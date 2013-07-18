From: Amit Shah <amit.shah@redhat.com>
Subject: [PATCH 06/10] virtio: console: fix race in port_fops_poll() and port
	unplug
Date: Fri, 19 Jul 2013 01:46:13 +0530
Message-ID: <bb9fe1cb5a1aeff6ecfc68936254045024e25e56.1374177234.git.amit.shah@redhat.com>
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

Between poll() being called and processed, the port can be unplugged.
Check if this happened, and bail out.

Signed-off-by: Amit Shah <amit.shah@redhat.com>
---
 drivers/char/virtio_console.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/char/virtio_console.c b/drivers/char/virtio_console.c
index 7728af9..1d4b748 100644
--- a/drivers/char/virtio_console.c
+++ b/drivers/char/virtio_console.c
@@ -967,6 +967,10 @@ static unsigned int port_fops_poll(struct file *filp, poll_table *wait)
 	unsigned int ret;
 
 	port = filp->private_data;
+	if (!port->guest_connected) {
+		/* Port was unplugged before we could proceed */
+		return POLLHUP;
+	}
 	poll_wait(filp, &port->waitqueue, wait);
 
 	if (!port->guest_connected) {
-- 
1.8.1.4
