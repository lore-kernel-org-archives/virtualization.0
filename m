From: Amit Shah <amit.shah@redhat.com>
Subject: [PATCH 1/6] virtio: Initialize vq->data entries to NULL
Date: Fri, 12 Feb 2010 10:32:14 +0530
Message-ID: <1265950939-12359-2-git-send-email-amit.shah@redhat.com>
References: <1265950939-12359-1-git-send-email-amit.shah@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <1265950939-12359-1-git-send-email-amit.shah@redhat.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: rusty@rustcorp.com.au
Cc: Amit Shah <amit.shah@redhat.com>, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

vq operations depend on vq->data[i] being NULL to figure out if the vq
entry is in use.

We have to initialize them to NULL to ensure we don't work with junk
data and trigger false BUG_ONs.

Signed-off-by: Amit Shah <amit.shah@redhat.com>
---
 drivers/virtio/virtio_ring.c |    5 ++++-
 1 files changed, 4 insertions(+), 1 deletions(-)

diff --git a/drivers/virtio/virtio_ring.c b/drivers/virtio/virtio_ring.c
index 71929ee..9bcfe95 100644
--- a/drivers/virtio/virtio_ring.c
+++ b/drivers/virtio/virtio_ring.c
@@ -431,8 +431,11 @@ struct virtqueue *vring_new_virtqueue(unsigned int num,
 	/* Put everything in free lists. */
 	vq->num_free = num;
 	vq->free_head = 0;
-	for (i = 0; i < num-1; i++)
+	for (i = 0; i < num-1; i++) {
 		vq->vring.desc[i].next = i+1;
+		vq->data[i] = NULL;
+	}
+	vq->data[i] = NULL;
 
 	return &vq->vq;
 }
-- 
1.6.2.5
