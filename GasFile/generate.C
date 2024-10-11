#include <iostream>

#include "Garfield/MediumMagboltz.hh"
#include "Garfield/FundamentalConstants.hh"

using namespace Garfield;

int main(int argc, char * argv[]) {

  const double pressure = 7.5 * AtmosphericPressure;
  const double temperature = 293.15;

  // Setup the gas.
  MediumMagboltz gas("Ar", 100.); // gas("Ar", 93., "CO2", 7.);
  gas.SetTemperature(temperature);
  gas.SetPressure(pressure);

  // Set the field range to be covered by the gas table.
  // [By default E ranges from 100 V/cm to 100000 V/cm in 20 logarithmically spaced steps.]
  const size_t nE = 20;
  const double emin =    100.;
  const double emax = 8000.;
  // Flag to request logarithmic spacing.
  constexpr bool useLog = true;
  gas.SetFieldGrid(emin, emax, nE, useLog);


  const int ncoll = 10; // number of collisions, in multiples of 10^7
  // Run Magboltz to generate the gas table.
  gas.GenerateGasTable(ncoll);
  // Save the table.
  gas.WriteGasFile("/Users/llarizgoitialive/Library/CloudStorage/OneDrive-Personal/GanESS/GarfieldCode/GarfieldGap/GasFile/ar_7.5bar.gas"); //("ar_93_co2_7.gas");

}
