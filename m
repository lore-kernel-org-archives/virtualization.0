From: Amit Shah <amit.shah@redhat.com>
Subject: [PATCH v3 5/9] virtio: console: return -ENODEV on all read operations
	after unplug
Date: Thu, 25 Jul 2013 19:28:45 +0530
Message-ID: <f218052d8d8438fea0d1c3483434e315c7e82db8.1374759439.git.amit.shah__5652.72017051956$1374760798$gmane$org@redhat.com>
References: <cover.1374759439.git.amit.shah@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <cover.1374759439.git.amit.shah@redhat.com>
In-Reply-To: <cover.1374759439.git.amit.shah@redhat.com>
References: <cover.1374759439.git.amit.shah@redhat.com>
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

If a port gets unplugged while a user is blocked on read(), -ENODEV is
returned.  However, subsequent read()s returned 0, indicating there's no
host-side connection (but not indicating the device went away).

This also happened when a port was unplugged and the user didn't have
any blocking operation pending.  If the user didn't monitor the SIGIO
signal, they won't have a chance to find out if the port went away.

Fix by returning -ENODEV on all read()s after the port gets unplugged.
write() already behaves this way.

CC: <stable@vger.kernel.org>
Signed-off-by: Amit Shah <amit.shah@redhat.com>
---
 drivers/char/virtio_console.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/char/virtio_console.c b/drivers/char/virtio_console.c
index 3435348..2b68075 100644
--- a/drivers/char/virtio_console.c
+++ b/drivers/char/virtio_console.c
@@ -749,6 +749,10 @@ static ssize_t port_fops_read(struct file *filp, char __user *ubuf,
 
 	port = filp->private_data;
 
+	/* Port is hot-unplugged. */
+	if (!port->guest_connected)
+		return -ENODEV;
+
 	if (!port_has_data(port)) {
 		/*
 		 * If nothing's connected on the host just return 0 in
@@ -765,7 +769,7 @@ static ssize_t port_fops_read(struct file *filp, char __user *ubuf,
 		if (ret < 0)
 			return ret;
 	}
-	/* Port got hot-unplugged. */
+	/* Port got hot-unplugged while we were waiting above. */
 	if (!port->guest_connected)
 		return -ENODEV;
 	/*
-- 
1.8.1.4
