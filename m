From: SF Markus Elfring <elfring@users.sourceforge.net>
Subject: [PATCH 1/3] s390: virtio: Delete error messages for failed memory
	allocations in two functions
Date: Tue, 16 May 2017 17:51:57 +0200
Message-ID: <78b6667b-69c4-39c5-7e1b-1b69ae983695__37081.4838716344$1494950243$gmane$org@users.sourceforge.net>
References: <d02fd34c-da59-0c33-d859-e49ecb4eb1c5@users.sourceforge.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <d02fd34c-da59-0c33-d859-e49ecb4eb1c5@users.sourceforge.net>
Content-Language: en-US
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: kvm@vger.kernel.org, linux-s390@vger.kernel.org, virtualization@lists.linux-foundation.org, Cornelia Huck <cornelia.huck@de.ibm.com>, Halil Pasic <pasic@linux.vnet.ibm.com>, Heiko Carstens <heiko.carstens@de.ibm.com>, Martin Schwidefsky <schwidefsky@de.ibm.com>
Cc: kernel-janitors@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>, Wolfram Sang <wsa@the-dreams.de>
List-Id: virtualization@lists.linuxfoundation.org

From: Markus Elfring <elfring@users.sourceforge.net>
Date: Tue, 16 May 2017 16:50:17 +0200

Omit three extra messages for memory allocation failures in these functions.

This issue was detected by using the Coccinelle software.

Link: http://events.linuxfoundation.org/sites/events/files/slides/LCJ16-Refactor_Strings-WSang_0.pdf
Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
---
 drivers/s390/virtio/virtio_ccw.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/drivers/s390/virtio/virtio_ccw.c b/drivers/s390/virtio/virtio_ccw.c
index 2a76ea78a0bf..447fe718c0ab 100644
--- a/drivers/s390/virtio/virtio_ccw.c
+++ b/drivers/s390/virtio/virtio_ccw.c
@@ -499,12 +499,10 @@ static struct virtqueue *virtio_ccw_setup_vq(struct virtio_device *vdev,
 	if (!info) {
-		dev_warn(&vcdev->cdev->dev, "no info\n");
 		err = -ENOMEM;
 		goto out_err;
 	}
 	info->info_block = kzalloc(sizeof(*info->info_block),
 				   GFP_DMA | GFP_KERNEL);
 	if (!info->info_block) {
-		dev_warn(&vcdev->cdev->dev, "no info block\n");
 		err = -ENOMEM;
 		goto out_err;
 	}
@@ -1225,7 +1223,6 @@ static int virtio_ccw_online(struct ccw_device *cdev)
 
 	vcdev = kzalloc(sizeof(*vcdev), GFP_KERNEL);
 	if (!vcdev) {
-		dev_warn(&cdev->dev, "Could not get memory for virtio\n");
 		ret = -ENOMEM;
 		goto out_free;
 	}
-- 
2.13.0
