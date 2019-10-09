From: Stefan Hajnoczi <stefanha@gmail.com>
Subject: Re: [RFC PATCH 02/13] vsock: remove vm_sockets_get_local_cid()
Date: Wed, 9 Oct 2019 12:42:24 +0100
Message-ID: <20191009114224.GC5747__7397.14866956405$1570621359$gmane$org@stefanha-x1.localdomain>
References: <20190927112703.17745-1-sgarzare@redhat.com>
	<20190927112703.17745-3-sgarzare@redhat.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============3201932903756432392=="
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20190927112703.17745-3-sgarzare@redhat.com>
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


--===============3201932903756432392==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="ALfTUftag+2gvp1h"
Content-Disposition: inline


--ALfTUftag+2gvp1h
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Sep 27, 2019 at 01:26:52PM +0200, Stefano Garzarella wrote:
> vm_sockets_get_local_cid() is only used in virtio_transport_common.c.
> We can replace it calling the virtio_transport_get_ops() and
> using the get_local_cid() callback registered by the transport.
>=20
> Signed-off-by: Stefano Garzarella <sgarzare@redhat.com>
> ---
>  include/linux/vm_sockets.h              |  2 --
>  net/vmw_vsock/af_vsock.c                | 10 ----------
>  net/vmw_vsock/virtio_transport_common.c |  2 +-
>  3 files changed, 1 insertion(+), 13 deletions(-)

Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>

--ALfTUftag+2gvp1h
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAl2dx6AACgkQnKSrs4Gr
c8hCTQf7B7NVspFDFsnm05GLUu5jhE/dRHrC3VyeqqicE3uUMPD7T+dn+SoNtnKs
OX/U72s4FYr4zeIPdjJaH4nqrMEmX8Cl6v9T20IEH58vvEnms/9iSyj0w+FdTFD7
ob0Ggxu22UzOtKpdYjzKXO2JyzxEguYGigkvWnN+WNAlLxfI4UyruK7LGhLrngDe
1TdiSHMS/b/HDZgQVbcF8wSEg9D+yg6gJsz+CiYneq3hcTR1ezWBCVLwUmkMGm9E
WOJP23V3t0m5K+Ottl8daxdvvIh58O/y9Xsrd8G4FRAjJvpSGwiai4KPnTfAhHzQ
sLP3Xt853ipwkz1KWXmS9dg8eJEyTQ==
=k7J2
-----END PGP SIGNATURE-----

--ALfTUftag+2gvp1h--

--===============3201932903756432392==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
--===============3201932903756432392==--
