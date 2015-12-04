From: "Sinclair Yeh" <syeh@vmware.com>
Subject: [PATCH 6/6] VMware balloon: Update vmw_balloon.c to use the VMW_PORT
	macro
Date: Fri,  4 Dec 2015 15:19:43 -0800
Message-ID: <1449271183-1746-7-git-send-email-syeh__40888.2311931395$1449271178$gmane$org@vmware.com>
References: <1449008047-8252-1-git-send-email-syeh@vmware.com>
	<1449271183-1746-1-git-send-email-syeh@vmware.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <1449271183-1746-1-git-send-email-syeh@vmware.com>
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
Cc: Sinclair Yeh <syeh@vmware.com>, pv-drivers@vmware.com, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org, Xavier Deguillard <xdeguillard@vmware.com>
List-Id: virtualization@lists.linuxfoundation.org

Updated VMWARE_BALLOON_CMD to use the common VMW_PORT macro.
Doing this rather than replacing all instances of VMWARE_BALLOON_CMD
to minimize code change.

Signed-off-by: Sinclair Yeh <syeh@vmware.com>
Reviewed-by: Thomas Hellstrom <thellstrom@vmware.com>
Reviewed-by: Alok N Kataria <akataria@vmware.com>
Cc: pv-drivers@vmware.com
Cc: Xavier Deguillard <xdeguillard@vmware.com>
Cc: linux-kernel@vger.kernel.org
Cc: virtualization@lists.linux-foundation.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
v1
Swapped parameters 1 and 2 to VMW_PORT because the macro has been
updated
---
 drivers/misc/vmw_balloon.c | 29 ++++++++++++-----------------
 1 file changed, 12 insertions(+), 17 deletions(-)

diff --git a/drivers/misc/vmw_balloon.c b/drivers/misc/vmw_balloon.c
index ffb5634..f8f60ca 100644
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
+	VMW_PORT(VMW_BALLOON_CMD_##cmd, data, VMW_BALLOON_HV_PORT, \
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
