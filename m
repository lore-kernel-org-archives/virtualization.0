From: Amit Shah <amit.shah@redhat.com>
Subject: [PATCH] virtio: console: Prevent userspace from submitting NULL
	buffers
Date: Tue, 14 Sep 2010 13:26:16 +0530
Message-ID: <e1ecf51b7dbcc8147709e0dd2fab83f437e62e68.1284450973.git.amit.shah@redhat.com>
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
To: Rusty Russell <rusty@rustcorp.com.au>
Cc: Amit Shah <amit.shah@redhat.com>, stable@kernel.org, Virtualization List <virtualization@lists.linux-foundation.org>
List-Id: virtualization@lists.linuxfoundation.org

A userspace could submit a buffer with 0 length to be written to the
host.  Prevent such a situation.

This was not needed previously, but recent changes in the way write()
works exposed this condition to trigger a virtqueue event to the host,
causing a NULL buffer to be sent across.

Signed-off-by: Amit Shah <amit.shah@redhat.com>
CC: stable@kernel.org
---
 drivers/char/virtio_console.c |    4 ++++
 1 files changed, 4 insertions(+), 0 deletions(-)

diff --git a/drivers/char/virtio_console.c b/drivers/char/virtio_console.c
index f7adfd3..be67d6b 100644
--- a/drivers/char/virtio_console.c
+++ b/drivers/char/virtio_console.c
@@ -653,6 +653,10 @@ static ssize_t port_fops_write(struct file *filp, const char __user *ubuf,
 	ssize_t ret;
 	bool nonblock;
 
+	/* Userspace could be out to fool us */
+	if (!count)
+		return 0;
+
 	port = filp->private_data;
 
 	nonblock = filp->f_flags & O_NONBLOCK;
-- 
1.7.2.2
