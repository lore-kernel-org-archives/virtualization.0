From: Ankur Arora <ankur.a.arora@oracle.com>
Subject: [RFC PATCH 04/26] x86/alternatives: Refactor alternatives_smp_module*
Date: Tue,  7 Apr 2020 22:03:01 -0700
Message-ID: <20200408050323.4237-5-ankur.a.arora@oracle.com>
References: <20200408050323.4237-1-ankur.a.arora@oracle.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20200408050323.4237-1-ankur.a.arora@oracle.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org, x86@kernel.org
Cc: peterz@infradead.org, hpa@zytor.com, jpoimboe@redhat.com, namit@vmware.com, mhiramat@kernel.org, jgross@suse.com, bp@alien8.de, vkuznets@redhat.com, pbonzini@redhat.com, boris.ostrovsky@oracle.com, mihai.carabas@oracle.com, kvm@vger.kernel.org, xen-devel@lists.xenproject.org, virtualization@lists.linux-foundation.org, Ankur Arora <ankur.a.arora@oracle.com>
List-Id: virtualization@lists.linuxfoundation.org

Refactor alternatives_smp_module* logic to make it available for
holding generic late patching state.

Most of the changes are to pull the module handling logic out
from CONFIG_SMP. In addition now we unconditionally call
alternatives_smp_module_add() and make the decision on patching
for UP or not there.

Signed-off-by: Ankur Arora <ankur.a.arora@oracle.com>
---
 arch/x86/include/asm/alternative.h | 13 ++-----
 arch/x86/kernel/alternative.c      | 55 ++++++++++++++++--------------
 2 files changed, 32 insertions(+), 36 deletions(-)

diff --git a/arch/x86/include/asm/alternative.h b/arch/x86/include/asm/alternative.h
index 13adca37c99a..8235bbb746d9 100644
--- a/arch/x86/include/asm/alternative.h
+++ b/arch/x86/include/asm/alternative.h
@@ -75,24 +75,15 @@ extern void apply_alternatives(struct alt_instr *start, struct alt_instr *end);
 
 struct module;
 
-#ifdef CONFIG_SMP
 extern void alternatives_smp_module_add(struct module *mod, char *name,
 					void *locks, void *locks_end,
 					void *text, void *text_end);
 extern void alternatives_smp_module_del(struct module *mod);
-extern void alternatives_enable_smp(void);
 extern int alternatives_text_reserved(void *start, void *end);
-extern bool skip_smp_alternatives;
+#ifdef CONFIG_SMP
+extern void alternatives_enable_smp(void);
 #else
-static inline void alternatives_smp_module_add(struct module *mod, char *name,
-					       void *locks, void *locks_end,
-					       void *text, void *text_end) {}
-static inline void alternatives_smp_module_del(struct module *mod) {}
 static inline void alternatives_enable_smp(void) {}
-static inline int alternatives_text_reserved(void *start, void *end)
-{
-	return 0;
-}
 #endif	/* CONFIG_SMP */
 
 #define b_replacement(num)	"664"#num
diff --git a/arch/x86/kernel/alternative.c b/arch/x86/kernel/alternative.c
index fdfda1375f82..32aa1ddf441d 100644
--- a/arch/x86/kernel/alternative.c
+++ b/arch/x86/kernel/alternative.c
@@ -470,6 +470,13 @@ static void alternatives_smp_unlock(const s32 *start, const s32 *end,
 	}
 }
 
+static bool uniproc_patched;	/* protected by text_mutex */
+#else	/* !CONFIG_SMP */
+#define uniproc_patched false
+static inline void alternatives_smp_unlock(const s32 *start, const s32 *end,
+					   u8 *text, u8 *text_end) { }
+#endif	/* CONFIG_SMP */
+
 struct smp_alt_module {
 	/* what is this ??? */
 	struct module	*mod;
@@ -486,7 +493,6 @@ struct smp_alt_module {
 	struct list_head next;
 };
 static LIST_HEAD(smp_alt_modules);
-static bool uniproc_patched = false;	/* protected by text_mutex */
 
 void __init_or_module alternatives_smp_module_add(struct module *mod,
 						  char *name,
@@ -495,23 +501,27 @@ void __init_or_module alternatives_smp_module_add(struct module *mod,
 {
 	struct smp_alt_module *smp;
 
-	mutex_lock(&text_mutex);
+#ifdef CONFIG_SMP
+	/* Patch to UP if other cpus not imminent. */
+	if (!noreplace_smp && (num_present_cpus() == 1 || setup_max_cpus <= 1))
+		uniproc_patched = true;
+#endif
 	if (!uniproc_patched)
-		goto unlock;
+		return;
 
-	if (num_possible_cpus() == 1)
-		/* Don't bother remembering, we'll never have to undo it. */
-		goto smp_unlock;
+	mutex_lock(&text_mutex);
 
-	smp = kzalloc(sizeof(*smp), GFP_KERNEL);
-	if (NULL == smp)
-		/* we'll run the (safe but slow) SMP code then ... */
-		goto unlock;
+	smp = kzalloc(sizeof(*smp), GFP_KERNEL | __GFP_NOFAIL);
 
 	smp->mod	= mod;
 	smp->name	= name;
-	smp->locks	= locks;
-	smp->locks_end	= locks_end;
+
+	if (num_possible_cpus() != 1 || uniproc_patched) {
+		/* Remember only if we'll need to undo it. */
+		smp->locks	= locks;
+		smp->locks_end	= locks_end;
+	}
+
 	smp->text	= text;
 	smp->text_end	= text_end;
 	DPRINTK("locks %p -> %p, text %p -> %p, name %s\n",
@@ -519,9 +529,9 @@ void __init_or_module alternatives_smp_module_add(struct module *mod,
 		smp->text, smp->text_end, smp->name);
 
 	list_add_tail(&smp->next, &smp_alt_modules);
-smp_unlock:
-	alternatives_smp_unlock(locks, locks_end, text, text_end);
-unlock:
+
+	if (uniproc_patched)
+		alternatives_smp_unlock(locks, locks_end, text, text_end);
 	mutex_unlock(&text_mutex);
 }
 
@@ -540,6 +550,7 @@ void __init_or_module alternatives_smp_module_del(struct module *mod)
 	mutex_unlock(&text_mutex);
 }
 
+#ifdef CONFIG_SMP
 void alternatives_enable_smp(void)
 {
 	struct smp_alt_module *mod;
@@ -561,6 +572,7 @@ void alternatives_enable_smp(void)
 	}
 	mutex_unlock(&text_mutex);
 }
+#endif /* CONFIG_SMP */
 
 /*
  * Return 1 if the address range is reserved for SMP-alternatives.
@@ -588,7 +600,6 @@ int alternatives_text_reserved(void *start, void *end)
 
 	return 0;
 }
-#endif /* CONFIG_SMP */
 
 #ifdef CONFIG_PARAVIRT
 void __init_or_module apply_paravirt(struct paravirt_patch_site *start,
@@ -723,21 +734,15 @@ void __init alternative_instructions(void)
 
 	apply_alternatives(__alt_instructions, __alt_instructions_end);
 
-#ifdef CONFIG_SMP
-	/* Patch to UP if other cpus not imminent. */
-	if (!noreplace_smp && (num_present_cpus() == 1 || setup_max_cpus <= 1)) {
-		uniproc_patched = true;
-		alternatives_smp_module_add(NULL, "core kernel",
-					    __smp_locks, __smp_locks_end,
-					    _text, _etext);
-	}
+	alternatives_smp_module_add(NULL, "core kernel",
+				    __smp_locks, __smp_locks_end,
+				    _text, _etext);
 
 	if (!uniproc_patched || num_possible_cpus() == 1) {
 		free_init_pages("SMP alternatives",
 				(unsigned long)__smp_locks,
 				(unsigned long)__smp_locks_end);
 	}
-#endif
 
 	apply_paravirt(__parainstructions, __parainstructions_end);
 	apply_paravirt(__parainstructions_runtime,
-- 
2.20.1
