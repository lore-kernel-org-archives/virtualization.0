From: "Michael S. Tsirkin" <mst@redhat.com>
Subject: [PATCH 1/3] virtio: fix avail event support
Date: Thu, 5 May 2011 18:08:04 +0300
Message-ID: <1d1d5b1a8d5326dae23685587e6ab84fc6b7177e.1304605816.git.mst__38656.0539053336$1304610456$gmane$org@redhat.com>
References: <cover.1304605816.git.mst@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <cover.1304605816.git.mst@redhat.com>
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

make valid flag false, not true, on overrun

Reported-by: Tom Lendacky <tahm@linux.vnet.ibm.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 drivers/virtio/virtio_ring.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/drivers/virtio/virtio_ring.c b/drivers/virtio/virtio_ring.c
index 57bf9d5..0ea0781 100644
--- a/drivers/virtio/virtio_ring.c
+++ b/drivers/virtio/virtio_ring.c
@@ -242,7 +242,7 @@ add_head:
 	 * kicked_avail index we stored. TODO: make sure all drivers
 	 * kick at least once in 2^16 and remove this. */
 	if (unlikely(vq->vring.avail->idx == vq->kicked_avail))
-		vq->kicked_avail_valid = true;
+		vq->kicked_avail_valid = false;
 
 	pr_debug("Added buffer head %i to %p\n", head, vq);
 	END_USE(vq);
-- 
1.7.5.53.gc233e
