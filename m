From: Stefan Hajnoczi <stefanha@redhat.com>
Subject: Re: [PATCH net 0/4] Prevent vhost kthread from hogging CPU
Date: Thu, 16 May 2019 10:34:50 +0100
Message-ID: <20190516093450.GR29507__38652.7636599325$1557999305$gmane$org@stefanha-x1.localdomain>
References: <1557992862-27320-1-git-send-email-jasowang@redhat.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============4962261527034497245=="
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <1557992862-27320-1-git-send-email-jasowang@redhat.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Jason Wang <jasowang@redhat.com>
Cc: kvm@vger.kernel.org, mst@redhat.com, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org, pbonzini@redhat.com
List-Id: virtualization@lists.linuxfoundation.org


--===============4962261527034497245==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="+S4DbcR7QPeSsP0V"
Content-Disposition: inline


--+S4DbcR7QPeSsP0V
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, May 16, 2019 at 03:47:38AM -0400, Jason Wang wrote:
> Hi:
>=20
> This series try to prvernt a guest triggerable CPU hogging through
> vhost kthread. This is done by introducing and checking the weight
> after each requrest. The patch has been tested with reproducer of
> vsock and virtio-net. Only compile test is done for vhost-scsi.
>=20
> Please review.
>=20
> This addresses CVE-2019-3900.
>=20
> Jason Wang (4):
>   vhost: introduce vhost_exceeds_weight()
>   vhost_net: fix possible infinite loop
>   vhost: vsock: add weight support
>   vhost: scsi: add weight support
>=20
>  drivers/vhost/net.c   | 41 ++++++++++++++---------------------------
>  drivers/vhost/scsi.c  | 21 ++++++++++++++-------
>  drivers/vhost/vhost.c | 20 +++++++++++++++++++-
>  drivers/vhost/vhost.h |  5 ++++-
>  drivers/vhost/vsock.c | 28 +++++++++++++++++++++-------
>  5 files changed, 72 insertions(+), 43 deletions(-)
>=20
> --=20
> 1.8.3.1
>=20

Looks good aside from the use-after-free in the vsock patch.

--+S4DbcR7QPeSsP0V
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAlzdLroACgkQnKSrs4Gr
c8hOGgf/TuvPxOE1Wzw+hWbX63+OyCIjKxtdlJzH3ahFiBAY+mlbhloiyLFxwFwm
Her1G3erNlR7kYao/4RMryOx0Bvz6l8iPocrRdkCimdgGuue3RN2fh1lL2kkKQny
33nIZNeWyzfD1igdQ/3Oab0o98s0Nl6orEdx6Ap3cKgBjrdRLhl72qnssF4etlve
G4k/1V8OyAQchWGqLBr4/xr0bnnA7Blx4sl18NgJn251MfZazuCk8SxffpfnZ3ni
yx6HxtZmQS3fRMCWioBVkforSNUlxURBvCnZYgWpHTP5CnQxzBPyT2NNBEpgXDvi
kYJIkiL2SbXqRNh87QZIQAu/WEyUGQ==
=JvSa
-----END PGP SIGNATURE-----

--+S4DbcR7QPeSsP0V--

--===============4962261527034497245==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
--===============4962261527034497245==--
