From: Matt Redfearn <matt.redfearn@imgtec.com>
Subject: [PATCH] virtio: console: Unlock vqs while freeing buffers
Date: Tue, 11 Oct 2016 12:05:15 +0100
Message-ID: <1476183915-13625-1-git-send-email-matt.redfearn__28760.1082156927$1476890568$gmane$org@imgtec.com>
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
To: Amit Shah <amit.shah@redhat.com>
Cc: Arnd Bergmann <arnd@arndb.de>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-kernel@vger.kernel.org, stable@vger.kernel.org, virtualization@lists.linux-foundation.org, Matt Redfearn <matt.redfearn@imgtec.com>
List-Id: virtualization@lists.linuxfoundation.org

Commit c6017e793b93 ("virtio: console: add locks around buffer removal
in port unplug path") added locking around the freeing of buffers in the
vq. However, when free_buf() is called with can_sleep = true and rproc
is enabled, it calls dma_free_coherent() directly, requiring interrupts
to be enabled. Currently a WARNING is triggered due to the spin locking
around free_buf, with a call stack like this:

WARNING: CPU: 3 PID: 121 at ./include/linux/dma-mapping.h:433
free_buf+0x1a8/0x288
Call Trace:
[<8040c538>] show_stack+0x74/0xc0
[<80757240>] dump_stack+0xd0/0x110
[<80430d98>] __warn+0xfc/0x130
[<80430ee0>] warn_slowpath_null+0x2c/0x3c
[<807e7c6c>] free_buf+0x1a8/0x288
[<807ea590>] remove_port_data+0x50/0xac
[<807ea6a0>] unplug_port+0xb4/0x1bc
[<807ea858>] virtcons_remove+0xb0/0xfc
[<807b6734>] virtio_dev_remove+0x58/0xc0
[<807f918c>] __device_release_driver+0xac/0x134
[<807f924c>] device_release_driver+0x38/0x50
[<807f7edc>] bus_remove_device+0xfc/0x130
[<807f4b74>] device_del+0x17c/0x21c
[<807f4c38>] device_unregister+0x24/0x38
[<807b6b50>] unregister_virtio_device+0x28/0x44

Fix this by restructuring the loops to allow the locks to only be taken
where it is necessary to protect the vqs, and release it while the
buffer is being freed.

Fixes: c6017e793b93 ("virtio: console: add locks around buffer removal in port unplug path")
Cc: stable@vger.kernel.org
Signed-off-by: Matt Redfearn <matt.redfearn@imgtec.com>
---

 drivers/char/virtio_console.c | 22 ++++++++++++++++------
 1 file changed, 16 insertions(+), 6 deletions(-)

diff --git a/drivers/char/virtio_console.c b/drivers/char/virtio_console.c
index 5da47e26a012..4aae0d27e382 100644
--- a/drivers/char/virtio_console.c
+++ b/drivers/char/virtio_console.c
@@ -1540,19 +1540,29 @@ static void remove_port_data(struct port *port)
 	spin_lock_irq(&port->inbuf_lock);
 	/* Remove unused data this port might have received. */
 	discard_port_data(port);
+	spin_unlock_irq(&port->inbuf_lock);
 
 	/* Remove buffers we queued up for the Host to send us data in. */
-	while ((buf = virtqueue_detach_unused_buf(port->in_vq)))
-		free_buf(buf, true);
-	spin_unlock_irq(&port->inbuf_lock);
+	do {
+		spin_lock_irq(&port->inbuf_lock);
+		buf = virtqueue_detach_unused_buf(port->in_vq);
+		spin_unlock_irq(&port->inbuf_lock);
+		if (buf)
+			free_buf(buf, true);
+	} while (buf);
 
 	spin_lock_irq(&port->outvq_lock);
 	reclaim_consumed_buffers(port);
+	spin_unlock_irq(&port->outvq_lock);
 
 	/* Free pending buffers from the out-queue. */
-	while ((buf = virtqueue_detach_unused_buf(port->out_vq)))
-		free_buf(buf, true);
-	spin_unlock_irq(&port->outvq_lock);
+	do {
+		spin_lock_irq(&port->outvq_lock);
+		buf = virtqueue_detach_unused_buf(port->out_vq);
+		spin_unlock_irq(&port->outvq_lock);
+		if (buf)
+			free_buf(buf, true);
+	} while (buf);
 }
 
 /*
-- 
2.7.4
