From: Stefan Hajnoczi <stefanha@gmail.com>
Subject: Re: [PATCH net-next 08/14] vsock: add vsock_create_connected()
	called by transports
Date: Sun, 27 Oct 2019 09:12:13 +0100
Message-ID: <20191027081213.GC4472__23315.9891025693$1572187438$gmane$org@stefanha-x1.localdomain>
References: <20191023095554.11340-1-sgarzare@redhat.com>
	<20191023095554.11340-9-sgarzare@redhat.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============4026023754936226677=="
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20191023095554.11340-9-sgarzare@redhat.com>
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
Cc: Sasha Levin <sashal@kernel.org>, linux-hyperv@vger.kernel.org, Stephen Hemminger <sthemmin@microsoft.com>, Arnd Bergmann <arnd@arndb.de>, kvm@vger.kernel.org, "Michael S. Tsirkin" <mst@redhat.com>, netdev@vger.kernel.org, Haiyang Zhang <haiyangz@microsoft.com>, Dexuan Cui <decui@microsoft.com>, linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org, Stefan Hajnoczi <stefanha@redhat.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "David S. Miller" <davem@davemloft.net>, Jorgen Hansen <jhansen@vmware.com>
List-Id: virtualization@lists.linuxfoundation.org


--===============4026023754936226677==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="DSayHWYpDlRfCAAQ"
Content-Disposition: inline


--DSayHWYpDlRfCAAQ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 23, 2019 at 11:55:48AM +0200, Stefano Garzarella wrote:
> All transports call __vsock_create() with the same parameters,
> most of them depending on the parent socket. In order to simplify
> the VSOCK core APIs exposed to the transports, this patch adds
> the vsock_create_connected() callable from transports to create
> a new socket when a connection request is received.
> We also unexported the __vsock_create().
>=20
> Suggested-by: Stefan Hajnoczi <stefanha@redhat.com>
> Signed-off-by: Stefano Garzarella <sgarzare@redhat.com>
> ---
>  include/net/af_vsock.h                  |  5 +----
>  net/vmw_vsock/af_vsock.c                | 20 +++++++++++++-------
>  net/vmw_vsock/hyperv_transport.c        |  3 +--
>  net/vmw_vsock/virtio_transport_common.c |  3 +--
>  net/vmw_vsock/vmci_transport.c          |  3 +--
>  5 files changed, 17 insertions(+), 17 deletions(-)

Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>

--DSayHWYpDlRfCAAQ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAl21UV0ACgkQnKSrs4Gr
c8j8/ggAyDA6UkgCfi0daj2HF5HCXYLlJ9/XXtklusGF1Wc9tWjzw/GXPdNlYum9
SqWtDu4YlWC3HH5TXKiMuTFjsumU6qJOSXKbPTFOmHdsQAnYeBMB1LZZRAd1O85T
LeBzRaNJjd+3qcjEeGf4gy7TuHGk49qnJaaP9n+SvheaN6DRf4cVJYhVYHf15xnI
qyhbT8cq5YcgszT/mp/D4guFPl9gYFPT7IqFvN8FOhELWmj7q6noJqAlEiUMsOSW
fg8L76b1v8h04Q7iF2lmvUMFu3q9POIgkxqCQcYZzxJUMFLJez2y8nWnRIbNLJnJ
l70AGpwkVMKXrJfa8DwyCI39cmT1Hg==
=06uZ
-----END PGP SIGNATURE-----

--DSayHWYpDlRfCAAQ--

--===============4026023754936226677==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
--===============4026023754936226677==--
