From: SF Markus Elfring <elfring@users.sourceforge.net>
Subject: [PATCH 11/11] virtio_console: Rename a jump label in five functions
Date: Wed, 14 Sep 2016 16:10:04 +0200
Message-ID: <3fe1a284-eda5-9951-c978-17fa4ea7d501@users.sourceforge.net>
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
Date: Wed, 14 Sep 2016 15:37:52 +0200

Adjust a jump label according to the current Linux coding style convention.
Thus replace the identifier "out" by "unlock".

Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
---
 drivers/char/virtio_console.c | 20 ++++++++++----------
 1 file changed, 10 insertions(+), 10 deletions(-)

diff --git a/drivers/char/virtio_console.c b/drivers/char/virtio_console.c
index 0c4d4e7..6c90c9c 100644
--- a/drivers/char/virtio_console.c
+++ b/drivers/char/virtio_console.c
@@ -257,11 +257,11 @@ static struct port *find_port_by_vtermno(u32 vtermno)
 	list_for_each_entry(cons, &pdrvdata.consoles, list) {
 		if (cons->vtermno == vtermno) {
 			port = container_of(cons, struct port, cons);
-			goto out;
+			goto unlock;
 		}
 	}
 	port = NULL;
-out:
+ unlock:
 	spin_unlock_irqrestore(&pdrvdata_lock, flags);
 	return port;
 }
@@ -276,11 +276,11 @@ static struct port *find_port_by_devt_in_portdev(struct ports_device *portdev,
 	list_for_each_entry(port, &portdev->ports, list) {
 		if (port->cdev->dev == dev) {
 			kref_get(&port->kref);
-			goto out;
+			goto unlock;
 		}
 	}
 	port = NULL;
-out:
+ unlock:
 	spin_unlock_irqrestore(&portdev->ports_lock, flags);
 
 	return port;
@@ -296,10 +296,10 @@ static struct port *find_port_by_devt(dev_t dev)
 	list_for_each_entry(portdev, &pdrvdata.portdevs, list) {
 		port = find_port_by_devt_in_portdev(portdev, dev);
 		if (port)
-			goto out;
+			goto unlock;
 	}
 	port = NULL;
-out:
+ unlock:
 	spin_unlock_irqrestore(&pdrvdata_lock, flags);
 	return port;
 }
@@ -312,9 +312,9 @@ static struct port *find_port_by_id(struct ports_device *portdev, u32 id)
 	spin_lock_irqsave(&portdev->ports_lock, flags);
 	list_for_each_entry(port, &portdev->ports, list)
 		if (port->id == id)
-			goto out;
+			goto unlock;
 	port = NULL;
-out:
+ unlock:
 	spin_unlock_irqrestore(&portdev->ports_lock, flags);
 
 	return port;
@@ -329,9 +329,9 @@ static struct port *find_port_by_vq(struct ports_device *portdev,
 	spin_lock_irqsave(&portdev->ports_lock, flags);
 	list_for_each_entry(port, &portdev->ports, list)
 		if (port->in_vq == vq || port->out_vq == vq)
-			goto out;
+			goto unlock;
 	port = NULL;
-out:
+ unlock:
 	spin_unlock_irqrestore(&portdev->ports_lock, flags);
 	return port;
 }
-- 
2.10.0
