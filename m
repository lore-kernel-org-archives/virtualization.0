From: Jan Kiszka <jan.kiszka@siemens.com>
Subject: [PATCH v4 1/7] jailhouse: Provide detection for non-x86 systems
Date: Sun,  4 Mar 2018 19:31:33 +0100
Message-ID: <7b24a9f00261e20e0dd12934a663ab552500bded.1520188299.git.jan.kiszka__6554.18838509849$1520188233$gmane$org@siemens.com>
References: <cover.1520188299.git.jan.kiszka@siemens.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <cover.1520188299.git.jan.kiszka@siemens.com>
In-Reply-To: <cover.1520188299.git.jan.kiszka@siemens.com>
References: <cover.1520188299.git.jan.kiszka@siemens.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, "H . Peter Anvin" <hpa@zytor.com>, Bjorn Helgaas <bhelgaas@google.com>
Cc: jailhouse-dev@googlegroups.com, Mark Rutland <mark.rutland@arm.com>, Juergen Gross <jgross@suse.com>, linux-pci@vger.kernel.org, x86@kernel.org, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, virtualization@lists.linux-foundation.org, Andy Shevchenko <andy.shevchenko@gmail.com>, Rob Herring <robh+dt@kernel.org>
List-Id: virtualization@lists.linuxfoundation.org

From: Jan Kiszka <jan.kiszka@siemens.com>

Implement jailhouse_paravirt() via device tree probing on architectures
!= x86. Will be used by the PCI core.

CC: Rob Herring <robh+dt@kernel.org>
CC: Mark Rutland <mark.rutland@arm.com>
CC: Juergen Gross <jgross@suse.com>
Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
Reviewed-by: Juergen Gross <jgross@suse.com>
---
 Documentation/devicetree/bindings/jailhouse.txt |  8 ++++++++
 arch/x86/include/asm/jailhouse_para.h           |  2 +-
 include/linux/hypervisor.h                      | 17 +++++++++++++++--
 3 files changed, 24 insertions(+), 3 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/jailhouse.txt

diff --git a/Documentation/devicetree/bindings/jailhouse.txt b/Documentation/devicetree/bindings/jailhouse.txt
new file mode 100644
index 000000000000..2901c25ff340
--- /dev/null
+++ b/Documentation/devicetree/bindings/jailhouse.txt
@@ -0,0 +1,8 @@
+Jailhouse non-root cell device tree bindings
+--------------------------------------------
+
+When running in a non-root Jailhouse cell (partition), the device tree of this
+platform shall have a top-level "hypervisor" node with the following
+properties:
+
+- compatible = "jailhouse,cell"
diff --git a/arch/x86/include/asm/jailhouse_para.h b/arch/x86/include/asm/jailhouse_para.h
index 875b54376689..b885a961a150 100644
--- a/arch/x86/include/asm/jailhouse_para.h
+++ b/arch/x86/include/asm/jailhouse_para.h
@@ -1,7 +1,7 @@
 /* SPDX-License-Identifier: GPL2.0 */
 
 /*
- * Jailhouse paravirt_ops implementation
+ * Jailhouse paravirt detection
  *
  * Copyright (c) Siemens AG, 2015-2017
  *
diff --git a/include/linux/hypervisor.h b/include/linux/hypervisor.h
index b19563f9a8eb..fc08b433c856 100644
--- a/include/linux/hypervisor.h
+++ b/include/linux/hypervisor.h
@@ -8,15 +8,28 @@
  */
 
 #ifdef CONFIG_X86
+
+#include <asm/jailhouse_para.h>
 #include <asm/x86_init.h>
+
 static inline void hypervisor_pin_vcpu(int cpu)
 {
 	x86_platform.hyper.pin_vcpu(cpu);
 }
-#else
+
+#else /* !CONFIG_X86 */
+
+#include <linux/of.h>
+
 static inline void hypervisor_pin_vcpu(int cpu)
 {
 }
-#endif
+
+static inline bool jailhouse_paravirt(void)
+{
+	return of_find_compatible_node(NULL, NULL, "jailhouse,cell");
+}
+
+#endif /* !CONFIG_X86 */
 
 #endif /* __LINUX_HYPEVISOR_H */
-- 
2.13.6
