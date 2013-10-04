#include <inttypes.h>
#include <caml/mlvalues.h>
#include "ppm.h"

uint16_t ppm_pulses[ PPM_NB_PULSES ];
volatile bool_t ppm_valid;


value update_rc_channel(value c, value v) {
  ppm_pulses[Int_val(c)] = Double_val(v);
  return Val_unit;
}

value send_ppm(value unit) {
  ppm_valid = TRUE;
  return unit;
}
