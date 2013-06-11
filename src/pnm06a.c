#include "erfam.h"

void eraPnm06a(double date1, double date2, double rnpb[3][3])
/*
**  - - - - - - - - - -
**   e r a P n m 0 6 a
**  - - - - - - - - - -
**
**  Form the matrix of precession-nutation for a given date (including
**  frame bias), IAU 2006 precession and IAU 2000A nutation models.
**
**  Given:
**     date1,date2 double       TT as a 2-part Julian Date (Note 1)
**
**  Returned:
**     rnpb        double[3][3] bias-precession-nutation matrix (Note 2)
**
**  Notes:
**
**  1) The TT date date1+date2 is a Julian Date, apportioned in any
**     convenient way between the two arguments.  For example,
**     JD(TT)=2450123.7 could be expressed in any of these ways,
**     among others:
**
**            date1          date2
**
**         2450123.7           0.0       (JD method)
**         2451545.0       -1421.3       (J2000 method)
**         2400000.5       50123.2       (MJD method)
**         2450123.5           0.2       (date & time method)
**
**     The JD method is the most natural and convenient to use in
**     cases where the loss of several decimal digits of resolution
**     is acceptable.  The J2000 method is best matched to the way
**     the argument is handled internally and will deliver the
**     optimum resolution.  The MJD method and the date & time methods
**     are both good compromises between resolution and convenience.
**
**  2) The matrix operates in the sense V(date) = rnpb * V(GCRS), where
**     the p-vector V(date) is with respect to the true equatorial triad
**     of date date1+date2 and the p-vector V(GCRS) is with respect to
**     the Geocentric Celestial Reference System (IAU, 2000).
**
**  Called:
**     eraPfw06     bias-precession F-W angles, IAU 2006
**     eraNut06a    nutation, IAU 2006/2000A
**     eraFw2m      F-W angles to r-matrix
**
**  Reference:
**
**     Capitaine, N. & Wallace, P.T., 2006, Astron.Astrophys. 450, 855.
**
**  Copyright (C) 2013, NumFOCUS Foundation.
**  Derived, with permission, from the SOFA library.  See notes at end of file.
*/
{
   double gamb, phib, psib, epsa, dp, de;


/* Fukushima-Williams angles for frame bias and precession. */
   eraPfw06(date1, date2, &gamb, &phib, &psib, &epsa);

/* Nutation components. */
   eraNut06a(date1, date2, &dp, &de);

/* Equinox based nutation x precession x bias matrix. */
   eraFw2m(gamb, phib, psib + dp, epsa + de, rnpb);

   return;

}
/*----------------------------------------------------------------------
**  
**  
**  Copyright (C) 2013, NumFOCUS Foundation.
**  All rights reserved.
**  
**  This library is derived, with permission, from the International
**  Astronomical Union's "Standards of Fundamental Astronomy" library,
**  available from http://www.iausofa.org.
**  
**  The ERFA version is intended to retain identical
**  functionality to the SOFA library,  but made distinct through
**  different function and file names, as set out in the SOFA license
**  conditions. The SOFA original has a role as a reference standard
**  for the IAU and IERS, and consequently redistribution is permitted only
**  in its unaltered state.  The ERFA version is not subject to this
**  restriction and therefore can be included in distributions which do not
**  support the concept of "read only" software.
**  
**  Although the intent is to replicate the SOFA API (other than replacement of
**  prefix names) and results (with the exception of bugs; any that are
**  discovered will be fixed), SOFA is not responsible for any errors found
**  in this version of the library.
**  
**  If you wish to acknowledge the SOFA heritage, please acknowledge that
**  you are using a library derived from SOFA, rather than SOFA itself.
**  
**  
**  TERMS AND CONDITIONS
**  
**  Redistribution and use in source and binary forms, with or without
**  modification, are permitted provided that the following conditions are met:
**  
**  1 Redistributions of source code must retain the above copyright
**     notice, this list of conditions and the following disclaimer.
**  
**  2 Redistributions in binary form must reproduce the above copyright
**     notice, this list of conditions and the following disclaimer in the
**     documentation and/or other materials provided with the distribution.
**  
**  3 Neither the name of the Standards Of Fundamental Astronomy Board, the
**     International Astronomical Union nor the names of its contributors
**     may be used to endorse or promote products derived from this software
**     without specific prior written permission.
**  
**  THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS
**  IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED
**  TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A
**  PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT
**  HOLDER OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL,
**  SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED
**  TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR
**  PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF
**  LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING
**  NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS
**  SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
**  
*/
