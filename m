From: Yu Zhao <yu.zhao@intel.com>
Subject: [PATCH 11/15 v5] PCI: split a new function from pci_bus_add_devices()
Date: Tue, 21 Oct 2008 19:52:42 +0800
Message-ID: <20081021115242.GL3185__44193.3101429187$1224595213$gmane$org@yzhao12-linux.sh.intel.com>
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

This patch splits a new function from pci_bus_add_devices(). The new
function can be used to register a PCI bus to device core and create
its sysfs entries.

Cc: Jesse Barnes <jbarnes@virtuousgeek.org>
Cc: Randy Dunlap <randy.dunlap@oracle.com>
Cc: Grant Grundler <grundler@parisc-linux.org>
Cc: Alex Chiang <achiang@hp.com>
Cc: Matthew Wilcox <matthew@wil.cx>
Cc: Roland Dreier <rdreier@cisco.com>
Cc: Greg KH <greg@kroah.com>
Signed-off-by: Yu Zhao <yu.zhao@intel.com>

---
 drivers/pci/bus.c   |   48 +++++++++++++++++++++++++++++-------------------
 include/linux/pci.h |    1 +
 2 files changed, 30 insertions(+), 19 deletions(-)

diff --git a/drivers/pci/bus.c b/drivers/pci/bus.c
index 7a21602..303ca74 100644
--- a/drivers/pci/bus.c
+++ b/drivers/pci/bus.c
@@ -91,6 +91,33 @@ int pci_bus_add_device(struct pci_dev *dev)
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
+	retval = device_create_file(&bus->dev, &dev_attr_cpulistaffinity);
+		return retval;
+}
+
+/**
  * pci_bus_add_devices - insert newly discovered PCI devices
  * @bus: bus to check for new devices
  *
@@ -141,26 +168,9 @@ void pci_bus_add_devices(struct pci_bus *bus)
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
