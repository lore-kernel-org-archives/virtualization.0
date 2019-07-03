From: Stefan Hajnoczi <stefanha@gmail.com>
Subject: Re: [PATCH v2 0/3] vsock/virtio: several fixes in the .probe() and
	.remove()
Date: Wed, 3 Jul 2019 10:14:53 +0100
Message-ID: <20190703091453.GA11844__553.881788958677$1562145847$gmane$org@stefanha-x1.localdomain>
References: <20190628123659.139576-1-sgarzare@redhat.com>
	<20190701151113.GE11900@stefanha-x1.localdomain>
	<20190701170357.jtuhy3ank7mv6izb@steredhat>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============4343557009544201301=="
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20190701170357.jtuhy3ank7mv6izb@steredhat>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Stefano Garzarella <sgarzare@redhat.com>
Cc: kvm@vger.kernel.org, "Michael S. Tsirkin" <mst@redhat.com>, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org, Stefan Hajnoczi <stefanha@redhat.com>, "David S. Miller" <davem@davemloft.net>
List-Id: virtualization@lists.linuxfoundation.org


--===============4343557009544201301==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="6TrnltStXW4iwmi0"
Content-Disposition: inline


--6TrnltStXW4iwmi0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jul 01, 2019 at 07:03:57PM +0200, Stefano Garzarella wrote:
> On Mon, Jul 01, 2019 at 04:11:13PM +0100, Stefan Hajnoczi wrote:
> > On Fri, Jun 28, 2019 at 02:36:56PM +0200, Stefano Garzarella wrote:
> > > During the review of "[PATCH] vsock/virtio: Initialize core virtio vs=
ock
> > > before registering the driver", Stefan pointed out some possible issu=
es
> > > in the .probe() and .remove() callbacks of the virtio-vsock driver.
> > >=20
> > > This series tries to solve these issues:
> > > - Patch 1 adds RCU critical sections to avoid use-after-free of
> > >   'the_virtio_vsock' pointer.
> > > - Patch 2 stops workers before to call vdev->config->reset(vdev) to
> > >   be sure that no one is accessing the device.
> > > - Patch 3 moves the works flush at the end of the .remove() to avoid
> > >   use-after-free of 'vsock' object.
> > >=20
> > > v2:
> > > - Patch 1: use RCU to protect 'the_virtio_vsock' pointer
> > > - Patch 2: no changes
> > > - Patch 3: flush works only at the end of .remove()
> > > - Removed patch 4 because virtqueue_detach_unused_buf() returns all t=
he buffers
> > >   allocated.
> > >=20
> > > v1: https://patchwork.kernel.org/cover/10964733/
> >=20
> > This looks good to me.
>=20
> Thanks for the review!
>=20
> >=20
> > Did you run any stress tests?  For example an SMP guest constantly
> > connecting and sending packets together with a script that
> > hotplug/unplugs vhost-vsock-pci from the host side.
>=20
> Yes, I started an SMP guest (-smp 4 -monitor tcp:127.0.0.1:1234,server,no=
wait)
> and I run these scripts to stress the .probe()/.remove() path:
>=20
> - guest
>   while true; do
>       cat /dev/urandom | nc-vsock -l 4321 > /dev/null &
>       cat /dev/urandom | nc-vsock -l 5321 > /dev/null &
>       cat /dev/urandom | nc-vsock -l 6321 > /dev/null &
>       cat /dev/urandom | nc-vsock -l 7321 > /dev/null &
>       wait
>   done
>=20
> - host
>   while true; do
>       cat /dev/urandom | nc-vsock 3 4321 > /dev/null &
>       cat /dev/urandom | nc-vsock 3 5321 > /dev/null &
>       cat /dev/urandom | nc-vsock 3 6321 > /dev/null &
>       cat /dev/urandom | nc-vsock 3 7321 > /dev/null &
>       sleep 2
>       echo "device_del v1" | nc 127.0.0.1 1234
>       sleep 1
>       echo "device_add vhost-vsock-pci,id=3Dv1,guest-cid=3D3" | nc 127.0.=
0.1 1234
>       sleep 1
>   done
>=20
> Do you think is enough or is better to have a test more accurate?

That's good when left running overnight so that thousands of hotplug
events are tested.

Stefan

--6TrnltStXW4iwmi0
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAl0ccg0ACgkQnKSrs4Gr
c8hyTQgAmrtuLTRHUWq+SnSxTw9xESj0gUVZd4sbTh6S0V4rPGdVbra3YbPfZfkH
IaakopaoNOkTWrPnhYmwgU30HpR8IAq/y7clSCsRIfPUYDSZok/iyag75Cy5oKno
lVANXMQYQ4Kgkq07R+BER41HW3MELCrSAX57rIat1F1OD3KouG6YicgmP7wetWcU
HVXVfjP7u1a2lUmuBdlcgPKX05STySKyNEQ3QdtLI6bgM6rGkx8OYn38Qe9cQuyi
zVG7+8JLFoJav87vvcIIB0IT8ifWocctQY//efyVVnrfHN6T5/35TPcM4bBW8HrK
Zs+bh7qyccexuuow4DrBHexFCIdtCw==
=jl/1
-----END PGP SIGNATURE-----

--6TrnltStXW4iwmi0--

--===============4343557009544201301==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
--===============4343557009544201301==--
