From: Amit Shah <amit.shah@redhat.com>
Subject: [PATCH 11/14] virtio: console: Add a find_port_by_devt() function
Date: Thu,  2 Sep 2010 18:20:58 +0530
Message-ID: <873688373617732c891878f78eb15447ccd00fd9.1283430900.git.amit.shah@redhat.com>
References: <cover.1283430900.git.amit.shah@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <cover.1283430900.git.amit.shah@redhat.com>
In-Reply-To: <cover.1283430900.git.amit.shah@redhat.com>
References: <cover.1283430900.git.amit.shah@redhat.com>
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
Cc: Amit Shah <amit.shah@redhat.com>, Virtualization List <virtualization@lists.linux-foundation.org>
List-Id: virtualization@lists.linuxfoundation.org

To convert to using cdev as a pointer to avoid kref troubles, we have to
use a different method to get to a port from an inode than the current
container_of method.

Add find_port_by_devt() that looks up all portdevs and ports with those
portdevs to find the right port.

Signed-off-by: Amit Shah <amit.shah@redhat.com>
---
 drivers/char/virtio_console.c |   37 ++++++++++++++++++++++++++++++++++++-
 1 files changed, 36 insertions(+), 1 deletions(-)

diff --git a/drivers/char/virtio_console.c b/drivers/char/virtio_console.c
index a37a868..af44332 100644
--- a/drivers/char/virtio_console.c
+++ b/drivers/char/virtio_console.c
@@ -227,6 +227,41 @@ out:
 	return port;
 }
 
+static struct port *find_port_by_devt_in_portdev(struct ports_device *portdev,
+						 dev_t dev)
+{
+	struct port *port;
+	unsigned long flags;
+
+	spin_lock_irqsave(&portdev->ports_lock, flags);
+	list_for_each_entry(port, &portdev->ports, list)
+		if (port->cdev.dev == dev)
+			goto out;
+	port = NULL;
+out:
+	spin_unlock_irqrestore(&portdev->ports_lock, flags);
+
+	return port;
+}
+
+static struct port *find_port_by_devt(dev_t dev)
+{
+	struct ports_device *portdev;
+	struct port *port;
+	unsigned long flags;
+
+	spin_lock_irqsave(&pdrvdata_lock, flags);
+	list_for_each_entry(portdev, &pdrvdata.portdevs, list) {
+		port = find_port_by_devt_in_portdev(portdev, dev);
+		if (port)
+			goto out;
+	}
+	port = NULL;
+out:
+	spin_unlock_irqrestore(&pdrvdata_lock, flags);
+	return port;
+}
+
 static struct port *find_port_by_id(struct ports_device *portdev, u32 id)
 {
 	struct port *port;
@@ -704,7 +739,7 @@ static int port_fops_open(struct inode *inode, struct file *filp)
 	struct port *port;
 	int ret;
 
-	port = container_of(cdev, struct port, cdev);
+	port = find_port_by_devt(cdev->dev);
 	filp->private_data = port;
 
 	/*
-- 
1.7.2.2
