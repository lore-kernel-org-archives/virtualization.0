From: Rusty Russell <rusty@rustcorp.com.au>
Subject: [PATCH] lguest: Fix uninitialized members in example launcher
Date: Mon, 19 Nov 2007 11:10:25 +1100
Message-ID: <200711191110.25836.rusty__32779.4236284264$1195431174$gmane$org@rustcorp.com.au>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: lguest <lguest@ozlabs.org>
Cc: linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

Thanks valgrind!

Signed-off-by: Rusty Russell <rusty@rustcorp.com.au>

diff -r 1041aeb944b2 Documentation/lguest/lguest.c
--- a/Documentation/lguest/lguest.c	Tue Nov 13 15:11:06 2007 +1100
+++ b/Documentation/lguest/lguest.c	Thu Nov 15 13:28:48 2007 +1100
@@ -1040,6 +1040,11 @@ static void add_virtqueue(struct device 
 		/ getpagesize();
 	p = get_pages(pages);
 
+	/* Initialize the virtqueue */
+	vq->next = NULL;
+	vq->last_avail_idx = 0;
+	vq->dev = dev;
+
 	/* Initialize the configuration. */
 	vq->config.num = num_descs;
 	vq->config.irq = devices.next_irq++;
@@ -1056,9 +1061,6 @@ static void add_virtqueue(struct device 
 	 * second.  */
 	for (i = &dev->vq; *i; i = &(*i)->next);
 	*i = vq;
-
-	/* Link virtqueue back to device. */
-	vq->dev = dev;
 
 	/* Set the routine to call when the Guest does something to this
 	 * virtqueue. */
@@ -1093,6 +1095,7 @@ static struct device *new_device(const c
 	dev->desc = new_dev_desc(type);
 	dev->handle_input = handle_input;
 	dev->name = name;
+	dev->vq = NULL;
 	return dev;
 }
