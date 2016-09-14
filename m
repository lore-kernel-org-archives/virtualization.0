From: SF Markus Elfring <elfring@users.sourceforge.net>
Subject: [PATCH 01/11] virtio_console: Use kmalloc_array() in init_vqs()
Date: Wed, 14 Sep 2016 16:00:05 +0200
Message-ID: <d47781b3-2e40-e887-b826-7eac1d5069ac__11420.1947035783$1473861653$gmane$org@users.sourceforge.net>
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
Date: Wed, 14 Sep 2016 11:23:59 +0200

* Multiplications for the size determination of memory allocations
  indicated that array data structures should be processed.
  Thus use the corresponding function "kmalloc_array".

  This issue was detected by using the Coccinelle software.

* Replace the specifications of data types by pointer dereferences
  to make the corresponding size determination a bit safer according to
  the Linux coding style convention.

Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
---
 drivers/char/virtio_console.c | 18 +++++++++++-------
 1 file changed, 11 insertions(+), 7 deletions(-)

diff --git a/drivers/char/virtio_console.c b/drivers/char/virtio_console.c
index d2406fe..325ebc6 100644
--- a/drivers/char/virtio_console.c
+++ b/drivers/char/virtio_console.c
@@ -1881,13 +1881,17 @@ static int init_vqs(struct ports_device *portdev)
 	nr_ports = portdev->config.max_nr_ports;
 	nr_queues = use_multiport(portdev) ? (nr_ports + 1) * 2 : 2;
 
-	vqs = kmalloc(nr_queues * sizeof(struct virtqueue *), GFP_KERNEL);
-	io_callbacks = kmalloc(nr_queues * sizeof(vq_callback_t *), GFP_KERNEL);
-	io_names = kmalloc(nr_queues * sizeof(char *), GFP_KERNEL);
-	portdev->in_vqs = kmalloc(nr_ports * sizeof(struct virtqueue *),
-				  GFP_KERNEL);
-	portdev->out_vqs = kmalloc(nr_ports * sizeof(struct virtqueue *),
-				   GFP_KERNEL);
+	vqs = kmalloc_array(nr_queues, sizeof(*vqs), GFP_KERNEL);
+	io_callbacks = kmalloc_array(nr_queues,
+				     sizeof(*io_callbacks),
+				     GFP_KERNEL);
+	io_names = kmalloc_array(nr_queues, sizeof(*io_names), GFP_KERNEL);
+	portdev->in_vqs = kmalloc_array(nr_ports,
+					sizeof(*portdev->in_vqs),
+					GFP_KERNEL);
+	portdev->out_vqs = kmalloc_array(nr_ports,
+					 sizeof(*portdev->out_vqs),
+					 GFP_KERNEL);
 	if (!vqs || !io_callbacks || !io_names || !portdev->in_vqs ||
 	    !portdev->out_vqs) {
 		err = -ENOMEM;
-- 
2.10.0
