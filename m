From: Wei Wang <wei.w.wang@intel.com>
Subject: [PATCH v1 2/3] virtio-balloon: deflate up to oom_pages on OOM
Date: Fri, 20 Oct 2017 19:54:25 +0800
Message-ID: <1508500466-21165-3-git-send-email-wei.w.wang__44635.5532775216$1508501346$gmane$org@intel.com>
References: <1508500466-21165-1-git-send-email-wei.w.wang@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <1508500466-21165-1-git-send-email-wei.w.wang@intel.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: mst@redhat.com, penguin-kernel@I-love.SAKURA.ne.jp, mhocko@kernel.org, linux-kernel@vger.kernel.org, linux-mm@kvack.org, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

The current implementation only deflates 256 pages even when a user
specifies more than that via the oom_pages module param. This patch
enables the deflating of up to oom_pages pages if there are enough
inflated pages.

Signed-off-by: Wei Wang <wei.w.wang@intel.com>
Cc: Michael S. Tsirkin <mst@redhat.com>
Cc: Michal Hocko <mhocko@kernel.org>
Cc: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
---
 drivers/virtio/virtio_balloon.c | 14 +++++++++-----
 1 file changed, 9 insertions(+), 5 deletions(-)

diff --git a/drivers/virtio/virtio_balloon.c b/drivers/virtio/virtio_balloon.c
index 1ecd15a..ab55cf8 100644
--- a/drivers/virtio/virtio_balloon.c
+++ b/drivers/virtio/virtio_balloon.c
@@ -43,8 +43,8 @@
 #define OOM_VBALLOON_DEFAULT_PAGES 256
 #define VIRTBALLOON_OOM_NOTIFY_PRIORITY 80
 
-static int oom_pages = OOM_VBALLOON_DEFAULT_PAGES;
-module_param(oom_pages, int, S_IRUSR | S_IWUSR);
+static unsigned int oom_pages = OOM_VBALLOON_DEFAULT_PAGES;
+module_param(oom_pages, uint, 0600);
 MODULE_PARM_DESC(oom_pages, "pages to free on OOM");
 
 #ifdef CONFIG_BALLOON_COMPACTION
@@ -359,16 +359,20 @@ static int virtballoon_oom_notify(struct notifier_block *self,
 {
 	struct virtio_balloon *vb;
 	unsigned long *freed;
-	unsigned num_freed_pages;
+	unsigned int npages = oom_pages;
 
 	vb = container_of(self, struct virtio_balloon, nb);
 	if (!virtio_has_feature(vb->vdev, VIRTIO_BALLOON_F_DEFLATE_ON_OOM))
 		return NOTIFY_OK;
 
 	freed = parm;
-	num_freed_pages = leak_balloon(vb, oom_pages);
+
+	/* Don't deflate more than the number of inflated pages */
+	while (npages && atomic64_read(&vb->num_pages))
+		npages -= leak_balloon(vb, npages);
+
 	update_balloon_size(vb);
-	*freed += num_freed_pages;
+	*freed += oom_pages - npages;
 
 	return NOTIFY_OK;
 }
-- 
2.7.4
