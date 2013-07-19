From: Amit Shah <amit.shah@redhat.com>
Subject: [PATCH v2 08/11] virtio: console: add locks around buffer removal in
	port unplug path
Date: Fri, 19 Jul 2013 16:52:01 +0530
Message-ID: <177a9cff011498b613d4e3c854ded6d6e632c627.1374232738.git.amit.shah__30131.2231379145$1374233005$gmane$org@redhat.com>
References: <cover.1374232738.git.amit.shah@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <cover.1374232738.git.amit.shah@redhat.com>
In-Reply-To: <cover.1374232738.git.amit.shah@redhat.com>
References: <cover.1374232738.git.amit.shah@redhat.com>
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
Cc: Amit Shah <amit.shah@redhat.com>, stable@vger.kernel.org
List-Id: virtualization@lists.linuxfoundation.org

The removal functions act on the vqs, and the vq operations need to be
locked.

CC: <stable@vger.kernel.org>
Signed-off-by: Amit Shah <amit.shah@redhat.com>
---
 drivers/char/virtio_console.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/char/virtio_console.c b/drivers/char/virtio_console.c
index dd21b2f..c9faea1 100644
--- a/drivers/char/virtio_console.c
+++ b/drivers/char/virtio_console.c
@@ -1516,18 +1516,22 @@ static void remove_port_data(struct port *port)
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
