From: Stefan Hajnoczi <stefanha@gmail.com>
Subject: Re: [PATCH] content: Reserve virtio device ID for pstore
Date: Wed, 20 Jul 2016 10:16:59 +0100
Message-ID: <20160720091659.GF13233@stefanha-x1.localdomain>
References: <1468941217-12904-1-git-send-email-namhyung@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============5127432844463244933=="
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <1468941217-12904-1-git-send-email-namhyung@gmail.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Namhyung Kim <namhyung@gmail.com>
Cc: virtio-dev@lists.oasis-open.org, Namhyung Kim <namhyung@kernel.org>, qemu-devel@nongnu.org, kvm@vger.kernel.org, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org


--===============5127432844463244933==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="qp4W5+cUSnZs0RIF"
Content-Disposition: inline


--qp4W5+cUSnZs0RIF
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 20, 2016 at 12:13:37AM +0900, Namhyung Kim wrote:
> From: Namhyung Kim <namhyung@kernel.org>
>=20
> This patch just reserve next available device ID for pstore device
> type.  The device specification for pstore will come later.
>=20
> Signed-off-by: Namhyung Kim <namhyung@kernel.org>
> ---
>  content.tex | 2 ++
>  1 file changed, 2 insertions(+)

Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>

--qp4W5+cUSnZs0RIF
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQEcBAEBAgAGBQJXj0GLAAoJEJykq7OBq3PInJIH/jCJfA0GJLMAKgVq3gxdhj/p
E3F7jm0Goff+hm9UpjRe+fogBdfmAxZWErB+iXzvPawqCPnxX0F/rvvKygbGvUrO
vDHTCeiSV5CNHnyl+vmAFPX08/wvwLvp1epbvF0Qgp/zvJvz24xzAyBtRS2a2kWr
oOAH/cEyDyfaY+YzRRc6V8H8J3w853CGmbNGgs2ifSuBqyQtnQnvYfKpQX4oXp86
pXVRKbNV/seUwtfJU2EqA7jkwkG3dE82+4xPzRHdImr4+3VjpDfdvIAxsWY9jBJa
WZqiAl7VyR+zjsbhfVZjOjY+L+zgZQyseTGUJwGHr6PdK2bxg9unPLFFFai8EjA=
=1EpW
-----END PGP SIGNATURE-----

--qp4W5+cUSnZs0RIF--

--===============5127432844463244933==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
--===============5127432844463244933==--
