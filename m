From: Stefan Hajnoczi <stefanha@gmail.com>
Subject: Re: [PATCH RFC 1/4] vsock/virtio: reduce credit update messages
Date: Thu, 4 Apr 2019 20:15:39 +0100
Message-ID: <20190404191539.GB25152__46750.5851572909$1554405352$gmane$org@stefanha-x1.localdomain>
References: <20190404105838.101559-1-sgarzare@redhat.com>
	<20190404105838.101559-2-sgarzare@redhat.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============4912833818494942191=="
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20190404105838.101559-2-sgarzare@redhat.com>
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
Cc: kvm@vger.kernel.org, "Michael S. Tsirkin" <mst@redhat.com>, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org, Stefan Hajnoczi <stefanha@redhat.com>, "David S. Miller" <davem@davemloft.net>
List-Id: virtualization@lists.linuxfoundation.org


--===============4912833818494942191==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="aM3YZ0Iwxop3KEKx"
Content-Disposition: inline


--aM3YZ0Iwxop3KEKx
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Apr 04, 2019 at 12:58:35PM +0200, Stefano Garzarella wrote:
> @@ -256,6 +257,7 @@ virtio_transport_stream_do_dequeue(struct vsock_sock =
*vsk,
>  	struct virtio_vsock_sock *vvs =3D vsk->trans;
>  	struct virtio_vsock_pkt *pkt;
>  	size_t bytes, total =3D 0;
> +	s64 free_space;

Why s64?  buf_alloc, fwd_cnt, and last_fwd_cnt are all u32.  fwd_cnt -
last_fwd_cnt <=3D buf_alloc is always true.

>  	int err =3D -EFAULT;
> =20
>  	spin_lock_bh(&vvs->rx_lock);
> @@ -288,9 +290,15 @@ virtio_transport_stream_do_dequeue(struct vsock_sock=
 *vsk,
>  	}
>  	spin_unlock_bh(&vvs->rx_lock);
> =20
> -	/* Send a credit pkt to peer */
> -	virtio_transport_send_credit_update(vsk, VIRTIO_VSOCK_TYPE_STREAM,
> -					    NULL);
> +	/* We send a credit update only when the space available seen
> +	 * by the transmitter is less than VIRTIO_VSOCK_MAX_PKT_BUF_SIZE
> +	 */
> +	free_space =3D vvs->buf_alloc - (vvs->fwd_cnt - vvs->last_fwd_cnt);

Locking?  These fields should be accessed under tx_lock.

> +	if (free_space < VIRTIO_VSOCK_MAX_PKT_BUF_SIZE) {
> +		virtio_transport_send_credit_update(vsk,
> +						    VIRTIO_VSOCK_TYPE_STREAM,
> +						    NULL);
> +	}

--aM3YZ0Iwxop3KEKx
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJcplfbAAoJEJykq7OBq3PI2uYIALQfLRpQHKb7GaCRjoDssVSe
XlSjQ47uP6LdmnzrkmFy2QtA0UCQS8fZdFbvu4wReh9dcDk+jQAno2Xzuwv6sTzu
cJ+uknZzmMmZarWh3m4w5ooIM4p7GO8HFWbCr9Sq6nS9aAw1N1YpGjB6JvtAZJuE
vIOHRa3rZ/aQ/Xil907cKLWyXwYMWEfeAnD+ujUr5zkyQyuUrYlck7YW9gPas3c+
ClvvF+uYnvq9tf1exel6NwPvnjmtG+1aTDtIuqrv0Af/QqryUuD64UDkybOHGRlZ
4rIsRIsRZHTsyleB/oJPANE/L0bNzDfCpxvyfSBps6b5bIR4rJ8AqvRrDE+82uI=
=9/y/
-----END PGP SIGNATURE-----

--aM3YZ0Iwxop3KEKx--

--===============4912833818494942191==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
--===============4912833818494942191==--
