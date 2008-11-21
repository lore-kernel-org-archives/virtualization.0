From: Yu Zhao <yu.zhao@intel.com>
Subject: [PATCH 13/13 v7] PCI: document for SR-IOV user and developer
Date: Sat, 22 Nov 2008 02:44:32 +0800
Message-ID: <20081121184432.GN7810__18946.6474498206$1227297041$gmane$org@yzhao12-linux.sh.intel.com>
References: <20081121183605.GA7810@yzhao12-linux.sh.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <20081121183605.GA7810@yzhao12-linux.sh.intel.com>
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
Cc: "randy.dunlap@oracle.com" <randy.dunlap@oracle.com>, "grundler@parisc-linux.org" <grundler@parisc-linux.org>, "achiang@hp.com" <achiang@hp.com>, "matthew@wil.cx" <matthew@wil.cx>, "greg@kroah.com" <greg@kroah.com>, "rdreier@cisco.com" <rdreier@cisco.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "jbarnes@virtuousgeek.org" <jbarnes@virtuousgeek.org>, "virtualization@lists.linux-foundation.org" <virtualization@lists.linux-foundation.org>, "horms@verge.net.au" <horms@verge.net.au>, "kvm@vger.kernel.org" <kvm@vger.kernel.org>, "mingo@elte.hu" <mingo@elte.hu>, "yinghai@kernel.org" <yinghai@kernel.org>, "bjorn.helgaas@hp.com" <bjorn.helgaas@hp.com>
List-Id: virtualization@lists.linuxfoundation.org

Create how-to for the SR-IOV user and driver developer.

Signed-off-by: Yu Zhao <yu.zhao@intel.com>

---
 Documentation/DocBook/kernel-api.tmpl |    1 +
 Documentation/PCI/pci-iov-howto.txt   |  138 +++++++++++++++++++++++++++++++++
 2 files changed, 139 insertions(+), 0 deletions(-)
 create mode 100644 Documentation/PCI/pci-iov-howto.txt

diff --git a/Documentation/DocBook/kernel-api.tmpl b/Documentation/DocBook/kernel-api.tmpl
index 5818ff7..506e611 100644
--- a/Documentation/DocBook/kernel-api.tmpl
+++ b/Documentation/DocBook/kernel-api.tmpl
@@ -251,6 +251,7 @@ X!Edrivers/pci/hotplug.c
 -->
 !Edrivers/pci/probe.c
 !Edrivers/pci/rom.c
+!Edrivers/pci/iov.c
      </sect1>
      <sect1><title>PCI Hotplug Support Library</title>
 !Edrivers/pci/hotplug/pci_hotplug_core.c
diff --git a/Documentation/PCI/pci-iov-howto.txt b/Documentation/PCI/pci-iov-howto.txt
new file mode 100644
index 0000000..216cecc
--- /dev/null
+++ b/Documentation/PCI/pci-iov-howto.txt
@@ -0,0 +1,138 @@
+		PCI Express I/O Virtualization Howto
+		Copyright (C) 2008 Intel Corporation
+
+
+1. Overview
+
+1.1 What is SR-IOV
+
+Single Root I/O Virtualization (SR-IOV) is a PCI Express Extended
+capability which makes one physical device appear as multiple virtual
+devices. The physical device is referred to as Physical Function (PF)
+while the virtual devices are referred to as Virtual Functions (VF).
+Allocation of the VF can be dynamically controlled by the PF via
+registers encapsulated in the capability. By default, this feature is
+not enabled and the PF behaves as traditional PCIe device. Once it's
+turned on, each VF's PCI configuration space can be accessed by its own
+Bus, Device and Function Number (Routing ID). And each VF also has PCI
+Memory Space, which is used to map its register set. VF device driver
+operates on the register set so it can be functional and appear as a
+real existing PCI device.
+
+2. User Guide
+
+2.1 How can I manage the SR-IOV
+
+If a device has the SR-IOV capability and the device driver (PF driver)
+supports this operation, then there should be some entries under the
+PF's sysfs directory:
+	- /sys/bus/pci/devices/NNNN:BB:DD.F/iov/
+	(NNNN:BB:DD:F is the domain, bus, device and function numbers)
+
+To change number of Virtual Functions:
+	- /sys/bus/pci/devices/NNNN:BB:DD.F/iov/nr_virtfn
+	(writing positive integer to this file will change the number of
+	VFs, and 0 means disable the capability)
+
+The total and initial numbers of VFs can get from:
+	- /sys/bus/pci/devices/NNNN:BB:DD.F/iov/total_virtfn
+	- /sys/bus/pci/devices/NNNN:BB:DD.F/iov/initial_virtfn
+
+2.2 How can I use the Virtual Functions
+
+The VF is treated as hot-plugged PCI devices in the kernel, so they
+should be able to work in the same way as real PCI devices. And also
+the VF requires device driver that is same as a normal PCI device's.
+
+3. Developer Guide
+
+3.1 SR-IOV APIs
+
+To use the SR-IOV service, the Physical Function driver needs to declare
+a callback function in its 'struct pci_driver':
+
+	static struct pci_driver dev_driver = {
+		...
+		.virtual =	dev_virtual,
+		...
+	};
+
+	The 'dev_virtual' is a callback function that the SR-IOV service
+	will invoke it when the number of  VFs is changed by the user.
+	The first argument of this callback is PF itself ('struct pci_dev'),
+	and the second argument is the number of VFs requested. The callback
+	should return 0 if the requested number of VFs is supported and all
+	necessary resources are granted to these VFs; otherwise it should
+	return a negative value indicating the error.
+
+3.2 Usage example
+
+Following piece of code illustrates the usage of APIs above.
+
+static int __devinit dev_probe(struct pci_dev *dev,
+				const struct pci_device_id *id)
+{
+	...
+
+	return 0;
+}
+
+static void __devexit dev_remove(struct pci_dev *dev)
+{
+	...
+}
+
+#ifdef CONFIG_PM
+static int dev_suspend(struct pci_dev *dev, pm_message_t state)
+{
+	...
+
+	return 0;
+}
+
+static int dev_resume(struct pci_dev *dev)
+{
+	pci_restore_state(dev);
+
+	...
+
+	return 0;
+}
+#endif
+
+static void dev_shutdown(struct pci_dev *dev)
+{
+	...
+}
+
+static int dev_virtual(struct pci_dev *dev, int nr_virtfn)
+{
+
+	if (nr_virtfn) {
+		/*
+		 * allocate device internal resources for VFs.
+		 * these resources are device-specific (e.g. rx/tx
+		 * queue in the NIC) and necessary to make the VF
+		 * functional.
+		 */
+	} else {
+		/*
+		 * reclaim the VF related resources if any.
+		 */
+	}
+
+	return 0;
+}
+
+static struct pci_driver dev_driver = {
+	.name =		"SR-IOV Physical Function driver",
+	.id_table =	dev_id_table,
+	.probe =	dev_probe,
+	.remove =	__devexit_p(dev_remove),
+#ifdef CONFIG_PM
+	.suspend =	dev_suspend,
+	.resume =	dev_resume,
+#endif
+	.shutdown =	dev_shutdown,
+	.virtual =	dev_virtual
+};
-- 
1.5.6.4
