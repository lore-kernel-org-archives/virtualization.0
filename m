From: Stefan Hajnoczi <stefanha@gmail.com>
Subject: Re: [RFC PATCH 04/13] vsock: add 'transport' member in the struct
	vsock_sock
Date: Wed, 9 Oct 2019 12:46:41 +0100
Message-ID: <20191009114641.GE5747__23129.0936748096$1570621615$gmane$org@stefanha-x1.localdomain>
References: <20190927112703.17745-1-sgarzare@redhat.com>
	<20190927112703.17745-5-sgarzare@redhat.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1895690195600032825=="
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20190927112703.17745-5-sgarzare@redhat.com>
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


--===============1895690195600032825==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="OZkY3AIuv2LYvjdk"
Content-Disposition: inline


--OZkY3AIuv2LYvjdk
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Sep 27, 2019 at 01:26:54PM +0200, Stefano Garzarella wrote:
> As a preparation to support multiple transports, this patch adds
> the 'transport' member at the 'struct vsock_sock'.
> This new field is initialized during the creation in the
> __vsock_create() function.
>=20
> This patch also renames the global 'transport' pointer to
> 'transport_single', since for now we're only supporting a single
> transport registered at run-time.
>=20
> Signed-off-by: Stefano Garzarella <sgarzare@redhat.com>
> ---
>  include/net/af_vsock.h   |  1 +
>  net/vmw_vsock/af_vsock.c | 56 +++++++++++++++++++++++++++-------------
>  2 files changed, 39 insertions(+), 18 deletions(-)

Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>

--OZkY3AIuv2LYvjdk
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAl2dyKEACgkQnKSrs4Gr
c8gl2wf9GDmxHYnnuV/4iY/UGudKy+Um/JJ6pvLVFrUG/VRJTTs7M23YLemIGqSr
G8h+cAEog9/59utW/OavWSSiV6dn3b84u74m7VrMCp4SYrYO8XbdUy0adjFAi6CT
+CeNnNORBhdA98Z8vMb4Z7oRjNF6i93S2Qb/ShDZX1K9zq1OhMNKstoZ+nrCbTOD
PP8heokQ0sC2Gh6+QOMFmG/yPufk9Yp3Ld1FN4jzxZuLnj7vS/qq8w6/m33qdkKs
O59qSocNgs90h6x7IP8dxTzfyjPIL76Pd8YeER0+WKvMubbc2tp1fyAZFXGHCf8p
8MPdEyjQYwluu8naEZY7Xp29OVNOnQ==
=2nON
-----END PGP SIGNATURE-----

--OZkY3AIuv2LYvjdk--

--===============1895690195600032825==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
--===============1895690195600032825==--
