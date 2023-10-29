// Auto-generated. Do not edit!

// (in-package project2fetch.msg)


"use strict";

const _serializer = _ros_msg_utils.Serialize;
const _arraySerializer = _serializer.Array;
const _deserializer = _ros_msg_utils.Deserialize;
const _arrayDeserializer = _deserializer.Array;
const _finder = _ros_msg_utils.Find;
const _getByteLength = _ros_msg_utils.getByteLength;

//-----------------------------------------------------------

class goalStatus {
  constructor(initObj={}) {
    if (initObj === null) {
      // initObj === null is a special case for deserialization where we don't initialize fields
      this.goal_reached = null;
    }
    else {
      if (initObj.hasOwnProperty('goal_reached')) {
        this.goal_reached = initObj.goal_reached
      }
      else {
        this.goal_reached = false;
      }
    }
  }

  static serialize(obj, buffer, bufferOffset) {
    // Serializes a message object of type goalStatus
    // Serialize message field [goal_reached]
    bufferOffset = _serializer.bool(obj.goal_reached, buffer, bufferOffset);
    return bufferOffset;
  }

  static deserialize(buffer, bufferOffset=[0]) {
    //deserializes a message object of type goalStatus
    let len;
    let data = new goalStatus(null);
    // Deserialize message field [goal_reached]
    data.goal_reached = _deserializer.bool(buffer, bufferOffset);
    return data;
  }

  static getMessageSize(object) {
    return 1;
  }

  static datatype() {
    // Returns string type for a message object
    return 'project2fetch/goalStatus';
  }

  static md5sum() {
    //Returns md5sum for a message object
    return 'a65bc774d2139031955fd7cc94fdd40f';
  }

  static messageDefinition() {
    // Returns full string definition for message
    return `
    bool goal_reached
    
    
    `;
  }

  static Resolve(msg) {
    // deep-construct a valid message object instance of whatever was passed in
    if (typeof msg !== 'object' || msg === null) {
      msg = {};
    }
    const resolved = new goalStatus(null);
    if (msg.goal_reached !== undefined) {
      resolved.goal_reached = msg.goal_reached;
    }
    else {
      resolved.goal_reached = false
    }

    return resolved;
    }
};

module.exports = goalStatus;
