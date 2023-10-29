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

class gripperStatus {
  constructor(initObj={}) {
    if (initObj === null) {
      // initObj === null is a special case for deserialization where we don't initialize fields
      this.gripper_closed = null;
    }
    else {
      if (initObj.hasOwnProperty('gripper_closed')) {
        this.gripper_closed = initObj.gripper_closed
      }
      else {
        this.gripper_closed = false;
      }
    }
  }

  static serialize(obj, buffer, bufferOffset) {
    // Serializes a message object of type gripperStatus
    // Serialize message field [gripper_closed]
    bufferOffset = _serializer.bool(obj.gripper_closed, buffer, bufferOffset);
    return bufferOffset;
  }

  static deserialize(buffer, bufferOffset=[0]) {
    //deserializes a message object of type gripperStatus
    let len;
    let data = new gripperStatus(null);
    // Deserialize message field [gripper_closed]
    data.gripper_closed = _deserializer.bool(buffer, bufferOffset);
    return data;
  }

  static getMessageSize(object) {
    return 1;
  }

  static datatype() {
    // Returns string type for a message object
    return 'project2fetch/gripperStatus';
  }

  static md5sum() {
    //Returns md5sum for a message object
    return '0bb9f49e5ee44b74c38bc58a62045bee';
  }

  static messageDefinition() {
    // Returns full string definition for message
    return `
    bool gripper_closed
    
    
    `;
  }

  static Resolve(msg) {
    // deep-construct a valid message object instance of whatever was passed in
    if (typeof msg !== 'object' || msg === null) {
      msg = {};
    }
    const resolved = new gripperStatus(null);
    if (msg.gripper_closed !== undefined) {
      resolved.gripper_closed = msg.gripper_closed;
    }
    else {
      resolved.gripper_closed = false
    }

    return resolved;
    }
};

module.exports = gripperStatus;
