#ifndef ERFAHDEF
#define ERFAHDEF

/*
**  - - - - - - -
**   e r f a . h
**  - - - - - - -
**
**  Prototype function declarations for ERFA library.
**
**  Copyright (C) 2013-2023, NumFOCUS Foundation.
**  Derived, with permission, from the SOFA library.  See notes at end of file.
*/

#include "math.h"

#ifdef __cplusplus
extern "C" {
#endif

/* Star-independent astrometry parameters */
typedef struct {
   double pmt;        /* PM time interval (SSB, Julian years) */
   double eb[3];      /* SSB to observer (vector, au) */
   double eh[3];      /* Sun to observer (unit vector) */
   double em;         /* distance from Sun to observer (au) */
   double v[3];       /* barycentric observer velocity (vector, c) */
   double bm1;        /* sqrt(1-|v|^2): reciprocal of Lorenz factor */
   double bpn[3][3];  /* bias-precession-nutation matrix */
   double along;      /* longitude + s' + dERA(DUT) (radians) */
   double phi;        /* geodetic latitude (radians) */
   double xpl;        /* polar motion xp wrt local meridian (radians) */
   double ypl;        /* polar motion yp wrt local meridian (radians) */
   double sphi;       /* sine of geodetic latitude */
   double cphi;       /* cosine of geodetic latitude */
   double diurab;     /* magnitude of diurnal aberration vector */
   double eral;       /* "local" Earth rotation angle (radians) */
   double refa;       /* refraction constant A (radians) */
   double refb;       /* refraction constant B (radians) */
} eraASTROM;
/* (Vectors eb, eh, em and v are all with respect to BCRS axes.) */

/* Body parameters for light deflection */
typedef struct {
   double bm;         /* mass of the body (solar masses) */
   double dl;         /* deflection limiter (radians^2/2) */
   double pv[2][3];   /* barycentric PV of the body (au, au/day) */
} eraLDBODY;

/* Astronomy/Calendars */
__device__ int eraCal2jd(int iy, int im, int id, double *djm0, double *djm);
__device__ double eraEpb(double dj1, double dj2);
__device__ void eraEpb2jd(double epb, double *djm0, double *djm);
__device__ double eraEpj(double dj1, double dj2);
__device__ void eraEpj2jd(double epj, double *djm0, double *djm);
__device__ int eraJd2cal(double dj1, double dj2,
                     int *iy, int *im, int *id, double *fd);
__device__ int eraJdcalf(int ndp, double dj1, double dj2, int iymdf[4]);

/* Astronomy/Astrometry */
__device__ void eraAb(double pnat[3], double v[3], double s, double bm1,
           double ppr[3]);
__device__ void eraApcg(double date1, double date2,
             double ebpv[2][3], double ehp[3],
             eraASTROM *astrom);
__device__ void eraApcg13(double date1, double date2, eraASTROM *astrom);
__device__ void eraApci(double date1, double date2,
             double ebpv[2][3], double ehp[3],
             double x, double y, double s,
             eraASTROM *astrom);
__device__ void eraApci13(double date1, double date2,
               eraASTROM *astrom, double *eo);
__device__ void eraApco(double date1, double date2,
             double ebpv[2][3], double ehp[3],
             double x, double y, double s, double theta,
             double elong, double phi, double hm,
             double xp, double yp, double sp,
             double refa, double refb,
             eraASTROM *astrom);
__device__ int eraApco13(double utc1, double utc2, double dut1,
              double elong, double phi, double hm, double xp, double yp,
              double phpa, double tc, double rh, double wl,
              eraASTROM *astrom, double *eo);
__device__ void eraApcs(double date1, double date2, double pv[2][3],
             double ebpv[2][3], double ehp[3],
             eraASTROM *astrom);
__device__ void eraApcs13(double date1, double date2, double pv[2][3],
               eraASTROM *astrom);
__device__ void eraAper(double theta, eraASTROM *astrom);
__device__ void eraAper13(double ut11, double ut12, eraASTROM *astrom);
__device__ void eraApio(double sp, double theta,
             double elong, double phi, double hm, double xp, double yp,
             double refa, double refb,
             eraASTROM *astrom);
__device__ int eraApio13(double utc1, double utc2, double dut1,
              double elong, double phi, double hm, double xp, double yp,
              double phpa, double tc, double rh, double wl,
              eraASTROM *astrom);
__device__ void eraAtcc13(double rc, double dc,
               double pr, double pd, double px, double rv,
               double date1, double date2,
               double *ra, double *da);
__device__ void eraAtccq(double rc, double dc,
              double pr, double pd, double px, double rv,
              eraASTROM *astrom, double *ra, double *da);
__device__ void eraAtci13(double rc, double dc,
               double pr, double pd, double px, double rv,
               double date1, double date2,
               double *ri, double *di, double *eo);
__device__ void eraAtciq(double rc, double dc, double pr, double pd,
              double px, double rv, eraASTROM *astrom,
              double *ri, double *di);
__device__ void eraAtciqn(double rc, double dc, double pr, double pd,
               double px, double rv, eraASTROM *astrom,
               int n, eraLDBODY b[], double *ri, double *di);
__device__ void eraAtciqz(double rc, double dc, eraASTROM *astrom,
               double *ri, double *di);
__device__ int eraAtco13(double rc, double dc,
              double pr, double pd, double px, double rv,
              double utc1, double utc2, double dut1,
              double elong, double phi, double hm, double xp, double yp,
              double phpa, double tc, double rh, double wl,
              double *aob, double *zob, double *hob,
              double *dob, double *rob, double *eo);
__device__ void eraAtic13(double ri, double di,
               double date1, double date2,
               double *rc, double *dc, double *eo);
__device__ void eraAticq(double ri, double di, eraASTROM *astrom,
              double *rc, double *dc);
__device__ void eraAticqn(double ri, double di, eraASTROM *astrom,
               int n, eraLDBODY b[], double *rc, double *dc);
__device__ int eraAtio13(double ri, double di,
              double utc1, double utc2, double dut1,
              double elong, double phi, double hm, double xp, double yp,
              double phpa, double tc, double rh, double wl,
              double *aob, double *zob, double *hob,
              double *dob, double *rob);
__device__ void eraAtioq(double ri, double di, eraASTROM *astrom,
              double *aob, double *zob,
              double *hob, double *dob, double *rob);
__device__ int eraAtoc13(const char *type, double ob1, double ob2,
              double utc1, double utc2, double dut1,
              double elong, double phi, double hm, double xp, double yp,
              double phpa, double tc, double rh, double wl,
              double *rc, double *dc);
__device__ int eraAtoi13(const char *type, double ob1, double ob2,
              double utc1, double utc2, double dut1,
              double elong, double phi, double hm, double xp, double yp,
              double phpa, double tc, double rh, double wl,
              double *ri, double *di);
__device__ void eraAtoiq(const char *type,
              double ob1, double ob2, eraASTROM *astrom,
              double *ri, double *di);
__device__ void eraLd(double bm, double p[3], double q[3], double e[3],
           double em, double dlim, double p1[3]);
__device__ void eraLdn(int n, eraLDBODY b[], double ob[3], double sc[3],
            double sn[3]);
__device__ void eraLdsun(double p[3], double e[3], double em, double p1[3]);
__device__ void eraPmpx(double rc, double dc, double pr, double pd,
             double px, double rv, double pmt, double pob[3],
             double pco[3]);
__device__ int eraPmsafe(double ra1, double dec1, double pmr1, double pmd1,
              double px1, double rv1,
              double ep1a, double ep1b, double ep2a, double ep2b,
              double *ra2, double *dec2, double *pmr2, double *pmd2,
              double *px2, double *rv2);
__device__ void eraPvtob(double elong, double phi, double height, double xp,
              double yp, double sp, double theta, double pv[2][3]);
__device__ void eraRefco(double phpa, double tc, double rh, double wl,
              double *refa, double *refb);

/* Astronomy/Ephemerides */
__device__ int eraEpv00(double date1, double date2,
             double pvh[2][3], double pvb[2][3]);
__device__ void eraMoon98(double date1, double date2, double pv[2][3]);
__device__ int eraPlan94(double date1, double date2, int np, double pv[2][3]);

/* Astronomy/FundamentalArgs */
__device__ double eraFad03(double t);
__device__ double eraFae03(double t);
__device__ double eraFaf03(double t);
__device__ double eraFaju03(double t);
__device__ double eraFal03(double t);
__device__ double eraFalp03(double t);
__device__ double eraFama03(double t);
__device__ double eraFame03(double t);
__device__ double eraFane03(double t);
__device__ double eraFaom03(double t);
__device__ double eraFapa03(double t);
__device__ double eraFasa03(double t);
__device__ double eraFaur03(double t);
__device__ double eraFave03(double t);

/* Astronomy/PrecNutPolar */
__device__ void eraBi00(double *dpsibi, double *depsbi, double *dra);
__device__ void eraBp00(double date1, double date2,
             double rb[3][3], double rp[3][3], double rbp[3][3]);
__device__ void eraBp06(double date1, double date2,
             double rb[3][3], double rp[3][3], double rbp[3][3]);
__device__ void eraBpn2xy(double rbpn[3][3], double *x, double *y);
__device__ void eraC2i00a(double date1, double date2, double rc2i[3][3]);
__device__ void eraC2i00b(double date1, double date2, double rc2i[3][3]);
__device__ void eraC2i06a(double date1, double date2, double rc2i[3][3]);
__device__ void eraC2ibpn(double date1, double date2, double rbpn[3][3],
               double rc2i[3][3]);
__device__ void eraC2ixy(double date1, double date2, double x, double y,
              double rc2i[3][3]);
__device__ void eraC2ixys(double x, double y, double s, double rc2i[3][3]);
__device__ void eraC2t00a(double tta, double ttb, double uta, double utb,
               double xp, double yp, double rc2t[3][3]);
__device__ void eraC2t00b(double tta, double ttb, double uta, double utb,
               double xp, double yp, double rc2t[3][3]);
__device__ void eraC2t06a(double tta, double ttb, double uta, double utb,
               double xp, double yp, double rc2t[3][3]);
__device__ void eraC2tcio(double rc2i[3][3], double era, double rpom[3][3],
               double rc2t[3][3]);
__device__ void eraC2teqx(double rbpn[3][3], double gst, double rpom[3][3],
               double rc2t[3][3]);
__device__ void eraC2tpe(double tta, double ttb, double uta, double utb,
              double dpsi, double deps, double xp, double yp,
              double rc2t[3][3]);
__device__ void eraC2txy(double tta, double ttb, double uta, double utb,
              double x, double y, double xp, double yp,
              double rc2t[3][3]);
__device__ double eraEo06a(double date1, double date2);
__device__ double eraEors(double rnpb[3][3], double s);
__device__ void eraFw2m(double gamb, double phib, double psi, double eps,
             double r[3][3]);
__device__ void eraFw2xy(double gamb, double phib, double psi, double eps,
              double *x, double *y);
__device__ void eraLtp(double epj, double rp[3][3]);
__device__ void eraLtpb(double epj, double rpb[3][3]);
__device__ void eraLtpecl(double epj, double vec[3]);
__device__ void eraLtpequ(double epj, double veq[3]);
__device__ void eraNum00a(double date1, double date2, double rmatn[3][3]);
__device__ void eraNum00b(double date1, double date2, double rmatn[3][3]);
__device__ void eraNum06a(double date1, double date2, double rmatn[3][3]);
__device__ void eraNumat(double epsa, double dpsi, double deps, double rmatn[3][3]);
__device__ void eraNut00a(double date1, double date2, double *dpsi, double *deps);
__device__ void eraNut00b(double date1, double date2, double *dpsi, double *deps);
__device__ void eraNut06a(double date1, double date2, double *dpsi, double *deps);
__device__ void eraNut80(double date1, double date2, double *dpsi, double *deps);
__device__ void eraNutm80(double date1, double date2, double rmatn[3][3]);
__device__ double eraObl06(double date1, double date2);
__device__ double eraObl80(double date1, double date2);
__device__ void eraP06e(double date1, double date2,
             double *eps0, double *psia, double *oma, double *bpa,
             double *bqa, double *pia, double *bpia,
             double *epsa, double *chia, double *za, double *zetaa,
             double *thetaa, double *pa,
             double *gam, double *phi, double *psi);
__device__ void eraPb06(double date1, double date2,
             double *bzeta, double *bz, double *btheta);
__device__ void eraPfw06(double date1, double date2,
              double *gamb, double *phib, double *psib, double *epsa);
__device__ void eraPmat00(double date1, double date2, double rbp[3][3]);
__device__ void eraPmat06(double date1, double date2, double rbp[3][3]);
__device__ void eraPmat76(double date1, double date2, double rmatp[3][3]);
__device__ void eraPn00(double date1, double date2, double dpsi, double deps,
             double *epsa,
             double rb[3][3], double rp[3][3], double rbp[3][3],
             double rn[3][3], double rbpn[3][3]);
__device__ void eraPn00a(double date1, double date2,
              double *dpsi, double *deps, double *epsa,
              double rb[3][3], double rp[3][3], double rbp[3][3],
              double rn[3][3], double rbpn[3][3]);
__device__ void eraPn00b(double date1, double date2,
              double *dpsi, double *deps, double *epsa,
              double rb[3][3], double rp[3][3], double rbp[3][3],
              double rn[3][3], double rbpn[3][3]);
__device__ void eraPn06(double date1, double date2, double dpsi, double deps,
             double *epsa,
             double rb[3][3], double rp[3][3], double rbp[3][3],
             double rn[3][3], double rbpn[3][3]);
__device__ void eraPn06a(double date1, double date2,
              double *dpsi, double *deps, double *epsa,
              double rb[3][3], double rp[3][3], double rbp[3][3],
              double rn[3][3], double rbpn[3][3]);
__device__ void eraPnm00a(double date1, double date2, double rbpn[3][3]);
__device__ void eraPnm00b(double date1, double date2, double rbpn[3][3]);
__device__ void eraPnm06a(double date1, double date2, double rnpb[3][3]);
__device__ void eraPnm80(double date1, double date2, double rmatpn[3][3]);
__device__ void eraPom00(double xp, double yp, double sp, double rpom[3][3]);
__device__ void eraPr00(double date1, double date2,
             double *dpsipr, double *depspr);
__device__ void eraPrec76(double date01, double date02,
               double date11, double date12,
               double *zeta, double *z, double *theta);
__device__ double eraS00(double date1, double date2, double x, double y);
__device__ double eraS00a(double date1, double date2);
__device__ double eraS00b(double date1, double date2);
__device__ double eraS06(double date1, double date2, double x, double y);
__device__ double eraS06a(double date1, double date2);
__device__ double eraSp00(double date1, double date2);
__device__ void eraXy06(double date1, double date2, double *x, double *y);
__device__ void eraXys00a(double date1, double date2,
               double *x, double *y, double *s);
__device__ void eraXys00b(double date1, double date2,
               double *x, double *y, double *s);
__device__ void eraXys06a(double date1, double date2,
               double *x, double *y, double *s);

/* Astronomy/RotationAndTime */
__device__ double eraEe00(double date1, double date2, double epsa, double dpsi);
__device__ double eraEe00a(double date1, double date2);
__device__ double eraEe00b(double date1, double date2);
__device__ double eraEe06a(double date1, double date2);
__device__ double eraEect00(double date1, double date2);
__device__ double eraEqeq94(double date1, double date2);
__device__ double eraEra00(double dj1, double dj2);
__device__ double eraGmst00(double uta, double utb, double tta, double ttb);
__device__ double eraGmst06(double uta, double utb, double tta, double ttb);
__device__ double eraGmst82(double dj1, double dj2);
__device__ double eraGst00a(double uta, double utb, double tta, double ttb);
__device__ double eraGst00b(double uta, double utb);
__device__ double eraGst06(double uta, double utb, double tta, double ttb,
                double rnpb[3][3]);
__device__ double eraGst06a(double uta, double utb, double tta, double ttb);
__device__ double eraGst94(double uta, double utb);

/* Astronomy/SpaceMotion */
__device__ int eraPvstar(double pv[2][3], double *ra, double *dec,
              double *pmr, double *pmd, double *px, double *rv);
__device__ int eraStarpv(double ra, double dec,
              double pmr, double pmd, double px, double rv,
              double pv[2][3]);

/* Astronomy/StarCatalogs */
__device__ void eraFk425(double r1950, double d1950,
              double dr1950, double dd1950,
              double p1950, double v1950,
              double *r2000, double *d2000,
              double *dr2000, double *dd2000,
              double *p2000, double *v2000);
__device__ void eraFk45z(double r1950, double d1950, double bepoch,
              double *r2000, double *d2000);
__device__ void eraFk524(double r2000, double d2000,
              double dr2000, double dd2000,
              double p2000, double v2000,
              double *r1950, double *d1950,
              double *dr1950, double *dd1950,
              double *p1950, double *v1950);
__device__ void eraFk52h(double r5, double d5,
              double dr5, double dd5, double px5, double rv5,
              double *rh, double *dh,
              double *drh, double *ddh, double *pxh, double *rvh);
__device__ void eraFk54z(double r2000, double d2000, double bepoch,
              double *r1950, double *d1950,
              double *dr1950, double *dd1950);
__device__ void eraFk5hip(double r5h[3][3], double s5h[3]);
__device__ void eraFk5hz(double r5, double d5, double date1, double date2,
              double *rh, double *dh);
__device__ void eraH2fk5(double rh, double dh,
              double drh, double ddh, double pxh, double rvh,
              double *r5, double *d5,
              double *dr5, double *dd5, double *px5, double *rv5);
__device__ void eraHfk5z(double rh, double dh, double date1, double date2,
              double *r5, double *d5, double *dr5, double *dd5);
__device__ int eraStarpm(double ra1, double dec1,
              double pmr1, double pmd1, double px1, double rv1,
              double ep1a, double ep1b, double ep2a, double ep2b,
              double *ra2, double *dec2,
              double *pmr2, double *pmd2, double *px2, double *rv2);

/* Astronomy/EclipticCoordinates */
__device__ void eraEceq06(double date1, double date2, double dl, double db,
               double *dr, double *dd);
__device__ void eraEcm06(double date1, double date2, double rm[3][3]);
__device__ void eraEqec06(double date1, double date2, double dr, double dd,
               double *dl, double *db);
__device__ void eraLteceq(double epj, double dl, double db, double *dr, double *dd);
__device__ void eraLtecm(double epj, double rm[3][3]);
__device__ void eraLteqec(double epj, double dr, double dd, double *dl, double *db);

/* Astronomy/GalacticCoordinates */
__device__ void eraG2icrs(double dl, double db, double *dr, double *dd);
__device__ void eraIcrs2g(double dr, double dd, double *dl, double *db);

/* Astronomy/GeodeticGeocentric */
__device__ int eraEform(int n, double *a, double *f);
__device__ int eraGc2gd(int n, double xyz[3],
             double *elong, double *phi, double *height);
__device__ int eraGc2gde(double a, double f, double xyz[3],
              double *elong, double *phi, double *height);
__device__ int eraGd2gc(int n, double elong, double phi, double height,
             double xyz[3]);
__device__ int eraGd2gce(double a, double f,
              double elong, double phi, double height, double xyz[3]);

/* Astronomy/Timescales */
__device__ int eraD2dtf(const char *scale, int ndp, double d1, double d2,
             int *iy, int *im, int *id, int ihmsf[4]);
__device__ int eraDat(int iy, int im, int id, double fd, double *deltat);
__device__ double eraDtdb(double date1, double date2,
               double ut, double elong, double u, double v);
__device__ int eraDtf2d(const char *scale, int iy, int im, int id,
             int ihr, int imn, double sec, double *d1, double *d2);
__device__ int eraTaitt(double tai1, double tai2, double *tt1, double *tt2);
__device__ int eraTaiut1(double tai1, double tai2, double dta,
              double *ut11, double *ut12);
__device__ int eraTaiutc(double tai1, double tai2, double *utc1, double *utc2);
__device__ int eraTcbtdb(double tcb1, double tcb2, double *tdb1, double *tdb2);
__device__ int eraTcgtt(double tcg1, double tcg2, double *tt1, double *tt2);
__device__ int eraTdbtcb(double tdb1, double tdb2, double *tcb1, double *tcb2);
__device__ int eraTdbtt(double tdb1, double tdb2, double dtr,
             double *tt1, double *tt2);
__device__ int eraTttai(double tt1, double tt2, double *tai1, double *tai2);
__device__ int eraTttcg(double tt1, double tt2, double *tcg1, double *tcg2);
__device__ int eraTttdb(double tt1, double tt2, double dtr,
             double *tdb1, double *tdb2);
__device__ int eraTtut1(double tt1, double tt2, double dt,
             double *ut11, double *ut12);
__device__ int eraUt1tai(double ut11, double ut12, double dta,
              double *tai1, double *tai2);
__device__ int eraUt1tt(double ut11, double ut12, double dt,
             double *tt1, double *tt2);
__device__ int eraUt1utc(double ut11, double ut12, double dut1,
              double *utc1, double *utc2);
__device__ int eraUtctai(double utc1, double utc2, double *tai1, double *tai2);
__device__ int eraUtcut1(double utc1, double utc2, double dut1,
              double *ut11, double *ut12);

/* Astronomy/HorizonEquatorial */
__device__ void eraAe2hd(double az, double el, double phi,
              double *ha, double *dec);
__device__ void eraHd2ae(double ha, double dec, double phi,
              double *az, double *el);
__device__ double eraHd2pa(double ha, double dec, double phi);

/* Astronomy/Gnomonic */
__device__ int eraTpors(double xi, double eta, double a, double b,
             double *a01, double *b01, double *a02, double *b02);
__device__ int eraTporv(double xi, double eta, double v[3],
             double v01[3], double v02[3]);
__device__ void eraTpsts(double xi, double eta, double a0, double b0,
              double *a, double *b);
__device__ void eraTpstv(double xi, double eta, double v0[3], double v[3]);
__device__ int eraTpxes(double a, double b, double a0, double b0,
             double *xi, double *eta);
__device__ int eraTpxev(double v[3], double v0[3], double *xi, double *eta);

/* VectorMatrix/AngleOps */
__device__ void eraA2af(int ndp, double angle, char *sign, int idmsf[4]);
__device__ void eraA2tf(int ndp, double angle, char *sign, int ihmsf[4]);
__device__ int eraAf2a(char s, int ideg, int iamin, double asec, double *rad);
__device__ double eraAnp(double a);
__device__ double eraAnpm(double a);
__device__ void eraD2tf(int ndp, double days, char *sign, int ihmsf[4]);
__device__ int eraTf2a(char s, int ihour, int imin, double sec, double *rad);
__device__ int eraTf2d(char s, int ihour, int imin, double sec, double *days);

/* VectorMatrix/BuildRotations */
__device__ void eraRx(double phi, double r[3][3]);
__device__ void eraRy(double theta, double r[3][3]);
__device__ void eraRz(double psi, double r[3][3]);

/* VectorMatrix/CopyExtendExtract */
__device__ void eraCp(double p[3], double c[3]);
__device__ void eraCpv(double pv[2][3], double c[2][3]);
__device__ void eraCr(double r[3][3], double c[3][3]);
__device__ void eraP2pv(double p[3], double pv[2][3]);
__device__ void eraPv2p(double pv[2][3], double p[3]);

/* VectorMatrix/Initialization */
__device__ void eraIr(double r[3][3]);
__device__ void eraZp(double p[3]);
__device__ void eraZpv(double pv[2][3]);
__device__ void eraZr(double r[3][3]);

/* VectorMatrix/MatrixOps */
__device__ void eraRxr(double a[3][3], double b[3][3], double atb[3][3]);
__device__ void eraTr(double r[3][3], double rt[3][3]);

/* VectorMatrix/MatrixVectorProducts */
__device__ void eraRxp(double r[3][3], double p[3], double rp[3]);
__device__ void eraRxpv(double r[3][3], double pv[2][3], double rpv[2][3]);
__device__ void eraTrxp(double r[3][3], double p[3], double trp[3]);
__device__ void eraTrxpv(double r[3][3], double pv[2][3], double trpv[2][3]);

/* VectorMatrix/RotationVectors */
__device__ void eraRm2v(double r[3][3], double w[3]);
__device__ void eraRv2m(double w[3], double r[3][3]);

/* VectorMatrix/SeparationAndAngle */
__device__ double eraPap(double a[3], double b[3]);
__device__ double eraPas(double al, double ap, double bl, double bp);
__device__ double eraSepp(double a[3], double b[3]);
__device__ double eraSeps(double al, double ap, double bl, double bp);

/* VectorMatrix/SphericalCartesian */
__device__ void eraC2s(double p[3], double *theta, double *phi);
__device__ void eraP2s(double p[3], double *theta, double *phi, double *r);
__device__ void eraPv2s(double pv[2][3],
             double *theta, double *phi, double *r,
             double *td, double *pd, double *rd);
__device__ void eraS2c(double theta, double phi, double c[3]);
__device__ void eraS2p(double theta, double phi, double r, double p[3]);
__device__ void eraS2pv(double theta, double phi, double r,
             double td, double pd, double rd,
             double pv[2][3]);

/* VectorMatrix/VectorOps */
__device__ double eraPdp(double a[3], double b[3]);
__device__ double eraPm(double p[3]);
__device__ void eraPmp(double a[3], double b[3], double amb[3]);
__device__ void eraPn(double p[3], double *r, double u[3]);
__device__ void eraPpp(double a[3], double b[3], double apb[3]);
__device__ void eraPpsp(double a[3], double s, double b[3], double apsb[3]);
__device__ void eraPvdpv(double a[2][3], double b[2][3], double adb[2]);
__device__ void eraPvm(double pv[2][3], double *r, double *s);
__device__ void eraPvmpv(double a[2][3], double b[2][3], double amb[2][3]);
__device__ void eraPvppv(double a[2][3], double b[2][3], double apb[2][3]);
__device__ void eraPvu(double dt, double pv[2][3], double upv[2][3]);
__device__ void eraPvup(double dt, double pv[2][3], double p[3]);
__device__ void eraPvxpv(double a[2][3], double b[2][3], double axb[2][3]);
__device__ void eraPxp(double a[3], double b[3], double axb[3]);
__device__ void eraS2xpv(double s1, double s2, double pv[2][3], double spv[2][3]);
__device__ void eraSxp(double s, double p[3], double sp[3]);
__device__ void eraSxpv(double s, double pv[2][3], double spv[2][3]);

#ifdef __cplusplus
}
#endif

#endif


/*----------------------------------------------------------------------
**  
**  
**  Copyright (C) 2013-2023, NumFOCUS Foundation.
**  All rights reserved.
**  
**  This library is derived, with permission, from the International
**  Astronomical Union's "Standards of Fundamental Astronomy" library,
**  available from http://www.iausofa.org.
**  
**  The ERFA version is intended to retain identical functionality to
**  the SOFA library, but made distinct through different function and
**  file names, as set out in the SOFA license conditions.  The SOFA
**  original has a role as a reference standard for the IAU and IERS,
**  and consequently redistribution is permitted only in its unaltered
**  state.  The ERFA version is not subject to this restriction and
**  therefore can be included in distributions which do not support the
**  concept of "read only" software.
**  
**  Although the intent is to replicate the SOFA API (other than
**  replacement of prefix names) and results (with the exception of
**  bugs;  any that are discovered will be fixed), SOFA is not
**  responsible for any errors found in this version of the library.
**  
**  If you wish to acknowledge the SOFA heritage, please acknowledge
**  that you are using a library derived from SOFA, rather than SOFA
**  itself.
**  
**  
**  TERMS AND CONDITIONS
**  
**  Redistribution and use in source and binary forms, with or without
**  modification, are permitted provided that the following conditions
**  are met:
**  
**  1 Redistributions of source code must retain the above copyright
**    notice, this list of conditions and the following disclaimer.
**  
**  2 Redistributions in binary form must reproduce the above copyright
**    notice, this list of conditions and the following disclaimer in
**    the documentation and/or other materials provided with the
**    distribution.
**  
**  3 Neither the name of the Standards Of Fundamental Astronomy Board,
**    the International Astronomical Union nor the names of its
**    contributors may be used to endorse or promote products derived
**    from this software without specific prior written permission.
**  
**  THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS
**  "AS IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT
**  LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS
**  FOR A PARTICULAR PURPOSE ARE DISCLAIMED.  IN NO EVENT SHALL THE
**  COPYRIGHT HOLDER OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT,
**  INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING,
**  BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES;
**  LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER
**  CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT
**  LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN
**  ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE
**  POSSIBILITY OF SUCH DAMAGE.
**  
*/
