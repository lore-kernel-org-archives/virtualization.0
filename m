From: "Zhao, Yu" <yu.zhao@intel.com>
Subject: [PATCH 0/4 v2] PCI: Linux kernel SR-IOV support
Date: Mon, 1 Sep 2008 19:20:36 +0800
Message-ID: <7A25B56E4BE99C4283EB931CD1A40E110177EB6C__15036.3209461377$1220268199$gmane$org@pdsmsx414.ccr.corp.intel.com>
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
To: Jesse Barnes <jbarnes@virtuousgeek.org>, linux-pci@vger.kernel.org
Cc: Randy Dunlap <randy.dunlap@oracle.com>, xen-devel@lists.xensource.com, Grant Grundler <grundler@parisc-linux.org>, kvm@vger.kernel.org, Matthew Wilcox <matthew@wil.cx>, Greg KH <greg@kroah.com>, linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

Greetings,

Following patches add SR-IOV capability support to the Linux kernel. With these patches, people can turn a PCI device with the capability into multiple ones from software perspective.

[PATCH 1/4 v2] PCI: introduce new base functions
[PATCH 2/4 v2] PCI: support ARI capability
[PATCH 3/4 v2] PCI: support SR-IOV capability
[PATCH 4/4 v2] PCI: document the change

Thanks to Randy Dunlap for carefully reviewing the document change.
And also thank Greg KH, Grant Grundler and Jesse Barnes for their comments on the initial version.

---
Single Root I/O Virtualization (SR-IOV) capability defined by PCI-SIG is intended to enable multiple system software to share PCI hardware resources. PCI device that supports this capability can be extended to one Physical Functions plus multiple Virtual Functions. Physical Function, which could be considered as the "real" PCI device, reflects the hardware instance and manages all physical resources. Virtual Functions are associated with a Physical Function and shares physical resources with the Physical Function. Software can control allocation of Virtual Functions via registers encapsulated in the capability structure.

SR-IOV specification can be found at http://www.pcisig.com/members/downloads/specifications/iov/sr-iov1.0_11Sep07.pdf

Devices that support SR-IOV are available from following vendors:
http://download.intel.com/design/network/ProdBrf/320025.pdf
http://www.netxen.com/products/chipsolutions/NX3031.html
http://www.neterion.com/products/x3100.html
