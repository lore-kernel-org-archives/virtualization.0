From: Amit Shah <amit.shah@redhat.com>
Subject: [PATCH 3/3] virtio: console: Accept console size along with resize
	control message
Date: Thu,  6 May 2010 02:05:09 +0530
Message-ID: <1273091709-19963-4-git-send-email-amit.shah__48050.2979168252$1273094795$gmane$org@redhat.com>
References: <1273091709-19963-1-git-send-email-amit.shah@redhat.com>
	<1273091709-19963-2-git-send-email-amit.shah@redhat.com>
	<1273091709-19963-3-git-send-email-amit.shah@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <1273091709-19963-3-git-send-email-amit.shah@redhat.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Rusty Russell <rusty@rustcorp.com.au>
Cc: Amit Shah <amit.shah@redhat.com>, Christian Borntraeger <borntraeger@de.ibm.com>, Kusanagi Kouichi <slash@ac.auone-net.jp>, linuxppc-dev@ozlabs.org, Virtualization List <virtualization@lists.linux-foundation.org>
List-Id: virtualization@lists.linuxfoundation.org

The VIRTIO_CONSOLE_RESIZE control message sent to us by the host now
contains the new {rows, cols} values for the console. This ensures each
console port gets its own size, and we don't depend on the config-space
rows and cols values at all now.

Signed-off-by: Amit Shah <amit.shah@redhat.com>
CC: Christian Borntraeger <borntraeger@de.ibm.com>
CC: linuxppc-dev@ozlabs.org
CC: Kusanagi Kouichi <slash@ac.auone-net.jp>
---
 drivers/char/virtio_console.c |   13 ++++++++++++-
 1 files changed, 12 insertions(+), 1 deletions(-)

diff --git a/drivers/char/virtio_console.c b/drivers/char/virtio_console.c
index ccfe68a..5cab839 100644
--- a/drivers/char/virtio_console.c
+++ b/drivers/char/virtio_console.c
@@ -1194,12 +1194,23 @@ static void handle_control_message(struct ports_device *portdev,
 		 * have to notify the host first.
 		 */
 		break;
-	case VIRTIO_CONSOLE_RESIZE:
+	case VIRTIO_CONSOLE_RESIZE: {
+		struct {
+			__u16 rows;
+			__u16 cols;
+		} size;
+
 		if (!is_console_port(port))
 			break;
+
+		memcpy(&size, buf->buf + buf->offset + sizeof(*cpkt),
+		       sizeof(size));
+		set_console_size(port, size.rows, size.cols);
+
 		port->cons.hvc->irq_requested = 1;
 		resize_console(port);
 		break;
+	}
 	case VIRTIO_CONSOLE_PORT_OPEN:
 		port->host_connected = cpkt->value;
 		wake_up_interruptible(&port->waitqueue);
-- 
1.6.2.5
