// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'local_database.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class WeatherLocalDatabaseAdapter extends TypeAdapter<WeatherLocalDatabase> {
  @override
  final int typeId = 0;

  @override
  WeatherLocalDatabase read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return WeatherLocalDatabase(
      id: fields[3] as int?,
      main: fields[0] as String?,
      description: fields[1] as String?,
      icon: fields[2] as String?,
      temp: fields[4] as double?,
      clouds: fields[7] as int?,
      pressure: fields[5] as int?,
      humidity: fields[6] as int?,
      speed: fields[8] as double?,
      country: fields[9] as String?,
      name: fields[10] as String?,
    );
  }

  @override
  void write(BinaryWriter writer, WeatherLocalDatabase obj) {
    writer
      ..writeByte(11)
      ..writeByte(0)
      ..write(obj.main)
      ..writeByte(1)
      ..write(obj.description)
      ..writeByte(2)
      ..write(obj.icon)
      ..writeByte(3)
      ..write(obj.id)
      ..writeByte(4)
      ..write(obj.temp)
      ..writeByte(5)
      ..write(obj.pressure)
      ..writeByte(6)
      ..write(obj.humidity)
      ..writeByte(7)
      ..write(obj.clouds)
      ..writeByte(8)
      ..write(obj.speed)
      ..writeByte(9)
      ..write(obj.country)
      ..writeByte(10)
      ..write(obj.name);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is WeatherLocalDatabaseAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
