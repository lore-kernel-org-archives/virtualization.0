From: Amit Shah <amit.shah@redhat.com>
Subject: [PATCH v3 6/9] virtio: console: add locks around buffer removal in
	port unplug path
Date: Thu, 25 Jul 2013 19:28:46 +0530
Message-ID: <076e81210c7105be320a9807e8ff2fb76e0a9b7d.1374759439.git.amit.shah@redhat.com>
References: <cover.1374759439.git.amit.shah@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <cover.1374759439.git.amit.shah@redhat.com>
In-Reply-To: <cover.1374759439.git.amit.shah@redhat.com>
References: <cover.1374759439.git.amit.shah@redhat.com>
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
Cc: Amit Shah <amit.shah@redhat.com>
List-Id: virtualization@lists.linuxfoundation.org

The removal functions act on the vqs, and the vq operations need to be
locked.

Signed-off-by: Amit Shah <amit.shah@redhat.com>
---
 drivers/char/virtio_console.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/char/virtio_console.c b/drivers/char/virtio_console.c
index 2b68075..9cbed93 100644
--- a/drivers/char/virtio_console.c
+++ b/drivers/char/virtio_console.c
@@ -1512,18 +1512,22 @@ static void remove_port_data(struct port *port)
 {
 	struct port_buffer *buf;
 
+	spin_lock_irq(&port->inbuf_lock);
 	/* Remove unused data this port might have received. */
 	discard_port_data(port);
 
-	reclaim_consumed_buffers(port);
-
 	/* Remove buffers we queued up for the Host to send us data in. */
 	while ((buf = virtqueue_detach_unused_buf(port->in_vq)))
 		free_buf(buf, true);
+	spin_unlock_irq(&port->inbuf_lock);
+
+	spin_lock_irq(&port->outvq_lock);
+	reclaim_consumed_buffers(port);
 
 	/* Free pending buffers from the out-queue. */
 	while ((buf = virtqueue_detach_unused_buf(port->out_vq)))
 		free_buf(buf, true);
+	spin_unlock_irq(&port->outvq_lock);
 }
 
 /*
-- 
1.8.1.4
