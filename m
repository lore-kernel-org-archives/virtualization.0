From: Amit Shah <amit.shah@redhat.com>
Subject: [PATCH v3 4/9] virtio: console: fix raising SIGIO after port unplug
Date: Thu, 25 Jul 2013 19:28:44 +0530
Message-ID: <e4199103bd85fae76ce7009d7d6abacf28f1f972.1374759439.git.amit.shah__36261.272399179$1374760788$gmane$org@redhat.com>
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
Cc: Amit Shah <amit.shah@redhat.com>, stable@vger.kernel.org
List-Id: virtualization@lists.linuxfoundation.org

SIGIO should be sent when a port gets unplugged.  It should only be sent
to prcesses that have the port opened, and have asked for SIGIO to be
delivered.  We were clearing out guest_connected before calling
send_sigio_to_port(), resulting in a sigio not getting sent to
processes.

Fix by setting guest_connected to false after invoking the sigio
function.

CC: <stable@vger.kernel.org>
Signed-off-by: Amit Shah <amit.shah@redhat.com>
---
 drivers/char/virtio_console.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/drivers/char/virtio_console.c b/drivers/char/virtio_console.c
index 6bf0df3..3435348 100644
--- a/drivers/char/virtio_console.c
+++ b/drivers/char/virtio_console.c
@@ -1534,12 +1534,14 @@ static void unplug_port(struct port *port)
 	spin_unlock_irq(&port->portdev->ports_lock);
 
 	if (port->guest_connected) {
+		/* Let the app know the port is going down. */
+		send_sigio_to_port(port);
+
+		/* Do this after sigio is actually sent */
 		port->guest_connected = false;
 		port->host_connected = false;
-		wake_up_interruptible(&port->waitqueue);
 
-		/* Let the app know the port is going down. */
-		send_sigio_to_port(port);
+		wake_up_interruptible(&port->waitqueue);
 	}
 
 	if (is_console_port(port)) {
-- 
1.8.1.4
