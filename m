From: Yu Zhao <yu.zhao@intel.com>
Subject: [PATCH 0/13 v7] PCI: Linux kernel SR-IOV support
Date: Sat, 22 Nov 2008 02:36:05 +0800
Message-ID: <20081121183605.GA7810__41531.8958963782$1227296212$gmane$org@yzhao12-linux.sh.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
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
To: linux-pci@vger.kernel.org
Cc: randy.dunlap@oracle.com, grundler@parisc-linux.org, achiang@hp.com, matthew@wil.cx, greg@kroah.com, rdreier@cisco.com, linux-kernel@vger.kernel.org, jbarnes@virtuousgeek.org, virtualization@lists.linux-foundation.org, horms@verge.net.au, kvm@vger.kernel.org, mingo@elte.hu, yinghai@kernel.org, bjorn.helgaas@hp.com
List-Id: virtualization@lists.linuxfoundation.org

Greetings,

Following patches are intended to support SR-IOV capability in the
Linux kernel. With these patches, people can turn a PCI device with
the capability into multiple ones from software perspective, which
will benefit KVM and achieve other purposes such as QoS, security,
and etc.

The Physical Function and Virtual Function drivers using the SR-IOV
APIs will come soon!

Major changes from v6 to v7:
1, remove boot-time resource rebalancing support. (Greg KH)
2, emit uevent upon the PF driver is loaded. (Greg KH)
3, put SR-IOV callback function into the 'pci_driver'. (Matthew Wilcox)
4, register SR-IOV service at the PF loading stage.
5, remove unnecessary APIs (pci_iov_enable/disable).

---

[PATCH 1/13 v7] PCI: enhance pci_ari_enabled()
[PATCH 2/13 v7] PCI: remove unnecessary arg of pci_update_resource()
[PATCH 3/13 v7] PCI: define PCI resource names in an 'enum'
[PATCH 4/13 v7] PCI: remove unnecessary condition check in pci_restore_bars()
[PATCH 5/13 v7] PCI: export __pci_read_base()
[PATCH 6/13 v7] PCI: make pci_alloc_child_bus() be able to handle NULL bridge
[PATCH 7/13 v7] PCI: add a new function to map BAR offset
[PATCH 8/13 v7] PCI: cleanup pci_bus_add_devices()
[PATCH 9/13 v7] PCI: split a new function from pci_bus_add_devices()
[PATCH 10/13 v7] PCI: support the SR-IOV capability
[PATCH 11/13 v7] PCI: reserve bus range for SR-IOV device
[PATCH 12/13 v7] PCI: document the SR-IOV sysfs entries
[PATCH 13/13 v7] PCI: document for SR-IOV user and developer

Cc: Alex Chiang <achiang@hp.com>
Cc: Bjorn Helgaas <bjorn.helgaas@hp.com>
Cc: Grant Grundler <grundler@parisc-linux.org>
Cc: Greg KH <greg@kroah.com>
Cc: Ingo Molnar <mingo@elte.hu>
Cc: Jesse Barnes <jbarnes@virtuousgeek.org>
Cc: Matthew Wilcox <matthew@wil.cx>
Cc: Randy Dunlap <randy.dunlap@oracle.com>
Cc: Roland Dreier <rdreier@cisco.com>
Cc: Simon Horman <horms@verge.net.au>
Cc: Yinghai Lu <yinghai@kernel.org>

---

Single Root I/O Virtualization (SR-IOV) capability defined by PCI-SIG
is intended to enable multiple system software to share PCI hardware
resources.  PCI device that supports this capability can be extended
to one Physical Functions plus multiple Virtual Functions. Physical
Function, which could be considered as the "real" PCI device, reflects
the hardware instance and manages all physical resources. Virtual
Functions are associated with a Physical Function and shares physical
resources with the Physical Function.Software can control allocation of
Virtual Functions via registers encapsulated in the capability structure.

SR-IOV specification can be found at
http://www.pcisig.com/members/downloads/specifications/iov/sr-iov1.0_11Sep07.pdf

Devices that support SR-IOV are available from following vendors:
http://download.intel.com/design/network/ProdBrf/320025.pdf
http://www.netxen.com/products/chipsolutions/NX3031.html
http://www.neterion.com/products/x3100.html
