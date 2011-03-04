From: Rusty Russell <rusty@rustcorp.com.au>
Subject: [PATCH] virtio: console: Don't access vqs if device was unplugged
Date: Fri, 04 Mar 2011 14:04:33 +1030
Message-ID: <871v2n4kza.fsf@rustcorp.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Amit Shah <amit.shah@redhat.com>, virtualization <virtualization@lists.linux-foundation.org>
List-Id: virtualization@lists.linuxfoundation.org

From: Amit Shah <amit.shah@redhat.com>

If a virtio-console device gets unplugged while a port is open, a
subsequent close() call on the port accesses vqs to free up buffers.
This can lead to a crash.

The buffers are already freed up as a result of the call to
unplug_ports() from virtcons_remove().  The fix is to simply not access
vq information if port->portdev is NULL.

Reported-by: juzhang <juzhang@redhat.com>
CC: stable@kernel.org
Signed-off-by: Amit Shah <amit.shah@redhat.com>
Signed-off-by: Rusty Russell <rusty@rustcorp.com.au>
---
 drivers/char/virtio_console.c |    8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/char/virtio_console.c b/drivers/char/virtio_console.c
index 4903931..84b164d 100644
--- a/drivers/char/virtio_console.c
+++ b/drivers/char/virtio_console.c
@@ -388,6 +388,10 @@ static void discard_port_data(struct port *port)
 	unsigned int len;
 	int ret;
 
+	if (!port->portdev) {
+		/* Device has been unplugged.  vqs are already gone. */
+		return;
+	}
 	vq = port->in_vq;
 	if (port->inbuf)
 		buf = port->inbuf;
@@ -470,6 +474,10 @@ static void reclaim_consumed_buffers(struct port *port)
 	void *buf;
 	unsigned int len;
 
+	if (!port->portdev) {
+		/* Device has been unplugged.  vqs are already gone. */
+		return;
+	}
 	while ((buf = virtqueue_get_buf(port->out_vq, &len))) {
 		kfree(buf);
 		port->outvq_full = false;
