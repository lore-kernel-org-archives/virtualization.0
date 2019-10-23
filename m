From: Stefan Hajnoczi <stefanha@redhat.com>
Subject: Re: [PATCH -next] virtiofs: remove unused variable 'fc'
Date: Wed, 23 Oct 2019 15:31:12 +0100
Message-ID: <20191023143112.GF9574__7752.43335390172$1571841089$gmane$org@stefanha-x1.localdomain>
References: <20191023062130.23068-1-yuehaibing@huawei.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============7469274430740727956=="
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20191023062130.23068-1-yuehaibing@huawei.com>
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

--===============7469274430740727956==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="3oCie2+XPXTnK5a5"
Content-Disposition: inline

--3oCie2+XPXTnK5a5
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 23, 2019 at 02:21:30PM +0800, YueHaibing wrote:
> fs/fuse/virtio_fs.c:983:20: warning:
>  variable fc set but not used [-Wunused-but-set-variable]
>=20
> It is not used since commit 7ee1e2e631db ("virtiofs:
> No need to check fpq->connected state")
>=20
> Signed-off-by: YueHaibing <yuehaibing@huawei.com>
> ---
>  fs/fuse/virtio_fs.c | 2 --
>  1 file changed, 2 deletions(-)

Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>

--3oCie2+XPXTnK5a5
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAl2wZDAACgkQnKSrs4Gr
c8ia7Af+MQeFLTLG0CFTE1qP7CUS9Bb7d/kyzFLEOhRKzGeQ/X5WF82X/8onbeeS
vWxhG9VDk5YfFMxJs/kCUsOdHyqzSqfU1neF08K+wgu2RsL9LwSvppC+RM68SbUV
+2fh6BaNdKNNtfxRi8Dbw+2xqKLnqlLyhBVCqc7jIAshVMwTeV8GiDAv5WMNWEhQ
8tXKiepCviHSBWHHE0hFQaczmLQQobtgxvJOE6Ooy0Cvd8daN5f3PiCIqpUfRPTx
4ojBtmkZN3Cdc9qHM9cQmqZ/AwdtTuCeTuqd5E096I4Zqm0oq+ZiCBmlt/BSKK+t
sPTRv0L6bdGD6UztBumMJcHOyGplaA==
=Ygrg
-----END PGP SIGNATURE-----

--3oCie2+XPXTnK5a5--


--===============7469274430740727956==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
--===============7469274430740727956==--
