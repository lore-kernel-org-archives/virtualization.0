From: Yu Zhao <yu.zhao@intel.com>
Subject: [PATCH 12/13 v7] PCI: document the SR-IOV sysfs entries
Date: Sat, 22 Nov 2008 02:43:59 +0800
Message-ID: <20081121184359.GM7810__34268.5328251266$1227296978$gmane$org@yzhao12-linux.sh.intel.com>
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

Document the SR-IOV sysfs entries.

Signed-off-by: Yu Zhao <yu.zhao@intel.com>

---
 Documentation/ABI/testing/sysfs-bus-pci |   26 ++++++++++++++++++++++++++
 1 files changed, 26 insertions(+), 0 deletions(-)

diff --git a/Documentation/ABI/testing/sysfs-bus-pci b/Documentation/ABI/testing/sysfs-bus-pci
index ceddcff..d66d63d 100644
--- a/Documentation/ABI/testing/sysfs-bus-pci
+++ b/Documentation/ABI/testing/sysfs-bus-pci
@@ -9,3 +9,29 @@ Description:
 		that some devices may have malformatted data.  If the
 		underlying VPD has a writable section then the
 		corresponding section of this file will be writable.
+
+What:		/sys/bus/pci/devices/.../iov/total_virtfn
+Date:		November 2008
+Contact:	Yu Zhao <yu.zhao@intel.com>
+Description:
+		This file appears when a device has the SR-IOV capability
+		and the device driver (PF driver) support this operation.
+		It holds the number of total Virtual Functions (read-only).
+
+What:		/sys/bus/pci/devices/.../iov/initial_virtfn
+Date:		November 2008
+Contact:	Yu Zhao <yu.zhao@intel.com>
+Description:
+		This file appears when a device has the SR-IOV capability
+		and the device driver (PF driver) support this operation.
+		It holds the number of initial Virtual Functions (read-only).
+
+What:		/sys/bus/pci/devices/.../iov/nr_virtfn
+Date:		November 2008
+Contact:	Yu Zhao <yu.zhao@intel.com>
+Description:
+		This file appears when a device has the SR-IOV capability
+		and the device driver (PF driver) support this operation.
+		It holds the number of available Virtual Functions, and
+		could be written (0 ~ InitialVFs) to change the number of
+		the Virtual Functions.
-- 
1.5.6.4
