From: Stefan Hajnoczi <stefanha@gmail.com>
Subject: Re: [PATCH v3 2/4] vhost-vsock: add pkt cancel capability
Date: Fri, 9 Dec 2016 10:15:40 +0000
Message-ID: <20161209101540.GA18260__5297.86318443275$1481278556$gmane$org@stefanha-x1.localdomain>
References: <1481217156-7160-1-git-send-email-bergwolf@gmail.com>
	<1481217156-7160-2-git-send-email-bergwolf@gmail.com>
	<1481217156-7160-3-git-send-email-bergwolf@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============6284547678837366378=="
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <1481217156-7160-3-git-send-email-bergwolf@gmail.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Peng Tao <bergwolf@gmail.com>
Cc: kvm@vger.kernel.org, netdev@vger.kernel.org, virtualization@lists.linux-foundation.org, Stefan Hajnoczi <stefanha@redhat.com>, David Miller <davem@davemloft.net>, Jorgen Hansen <jhansen@vmware.com>
List-Id: virtualization@lists.linuxfoundation.org


--===============6284547678837366378==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="M9NhX3UHpAaciwkO"
Content-Disposition: inline


--M9NhX3UHpAaciwkO
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Dec 09, 2016 at 01:12:34AM +0800, Peng Tao wrote:
> To allow canceling all packets of a connection.
>=20
> Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
> Signed-off-by: Peng Tao <bergwolf@gmail.com>
> ---
>  drivers/vhost/vsock.c  | 41 +++++++++++++++++++++++++++++++++++++++++
>  include/net/af_vsock.h |  3 +++
>  2 files changed, 44 insertions(+)
>=20
> diff --git a/drivers/vhost/vsock.c b/drivers/vhost/vsock.c
> index a504e2e0..db64d51 100644
> --- a/drivers/vhost/vsock.c
> +++ b/drivers/vhost/vsock.c
> @@ -218,6 +218,46 @@ vhost_transport_send_pkt(struct virtio_vsock_pkt *pk=
t)
>  	return len;
>  }
> =20
> +static int
> +vhost_transport_cancel_pkt(struct vsock_sock *vsk)
> +{
> +	struct vhost_vsock *vsock;
> +	struct virtio_vsock_pkt *pkt, *n;
> +	int cnt =3D 0;
> +	LIST_HEAD(freeme);
> +
> +	/* Find the vhost_vsock according to guest context id  */
> +	vsock =3D vhost_vsock_get(vsk->remote_addr.svm_cid);
> +	if (!vsock)
> +		return -ENODEV;
> +
> +	spin_lock_bh(&vsock->send_pkt_list_lock);
> +	list_for_each_entry_safe(pkt, n, &vsock->send_pkt_list, list) {
> +		if (pkt->cancel_token !=3D (void *)vsk)

It's not necessary to cast to void* in C.  All pointers cast to void*
automatically without compiler warnings.  The warnings and explicit
casts are a C++ thing.

--M9NhX3UHpAaciwkO
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJYSoRMAAoJEJykq7OBq3PIxG8H/iBbUKbQcwvnjrU4QwZfX4zL
rl7gzJDKjE/ptLMcp62VM8RDymS/qKTp0xA2hpLablZvDYi92dJPiARpfBslBXIP
2jmwd3RJrbK+v3X8l3m18wKsWKNMYx53PPZ7P7QnqWsdglmQ6XVWj0SyZxphd87K
4EgXoKBcA4RoU1Hi4Do6t6LqgGZj55ig6RgF8YI5IK9RJnCt9Y8Wviuwcf5dPLnL
eltllvvXNDkF+mz9HMjHJiOe+HBqpsUSKLKo8QTyRh/qKaJwxU29FBuGJFnqGP/N
FtsHI1wkTgQDdjclMHw4QToVBeeLjDm34uqbAxTxn3GvoP4pajumyGPnYAZTIj0=
=+NC2
-----END PGP SIGNATURE-----

--M9NhX3UHpAaciwkO--

--===============6284547678837366378==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
--===============6284547678837366378==--
