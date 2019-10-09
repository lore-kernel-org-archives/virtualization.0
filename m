From: Stefan Hajnoczi <stefanha@gmail.com>
Subject: Re: [RFC PATCH 09/13] hv_sock: set VMADDR_CID_HOST in the
	hvs_remote_addr_init()
Date: Wed, 9 Oct 2019 13:35:24 +0100
Message-ID: <20191009123524.GJ5747@stefanha-x1.localdomain>
References: <20190927112703.17745-1-sgarzare@redhat.com>
	<20190927112703.17745-10-sgarzare@redhat.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============5339365623878655763=="
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20190927112703.17745-10-sgarzare@redhat.com>
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
Cc: Sasha Levin <sashal@kernel.org>, linux-hyperv@vger.kernel.org, Stephen Hemminger <sthemmin@microsoft.com>, kvm@vger.kernel.org, "Michael S. Tsirkin" <mst@redhat.com>, netdev@vger.kernel.org, Haiyang Zhang <haiyangz@microsoft.com>, Dexuan Cui <decui@microsoft.com>, linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org, Stefan Hajnoczi <stefanha@redhat.com>, "David S. Miller" <davem@davemloft.net>, Jorgen Hansen <jhansen@vmware.com>
List-Id: virtualization@lists.linuxfoundation.org


--===============5339365623878655763==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="5me2qT3T17SWzdxI"
Content-Disposition: inline


--5me2qT3T17SWzdxI
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Sep 27, 2019 at 01:26:59PM +0200, Stefano Garzarella wrote:
> Remote peer is always the host, so we set VMADDR_CID_HOST as
> remote CID instead of VMADDR_CID_ANY.
>=20
> Signed-off-by: Stefano Garzarella <sgarzare@redhat.com>
> ---
>  net/vmw_vsock/hyperv_transport.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)

Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>

--5me2qT3T17SWzdxI
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAl2d1AwACgkQnKSrs4Gr
c8jb5wf/RiXbiexvEEg0hOVPHCNYSDBNEehuU8/ZUOo11ueiWzI9+b5rFidWUcc9
4VZ3SCtzOW/3meXooyF42QP97QPJ0sQO3jpPZjCECe9McxAbm0zum+N3Cb/0AbjT
xrpQ1FHtTgGBHydsxFcsyIcZMvp91o4Q7qNtExg/CB7vbOEJXFkSmh5968GD3o1f
uK0Rqjqgx1Fm30mT41uRe41JvrE7QtJr8yc/uFB2h2JL7RgxRa+G+mIV1+66P2t+
xIwq8Nj/JyQBfvD82Bvezuvf6ITNloJ7/97xTnHgg2U0YcslB/cU8gArZJlWHAKv
O9b3imMu/xyzY1oO4yJ+mmOM3cEtFQ==
=ktlx
-----END PGP SIGNATURE-----

--5me2qT3T17SWzdxI--

--===============5339365623878655763==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
--===============5339365623878655763==--
