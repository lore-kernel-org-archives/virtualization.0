From: Stefan Hajnoczi <stefanha@gmail.com>
Subject: Re: [PATCH net-next 12/14] vsock/vmci: register vmci_transport only
	when VMCI guest/host are active
Date: Sun, 27 Oct 2019 09:17:52 +0100
Message-ID: <20191027081752.GD4472__45828.6377879389$1572187446$gmane$org@stefanha-x1.localdomain>
References: <20191023095554.11340-1-sgarzare@redhat.com>
	<20191023095554.11340-13-sgarzare@redhat.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0117337910579865229=="
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20191023095554.11340-13-sgarzare@redhat.com>
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


--===============0117337910579865229==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="C1iGAkRnbeBonpVg"
Content-Disposition: inline


--C1iGAkRnbeBonpVg
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Oct 23, 2019 at 11:55:52AM +0200, Stefano Garzarella wrote:
> +static int __init vmci_transport_init(void)
> +{
> +	int features = VSOCK_TRANSPORT_F_DGRAM;

Where is this variable used?

--C1iGAkRnbeBonpVg
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAl21UrAACgkQnKSrs4Gr
c8iGGgf/YjP9kPT916spdjeVdu2Wg8PPuw60Kt/da2i6Qp1hdl0CTXaK1RJxoH8F
FYtdWNROfs6CPSHEP5xVD4xBeHvZEST4BgeVr/hFZYbw4F5vVb9OIDpSln7JkN/r
zldMb0Q+UjbvTUZm9buMeb08nbzn9CdeaCJDGPIRHOZjDNw+wL0cilfVm5NMDR4L
pNbLtyJJliiIZeh2CxCu0k8Kd25OUlwDfqHHuFvDn/kmcNyQlVOUwb0VRnDts8mW
ian+XNpRXDY24xdyZ9F2UxA6wvwOleFhEN/La2euNs8Iv38liHKNgiCDHe/+br/t
vuMWadKe9tonhgk7iUlCA5hNDKgKiQ==
=CXM0
-----END PGP SIGNATURE-----

--C1iGAkRnbeBonpVg--

--===============0117337910579865229==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
--===============0117337910579865229==--
