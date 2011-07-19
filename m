From: "Michael S. Tsirkin" <mst@redhat.com>
Subject: [PATCH RFC] vhost: optimize interrupt enable/disable
Date: Tue, 19 Jul 2011 18:04:34 +0300
Message-ID: <20110719150434.GA3413__17936.0320712023$1311088006$gmane$org@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
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
To: Jason Wang <jasowang@redhat.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, kvm@vger.kernel.org, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

As we now only update used ring after enabling
the backend, we can write flags with __put_user:
as that's done on data path, it matters.

Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---

It seems an obvious optimization so I queued this up
already.

 drivers/vhost/vhost.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/vhost/vhost.c b/drivers/vhost/vhost.c
index c16d225..c14c42b 100644
--- a/drivers/vhost/vhost.c
+++ b/drivers/vhost/vhost.c
@@ -998,7 +998,7 @@ int vhost_log_write(struct vhost_virtqueue *vq, struct vhost_log *log,
 static int vhost_update_used_flags(struct vhost_virtqueue *vq)
 {
 	void __user *used;
-	if (put_user(vq->used_flags, &vq->used->flags) < 0)
+	if (__put_user(vq->used_flags, &vq->used->flags) < 0)
 		return -EFAULT;
 	if (unlikely(vq->log_used)) {
 		/* Make sure the flag is seen before log. */
@@ -1016,7 +1016,7 @@ static int vhost_update_used_flags(struct vhost_virtqueue *vq)
 
 static int vhost_update_avail_event(struct vhost_virtqueue *vq, u16 avail_event)
 {
-	if (put_user(vq->avail_idx, vhost_avail_event(vq)))
+	if (__put_user(vq->avail_idx, vhost_avail_event(vq)))
 		return -EFAULT;
 	if (unlikely(vq->log_used)) {
 		void __user *used;
-- 
1.7.5.53.gc233e
