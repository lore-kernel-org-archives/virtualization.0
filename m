From: Yisheng Xie <xieyisheng1@huawei.com>
Subject: [PATCH] mm balloon: umount balloon_mnt when remove vb device
Date: Wed, 8 Feb 2017 13:21:58 +0800
Message-ID: <1486531318-35189-1-git-send-email-xieyisheng1__47667.0506330722$1486532453$gmane$org@huawei.com>
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
To: akpm@linux-foundation.org
Cc: liubo95@huawei.com, aquini@redhat.com, minchan@kernel.org, vbabka@suse.cz, mst@redhat.com, linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org, linux-mm@kvack.org, gi-oh.kim@profitbricks.com, guohanjun@huawei.com, qiuxishi@huawei.com, mhocko@kernel.org, koct9i@gmail.com
List-Id: virtualization@lists.linuxfoundation.org

With CONFIG_BALLOON_COMPACTION=y, it will mount balloon_mnt for
balloon page migration when probe a virtio_balloon device, however
do not unmount it when remove the device, fix it.

Fixes: b1123ea6d3b3 ("mm: balloon: use general non-lru movable page feature")
Signed-off-by: Yisheng Xie <xieyisheng1@huawei.com>
---
 drivers/virtio/virtio_balloon.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/virtio/virtio_balloon.c b/drivers/virtio/virtio_balloon.c
index 181793f..9d2738e 100644
--- a/drivers/virtio/virtio_balloon.c
+++ b/drivers/virtio/virtio_balloon.c
@@ -615,8 +615,12 @@ static void virtballoon_remove(struct virtio_device *vdev)
 	cancel_work_sync(&vb->update_balloon_stats_work);
 
 	remove_common(vb);
+#ifdef CONFIG_BALLOON_COMPACTION
 	if (vb->vb_dev_info.inode)
 		iput(vb->vb_dev_info.inode);
+
+	kern_unmount(balloon_mnt);
+#endif
 	kfree(vb);
 }
 
-- 
1.7.12.4
