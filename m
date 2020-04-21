From: Stefan Hajnoczi <stefanha@gmail.com>
Subject: Re: [PATCH net] vsock/virtio: postpone packet delivery to monitoring
 devices
Date: Tue, 21 Apr 2020 16:42:46 +0100
Message-ID: <20200421154246.GA47385@stefanha-x1.localdomain>
References: <20200421092527.41651-1-sgarzare@redhat.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="jRHKVT23PllUwdXP"
Return-path: <netdev-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20200421092527.41651-1-sgarzare@redhat.com>
Sender: netdev-owner@vger.kernel.org
To: Stefano Garzarella <sgarzare@redhat.com>
Cc: davem@davemloft.net, Gerard Garcia <ggarcia@abra.uab.cat>, kvm@vger.kernel.org, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org, Stefan Hajnoczi <stefanha@redhat.com>, Jakub Kicinski <kuba@kernel.org>
List-Id: virtualization@lists.linuxfoundation.org


--jRHKVT23PllUwdXP
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 21, 2020 at 11:25:27AM +0200, Stefano Garzarella wrote:
> We delivering packets to monitoring devices, before to check if
> the virtqueue has enough space.

"We [are] delivering packets" and "before to check" -> "before
checking".  Perhaps it can be rewritten as:

  Packets are delivered to monitoring devices before checking if the
  virtqueue has enough space.

>=20
> If the virtqueue is full, the transmitting packet is queued up
> and it will be sent in the next iteration. This causes the same
> packet to be delivered multiple times to monitoring devices.
>=20
> This patch fixes this issue, postponing the packet delivery
> to monitoring devices, only when it is properly queued in the

s/,//

> virqueue.

s/virqueue/virtqueue/

> @@ -137,6 +135,11 @@ virtio_transport_send_pkt_work(struct work_struct *w=
ork)
>  			break;
>  		}
> =20
> +		/* Deliver to monitoring devices all correctly transmitted
> +		 * packets.
> +		 */
> +		virtio_transport_deliver_tap_pkt(pkt);
> +

The device may see the tx packet and therefore receive a reply to it
before we can call virtio_transport_deliver_tap_pkt().  Does this mean
that replies can now appear in the packet capture before the transmitted
packet?

--jRHKVT23PllUwdXP
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAl6fFHYACgkQnKSrs4Gr
c8gyawf/T+a2xJRtBkyZjuaj7XH+djH+xU923vloo0YRur+sYDLhisPt7kU7x0E9
NXQvUSZKmd8iUUUDDBeJPpa86l7OisNvebRkWrpj1pOWKl0aOiRG7h7nsRM7+0O4
hZZ84Hpaq05u6KYAJvtwMXGBtb+Vn3m3CqLf2fEt+Z1xZ+laJhgQD66f/6/HEeVz
Y2bBrSwjULMJSzy5rGaqDAeewofwWYdK6XPnNXsOHcfcCN3a3Ioy9/GcRfx/8paa
vswqRKN0nbWhj/xk0dsWoK64CmBFZ7S2wDOztjQ6gtqZ9oG1LzMCWvv/JZADJAPX
Z64ss/NhhySeVpAIhPrpkFXBVYFuLA==
=zD+X
-----END PGP SIGNATURE-----

--jRHKVT23PllUwdXP--
