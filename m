From: "=?utf-8?q?S=2E=C3=87a=C4=9Flar?= Onur" <caglar@pardus.org.tr>
Subject: Re: [PATCH] Fix potential interrupts during alternative patching =?utf-8?q?=5Bwas=09Re=3A_=5BRFC=5D_Avoid_PIT_SMP?= lockups]
Date: Fri, 20 Oct 2006 13:36:05 +0300
Message-ID: <200610201336.05760.caglar@pardus.org.tr>
References: <1160170736.6140.31.camel@localhost.localdomain> <45373C1D.9080808@goop.org> <45373E92.1070200@vmware.com>
Reply-To: caglar@pardus.org.tr
Mime-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart3185532.zcL0iRfIK5";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1422940AbWJTKgI@vger.kernel.org>
In-Reply-To: <45373E92.1070200@vmware.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Zachary Amsden <zach@vmware.com>
Cc: Jeremy Fitzhardinge <jeremy@goop.org>, Andi Kleen <ak@suse.de>, lkml <linux-kernel@vger.kernel.org>, Virtualization Mailing List <virtualization@lists.osdl.org>, Greg KH <greg@kroah.com>, Andrew Morton <akpm@osdl.org>
List-Id: virtualization@lists.linuxfoundation.org

--nextPart3185532.zcL0iRfIK5
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

19 Eki 2006 Per 12:00 tarihinde, Zachary Amsden =C5=9Funlar=C4=B1 yazm=C4=
=B1=C5=9Ft=C4=B1:=20
> Jeremy Fitzhardinge wrote:
> > Zachary Amsden wrote:
> >> So this patch is an obvious bugfix - please apply, and to stable as
> >> well. I'm not sure when this broke, but taking interrupts in the
> >> middle of self modifying code is not a pretty sight.
> >
> > I had actually seen this when I built the Xen paravirt kernel with SMP
> > on, but I assumed it was something in the pv_ops tree rather than
> > mainline...
>
> Very likely to show up in qemu as well, if you use that.

I can confirm qemu and virtual pc 2004 gaves same exception without that=20
patch.

=2D-=20
S.=C3=87a=C4=9Flar Onur <caglar@pardus.org.tr>
http://cekirdek.pardus.org.tr/~caglar/

Linux is like living in a teepee. No Windows, no Gates and an Apache in hou=
se!

--nextPart3185532.zcL0iRfIK5
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.5 (GNU/Linux)

iD8DBQBFOKaVy7E6i0LKo6YRArzkAKCQfTN4WielKDQm9n3Qhipz6ZpPRwCgkBpp
79gu9E0X8s6Nh81NyePN6/M=
=xl1Z
-----END PGP SIGNATURE-----

--nextPart3185532.zcL0iRfIK5--
