From: Stefan Hajnoczi <stefanha@redhat.com>
Subject: Re: [PATCH RFC 2/4] vhost/vsock: split packets to send using
	multiple buffers
Date: Mon, 8 Apr 2019 10:28:11 +0100
Message-ID: <20190408092811.GO15001__12659.2589121842$1554715705$gmane$org@stefanha-x1.localdomain>
References: <20190404105838.101559-1-sgarzare@redhat.com>
	<20190404105838.101559-3-sgarzare@redhat.com>
	<20190405081356.GC25152@stefanha-x1.localdomain>
	<20190405093608.f2zsyxnjxcba5v6r@steredhat>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0542218831567873165=="
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20190405093608.f2zsyxnjxcba5v6r@steredhat>
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


--===============0542218831567873165==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="Sr6hGnsCY8KeifOY"
Content-Disposition: inline


--Sr6hGnsCY8KeifOY
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Apr 05, 2019 at 11:36:08AM +0200, Stefano Garzarella wrote:
> On Fri, Apr 05, 2019 at 09:13:56AM +0100, Stefan Hajnoczi wrote:
> > On Thu, Apr 04, 2019 at 12:58:36PM +0200, Stefano Garzarella wrote:
> > > -		vhost_add_used(vq, head, sizeof(pkt->hdr) + pkt->len);
> > > +		vhost_add_used(vq, head, sizeof(pkt->hdr) + payload_len);
> > >  		added =3D true;
> > > =20
> > > +		pkt->off +=3D payload_len;
> > > +
> > > +		/* If we didn't send all the payload we can requeue the packet
> > > +		 * to send it with the next available buffer.
> > > +		 */
> > > +		if (pkt->off < pkt->len) {
> > > +			spin_lock_bh(&vsock->send_pkt_list_lock);
> > > +			list_add(&pkt->list, &vsock->send_pkt_list);
> > > +			spin_unlock_bh(&vsock->send_pkt_list_lock);
> > > +			continue;
> >=20
> > The virtio_transport_deliver_tap_pkt() call is skipped.  Packet capture
> > should see the exact packets that are delivered.  I think this patch
> > will present one large packet instead of several smaller packets that
> > were actually delivered.
>=20
> I'll modify virtio_transport_build_skb() to take care of pkt->off
> and reading the payload size from the virtio_vsock_hdr.
> Otherwise, should I introduce another field in virtio_vsock_pkt to store
> the payload size?

I don't remember the details but I trust you'll pick a good way of doing
it.

Stefan

--Sr6hGnsCY8KeifOY
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJcqxQrAAoJEJykq7OBq3PIRNMH/RSv7+scItA1bhLrAepGRG8C
33Z8YoFCFwvbnEzOhreX/oBgQD2uKuXWeiuQvhnx2jEondkZcmspoTqAqA3YIr1C
3ujY9MsIfEmKoM4XLYhEnZ5bf5gZeBuWzPIWhhZJTF8N7fyIOIIV2XmFeVEOnRk0
U9PEDq3gGU50Z4Z2rmHDQIp9LswnDw2knzgQptXFRDhQh6GRql7n4d0GIMlLG1YI
AyBmxasATjVa7TYish3o7+bS1m5xXzqx7kBar1DfwLwhmn3wy4zhJKvLcjJiL9Rb
V1MiVGdVwhKcY7dlEhHd9cTpkuUQ2bXbY+WNlIX+9yByy7EMbb1Fk/Iqpdut190=
=bSSE
-----END PGP SIGNATURE-----

--Sr6hGnsCY8KeifOY--

--===============0542218831567873165==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
--===============0542218831567873165==--
