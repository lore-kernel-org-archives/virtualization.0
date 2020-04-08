From: Ankur Arora <ankur.a.arora@oracle.com>
Subject: [RFC PATCH 08/26] x86/paravirt: Stash native pv-ops
Date: Tue,  7 Apr 2020 22:03:05 -0700
Message-ID: <20200408050323.4237-9-ankur.a.arora@oracle.com>
References: <20200408050323.4237-1-ankur.a.arora@oracle.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <xen-devel-bounces@lists.xenproject.org>
In-Reply-To: <20200408050323.4237-1-ankur.a.arora@oracle.com>
List-Unsubscribe: <https://lists.xenproject.org/mailman/options/xen-devel>,
 <mailto:xen-devel-request@lists.xenproject.org?subject=unsubscribe>
List-Post: <mailto:xen-devel@lists.xenproject.org>
List-Help: <mailto:xen-devel-request@lists.xenproject.org?subject=help>
List-Subscribe: <https://lists.xenproject.org/mailman/listinfo/xen-devel>,
 <mailto:xen-devel-request@lists.xenproject.org?subject=subscribe>
Errors-To: xen-devel-bounces@lists.xenproject.org
Sender: "Xen-devel" <xen-devel-bounces@lists.xenproject.org>
To: linux-kernel@vger.kernel.org, x86@kernel.org
Cc: jgross@suse.com, xen-devel@lists.xenproject.org, kvm@vger.kernel.org, peterz@infradead.org, hpa@zytor.com, Ankur Arora <ankur.a.arora@oracle.com>, virtualization@lists.linux-foundation.org, pbonzini@redhat.com, namit@vmware.com, mhiramat@kernel.org, jpoimboe@redhat.com, mihai.carabas@oracle.com, bp@alien8.de, vkuznets@redhat.com, boris.ostrovsky@oracle.com
List-Id: virtualization@lists.linuxfoundation.org

Introduce native_pv_ops where we stash the pv_ops array before
hypervisor specific hooks have modified it.

native_pv_ops get used when switching between paravirt and native
pv-ops at runtime.

Signed-off-by: Ankur Arora <ankur.a.arora@oracle.com>
---
 arch/x86/include/asm/paravirt_types.h |  4 ++++
 arch/x86/kernel/paravirt.c            | 10 ++++++++++
 arch/x86/kernel/setup.c               |  2 ++
 3 files changed, 16 insertions(+)

diff --git a/arch/x86/include/asm/paravirt_types.h b/arch/x86/include/asm/paravirt_types.h
index f1153f53c529..bc935eec7ec6 100644
--- a/arch/x86/include/asm/paravirt_types.h
+++ b/arch/x86/include/asm/paravirt_types.h
@@ -339,6 +339,7 @@ extern struct paravirt_patch_template pv_ops;
 
 #ifdef CONFIG_PARAVIRT_RUNTIME
 #define PVRT_SUFFIX ".runtime"
+extern struct paravirt_patch_template native_pv_ops;
 #else
 #define PVRT_SUFFIX ""
 #endif
@@ -775,6 +776,9 @@ extern struct paravirt_patch_site __parainstructions[],
 #ifdef CONFIG_PARAVIRT_RUNTIME
 extern struct paravirt_patch_site __parainstructions_runtime[],
 	__parainstructions_runtime_end[];
+void paravirt_ops_init(void);
+#else
+static inline void paravirt_ops_init(void) { }
 #endif
 
 #endif	/* __ASSEMBLY__ */
diff --git a/arch/x86/kernel/paravirt.c b/arch/x86/kernel/paravirt.c
index c131ba4e70ef..8c511cc4d4f4 100644
--- a/arch/x86/kernel/paravirt.c
+++ b/arch/x86/kernel/paravirt.c
@@ -458,5 +458,15 @@ NOKPROBE_SYMBOL(native_set_debugreg);
 NOKPROBE_SYMBOL(native_load_idt);
 #endif
 
+#ifdef CONFIG_PARAVIRT_RUNTIME
+__ro_after_init struct paravirt_patch_template native_pv_ops;
+
+void __init paravirt_ops_init(void)
+{
+	native_pv_ops = pv_ops;
+}
+EXPORT_SYMBOL(native_pv_ops);
+#endif
+
 EXPORT_SYMBOL(pv_ops);
 EXPORT_SYMBOL_GPL(pv_info);
diff --git a/arch/x86/kernel/setup.c b/arch/x86/kernel/setup.c
index e6b545047f38..2746a6a78fe7 100644
--- a/arch/x86/kernel/setup.c
+++ b/arch/x86/kernel/setup.c
@@ -43,6 +43,7 @@
 #include <asm/unwind.h>
 #include <asm/vsyscall.h>
 #include <linux/vmalloc.h>
+#include <asm/paravirt_types.h>
 
 /*
  * max_low_pfn_mapped: highest directly mapped pfn < 4 GB
@@ -831,6 +832,7 @@ void __init setup_arch(char **cmdline_p)
 	boot_cpu_data.x86_phys_bits = MAX_PHYSMEM_BITS;
 #endif
 
+	paravirt_ops_init();
 	/*
 	 * If we have OLPC OFW, we might end up relocating the fixmap due to
 	 * reserve_top(), so do this before touching the ioremap area.
-- 
2.20.1
