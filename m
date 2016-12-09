From: Stefan Hajnoczi <stefanha@gmail.com>
Subject: Re: [PATCH v3 0/4] vsock: cancel connect packets when failing to
	connect
Date: Fri, 9 Dec 2016 10:18:42 +0000
Message-ID: <20161209101842.GD18260__16826.4335058213$1481278735$gmane$org@stefanha-x1.localdomain>
References: <1481217156-7160-1-git-send-email-bergwolf@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============7492907798452739757=="
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <1481217156-7160-1-git-send-email-bergwolf@gmail.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Peng Tao <bergwolf@gmail.com>
Cc: kvm@vger.kernel.org, netdev@vger.kernel.org, virtualization@lists.linux-foundation.org, Stefan Hajnoczi <stefanha@redhat.com>, David Miller <davem@davemloft.net>, Jorgen Hansen <jhansen@vmware.com>
List-Id: virtualization@lists.linuxfoundation.org


--===============7492907798452739757==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="ZARJHfwaSJQLOEUz"
Content-Disposition: inline


--ZARJHfwaSJQLOEUz
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Dec 09, 2016 at 01:12:32AM +0800, Peng Tao wrote:
> Currently, if a connect call fails on a signal or timeout (e.g., guest is=
 still
> in the process of starting up), we'll just return to caller and leave the=
 connect
> packet queued and they are sent even though the connection is considered =
a failure,
> which can confuse applications with unwanted false connect attempt.
>=20
> The patchset enables vsock (both host and guest) to cancel queued packets=
 when
> a connect attempt is considered to fail.
>=20
> v3 changelog:
>   - define cancel_pkt callback in struct vsock_transport rather than stru=
ct virtio_transport
>   - rename virtio_vsock_pkt->vsk to virtio_vsock_pkt->cancel_token
> v2 changelog:
>   - fix queued_replies counting and resume tx/rx when necessary
>=20
>=20
> Peng Tao (4):
>   vsock: track pkt owner vsock
>   vhost-vsock: add pkt cancel capability
>   vsock: add pkt cancel capability
>   vsock: cancel packets when failing to connect
>=20
>  drivers/vhost/vsock.c                   | 41 +++++++++++++++++++++++++++=
+++++
>  include/linux/virtio_vsock.h            |  2 ++
>  include/net/af_vsock.h                  |  3 +++
>  net/vmw_vsock/af_vsock.c                | 14 +++++++++++
>  net/vmw_vsock/virtio_transport.c        | 42 +++++++++++++++++++++++++++=
++++++
>  net/vmw_vsock/virtio_transport_common.c |  7 ++++++
>  6 files changed, 109 insertions(+)

I'm happy although I pointed out two unnecessary (void*) casts.

Please wait for Jorgen to go happy on the af_vsock.c changes before
applying.

--ZARJHfwaSJQLOEUz
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJYSoUCAAoJEJykq7OBq3PIQjEIAKYl8LmOU9lG6p9P9A2VMZzV
WB82TJlV+XtLxgee1RvrmtxZe0fxYcoSUHcsl6V5XSbF2QKN60iGgWq9bMNCIZ2Z
dmU5O96qOcINs86Scslb9sfWQegI0Vt9A5fs7w0LfMNTjxGJFoPLSFnZ5xLUy90e
AKQs9oiRBbZQcvRvefTs3eSRqC8Y8REc7b9vXslAdeCP+3QAAoCt2K7oNGOnvxDa
Wp/UC1JJuxcN2THuV13Mfp0kgcBNHiksbw/RIawVIVzfOsSxB+gSO2N4hizq8pP+
iK4tNNNIVj10EjFhLcYg7/6At5MrkpvjsEwL8hL7XlTkfTrMe65LcXWSdfvHkFk=
=IbrC
-----END PGP SIGNATURE-----

--ZARJHfwaSJQLOEUz--

--===============7492907798452739757==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
--===============7492907798452739757==--
