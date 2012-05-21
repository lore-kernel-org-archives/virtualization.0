From: Asias He <asias@redhat.com>
Subject: [RFC PATCH 3/5] virtio-blk: Call del_gendisk() before disable guest
	kick
Date: Mon, 21 May 2012 17:08:31 +0800
Message-ID: <1337591313-26333-3-git-send-email-asias@redhat.com>
References: <1337591313-26333-1-git-send-email-asias@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <1337591313-26333-1-git-send-email-asias@redhat.com>
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
Cc: kvm@vger.kernel.org, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

del_gendisk() might not return due to failing to remove the
/sys/block/vda/serial sysfs entry when another thread (udev) is
trying to read it.

virtblk_remove()
  vdev->config->reset() : guest will not kick us through interrupt
    del_gendisk()
      device_del()
        kobject_del(): got stuck, sysfs entry ref count non zero

sysfs_open_file(): user space process read /sys/block/vda/serial
   sysfs_get_active() : got sysfs entry ref count
      dev_attr_show()
        virtblk_serial_show()
           blk_execute_rq() : got stuck, interrupt is disabled
                              request cannot be finished

This patch fixes it by calling del_gendisk() before we disable guest's
interrupt so that the request sent in virtblk_serial_show() will be
finished and del_gendisk() will success.

This fixes another race in hot-unplug process.

It is save to call del_gendisk(vblk->disk) before
flush_work(&vblk->config_work) which might access vblk->disk, because
vblk->disk is not freed until put_disk(vblk->disk).

Cc: Rusty Russell <rusty@rustcorp.com.au>
Cc: "Michael S. Tsirkin" <mst@redhat.com>
Cc: virtualization@lists.linux-foundation.org
Cc: kvm@vger.kernel.org
Signed-off-by: Asias He <asias@redhat.com>
---
 drivers/block/virtio_blk.c |    3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/block/virtio_blk.c b/drivers/block/virtio_blk.c
index 693187d..7d5f5b0 100644
--- a/drivers/block/virtio_blk.c
+++ b/drivers/block/virtio_blk.c
@@ -584,12 +584,13 @@ static void __devexit virtblk_remove(struct virtio_device *vdev)
 	vblk->config_enable = false;
 	mutex_unlock(&vblk->config_lock);
 
+	del_gendisk(vblk->disk);
+
 	/* Stop all the virtqueues. */
 	vdev->config->reset(vdev);
 
 	flush_work(&vblk->config_work);
 
-	del_gendisk(vblk->disk);
 
 	/* Abort requests dispatched to driver. */
 	spin_lock_irqsave(&vblk->lock, flags);
-- 
1.7.10.1
