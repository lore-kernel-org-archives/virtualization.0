From: Stefan Hajnoczi <stefanha@redhat.com>
Subject: Re: [PATCH v3] virtio: update the comments for transport features
Date: Thu, 7 Jun 2018 14:04:48 +0100
Message-ID: <20180607130448.GM19032__43828.9686492228$1528376594$gmane$org@stefanha-x1.localdomain>
References: <20180601112632.12651-1-tiwei.bie@intel.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============5852434016818587434=="
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20180601112632.12651-1-tiwei.bie@intel.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Tiwei Bie <tiwei.bie@intel.com>
Cc: virtio-dev@lists.oasis-open.org, mst@redhat.com, cohuck@redhat.com, linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org


--===============5852434016818587434==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="VLAOICcq5m4DWEYr"
Content-Disposition: inline


--VLAOICcq5m4DWEYr
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jun 01, 2018 at 07:26:32PM +0800, Tiwei Bie wrote:
> The existing comments for transport features are outdated.
> So update them to address the latest changes in the spec.
>=20
> Suggested-by: Michael S. Tsirkin <mst@redhat.com>
> Signed-off-by: Tiwei Bie <tiwei.bie@intel.com>
> Reviewed-by: Cornelia Huck <cohuck@redhat.com>
> ---
> This patch is generated on top of below patch:
> https://lists.oasis-open.org/archives/virtio-dev/201805/msg00212.html
>=20
> v3:
> - Fix a typo in the commit message (Cornelia);
>=20
> v2:
> - Improve the comments (Cornelia);
> - Improve the commit message;
>=20
>  include/uapi/linux/virtio_config.h | 9 ++++++---
>  1 file changed, 6 insertions(+), 3 deletions(-)

Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>

--VLAOICcq5m4DWEYr
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJbGS1wAAoJEJykq7OBq3PIsQgH/juE93zamoKrVvX0dLQqbPh7
cO+fADWB/7gWbUTAivY6zhpmxKN22QaR8OTrbJHctlS2A8NV3Ra7NOjNq9ThZEWQ
lsVF58S3PHBZVoI11pbd1FYgJvhQbBtI18wdN0VWwu2bXfL18qIEpELnfS/ePkvJ
WUx6nPt8JcqDwPwQpVyQFfRLudcg5N8RLXxTGPhSOHjyiPzfHkxvrs/Qu51W75C7
rX9K3AjauK4Rc1nebJG/u4REDJch6zBiTCqGod4cZCR4Zc/oeXQKCz02RLL8/VeR
zvfilxTYEEelkYa/+5mUDnt1tGpAssOt+Es/h0uERnxnL3haa1D+ofI8DYX+IM4=
=qMT1
-----END PGP SIGNATURE-----

--VLAOICcq5m4DWEYr--

--===============5852434016818587434==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
--===============5852434016818587434==--
