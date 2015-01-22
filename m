From: David Gibson <david@gibson.dropbear.id.au>
Subject: Re: [Qemu-devel] [PATCH RFC v6 05/20] virtio: support more feature
	bits
Date: Thu, 22 Jan 2015 12:40:32 +1100
Message-ID: <20150122014032.GF27371__36485.5720931247$1421893526$gmane$org@voom.fritz.box>
References: <1418304322-7546-1-git-send-email-cornelia.huck@de.ibm.com>
	<1418304322-7546-6-git-send-email-cornelia.huck@de.ibm.com>
	<20141212110640.5ddfcbda@oc7435384737.ibm.com>
	<20141212111747.26047921.cornelia.huck@de.ibm.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0985020429817954745=="
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20141212111747.26047921.cornelia.huck@de.ibm.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Cornelia Huck <cornelia.huck@de.ibm.com>
Cc: qemu-devel@nongnu.org, virtualization@lists.linux-foundation.org, Thomas Huth <thuth@linux.vnet.ibm.com>, mst@redhat.com
List-Id: virtualization@lists.linuxfoundation.org


--===============0985020429817954745==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="/QKKmeG/X/bPShih"
Content-Disposition: inline


--/QKKmeG/X/bPShih
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Dec 12, 2014 at 11:17:47AM +0100, Cornelia Huck wrote:
> On Fri, 12 Dec 2014 11:06:40 +0100
> Thomas Huth <thuth@linux.vnet.ibm.com> wrote:
>=20
> > On Thu, 11 Dec 2014 14:25:07 +0100
> > Cornelia Huck <cornelia.huck@de.ibm.com> wrote:
[snip]
> > >      vdev->queue_sel =3D 0;
> > >      vdev->status =3D 0;
> > >      vdev->isr =3D 0;
> > > @@ -924,7 +925,8 @@ void virtio_save(VirtIODevice *vdev, QEMUFile *f)
> > >      qemu_put_8s(f, &vdev->status);
> > >      qemu_put_8s(f, &vdev->isr);
> > >      qemu_put_be16s(f, &vdev->queue_sel);
> > > -    qemu_put_be32s(f, &vdev->guest_features);
> > > +    /* XXX features >=3D 32 */
> > > +    qemu_put_be32s(f, (uint32_t *)&vdev->guest_features);
> >=20
> > Casting a uint64_t* to a uint32_t* here sounds very wrong - this likely
> > only works on little endian sytems, but certainly not on big-endian
> > systems.
> > If you do not want to extend this for 64-bit right from the beginning,
> > I think you've got to use a temporary 32-bit variable to get this right.
>=20
> Hm... always store the old 32 bits here, then store the new 32 bits
> later? Should be able to get that compatible.

I think Thomas' point is that since vdev->guest_features has changed
to a uint64_t, the "old" bits are now in the second 32-bit half on a
BE system.

Or maybe I'm misunderstanding your reply.

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--/QKKmeG/X/bPShih
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJUwFUQAAoJEGw4ysog2bOSr9QP+wbnpRa9qDRZrpDF3r5YqufE
n5IAig/0lkLYIMQzCMCN+SW2Na23h25I8M7XuW6RNe0IzmNeJPQMFdMx702RY+OX
vbFqqC85FJFUhxEHgHM/XEBGkb70ihHriHImv5EY5jDXvMQyc4S1uqdWmjEyyM5y
du1DKed3jFcCKycl6b6QI7Vloono/OktjOXVz6f0/C2WJRmptIn6cloibvQ9ivhB
7Y6J6JA6iKB6Ywwx9bMuuh8dLXwAo5g7KTBerZY/A9oMuBV9s7iuDPVrQoGHCxUa
Yz1BspS/plVsWJWjMloyYMiCi4htWADp0eU7gSRO9EJVtS6J5/3rK5WoxFI8ET09
2dusdE+nOvLtqtzvsiddy9SlLJDl1Pypa7uI3dPzFXDDuJAz/BTG0O+Id52Go10V
KKDtfcE/WkyK6OqFQW0YC5c1Tzu+WVTrWX17Spb7nfQb1srkXeXskn06ZlSRcxsA
uvvoziA4dOrtvg67pwQnLO9+HGGfNHyvm1D/7SDbW8WVQkZV/l8lUNrAizch5LAg
ltu6uHp9gY4i0WQQpdHTVUI2RKablse4HEeMnEBjINtaqL42KAktTTSDmpVmoVP0
NM3mBbnHWx3Kobk8lAy+DndRP6r5cdcSz/x+KozoIyV0FZXngRV39aEfgNrtC4da
H8tvQn/UoqR7l+IRq5cs
=gDOx
-----END PGP SIGNATURE-----

--/QKKmeG/X/bPShih--

--===============0985020429817954745==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
--===============0985020429817954745==--
