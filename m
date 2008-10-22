From: Yu Zhao <yu.zhao@intel.com>
Subject: [PATCH 11/16 v6] PCI: split a new function from pci_bus_add_devices()
Date: Wed, 22 Oct 2008 16:44:05 +0800
Message-ID: <20081022084405.GK3773__43435.0143805661$1224669306$gmane$org@yzhao12-linux.sh.intel.com>
References: <20081022083809.GA3757@yzhao12-linux.sh.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <20081022083809.GA3757@yzhao12-linux.sh.intel.com>
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
Cc: "randy.dunlap@oracle.com" <randy.dunlap@oracle.com>, "grundler@parisc-linux.org" <grundler@parisc-linux.org>, "achiang@hp.com" <achiang@hp.com>, "matthew@wil.cx" <matthew@wil.cx>, "greg@kroah.com" <greg@kroah.com>, "rdreier@cisco.com" <rdreier@cisco.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "jbarnes@virtuousgeek.org" <jbarnes@virtuousgeek.org>, "virtualization@lists.linux-foundation.org" <virtualization@lists.linux-foundation.org>, "kvm@vger.kernel.org" <kvm@vger.kernel.org>, "mingo@elte.hu" <mingo@elte.hu>
List-Id: virtualization@lists.linuxfoundation.org

This patch splits a new function from pci_bus_add_devices(). The new
function can be used to register PCI bus to the device core and create
its sysfs entries.

Cc: Alex Chiang <achiang@hp.com>
Cc: Grant Grundler <grundler@parisc-linux.org>
Cc: Greg KH <greg@kroah.com>
Cc: Ingo Molnar <mingo@elte.hu>
Cc: Jesse Barnes <jbarnes@virtuousgeek.org>
Cc: Matthew Wilcox <matthew@wil.cx>
Cc: Randy Dunlap <randy.dunlap@oracle.com>
Cc: Roland Dreier <rdreier@cisco.com>
Signed-off-by: Yu Zhao <yu.zhao@intel.com>

---
 drivers/pci/bus.c   |   47 ++++++++++++++++++++++++++++-------------------
 include/linux/pci.h |    1 +
 2 files changed, 29 insertions(+), 19 deletions(-)

diff --git a/drivers/pci/bus.c b/drivers/pci/bus.c
index 7a21602..1713c35 100644
--- a/drivers/pci/bus.c
+++ b/drivers/pci/bus.c
@@ -91,6 +91,32 @@ int pci_bus_add_device(struct pci_dev *dev)
 }
 
 /**
+ * pci_bus_add_child - add a child bus
+ * @bus: bus to add
+ *
+ * This adds sysfs entries for a single bus
+ */
+int pci_bus_add_child(struct pci_bus *bus)
+{
+	int retval;
+
+	if (bus->bridge)
+		bus->dev.parent = bus->bridge;
+
+	retval = device_register(&bus->dev);
+	if (retval)
+		return retval;
+
+	bus->is_added = 1;
+
+	retval = device_create_file(&bus->dev, &dev_attr_cpuaffinity);
+	if (retval)
+		return retval;
+
+	return device_create_file(&bus->dev, &dev_attr_cpulistaffinity);
+}
+
+/**
  * pci_bus_add_devices - insert newly discovered PCI devices
  * @bus: bus to check for new devices
  *
@@ -141,26 +167,9 @@ void pci_bus_add_devices(struct pci_bus *bus)
 		 */
 		if (child->is_added)
 			continue;
-		child->dev.parent = child->bridge;
-		retval = device_register(&child->dev);
+		retval = pci_bus_add_child(child);
 		if (retval)
-			dev_err(&dev->dev, "Error registering pci_bus,"
-				" continuing...\n");
-		else {
-			child->is_added = 1;
-			retval = device_create_file(&child->dev,
-						&dev_attr_cpuaffinity);
-			if (retval)
-				dev_err(&dev->dev, "Error creating cpuaffinity"
-					" file, continuing...\n");
-
-			retval = device_create_file(&child->dev,
-						&dev_attr_cpulistaffinity);
-			if (retval)
-				dev_err(&dev->dev,
-					"Error creating cpulistaffinity"
-					" file, continuing...\n");
-		}
+			dev_err(&dev->dev, "Error adding bus, continuing\n");
 	}
 }
 
diff --git a/include/linux/pci.h b/include/linux/pci.h
index 6ac69af..80d88f8 100644
--- a/include/linux/pci.h
+++ b/include/linux/pci.h
@@ -528,6 +528,7 @@ struct pci_dev *pci_scan_single_device(struct pci_bus *bus, int devfn);
 void pci_device_add(struct pci_dev *dev, struct pci_bus *bus);
 unsigned int pci_scan_child_bus(struct pci_bus *bus);
 int __must_check pci_bus_add_device(struct pci_dev *dev);
+int pci_bus_add_child(struct pci_bus *bus);
 void pci_read_bridge_bases(struct pci_bus *child);
 struct resource *pci_find_parent_resource(const struct pci_dev *dev,
 					  struct resource *res);
-- 
1.5.6.4
