From: Amit Shah <amit.shah@redhat.com>
Subject: [PATCH 05/10] virtio: console: update private_data in struct file
	only on successful open
Date: Fri, 19 Jul 2013 01:46:12 +0530
Message-ID: <a012f8e8c562c84c2302e57e5360291ef7d4ff21.1374177234.git.amit.shah__9892.56578400291$1374178641$gmane$org@redhat.com>
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
Cc: Amit Shah <amit.shah@redhat.com>, stable@vger.kernel.org
List-Id: virtualization@lists.linuxfoundation.org

Mateusz Guzik points out that we update the 'file' struct's private_data
field before we've successfully done all our checks.  This means we can
return an error with the private_data field updated.  This could lead to
problems.

Fix by moving the assignment after all checks are done.

CC: <stable@vger.kernel.org>
Reported-by: Mateusz Guzik <mguzik@redhat.com>
Signed-off-by: Amit Shah <amit.shah@redhat.com>
---
 drivers/char/virtio_console.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/char/virtio_console.c b/drivers/char/virtio_console.c
index a39702a..7728af9 100644
--- a/drivers/char/virtio_console.c
+++ b/drivers/char/virtio_console.c
@@ -1032,7 +1032,6 @@ static int port_fops_open(struct inode *inode, struct file *filp)
 		/* Port was unplugged before we could proceed */
 		return -ENXIO;
 	}
-	filp->private_data = port;
 
 	/*
 	 * Don't allow opening of console port devices -- that's done
@@ -1051,6 +1050,7 @@ static int port_fops_open(struct inode *inode, struct file *filp)
 		goto out;
 	}
 
+	filp->private_data = port;
 	port->guest_connected = true;
 	spin_unlock_irq(&port->inbuf_lock);
 
-- 
1.8.1.4
