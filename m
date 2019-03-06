From: Stefan Hajnoczi <stefanha@gmail.com>
Subject: Re: [PATCH] vsock/virtio: fix kernel panic from
	virtio_transport_reset_no_sock
Date: Wed, 6 Mar 2019 08:41:04 +0000
Message-ID: <20190306084104.GA22159__21586.5608699218$1551861709$gmane$org@stefanha-x1.localdomain>
References: <20190305180145.27161-1-alazar@bitdefender.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============8569720193183309035=="
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20190305180145.27161-1-alazar@bitdefender.com>
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
Cc: kvm@vger.kernel.org, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org, Stefan Hajnoczi <stefanha@redhat.com>, "David S . Miller" <davem@davemloft.net>, Stefano Garzarella <sgarzare@redhat.com>
List-Id: virtualization@lists.linuxfoundation.org


--===============8569720193183309035==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="HcAYCG3uE/tztfnV"
Content-Disposition: inline


--HcAYCG3uE/tztfnV
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 05, 2019 at 08:01:45PM +0200, Adalbert Laz=C4=83r wrote:

Thanks for the patch, Adalbert!  Please add a Signed-off-by tag so your
patch can be merged (see Documentation/process/submitting-patches.rst
Chapter 11 for details on the Developer's Certificate of Origin).

>  static int virtio_transport_reset_no_sock(struct virtio_vsock_pkt *pkt)
>  {
> +	const struct virtio_transport *t;
>  	struct virtio_vsock_pkt_info info =3D {
>  		.op =3D VIRTIO_VSOCK_OP_RST,
>  		.type =3D le16_to_cpu(pkt->hdr.type),
> @@ -680,7 +681,11 @@ static int virtio_transport_reset_no_sock(struct vir=
tio_vsock_pkt *pkt)
>  	if (!pkt)
>  		return -ENOMEM;
> =20
> -	return virtio_transport_get_ops()->send_pkt(pkt);
> +	t =3D virtio_transport_get_ops();
> +	if (!t)
> +		return -ENOTCONN;

pkt is leaked here.  This is an easy mistake to make because the code is
unclear.  The pkt argument is the received packet that we must reply to.
The reply packet is allocated just before line 680 and must be free
explicitly for return -ENOTCONN.

You can avoid the leak and make the code easier to read like this:

  struct virtio_vsock_pkt *reply;

  ...

     ------ avoid reusing 'pkt'
    v
  reply =3D virtio_transport_alloc_pkt(&info, 0, ...);
  if (!reply)
      return -ENOMEM;

  t =3D virtio_transport_get_ops();
  if (!t) {
      virtio_transport_free_pkt(reply); <-- prevent memory leak
      return -ENOTCONN;
  }
  return t->send_pkt(reply);

Stefan

--HcAYCG3uE/tztfnV
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJcf4efAAoJEJykq7OBq3PIkjwIAMq2n+AiAjkQ7wqlpb1kDkHv
b+A8ugno/BLAsZXuNFMgSPmbh6JBJ1B5KEwKLJHOcNlgyYsfjvASDTaL+fb3sHsx
Hoxv/QITZrd5dEDIyuOZFyDcxqhhnweSg/R5ehRBxmM+/beluWKg9/sbCA4CcORZ
zw136cmFZr4NOTzsSPMDKCubtNNLNhKIv+mRAXKJDMAqys0jd6mQVCCbY8CeZH2F
cYZRwyQW7r0sZvS//OFEZtB+crBZz+TzjibD2K82sz4pPzviJkWl30CA4NDFdOT+
jeRb05o1DqalP5HOHuCCfwnSCcdL30TaLvKJv29uBsgX4MmqyQ5QFjBmUyx6cPI=
=SlL5
-----END PGP SIGNATURE-----

--HcAYCG3uE/tztfnV--

--===============8569720193183309035==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
--===============8569720193183309035==--
