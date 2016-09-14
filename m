From: SF Markus Elfring <elfring@users.sourceforge.net>
Subject: [PATCH 02/11] virtio_console: Less function calls in init_vqs() after
	error detection
Date: Wed, 14 Sep 2016 16:01:28 +0200
Message-ID: <490b98e1-6129-f11f-55ff-94219ebce6d6@users.sourceforge.net>
References: <566ABCD9.1060404@users.sourceforge.net>
	<020438b9-a7f8-0050-04c1-43382ba60b75@users.sourceforge.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <020438b9-a7f8-0050-04c1-43382ba60b75@users.sourceforge.net>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: virtualization@lists.linux-foundation.org, Amit Shah <amit.shah@redhat.com>, Arnd Bergmann <arnd@arndb.de>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "Michael S. Tsirkin" <mst@redhat.com>, Rusty Russell <rusty@rustcorp.com.au>
Cc: Julia Lawall <julia.lawall@lip6.fr>, kernel-janitors@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>
List-Id: virtualization@lists.linuxfoundation.org

From: Markus Elfring <elfring@users.sourceforge.net>
Date: Wed, 14 Sep 2016 14:00:35 +0200

The kfree() function was called in up to five cases
by the init_vqs() function during error handling even if
the passed variable contained a null pointer.

* Return directly after a call of the function "kmalloc_array" failed
  at the beginning.

* Split a condition check for memory allocation failures so that
  each pointer from these function calls will be checked immediately.

  See also background information:
  Topic "CWE-754: Improper check for unusual or exceptional conditions"
  Link: https://cwe.mitre.org/data/definitions/754.html

* Adjust jump targets according to the Linux coding style convention.

Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
---
 drivers/char/virtio_console.c | 32 ++++++++++++++++++++++++++------
 1 file changed, 26 insertions(+), 6 deletions(-)

diff --git a/drivers/char/virtio_console.c b/drivers/char/virtio_console.c
index 325ebc6..bf0ad57 100644
--- a/drivers/char/virtio_console.c
+++ b/drivers/char/virtio_console.c
@@ -1882,20 +1882,37 @@ static int init_vqs(struct ports_device *portdev)
 	nr_queues = use_multiport(portdev) ? (nr_ports + 1) * 2 : 2;
 
 	vqs = kmalloc_array(nr_queues, sizeof(*vqs), GFP_KERNEL);
+	if (!vqs)
+		return -ENOMEM;
+
 	io_callbacks = kmalloc_array(nr_queues,
 				     sizeof(*io_callbacks),
 				     GFP_KERNEL);
+	if (!io_callbacks) {
+		err = -ENOMEM;
+		goto free_vqs;
+	}
+
 	io_names = kmalloc_array(nr_queues, sizeof(*io_names), GFP_KERNEL);
+	if (!io_names) {
+		err = -ENOMEM;
+		goto free_callbacks;
+	}
+
 	portdev->in_vqs = kmalloc_array(nr_ports,
 					sizeof(*portdev->in_vqs),
 					GFP_KERNEL);
+	if (!portdev->in_vqs) {
+		err = -ENOMEM;
+		goto free_names;
+	}
+
 	portdev->out_vqs = kmalloc_array(nr_ports,
 					 sizeof(*portdev->out_vqs),
 					 GFP_KERNEL);
-	if (!vqs || !io_callbacks || !io_names || !portdev->in_vqs ||
-	    !portdev->out_vqs) {
+	if (!portdev->out_vqs) {
 		err = -ENOMEM;
-		goto free;
+		goto free_in_vqs;
 	}
 
 	/*
@@ -1929,7 +1946,7 @@ static int init_vqs(struct ports_device *portdev)
 					      io_callbacks,
 					      (const char **)io_names);
 	if (err)
-		goto free;
+		goto free_out_vqs;
 
 	j = 0;
 	portdev->in_vqs[0] = vqs[0];
@@ -1950,12 +1967,15 @@ static int init_vqs(struct ports_device *portdev)
 	kfree(vqs);
 
 	return 0;
-
-free:
+ free_out_vqs:
 	kfree(portdev->out_vqs);
+ free_in_vqs:
 	kfree(portdev->in_vqs);
+ free_names:
 	kfree(io_names);
+ free_callbacks:
 	kfree(io_callbacks);
+ free_vqs:
 	kfree(vqs);
 
 	return err;
-- 
2.10.0
