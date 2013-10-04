ap.srcs += main_ap.c sys_time.c main.c inter_mcu.c link_mcu.c gps_ubx.c gps.c infrared.c  fw_h_ctl.c fw_v_ctl.c nav.c estimator.c cam.c spi.c
ap.CFLAGS += -DMCU_SPI_LINK -DGPS -DUBX -DINFRARED -DRADIO_CONTROL -DINTER_MCU -DSPI_MASTER -DUSE_SPI -DNAV


fbw.srcs +=  sys_time.c main_fbw.c main.c commands.c inter_mcu.c spi.c link_mcu.c radio_control.c
fbw.CFLAGS += -DINTER_MCU -DMCU_SPI_LINK -DSPI_SLAVE -DUSE_SPI -DRADIO_CONTROL -DRADIO_CONTROL_TYPE=RC_FUTABA

#---SERIAL---
fbw.CFLAGS += -DDOWNLINK_TRANSPORT=PprzTransport  -DDOWNLINK -DDOWNLINK_FBW_DEVICE=Uart0 
fbw.CFLAGS += -DUSE_UART0 -DUART0_BAUD=B38400 
fbw.srcs +=  downlink.c pprz_transport.c

