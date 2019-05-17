From: Stefan Hajnoczi <stefanha@gmail.com>
Subject: Re: [PATCH V2 0/4] Prevent vhost kthread from hogging CPU
Date: Fri, 17 May 2019 10:10:54 +0100
Message-ID: <20190517091054.GE3679__29213.0148083501$1558084267$gmane$org@stefanha-x1.localdomain>
References: <1558067392-11740-1-git-send-email-jasowang@redhat.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============5855275875370286018=="
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <1558067392-11740-1-git-send-email-jasowang@redhat.com>
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
Cc: kvm@vger.kernel.org, mst@redhat.com, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org, stefanha@redhat.com, pbonzini@redhat.com
List-Id: virtualization@lists.linuxfoundation.org


--===============5855275875370286018==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="ytoMbUMiTKPMT3hY"
Content-Disposition: inline


--ytoMbUMiTKPMT3hY
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, May 17, 2019 at 12:29:48AM -0400, Jason Wang wrote:
> Hi:
>=20
> This series try to prevent a guest triggerable CPU hogging through
> vhost kthread. This is done by introducing and checking the weight
> after each requrest. The patch has been tested with reproducer of
> vsock and virtio-net. Only compile test is done for vhost-scsi.
>=20
> Please review.
>=20
> This addresses CVE-2019-3900.
>=20
> Changs from V1:
> - fix user-ater-free in vosck patch
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
> _______________________________________________
> Virtualization mailing list
> Virtualization@lists.linux-foundation.org
> https://lists.linuxfoundation.org/mailman/listinfo/virtualization

Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>

--ytoMbUMiTKPMT3hY
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAlzeep4ACgkQnKSrs4Gr
c8iNjggAneRqHvB02eyRBli2HesL5fARqNFQbAFYGE3ABJtYfF1NDOnIwXI1t5Bt
BassfyZocyhGcUX5kzLujRenaH0Yponx/sp7aDcA3EzH8gwyjdFAlozMSO5Mo/1M
Tq48N/3dHRew7HDCyR83slVKuuaYch4HBtn/K8XAe+HaDAEcdGx8tGAoieeBd1fH
jt7U2G0upIpOGhR1HOtHIZJ6llJU888Xj/l9EySxcXcoApQgaTV1Ta3oR2Sml3ts
WrSc06MuGo/2kKevVAW+qWvqLWk01rIhUWF1IH8+FGUkrPY/QZQDay+muNVXrD7m
/Zp2SmuE+tdA+yhwHfGEWgMsIDspGA==
=Dchs
-----END PGP SIGNATURE-----

--ytoMbUMiTKPMT3hY--

--===============5855275875370286018==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
--===============5855275875370286018==--
