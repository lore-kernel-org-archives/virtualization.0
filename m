From: Yu Zhao <yu.zhao@intel.com>
Subject: [PATCH 15/15 v5] PCI: document the new PCI boot parameters
Date: Tue, 21 Oct 2008 19:54:29 +0800
Message-ID: <20081021115429.GP3185__41935.6129285463$1224595721$gmane$org@yzhao12-linux.sh.intel.com>
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

Complete document for the new PCI boot parameters.

---
 Documentation/kernel-parameters.txt |   10 ++++++++++
 1 files changed, 10 insertions(+), 0 deletions(-)

diff --git a/Documentation/kernel-parameters.txt b/Documentation/kernel-parameters.txt
index 53ba7c7..5482ae0 100644
--- a/Documentation/kernel-parameters.txt
+++ b/Documentation/kernel-parameters.txt
@@ -1677,6 +1677,16 @@ and is between 256 and 4096 characters. It is defined in the file
 		cbmemsize=nn[KMG]	The fixed amount of bus space which is
 				reserved for the CardBus bridge's memory
 				window. The default value is 64 megabytes.
+		assign-mmio=[dddd:]bb	[X86] reassign memory resources of all
+				devices under bus [dddd:]bb (dddd is the domain
+				number and bb is the bus number).
+		assign-pio=[dddd:]bb	[X86] reassign io port resources of all
+				devices under bus [dddd:]bb (dddd is the domain
+				number and bb is the bus number).
+		align-mmio=[dddd:]bb:dd.f  [X86] relocate memory resources of a
+				device with minimum PAGE_SIZE alignment (dddd
+				is the domain number and bb, dd and f is the
+				bus, device and function number).
 
 	pcie_aspm=	[PCIE] Forcibly enable or disable PCIe Active State Power
 			Management.
-- 
1.5.6.4
