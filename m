From: Amit Shah <amit.shah@redhat.com>
Subject: [PATCH 10/11] virtio: console: Rename wait_is_over() to
	will_read_block()
Date: Thu,  8 Apr 2010 20:19:39 +0530
Message-ID: <1270738180-21170-11-git-send-email-amit.shah@redhat.com>
References: <1270738180-21170-1-git-send-email-amit.shah@redhat.com>
	<1270738180-21170-2-git-send-email-amit.shah@redhat.com>
	<1270738180-21170-3-git-send-email-amit.shah@redhat.com>
	<1270738180-21170-4-git-send-email-amit.shah@redhat.com>
	<1270738180-21170-5-git-send-email-amit.shah@redhat.com>
	<1270738180-21170-6-git-send-email-amit.shah@redhat.com>
	<1270738180-21170-7-git-send-email-amit.shah@redhat.com>
	<1270738180-21170-8-git-send-email-amit.shah@redhat.com>
	<1270738180-21170-9-git-send-email-amit.shah@redhat.com>
	<1270738180-21170-10-git-send-email-amit.shah@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <1270738180-21170-10-git-send-email-amit.shah@redhat.com>
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

We'll introduce a function that checks if write will block.  Have
function names that are similar for the two cases.

Signed-off-by: Amit Shah <amit.shah@redhat.com>
---
 drivers/char/virtio_console.c |    6 +++---
 1 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/char/virtio_console.c b/drivers/char/virtio_console.c
index 567acbd..03d9229 100644
--- a/drivers/char/virtio_console.c
+++ b/drivers/char/virtio_console.c
@@ -479,9 +479,9 @@ static ssize_t fill_readbuf(struct port *port, char *out_buf, size_t out_count,
 }
 
 /* The condition that must be true for polling to end */
-static bool wait_is_over(struct port *port)
+static bool will_read_block(struct port *port)
 {
-	return port_has_data(port) || !port->host_connected;
+	return !port_has_data(port) && port->host_connected;
 }
 
 static ssize_t port_fops_read(struct file *filp, char __user *ubuf,
@@ -504,7 +504,7 @@ static ssize_t port_fops_read(struct file *filp, char __user *ubuf,
 			return -EAGAIN;
 
 		ret = wait_event_interruptible(port->waitqueue,
-					       wait_is_over(port));
+					       !will_read_block(port));
 		if (ret < 0)
 			return ret;
 	}
-- 
1.6.2.5
