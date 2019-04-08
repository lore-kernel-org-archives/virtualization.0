From: Stefan Hajnoczi <stefanha@redhat.com>
Subject: Re: [PATCH RFC 1/4] vsock/virtio: reduce credit update messages
Date: Mon, 8 Apr 2019 10:25:39 +0100
Message-ID: <20190408092539.GN15001__34507.7757885278$1554715552$gmane$org@stefanha-x1.localdomain>
References: <20190404105838.101559-1-sgarzare@redhat.com>
	<20190404105838.101559-2-sgarzare@redhat.com>
	<20190404191539.GB25152@stefanha-x1.localdomain>
	<20190405081648.2zflr7gxknk4q3a2@steredhat>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============2926575475199819822=="
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20190405081648.2zflr7gxknk4q3a2@steredhat>
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
Cc: kvm@vger.kernel.org, "Michael S. Tsirkin" <mst@redhat.com>, linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org, netdev@vger.kernel.org, "David S. Miller" <davem@davemloft.net>
List-Id: virtualization@lists.linuxfoundation.org


--===============2926575475199819822==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="K4LMwn8CgX2KMboP"
Content-Disposition: inline


--K4LMwn8CgX2KMboP
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Apr 05, 2019 at 10:16:48AM +0200, Stefano Garzarella wrote:
> On Thu, Apr 04, 2019 at 08:15:39PM +0100, Stefan Hajnoczi wrote:
> > On Thu, Apr 04, 2019 at 12:58:35PM +0200, Stefano Garzarella wrote:
> > >  	int err =3D -EFAULT;
> > > =20
> > >  	spin_lock_bh(&vvs->rx_lock);
> > > @@ -288,9 +290,15 @@ virtio_transport_stream_do_dequeue(struct vsock_=
sock *vsk,
> > >  	}
> > >  	spin_unlock_bh(&vvs->rx_lock);
> > > =20
> > > -	/* Send a credit pkt to peer */
> > > -	virtio_transport_send_credit_update(vsk, VIRTIO_VSOCK_TYPE_STREAM,
> > > -					    NULL);
> > > +	/* We send a credit update only when the space available seen
> > > +	 * by the transmitter is less than VIRTIO_VSOCK_MAX_PKT_BUF_SIZE
> > > +	 */
> > > +	free_space =3D vvs->buf_alloc - (vvs->fwd_cnt - vvs->last_fwd_cnt);
> >=20
> > Locking?  These fields should be accessed under tx_lock.
> >=20
>=20
> Yes, we need a lock, but looking in the code, vvs->fwd_cnd is written
> taking rx_lock (virtio_transport_dec_rx_pkt) and it is read with the
> tx_lock (virtio_transport_inc_tx_pkt).
>=20
> Maybe we should use another spin_lock shared between RX and TX for those
> fields or use atomic variables.
>=20
> What do you suggest?

Or make vvs->fwd_cnt atomic if it's the only field that needs to be
accessed in this manner.

Stefan

--K4LMwn8CgX2KMboP
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJcqxOTAAoJEJykq7OBq3PIZMYH/1TEHAKZjxIg1G2ajVhnFTbZ
OFodA0ipnYIhsKDvhulux8zPhKa/dHkxBcWAKyBmMHdQ7CuwGAGSmXl8+wvQJt91
AGkSXajUCMjW7ZBL0BLGtapphp/Rjam/9udW9YjTPHiOfOgc55h7oAHmNatTSDFF
o9vRzFlJnqvAOA+06XB4ss3hALFebZjF50+c+yk/2d6UiMLADwjjqDANmJ9e8Vbl
W4nTbFwpdLRkMn+VU8MtdJqFk+rvgvPPBRARV9wHVWS8CET8wJseU3zgDfTlajK9
/22u/jzh++RQiHJ4nExEj9o93xWEatPblEPOmhvgR633SOjouPAeAwkDQFi9gRA=
=hXkx
-----END PGP SIGNATURE-----

--K4LMwn8CgX2KMboP--

--===============2926575475199819822==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
--===============2926575475199819822==--
