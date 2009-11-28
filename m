From: Amit Shah <amit.shah@redhat.com>
Subject: [PATCH 15/28] virtio: console: Separate out console init into a new
	function
Date: Sat, 28 Nov 2009 12:20:38 +0530
Message-ID: <1259391051-7752-16-git-send-email-amit.shah@redhat.com>
References: <1259391051-7752-1-git-send-email-amit.shah@redhat.com>
	<1259391051-7752-2-git-send-email-amit.shah@redhat.com>
	<1259391051-7752-3-git-send-email-amit.shah@redhat.com>
	<1259391051-7752-4-git-send-email-amit.shah@redhat.com>
	<1259391051-7752-5-git-send-email-amit.shah@redhat.com>
	<1259391051-7752-6-git-send-email-amit.shah@redhat.com>
	<1259391051-7752-7-git-send-email-amit.shah@redhat.com>
	<1259391051-7752-8-git-send-email-amit.shah@redhat.com>
	<1259391051-7752-9-git-send-email-amit.shah@redhat.com>
	<1259391051-7752-10-git-send-email-amit.shah@redhat.com>
	<1259391051-7752-11-git-send-email-amit.shah@redhat.com>
	<1259391051-7752-12-git-send-email-amit.shah@redhat.com>
	<1259391051-7752-13-git-send-email-amit.shah@redhat.com>
	<1259391051-7752-14-git-send-email-amit.shah@redhat.com>
	<1259391051-7752-15-git-send-email-amit.shah@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <1259391051-7752-15-git-send-email-amit.shah@redhat.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: rusty@rustcorp.com.au
Cc: Amit Shah <amit.shah@redhat.com>, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

Console ports could be hot-added. Also, with the new multiport support,
a port is identified as a console port only if the host sends a control
message.

Move the console port init into a separate function so it can be invoked
from other places.

Signed-off-by: Amit Shah <amit.shah@redhat.com>
---
 drivers/char/virtio_console.c |   63 ++++++++++++++++++++++++++---------------
 1 files changed, 40 insertions(+), 23 deletions(-)

diff --git a/drivers/char/virtio_console.c b/drivers/char/virtio_console.c
index da8a3ff..64a927c 100644
--- a/drivers/char/virtio_console.c
+++ b/drivers/char/virtio_console.c
@@ -367,6 +367,43 @@ int __init virtio_cons_early_init(int (*put_chars)(u32, const char *, int))
 	return hvc_instantiate(0, 0, &hv_ops);
 }
 
+int init_port_console(struct port *port)
+{
+	int ret;
+
+	/*
+	 * The Host's telling us this port is a console port.  Hook it
+	 * up with an hvc console.
+	 *
+	 * To set up and manage our virtual console, we call
+	 * hvc_alloc().
+	 *
+	 * The first argument of hvc_alloc() is the virtual console
+	 * number.  The second argument is the parameter for the
+	 * notification mechanism (like irq number).  We currently
+	 * leave this as zero, virtqueues have implicit notifications.
+	 *
+	 * The third argument is a "struct hv_ops" containing the
+	 * put_chars() get_chars(), notifier_add() and notifier_del()
+	 * pointers.  The final argument is the output buffer size: we
+	 * can do any size, so we put PAGE_SIZE here.
+	 */
+	port->cons.vtermno = pdrvdata.next_vtermno;
+
+	port->cons.hvc = hvc_alloc(port->cons.vtermno, 0, &hv_ops, PAGE_SIZE);
+	if (IS_ERR(port->cons.hvc)) {
+		ret = PTR_ERR(port->cons.hvc);
+		port->cons.hvc = NULL;
+		return ret;
+	}
+	spin_lock_irq(&pdrvdata_lock);
+	pdrvdata.next_vtermno++;
+	list_add_tail(&port->cons.list, &pdrvdata.consoles);
+	spin_unlock_irq(&pdrvdata_lock);
+
+	return 0;
+}
+
 static struct port_buffer *get_buf(size_t buf_size)
 {
 	struct port_buffer *buf;
@@ -537,32 +574,12 @@ static int __devinit add_port(struct ports_device *portdev)
 
 	port->portdev = portdev;
 
-	/*
-	 * The first argument of hvc_alloc() is the virtual console
-	 * number.  The second argument is the parameter for the
-	 * notification mechanism (like irq number).  We currently
-	 * leave this as zero, virtqueues have implicit notifications.
-	 *
-	 * The third argument is a "struct hv_ops" containing the
-	 * put_chars(), get_chars(), notifier_add() and notifier_del()
-	 * pointers.  The final argument is the output buffer size: we
-	 * can do any size, so we put PAGE_SIZE here.
-	 */
-	port->cons.vtermno = pdrvdata.next_vtermno;
-	port->cons.hvc = hvc_alloc(port->cons.vtermno, 0, &hv_ops, PAGE_SIZE);
-	if (IS_ERR(port->cons.hvc)) {
-		err = PTR_ERR(port->cons.hvc);
-		goto free;
-	}
-
 	spin_lock_init(&port->readbuf_list_lock);
 	INIT_LIST_HEAD(&port->readbuf_head);
 
-	/* Add to vtermno list. */
-	spin_lock_irq(&pdrvdata_lock);
-	pdrvdata.next_vtermno++;
-	list_add(&port->cons.list, &pdrvdata.consoles);
-	spin_unlock_irq(&pdrvdata_lock);
+	err = init_port_console(port);
+	if (err)
+		goto free;
 
 	return 0;
 free:
-- 
1.6.2.5
