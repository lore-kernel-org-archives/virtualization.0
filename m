From: Amit Shah <amit.shah@redhat.com>
Subject: [PATCH] virtio: console: Don't block entire guest if host doesn't
	read data
Date: Tue, 19 Oct 2010 11:15:57 +0530
Message-ID: <baecf865292e0cc96914d30fc601e3a96fad9845.1287467155.git.amit.shah@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
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
Cc: Amit Shah <amit.shah@redhat.com>, Hans de Goede <hdegoede@redhat.com>, stable@kernel.org
List-Id: virtualization@lists.linuxfoundation.org

If the host is slow in reading data or doesn't read data at all,
blocking write calls not only blocked the program that called write()
but the entire guest itself.

To overcome this, let's not block till the host signals it has given
back the virtio ring element we passed it.  Instead, send the buffer to
the host and return to userspace.  This operation then becomes similar
to how non-blocking writes work, so let's use the existing code for this
path as well.

This code change also ensures blocking write calls do get blocked if
there's not enough room in the virtio ring as well as they don't return
-EAGAIN to userspace.

Signed-off-by: Amit Shah <amit.shah@redhat.com>
CC: stable@kernel.org
---
 drivers/char/virtio_console.c |   17 ++++++++++++++---
 1 files changed, 14 insertions(+), 3 deletions(-)

diff --git a/drivers/char/virtio_console.c b/drivers/char/virtio_console.c
index c810481..0f69c5e 100644
--- a/drivers/char/virtio_console.c
+++ b/drivers/char/virtio_console.c
@@ -459,9 +459,12 @@ static ssize_t send_buf(struct port *port, void *in_buf, size_t in_count,
 
 	/*
 	 * Wait till the host acknowledges it pushed out the data we
-	 * sent.  This is done for ports in blocking mode or for data
-	 * from the hvc_console; the tty operations are performed with
-	 * spinlocks held so we can't sleep here.
+	 * sent.  This is done for data from the hvc_console; the tty
+	 * operations are performed with spinlocks held so we can't
+	 * sleep here.  An alternative would be to copy the data to a
+	 * buffer and relax the spinning requirement.  The downside is
+	 * we need to kmalloc a GFP_ATOMIC buffer each time the
+	 * console driver writes something out.
 	 */
 	while (!virtqueue_get_buf(out_vq, &len))
 		cpu_relax();
@@ -626,6 +629,14 @@ static ssize_t port_fops_write(struct file *filp, const char __user *ubuf,
 		goto free_buf;
 	}
 
+	/*
+	 * We now ask send_buf() to not spin for generic ports -- we
+	 * can re-use the same code path that non-blocking file
+	 * descriptors take for blocking file descriptors since the
+	 * wait is already done and we're certain the write will go
+	 * through to the host.
+	 */
+	nonblock = true;
 	ret = send_buf(port, buf, count, nonblock);
 
 	if (nonblock && ret > 0)
-- 
1.7.2.3
