From: "Michael S. Tsirkin" <mst@redhat.com>
Subject: [PATCHv2 RFC 4/4] Revert "virtio: make add_buf return capacity
	remaining:
Date: Thu, 2 Jun 2011 18:43:25 +0300
Message-ID: <7572d6fb81181e349af4a8b203ea0977f6e91ae1.1307029009.git.mst__9290.58735860071$1307029546$gmane$org@redhat.com>
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

This reverts commit 3c1b27d5043086a485f8526353ae9fe37bfa1065.
The only user was virtio_net, and it switched to
min_capacity instead.

Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 drivers/virtio/virtio_ring.c |    2 +-
 include/linux/virtio.h       |    2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/virtio/virtio_ring.c b/drivers/virtio/virtio_ring.c
index 23422f1..a6c21eb 100644
--- a/drivers/virtio/virtio_ring.c
+++ b/drivers/virtio/virtio_ring.c
@@ -233,7 +233,7 @@ add_head:
 	pr_debug("Added buffer head %i to %p\n", head, vq);
 	END_USE(vq);
 
-	return vq->num_free;
+	return 0;
 }
 EXPORT_SYMBOL_GPL(virtqueue_add_buf_gfp);
 
diff --git a/include/linux/virtio.h b/include/linux/virtio.h
index 209220d..63c4908 100644
--- a/include/linux/virtio.h
+++ b/include/linux/virtio.h
@@ -34,7 +34,7 @@ struct virtqueue {
  *	in_num: the number of sg which are writable (after readable ones)
  *	data: the token identifying the buffer.
  *	gfp: how to do memory allocations (if necessary).
- *      Returns remaining capacity of queue (sg segments) or a negative error.
+ *      Returns 0 on success or a negative error.
  * virtqueue_kick: update after add_buf
  *	vq: the struct virtqueue
  *	After one or more add_buf calls, invoke this to kick the other side.
-- 
1.7.5.53.gc233e
