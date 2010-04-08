From: Amit Shah <amit.shah@redhat.com>
Subject: [PATCH 05/11] virtio: console: Don't call hvc_remove() on unplugging
	console ports
Date: Thu,  8 Apr 2010 20:19:34 +0530
Message-ID: <1270738180-21170-6-git-send-email-amit.shah@redhat.com>
References: <1270738180-21170-1-git-send-email-amit.shah@redhat.com>
	<1270738180-21170-2-git-send-email-amit.shah@redhat.com>
	<1270738180-21170-3-git-send-email-amit.shah@redhat.com>
	<1270738180-21170-4-git-send-email-amit.shah@redhat.com>
	<1270738180-21170-5-git-send-email-amit.shah@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <1270738180-21170-5-git-send-email-amit.shah@redhat.com>
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
Cc: Amit Shah <amit.shah@redhat.com>, Juan Quintela <quintela@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>
List-Id: virtualization@lists.linuxfoundation.org

hvc_remove() has some bug which freezes other active hvc ports when one
port is removed.

So disable calling of hvc_remove() which deregisters a port with the
hvc_console.

If the hvc_console code calls into our get_chars() routine as a result
of a poll operation, we will return -EPIPE and the hvc_console code will
then do the necessary cleanup.

This call will be restored when the bug in hvc_remove() is found and
fixed.

Signed-off-by: Amit Shah <amit.shah@redhat.com>
---
 drivers/char/virtio_console.c |   11 +++++++++++
 1 files changed, 11 insertions(+), 0 deletions(-)

diff --git a/drivers/char/virtio_console.c b/drivers/char/virtio_console.c
index 24fa759..6adde65 100644
--- a/drivers/char/virtio_console.c
+++ b/drivers/char/virtio_console.c
@@ -869,7 +869,18 @@ static int remove_port(struct port *port)
 		spin_lock_irq(&pdrvdata_lock);
 		list_del(&port->cons.list);
 		spin_unlock_irq(&pdrvdata_lock);
+#if 0
+		/*
+		 * hvc_remove() not called as removing one hvc port
+		 * results in other hvc ports getting frozen.
+		 *
+		 * Once this is resolved in hvc, this functionality
+		 * will be enabled.  Till that is done, the -EPIPE
+		 * return from get_chars() above will help
+		 * hvc_console.c to clean up on ports we remove here.
+		 */
 		hvc_remove(port->cons.hvc);
+#endif
 	}
 	if (port->guest_connected)
 		send_control_msg(port, VIRTIO_CONSOLE_PORT_OPEN, 0);
-- 
1.6.2.5
