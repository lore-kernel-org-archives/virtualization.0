From: Sebastian Ott <sebott@linux.vnet.ibm.com>
Subject: [PATCH] virtio_ccw: remove unsued variable
Date: Mon, 20 Oct 2014 12:48:18 +0200 (CEST)
Message-ID: <alpine.LFD.2.11.1410201242390.1601@denkbrett>
Mime-Version: 1.0
Content-Type: MULTIPART/MIXED;
	BOUNDARY="-1744217900-1223999100-1413802099=:1601"
Return-path: <virtualization-bounces@lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Rusty Russell <rusty@rustcorp.com.au>, "Michael S. Tsirkin" <mst@redhat.com>
Cc: virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

---1744217900-1223999100-1413802099=:1601
Content-Type: TEXT/PLAIN; charset=ISO-8859-7
Content-Transfer-Encoding: quoted-printable

Hi,

016c98c6f virtio: unify config_changed handling

introduced a warning in virtio_ccw which is fixed by the following patch.

Regards,
Sebastian
---
virtio_ccw: remove unsued variable

Fix this warning:
drivers/s390/kvm/virtio_ccw.c: In function =A1virtio_ccw_int_handler=A2:
drivers/s390/kvm/virtio_ccw.c:891:24: warning: unused variable =A1drv=A2 =
[-Wunused-variable]
    struct virtio_driver *drv;

Signed-off-by: Sebastian Ott <sebott@linux.vnet.ibm.com>
---
 drivers/s390/kvm/virtio_ccw.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/s390/kvm/virtio_ccw.c b/drivers/s390/kvm/virtio_ccw.=
c
index 6cbe6ef..bda52f1 100644
--- a/drivers/s390/kvm/virtio_ccw.c
+++ b/drivers/s390/kvm/virtio_ccw.c
@@ -888,7 +888,6 @@ static void virtio_ccw_int_handler(struct ccw_device =
*cdev,
 	struct virtio_ccw_device *vcdev =3D dev_get_drvdata(&cdev->dev);
 	int i;
 	struct virtqueue *vq;
-	struct virtio_driver *drv;
=20
 	if (!vcdev)
 		return;
--=20
1.8.4.2

---1744217900-1223999100-1413802099=:1601
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
---1744217900-1223999100-1413802099=:1601--
