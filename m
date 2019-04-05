From: Stefan Hajnoczi <stefanha@gmail.com>
Subject: Re: [PATCH RFC 2/4] vhost/vsock: split packets to send using
	multiple buffers
Date: Fri, 5 Apr 2019 09:13:56 +0100
Message-ID: <20190405081356.GC25152__14894.5238137216$1554452090$gmane$org@stefanha-x1.localdomain>
References: <20190404105838.101559-1-sgarzare@redhat.com>
	<20190404105838.101559-3-sgarzare@redhat.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============6305455994114708992=="
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20190404105838.101559-3-sgarzare@redhat.com>
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


--===============6305455994114708992==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="Sr1nOIr3CvdE5hEN"
Content-Disposition: inline


--Sr1nOIr3CvdE5hEN
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Apr 04, 2019 at 12:58:36PM +0200, Stefano Garzarella wrote:
> @@ -139,8 +139,18 @@ vhost_transport_do_send_pkt(struct vhost_vsock *vsoc=
k,
>  			break;
>  		}
> =20
> -		len =3D iov_length(&vq->iov[out], in);
> -		iov_iter_init(&iov_iter, READ, &vq->iov[out], in, len);
> +		payload_len =3D pkt->len - pkt->off;
> +		iov_len =3D iov_length(&vq->iov[out], in);
> +		iov_iter_init(&iov_iter, READ, &vq->iov[out], in, iov_len);
> +
> +		/* If the packet is greater than the space available in the
> +		 * buffer, we split it using multiple buffers.
> +		 */
> +		if (payload_len > iov_len - sizeof(pkt->hdr))

Integer underflow.  iov_len is controlled by the guest and therefore
untrusted.  Please validate iov_len before assuming it's larger than
sizeof(pkt->hdr).

> -		vhost_add_used(vq, head, sizeof(pkt->hdr) + pkt->len);
> +		vhost_add_used(vq, head, sizeof(pkt->hdr) + payload_len);
>  		added =3D true;
> =20
> +		pkt->off +=3D payload_len;
> +
> +		/* If we didn't send all the payload we can requeue the packet
> +		 * to send it with the next available buffer.
> +		 */
> +		if (pkt->off < pkt->len) {
> +			spin_lock_bh(&vsock->send_pkt_list_lock);
> +			list_add(&pkt->list, &vsock->send_pkt_list);
> +			spin_unlock_bh(&vsock->send_pkt_list_lock);
> +			continue;

The virtio_transport_deliver_tap_pkt() call is skipped.  Packet capture
should see the exact packets that are delivered.  I think this patch
will present one large packet instead of several smaller packets that
were actually delivered.

--Sr1nOIr3CvdE5hEN
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJcpw5DAAoJEJykq7OBq3PIJgcIALZ1RYiVNTOBUmwCwEEblxaw
fJC/J3itodETbLSey5X8x6dJhkwH+34HkZvYoGAh/mx31OLS/Z4+BCNuUVokPHST
yd7Wa0XAzQTd6N0b826X3iwJDavCbiSJLTmTK5LNOaRX1tDY8BYKjhWHhJS4y3CG
RJfHKM9Uo0e9viKDXuCzLbR+/CX4C0nPV4/f0N7x9nfAuqIsojiLKCZqaZylKO66
4UWWnr6PuhoCqtnjzOG5OM/QRO05I7yCW3/hAN8kU3e58yPVlke4d4vGrZzBvLfS
D0z2dW6xwhG33B0p4qNkPhg1KUxd6OaR4i36OA7Qd+36sLPNCxV8Z0yGbvi++CI=
=sM71
-----END PGP SIGNATURE-----

--Sr1nOIr3CvdE5hEN--

--===============6305455994114708992==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
--===============6305455994114708992==--
