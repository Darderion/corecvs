/**
 * \file openCVCheckerBoardDetectorParameters.cpp
 * \attention This file is automatically generated and should not be in general modified manually
 *
 * \date MMM DD, 20YY
 * \author autoGenerator
 * Generated from opencv.xml
 */

#include <vector>
#include <stddef.h>
#include "openCVCheckerBoardDetectorParameters.h"

/**
 *  Looks extremely unsafe because it depends on the order of static initialization.
 *  Should check standard if this is ok
 *
 *  Also it's not clear why removing "= Reflection()" breaks the code;
 **/

namespace corecvs {
#if 0
template<>
Reflection BaseReflection<OpenCVCheckerBoardDetectorParameters>::reflection = Reflection();
template<>
int BaseReflection<OpenCVCheckerBoardDetectorParameters>::dummy = OpenCVCheckerBoardDetectorParameters::staticInit();
#endif
} // namespace corecvs 

SUPPRESS_OFFSET_WARNING_BEGIN


using namespace corecvs;

int OpenCVCheckerBoardDetectorParameters::staticInit(corecvs::Reflection *toFill)
{
    if (toFill == NULL || toFill->objectSize != 0) {
        SYNC_PRINT(("staticInit(): Contract Violation in <OpenCVCheckerBoardDetectorParameters>\n"));
         return -1;
    }

    toFill->name = ReflectionNaming(
        "OpenCV Checker Board Detector Parameters",
        "OpenCV Checker Board Detector Parameters",
        ""
    );

     toFill->objectSize = sizeof(OpenCVCheckerBoardDetectorParameters);
     

    BoolField* field0 = new BoolField
        (
          OpenCVCheckerBoardDetectorParameters::DEBUG_ID,
          offsetof(OpenCVCheckerBoardDetectorParameters, mDebug),
          false,
          "debug",
          "debug",
          "debug"
        );
    field0->widgetHint=BaseField::CHECK_BOX;
    toFill->fields.push_back(field0);
    /*  */ 
    IntField* field1 = new IntField
        (
          OpenCVCheckerBoardDetectorParameters::HEIGHT_ID,
          offsetof(OpenCVCheckerBoardDetectorParameters, mHeight),
          4,
          "height",
          "height",
          "height"
        );
    toFill->fields.push_back(field1);
    /*  */ 
    IntField* field2 = new IntField
        (
          OpenCVCheckerBoardDetectorParameters::WIDTH_ID,
          offsetof(OpenCVCheckerBoardDetectorParameters, mWidth),
          5,
          "width",
          "width",
          "width"
        );
    toFill->fields.push_back(field2);
    /*  */ 
    ReflectionDirectory &directory = *ReflectionDirectoryHolder::getReflectionDirectory();
    directory[std::string("OpenCV Checker Board Detector Parameters")]= toFill;
   return 0;
}
int OpenCVCheckerBoardDetectorParameters::relinkCompositeFields()
{
   return 0;
}

SUPPRESS_OFFSET_WARNING_END


