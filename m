From: Amit Shah <amit.shah@redhat.com>
Subject: [RFC PATCH 5/8] virtio: console: Use wait_event_freezable instead of
	_interruptible
Date: Thu, 28 Jul 2011 20:05:10 +0530
Message-ID: <b2634bc36bb4b0ab8ddcd5cf283ae6b455adb214.1311863438.git.amit.shah@redhat.com>
References: <cover.1311863438.git.amit.shah@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <cover.1311863438.git.amit.shah@redhat.com>
In-Reply-To: <cover.1311863438.git.amit.shah@redhat.com>
References: <cover.1311863438.git.amit.shah@redhat.com>
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

Get ready to support suspend/resume by using the freezable calls so that
blocking read/write syscalls are handled properly across suspend/resume.

Signed-off-by: Amit Shah <amit.shah@redhat.com>
---
 drivers/char/virtio_console.c |    9 +++++----
 1 files changed, 5 insertions(+), 4 deletions(-)

diff --git a/drivers/char/virtio_console.c b/drivers/char/virtio_console.c
index 3c10b10..a7dfd02 100644
--- a/drivers/char/virtio_console.c
+++ b/drivers/char/virtio_console.c
@@ -21,6 +21,7 @@
 #include <linux/debugfs.h>
 #include <linux/device.h>
 #include <linux/err.h>
+#include <linux/freezer.h>
 #include <linux/fs.h>
 #include <linux/init.h>
 #include <linux/list.h>
@@ -633,8 +634,8 @@ static ssize_t port_fops_read(struct file *filp, char __user *ubuf,
 		if (filp->f_flags & O_NONBLOCK)
 			return -EAGAIN;
 
-		ret = wait_event_interruptible(port->waitqueue,
-					       !will_read_block(port));
+		ret = wait_event_freezable(port->waitqueue,
+					   !will_read_block(port));
 		if (ret < 0)
 			return ret;
 	}
@@ -677,8 +678,8 @@ static ssize_t port_fops_write(struct file *filp, const char __user *ubuf,
 		if (nonblock)
 			return -EAGAIN;
 
-		ret = wait_event_interruptible(port->waitqueue,
-					       !will_write_block(port));
+		ret = wait_event_freezable(port->waitqueue,
+					   !will_write_block(port));
 		if (ret < 0)
 			return ret;
 	}
-- 
1.7.6
