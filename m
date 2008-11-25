From: Isaku Yamahata <yamahata@valinux.co.jp>
Subject: [PATCH 3/5] ia64/pv_ops/bp/module: support binary patching for kernel
	module.
Date: Tue, 25 Nov 2008 22:03:53 +0900
Message-ID: <1227618235-3890-4-git-send-email-yamahata__7645.67006049237$1227618750$gmane$org@valinux.co.jp>
References: <1227618235-3890-1-git-send-email-yamahata@valinux.co.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <1227618235-3890-1-git-send-email-yamahata@valinux.co.jp>
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

support binary patching for kernel module.

Signed-off-by: Isaku Yamahata <yamahata@valinux.co.jp>
---
 arch/ia64/include/asm/module.h |    6 ++++++
 arch/ia64/kernel/module.c      |   32 ++++++++++++++++++++++++++++++++
 2 files changed, 38 insertions(+), 0 deletions(-)

diff --git a/arch/ia64/include/asm/module.h b/arch/ia64/include/asm/module.h
index d2da61e..908eaef 100644
--- a/arch/ia64/include/asm/module.h
+++ b/arch/ia64/include/asm/module.h
@@ -16,6 +16,12 @@ struct mod_arch_specific {
 	struct elf64_shdr *got;		/* global offset table */
 	struct elf64_shdr *opd;		/* official procedure descriptors */
 	struct elf64_shdr *unwind;	/* unwind-table section */
+#ifdef CONFIG_PARAVIRT
+	struct elf64_shdr *paravirt_bundles;
+					/* paravirt_alt_bundle_patch table */
+	struct elf64_shdr *paravirt_insts;
+					/* paravirt_alt_inst_patch table */
+#endif
 	unsigned long gp;		/* global-pointer for module */
 
 	void *core_unw_table;		/* core unwind-table cookie returned by unwinder */
diff --git a/arch/ia64/kernel/module.c b/arch/ia64/kernel/module.c
index aaa7d90..34fe425 100644
--- a/arch/ia64/kernel/module.c
+++ b/arch/ia64/kernel/module.c
@@ -446,6 +446,14 @@ module_frob_arch_sections (Elf_Ehdr *ehdr, Elf_Shdr *sechdrs, char *secstrings,
 			mod->arch.opd = s;
 		else if (strcmp(".IA_64.unwind", secstrings + s->sh_name) == 0)
 			mod->arch.unwind = s;
+#ifdef CONFIG_PARAVIRT
+		else if (strcmp(".paravirt_bundles",
+				secstrings + s->sh_name) == 0)
+			mod->arch.paravirt_bundles = s;
+		else if (strcmp(".paravirt_insts",
+				secstrings + s->sh_name) == 0)
+			mod->arch.paravirt_insts = s;
+#endif
 
 	if (!mod->arch.core_plt || !mod->arch.init_plt || !mod->arch.got || !mod->arch.opd) {
 		printk(KERN_ERR "%s: sections missing\n", mod->name);
@@ -921,6 +929,30 @@ module_finalize (const Elf_Ehdr *hdr, const Elf_Shdr *sechdrs, struct module *mo
 	DEBUGP("%s: init: entry=%p\n", __func__, mod->init);
 	if (mod->arch.unwind)
 		register_unwind_table(mod);
+#ifdef CONFIG_PARAVIRT
+        if (mod->arch.paravirt_bundles) {
+                struct paravirt_patch_site_bundle *start =
+                        (struct paravirt_patch_site_bundle *)
+                        mod->arch.paravirt_bundles->sh_addr;
+                struct paravirt_patch_site_bundle *end =
+                        (struct paravirt_patch_site_bundle *)
+                        (mod->arch.paravirt_bundles->sh_addr +
+                         mod->arch.paravirt_bundles->sh_size);
+
+                paravirt_patch_apply_bundle(start, end);
+        }
+        if (mod->arch.paravirt_insts) {
+                struct paravirt_patch_site_inst *start =
+                        (struct paravirt_patch_site_inst *)
+                        mod->arch.paravirt_insts->sh_addr;
+                struct paravirt_patch_site_inst *end =
+                        (struct paravirt_patch_site_inst *)
+                        (mod->arch.paravirt_insts->sh_addr +
+                         mod->arch.paravirt_insts->sh_size);
+
+                paravirt_patch_apply_inst(start, end);
+        }
+#endif
 	return 0;
 }
 
-- 
1.6.0.2
