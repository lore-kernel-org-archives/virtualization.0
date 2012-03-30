From: Ren Mingxin <renmx@cn.fujitsu.com>
Subject: [PATCH 4/4] virtio_blk: use disk_name_format() to support mass of
	disks naming
Date: Fri, 30 Mar 2012 17:53:52 +0800
Message-ID: <4F7582B0.5010609__41404.1418386207$1333381119$gmane$org@cn.fujitsu.com>
References: <4F7581D4.4040301@cn.fujitsu.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <4F7581D4.4040301@cn.fujitsu.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Jens Axboe <axboe@kernel.dk>, "Michael S. Tsirkin" <mst@redhat.com>, Rusty Russell <rusty@rustcorp.com.au>, Tejun Heo <tj@kernel.org>
Cc: VIRTUAL <virtualization@lists.linux-foundation.org>, LKML <linux-kernel@vger.kernel.org>, SCSI <linux-scsi@vger.kernel.org>, KVM <kvm@vger.kernel.org>
List-Id: virtualization@lists.linuxfoundation.org

  The current virtblk's naming algorithm only supports 263  disks.
If there are mass of virtblks(exceeding 263), there will be disks
with the same name.

By renaming "sd_format_disk_name()" to "disk_name_format()"
and moving it into block core, virtio_blk can use this function to
support mass of disks.

Signed-off-by: Ren Mingxin <renmx@cn.fujitsu.com>
---
   virtio_blk.c |   13 +------------
  1 file changed, 1 insertion(+), 12 deletions(-)

diff --git a/drivers/block/virtio_blk.c b/drivers/block/virtio_blk.c
index c4a60ba..54612c2 100644
--- a/drivers/block/virtio_blk.c
+++ b/drivers/block/virtio_blk.c
@@ -442,18 +442,7 @@ static int __devinit virtblk_probe(struct 
virtio_device *vdev)

         q->queuedata = vblk;

-       if (index < 26) {
-               sprintf(vblk->disk->disk_name, "vd%c", 'a' + index % 26);
-       } else if (index < (26 + 1) * 26) {
-               sprintf(vblk->disk->disk_name, "vd%c%c",
-                       'a' + index / 26 - 1, 'a' + index % 26);
-       } else {
-               const unsigned int m1 = (index / 26 - 1) / 26 - 1;
-               const unsigned int m2 = (index / 26 - 1) % 26;
-               const unsigned int m3 =  index % 26;
-               sprintf(vblk->disk->disk_name, "vd%c%c%c",
-                       'a' + m1, 'a' + m2, 'a' + m3);
-       }
+       disk_name_format("vd", index, vblk->disk->disk_name, DISK_NAME_LEN);

         vblk->disk->major = major;
         vblk->disk->first_minor = index_to_minor(index);
