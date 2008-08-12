From: "Zhao, Yu" <yu.zhao@intel.com>
Subject: SR-IOV: patches are available for Linux kernel
Date: Tue, 12 Aug 2008 16:32:14 +0800
Message-ID: <7A25B56E4BE99C4283EB931CD1A40E110164BC6E__41985.022268682$1218530217$gmane$org@pdsmsx414.ccr.corp.intel.com>
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

Greetings,

Patches to support Single Root I/O Virtualization (SR-IOV) capability are available for the Linux 2.6 development tree.

KVM and Xen supports will come soon!

---

Single Root I/O Virtualization (SR-IOV) capability defined by PCI-SIG is intended to enable multiple system software to share PCI hardware resources. PCI device that supports this capability can be extended to one Physical Functions plus multiple Virtual Functions. Physical Function, which could be considered as the "real" PCI device, reflects the hardware instance and manages all physical resources. Virtual Functions are associated with a Physical Function and shares physical resources with the Physical Function. Software can control allocation of Virtual Functions via registers encapsulated in the capability.

Following patches add SR-IOV capability support to the Linux kernel. With these patches, people can turn a PCI device with the capability into multiple ones from software perspective.

[PATCH 1/4] PCI: export pci_read_base and add pci_update_base
[PATCH 2/4] PCI: support ARI capability
[PATCH 3/4] PCI: support SR-IOV capability
[PATCH 4/4] PCI: document SR-IOV

SR-IOV specification can be found at http://www.pcisig.com/members/downloads/specifications/iov/sr-iov1.0_11Sep07.pdf
