From: Markus Elfring <Markus.Elfring@web.de>
Subject: [PATCH] virtio-mmio: Delete an error message in vm_find_vqs()
Date: Sun, 5 Apr 2020 19:19:34 +0200
Message-ID: <9e27bc4a-cfa1-7818-dc25-8ad308816b30@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: virtualization@lists.linux-foundation.org, Jason Wang <jasowang@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>
Cc: LKML <linux-kernel@vger.kernel.org>, kernel-janitors@vger.kernel.org, Tang Bin <tangbin@cmss.chinamobile.com>
List-Id: virtualization@lists.linuxfoundation.org

From: Markus Elfring <elfring@users.sourceforge.net>
Date: Sun, 5 Apr 2020 19:14:10 +0200

The function =E2=80=9Cplatform_get_irq=E2=80=9D can log an error already.
Thus omit a redundant message for the exception handling in the
calling function.

This issue was detected by using the Coccinelle software.

Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
=2D--
 drivers/virtio/virtio_mmio.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/virtio/virtio_mmio.c b/drivers/virtio/virtio_mmio.c
index 97d5725fd9a2..9d16aaffca9d 100644
=2D-- a/drivers/virtio/virtio_mmio.c
+++ b/drivers/virtio/virtio_mmio.c
@@ -466,10 +466,8 @@ static int vm_find_vqs(struct virtio_device *vdev, un=
signed nvqs,
 	int irq =3D platform_get_irq(vm_dev->pdev, 0);
 	int i, err, queue_idx =3D 0;

-	if (irq < 0) {
-		dev_err(&vdev->dev, "Cannot get IRQ resource\n");
+	if (irq < 0)
 		return irq;
-	}

 	err =3D request_irq(irq, vm_interrupt, IRQF_SHARED,
 			dev_name(&vdev->dev), vm_dev);
=2D-
2.26.0
