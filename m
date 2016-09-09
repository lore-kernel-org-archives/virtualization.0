From: "Denis V. Lunev" <den@openvz.org>
Subject: [PATCH 1/1] balloon: stop inflate balloon after oom notification
Date: Fri,  9 Sep 2016 16:54:44 +0300
Message-ID: <1473429284-26441-1-git-send-email-den__14994.2084368833$1473430268$gmane$org@openvz.org>
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
Cc: "Denis V . Lunev" <den@openvz.org>, Konstantin Neumoin <kneumoin@virtuozzo.com>, "Michael S . Tsirkin" <mst@redhat.com>, linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

From: Konstantin Neumoin <kneumoin@virtuozzo.com>

At this moment oom notification in balloon does not work as expected.
After virtballoon_oom_notify there is an infinitive loop:
 - virtballoon_oom_notify was called and balloon was deflated
 - balloon get notification that config was changed, compare target and
   actual and try to reach target again.

This patch adds global variable fail_counter which indicates that oom has
been happened. We check that fail_counter was changed between calls
update_balloon_size_func. In this case we should not try to inflate balloon
even if actual != target.

Signed-off-by: Konstantin Neumoin <kneumoin@virtuozzo.com>
Signed-off-by: Denis V. Lunev <den@openvz.org>
CC: Michael S. Tsirkin <mst@redhat.com>
---
 drivers/virtio/virtio_balloon.c | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/drivers/virtio/virtio_balloon.c b/drivers/virtio/virtio_balloon.c
index 4e7003d..253bf05 100644
--- a/drivers/virtio/virtio_balloon.c
+++ b/drivers/virtio/virtio_balloon.c
@@ -50,6 +50,8 @@ MODULE_PARM_DESC(oom_pages, "pages to free on OOM");
 static struct vfsmount *balloon_mnt;
 #endif
 
+static unsigned long fail_count;
+
 struct virtio_balloon {
 	struct virtio_device *vdev;
 	struct virtqueue *inflate_vq, *deflate_vq, *stats_vq;
@@ -361,6 +363,8 @@ static int virtballoon_oom_notify(struct notifier_block *self,
 	unsigned long *freed;
 	unsigned num_freed_pages;
 
+	fail_count++;
+
 	vb = container_of(self, struct virtio_balloon, nb);
 	if (!virtio_has_feature(vb->vdev, VIRTIO_BALLOON_F_DEFLATE_ON_OOM))
 		return NOTIFY_OK;
@@ -386,11 +390,22 @@ static void update_balloon_size_func(struct work_struct *work)
 {
 	struct virtio_balloon *vb;
 	s64 diff;
+	static unsigned long fc;
+
+	if (fc == 0)
+		fc = fail_count;
 
 	vb = container_of(work, struct virtio_balloon,
 			  update_balloon_size_work);
 	diff = towards_target(vb);
 
+	if (fc != fail_count) {
+		fc = fail_count;
+		/* Don't inflate balloon after oom notification */
+		if (diff > 0)
+			return;
+	}
+
 	if (diff > 0)
 		diff -= fill_balloon(vb, diff);
 	else if (diff < 0)
-- 
2.7.4
