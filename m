From: Amit Shah <amit.shah@redhat.com>
Subject: [PATCH 07/10] virtio: console: fix raising SIGIO after port unplug
Date: Fri, 19 Jul 2013 01:46:14 +0530
Message-ID: <65c5eee3761ab48dde5bc0704fdae1466169061d.1374177234.git.amit.shah@redhat.com>
References: <cover.1374177234.git.amit.shah@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <cover.1374177234.git.amit.shah@redhat.com>
In-Reply-To: <cover.1374177234.git.amit.shah@redhat.com>
References: <cover.1374177234.git.amit.shah@redhat.com>
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

SIGIO should be sent when a port gets unplugged.  However, the SIGIO is
sent only when there's a userspace application that has the port opened,
and has asked for SIGIO to be delivered.  We were clearing out
guest_connected before calling send_sigio_to_port(), resulting in a
sigio not getting sent to users.

Fix by setting guest_connected to false after invoking the sigio
function.

Signed-off-by: Amit Shah <amit.shah@redhat.com>
---
 drivers/char/virtio_console.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/char/virtio_console.c b/drivers/char/virtio_console.c
index 1d4b748..ce71df1 100644
--- a/drivers/char/virtio_console.c
+++ b/drivers/char/virtio_console.c
@@ -1542,12 +1542,14 @@ static void unplug_port(struct port *port)
 	spin_unlock_irq(&port->portdev->ports_lock);
 
 	if (port->guest_connected) {
-		port->guest_connected = false;
 		port->host_connected = false;
 		wake_up_interruptible(&port->waitqueue);
 
 		/* Let the app know the port is going down. */
 		send_sigio_to_port(port);
+
+		/* Do this last so that sigio is actually sent */
+		port->guest_connected = false;
 	}
 
 	if (is_console_port(port)) {
-- 
1.8.1.4
