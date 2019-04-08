From: Stefan Hajnoczi <stefanha@redhat.com>
Subject: Re: [PATCH RFC 3/4] vsock/virtio: change the maximum packet size
	allowed
Date: Mon, 8 Apr 2019 16:45:05 +0100
Message-ID: <20190408154505.GA1333__49356.9232801505$1554738330$gmane$org@stefanha-x1.localdomain>
References: <20190404105838.101559-1-sgarzare@redhat.com>
	<20190404105838.101559-4-sgarzare@redhat.com>
	<20190405082447.GD25152@stefanha-x1.localdomain>
	<20190405100747.dbwi3sjaudp3d2wa@steredhat>
	<20190408093723.GP15001@stefanha-x1.localdomain>
	<20190408145531.yreyawkn5vjqj7sl@steredhat>
	<20190408105619-mutt-send-email-mst@kernel.org>
	<20190408151735.itsfswajk5ww3ejv@steredhat>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============4887620447420900260=="
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20190408151735.itsfswajk5ww3ejv@steredhat>
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


--===============4887620447420900260==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="5mCyUwZo2JvN/JJP"
Content-Disposition: inline


--5mCyUwZo2JvN/JJP
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Apr 08, 2019 at 05:17:35PM +0200, Stefano Garzarella wrote:
> On Mon, Apr 08, 2019 at 10:57:44AM -0400, Michael S. Tsirkin wrote:
> > On Mon, Apr 08, 2019 at 04:55:31PM +0200, Stefano Garzarella wrote:
> > > > Anyway, any change to this behavior requires compatibility so new g=
uest
> > > > drivers work with old vhost_vsock.ko.  Therefore we should probably=
 just
> > > > leave the limit for now.
> > >=20
> > > I understood your point of view and I completely agree with you.
> > > But, until we don't have a way to expose features/versions between gu=
est
> > > and host,
> >=20
> > Why not use the standard virtio feature negotiation mechanism for this?
> >=20
>=20
> Yes, I have this in my mind :), but I want to understand better if we can
> use virtio-net also for this mechanism.
> For now, I don't think limiting the packets to 64 KiB is a big issue.
>=20
> What do you think if I postpone this when I have more clear if we can
> use virtio-net or not? (in order to avoid duplicated work)

Yes, I agree.  VIRTIO has feature negotiation and we can use it to
change this behavior cleanly.

However, this will require a spec change and this patch series delivers
significant performance improvements that can be merged sooner than
VIRTIO spec changes.

Let's defer the max packet size change via VIRTIO feature bits.  It can
be done separately if we decide to stick to the virtio-vsock device
design and not virtio-net.

Stefan

--5mCyUwZo2JvN/JJP
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJcq2yBAAoJEJykq7OBq3PIdLwIAJ53dUbUcSZ6WgyRyiz+7o7U
fmFk32nGiRNXGrXxnisvG+Zv0azKfxYNSFi0uP4tHqxCSjNlQDs0XayhrAjeywri
ZuycR6NdulGIqUpSf74hi7beBmcj1wAzotC9aiDCNoQnQ3IqYNzkz/8FWhOQO5T6
CpfPf5EKbPOw3FBAbFNL7m6TZR3SoEb7vkMK6tnGQ+SruDFdXBr4H5XvNcoOyUbX
BK03izf4SDpjMio8782ASOF4v8OeVkDJfbP/RGWFTtLOS9fHmGDOBRNp8iQayXWt
TjAgwkEmDDinRcRXifRz7i9lHhPdfBnmJmWpyW+tHcIAy4HMC2C6WXoMb5AvRvg=
=18t+
-----END PGP SIGNATURE-----

--5mCyUwZo2JvN/JJP--

--===============4887620447420900260==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
--===============4887620447420900260==--
