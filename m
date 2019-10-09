From: Stefan Hajnoczi <stefanha@gmail.com>
Subject: Re: [RFC PATCH 12/13] vsock: prevent transport modules unloading
Date: Wed, 9 Oct 2019 14:28:33 +0100
Message-ID: <20191009132833.GM5747__43724.3086214707$1570627730$gmane$org@stefanha-x1.localdomain>
References: <20190927112703.17745-1-sgarzare@redhat.com>
	<20190927112703.17745-13-sgarzare@redhat.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1159089283140870608=="
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20190927112703.17745-13-sgarzare@redhat.com>
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


--===============1159089283140870608==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="kunpHVz1op/+13PW"
Content-Disposition: inline


--kunpHVz1op/+13PW
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Sep 27, 2019 at 01:27:02PM +0200, Stefano Garzarella wrote:
> diff --git a/net/vmw_vsock/af_vsock.c b/net/vmw_vsock/af_vsock.c
> index c5f46b8242ce..750b62711b01 100644
> --- a/net/vmw_vsock/af_vsock.c
> +++ b/net/vmw_vsock/af_vsock.c
> @@ -416,13 +416,28 @@ int vsock_assign_transport(struct vsock_sock *vsk, =
struct vsock_sock *psk)
>  		return -ESOCKTNOSUPPORT;
>  	}
> =20
> -	if (!vsk->transport)
> +	/* We increase the module refcnt to prevent the tranport unloading

s/tranport/transport/

Otherwise:

Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>

--kunpHVz1op/+13PW
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAl2d4IEACgkQnKSrs4Gr
c8gJ2gf/fEP3ucMouPO/fhEeGplHc1JeWTI82mmjT2/LiJgxHaNqylqpIMASW19q
7nn9yxlVS1rBu7D/Os+q4CtQwAc3ea5KvmwwHgFa4v/N1Sm25jklsw/zWMyus6gw
0xc5zcifHOfttIiSKldJuRCc1nYYUnUrakwm1MJjlzB+LEIYUm2/264mLBbyxWqa
TxQBVZSI0BlpISSAry9LKNQIqZU/3gWBa1sIHT3PElSZQ5Z9be7XQciuLi84Hfag
uOky8F3zdmzG2REAu8mKuF0thOyFpPP05O2qo6GML9+ERqf1PwR2qenlTO/cMBzS
KwNQ3ydpast9dLj7idIKHuiQgTIxcQ==
=qIxu
-----END PGP SIGNATURE-----

--kunpHVz1op/+13PW--

--===============1159089283140870608==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
--===============1159089283140870608==--
