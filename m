From: Stephen Rothwell <sfr@canb.auug.org.au>
Subject: Re: linux-next: Tree for June 18 (XEN build error)
Date: Thu, 19 Jun 2008 15:54:51 +1000
Message-ID: <20080619155451.0a4ea6f8.sfr@canb.auug.org.au>
References: <20080618175753.2a519b71.sfr@canb.auug.org.au>
	<20080618124331.04e27900.randy.dunlap@oracle.com>
	<4859E9B8.9040406@goop.org>
Mime-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature";
 micalg="PGP-SHA1";
 boundary="Signature=_Thu__19_Jun_2008_15_54_51_+1000_oPcnqRUAr122._Oi"
Return-path: <linux-next-owner@vger.kernel.org>
In-Reply-To: <4859E9B8.9040406@goop.org>
Sender: linux-next-owner@vger.kernel.org
To: Jeremy Fitzhardinge <jeremy@goop.org>
Cc: Randy Dunlap <randy.dunlap@oracle.com>, jeremy@xensource.com, chrisw@sous-sol.org, linux-next@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>, virtualization@lists.osdl.org
List-Id: virtualization@lists.linuxfoundation.org

--Signature=_Thu__19_Jun_2008_15_54_51_+1000_oPcnqRUAr122._Oi
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, 18 Jun 2008 22:08:08 -0700 Jeremy Fitzhardinge <jeremy@goop.org> wr=
ote:
>
> Randy Dunlap wrote:
> > linux-next-20080618/drivers/xen/manage.c: In function 'xen_suspend':
> > linux-next-20080618/drivers/xen/manage.c:66: error: too few arguments t=
o function 'device_power_up'
> > linux-next-20080618/drivers/xen/manage.c: In function 'do_suspend':
> > linux-next-20080618/drivers/xen/manage.c:115: error: too few arguments =
to function 'device_resume'
> > make[3]: *** [drivers/xen/manage.o] Error 1
> >  =20
>=20
> What argument(s) do device_power_up() and device_resume() want now?

In today's linux-next:

void device_power_up(pm_message_t state)
void device_resume(pm_message_t state)

If someone can give me a patch, I can carry it in linux-next ...

--=20
Cheers,
Stephen Rothwell                    sfr@canb.auug.org.au
http://www.canb.auug.org.au/~sfr/

--Signature=_Thu__19_Jun_2008_15_54_51_+1000_oPcnqRUAr122._Oi
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEARECAAYFAkhZ9KsACgkQTgG2atn1QN+fYACeKC7yV15vkutEIZbGUn5uH56D
NpQAn0zV2NMklMGbyv5bqFkhEyJzA4SC
=+VnH
-----END PGP SIGNATURE-----

--Signature=_Thu__19_Jun_2008_15_54_51_+1000_oPcnqRUAr122._Oi--
