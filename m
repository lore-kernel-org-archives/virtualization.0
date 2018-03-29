From: Jason Wang <jasowang@redhat.com>
Subject: [PATCH net] vhost: validate log when IOTLB is enabled
Date: Thu, 29 Mar 2018 16:00:04 +0800
Message-ID: <1522310404-8486-1-git-send-email-jasowang@redhat.com>
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
To: mst@redhat.com, jasowang@redhat.com
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, kvm@vger.kernel.org, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

Vq log_base is the userspace address of bitmap which has nothing to do
with IOTLB. So it needs to be validated unconditionally otherwise we
may try use 0 as log_base which may lead to pin pages that will lead
unexpected result (e.g trigger BUG_ON() in set_bit_to_user()).

Fixes: 6b1e6cc7855b0 ("vhost: new device IOTLB API")
Reported-by: syzbot+6304bf97ef436580fede@syzkaller.appspotmail.com
Signed-off-by: Jason Wang <jasowang@redhat.com>
---
 drivers/vhost/vhost.c | 14 ++++++--------
 1 file changed, 6 insertions(+), 8 deletions(-)

diff --git a/drivers/vhost/vhost.c b/drivers/vhost/vhost.c
index 5d5a9d9..5320039 100644
--- a/drivers/vhost/vhost.c
+++ b/drivers/vhost/vhost.c
@@ -1244,14 +1244,12 @@ static int vq_log_access_ok(struct vhost_virtqueue *vq,
 /* Caller should have vq mutex and device mutex */
 int vhost_vq_access_ok(struct vhost_virtqueue *vq)
 {
-	if (vq->iotlb) {
-		/* When device IOTLB was used, the access validation
-		 * will be validated during prefetching.
-		 */
-		return 1;
-	}
-	return vq_access_ok(vq, vq->num, vq->desc, vq->avail, vq->used) &&
-		vq_log_access_ok(vq, vq->log_base);
+	int ret = vq_log_access_ok(vq, vq->log_base);
+
+	if (ret || vq->iotlb)
+		return ret;
+
+	return vq_access_ok(vq, vq->num, vq->desc, vq->avail, vq->used);
 }
 EXPORT_SYMBOL_GPL(vhost_vq_access_ok);
 
-- 
2.7.4
