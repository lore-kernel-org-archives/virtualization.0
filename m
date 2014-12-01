From: "Michael S. Tsirkin" <mst@redhat.com>
Subject: [PATCH v8 32/50] vhost: switch to __get/__put_user exclusively
Date: Mon, 1 Dec 2014 18:05:25 +0200
Message-ID: <1417449619-24896-33-git-send-email-mst__15020.5124206424$1417450012$gmane$org@redhat.com>
References: <1417449619-24896-1-git-send-email-mst@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <1417449619-24896-1-git-send-email-mst@redhat.com>
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
Cc: thuth@linux.vnet.ibm.com, kvm@vger.kernel.org, rusty@au1.ibm.com, netdev@vger.kernel.org, virtualization@lists.linux-foundation.org, dahi@linux.vnet.ibm.com, pbonzini@redhat.com, David Miller <davem@davemloft.net>
List-Id: virtualization@lists.linuxfoundation.org

Most places in vhost can use __get/__put_user rather than
get/put_user since addresses are pre-validated.
This should be good for performance, but this also
will help make code sparse-clean: get/put_user macros
don't play well with __virtioXX bitwise tags.
Switch to get/put_user to __ variants everywhere in vhost.
There's one exception - for consistency switch that
as well, and add an explicit access_ok check.

Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 drivers/vhost/vhost.c | 13 ++++++++++---
 1 file changed, 10 insertions(+), 3 deletions(-)

diff --git a/drivers/vhost/vhost.c b/drivers/vhost/vhost.c
index c90f437..6a40837 100644
--- a/drivers/vhost/vhost.c
+++ b/drivers/vhost/vhost.c
@@ -1038,6 +1038,7 @@ static int vhost_update_avail_event(struct vhost_virtqueue *vq, u16 avail_event)
 
 int vhost_init_used(struct vhost_virtqueue *vq)
 {
+	u16 last_used_idx;
 	int r;
 	if (!vq->private_data)
 		return 0;
@@ -1046,7 +1047,13 @@ int vhost_init_used(struct vhost_virtqueue *vq)
 	if (r)
 		return r;
 	vq->signalled_used_valid = false;
-	return get_user(vq->last_used_idx, &vq->used->idx);
+	if (!access_ok(VERIFY_READ, &vq->used->idx, sizeof vq->used->idx))
+		return -EFAULT;
+	r = __get_user(last_used_idx, &vq->used->idx);
+	if (r)
+		return r;
+	vq->last_used_idx = last_used_idx;
+	return 0;
 }
 EXPORT_SYMBOL_GPL(vhost_init_used);
 
@@ -1404,7 +1411,7 @@ int vhost_add_used_n(struct vhost_virtqueue *vq, struct vring_used_elem *heads,
 
 	/* Make sure buffer is written before we update index. */
 	smp_wmb();
-	if (put_user(vq->last_used_idx, &vq->used->idx)) {
+	if (__put_user(vq->last_used_idx, &vq->used->idx)) {
 		vq_err(vq, "Failed to increment used idx");
 		return -EFAULT;
 	}
@@ -1449,7 +1456,7 @@ static bool vhost_notify(struct vhost_dev *dev, struct vhost_virtqueue *vq)
 	if (unlikely(!v))
 		return true;
 
-	if (get_user(event, vhost_used_event(vq))) {
+	if (__get_user(event, vhost_used_event(vq))) {
 		vq_err(vq, "Failed to get used event idx");
 		return true;
 	}
-- 
MST
