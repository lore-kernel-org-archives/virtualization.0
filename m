From: Stefan Hajnoczi <stefanha@redhat.com>
Subject: Re: [PATCH v2] scsi: virtio_scsi: unplug LUNs when events missed
Date: Fri, 6 Sep 2019 09:54:09 +0100
Message-ID: <20190906085409.GC5900__37500.8458433271$1567760064$gmane$org@stefanha-x1.localdomain>
References: <20190905181903.29756-1-mlupfer@ddn.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============8776125737915835866=="
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20190905181903.29756-1-mlupfer@ddn.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Matt Lupfer <mlupfer@ddn.com>
Cc: "linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>, "martin.petersen@oracle.com" <martin.petersen@oracle.com>, "mst@redhat.com" <mst@redhat.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "virtualization@lists.linux-foundation.org" <virtualization@lists.linux-foundation.org>, "pbonzini@redhat.com" <pbonzini@redhat.com>, "jejb@linux.ibm.com" <jejb@linux.ibm.com>
List-Id: virtualization@lists.linuxfoundation.org


--===============8776125737915835866==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="WplhKdTI2c8ulnbP"
Content-Disposition: inline


--WplhKdTI2c8ulnbP
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 05, 2019 at 06:19:28PM +0000, Matt Lupfer wrote:
> The event handler calls scsi_scan_host() when events are missed, which
> will hotplug new LUNs.  However, this function won't remove any
> unplugged LUNs.  The result is that hotunplug doesn't work properly when
> the number of unplugged LUNs exceeds the event queue size (currently 8).
>=20
> Scan existing LUNs when events are missed to check if they are still
> present.  If not, remove them.
>=20
> Signed-off-by: Matt Lupfer <mlupfer@ddn.com>
> ---
>  drivers/scsi/virtio_scsi.c | 33 +++++++++++++++++++++++++++++++++
>  1 file changed, 33 insertions(+)

Please include a changelog in future patch revisions.  For example:

  Signed-off-by: ...
  ---
  v2:
    * Replaced magic constants with sd.h constants [Michael]

Just C and virtio code review, no SCSI specifics:

Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>

--WplhKdTI2c8ulnbP
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAl1yHrEACgkQnKSrs4Gr
c8gzzAgAuYSjHn9hrs1cMsy6ox6Yq6EuWDPA1QLCT8w5U0wDuEYZNyEcXwfjz9YX
UTUP5SvIxTPY0h1xkG+xZBWzxeGSzO8+24810N6QeJJLbmXqLJT1YATxntwvp+wa
Y0pP8RmHry+TLkuq7kH87eFrp5+kml6Cxq3mTAx8ELSpikGl8GGK6SQN958+5Tgv
NfI9iko4E3c8hSbRthCUMt6ZQpJEpMIoh2DsIkFeY5OI+ZXs4uCUMqc8u9oVCDwf
sj3CrN+r27WQ5oGlXrg3MA4w9Ng6+hvpPRbhbLli4v7NeFUyswz2qJDQWM2e87Pt
vJ2fssWWXnh3m7u5LraZwstLo3ainA==
=6rpq
-----END PGP SIGNATURE-----

--WplhKdTI2c8ulnbP--

--===============8776125737915835866==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
--===============8776125737915835866==--
