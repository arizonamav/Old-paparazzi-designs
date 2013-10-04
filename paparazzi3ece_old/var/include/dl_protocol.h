/* Automatically generated from /home/mav/Desktop/paparazzivn100/conf/messages.xml */
/* Please DO NOT EDIT */
/* Macros to send and receive messages of class datalink */
#define DL_ACINFO 1
#define DL_MOVE_WP 2
#define DL_WIND_INFO 3
#define DL_SETTING 4
#define DL_BLOCK 5
#define DL_HITL_UBX 6
#define DL_HITL_INFRARED 7
#define DL_TELEMETRY_MODE 8
#define DL_SET_ACTUATOR 100
#define DL_MSG_datalink_NB 9

#define MSG_datalink_LENGTHS {0,(2+0+2+4+4+4+4+2+2+1),(2+0+1+1+4+4+4),(2+0+2+4+4),(2+0+1+1+4),(2+0+1),(2+0+1+1+1+nb_ubx_payload*1),(2+0+2+2),(2+0+1),0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,(2+0+2+1),}

#define DOWNLINK_SEND_ACINFO(course, utm_east, utm_north, alt, itow, speed, climb, ac_id){ \
	if (DownlinkCheckFreeSpace(DownlinkSizeOf(0+2+4+4+4+4+2+2+1))) {\
	  DownlinkStartMessage("ACINFO", DL_ACINFO, 0+2+4+4+4+4+2+2+1) \
	  DownlinkPutInt16ByAddr((course)); \
	  DownlinkPutInt32ByAddr((utm_east)); \
	  DownlinkPutInt32ByAddr((utm_north)); \
	  DownlinkPutInt32ByAddr((alt)); \
	  DownlinkPutUint32ByAddr((itow)); \
	  DownlinkPutUint16ByAddr((speed)); \
	  DownlinkPutInt16ByAddr((climb)); \
	  DownlinkPutUint8ByAddr((ac_id)); \
	  DownlinkEndMessage() \
	} else \
	  DonwlinkOverrun(); \
}

#define DOWNLINK_SEND_MOVE_WP(wp_id, pad0, utm_east, utm_north, alt){ \
	if (DownlinkCheckFreeSpace(DownlinkSizeOf(0+1+1+4+4+4))) {\
	  DownlinkStartMessage("MOVE_WP", DL_MOVE_WP, 0+1+1+4+4+4) \
	  DownlinkPutUint8ByAddr((wp_id)); \
	  DownlinkPutUint8ByAddr((pad0)); \
	  DownlinkPutInt32ByAddr((utm_east)); \
	  DownlinkPutInt32ByAddr((utm_north)); \
	  DownlinkPutInt32ByAddr((alt)); \
	  DownlinkEndMessage() \
	} else \
	  DonwlinkOverrun(); \
}

#define DOWNLINK_SEND_WIND_INFO(pad0, east, north){ \
	if (DownlinkCheckFreeSpace(DownlinkSizeOf(0+2+4+4))) {\
	  DownlinkStartMessage("WIND_INFO", DL_WIND_INFO, 0+2+4+4) \
	  DownlinkPutUint16ByAddr((pad0)); \
	  DownlinkPutFloatByAddr((east)); \
	  DownlinkPutFloatByAddr((north)); \
	  DownlinkEndMessage() \
	} else \
	  DonwlinkOverrun(); \
}

#define DOWNLINK_SEND_SETTING(index, pad0, value){ \
	if (DownlinkCheckFreeSpace(DownlinkSizeOf(0+1+1+4))) {\
	  DownlinkStartMessage("SETTING", DL_SETTING, 0+1+1+4) \
	  DownlinkPutUint8ByAddr((index)); \
	  DownlinkPutUint8ByAddr((pad0)); \
	  DownlinkPutFloatByAddr((value)); \
	  DownlinkEndMessage() \
	} else \
	  DonwlinkOverrun(); \
}

#define DOWNLINK_SEND_BLOCK(block_id){ \
	if (DownlinkCheckFreeSpace(DownlinkSizeOf(0+1))) {\
	  DownlinkStartMessage("BLOCK", DL_BLOCK, 0+1) \
	  DownlinkPutUint8ByAddr((block_id)); \
	  DownlinkEndMessage() \
	} else \
	  DonwlinkOverrun(); \
}

#define DOWNLINK_SEND_HITL_UBX(class, id, nb_ubx_payload, ubx_payload){ \
	if (DownlinkCheckFreeSpace(DownlinkSizeOf(0+1+1+1+nb_ubx_payload*1))) {\
	  DownlinkStartMessage("HITL_UBX", DL_HITL_UBX, 0+1+1+1+nb_ubx_payload*1) \
	  DownlinkPutUint8ByAddr((class)); \
	  DownlinkPutUint8ByAddr((id)); \
	  DownlinkPutUint8Array(nb_ubx_payload, ubx_payload); \
	  DownlinkEndMessage() \
	} else \
	  DonwlinkOverrun(); \
}

#define DOWNLINK_SEND_HITL_INFRARED(roll, pitch){ \
	if (DownlinkCheckFreeSpace(DownlinkSizeOf(0+2+2))) {\
	  DownlinkStartMessage("HITL_INFRARED", DL_HITL_INFRARED, 0+2+2) \
	  DownlinkPutInt16ByAddr((roll)); \
	  DownlinkPutInt16ByAddr((pitch)); \
	  DownlinkEndMessage() \
	} else \
	  DonwlinkOverrun(); \
}

#define DOWNLINK_SEND_TELEMETRY_MODE(mode){ \
	if (DownlinkCheckFreeSpace(DownlinkSizeOf(0+1))) {\
	  DownlinkStartMessage("TELEMETRY_MODE", DL_TELEMETRY_MODE, 0+1) \
	  DownlinkPutUint8ByAddr((mode)); \
	  DownlinkEndMessage() \
	} else \
	  DonwlinkOverrun(); \
}

#define DOWNLINK_SEND_SET_ACTUATOR(value, no){ \
	if (DownlinkCheckFreeSpace(DownlinkSizeOf(0+2+1))) {\
	  DownlinkStartMessage("SET_ACTUATOR", DL_SET_ACTUATOR, 0+2+1) \
	  DownlinkPutUint16ByAddr((value)); \
	  DownlinkPutUint8ByAddr((no)); \
	  DownlinkEndMessage() \
	} else \
	  DonwlinkOverrun(); \
}

#define MESSAGES_MD5SUM "\156\054\322\261\004\165\012\226\302\337\367\012\204\262\150\222"

#define DL_ACINFO_course(_payload) (*(int16_t*)(_payload+2))
#define DL_ACINFO_utm_east(_payload) (*(int32_t*)(_payload+4))
#define DL_ACINFO_utm_north(_payload) (*(int32_t*)(_payload+8))
#define DL_ACINFO_alt(_payload) (*(int32_t*)(_payload+12))
#define DL_ACINFO_itow(_payload) (*(uint32_t*)(_payload+16))
#define DL_ACINFO_speed(_payload) (*(uint16_t*)(_payload+20))
#define DL_ACINFO_climb(_payload) (*(int16_t*)(_payload+22))
#define DL_ACINFO_ac_id(_payload) (*(uint8_t*)(_payload+24))

#define DL_MOVE_WP_wp_id(_payload) (*(uint8_t*)(_payload+2))
#define DL_MOVE_WP_pad0(_payload) (*(uint8_t*)(_payload+3))
#define DL_MOVE_WP_utm_east(_payload) (*(int32_t*)(_payload+4))
#define DL_MOVE_WP_utm_north(_payload) (*(int32_t*)(_payload+8))
#define DL_MOVE_WP_alt(_payload) (*(int32_t*)(_payload+12))

#define DL_WIND_INFO_pad0(_payload) (*(uint16_t*)(_payload+2))
#define DL_WIND_INFO_east(_payload) (*(float*)(_payload+4))
#define DL_WIND_INFO_north(_payload) (*(float*)(_payload+8))

#define DL_SETTING_index(_payload) (*(uint8_t*)(_payload+2))
#define DL_SETTING_pad0(_payload) (*(uint8_t*)(_payload+3))
#define DL_SETTING_value(_payload) (*(float*)(_payload+4))

#define DL_BLOCK_block_id(_payload) (*(uint8_t*)(_payload+2))

#define DL_HITL_UBX_class(_payload) (*(uint8_t*)(_payload+2))
#define DL_HITL_UBX_id(_payload) (*(uint8_t*)(_payload+3))
#define DL_HITL_UBX_ubx_payload_length(_payload) (*(uint8_t*)(_payload+4))
#define DL_HITL_UBX_ubx_payload(_payload) (uint8_t*)(_payload+5)

#define DL_HITL_INFRARED_roll(_payload) (*(int16_t*)(_payload+2))
#define DL_HITL_INFRARED_pitch(_payload) (*(int16_t*)(_payload+4))

#define DL_TELEMETRY_MODE_mode(_payload) (*(uint8_t*)(_payload+2))

#define DL_SET_ACTUATOR_value(_payload) (*(uint16_t*)(_payload+2))
#define DL_SET_ACTUATOR_no(_payload) (*(uint8_t*)(_payload+4))
