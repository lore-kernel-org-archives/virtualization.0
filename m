From: Amit Shah <amit.shah@redhat.com>
Subject: [PATCH 1/5] virtio: balloon: Allow stats update after restore from S4
Date: Thu, 29 Mar 2012 13:58:07 +0530
Message-ID: <32462a09889aba81461be2be1d32da8775d2cab3.1333008576.git.amit.shah@redhat.com>
References: <cover.1333008576.git.amit.shah@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <cover.1333008576.git.amit.shah@redhat.com>
In-Reply-To: <cover.1333008576.git.amit.shah@redhat.com>
References: <cover.1333008576.git.amit.shah@redhat.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Virtualization List <virtualization@lists.linux-foundation.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, "Michael S. Tsirkin" <mst@redhat.com>
List-Id: virtualization@lists.linuxfoundation.org

There's no reason stats update after restore can't work.  If a host
requested for stats, and before servicing the request, the guest entered
S4, upon restore, the stats request can still be processed and sent off
to the host.

Signed-off-by: Amit Shah <amit.shah@redhat.com>
---
 drivers/virtio/virtio_balloon.c |    8 --------
 1 files changed, 0 insertions(+), 8 deletions(-)

diff --git a/drivers/virtio/virtio_balloon.c b/drivers/virtio/virtio_balloon.c
index 958e512..9f1bb36 100644
--- a/drivers/virtio/virtio_balloon.c
+++ b/drivers/virtio/virtio_balloon.c
@@ -405,14 +405,6 @@ static int virtballoon_thaw(struct virtio_device *vdev)
 
 static int virtballoon_restore(struct virtio_device *vdev)
 {
-	struct virtio_balloon *vb = vdev->priv;
-
-	/*
-	 * If a request wasn't complete at the time of freezing, this
-	 * could have been set.
-	 */
-	vb->need_stats_update = 0;
-
 	return restore_common(vdev);
 }
 #endif
-- 
1.7.7.6
