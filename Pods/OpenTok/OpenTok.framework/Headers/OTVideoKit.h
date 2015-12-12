//
//  OTVideoKit.h
//
//  Copyright (c) 2014 TokBox, Inc. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreMedia/CMTime.h>

/**
 * Defines values for video orientations (up, down, left, right) for the
 * orieintation property of an <OTVideoFrame> object.
 */
typedef NS_ENUM(int32_t, OTVideoOrientation) {
    /** The video is oriented top up. No rotation is applies. */
    OTVideoOrientationUp = 1,
    /** The video is rotated 180 degrees. */
    OTVideoOrientationDown = 2,
   /** The video is rotated 90 degrees. */
    OTVideoOrientationLeft = 3,
   /** The video is rotated 270 degrees. */
    OTVideoOrientationRight = 4,
};

/**
 * Defines values for pixel format for the pixelFormat property of an
 * <OTVideoFrame> object.
 */
typedef NS_ENUM(int32_t, OTPixelFormat) {
    /** I420 format. */
    OTPixelFormatI420 = 'I420',
    /** ARGB format. */
    OTPixelFormatARGB = 'ARGB',
    /** NV12 format. */
    OTPixelFormatNV12 = 'NV12',
};

/**
 * Defines the video format assigned to an instance of an <OTVideoFrame> object.
 */
@interface OTVideoFormat : NSObject

/**
 * The name you assign to the video format
 */
@property(nonatomic, copy) NSString* name;
/**
 * The pixel format. Valid values are defined in the <OTPixelFormat> enum.
 */
@property(nonatomic, assign) OTPixelFormat pixelFormat;
/**
 * The number of bytes per row of the video.
 */
@property(nonatomic, retain) NSMutableArray* bytesPerRow;
/**
 * The width of the video, in pixels.
 */
@property(nonatomic, assign) uint32_t imageWidth;
/**
 * The height of the video, in pixels.
 */
@property(nonatomic, assign) uint32_t imageHeight;
/**
 * The estimated number of frames per second in the video.
 */
@property(nonatomic, assign) double estimatedFramesPerSecond;
/**
 * The estimated capture delay, in milliseconds, of the video.
 */
@property(nonatomic, assign) double estimatedCaptureDelay;

+ (OTVideoFormat*)videoFormatI420WithWidth:(uint32_t)width
                                   height:(uint32_t)height;

+ (OTVideoFormat*)videoFormatNV12WithWidth:(uint32_t)width
                                    height:(uint32_t)height;
@end

/**
 * Defines a frame of a video. See <[OTVideoRender renderVideoFrame:]> and
 * <[OTVideoCaptureConsumer consumeFrame:]>.
 */
@interface OTVideoFrame : NSObject

/** @name Properties of OTVideoFrame objects */

/**
 * An array of planes in the video frame.
 */
@property(nonatomic, retain) NSPointerArray* planes;
/**
 * A timestap of the video frame.
 */
@property(nonatomic, assign) CMTime timestamp;
/**
 * The orientation of the video frame.
 */
@property(nonatomic, assign) OTVideoOrientation orientation;
/**
 * The format of the video frame.
 */
@property(nonatomic, retain) OTVideoFormat* format;

/** @name Instantiating OTVideoFrame objects */

/**
 * Initializes an OTVideoFrame object.
 */
- (id)init;

/**
 * Initializes an OTVideoFrame object with a specified format.
 *
 * @param videoFormat The video format used by the video frame.
 */
- (id)initWithFormat:(OTVideoFormat*)videoFormat;
/**
 * Sets planes for the video frame.
 *
 * @param planes The planes to assign.
 * @param numPlanes The number of planes to assign.
 */
- (void)setPlanesWithPointers:(uint8_t*[])planes numPlanes:(int)numPlanes;
/**
 * Cleans the planes in the video frame.
 */
- (void)clearPlanes;
@end

/**
 * Defines a the consumer of an OTVideoCapture object.
 */
@protocol OTVideoCaptureConsumer <NSObject>

/**
 * Consumes a frame.
 *
 * @param frame The frame to consume.
 */
- (void)consumeFrame:(OTVideoFrame*)frame;

@end

/**
 * Defines a video capturer to be used by an <OTPublisherKit> object.
 * See the `videoCapture` property of an <OTPublisherKit> object.
 */
@protocol OTVideoCapture <NSObject>

/**
 * The <OTVideoCaptureConsumer> object that consumes frames for the video
 * capturer.
 */
@property(atomic, assign) id<OTVideoCaptureConsumer>videoCaptureConsumer;

/**
 * Initializes the video capturer.
 */
- (void)initCapture;
/**
 * Releases the video capturer.
 */
- (void)releaseCapture;
/**
 * Starts capturing video.
 */
- (int32_t)startCapture;
/**
 * Stops capturing video.
 */
- (int32_t)stopCapture;
/**
 * Whether video is being captured.
 */
- (BOOL)isCaptureStarted;
/**
 * The video format of the video capturer.
 * @param videoFormat The video format used.
 */
- (int32_t)captureSettings:(OTVideoFormat*)videoFormat;

@end


/**
 * Defines a video renderer to be used by an <OTPublisherKit> object or an
 * <OTSubscriberKit> object. See the `videoRender` properties of
 * <OTPublisherKit> object and <OTSubscriberKit>.
 */
@protocol OTVideoRender <NSObject>

/**
 * Renders a frame to the video renderer.
 *
 * @param frame The frame to render.
 */
- (void)renderVideoFrame:(OTVideoFrame*) frame;

@end
