From: Ankur Arora <ankur.a.arora@oracle.com>
Subject: [RFC PATCH 11/26] x86/alternatives: Remove return value of
 text_poke*()
Date: Tue,  7 Apr 2020 22:03:08 -0700
Message-ID: <20200408050323.4237-12-ankur.a.arora@oracle.com>
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

Various text_poke() variants don't return a useful value. Remove it.

Signed-off-by: Ankur Arora <ankur.a.arora@oracle.com>
---
 arch/x86/include/asm/text-patching.h |  4 ++--
 arch/x86/kernel/alternative.c        | 11 +++++------
 2 files changed, 7 insertions(+), 8 deletions(-)

diff --git a/arch/x86/include/asm/text-patching.h b/arch/x86/include/asm/text-patching.h
index 706e61e6967d..04778c2bc34e 100644
--- a/arch/x86/include/asm/text-patching.h
+++ b/arch/x86/include/asm/text-patching.h
@@ -46,9 +46,9 @@ extern void text_poke_early(void *addr, const void *opcode, size_t len);
  * On the local CPU you need to be protected against NMI or MCE handlers seeing
  * an inconsistent instruction while you patch.
  */
-extern void *text_poke(void *addr, const void *opcode, size_t len);
+extern void text_poke(void *addr, const void *opcode, size_t len);
 extern void text_poke_sync(void);
-extern void *text_poke_kgdb(void *addr, const void *opcode, size_t len);
+extern void text_poke_kgdb(void *addr, const void *opcode, size_t len);
 extern int poke_int3_handler(struct pt_regs *regs);
 extern void text_poke_bp(void *addr, const void *opcode, size_t len, const void *emulate);
 
diff --git a/arch/x86/kernel/alternative.c b/arch/x86/kernel/alternative.c
index 0c335af9ee28..8c79a3dc5e72 100644
--- a/arch/x86/kernel/alternative.c
+++ b/arch/x86/kernel/alternative.c
@@ -805,7 +805,7 @@ void __init_or_module text_poke_early(void *addr, const void *opcode,
 __ro_after_init struct mm_struct *poking_mm;
 __ro_after_init unsigned long poking_addr;
 
-static void *__text_poke(void *addr, const void *opcode, size_t len)
+static void __text_poke(void *addr, const void *opcode, size_t len)
 {
 	bool cross_page_boundary = offset_in_page(addr) + len > PAGE_SIZE;
 	struct page *pages[2] = {NULL};
@@ -906,7 +906,6 @@ static void *__text_poke(void *addr, const void *opcode, size_t len)
 
 	pte_unmap_unlock(ptep, ptl);
 	local_irq_restore(flags);
-	return addr;
 }
 
 /**
@@ -925,11 +924,11 @@ static void *__text_poke(void *addr, const void *opcode, size_t len)
  * by registering a module notifier, and ordering module removal and patching
  * trough a mutex.
  */
-void *text_poke(void *addr, const void *opcode, size_t len)
+void text_poke(void *addr, const void *opcode, size_t len)
 {
 	lockdep_assert_held(&text_mutex);
 
-	return __text_poke(addr, opcode, len);
+	__text_poke(addr, opcode, len);
 }
 
 /**
@@ -946,9 +945,9 @@ void *text_poke(void *addr, const void *opcode, size_t len)
  * Context: should only be used by kgdb, which ensures no other core is running,
  *	    despite the fact it does not hold the text_mutex.
  */
-void *text_poke_kgdb(void *addr, const void *opcode, size_t len)
+void text_poke_kgdb(void *addr, const void *opcode, size_t len)
 {
-	return __text_poke(addr, opcode, len);
+	__text_poke(addr, opcode, len);
 }
 
 static void do_sync_core(void *info)
-- 
2.20.1
