From: Amit Shah <amit.shah@redhat.com>
Subject: [PATCH 01/10] virtio: console: Add a __send_control_msg() that can
	send messages without a valid port
Date: Mon,  5 Apr 2010 19:24:05 +0530
Message-ID: <1270475654-399-2-git-send-email-amit.shah@redhat.com>
References: <1270475654-399-1-git-send-email-amit.shah@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <1270475654-399-1-git-send-email-amit.shah@redhat.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Virtualization List <virtualization@lists.linux-foundation.org>
Cc: Amit Shah <amit.shah@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>
List-Id: virtualization@lists.linuxfoundation.org

We will introduce control messages that operate on the device as a whole
rather than just ports. Make send_control_msg() a wrapper around
__send_control_msg() which does not need a valid port.

Signed-off-by: Amit Shah <amit.shah@redhat.com>
---
 drivers/char/virtio_console.c |   16 +++++++++++-----
 1 files changed, 11 insertions(+), 5 deletions(-)

diff --git a/drivers/char/virtio_console.c b/drivers/char/virtio_console.c
index 8f665bc..5d24015 100644
--- a/drivers/char/virtio_console.c
+++ b/drivers/char/virtio_console.c
@@ -373,22 +373,22 @@ out:
 	return ret;
 }
 
-static ssize_t send_control_msg(struct port *port, unsigned int event,
-				unsigned int value)
+static ssize_t __send_control_msg(struct ports_device *portdev, u32 port_id,
+				  unsigned int event, unsigned int value)
 {
 	struct scatterlist sg[1];
 	struct virtio_console_control cpkt;
 	struct virtqueue *vq;
 	unsigned int len;
 
-	if (!use_multiport(port->portdev))
+	if (!use_multiport(portdev))
 		return 0;
 
-	cpkt.id = port->id;
+	cpkt.id = port_id;
 	cpkt.event = event;
 	cpkt.value = value;
 
-	vq = port->portdev->c_ovq;
+	vq = portdev->c_ovq;
 
 	sg_init_one(sg, &cpkt, sizeof(cpkt));
 	if (vq->vq_ops->add_buf(vq, sg, 1, 0, &cpkt) >= 0) {
@@ -399,6 +399,12 @@ static ssize_t send_control_msg(struct port *port, unsigned int event,
 	return 0;
 }
 
+static ssize_t send_control_msg(struct port *port, unsigned int event,
+				unsigned int value)
+{
+	return __send_control_msg(port->portdev, port->id, event, value);
+}
+
 static ssize_t send_buf(struct port *port, void *in_buf, size_t in_count)
 {
 	struct scatterlist sg[1];
-- 
1.6.2.5
