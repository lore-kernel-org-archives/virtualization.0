From: Ben Hutchings <ben@decadent.org.uk>
Subject: Re: TUN_F_UFO change breaks live migration
Date: Tue, 11 Nov 2014 17:07:30 +0000
Message-ID: <1415725650.3398.97.camel@decadent.org.uk>
References: <20141111105849.GA8482@stefanha-thinkpad.redhat.com>
	<1415708246.3398.88.camel@decadent.org.uk>
	<20141111155750.GA17418@redhat.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============9062749641696735060=="
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20141111155750.GA17418@redhat.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: kvm@vger.kernel.org, virtualization@lists.linux-foundation.org, Stefan Hajnoczi <stefanha@redhat.com>, jelledejong@powercraft.nl, David Miller <davem@davemloft.net>
List-Id: virtualization@lists.linuxfoundation.org


--===============9062749641696735060==
Content-Type: multipart/signed; micalg="pgp-sha512";
	protocol="application/pgp-signature"; boundary="=-4XX8ahPaGDei3iRDYmC1"


--=-4XX8ahPaGDei3iRDYmC1
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, 2014-11-11 at 17:57 +0200, Michael S. Tsirkin wrote:
> On Tue, Nov 11, 2014 at 12:17:26PM +0000, Ben Hutchings wrote:
> > On Tue, 2014-11-11 at 10:58 +0000, Stefan Hajnoczi wrote:
> > > Commit 3d0ad09412ffe00c9afa201d01effdb6023d09b4 ("drivers/net: Disabl=
e
> > > UFO through virtio") breaks live migration of KVM guests from older t=
o
> > > newer host kernels:
> > >=20
> > > https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git/commi=
t/?id=3D3d0ad09412ffe00c9afa201d01effdb6023d09b4
> > >=20
> > > The problem occurs when a guest running on a host kernel without comm=
it
> > > 3d0ad0941 in tun.ko attempts to live migration to a host with commit
> > > 3d0ad0941.
> > >=20
> > > Live migration fails in QEMU with the following error message:
> > >=20
> > >   virtio-net: saved image requires TUN_F_UFO support
> > >=20
> > > The old host tun.ko advertised support for TUN_F_UFO.  The new host
> > > tun.ko does not and that's why QEMU aborts live migration.  QEMU cann=
ot
> > > change the features of a running virtio-net device.
> >=20
> > Yes, this is known and was mentioned in the DSA.
> >=20
> > > tuxcrafter provided logs from two Debian hosts migrating from
> > > 3.2.60-1+deb7u3 to 3.2.63-2+deb7u1:
> > >=20
> > > http://paste.debian.net/131264/
> > >=20
> > > I haven't investigated enough to suggest a fix, just wanted to bring =
it
> > > to your attention.  Soon a lot of people will be hitting this problem=
 as
> > > they upgrade their infrastructure and migrate guests - seems like a
> > > critical issue.
> >=20
> > You can work around this by making macvtap and tun still claim to
> > support UFO.
>=20
> If this is what we want userspace to do, let's just put the
> feature flag back?

Let's not *just* put the feature flag back.  I accept this is probably
needed as a workaround, but UFO/IPv6 still won't work correctly over
virtio.

> Basically userspace assumed that features will only
> ever be added, never removed, so this change is
> breaking it.

OK.

> >  They continue to support it even if it's not advertised
> > because the tap features don't reliably get propagated to virtio
> > devices.
> >=20
> > Ben.
>=20
> Hmm I don't understand this last sentence.
> features are actually reliably propagated to virtio devices.

They might be when using current QEMU and libvirt on the host.  They
weren't when I tested on Debian stable.  The warnings about 'using
disabled UFO feature' are reliably triggered if the host's tap driver is
patched and the guest's virtio_net driver is not.

Ben.

--=20
Ben Hutchings
Experience is directly proportional to the value of equipment destroyed.
                                                         - Carolyn Scheppne=
r

--=-4XX8ahPaGDei3iRDYmC1
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIVAwUAVGJCV+e/yOyVhhEJAQpJ9w//fYZUQCKkZ35rk/8BeeVoHehNQKHd+LMF
E2PrtpyV+UxsDYR9syzy0drfOmBBTyx1qQBELuln9yLNUYp+cOir1OzZ0rp0lcdT
OWv9D9dASEIbXycOrSQQmaZulbqSoqkKVMyz6eYuuqeHT2rxYabSaVvo8A4UW2dA
66+4Cwvbi+xkzUbuKPSGQmSfLzle4VlOZzLX0S3E5HnzdqZRyhn8on+ypX1PazZ1
vE2nAIeCCDD05gkzMxjFQIAxamHlb4lnJuC8Ka9j861Tu9p0GTnpmWv5FQLqRBKf
putTUOiJw6kK/H/chHdrr0ci/+WmhROO8WhvAKk0wWLCw1KxQtKlI7ExtKRLsgPO
yBV/CZyaSkjiemdkepyPuaR7SH2SU83qm1V0ei7tLH528hBy1xEyZRfFNf7zKNEd
BkmuivNp0mir+VYJ1TPy+7p6tiRS8IClPJmhunMY3Temn1DjTqTDUUP4bFoa94ys
bNxMqVG/P9BXmj6ZKZfrXmtFqo3UYkp3PsAwYAI0oTVVq7nLds+FFGKXP6JxmQMp
m9W9RG6ov4oknAczOtagP7+5aRI2Sa50/YlLSQGrICKT29Fa83E6j6OpTq6X+n5M
lNVFanAayskvJKd1Y1uHy2qim4++gJF1ZI+bDt8bjuvVzP6BMsZwS8ESIvyjvk7C
MPIiV0aVLX0=
=MulE
-----END PGP SIGNATURE-----

--=-4XX8ahPaGDei3iRDYmC1--

--===============9062749641696735060==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
--===============9062749641696735060==--
