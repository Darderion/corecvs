#ifndef OPENCV_CHECKER_BOARD_DETECTOR_PARAMETERS_H_
#define OPENCV_CHECKER_BOARD_DETECTOR_PARAMETERS_H_
/**
 * \file openCVCheckerBoardDetectorParameters.h
 * \attention This file is automatically generated and should not be in general modified manually
 *
 * \date MMM DD, 20YY
 * \author autoGenerator
 * Generated from opencv.xml
 */

#include "core/reflection/reflection.h"
#include "core/reflection/defaultSetter.h"
#include "core/reflection/printerVisitor.h"

/*
 *  Embed includes.
 */
/*
 *  Additional includes for Composite Types.
 */

// using namespace corecvs;

/*
 *  Additional includes for Pointer Types.
 */

// namespace corecvs {
// }
/*
 *  Additional includes for enum section.
 */

/**
 * \brief OpenCV Checker Board Detector Parameters 
 * OpenCV Checker Board Detector Parameters 
 **/
class OpenCVCheckerBoardDetectorParameters : public corecvs::BaseReflection<OpenCVCheckerBoardDetectorParameters>
{
public:
    enum FieldId {
        DEBUG_ID,
        HEIGHT_ID,
        WIDTH_ID,
        OPENCV_CHECKER_BOARD_DETECTOR_PARAMETERS_FIELD_ID_NUM
    };

    /** Section with variables */

    /** 
     * \brief debug 
     * debug 
     */
    bool mDebug;

    /** 
     * \brief height 
     * height 
     */
    int mHeight;

    /** 
     * \brief width 
     * width 
     */
    int mWidth;

    /** Static fields init function, this is used for "dynamic" field initialization */ 
    static int staticInit(corecvs::Reflection *toFill);

    static int relinkCompositeFields();

    /** Section with getters */
    const void *getPtrById(int fieldId) const
    {
        return (const unsigned char *)(this) + fields()[fieldId]->offset;
    }
    bool debug() const
    {
        return mDebug;
    }

    int height() const
    {
        return mHeight;
    }

    int width() const
    {
        return mWidth;
    }

    /** Section with setters */
    void setDebug(bool debug)
    {
        mDebug = debug;
    }

    void setHeight(int height)
    {
        mHeight = height;
    }

    void setWidth(int width)
    {
        mWidth = width;
    }

    /** Section with embedded classes */
    /* visitor pattern - http://en.wikipedia.org/wiki/Visitor_pattern */
template<class VisitorType>
    void accept(VisitorType &visitor)
    {
        visitor.visit(mDebug,                     static_cast<const corecvs::BoolField *>(fields()[DEBUG_ID]));
        visitor.visit(mHeight,                    static_cast<const corecvs::IntField *>(fields()[HEIGHT_ID]));
        visitor.visit(mWidth,                     static_cast<const corecvs::IntField *>(fields()[WIDTH_ID]));
    }

    OpenCVCheckerBoardDetectorParameters()
    {
        corecvs::DefaultSetter setter;
        accept(setter);
    }

    OpenCVCheckerBoardDetectorParameters(
          bool debug
        , int height
        , int width
    )
    {
        mDebug = debug;
        mHeight = height;
        mWidth = width;
    }

    /** Exact match comparator **/ 
    bool operator ==(const OpenCVCheckerBoardDetectorParameters &other) const 
    {
        if ( !(this->mDebug == other.mDebug)) return false;
        if ( !(this->mHeight == other.mHeight)) return false;
        if ( !(this->mWidth == other.mWidth)) return false;
        return true;
    }
    friend std::ostream& operator << (std::ostream &out, OpenCVCheckerBoardDetectorParameters &toSave)
    {
        corecvs::PrinterVisitor printer(out);
        toSave.accept<corecvs::PrinterVisitor>(printer);
        return out;
    }

    void print ()
    {
        std::cout << *this;
    }
};
#endif  //OPENCV_CHECKER_BOARD_DETECTOR_PARAMETERS_H_
