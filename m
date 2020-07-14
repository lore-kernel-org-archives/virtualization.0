From: Joerg Roedel <joro@8bytes.org>
Subject: [PATCH v4 44/75] x86/sev-es: Allocate and setup IST entry for #VC
Date: Tue, 14 Jul 2020 14:08:46 +0200
Message-ID: <20200714120917.11253-45-joro@8bytes.org>
References: <20200714120917.11253-1-joro@8bytes.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20200714120917.11253-1-joro@8bytes.org>
Sender: linux-kernel-owner@vger.kernel.org
To: x86@kernel.org
Cc: Joerg Roedel <joro@8bytes.org>, Joerg Roedel <jroedel@suse.de>, hpa@zytor.com, Andy Lutomirski <luto@kernel.org>, Dave Hansen <dave.hansen@linux.intel.com>, Peter Zijlstra <peterz@infradead.org>, Jiri Slaby <jslaby@suse.cz>, Dan Williams <dan.j.williams@intel.com>, Tom Lendacky <thomas.lendacky@amd.com>, Juergen Gross <jgross@suse.com>, Kees Cook <keescook@chromium.org>, David Rientjes <rientjes@google.com>, Cfir Cohen <cfir@google.com>, Erdem Aktas <erdemaktas@google.com>, Masami Hiramatsu <mhiramat@kernel.org>, Mike Stunes <mstunes@vmware.com>, Sean Christopherson <sean.j.christopherson@intel.com>, Martin Radev <martin.b.radev@gmail.com>, linux-kernel@vger.kernel.org, kvm@vger.kernel.org, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

From: Joerg Roedel <jroedel@suse.de>

Allocate IST entry number 4 for the #VC handler and setup it up in the
per-cpu TSS. This will setup the TSS for all CPUs before they even
start, so that the boot-code for secondary CPUs can handle #VC
exceptions.

Signed-off-by: Joerg Roedel <jroedel@suse.de>
---
 arch/x86/include/asm/page_64_types.h | 1 +
 arch/x86/kernel/sev-es.c             | 5 +++++
 2 files changed, 6 insertions(+)

diff --git a/arch/x86/include/asm/page_64_types.h b/arch/x86/include/asm/page_64_types.h
index 288b065955b7..d0c6c10c18a0 100644
--- a/arch/x86/include/asm/page_64_types.h
+++ b/arch/x86/include/asm/page_64_types.h
@@ -28,6 +28,7 @@
 #define	IST_INDEX_NMI		1
 #define	IST_INDEX_DB		2
 #define	IST_INDEX_MCE		3
+#define	IST_INDEX_VC		4
 
 /*
  * Set __PAGE_OFFSET to the most negative possible address +
diff --git a/arch/x86/kernel/sev-es.c b/arch/x86/kernel/sev-es.c
index 64002d86a237..d415368f16ec 100644
--- a/arch/x86/kernel/sev-es.c
+++ b/arch/x86/kernel/sev-es.c
@@ -56,11 +56,13 @@ static void __init sev_es_setup_vc_stacks(int cpu)
 {
 	struct sev_es_runtime_data *data;
 	struct cpu_entry_area *cea;
+	struct tss_struct *tss;
 	unsigned long vaddr;
 	phys_addr_t pa;
 
 	data = per_cpu(runtime_data, cpu);
 	cea  = get_cpu_entry_area(cpu);
+	tss  = per_cpu_ptr(&cpu_tss_rw, cpu);
 
 	/* Map #VC IST stack */
 	vaddr = CEA_ESTACK_BOT(&cea->estacks, VC);
@@ -71,6 +73,9 @@ static void __init sev_es_setup_vc_stacks(int cpu)
 	vaddr = CEA_ESTACK_BOT(&cea->estacks, VC2);
 	pa    = __pa(data->fallback_stack);
 	cea_set_pte((void *)vaddr, pa, PAGE_KERNEL);
+
+	/* Set IST entry in TSS */
+	tss->x86_tss.ist[IST_INDEX_VC] = CEA_ESTACK_TOP(&cea->estacks, VC);
 }
 
 /* Needed in vc_early_forward_exception */
-- 
2.27.0
