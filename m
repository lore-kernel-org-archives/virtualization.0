From: Ian Campbell <ijc@hellion.org.uk>
Subject: [PATCH] Implement getgeo for Xen virtual block device.
Date: Sun, 16 Dec 2007 16:35:28 +0000
Message-ID: <1197822928.16584.7.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============5922654915132123974=="
Return-path: <virtualization-bounces@lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Mime-version: 1.0
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Jeremy Fitzhardinge <jeremy@goop.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org


--===============5922654915132123974==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="=-DCbjuCcicOkgj0ArjrLc"


--=-DCbjuCcicOkgj0ArjrLc
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

Hi Jeremy,

The below implements the getgeo hook for Xen block devices. Extracted
from the xen-unstable tree where it has been used for ages.

It is useful to have because it allows things like grub2 (used by the
Debian installer images) to work in a guest domain without having to
sprinkle Xen specific hacks around the place.

Signed-off-by: Ian Campbell <ijc@hellion.org.uk>

diff --git a/drivers/block/xen-blkfront.c b/drivers/block/xen-blkfront.c
index 2bdebcb..b0a2e69 100644
--- a/drivers/block/xen-blkfront.c
+++ b/drivers/block/xen-blkfront.c
@@ -37,6 +37,7 @@
=20
 #include <linux/interrupt.h>
 #include <linux/blkdev.h>
+#include <linux/hdreg.h>
 #include <linux/module.h>
=20
 #include <xen/xenbus.h>
@@ -135,6 +136,22 @@ static void blkif_restart_queue_callback(void *arg)
 	schedule_work(&info->work);
 }
=20
+int blkif_getgeo(struct block_device *bd, struct hd_geometry *hg)
+{
+	/* We don't have real geometry info, but let's at least return
+	   values consistent with the size of the device */
+	sector_t nsect =3D get_capacity(bd->bd_disk);
+	sector_t cylinders =3D nsect;
+
+	hg->heads =3D 0xff;
+	hg->sectors =3D 0x3f;
+	sector_div(cylinders, hg->heads * hg->sectors);
+	hg->cylinders =3D cylinders;
+	if ((sector_t)(hg->cylinders + 1) * hg->heads * hg->sectors < nsect)
+		hg->cylinders =3D 0xffff;
+	return 0;
+}
+
 /*
  * blkif_queue_request
  *
@@ -939,6 +956,7 @@ static struct block_device_operations xlvbd_block_fops =
=3D
 	.owner =3D THIS_MODULE,
 	.open =3D blkif_open,
 	.release =3D blkif_release,
+	.getgeo =3D blkif_getgeo,
 };
=20



--=20
Ian Campbell

'Martyrdom' is the only way a person can become famous without ability.
		-- George Bernard Shaw

--=-DCbjuCcicOkgj0ArjrLc
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQBHZVPQM0+0qS9rzVkRApNAAKCv9Eb60CmCie2uDI0GbmToocG4NQCfcpEi
+VA2U+3GS5mbaomJejeAYaM=
=H7a/
-----END PGP SIGNATURE-----

--=-DCbjuCcicOkgj0ArjrLc--


--===============5922654915132123974==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linux-foundation.org/mailman/listinfo/virtualization
--===============5922654915132123974==--
