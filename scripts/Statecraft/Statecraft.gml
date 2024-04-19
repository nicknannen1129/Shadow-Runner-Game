// Copyright 2014-2021 by James Palmer.
//
// Licensed under the Apache License, Version 2.0 (the "License");
// you may not use this file except in compliance with the License.
// You may obtain a copy of the License at
//
//    http://www.apache.org/licenses/LICENSE-2.0
//
// Unless required by applicable law or agreed to in writing, software
// distributed under the License is distributed on an "AS IS" BASIS,
// WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
// See the License for the specific language governing permissions and
// limitations under the License.

// StatecraftGML is a state machine engine for Game Maker Studio 2.3+.
// State machines are composed of states and transitions between states.
// While Statecraft can implement finite-state machines (FSM), it can also
// be used to devise machines where transitions are added over time or have
// guarded transitions which exhibit more complicated behavior.

/// @function		m_create(initial_state)
/// @description	Create a new Machine with the specified initial state.
/// @param {string} initial_state	The start state for the machine.

function m_create(initial_state) {
	// The Machine object represents states, transitions and actions for a
	// single state machine.  The exported fields Src, Dst, and Evt are
	// only defined when an action is being executed and contain,
	// respectively, the source state, destination state, and event name.
	return {
		currentState : initial_state,
		initialState: initial_state,
		transitions : ds_map_create(), // string -> string
		actions : ds_map_create(), // string -> func
		pendingEvent : "",
		processingEvent : false,
		cancellable : false,
		cancel : false,
		Src : "",
		Dst : "",
		Evt : ""
	};
}

// Specifiers use a special prefix minilanguage to annotate how the
// function should be attached to a transition.  Specifically:
//
//   >myState  - Evaluate the action as the machine enters myState.
//   <myState  - Evaluate the action as the machine leaves myState.
//   >*        - Evaluate the action before entering any state.
//   <*        - Evaluate the action after leaving any state.
//   >>myEvent - Evaluate the action before myEvent.
//   <<myEvent - Evaluate the action after myEvent.
//   >>*       - Evaluate the action before responding to any event.
//   <<*       - Evaluate the action after responding to any event.
//   !myState  - Evaluate the action if the machine is in myState when
//               an event is not matched.
//   !!myEvent - Evaluate the action if myEvent is not matched.
//   !*        - Evaluate the action for all states where an event is not
//               matched.
//   !!!       - Evaluate the action if and only if the match failed
//               and no other error handling code would be evaluated.

/// @function		m_action(m, specifier, fn)
/// @description	Attach fn to the transition described in specifier.
/// @param {struct} m			The machine.
/// @param {string} specifier	The specifier for the transition.
/// @param {function} fn		The function attached to the transition.

function m_action(m, specifier, fn) {
	m.actions[? specifier] = fn;
}

/// @function		m_cancel(m)
/// @description	Attempts to cancel an executing event.  If successful the
///					function returns true and false otherwise.
/// @param {struct} m			The machine.

function m_cancel(m) {
	if !m.cancellable {
		return false
	}
	m.cancel = true
	return true
}

/// @function		m_send(m, event)
/// @description	Fire an event which may cause the machine to change state.
/// @param {struct} m			The machine.
/// @param {string} event		The event to broadcast.

function m_send(m, event) {

	if m.cancel {
		return;
	}

	if m.processingEvent {
		m.pendingEvent = event;
		return;
	}

	m.Src = m.currentState;
	m.Evt = event;
	var k = event+"_"+m.currentState;
	var nextState = m.transitions[? k];
	m.processingEvent = true;

	if !is_undefined(nextState) {
		
		m.Dst = nextState;
		m.cancellable = true;

		var f = m.actions[? ">>"+event];
		if !is_undefined(f) {
			f();
		}
		if m.cancel {
			m.reset();
			return;
		}
		f = m.actions[? ">>*"];
		if !is_undefined(f) {
			f();
		}
		if m.cancel {
			m.reset();
			return;
		}
		f = m.actions[? "<"+m.currentState];
		if !is_undefined(f) {
			f();
		}
		if m.cancel {
			m.reset();
			return;
		}
		f = m.actions[? "<*"];
		if !is_undefined(f) {
			f();
		}
		if m.cancel {
			m.reset();
			return;
		}

		m.currentState = nextState;
		m.cancellable = false;

		f = m.actions[? ">"+m.currentState];
		if !is_undefined(f) {
			f();
		}
		f = m.actions[? ">*"];
		if !is_undefined(f) {
			f();
		}
		f = m.actions[? "<<"+event];
		if !is_undefined(f) {
			f();
		}
		f = m.actions[? "<<*"];
		if !is_undefined(f) {
			f();
		}

		m.Dst = "";
	} else {
		var cnt = 0;
		f = m.actions[? "!!"+event];
		if !is_undefined(f) {
			f()
			cnt += 1
		}
		f = m.actions[? "!"+m.currentState];
		if !is_undefined(f) {
			f();
			cnt += 1;
		}
		f = m.actions[? "!*"];
		if !is_undefined(f) {
			f();
			cnt += 1;
		}
		if cnt == 0 {
			f = m.actions[? "!!!"]
			if !is_undefined(f) {
				f();
			}
		}
	}
	m.Src = "";
	m.Evt = "";

	m.processingEvent = false

	if m.pendingEvent != "" {
		var e = m.pendingEvent;
		m.pendingEvent = "";
		m.Send(e);
	}

}

/// @function		m_rule(m, event, src, dst)
/// @description	Add a transition connecting an event (i.e., an arc or 
///                 transition) between a pair of src and dst states.
/// @param {struct} m			The machine.
/// @param {string} event		The event that connects the src and dst states.
/// @param {string} src			The source state.
/// @param {string} dst			The destination state.

function m_rule(m, event, src, dst) {
	m.transitions[? event+"_"+src] = dst;
}

/// @function		m_is_state(m, state)
/// @description	Returns true if state is the current state.
/// @param {struct} m			The machine.
/// @param {string} state		The state to lookup.

function m_is_state(m, state) {
	if m.currentState == state {
		return true
	}
	return false
}

/// @function		m_is_event(m, event)
/// @description	Returns true if event is a valid event from the current state.
/// @param {struct} m			The machine.
/// @param {string} event		The event to lookup.

function m_is_event(event) {
	var dst = m.transitions[event+"_"+m.currentState];
	if !is_undefined(dst) {
		return true;
	}
	return false;
}

/// @function		m_reset(m)
/// @description	Resets the machine to the starting state.
/// @param {struct} m			The machine.

function m_reset(m) {
	m.processingEvent = false;
	m.cancellable = false;
	m.cancel = false;
	m.pendingEvent = "";
	m.Src = "";
	m.Dst = "";
	m.Evt = "";
	m.currentState = m.initialState;
}

// State Machine Example
/*
m = m_create("locked");

m_rule(m, "push", "unlocked", "locked");
m_rule(m, "coin", "locked", "unlocked");

m_action(m, ">unlocked", function() {
	show_debug_message("UNLOCKED!");
});

m_send(m, "coin");
*/