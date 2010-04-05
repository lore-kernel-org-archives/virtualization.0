From: Amit Shah <amit.shah@redhat.com>
Subject: [PATCH 09/10] virtio: console: Rename wait_is_over() to
	will_read_block()
Date: Mon,  5 Apr 2010 19:24:13 +0530
Message-ID: <1270475654-399-10-git-send-email-amit.shah@redhat.com>
References: <1270475654-399-1-git-send-email-amit.shah@redhat.com>
	<1270475654-399-2-git-send-email-amit.shah@redhat.com>
	<1270475654-399-3-git-send-email-amit.shah@redhat.com>
	<1270475654-399-4-git-send-email-amit.shah@redhat.com>
	<1270475654-399-5-git-send-email-amit.shah@redhat.com>
	<1270475654-399-6-git-send-email-amit.shah@redhat.com>
	<1270475654-399-7-git-send-email-amit.shah@redhat.com>
	<1270475654-399-8-git-send-email-amit.shah@redhat.com>
	<1270475654-399-9-git-send-email-amit.shah@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <1270475654-399-9-git-send-email-amit.shah@redhat.com>
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

We'll introduce a function that checks if write will block.  Have
function names that are similar for the two cases.

Signed-off-by: Amit Shah <amit.shah@redhat.com>
---
 drivers/char/virtio_console.c |    6 +++---
 1 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/char/virtio_console.c b/drivers/char/virtio_console.c
index 3d70729..680ea25 100644
--- a/drivers/char/virtio_console.c
+++ b/drivers/char/virtio_console.c
@@ -486,9 +486,9 @@ static ssize_t fill_readbuf(struct port *port, char *out_buf, size_t out_count,
 }
 
 /* The condition that must be true for polling to end */
-static bool wait_is_over(struct port *port)
+static bool will_read_block(struct port *port)
 {
-	return port_has_data(port) || !port->host_connected;
+	return !port_has_data(port) && port->host_connected;
 }
 
 static ssize_t port_fops_read(struct file *filp, char __user *ubuf,
@@ -511,7 +511,7 @@ static ssize_t port_fops_read(struct file *filp, char __user *ubuf,
 			return -EAGAIN;
 
 		ret = wait_event_interruptible(port->waitqueue,
-					       wait_is_over(port));
+					       !will_read_block(port));
 		if (ret < 0)
 			return ret;
 	}
-- 
1.6.2.5
