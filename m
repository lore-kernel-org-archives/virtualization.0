From: "Sinclair Yeh" <syeh@vmware.com>
Subject: [PATCH 6/6] VMware balloon: Update vmw_balloon.c to use the VMW_PORT
	macro
Date: Tue,  1 Dec 2015 14:18:52 -0800
Message-ID: <1449008332-9394-6-git-send-email-syeh__8602.45528533614$1449008327$gmane$org@vmware.com>
References: <1449008047-8252-1-git-send-email-syeh@vmware.com>
	<1449008332-9394-1-git-send-email-syeh@vmware.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <1449008332-9394-1-git-send-email-syeh@vmware.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: x86@kernel.org
Cc: pv-drivers@vmware.com, Xavier Deguillard <xdeguillard@vmware.com>, virtualization@lists.linux-foundation.org, linux-kernel@vger.kernel.org, Sinclair Yeh <syeh@vmware.com>
List-Id: virtualization@lists.linuxfoundation.org

Signed-off-by: Sinclair Yeh <syeh@vmware.com>
Reviewed-by: Thomas Hellstrom <thellstrom@vmware.com>
Reviewed-by: Alok N Kataria <akataria@vmware.com>
Cc: pv-drivers@vmware.com
Cc: Xavier Deguillard <xdeguillard@vmware.com>
Cc: linux-kernel@vger.kernel.org
Cc: virtualization@lists.linux-foundation.org
---
 drivers/misc/vmw_balloon.c | 29 ++++++++++++-----------------
 1 file changed, 12 insertions(+), 17 deletions(-)

diff --git a/drivers/misc/vmw_balloon.c b/drivers/misc/vmw_balloon.c
index ffb5634..90a0d07 100644
--- a/drivers/misc/vmw_balloon.c
+++ b/drivers/misc/vmw_balloon.c
@@ -43,6 +43,7 @@
 #include <linux/debugfs.h>
 #include <linux/seq_file.h>
 #include <asm/hypervisor.h>
+#include <asm/vmware.h>
 
 MODULE_AUTHOR("VMware, Inc.");
 MODULE_DESCRIPTION("VMware Memory Control (Balloon) Driver");
@@ -142,23 +143,17 @@ enum vmwballoon_capabilities {
 
 #define VMW_BALLOON_SUCCESS_WITH_CAPABILITIES	(0x03000000)
 
-#define VMWARE_BALLOON_CMD(cmd, data, result)			\
-({								\
-	unsigned long __status, __dummy1, __dummy2;		\
-	__asm__ __volatile__ ("inl %%dx" :			\
-		"=a"(__status),					\
-		"=c"(__dummy1),					\
-		"=d"(__dummy2),					\
-		"=b"(result) :					\
-		"0"(VMW_BALLOON_HV_MAGIC),			\
-		"1"(VMW_BALLOON_CMD_##cmd),			\
-		"2"(VMW_BALLOON_HV_PORT),			\
-		"3"(data) :					\
-		"memory");					\
-	if (VMW_BALLOON_CMD_##cmd == VMW_BALLOON_CMD_START)	\
-		result = __dummy1;				\
-	result &= -1UL;						\
-	__status & -1UL;					\
+#define VMWARE_BALLOON_CMD(cmd, data, result)			   \
+({								   \
+	unsigned long __status, __dummy1, __dummy2;		   \
+	unsigned long __si = 0, __di = 0;			   \
+	VMW_PORT(data, VMW_BALLOON_CMD_##cmd, VMW_BALLOON_HV_PORT, \
+		 VMW_BALLOON_HV_MAGIC,				   \
+		 __status, result, __dummy1, __dummy2, __si, __di);\
+	if (VMW_BALLOON_CMD_##cmd == VMW_BALLOON_CMD_START)	   \
+		result = __dummy1;				   \
+	result &= -1UL;						   \
+	__status & -1UL;					   \
 })
 
 #ifdef CONFIG_DEBUG_FS
-- 
1.9.1
