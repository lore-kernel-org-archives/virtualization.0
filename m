From: Stefan Hajnoczi <stefanha@redhat.com>
Subject: Re: [PATCH 13/18] virtiofs: Do not access virtqueue in request
	submission path
Date: Fri, 6 Sep 2019 12:52:41 +0100
Message-ID: <20190906115241.GU5900__46687.6809181244$1567770779$gmane$org@stefanha-x1.localdomain>
References: <20190905194859.16219-1-vgoyal@redhat.com>
	<20190905194859.16219-14-vgoyal@redhat.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============8288909688578011247=="
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20190905194859.16219-14-vgoyal@redhat.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Vivek Goyal <vgoyal@redhat.com>
Cc: miklos@szeredi.hu, mst@redhat.com, linux-kernel@vger.kernel.org, dgilbert@redhat.com, virtio-fs@redhat.com, linux-fsdevel@vger.kernel.org, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org


--===============8288909688578011247==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="iBHcHRCIarfY7C0j"
Content-Disposition: inline


--iBHcHRCIarfY7C0j
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 05, 2019 at 03:48:54PM -0400, Vivek Goyal wrote:
> In request submission path it is possible that virtqueue is already gone
> due to driver->remove(). So do not access it in dev_dbg(). Use pr_debug()
> instead.
>=20
> If virtuqueue is gone, this will result in NULL pointer deference.
>=20
> Signed-off-by: Vivek Goyal <vgoyal@redhat.com>
> ---
>  fs/fuse/virtio_fs.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)

Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>

--iBHcHRCIarfY7C0j
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAl1ySIkACgkQnKSrs4Gr
c8gXMQf/QUTibXMbQdKidGB1Vqv7pi+fendYycKROG3QMPsuTAtmXYzqvaPyQ+V7
IQKRcXkPStzxee3RJePDleTtTNsjDlsuLgfpvgh0Bik7ZTOfN7ddHzXvcBx2VDJf
OtV+D2N9Cm2YkI1r2OEVWylqmv9aH83xFJHj5hsc7vNO+yu9V+7TA+RZKasdT1GX
zd/W2E4xlYS/vz9fKRX7QReLWIla2yJVy7Qb6MECtMGELGmq02OdzsO5SJWX52cG
gSh58Gw1wIyidQXqTbEkl+gNMORVs3xtNvlIXNyEcXjvaVZzRCAdq3UGVAFL2C7x
LeqWw3/P3WTKxDZwTHLyAwoo2fpnpg==
=cLla
-----END PGP SIGNATURE-----

--iBHcHRCIarfY7C0j--

--===============8288909688578011247==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
--===============8288909688578011247==--
