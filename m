From: Stefan Hajnoczi <stefanha@gmail.com>
Subject: Re: [RFC PATCH 06/13] vsock: add 'struct vsock_sock *' param to
	vsock_core_get_transport()
Date: Wed, 9 Oct 2019 12:54:33 +0100
Message-ID: <20191009115433.GG5747__45944.4462483347$1570622089$gmane$org@stefanha-x1.localdomain>
References: <20190927112703.17745-1-sgarzare@redhat.com>
	<20190927112703.17745-7-sgarzare@redhat.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============6907763690376517684=="
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20190927112703.17745-7-sgarzare@redhat.com>
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


--===============6907763690376517684==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="S5HS5MvDw4DmbRmb"
Content-Disposition: inline


--S5HS5MvDw4DmbRmb
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Sep 27, 2019 at 01:26:56PM +0200, Stefano Garzarella wrote:
> -const struct vsock_transport *vsock_core_get_transport(void)
> +const struct vsock_transport *vsock_core_get_transport(struct vsock_sock *vsk)
>  {
>  	/* vsock_register_mutex not taken since only the transport uses this
>  	 * function and only while registered.
>  	 */
> -	return transport_single;

This comment is about protecting transport_single.  It no longer applies
when using vsk->transport.  Please drop it.

Otherwise:

Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>

--S5HS5MvDw4DmbRmb
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAl2dyngACgkQnKSrs4Gr
c8jpGwf+OKGaK9OPf0rceIKo+5pdDJMkf+lhw9ooooqK7bZFZkqZFYhUYOP9qYqk
iPKeaY6YWLpuWMJRuh2EObxLrC1VrmfYA1lPcNXDEq6yVOloX43zrBM5Zec2GVq3
GVJHTW2tw1bTyRAtLI/zSYy9hblQlWcG6BKmK1WBNFIyQ9JLGvRqFGKobpJPP2LS
/7z3MWkRsZkFTUnJGocbhjbkZk2dLUwY9cy/IrOzfPAgX79WB7DSl7RpjH/hx7+b
M8cDi9WDJ53vRN81sXNSHg8JQA3x+DoErU3TdY1sTxSyHqcZiPgI13LXZmIw3wSS
W8aTJLNML/vAaTn6rvoGHkQXwt3Izw==
=2X/V
-----END PGP SIGNATURE-----

--S5HS5MvDw4DmbRmb--

--===============6907763690376517684==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
--===============6907763690376517684==--
