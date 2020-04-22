From: Stefan Hajnoczi <stefanha@redhat.com>
Subject: Re: [PATCH net] vsock/virtio: postpone packet delivery to monitoring
 devices
Date: Wed, 22 Apr 2020 17:54:20 +0100
Message-ID: <20200422165420.GL47385@stefanha-x1.localdomain>
References: <20200421092527.41651-1-sgarzare@redhat.com>
 <20200421154246.GA47385@stefanha-x1.localdomain>
 <20200421161724.c3pnecltfz4jajww@steredhat>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="FnOKg9Ah4tDwTfQS"
Return-path: <kvm-owner@vger.kernel.org>
In-Reply-To: <20200421161724.c3pnecltfz4jajww@steredhat>
Content-Disposition: inline
Sender: kvm-owner@vger.kernel.org
To: Stefano Garzarella <sgarzare@redhat.com>
Cc: Stefan Hajnoczi <stefanha@gmail.com>, davem@davemloft.net, Gerard Garcia <ggarcia@abra.uab.cat>, kvm@vger.kernel.org, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org, Jakub Kicinski <kuba@kernel.org>
List-Id: virtualization@lists.linuxfoundation.org

--FnOKg9Ah4tDwTfQS
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 21, 2020 at 06:17:24PM +0200, Stefano Garzarella wrote:
> On Tue, Apr 21, 2020 at 04:42:46PM +0100, Stefan Hajnoczi wrote:
> > On Tue, Apr 21, 2020 at 11:25:27AM +0200, Stefano Garzarella wrote:
> > > We delivering packets to monitoring devices, before to check if
> > > the virtqueue has enough space.
> >=20
> > "We [are] delivering packets" and "before to check" -> "before
> > checking".  Perhaps it can be rewritten as:
> >=20
> >   Packets are delivered to monitoring devices before checking if the
> >   virtqueue has enough space.
> >=20
>=20
> Yeah, it is better :-)
>=20
> > >=20
> > > If the virtqueue is full, the transmitting packet is queued up
> > > and it will be sent in the next iteration. This causes the same
> > > packet to be delivered multiple times to monitoring devices.
> > >=20
> > > This patch fixes this issue, postponing the packet delivery
> > > to monitoring devices, only when it is properly queued in the
> >=20
> > s/,//
> >=20
> > > virqueue.
> >=20
> > s/virqueue/virtqueue/
> >=20
>=20
> Thanks, I'll fix in the v2!
>=20
> > > @@ -137,6 +135,11 @@ virtio_transport_send_pkt_work(struct work_struc=
t *work)
> > >  =09=09=09break;
> > >  =09=09}
> > > =20
> > > +=09=09/* Deliver to monitoring devices all correctly transmitted
> > > +=09=09 * packets.
> > > +=09=09 */
> > > +=09=09virtio_transport_deliver_tap_pkt(pkt);
> > > +
> >=20
> > The device may see the tx packet and therefore receive a reply to it
> > before we can call virtio_transport_deliver_tap_pkt().  Does this mean
> > that replies can now appear in the packet capture before the transmitte=
d
> > packet?
>=20
> hmm, you are right!
>=20
> And the same thing can already happen in vhost-vsock where we call
> virtio_transport_deliver_tap_pkt() after the vhost_add_used(), right?
>=20
> The vhost-vsock case can be fixed in a simple way, but here do you think
> we should serialize them? (e.g. mutex, spinlock)
>=20
> In this case I'm worried about performance.
>=20
> Or is there some virtqueue API to check availability?

Let's stick to the same semantics as Ethernet netdevs.  That way there
are no surprises to anyone who is familiar with Linux packet captures.
I don't know what those semantics are though, you'd need to check the
code :).

Stefan

--FnOKg9Ah4tDwTfQS
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAl6gdrwACgkQnKSrs4Gr
c8ge/AgAr4BzzDJ/myfhWhgsvMu3TdicuwspJcKD1cHy36+ZKBVo2LAGNjaM14PE
LfCBpZxLe0al85XyUlQfyhc2yWGnLhNBatu6d9IXH+PiwWgI6LAsE0Wt0GSFgo2Q
8camx09TTHHx3zKvM5IyGHhJJNgQkOLjCGCRGGBclVjPZymt6KqH38T2YSvzcZlm
SlGJwX3YlAxmaDxLnenVfdDW76tVkcpg8Ik91Fpa6RHsD+Y4zxF07/qGPIzOB4Ay
fYQUeCAJV1Vf/au5LOy7KoH6LMdqlOKH8MzCkPXV41REHUYEOXNYWFy13HMkEj+1
QBkWbRsN/zAS6nmFJWAAYwFz+lNDog==
=uwp0
-----END PGP SIGNATURE-----

--FnOKg9Ah4tDwTfQS--
