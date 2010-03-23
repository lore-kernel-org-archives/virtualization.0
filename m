From: Amit Shah <amit.shah@redhat.com>
Subject: [PATCH 8/8] virtio: console: Add partial blocking/non-blocking
	support to write()
Date: Tue, 23 Mar 2010 18:23:16 +0530
Message-ID: <1269348796-8660-9-git-send-email-amit.shah@redhat.com>
References: <1269348796-8660-1-git-send-email-amit.shah@redhat.com>
	<1269348796-8660-2-git-send-email-amit.shah@redhat.com>
	<1269348796-8660-3-git-send-email-amit.shah@redhat.com>
	<1269348796-8660-4-git-send-email-amit.shah@redhat.com>
	<1269348796-8660-5-git-send-email-amit.shah@redhat.com>
	<1269348796-8660-6-git-send-email-amit.shah@redhat.com>
	<1269348796-8660-7-git-send-email-amit.shah@redhat.com>
	<1269348796-8660-8-git-send-email-amit.shah@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <1269348796-8660-8-git-send-email-amit.shah@redhat.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: virtualization@lists.linux-foundation.org
Cc: Amit Shah <amit.shah@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>
List-Id: virtualization@lists.linuxfoundation.org

If the host port is not open, a write() should either just return if the
file is opened in non-blocking mode, or block till the host port is
opened.

This is just half of the blocking/non-blocking story.

The other half will be addressed when we get rid of the cpu_relax() in
send_buf(). Add a fixme mentioning that case.

Signed-off-by: Amit Shah <amit.shah@redhat.com>
---
 drivers/char/virtio_console.c |   18 ++++++++++++++++++
 1 files changed, 18 insertions(+), 0 deletions(-)

diff --git a/drivers/char/virtio_console.c b/drivers/char/virtio_console.c
index f33ceaa..fa616aa 100644
--- a/drivers/char/virtio_console.c
+++ b/drivers/char/virtio_console.c
@@ -536,6 +536,24 @@ static ssize_t port_fops_write(struct file *filp, const char __user *ubuf,
 
 	port = filp->private_data;
 
+	if (!port->host_connected) {
+		/*
+		 * FIXME: Also check if the vq has enough room to send
+		 * this buffer out to the guest.  Return EAGAIN or
+		 * block in case there's no room.  Currently the vq
+		 * always has room because we only use one buffer (and
+		 * cpu_relax()), but when send_buf() becomes
+		 * non-spinning, we'll use more buffers.
+		 */
+		if (filp->f_flags & O_NONBLOCK)
+			return -EAGAIN;
+
+		ret = wait_event_interruptible(port->waitqueue,
+					       port->host_connected);
+		if (ret < 0)
+			return ret;
+	}
+
 	count = min((size_t)(32 * 1024), count);
 
 	buf = kmalloc(count, GFP_KERNEL);
-- 
1.6.2.5
