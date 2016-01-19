From: "Sinclair Yeh" <syeh@vmware.com>
Subject: [PATCH 2/6] x86: Update vmware.c to use the common VMW_PORT macros
Date: Tue, 19 Jan 2016 13:46:01 -0800
Message-ID: <1453239965-1466-3-git-send-email-syeh@vmware.com>
References: <1449271183-1746-1-git-send-email-syeh@vmware.com>
	<1453239965-1466-1-git-send-email-syeh@vmware.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <1453239965-1466-1-git-send-email-syeh@vmware.com>
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
Cc: Sinclair Yeh <syeh@vmware.com>, pv-drivers@vmware.com, gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org, Ingo Molnar <mingo@redhat.com>, "H. Peter Anvin" <hpa@zytor.com>, Thomas Gleixner <tglx@linutronix.de>
List-Id: virtualization@lists.linuxfoundation.org

Updated the VMWARE_PORT macro to use the new VMW_PORT
macro.  Doing this instead of replacing all existing
instances of VMWARE_PORT to minimize code change.

Signed-off-by: Sinclair Yeh <syeh@vmware.com>
Reviewed-by: Thomas Hellstrom <thellstrom@vmware.com>
Reviewed-by: Alok N Kataria <akataria@vmware.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: "H. Peter Anvin" <hpa@zytor.com>
Cc: pv-drivers@vmware.com
Cc: virtualization@lists.linux-foundation.org
Cc: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---

v2:
Instead of replacing all existing instances of VMWARE_PORT
with VMW_PORT, update VMWARE_PORT to use the new VMW_PORT.

v3:
Using updated VMWARE_PORT() macro, which needs hypervisor magic in the
parameter

v4:
Swapped the first and second parameters because VMW_PORT has
changed.

v5:
si and di are now separate input/output arguments in VMW_PORT()
---
 arch/x86/kernel/cpu/vmware.c | 14 ++++++++------
 1 file changed, 8 insertions(+), 6 deletions(-)

diff --git a/arch/x86/kernel/cpu/vmware.c b/arch/x86/kernel/cpu/vmware.c
index 628a059..8e900d3 100644
--- a/arch/x86/kernel/cpu/vmware.c
+++ b/arch/x86/kernel/cpu/vmware.c
@@ -26,6 +26,7 @@
 #include <asm/div64.h>
 #include <asm/x86_init.h>
 #include <asm/hypervisor.h>
+#include <asm/vmware.h>
 
 #define CPUID_VMWARE_INFO_LEAF	0x40000000
 #define VMWARE_HYPERVISOR_MAGIC	0x564D5868
@@ -38,12 +39,13 @@
 #define VMWARE_PORT_CMD_VCPU_RESERVED	31
 
 #define VMWARE_PORT(cmd, eax, ebx, ecx, edx)				\
-	__asm__("inl (%%dx)" :						\
-			"=a"(eax), "=c"(ecx), "=d"(edx), "=b"(ebx) :	\
-			"0"(VMWARE_HYPERVISOR_MAGIC),			\
-			"1"(VMWARE_PORT_CMD_##cmd),			\
-			"2"(VMWARE_HYPERVISOR_PORT), "3"(UINT_MAX) :	\
-			"memory");
+({									\
+	unsigned long __si, __di; /* Not used */			\
+	VMW_PORT(VMWARE_PORT_CMD_##cmd, UINT_MAX, 0, 0,			\
+		 VMWARE_HYPERVISOR_PORT, VMWARE_HYPERVISOR_MAGIC,	\
+		 eax, ebx, ecx, edx, __si, __di);			\
+})
+
 
 static inline int __vmware_platform(void)
 {
-- 
1.9.1
