From: Stefan Hajnoczi <stefanha@gmail.com>
Subject: Re: [PATCH 0/4] vsock/virtio: several fixes in the .probe() and
	.remove()
Date: Mon, 10 Jun 2019 14:09:45 +0100
Message-ID: <20190610130945.GL14257@stefanha-x1.localdomain>
References: <20190528105623.27983-1-sgarzare@redhat.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============2271529800197618317=="
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20190528105623.27983-1-sgarzare@redhat.com>
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
Cc: kvm@vger.kernel.org, "Michael S . Tsirkin" <mst@redhat.com>, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org, Stefan Hajnoczi <stefanha@redhat.com>, "David S. Miller" <davem@davemloft.net>
List-Id: virtualization@lists.linuxfoundation.org


--===============2271529800197618317==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="Swj79WlilW4BQYVz"
Content-Disposition: inline


--Swj79WlilW4BQYVz
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, May 28, 2019 at 12:56:19PM +0200, Stefano Garzarella wrote:
> During the review of "[PATCH] vsock/virtio: Initialize core virtio vsock
> before registering the driver", Stefan pointed out some possible issues
> in the .probe() and .remove() callbacks of the virtio-vsock driver.
>=20
> This series tries to solve these issues:
> - Patch 1 postpones the 'the_virtio_vsock' assignment at the end of the
>   .probe() to avoid that some sockets queue works when the initialization
>   is not finished.
> - Patches 2 and 3 stop workers before to call vdev->config->reset(vdev) to
>   be sure that no one is accessing the device, and adds another flush at =
the
>   end of the .remove() to avoid use after free.
> - Patch 4 free also used buffers in the virtqueues during the .remove().
>=20
> Stefano Garzarella (4):
>   vsock/virtio: fix locking around 'the_virtio_vsock'
>   vsock/virtio: stop workers during the .remove()
>   vsock/virtio: fix flush of works during the .remove()
>   vsock/virtio: free used buffers during the .remove()
>=20
>  net/vmw_vsock/virtio_transport.c | 105 ++++++++++++++++++++++++++-----
>  1 file changed, 90 insertions(+), 15 deletions(-)

Looking forward to v2.  I took a look at the discussion and I'll review
v2 from scratch.  Just keep in mind that the mutex is used more for
mutual exclusion of the init/exit code than to protect the_virtio_vsock,
so we'll still need protection of init/exit code even with RCU.

Stefan

--Swj79WlilW4BQYVz
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAlz+VpkACgkQnKSrs4Gr
c8gjIAf5AWLeKzDJN89IePr9aSiIQg5UqFqV3MQyrKA4CEklt/RqqcNc5/56tDEy
bvy+2q8wvJ7/OiMV5W11mpCpeLFDR9h4pggfExa/lWg5l+XYFVYD5Zelym/k5KPk
6M0hgDooBw4fm9rL2LalhQTTseflHIlXEdZK29E1lwX2em55BofBt5gRnk943uFm
Su0p8R1u9Jjqe8cypBWNMEIdfJtGhi8Mcs4RYfm/YDmYpyYyOWp5T47VTth0h6Mw
sJdCIlTi4tHHZSH53bZyjPJ8Hl7+kSh2afiMRgzNvuLPyNVhQEGzVWZd5svlNim/
u1Px/8wo39dQECN0sS0MNY07nG327w==
=Jv/l
-----END PGP SIGNATURE-----

--Swj79WlilW4BQYVz--

--===============2271529800197618317==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
--===============2271529800197618317==--
