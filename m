From: James Hogan <james.hogan@imgtec.com>
Subject: Re: [PATCH v2 20/32] metag: define __smp_xxx
Date: Mon, 4 Jan 2016 16:04:55 +0000
Message-ID: <20160104160455.GE17861__27158.0916982659$1451923517$gmane$org@jhogan-linux.le.imgtec.org>
References: <1451572003-2440-1-git-send-email-mst@redhat.com>
	<1451572003-2440-21-git-send-email-mst@redhat.com>
	<20160104134128.GZ6344@twins.programming.kicks-ass.net>
	<20160104152558.GD17861@jhogan-linux.le.imgtec.org>
	<20160104153036.GG6344@twins.programming.kicks-ass.net>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1604571725006547991=="
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20160104153036.GG6344@twins.programming.kicks-ass.net>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Peter Zijlstra <peterz@infradead.org>
Cc: linux-mips@linux-mips.org, linux-ia64@vger.kernel.org, "Michael S. Tsirkin" <mst@redhat.com>, virtualization@lists.linux-foundation.org, "H. Peter Anvin" <hpa@zytor.com>, sparclinux@vger.kernel.org, Ingo Molnar <mingo@kernel.org>, linux-arch@vger.kernel.org, linux-s390@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>, Davidlohr Bueso <dbueso@suse.de>, linux-sh@vger.kernel.org, x86@kernel.org, xen-devel@lists.xenproject.org, Ingo Molnar <mingo@elte.hu>, linux-xtensa@linux-xtensa.org, user-mode-linux-devel@lists.sourceforge.net, Stefano Stabellini <stefano.stabellini@eu.citrix.com>, Andrey Konovalov <andreyknvl@google.com>, adi-buildroot-devel@lists.sourceforge.net, Thomas Gleixner <tglx@linutronix.de>, linux-metag@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Andrew Cooper <andrew.cooper3@citrix.com>, linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
List-Id: virtualization@lists.linuxfoundation.org

--===============1604571725006547991==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="PGNNI9BzQDUtgA2J"
Content-Disposition: inline

--PGNNI9BzQDUtgA2J
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jan 04, 2016 at 04:30:36PM +0100, Peter Zijlstra wrote:
> On Mon, Jan 04, 2016 at 03:25:58PM +0000, James Hogan wrote:
> > It is used along with the metag specific __global_lock1() (global
> > voluntary lock between hw threads) whenever a write is performed, and by
> > smp_mb/smp_rmb to try to catch other cases, but I've never been
> > confident this fixes every single corner case, since there could be
> > other places where multiple CPUs perform unsynchronised writes to the
> > same memory location, and expect cache not to become incoherent at that
> > location.
>=20
> Ah, yuck, I thought blackfin was the only one attempting !coherent SMP.
> And yes, this is bound to break in lots of places in subtle ways. We
> very much assume cache coherency for SMP in generic code.

Well, its usually completely coherent, its just a bit dodgy in a
particular hardware corner case, which was pretty hard to hit, even
without these workarounds.

>=20
> > It seemed to be sufficient to achieve stability however, and SMP on Meta
> > Linux never made it into a product anyway, since the other hw thread
> > tended to be used for RTOS stuff, so it didn't seem worth extending the
> > generic barrier API for it.
>=20
> *phew*, should we take it out then, just to be sure nobody accidentally
> tries to use it then?

SMP support on this SoC you mean? I doubt it'll be a problem tbh, and
it'd work fine in QEMU when emulating this SoC, so I'd prefer to keep it
in.

Cheers
James

--PGNNI9BzQDUtgA2J
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJWipgnAAoJEGwLaZPeOHZ6H00QAJCE8+tFVrOY06765tPTdzed
wYC0LFfKDLv/TtsEAy4zBhWYEwJ0R1gQOTjCKsdaJMINDcpCy+1mWV4b1X1B+ptV
QD5oOYZy7Fln8VYYvzWp+2Tz/iAoBSnBV1S8rG9eIxwWmJ9NQmhRl7I+GaFO5kgS
+0p+z0sJ6Fvv8jmFdzGF4AIAgm4hFY2O2ojy2jtGArgkFmuSdrrrS2//Uls6z3ZC
thEMVwEapQUjh0JZXDxkImzKXDfMcDi7Sse8Pdz+hXn0Q8J1u2tlhNwL7mqlY5lz
JpV/L050BZ94Vpop0JXLmQRkqaO7dDgmi+zGXSvSqSUL7/qWHk3h6gE6tTShr4Qp
rccA+QoreW9oQmUaAERc/DlB7I8SFYZE08YTLLVh+6bqPPK2sZOSa1/XfRC3UC35
+/exm7MjSr4Emmfo9D5xxRAf4e+nYIuYjmf0rik9Hz5CUYqgbc6yoN570p0omqnL
7WaRZWn+KESjhPrBrEcEbHFqV3OYsRgCPcoiSL5MVXXE0PlRXQtkDG9ach9jmtyZ
gz103rjyp1FdqUVG3yYfmCsTNfWwiOJRX1IXLkuTJ0Spjmmk9KtFFO5sUxMV/2l6
aJ+ehCqr/o58IZf71tqQvLQPeJCvUZ6y8mqAjBAdx1b+FBxUlu2kZ+opl3tI96dK
DUA3rNDlPNmeqf8XVgY8
=bXcF
-----END PGP SIGNATURE-----

--PGNNI9BzQDUtgA2J--

--===============1604571725006547991==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
--===============1604571725006547991==--
