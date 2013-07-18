From: Amit Shah <amit.shah@redhat.com>
Subject: [PATCH 09/10] virtio: console: add locking in port unplug path
Date: Fri, 19 Jul 2013 01:46:16 +0530
Message-ID: <f40992d5f222df4f34ebdb9e1e45da5d73f13445.1374177234.git.amit.shah@redhat.com>
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

Port unplug can race with close() in port_fops_release().
port_fops_release() already takes the necessary locks, ensure
unplug_port() does that too.

Signed-off-by: Amit Shah <amit.shah@redhat.com>
---
 drivers/char/virtio_console.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/char/virtio_console.c b/drivers/char/virtio_console.c
index dd0020d..b174945 100644
--- a/drivers/char/virtio_console.c
+++ b/drivers/char/virtio_console.c
@@ -1545,6 +1545,7 @@ static void unplug_port(struct port *port)
 	list_del(&port->list);
 	spin_unlock_irq(&port->portdev->ports_lock);
 
+	spin_lock_irq(&port->inbuf_lock);
 	if (port->guest_connected) {
 		port->host_connected = false;
 		wake_up_interruptible(&port->waitqueue);
@@ -1555,6 +1556,7 @@ static void unplug_port(struct port *port)
 		/* Do this last so that sigio is actually sent */
 		port->guest_connected = false;
 	}
+	spin_unlock_irq(&port->inbuf_lock);
 
 	if (is_console_port(port)) {
 		spin_lock_irq(&pdrvdata_lock);
-- 
1.8.1.4
