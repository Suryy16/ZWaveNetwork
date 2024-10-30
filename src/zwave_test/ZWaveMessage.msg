packet ZWaveMessage {
    int sourceAddress;
    int destinationAddress;
    int messageType;  // COMMAND_CLASS
    int commandId;
    string payload;
}