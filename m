From: Stefan Hajnoczi <stefanha@redhat.com>
Subject: Re: [PATCH v2] vhost: add vsock compat ioctl
Date: Thu, 15 Mar 2018 13:51:23 +0000
Message-ID: <20180315135123.GB7015__35663.1957729862$1521210406$gmane$org@stefanha-x1.localdomain>
References: <20180314213625.119211-1-sonnyrao@chromium.org>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============6976019908374081167=="
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20180314213625.119211-1-sonnyrao@chromium.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Sonny Rao <sonnyrao@chromium.org>
Cc: kvm@vger.kernel.org, "Michael S . Tsirkin" <mst@redhat.com>, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org


--===============6976019908374081167==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="SkvwRMAIpAhPCcCJ"
Content-Disposition: inline


--SkvwRMAIpAhPCcCJ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Mar 14, 2018 at 02:36:25PM -0700, Sonny Rao wrote:
> This will allow usage of vsock from 32-bit binaries on a 64-bit
> kernel.
>=20
> Signed-off-by: Sonny Rao <sonnyrao@chromium.org>
> ---
>  drivers/vhost/vsock.c | 11 +++++++++++
>  1 file changed, 11 insertions(+)

Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>

--SkvwRMAIpAhPCcCJ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJaqnpbAAoJEJykq7OBq3PIRW8IAMcewt0u7IxTrOAqBcWsEpGy
LinA4rdQttT81XR7oiFrzf0b+b/oaCPfW4ZNACeq3gADu4nDhIhp/ZYUKHVQh2NI
7ykw6yPm0pqIQB82mbz2LGGf3PK+0ZRhu9qTLBXhg4uDMDcWKZhD9fAm/xx0YCRS
4a2fhlFaxdK1TI4PCLB2vXnoto5aJqwHNTr9K/GOX69LHB7lMFKeMl/oLFduv2i2
BZeBj4TI8rcvgBcLEK68clN8WkBxvSu4sWiUTLGtp1bowbqPnh6Dcspt5y7is4N7
17y0mahmKrdKTGpmBN+cFsp9O7Fq0CDTH6H4vE3e+chpbaw7ieh90tTyMtZ5mKY=
=bRd3
-----END PGP SIGNATURE-----

--SkvwRMAIpAhPCcCJ--

--===============6976019908374081167==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
--===============6976019908374081167==--
