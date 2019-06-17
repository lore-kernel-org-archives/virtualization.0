From: Sam Bobroff <sbobroff@linux.ibm.com>
Subject: Re: [EXTERNAL] Re: [PATCH 1/1] drm/bochs: Fix connector leak during
	driver unload
Date: Mon, 17 Jun 2019 11:20:34 +1000
Message-ID: <20190617012033.GA1151@tungsten.ozlabs.ibm.com>
References: <93b363ad62f4938d9ddf3e05b2a61e3f66b2dcd3.1558416473.git.sbobroff@linux.ibm.com>
	<20190521081029.dexgf7e7d3b7wxdw@sirius.home.kraxel.org>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0329040397705768519=="
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20190521081029.dexgf7e7d3b7wxdw@sirius.home.kraxel.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Gerd Hoffmann <kraxel@redhat.com>
Cc: airlied@linux.ie, daniel@ffwll.ch, linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org


--===============0329040397705768519==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="yrj/dFKFPuw6o+aM"
Content-Disposition: inline


--yrj/dFKFPuw6o+aM
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, May 21, 2019 at 10:10:29AM +0200, Gerd Hoffmann wrote:
>   Hi,
>=20
> The bug is in the driver, so ...
>=20
> > Bisecting the issue for commits to drivers/gpu/drm/bochs/ points to:
> > 6579c39594ae ("drm/bochs: atomic: switch planes to atomic, wire up help=
ers.")
> > ... but the issue also seems to be due to a change in the generic drm c=
ode
>=20
> ... this one is the culprit and should be listed.
>=20
> > (reverting it separately fixes the issue):
> > 846c7dfc1193 ("drm/atomic: Try to preserve the crtc enabled state in dr=
m_atomic_remove_fb, v2.")
> > ... so I've included both in the commit.  Is that the right thing to do?
>=20
> That only triggers the driver bug.
>=20
> I'll fix it up on commit,
>   Gerd

Sorry if I misunderstood, but were you going to take the patch and fix
it up or would you like me to post a v2?

Cheers,
Sam.


--yrj/dFKFPuw6o+aM
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEELWWF8pdtWK5YQRohMX8w6AQl/iIFAl0G6tMACgkQMX8w6AQl
/iJjVgf/T6KF8XcN9Z/Yppy+tUW0hD9031/YPdlJJ7slrFUkPrEcVSxARY1J32SO
f7Vdc6de427aF9P33QULxkg/rqAbdVYTuim6s3BQUPax7JYmkfviHOKUNPVdDlN/
BUBpEPqkanHxn8KKBSd4OdKWpek/20RTAgM+Vg5jwhN8jtLNHbrqXQf+z3ll1SS/
9iHxA/KH8/lBv1RH2AfbChumNz/dNioxMoZizPOxEZbu9G8tfDb40q2HBfLD8lXk
aCdFb8P6d37bkR1xn51HKqGgChbL6orlfiVuT1goYLB/MLxDvHn+9G5yywcwLjvp
zWJH22IKznWBtuRpaaoTunVc4UPd+Q==
=snbg
-----END PGP SIGNATURE-----

--yrj/dFKFPuw6o+aM--


--===============0329040397705768519==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
--===============0329040397705768519==--
