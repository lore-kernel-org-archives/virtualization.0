From: "Michael S. Tsirkin" <mst@redhat.com>
Subject: [PATCHv2 RFC 1/4] virtio_ring: add capacity check API
Date: Thu, 2 Jun 2011 18:42:59 +0300
Message-ID: <8014f898ca6b768d7be626b83c617a1e84adfeb9.1307029009.git.mst__44063.9967135668$1307029558$gmane$org@redhat.com>
References: <cover.1307029008.git.mst@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <cover.1307029008.git.mst@redhat.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
Cc: Krishna Kumar <krkumar2@in.ibm.com>, Carsten Otte <cotte@de.ibm.com>, lguest@lists.ozlabs.org, Shirley Ma <xma@us.ibm.com>, kvm@vger.kernel.org, linux-s390@vger.kernel.org, netdev@vger.kernel.org, habanero@linux.vnet.ibm.com, Heiko Carstens <heiko.carstens@de.ibm.com>, linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org, steved@us.ibm.com, Christian Borntraeger <borntraeger@de.ibm.com>, Tom Lendacky <tahm@linux.vnet.ibm.com>, Martin Schwidefsky <schwidefsky@de.ibm.com>, linux390@de.ibm.com
List-Id: virtualization@lists.linuxfoundation.org

Add API to check ring capacity. Because of the option
to use indirect buffers, this returns the worst
case, not the normal case capacity.

Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 drivers/virtio/virtio_ring.c |    8 ++++++++
 include/linux/virtio.h       |    5 +++++
 2 files changed, 13 insertions(+), 0 deletions(-)

diff --git a/drivers/virtio/virtio_ring.c b/drivers/virtio/virtio_ring.c
index 68b9136..23422f1 100644
--- a/drivers/virtio/virtio_ring.c
+++ b/drivers/virtio/virtio_ring.c
@@ -344,6 +344,14 @@ void *virtqueue_get_buf(struct virtqueue *_vq, unsigned int *len)
 }
 EXPORT_SYMBOL_GPL(virtqueue_get_buf);
 
+int virtqueue_min_capacity(struct virtqueue *_vq)
+{
+	struct vring_virtqueue *vq = to_vvq(_vq);
+
+	return vq->num_free;
+}
+EXPORT_SYMBOL_GPL(virtqueue_min_capacity);
+
 void virtqueue_disable_cb(struct virtqueue *_vq)
 {
 	struct vring_virtqueue *vq = to_vvq(_vq);
diff --git a/include/linux/virtio.h b/include/linux/virtio.h
index 7108857..209220d 100644
--- a/include/linux/virtio.h
+++ b/include/linux/virtio.h
@@ -42,6 +42,9 @@ struct virtqueue {
  *	vq: the struct virtqueue we're talking about.
  *	len: the length written into the buffer
  *	Returns NULL or the "data" token handed to add_buf.
+ * virtqueue_min_capacity: get the current capacity of the queue
+ *	vq: the struct virtqueue we're talking about.
+ *	Returns the current worst case capacity of the queue.
  * virtqueue_disable_cb: disable callbacks
  *	vq: the struct virtqueue we're talking about.
  *	Note that this is not necessarily synchronous, hence unreliable and only
@@ -89,6 +92,8 @@ void virtqueue_kick(struct virtqueue *vq);
 
 void *virtqueue_get_buf(struct virtqueue *vq, unsigned int *len);
 
+int virtqueue_min_capacity(struct virtqueue *vq);
+
 void virtqueue_disable_cb(struct virtqueue *vq);
 
 bool virtqueue_enable_cb(struct virtqueue *vq);
-- 
1.7.5.53.gc233e
