From: Amit Shah <amit.shah@redhat.com>
Subject: [PATCH 05/14] virtio: console: Unblock poll on port hot-unplug
Date: Thu,  2 Sep 2010 18:11:44 +0530
Message-ID: <6c1e8d3ce78d70f0b55c7fa8ac7c0481da7b7942.1283430900.git.amit.shah@redhat.com>
References: <cover.1283430900.git.amit.shah@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <cover.1283430900.git.amit.shah@redhat.com>
In-Reply-To: <cover.1283430900.git.amit.shah@redhat.com>
References: <cover.1283430900.git.amit.shah@redhat.com>
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
Cc: Amit Shah <amit.shah@redhat.com>, Virtualization List <virtualization@lists.linux-foundation.org>
List-Id: virtualization@lists.linuxfoundation.org

When a port is hot-unplugged while an app is blocked on poll(), unblock
the poll() and return.

Signed-off-by: Amit Shah <amit.shah@redhat.com>
---
 drivers/char/virtio_console.c |    4 ++++
 1 files changed, 4 insertions(+), 0 deletions(-)

diff --git a/drivers/char/virtio_console.c b/drivers/char/virtio_console.c
index 488d250..c8a5678 100644
--- a/drivers/char/virtio_console.c
+++ b/drivers/char/virtio_console.c
@@ -648,6 +648,10 @@ static unsigned int port_fops_poll(struct file *filp, poll_table *wait)
 	port = filp->private_data;
 	poll_wait(filp, &port->waitqueue, wait);
 
+	if (!port->guest_connected) {
+		/* Port got unplugged */
+		return POLLHUP;
+	}
 	ret = 0;
 	if (port->inbuf)
 		ret |= POLLIN | POLLRDNORM;
-- 
1.7.2.2
