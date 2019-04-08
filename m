From: Stefan Hajnoczi <stefanha@redhat.com>
Subject: Re: [PATCH RFC 0/4] vsock/virtio: optimizations to increase the
	throughput
Date: Mon, 8 Apr 2019 10:23:18 +0100
Message-ID: <20190408092318.GM15001__12016.5860907704$1554715417$gmane$org@stefanha-x1.localdomain>
References: <20190404105838.101559-1-sgarzare@redhat.com>
	<20190404114643-mutt-send-email-mst@kernel.org>
	<20190404164715.sycigtccwq2rziuz@steredhat>
	<20190404140345-mutt-send-email-mst@kernel.org>
	<20190405074917.ooftpalmploq6x3b@steredhat>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============3752699334039785395=="
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20190405074917.ooftpalmploq6x3b@steredhat>
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
Cc: kvm@vger.kernel.org, "Michael S. Tsirkin" <mst@redhat.com>, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org, "David S. Miller" <davem@davemloft.net>
List-Id: virtualization@lists.linuxfoundation.org


--===============3752699334039785395==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="yaap9KN+GmBP785v"
Content-Disposition: inline


--yaap9KN+GmBP785v
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Apr 05, 2019 at 09:49:17AM +0200, Stefano Garzarella wrote:
> On Thu, Apr 04, 2019 at 02:04:10PM -0400, Michael S. Tsirkin wrote:
> > On Thu, Apr 04, 2019 at 06:47:15PM +0200, Stefano Garzarella wrote:
> > > On Thu, Apr 04, 2019 at 11:52:46AM -0400, Michael S. Tsirkin wrote:
> > > > I simply love it that you have analysed the individual impact of
> > > > each patch! Great job!
> > >=20
> > > Thanks! I followed Stefan's suggestions!
> > >=20
> > > >=20
> > > > For comparison's sake, it could be IMHO benefitial to add a column
> > > > with virtio-net+vhost-net performance.
> > > >=20
> > > > This will both give us an idea about whether the vsock layer introd=
uces
> > > > inefficiencies, and whether the virtio-net idea has merit.
> > > >=20
> > >=20
> > > Sure, I already did TCP tests on virtio-net + vhost, starting qemu in
> > > this way:
> > >   $ qemu-system-x86_64 ... \
> > >       -netdev tap,id=3Dnet0,vhost=3Don,ifname=3Dtap0,script=3Dno,down=
script=3Dno \
> > >       -device virtio-net-pci,netdev=3Dnet0
> > >=20
> > > I did also a test using TCP_NODELAY, just to be fair, because VSOCK
> > > doesn't implement something like this.
> >=20
> > Why not?
> >=20
>=20
> I think because originally VSOCK was designed to be simple and
> low-latency, but of course we can introduce something like that.
>=20
> Current implementation directly copy the buffer from the user-space in a
> virtio_vsock_pkt and enqueue it to be transmitted.
>=20
> Maybe we can introduce a buffer per socket where accumulate bytes and
> send it when it is full or when a timer is fired . We can also introduce
> a VSOCK_NODELAY (maybe using the same value of TCP_NODELAY for
> compatibility) to send the buffer immediately for low-latency use cases.
>=20
> What do you think?

Today virtio-vsock implements a 1:1 sendmsg():packet relationship
because it's simple.  But there's no need for the guest to enqueue
multiple VIRTIO_VSOCK_OP_RW packets when a single large packet could
combine all payloads for a connection.  This is not the same as
TCP_NODELAY but related.

I think it's worth exploring TCP_NODELAY and send_pkt_list merging.
Hopefully it won't make the code much more complicated.

Stefan

--yaap9KN+GmBP785v
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJcqxMGAAoJEJykq7OBq3PITjwH/jr71No5QfyjmjTtKanTvBNm
ETbLBSbD/NXtjcvBfF3HVkiPyv2dNjB/cpAc8/dAVlvnMskaQHdeKIxeTZ9k//jC
dxUbXR6TYhYbQhwMQN8ra8GaxhlweNsjgjARXFw0Tl8ROSICLL881UhGJ7VseSkz
FR43QCE+HTQgZmBhmNg9wODD4mXZGyAKSDCkDsAk6SrJALV5RTXOI8lhRwi7Ro+e
ASS7b3XQXfbgn2gw37OIyehAY/vxo/PBQSFYAOOBIdNhQK4a+G/i2T0wOTN9yrxD
09/8JSvXIj97UPAO786QIFaUMYFvYsZJ5usFzBvIGntSvZMPLkyeDlUAw/Y1CUA=
=oVMF
-----END PGP SIGNATURE-----

--yaap9KN+GmBP785v--

--===============3752699334039785395==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
--===============3752699334039785395==--
