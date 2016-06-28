From: Fam Zheng <famz@redhat.com>
Subject: [PATCH] virtio-blk: Generate uevent after attribute available
Date: Tue, 28 Jun 2016 10:39:15 +0800
Message-ID: <20160628023915.6012-1-famz@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
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
To: linux-kernel@vger.kernel.org
Cc: virtualization@lists.linux-foundation.org, famz@redhat.com, "Michael S. Tsirkin" <mst@redhat.com>
List-Id: virtualization@lists.linuxfoundation.org

Userspace listens to the KOBJ_ADD uevent generated in add_disk. At that
point we haven't created the serial attribute file, therefore depending
on how fast udev reacts, the /dev/disk/by-id/ entry doesn't always get
created.

This race condition can be easily reproduced by hot plugging a number of
virtio-blk disks.

Also in systemd, there used to be a related workaround in udev rules
called 'WAIT_FOR="serial"', but it is removed in later versions.

Now let's generate a KOBJ_CHANGE event after the attributes are ready.

Signed-off-by: Fam Zheng <famz@redhat.com>
---
 drivers/block/virtio_blk.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/block/virtio_blk.c b/drivers/block/virtio_blk.c
index 42758b5..5056007 100644
--- a/drivers/block/virtio_blk.c
+++ b/drivers/block/virtio_blk.c
@@ -567,6 +567,7 @@ static int virtblk_probe(struct virtio_device *vdev)
 {
 	struct virtio_blk *vblk;
 	struct request_queue *q;
+	struct device *ddev;
 	int err, index;
 
 	u64 cap;
@@ -746,6 +747,8 @@ static int virtblk_probe(struct virtio_device *vdev)
 					 &dev_attr_cache_type_ro);
 	if (err)
 		goto out_del_disk;
+	ddev = disk_to_dev(vblk->disk);
+	kobject_uevent(&ddev->kobj, KOBJ_CHANGE);
 	return 0;
 
 out_del_disk:
-- 
2.9.0
