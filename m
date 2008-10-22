From: Yu Zhao <yu.zhao@intel.com>
Subject: [PATCH 15/16 v6] PCI: document the SR-IOV sysfs entries
Date: Wed, 22 Oct 2008 16:45:15 +0800
Message-ID: <20081022084515.GO3773__34490.8014908016$1224669374$gmane$org@yzhao12-linux.sh.intel.com>
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

Document the SR-IOV sysfs entries.

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
 Documentation/ABI/testing/sysfs-bus-pci |   33 +++++++++++++++++++++++++++++++
 1 files changed, 33 insertions(+), 0 deletions(-)

diff --git a/Documentation/ABI/testing/sysfs-bus-pci b/Documentation/ABI/testing/sysfs-bus-pci
index ceddcff..41cce8f 100644
--- a/Documentation/ABI/testing/sysfs-bus-pci
+++ b/Documentation/ABI/testing/sysfs-bus-pci
@@ -9,3 +9,36 @@ Description:
 		that some devices may have malformatted data.  If the
 		underlying VPD has a writable section then the
 		corresponding section of this file will be writable.
+
+What:		/sys/bus/pci/devices/.../iov/enable
+Date:		October 2008
+Contact:	Yu Zhao <yu.zhao@intel.com>
+Description:
+		This file appears when a device has the SR-IOV capability.
+		It holds the status of the capability, and could be written
+		(0/1) to disable and enable the capability if the PF driver
+		supports this operation.
+
+What:		/sys/bus/pci/devices/.../iov/initialvfs
+Date:		October 2008
+Contact:	Yu Zhao <yu.zhao@intel.com>
+Description:
+		This file appears when a device has the SR-IOV capability.
+		It holds the number of initial Virtual Functions (read-only).
+
+What:		/sys/bus/pci/devices/.../iov/totalvfs
+Date:		October 2008
+Contact:	Yu Zhao <yu.zhao@intel.com>
+Description:
+		This file appears when a device has the SR-IOV capability.
+		It holds the number of total Virtual Functions (read-only).
+
+
+What:		/sys/bus/pci/devices/.../iov/numvfs
+Date:		October 2008
+Contact:	Yu Zhao <yu.zhao@intel.com>
+Description:
+		This file appears when a device has the SR-IOV capability.
+		It holds the number of available Virtual Functions, and
+		could be written (1 ~ InitialVFs) to change the number if
+		the PF driver supports this operation.
-- 
1.5.6.4
