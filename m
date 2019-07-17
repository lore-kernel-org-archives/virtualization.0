From: Jason Wang <jasowang@redhat.com>
Subject: [PATCH V3 09/15] vhost: do not export vhost_add_used_n() and
	vhost_add_used_and_signal_n()
Date: Wed, 17 Jul 2019 06:52:49 -0400
Message-ID: <20190717105255.63488-10-jasowang__28388.7134328083$1563360893$gmane$org@redhat.com>
References: <20190717105255.63488-1-jasowang@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20190717105255.63488-1-jasowang@redhat.com>
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
Cc: kvm@vger.kernel.org, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org, maxime.coquelin@redhat.com
List-Id: virtualization@lists.linuxfoundation.org

We would request device to use shadow used ring API. Then there's no
need for exposing those to device.

Signed-off-by: Jason Wang <jasowang@redhat.com>
---
 drivers/vhost/vhost.c | 13 +++++++------
 drivers/vhost/vhost.h |  4 ----
 2 files changed, 7 insertions(+), 10 deletions(-)

diff --git a/drivers/vhost/vhost.c b/drivers/vhost/vhost.c
index 5bfca5b76b05..50ba382f0981 100644
--- a/drivers/vhost/vhost.c
+++ b/drivers/vhost/vhost.c
@@ -2883,8 +2883,9 @@ EXPORT_SYMBOL_GPL(vhost_get_shadow_used_count);
 
 /* After we've used one of their buffers, we tell them about it.  We'll then
  * want to notify the guest, using eventfd. */
-int vhost_add_used_n(struct vhost_virtqueue *vq, struct vring_used_elem *heads,
-		     unsigned count)
+static int vhost_add_used_n(struct vhost_virtqueue *vq,
+			    struct vring_used_elem *heads,
+			    unsigned count)
 {
 	int start, n, r;
 
@@ -2988,14 +2989,14 @@ void vhost_add_used_and_signal(struct vhost_dev *dev,
 EXPORT_SYMBOL_GPL(vhost_add_used_and_signal);
 
 /* multi-buffer version of vhost_add_used_and_signal */
-void vhost_add_used_and_signal_n(struct vhost_dev *dev,
-				 struct vhost_virtqueue *vq,
-				 struct vring_used_elem *heads, unsigned count)
+static void vhost_add_used_and_signal_n(struct vhost_dev *dev,
+					struct vhost_virtqueue *vq,
+					struct vring_used_elem *heads,
+					unsigned count)
 {
 	vhost_add_used_n(vq, heads, count);
 	vhost_signal(dev, vq);
 }
-EXPORT_SYMBOL_GPL(vhost_add_used_and_signal_n);
 
 void vhost_flush_shadow_used_and_signal(struct vhost_virtqueue *vq)
 
diff --git a/drivers/vhost/vhost.h b/drivers/vhost/vhost.h
index 175eb5ebf954..481baba20c3d 100644
--- a/drivers/vhost/vhost.h
+++ b/drivers/vhost/vhost.h
@@ -240,13 +240,9 @@ void vhost_discard_vq_desc(struct vhost_virtqueue *, int n);
 
 int vhost_vq_init_access(struct vhost_virtqueue *);
 int vhost_add_used(struct vhost_virtqueue *, unsigned int head, int len);
-int vhost_add_used_n(struct vhost_virtqueue *, struct vring_used_elem *heads,
-		     unsigned count);
 
 void vhost_add_used_and_signal(struct vhost_dev *, struct vhost_virtqueue *,
 			       unsigned int id, int len);
-void vhost_add_used_and_signal_n(struct vhost_dev *, struct vhost_virtqueue *,
-			       struct vring_used_elem *heads, unsigned count);
 
 /* Zerocopy shadow used ring API */
 void vhost_set_zc_used_len(struct vhost_virtqueue *vq,
-- 
2.18.1
