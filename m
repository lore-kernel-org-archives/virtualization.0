From: Amit Shah <amit.shah@redhat.com>
Subject: [PATCH v3 8/9] virtio: console: fix locking around
	send_sigio_to_port()
Date: Thu, 25 Jul 2013 19:28:48 +0530
Message-ID: <757aac3a03423986825852680496f69db0f6c7de.1374759439.git.amit.shah@redhat.com>
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

send_sigio_to_port() checks the value of guest_connected, which we
always modify under the inbuf_lock; make sure invocations of
send_sigio_to_port() have take the inbuf_lock around the call.

Signed-off-by: Amit Shah <amit.shah@redhat.com>
---
 drivers/char/virtio_console.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/drivers/char/virtio_console.c b/drivers/char/virtio_console.c
index e8b707d..4e380c1 100644
--- a/drivers/char/virtio_console.c
+++ b/drivers/char/virtio_console.c
@@ -1670,7 +1670,9 @@ static void handle_control_message(struct ports_device *portdev,
 		 * If the guest is connected, it'll be interested in
 		 * knowing the host connection state changed.
 		 */
+		spin_lock_irq(&port->inbuf_lock);
 		send_sigio_to_port(port);
+		spin_unlock_irq(&port->inbuf_lock);
 		break;
 	case VIRTIO_CONSOLE_PORT_NAME:
 		/*
@@ -1790,13 +1792,13 @@ static void in_intr(struct virtqueue *vq)
 	if (!port->guest_connected && !is_rproc_serial(port->portdev->vdev))
 		discard_port_data(port);
 
+	/* Send a SIGIO indicating new data in case the process asked for it */
+	send_sigio_to_port(port);
+
 	spin_unlock_irqrestore(&port->inbuf_lock, flags);
 
 	wake_up_interruptible(&port->waitqueue);
 
-	/* Send a SIGIO indicating new data in case the process asked for it */
-	send_sigio_to_port(port);
-
 	if (is_console_port(port) && hvc_poll(port->cons.hvc))
 		hvc_kick();
 }
-- 
1.8.1.4
