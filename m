From: Stefan Hajnoczi <stefanha@gmail.com>
Subject: Re: [PATCH] vhost: Coalesce vq_err formats, pr_fmt misuse, add
	missing newlines
Date: Mon, 22 May 2017 15:16:46 +0100
Message-ID: <20170522141646.GC1021__87.0911092080817$1495462617$gmane$org@stefanha-x1.localdomain>
References: <0e8f84aec009831d34ccb2b4ed27364e78b07e02.1495449147.git.joe@perches.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============5684527627458542688=="
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <0e8f84aec009831d34ccb2b4ed27364e78b07e02.1495449147.git.joe@perches.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Joe Perches <joe@perches.com>
Cc: kvm@vger.kernel.org, "Michael S. Tsirkin" <mst@redhat.com>, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org


--===============5684527627458542688==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="nmemrqcdn5VTmUEE"
Content-Disposition: inline


--nmemrqcdn5VTmUEE
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, May 22, 2017 at 03:33:43AM -0700, Joe Perches wrote:
> vhost logging uses of vq_err has a few defects and style inconsistencies.
>=20
> o pr_debug already uses pr_fmt so its use in vq_err is defective
>   however no #defines of pr_fmt exist in this code so no actual
>   defects exist
> o vq_err uses need terminating newlines so add the missing ones
> o Coalesce formats and realign arguments
>=20
> Signed-off-by: Joe Perches <joe@perches.com>
> ---
>  drivers/vhost/net.c   | 17 ++++++-------
>  drivers/vhost/scsi.c  | 17 ++++++-------
>  drivers/vhost/test.c  |  4 +--
>  drivers/vhost/vhost.c | 70 +++++++++++++++++++++++----------------------=
------
>  drivers/vhost/vhost.h | 11 ++++----
>  5 files changed, 54 insertions(+), 65 deletions(-)

Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>

--nmemrqcdn5VTmUEE
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJZIvLOAAoJEJykq7OBq3PIpg4H/RfmmmtMDlNVLY6i9kHg0pQT
25bZv0Nr6PjANJzOO+UxuPYK30nlzZU7iabJ9GB9dxZiy21CKIUO7yCJbvH2Mep/
jO2pTjHVVGhdiYKa1RXqgzzelnhcRz4QZqe2ysg9e8AWbpk0w3SH1AJE2TBfSbTP
X9Ew4NTlJimLEeVLQwriQNYvOKa80SPwUL0DrvYUWOVUVtF0S8wNIXT9BQCPRHp2
m9cYMrb9FVitMIwHGcBCJoFzkIEZPWxuWyF0FR+BIk9fv9GluXvwehl941gmaxTD
d7ghA/bIlK2Z4Zb4U/oUwYJ2Eqt8/V22xj5Dt+zNpGZVW3Mxl8X/q/gkwVbWwYk=
=Wl4C
-----END PGP SIGNATURE-----

--nmemrqcdn5VTmUEE--

--===============5684527627458542688==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
--===============5684527627458542688==--
