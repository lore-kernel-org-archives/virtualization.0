From: Amit Shah <amit.shah@redhat.com>
Subject: [PATCH 07/14] virtio: console: Make write() return -ENODEV on
	hot-unplug
Date: Thu,  2 Sep 2010 18:11:46 +0530
Message-ID: <27331617cfce8b8f39d892ddcbbf4472c1f85372.1283430900.git.amit.shah@redhat.com>
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

When a port is hot-unplugged while an app was blocked on a write() call,
the call was unblocked but would not get an error returned.

Return -ENODEV to ensure the app knows the port has gone away.

Signed-off-by: Amit Shah <amit.shah@redhat.com>
---
 drivers/char/virtio_console.c |    3 +++
 1 files changed, 3 insertions(+), 0 deletions(-)

diff --git a/drivers/char/virtio_console.c b/drivers/char/virtio_console.c
index 7fa3c26..ecadfa2 100644
--- a/drivers/char/virtio_console.c
+++ b/drivers/char/virtio_console.c
@@ -619,6 +619,9 @@ static ssize_t port_fops_write(struct file *filp, const char __user *ubuf,
 		if (ret < 0)
 			return ret;
 	}
+	/* Port got hot-unplugged. */
+	if (!port->guest_connected)
+		return -ENODEV;
 
 	count = min((size_t)(32 * 1024), count);
 
-- 
1.7.2.2
