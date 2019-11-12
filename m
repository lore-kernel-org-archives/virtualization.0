From: Stefan Hajnoczi <stefanha@redhat.com>
Subject: Re: [PATCH -next] virtiofs: Fix old-style declaration
Date: Tue, 12 Nov 2019 10:33:54 +0000
Message-ID: <20191112103354.GF463128__48984.5183373959$1573554867$gmane$org@stefanha-x1.localdomain>
References: <20191111122359.43624-1-yuehaibing@huawei.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============2915682224872862672=="
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20191111122359.43624-1-yuehaibing@huawei.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: YueHaibing <yuehaibing@huawei.com>
Cc: mszeredi@redhat.com, miklos@szeredi.hu, linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org, linux-fsdevel@vger.kernel.org, vgoyal@redhat.com
List-Id: virtualization@lists.linuxfoundation.org

--===============2915682224872862672==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="eNMatiwYGLtwo1cJ"
Content-Disposition: inline

--eNMatiwYGLtwo1cJ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Nov 11, 2019 at 08:23:59PM +0800, YueHaibing wrote:
> There expect the 'static' keyword to come first in a
> declaration, and we get warnings like this with "make W=3D1":
>=20
> fs/fuse/virtio_fs.c:687:1: warning: 'static' is not at beginning of decla=
ration [-Wold-style-declaration]
> fs/fuse/virtio_fs.c:692:1: warning: 'static' is not at beginning of decla=
ration [-Wold-style-declaration]
> fs/fuse/virtio_fs.c:1029:1: warning: 'static' is not at beginning of decl=
aration [-Wold-style-declaration]
>=20
> Signed-off-by: YueHaibing <yuehaibing@huawei.com>
> ---
>  fs/fuse/virtio_fs.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)

Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>

--eNMatiwYGLtwo1cJ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAl3KipIACgkQnKSrs4Gr
c8gdJwf+PUqmtiGDYcD4HiwZZWATLMxXmETqzmnRsTSpcZmilmmFYmNPT9MNuj7D
oPRTSg2Buso6+GYt3HILA0QBHzltRPFpGHFKGFo87AMHUs8Hya8Kn/Ixtlzd2yzk
uetQbToOHQ1BXjNmm8AVmXImi8hr6HVpNGfY08rcbiiw8f5pZeKEiXwLtWc/09Kl
pkOLTnMrheeXEWt8eVMTUfGaUeEeylz3XRUdObm9Oq5hbN1DbERRV3WbNI55a96q
n+X86cFuZP2dvI82+tS5bYl+DcGYkKWrM+kAKJWiwBO9vWTN/5M9UiJmdigSIFux
i47j9PEBMtc87VtbuU9ytoi8EF51MA==
=WtV3
-----END PGP SIGNATURE-----

--eNMatiwYGLtwo1cJ--


--===============2915682224872862672==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
--===============2915682224872862672==--
