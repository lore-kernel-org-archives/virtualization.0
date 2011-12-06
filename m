From: Amit Shah <amit.shah@redhat.com>
Subject: [PATCH v4 10/12] virtio: balloon: ensure thread exists before
	stopping it
Date: Wed,  7 Dec 2011 01:18:48 +0530
Message-ID: <e85c8b64de7619522a565d8c38e5b2c8c8ed1412.1323199985.git.amit.shah@redhat.com>
References: <cover.1323199985.git.amit.shah@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <cover.1323199985.git.amit.shah@redhat.com>
In-Reply-To: <cover.1323199985.git.amit.shah@redhat.com>
References: <cover.1323199985.git.amit.shah@redhat.com>
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
Cc: Amit Shah <amit.shah@redhat.com>, linux-kernel@vger.kernel.org, levinsasha928@gmail.com, "Michael S. Tsirkin" <mst@redhat.com>
List-Id: virtualization@lists.linuxfoundation.org

The vballoon thread could have exited earlier and not re-started.
Ensure we don't try to stop a non-existent thread.

This can happen if the balloon driver goes into S4 state and the thread
exits (this code lands in the next patch).  If, however, on restore, the
vqs fail to initialise, the vballoon thread will not be re-created.
Upon a subsequent module removal in that state, we will end up
dereferencing an invalid pointer without this patch.
---
 drivers/virtio/virtio_balloon.c |    4 +++-
 1 files changed, 3 insertions(+), 1 deletions(-)

diff --git a/drivers/virtio/virtio_balloon.c b/drivers/virtio/virtio_balloon.c
index 94fd738..22f7c69 100644
--- a/drivers/virtio/virtio_balloon.c
+++ b/drivers/virtio/virtio_balloon.c
@@ -338,7 +338,9 @@ static void __devexit virtballoon_remove(struct virtio_device *vdev)
 {
 	struct virtio_balloon *vb = vdev->priv;
 
-	kthread_stop(vb->thread);
+	/* Thread may not have started on restore after a suspend */
+	if (vb->thread)
+		kthread_stop(vb->thread);
 
 	/* There might be pages left in the balloon: free them. */
 	while (vb->num_pages)
-- 
1.7.7.3
