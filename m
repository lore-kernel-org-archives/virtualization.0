From: Amit Shah <amit.shah@redhat.com>
Subject: [PATCH v2 09/11] virtio: console: add locking in port unplug path
Date: Fri, 19 Jul 2013 16:52:02 +0530
Message-ID: <75ea703ab8de327b25064afd466f0bd7bb3c7903.1374232738.git.amit.shah__17078.5379749306$1374233005$gmane$org@redhat.com>
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

Port unplug can race with close() in port_fops_release().
port_fops_release() already takes the necessary locks, ensure
unplug_port() does that too.

CC: <stable@vger.kernel.org>
Signed-off-by: Amit Shah <amit.shah@redhat.com>
---
 drivers/char/virtio_console.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/char/virtio_console.c b/drivers/char/virtio_console.c
index c9faea1..bdfb814 100644
--- a/drivers/char/virtio_console.c
+++ b/drivers/char/virtio_console.c
@@ -1545,6 +1545,7 @@ static void unplug_port(struct port *port)
 	list_del(&port->list);
 	spin_unlock_irq(&port->portdev->ports_lock);
 
+	spin_lock_irq(&port->inbuf_lock);
 	if (port->guest_connected) {
 		/* Let the app know the port is going down. */
 		send_sigio_to_port(port);
@@ -1555,6 +1556,7 @@ static void unplug_port(struct port *port)
 
 		wake_up_interruptible(&port->waitqueue);
 	}
+	spin_unlock_irq(&port->inbuf_lock);
 
 	if (is_console_port(port)) {
 		spin_lock_irq(&pdrvdata_lock);
-- 
1.8.1.4
