From: Stefan Hajnoczi <stefanha@redhat.com>
Subject: Re: [PATCH] vsock/virtio: fix kernel panic from
	virtio_transport_reset_no_sock
Date: Wed, 6 Mar 2019 17:02:16 +0000
Message-ID: <20190306170216.GC29057__4287.97203801281$1551891757$gmane$org@stefanha-x1.localdomain>
References: <20190305180145.27161-1-alazar@bitdefender.com>
	<20190306084104.GA22159@stefanha-x1.localdomain>
	<1551863441.5559.19509.@c1753101230bd75c4bdbfe8f0947046bcaf69c6c>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============6418305306077918485=="
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <1551863441.5559.19509.@c1753101230bd75c4bdbfe8f0947046bcaf69c6c>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Adalbert =?utf-8?B?TGF6xINy?= <alazar@bitdefender.com>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org, netdev@vger.kernel.org, "David S . Miller" <davem@davemloft.net>, Stefano Garzarella <sgarzare@redhat.com>
List-Id: virtualization@lists.linuxfoundation.org


--===============6418305306077918485==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="oJ71EGRlYNjSvfq7"
Content-Disposition: inline


--oJ71EGRlYNjSvfq7
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Mar 06, 2019 at 11:10:41AM +0200, Adalbert Laz=C4=83r wrote:
> On Wed, 6 Mar 2019 08:41:04 +0000, Stefan Hajnoczi <stefanha@gmail.com> w=
rote:
> > On Tue, Mar 05, 2019 at 08:01:45PM +0200, Adalbert Laz=C4=83r wrote:
> > The pkt argument is the received packet that we must reply to.
> > The reply packet is allocated just before line 680 and must be free
> > explicitly for return -ENOTCONN.
> >=20
> > You can avoid the leak and make the code easier to read like this:
> >=20
> >   struct virtio_vsock_pkt *reply;
> >=20
> >   ...
> >=20
> >      ------ avoid reusing 'pkt'
> >     v
> >   reply =3D virtio_transport_alloc_pkt(&info, 0, ...);
> >   if (!reply)
> >       return -ENOMEM;
> >=20
> >   t =3D virtio_transport_get_ops();
> >   if (!t) {
> >       virtio_transport_free_pkt(reply); <-- prevent memory leak
> >       return -ENOTCONN;
> >   }
> >   return t->send_pkt(reply);
>=20
> What do you think about Stefano's suggestion, to move the check above
> the line were the reply is allocated?

That's fine too.

However a follow up patch to eliminate the confusing way that 'pkt' is
reused is still warranted.  If you are busy I'd be happy to send that
cleanup.

Stefan

--oJ71EGRlYNjSvfq7
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJcf/0YAAoJEJykq7OBq3PIs3AH/1reh3MukS2CTzKwSmGQGqBN
Ps+VDdzKgn+h+Rmr9t6vj3wrJI7T8omxUwcZzXjz45cJyY4UnqynrwvayMzZSLxi
V817uV3GAMrlRJzTQdnl5M5UEW7h6gdkOexKl92eUU5cl+H0SUhb8oeOhL+9SY7X
nuEaEQVfRiDeBGC62oUTfwwIVAQlkKyoLhE649PKl2lpP1UA+JwSaBFVQ/7RzLBo
fPK33EceZifQh95nd4vr6TZhBbu3F4wC44illc46C9i9yYLvHz7RmXoHOteXuNVP
TNLgyoLUMwiz7RCGn016JJ9MFCQBL7rA/JNuS4fo5DE2+ihx8kp8i58VnMEvPrs=
=nvm3
-----END PGP SIGNATURE-----

--oJ71EGRlYNjSvfq7--

--===============6418305306077918485==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
--===============6418305306077918485==--
