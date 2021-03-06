EventEmitter = require '../core/events'
AudioDevice = require '../device'

BUFFER_SIZE = 4096

class VirtualDevice extends EventEmitter
    AudioDevice.register(VirtualDevice)
    
    @supported = not (typeof self is "undefined")

    constructor: (@sampleRate, @channels) ->

        @bufferSize = Math.ceil(BUFFER_SIZE / (self.deviceSampleRate / @sampleRate) * @channels)
        @bufferSize += @bufferSize % @channels

        setInterval =>
            @refill()
        , 50

    refill: =>

        data = new Float32Array @bufferSize
        @emit 'refill', data

        # data is now complete
        @emit 'refilled', data # if do-> return yes for d in data when data isnt 0

    destroy: ->
        @audioBuffers = []

    getDeviceTime: ->
        Date.now()
