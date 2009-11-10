From: Rusty Russell <rusty@rustcorp.com.au>
Subject: [PATCH 6/8] virtio: console: don't assume a single console port.
Date: Tue, 10 Nov 2009 16:57:30 +1030
Message-ID: <2142.36183460361$1257834668@news.gmane.org>
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
To: virtualization@linux-foundation.org
Cc: Amit Shah <amit.shah@redhat.com>
List-Id: virtualization@lists.linuxfoundation.org


Keep a list of all ports being used as a console, and provide a lock
and a lookup function.  The hvc callbacks only give us a vterm number,
so we need to map this.

Signed-off-by: Rusty Russell <rusty@rustcorp.com.au>
---
 drivers/char/virtio_console.c |   42 ++++++++++++++++++++++++++++++++++++++----
 1 file changed, 38 insertions(+), 4 deletions(-)

diff --git a/drivers/char/virtio_console.c b/drivers/char/virtio_console.c
--- a/drivers/char/virtio_console.c
+++ b/drivers/char/virtio_console.c
@@ -28,16 +28,45 @@ struct port {
 	char *inbuf;
 	unsigned int used_len, offset;
 
+	/* For console ports, hvc != NULL and these are valid. */
 	/* The hvc device */
 	struct hvc_struct *hvc;
+
+	/* ports_by_vtermno */
+	struct list_head vtermno_list;
+
+	/* Our vterm number. */
+	u32 vtermno;
 };
 
+/* The list of ports. */
+static LIST_HEAD(ports_by_vtermno);
+
+/* The lock on the port list. */
+static DEFINE_SPINLOCK(ports_by_vtermno_lock);
+
 /* We have one port ready to go immediately, for a console. */
 static struct port console;
 
 /* This is the very early put chars function. */
 static int (*early_put_chars)(u32, const char *, int);
 
+static struct port *find_port_by_vtermno(u32 vtermno)
+{
+	unsigned long flags;
+	struct port *port;
+
+	spin_lock_irqsave(&ports_by_vtermno_lock, flags);
+	list_for_each_entry(port, &ports_by_vtermno, vtermno_list) {
+		if (port->hvc && port->vtermno == vtermno)
+			goto out;
+	}
+	port = NULL;
+out:
+	spin_unlock_irqrestore(&ports_by_vtermno_lock, flags);
+	return port;
+}
+
 /* The put_chars() callback is pretty straightforward.
  *
  * We turn the characters into a scatter-gather list, add it to the output
@@ -48,7 +77,7 @@ static int put_chars(u32 vtermno, const 
 {
 	struct scatterlist sg[1];
 	unsigned int len;
-	struct port *port = &console;
+	struct port *port = find_port_by_vtermno(vtermno);
 
 	if (unlikely(early_put_chars))
 		return early_put_chars(vtermno, buf, count);
@@ -89,7 +118,7 @@ static void add_inbuf(struct port *port)
  * for partially-filled buffers. */
 static int get_chars(u32 vtermno, char *buf, int count)
 {
-	struct port *port = &console;
+	struct port *port = find_port_by_vtermno(vtermno);
 
 	/* If we don't have an input queue yet, we can't get input. */
 	BUG_ON(!port->in_vq);
@@ -137,13 +166,13 @@ static void virtcons_apply_config(struct
 }
 
 /*
- * we support only one console, the hvc struct is a global var
  * We set the configuration at this point, since we now have a tty
  */
 static int notifier_add_vio(struct hvc_struct *hp, int data)
 {
+	struct port *port = find_port_by_vtermno(hp->vtermno);
 	hp->irq_requested = 1;
-	virtcons_apply_config(console.vdev);
+	virtcons_apply_config(port->vdev);
 
 	return 0;
 }
@@ -232,6 +261,11 @@ static int __devinit virtcons_probe(stru
 		goto free_vqs;
 	}
 
+	/* Add to vtermno list. */
+	spin_lock_irq(&ports_by_vtermno_lock);
+	list_add(&port->vtermno_list, &ports_by_vtermno);
+	spin_unlock_irq(&ports_by_vtermno_lock);
+
 	/* Register the input buffer the first time. */
 	add_inbuf(port);
