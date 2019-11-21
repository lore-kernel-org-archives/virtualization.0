From: Stefan Hajnoczi <stefanha@gmail.com>
Subject: Re: [PATCH net-next 5/6] vsock: use local transport when it is loaded
Date: Thu, 21 Nov 2019 09:46:14 +0000
Message-ID: <20191121094614.GC439743__30078.429651779$1574329594$gmane$org@stefanha-x1.localdomain>
References: <20191119110121.14480-1-sgarzare@redhat.com>
 <20191119110121.14480-6-sgarzare@redhat.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============4133274744528085402=="
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20191119110121.14480-6-sgarzare@redhat.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
 <mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
 <mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>
To: Stefano Garzarella <sgarzare@redhat.com>
Cc: kvm@vger.kernel.org, netdev@vger.kernel.org, Dexuan Cui <decui@microsoft.com>, linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org, Stefan Hajnoczi <stefanha@redhat.com>, "David S. Miller" <davem@davemloft.net>, Jorgen Hansen <jhansen@vmware.com>
List-Id: virtualization@lists.linuxfoundation.org


--===============4133274744528085402==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="+nBD6E3TurpgldQp"
Content-Disposition: inline


--+nBD6E3TurpgldQp
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Nov 19, 2019 at 12:01:20PM +0100, Stefano Garzarella wrote:
> @@ -420,9 +436,10 @@ int vsock_assign_transport(struct vsock_sock *vsk, struct vsock_sock *psk)
>  		new_transport = transport_dgram;
>  		break;
>  	case SOCK_STREAM:
> -		if (remote_cid <= VMADDR_CID_HOST ||
> -		    (transport_g2h &&
> -		     remote_cid == transport_g2h->get_local_cid()))
> +		if (vsock_use_local_transport(remote_cid))
> +			new_transport = transport_local;
> +		else if (remote_cid == VMADDR_CID_HOST ||
> +			 remote_cid == VMADDR_CID_HYPERVISOR)
>  			new_transport = transport_g2h;
>  		else
>  			new_transport = transport_h2g;

We used to send VMADDR_CID_RESERVED to the host.  Now we send
VMADDR_CID_RESERVED (LOCAL) to the guest when there is no
transport_local loaded?

If this is correct, is there a justification for this change?  It seems
safest to retain existing behavior.

--+nBD6E3TurpgldQp
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAl3WXOYACgkQnKSrs4Gr
c8iT+Qf9ESuEFX++6Sq/wJtYnpiX6cvGw7bvw+fxkdiksMzIPBWT6ZbC/ZrRv87z
zBMNmGrLElTPu3lN4ISYgd1gjrLn1iTTnkj/A42X5VvjEqfQYXNz84gBMP7jRcxo
XufjkgajBvxcssZgAPOAMjx/4BbGlW3cwUNoTa7oy9PCQlhBPVDvqPWSM4sQ61cP
GJ2hFaCeYTmCbYKnyrvqmoXIewMF1XAjAuuXSHz7zVlCpbHL21piJByTKAUnqL7N
6W6nMibNjso9qI0AYAOsCkFRnhIshBqRhRhO96/1ZEBmLe7kH6gXYpgScRs4IRYD
V7w4kz76mzwiZZZLiW4/K5FOBe8v9Q==
=HSd8
-----END PGP SIGNATURE-----

--+nBD6E3TurpgldQp--

--===============4133274744528085402==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
--===============4133274744528085402==--
