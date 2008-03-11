From: Rusty Russell <rusty@rustcorp.com.au>
Subject: [PATCH 2/4] virtio: Fix sysfs bits to have proper block symlink
Date: Tue, 11 Mar 2008 23:04:21 +1100
Message-ID: <200803112304.21680.rusty__25933.1082030714$1205237303$gmane$org@rustcorp.com.au>
References: <200803112303.22984.rusty@rustcorp.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <200803112303.22984.rusty@rustcorp.com.au>
Content-Disposition: inline
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: virtualization@lists.linux-foundation.org
Cc: Jeremy Katz <katzj@redhat.com>, linux-kernel@vger.kernel.org
List-Id: virtualization@lists.linuxfoundation.org

From: Jeremy Katz <katzj@redhat.com>

Fix up so that the virtio_blk devices in sysfs link correctly to their
block device.  This then allows them to be detected by hal, etc

Signed-off-by: Jeremy Katz <katzj@redhat.com>
Signed-off-by: Rusty Russell <rusty@rustcorp.com.au>
---
 drivers/block/virtio_blk.c |    1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/block/virtio_blk.c b/drivers/block/virtio_blk.c
index 3b1a68d..0cfbe8c 100644
--- a/drivers/block/virtio_blk.c
+++ b/drivers/block/virtio_blk.c
@@ -238,6 +238,7 @@ static int virtblk_probe(struct virtio_device *vdev)
 	vblk->disk->first_minor = index_to_minor(index);
 	vblk->disk->private_data = vblk;
 	vblk->disk->fops = &virtblk_fops;
+	vblk->disk->driverfs_dev = &vdev->dev;
 	index++;
 
 	/* If barriers are supported, tell block layer that queue is ordered */
