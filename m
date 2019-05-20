From: Stefan Hajnoczi <stefanha@redhat.com>
Subject: Re: [PATCH v2 1/8] vsock/virtio: limit the memory used per-socket
Date: Mon, 20 May 2019 09:57:31 +0100
Message-ID: <20190520085731.GA22546__37793.6276536033$1558342680$gmane$org@stefanha-x1.localdomain>
References: <20190510125843.95587-1-sgarzare@redhat.com>
	<20190510125843.95587-2-sgarzare@redhat.com>
	<20190516152533.GB29808@stefanha-x1.localdomain>
	<20190517082505.ibjkuh7zibumen77@steredhat>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============7835411519441482548=="
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20190517082505.ibjkuh7zibumen77@steredhat>
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
Cc: kvm@vger.kernel.org, "Michael S. Tsirkin" <mst@redhat.com>, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org, "David S. Miller" <davem@davemloft.net>
List-Id: virtualization@lists.linuxfoundation.org


--===============7835411519441482548==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="wRRV7LY7NUeQGEoC"
Content-Disposition: inline


--wRRV7LY7NUeQGEoC
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, May 17, 2019 at 10:25:05AM +0200, Stefano Garzarella wrote:
> On Thu, May 16, 2019 at 04:25:33PM +0100, Stefan Hajnoczi wrote:
> > On Fri, May 10, 2019 at 02:58:36PM +0200, Stefano Garzarella wrote:
> > > +static struct virtio_vsock_buf *
> > > +virtio_transport_alloc_buf(struct virtio_vsock_pkt *pkt, bool zero_c=
opy)
> > > +{
> > > +	struct virtio_vsock_buf *buf;
> > > +
> > > +	if (pkt->len =3D=3D 0)
> > > +		return NULL;
> > > +
> > > +	buf =3D kzalloc(sizeof(*buf), GFP_KERNEL);
> > > +	if (!buf)
> > > +		return NULL;
> > > +
> > > +	/* If the buffer in the virtio_vsock_pkt is full, we can move it to
> > > +	 * the new virtio_vsock_buf avoiding the copy, because we are sure =
that
> > > +	 * we are not use more memory than that counted by the credit mecha=
nism.
> > > +	 */
> > > +	if (zero_copy && pkt->len =3D=3D pkt->buf_len) {
> > > +		buf->addr =3D pkt->buf;
> > > +		pkt->buf =3D NULL;
> > > +	} else {
> > > +		buf->addr =3D kmalloc(pkt->len, GFP_KERNEL);
> >=20
> > buf and buf->addr could be allocated in a single call, though I'm not
> > sure how big an optimization this is.
> >=20
>=20
> IIUC, in the case of zero-copy I should allocate only the buf,
> otherwise I should allocate both buf and buf->addr in a single call
> when I'm doing a full-copy.
>=20
> Is it correct?

Yes, but it's your choice whether optimization is worthwhile.  If it
increases the complexity of the code and doesn't result in a measurable
improvement, then it's not worth it.

Stefan

--wRRV7LY7NUeQGEoC
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAlzia/sACgkQnKSrs4Gr
c8j8/Qf+NOeZJ2tO8MN+lVvjuwE3gShPAFPc2joqHrqQkZPrfOMHyxNPWBjmd06G
mJaov5ZMGAQQdvkkJatcCbnrnV2IuYLbZyGpfQAGrjVZ4S5RtU8/2VpksfxRJNDV
KrRPS/HoPQrDfJcMnsRxXSpf0dFcG/WptgKFMOlzLPAKiwWZ62dpc/m8ghrHXbzz
/x/TaT4NA9m4S3NwFqZYq/kTQwiXtrSU40sPo/QGk6Wn5o4sTcgNDEveJK3KsLI+
p8KQrt7muGMn9FbRrLjwq2VytiLXksXrdFAeWugUon0qEkmxaKiUSNvbgof0/qi3
4DwGQi4FYh6hvSyjckKOVP/y/F8jSg==
=1IhX
-----END PGP SIGNATURE-----

--wRRV7LY7NUeQGEoC--

--===============7835411519441482548==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
--===============7835411519441482548==--
