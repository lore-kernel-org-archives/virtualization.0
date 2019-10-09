From: Stefan Hajnoczi <stefanha@gmail.com>
Subject: Re: [RFC PATCH 07/13] vsock: handle buffer_size sockopts in the core
Date: Wed, 9 Oct 2019 13:30:26 +0100
Message-ID: <20191009123026.GH5747__39921.3711543538$1570624246$gmane$org@stefanha-x1.localdomain>
References: <20190927112703.17745-1-sgarzare@redhat.com>
	<20190927112703.17745-8-sgarzare@redhat.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0514097252430143775=="
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20190927112703.17745-8-sgarzare@redhat.com>
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


--===============0514097252430143775==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="0XhtP95kHFp3KGBe"
Content-Disposition: inline


--0XhtP95kHFp3KGBe
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Sep 27, 2019 at 01:26:57PM +0200, Stefano Garzarella wrote:
> @@ -140,18 +145,11 @@ struct vsock_transport {
>  		struct vsock_transport_send_notify_data *);
>  	int (*notify_send_post_enqueue)(struct vsock_sock *, ssize_t,
>  		struct vsock_transport_send_notify_data *);
> +	int (*notify_buffer_size)(struct vsock_sock *, u64 *);

Is ->notify_buffer_size() called under lock_sock(sk)?  If yes, please
document it.

> +static void vsock_update_buffer_size(struct vsock_sock *vsk,
> +				     const struct vsock_transport *transport,
> +				     u64 val)
> +{
> +	if (val > vsk->buffer_max_size)
> +		val =3D vsk->buffer_max_size;
> +
> +	if (val < vsk->buffer_min_size)
> +		val =3D vsk->buffer_min_size;
> +
> +	if (val !=3D vsk->buffer_size &&
> +	    transport && transport->notify_buffer_size)
> +		transport->notify_buffer_size(vsk, &val);

Why does this function return an int if we don't check the return value?

> diff --git a/net/vmw_vsock/virtio_transport_common.c b/net/vmw_vsock/virt=
io_transport_common.c
> index fc046c071178..bac9e7430a2e 100644
> --- a/net/vmw_vsock/virtio_transport_common.c
> +++ b/net/vmw_vsock/virtio_transport_common.c
> @@ -403,17 +403,13 @@ int virtio_transport_do_socket_init(struct vsock_so=
ck *vsk,
>  	if (psk) {
>  		struct virtio_vsock_sock *ptrans =3D psk->trans;
> =20
> -		vvs->buf_size	=3D ptrans->buf_size;
> -		vvs->buf_size_min =3D ptrans->buf_size_min;
> -		vvs->buf_size_max =3D ptrans->buf_size_max;
>  		vvs->peer_buf_alloc =3D ptrans->peer_buf_alloc;
> -	} else {
> -		vvs->buf_size =3D VIRTIO_VSOCK_DEFAULT_BUF_SIZE;
> -		vvs->buf_size_min =3D VIRTIO_VSOCK_DEFAULT_MIN_BUF_SIZE;
> -		vvs->buf_size_max =3D VIRTIO_VSOCK_DEFAULT_MAX_BUF_SIZE;
>  	}
> =20
> -	vvs->buf_alloc =3D vvs->buf_size;
> +	if (vsk->buffer_size > VIRTIO_VSOCK_MAX_BUF_SIZE)
> +		vsk->buffer_size =3D VIRTIO_VSOCK_MAX_BUF_SIZE;

Hmm...this could be outside the [min, max] range.  I'm not sure how much
it matters.

Another issue is that this patch drops the VIRTIO_VSOCK_MAX_BUF_SIZE
limit that used to be enforced by virtio_transport_set_buffer_size().
Now the limit is only applied at socket init time.  If the buffer size
is changed later then VIRTIO_VSOCK_MAX_BUF_SIZE can be exceeded.  If
that doesn't matter, why even bother with VIRTIO_VSOCK_MAX_BUF_SIZE
here?


--0XhtP95kHFp3KGBe
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAl2d0uEACgkQnKSrs4Gr
c8gO1gf/Vraalf45FT85Jz4M4KTdl8jmHbCz4Q+gxBtfD8s3Wzm9XCdztbebJ5lD
OmU/wCuporLHCeVao4GUpQzpN25FoSogf5cH8jHIGU3pJOkLd7pF0KNMvpWjcETw
KwF3Kl5HHrayPHagzXF5JGb/B31pXZOpLBhs4KasERFqwOeZDDvBgsgVhrt936Jj
/w6KEb1J0i8dJ7KgM6VLynvT2gudUhmp4BFFChNacJnk1xduOIAK/rBPVL4FDKPg
pTwuT0zC8zGmmMGnnTRCmAOupCnMo8KRfkrydiJ6v093blyJ7N8sRDbKPDdU/4AD
K76VCRMrxnjuOnWPRlo2ERDIH/67qw==
=DYWp
-----END PGP SIGNATURE-----

--0XhtP95kHFp3KGBe--

--===============0514097252430143775==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
--===============0514097252430143775==--
