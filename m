From: Amit Shah <amit.shah@redhat.com>
Subject: [PATCH 2/2] virtio: console: Disable lseek(2) for port file operations
Date: Thu, 16 Sep 2010 14:43:09 +0530
Message-ID: <aafee8aecf4b692202a1121bbf04ad08aeaf40ce.1284628364.git.amit.shah@redhat.com>
References: <6c7c2590a114d65ec52689be7cda7ada5ee876d5.1284628364.git.amit.shah@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <6c7c2590a114d65ec52689be7cda7ada5ee876d5.1284628364.git.amit.shah@redhat.com>
In-Reply-To: <6c7c2590a114d65ec52689be7cda7ada5ee876d5.1284628364.git.amit.shah@redhat.com>
References: <6c7c2590a114d65ec52689be7cda7ada5ee876d5.1284628364.git.amit.shah@redhat.com>
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
Cc: Amit Shah <amit.shah@redhat.com>, Arnd Bergmann <arnd@arndb.de>, Virtualization List <virtualization@lists.linux-foundation.org>
List-Id: virtualization@lists.linuxfoundation.org

The ports are char devices; do not have seeking capabilities.  Calling
nonseekable_open() from the fops_open() call and setting the llseek fops
pointer to no_llseek ensures an lseek() call from userspace returns
-ESPIPE.

Signed-off-by: Amit Shah <amit.shah@redhat.com>
CC: Arnd Bergmann <arnd@arndb.de>
---
 drivers/char/virtio_console.c |    3 +++
 1 files changed, 3 insertions(+), 0 deletions(-)

diff --git a/drivers/char/virtio_console.c b/drivers/char/virtio_console.c
index 2dbcd41..28718a9 100644
--- a/drivers/char/virtio_console.c
+++ b/drivers/char/virtio_console.c
@@ -798,6 +798,8 @@ static int port_fops_open(struct inode *inode, struct file *filp)
 	reclaim_consumed_buffers(port);
 	spin_unlock_irq(&port->outvq_lock);
 
+	nonseekable_open(inode, filp);
+
 	/* Notify host of port being opened */
 	send_control_msg(filp->private_data, VIRTIO_CONSOLE_PORT_OPEN, 1);
 
@@ -829,6 +831,7 @@ static const struct file_operations port_fops = {
 	.poll  = port_fops_poll,
 	.release = port_fops_release,
 	.fasync = port_fops_fasync,
+	.llseek = no_llseek,
 };
 
 /*
-- 
1.7.2.3
