From: "Zhao, Yu" <yu.zhao@intel.com>
Subject: SR-IOV: patches are available for Linux kernel [4/4]
Date: Tue, 12 Aug 2008 16:46:39 +0800
Message-ID: <7A25B56E4BE99C4283EB931CD1A40E110164BC9B__11425.5016939298$1218531198$gmane$org@pdsmsx414.ccr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-class: urn:content-classes:message
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: kvm@vger.kernel.org, xen-devel@lists.xensource.com, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

[PATCH 4/4] PCI: document SR-IOV

SR-IOV Documentation.

Signed-off-by: Yu Zhao <yu.zhao@intel.com>
Signed-off-by:  Eddie Dong <eddie.dong@intel.com>

---
 Documentation/ABI/testing/sysfs-bus-pci |   13 ++
 Documentation/PCI/00-INDEX              |    2 
 Documentation/PCI/pci-iov-howto.txt     |  170 +++++++++++++++++++++++++++++++
 3 files changed, 185 insertions(+), 0 deletions(-)

diff --git a/Documentation/ABI/testing/sysfs-bus-pci b/Documentation/ABI/testing/sysfs-bus-pci
index ceddcff..9ada27b 100644
--- a/Documentation/ABI/testing/sysfs-bus-pci
+++ b/Documentation/ABI/testing/sysfs-bus-pci
@@ -9,3 +9,16 @@ Description:
 		that some devices may have malformatted data.  If the
 		underlying VPD has a writable section then the
 		corresponding section of this file will be writable.
+
+What:		/sys/bus/pci/devices/.../iov
+Date:		August 2008
+Contact:	Yu Zhao <yu.zhao@intel.com>
+Description:
+		This file will appear when SR-IOV capability is enabled
+		by the device driver if supported. It holds number of
+		available Virtual Functions and Bus, Device, Function
+		number and status of these Virtual Functions that belong
+		to this device (Physical Function). This file can be
+		written using same format as what can be read out, to
+		change the number of available Virtual Functions and to
+		enable or disable a Virtual Functions.
diff --git a/Documentation/PCI/00-INDEX b/Documentation/PCI/00-INDEX
index 49f4394..8f8ee17 100644
--- a/Documentation/PCI/00-INDEX
+++ b/Documentation/PCI/00-INDEX
@@ -10,3 +10,5 @@ pci.txt
 	- info on the PCI subsystem for device driver authors
 pcieaer-howto.txt
 	- the PCI Express Advanced Error Reporting Driver Guide HOWTO
+pci-iov-howto.txt
+	- PCI Express Single Root I/O Virtualization HOWTO
diff --git a/Documentation/PCI/pci-iov-howto.txt b/Documentation/PCI/pci-iov-howto.txt
new file mode 100644
index 0000000..2d7ae64
--- /dev/null
+++ b/Documentation/PCI/pci-iov-howto.txt
@@ -0,0 +1,170 @@
+		PCI Express Single Root I/O Virtualization HOWTO
+			Copyright (C) 2008 Intel Corporation
+			    Yu Zhao <yu.zhao@intel.com>
+
+
+1. Overview
+
+1.1 What is SR-IOV
+
+SR-IOV is PCI Express Extended Capability, which makes one physical device
+becomes multiple virtual devices. The physical device is referred as Physical
+Function while the virtual devices are refereed as Virtual Functions.
+Allocation of Virtual Functions can be dynamically controlled by Physical
+Function via registers encapsulated in the capability. By default, this
+feature is not enabled and the Physical Function behaves as traditional PCIe
+device. Once it's turned on, each Virtual Function's PCI configuration space
+can be accessed by its own Bus, Device and Function Number (Routing ID). And
+each Virtual Function also has PCI Memory Space, which is used to map its
+register set. Virtual Function device driver operates on the register set so
+it can be functional and appear as a real existing PCI device.
+
+1.2 What is ARI
+
+Alternative Routing-ID Interpretation allows a PCI Express Endpoint to use
+its device number field as part of function number. Traditionally, an
+Endpoint can only have 8 functions, and the device number of all Endpoints
+is zero. With ARI enabled, an Endpoint can have up to 256 functions. ARI is
+managed via a ARI Forwarding bit in the Device Capabilities 2 register of
+the PCI Express Capability on the Root Port or the Downstream Port and a new
+ARI Capability on the Endpoint.
+
+
+2. User Guide
+
+2.1 How can I manage SR-IOV
+
+SR-IOV can be managed by reading or writing /sys/bus/pci/devices/.../iov.
+Legal operations on this file include:
+	- Read: will get number of available VFs and a list of them.
+	- Write: bb:dd.f={1|0} will enable or disable a VF.
+	- Write: NumVFs=N will change number of available VFs.
+
+2.2 How can I use Virtual Functions
+
+Virtual Functions can be treated as hot-plugged PCI devices in the kernel,
+so they should be able to work in the same way as real PCI devices.
+NOTE: Virtual Function device driver must be loaded to make it work.
+
+
+3. Developer Guide
+
+3.1 SR-IOV APIs
+
+To enable SR-IOV, Physical Function device driver needs to call:
+	int pci_iov_enable(struct pci_dev *dev, int nvfs,
+				int (*cb)(struct pci_dev *, int, int))
+NOTE: this function sleeps 2 seconds waiting on hardware transaction
+completion according to SR-IOV specification.
+
+To disable SR-IOV, Physical Function device driver needs to call:
+	void pci_iov_disable(struct pci_dev *dev)
+NOTE: this function sleeps 1 second waiting on hardware transaction
+completion according to SR-IOV specification.
+
+Following function can be used to query maximum number of Virtual Functions
+that a Physical Function can support:
+	int pci_iov_max_virtfn(struct pci_dev *dev)
+
+Following function can be used to retrieve parameter of a Virtual Function:
+	const char *pci_iov_virtfn_param(struct pci_dev *dev, int vfid)
+
+3.2 Usage example
+
+Following piece of codes illustrates the usage of APIs above.
+
+static int callback(struct pci_dev *dev, int event, int arg)
+{
+	int err;
+	const char *param;
+
+	switch (event) {
+	case PCI_IOV_VF_ENA:	/* request to enable a VF */
+		param = pci_iov_virtfn_param(dev, arg);
+		...
+		break;
+	case PCI_IOV_VF_DIS:	/* a VF is disabled */
+		/*
+		 * reclaim hardware resource if needed
+		 */
+		break;
+	case PCI_IOV_VF_PAR:	/* VF parameter changed */
+		param = pci_iov_virtfn_param(dev, arg);
+		...
+		break;
+	case PCI_IOV_VF_NUM:	/* request to change NumVFs */
+		/*
+		 * adjust hardware resources if needed
+		 * NOTE: arg is the new requested NumVFs
+		 */
+		break;
+	case PCI_IOV_VF_ERR:	/* error occurred */
+		/*
+		 * error handling
+		 * NOTE: arg is the error code
+		 */
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	return err;
+}
+
+static int __devinit dev_probe(struct pci_dev *dev,
+				const struct pci_device_id *id)
+{
+	int err, nvfs;
+
+	...
+
+	nvfs = pci_iov_max_virtfn(dev);
+	if (nvfs <= 0)
+		return -ENODEV;
+
+	err = pci_iov_enable(dev, nvfs, callback);
+	if (err)
+		return err;
+
+	...
+}
+
+static void __devexit dev_remove(struct pci_dev *dev)
+{
+	...
+
+	pci_iov_disable(dev);
+
+	...
+}
+
+#ifdef CONFIG_PM
+static int dev_suspend(struct pci_dev *dev, pm_message_t state)
+{
+	...
+
+	pci_iov_disable(dev);
+
+	...
+}
+
+static int dev_resume(struct pci_dev *dev)
+{
+	...
+
+	pci_iov_enable(dev, nvfs, callback);
+
+	...
+}
+#endif
+
+static struct pci_driver dev_driver = {
+	.name =		"SR-IOV PF driver",
+	.id_table =	dev_id_table,
+	.probe =	dev_probe,
+	.remove =	__devexit_p(dev_remove),
+#ifdef CONFIG_PM
+	.suspend =	dev_suspend,
+	.resume =	dev_resume,
+#endif
+};
-- 
1.4.2.1
