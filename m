From: Stefan Hajnoczi <stefanha@redhat.com>
Subject: Re: [PATCH v4 4/5] vhost/vsock: split packets to send using multiple
	buffers
Date: Mon, 22 Jul 2019 10:06:32 +0100
Message-ID: <20190722090632.GD24934@stefanha-x1.localdomain>
References: <20190717113030.163499-1-sgarzare@redhat.com>
	<20190717113030.163499-5-sgarzare@redhat.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0824544068008785175=="
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20190717113030.163499-5-sgarzare@redhat.com>
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


--===============0824544068008785175==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="BI5RvnYi6R4T2M87"
Content-Disposition: inline


--BI5RvnYi6R4T2M87
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 17, 2019 at 01:30:29PM +0200, Stefano Garzarella wrote:
> If the packets to sent to the guest are bigger than the buffer
> available, we can split them, using multiple buffers and fixing
> the length in the packet header.
> This is safe since virtio-vsock supports only stream sockets.
>=20
> Signed-off-by: Stefano Garzarella <sgarzare@redhat.com>
> ---
>  drivers/vhost/vsock.c                   | 66 ++++++++++++++++++-------
>  net/vmw_vsock/virtio_transport_common.c | 15 ++++--
>  2 files changed, 60 insertions(+), 21 deletions(-)

Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>

--BI5RvnYi6R4T2M87
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAl01fJgACgkQnKSrs4Gr
c8iGEAf8Djr/PEoFhNeRcB4nTbEZ0yqI9J0bTIg+5JPeRIwVuw8VN0SNdYcbUn4x
8z5Ze/MQcXrji7cU3OHBfNC0aTebpQ7odl8Fh+0Ge74z8CGT4fjTHgVVuFXcGOdw
oO0lLxNBn1PEZG3GziU7v1nnOOQMP7p1uedmMBNm1eRJztxOFGIfbl7eQzGYE0/0
UvnT0EbbiIaqcN151Db4L94rvRASIhKQSvk/Vx9lM6kKFzjJml2dO/pirzJvwyg7
ToYEINcqb5vJibA/uV9zXiaQPIuAi4HNSrXWXXvCyPZycd4MsISdRQSig44VmT3P
bkhomEAvwsqdfMfALjPSRENrlVKkhg==
=9pnw
-----END PGP SIGNATURE-----

--BI5RvnYi6R4T2M87--

--===============0824544068008785175==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
--===============0824544068008785175==--
