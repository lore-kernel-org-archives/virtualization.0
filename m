From: Yu Zhao <yu.zhao@intel.com>
Subject: [PATCH 10/15 v5] PCI: cleanup pci_bus_add_devices()
Date: Tue, 21 Oct 2008 19:51:05 +0800
Message-ID: <20081021115105.GK3185__8463.77504426545$1224594992$gmane$org@yzhao12-linux.sh.intel.com>
References: <20081021114056.GA3185@yzhao12-linux.sh.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <20081021114056.GA3185@yzhao12-linux.sh.intel.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
Cc: "randy.dunlap@oracle.com" <randy.dunlap@oracle.com>, "grundler@parisc-linux.org" <grundler@parisc-linux.org>, "achiang@hp.com" <achiang@hp.com>, "matthew@wil.cx" <matthew@wil.cx>, "greg@kroah.com" <greg@kroah.com>, "rdreier@cisco.com" <rdreier@cisco.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "jbarnes@virtuousgeek.org" <jbarnes@virtuousgeek.org>, "virtualization@lists.linux-foundation.org" <virtualization@lists.linux-foundation.org>, "kvm@vger.kernel.org" <kvm@vger.kernel.org>
List-Id: virtualization@lists.linuxfoundation.org

This cleanup makes pci_bus_add_devices() easier to be read.
And it checks if a bus has been added before removing it.

Cc: Jesse Barnes <jbarnes@virtuousgeek.org>
Cc: Randy Dunlap <randy.dunlap@oracle.com>
Cc: Grant Grundler <grundler@parisc-linux.org>
Cc: Alex Chiang <achiang@hp.com>
Cc: Matthew Wilcox <matthew@wil.cx>
Cc: Roland Dreier <rdreier@cisco.com>
Cc: Greg KH <greg@kroah.com>
Signed-off-by: Yu Zhao <yu.zhao@intel.com>

---
 drivers/pci/bus.c    |   56 +++++++++++++++++++++++++------------------------
 drivers/pci/remove.c |    2 +
 2 files changed, 31 insertions(+), 27 deletions(-)

diff --git a/drivers/pci/bus.c b/drivers/pci/bus.c
index 999cc40..7a21602 100644
--- a/drivers/pci/bus.c
+++ b/drivers/pci/bus.c
@@ -71,7 +71,7 @@ pci_bus_alloc_resource(struct pci_bus *bus, struct resource *res,
 }
 
 /**
- * add a single device
+ * pci_bus_add_device - add a single device
  * @dev: device to add
  *
  * This adds a single pci device to the global
@@ -105,7 +105,7 @@ int pci_bus_add_device(struct pci_dev *dev)
 void pci_bus_add_devices(struct pci_bus *bus)
 {
 	struct pci_dev *dev;
-	struct pci_bus *child_bus;
+	struct pci_bus *child;
 	int retval;
 
 	list_for_each_entry(dev, &bus->devices, bus_list) {
@@ -120,39 +120,41 @@ void pci_bus_add_devices(struct pci_bus *bus)
 	list_for_each_entry(dev, &bus->devices, bus_list) {
 		BUG_ON(!dev->is_added);
 
+		child = dev->subordinate;
 		/*
 		 * If there is an unattached subordinate bus, attach
 		 * it and then scan for unattached PCI devices.
 		 */
-		if (dev->subordinate) {
-		       if (list_empty(&dev->subordinate->node)) {
-			       down_write(&pci_bus_sem);
-			       list_add_tail(&dev->subordinate->node,
-					       &dev->bus->children);
-			       up_write(&pci_bus_sem);
-			}
-			pci_bus_add_devices(dev->subordinate);
-
-			/* register the bus with sysfs as the parent is now
-			 * properly registered. */
-			child_bus = dev->subordinate;
-			if (child_bus->is_added)
-				continue;
-			child_bus->dev.parent = child_bus->bridge;
-			retval = device_register(&child_bus->dev);
-			if (retval)
-				dev_err(&dev->dev, "Error registering pci_bus,"
-					" continuing...\n");
-			else {
-				child_bus->is_added = 1;
-				retval = device_create_file(&child_bus->dev,
-							&dev_attr_cpuaffinity);
-			}
+		if (!child)
+			continue;
+		if (list_empty(&child->node)) {
+			down_write(&pci_bus_sem);
+			list_add_tail(&child->node,
+						&dev->bus->children);
+			up_write(&pci_bus_sem);
+		}
+		pci_bus_add_devices(child);
+
+		/*
+		 * register the bus with sysfs as the parent is now
+		 * properly registered.
+		 */
+		if (child->is_added)
+			continue;
+		child->dev.parent = child->bridge;
+		retval = device_register(&child->dev);
+		if (retval)
+			dev_err(&dev->dev, "Error registering pci_bus,"
+				" continuing...\n");
+		else {
+			child->is_added = 1;
+			retval = device_create_file(&child->dev,
+						&dev_attr_cpuaffinity);
 			if (retval)
 				dev_err(&dev->dev, "Error creating cpuaffinity"
 					" file, continuing...\n");
 
-			retval = device_create_file(&child_bus->dev,
+			retval = device_create_file(&child->dev,
 						&dev_attr_cpulistaffinity);
 			if (retval)
 				dev_err(&dev->dev,
diff --git a/drivers/pci/remove.c b/drivers/pci/remove.c
index 042e089..bfa0869 100644
--- a/drivers/pci/remove.c
+++ b/drivers/pci/remove.c
@@ -72,6 +72,8 @@ void pci_remove_bus(struct pci_bus *pci_bus)
 	list_del(&pci_bus->node);
 	up_write(&pci_bus_sem);
 	pci_remove_legacy_files(pci_bus);
+	if (!pci_bus->is_added)
+		return;
 	device_remove_file(&pci_bus->dev, &dev_attr_cpuaffinity);
 	device_remove_file(&pci_bus->dev, &dev_attr_cpulistaffinity);
 	device_unregister(&pci_bus->dev);
-- 
1.5.6.4
