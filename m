From: Isaku Yamahata <yamahata@valinux.co.jp>
Subject: [PATCH 07/29] ia64/xen: add a neccessary header file to copmle
	include/xen/interface/xen.h
Date: Thu, 17 Jul 2008 11:10:39 +0900
Message-ID: <1216260662692-git-send-email-yamahata__38364.7832939916$1216261471$gmane$org@valinux.co.jp>
References: <12162606614068-git-send-email-yamahata@valinux.co.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <12162606614068-git-send-email-yamahata@valinux.co.jp>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: tony.luck@intel.com, linux-ia64@vger.kernel.org
Cc: yamahata@valinux.co.jp, xen-ia64-devel@lists.xensource.com, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

Create include/asm-ia64/pvclock-abi.h to compile which includes
include/asm-x86/pvclock-abi.h because ia64/xen uses same structure.
Hopefully include/asm-x86/pvclock-abi.h would be moved to somewhere
more generic.

Signed-off-by: Isaku Yamahata <yamahata@valinux.co.jp>
---
 include/asm-ia64/pvclock-abi.h |    5 +++++
 1 files changed, 5 insertions(+), 0 deletions(-)
 create mode 100644 include/asm-ia64/pvclock-abi.h

diff --git a/include/asm-ia64/pvclock-abi.h b/include/asm-ia64/pvclock-abi.h
new file mode 100644
index 0000000..1c34d11
--- /dev/null
+++ b/include/asm-ia64/pvclock-abi.h
@@ -0,0 +1,5 @@
+/*
+ * use same streucute to x86's
+ * Hopefully asm-x86/pvclock-abi.h would be moved to somewhere more generic.
+ */
+#include <asm-x86/pvclock-abi.h>
-- 
1.5.3
