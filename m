From: Will Deacon <will@kernel.org>
Subject: [PATCH 14/18] arm64: Reduce the number of header files pulled into vmlinux.lds.S
Date: Tue, 30 Jun 2020 18:37:30 +0100
Message-ID: <20200630173734.14057-15-will@kernel.org>
References: <20200630173734.14057-1-will@kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20200630173734.14057-1-will@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: Will Deacon <will@kernel.org>, Sami Tolvanen <samitolvanen@google.com>, Nick Desaulniers <ndesaulniers@google.com>, Kees Cook <keescook@chromium.org>, Marco Elver <elver@google.com>, "Paul E. McKenney" <paulmck@kernel.org>, Josh Triplett <josh@joshtriplett.org>, Matt Turner <mattst88@gmail.com>, Ivan Kokshaysky <ink@jurassic.park.msu.ru>, Richard Henderson <rth@twiddle.net>, Peter Zijlstra <peterz@infradead.org>, Alan Stern <stern@rowland.harvard.edu>, "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>, Arnd Bergmann <arnd@arndb.de>, Boqun Feng <boqun.feng@gmail.com>, Catalin Marinas <catalin.marinas@arm.com>, Mark Rutland <mark.rutland@arm.com>, linux-arm-kernel@lists.infradead.org, linux-alpha@vger.kernel.orgv
List-Id: virtualization@lists.linuxfoundation.org

Although vmlinux.lds.S smells like an assembly file and is compiled
with __ASSEMBLY__ defined, it's actually just fed to the preprocessor to
create our linker script. This means that any assembly macros defined
by headers that it includes will result in a helpful link error:

| aarch64-linux-gnu-ld:./arch/arm64/kernel/vmlinux.lds:1: syntax error

In preparation for an arm64-private asm/rwonce.h implementation, which
will end up pulling assembly macros into linux/compiler.h, reduce the
number of headers we include directly and transitively in vmlinux.lds.S

Signed-off-by: Will Deacon <will@kernel.org>
---
 arch/arm64/include/asm/kernel-pgtable.h |  2 +-
 arch/arm64/include/asm/memory.h         | 11 ++++++-----
 arch/arm64/include/asm/uaccess.h        |  1 +
 arch/arm64/kernel/entry.S               |  1 +
 arch/arm64/kernel/vmlinux.lds.S         |  1 -
 arch/arm64/kvm/hyp-init.S               |  1 +
 6 files changed, 10 insertions(+), 7 deletions(-)

diff --git a/arch/arm64/include/asm/kernel-pgtable.h b/arch/arm64/include/asm/kernel-pgtable.h
index 3bf626f6fe0c..329fb15f6bac 100644
--- a/arch/arm64/include/asm/kernel-pgtable.h
+++ b/arch/arm64/include/asm/kernel-pgtable.h
@@ -8,7 +8,7 @@
 #ifndef __ASM_KERNEL_PGTABLE_H
 #define __ASM_KERNEL_PGTABLE_H
 
-#include <linux/pgtable.h>
+#include <asm/pgtable-hwdef.h>
 #include <asm/sparsemem.h>
 
 /*
diff --git a/arch/arm64/include/asm/memory.h b/arch/arm64/include/asm/memory.h
index a1871bb32bb1..9d4bf58cf7b3 100644
--- a/arch/arm64/include/asm/memory.h
+++ b/arch/arm64/include/asm/memory.h
@@ -10,11 +10,8 @@
 #ifndef __ASM_MEMORY_H
 #define __ASM_MEMORY_H
 
-#include <linux/compiler.h>
 #include <linux/const.h>
 #include <linux/sizes.h>
-#include <linux/types.h>
-#include <asm/bug.h>
 #include <asm/page-def.h>
 
 /*
@@ -157,11 +154,15 @@
 #endif
 
 #ifndef __ASSEMBLY__
-extern u64			vabits_actual;
-#define PAGE_END		(_PAGE_END(vabits_actual))
 
 #include <linux/bitops.h>
+#include <linux/compiler.h>
 #include <linux/mmdebug.h>
+#include <linux/types.h>
+#include <asm/bug.h>
+
+extern u64			vabits_actual;
+#define PAGE_END		(_PAGE_END(vabits_actual))
 
 extern s64			physvirt_offset;
 extern s64			memstart_addr;
diff --git a/arch/arm64/include/asm/uaccess.h b/arch/arm64/include/asm/uaccess.h
index bc5c7b091152..8d7c466f809b 100644
--- a/arch/arm64/include/asm/uaccess.h
+++ b/arch/arm64/include/asm/uaccess.h
@@ -19,6 +19,7 @@
 #include <linux/string.h>
 
 #include <asm/cpufeature.h>
+#include <asm/mmu.h>
 #include <asm/ptrace.h>
 #include <asm/memory.h>
 #include <asm/extable.h>
diff --git a/arch/arm64/kernel/entry.S b/arch/arm64/kernel/entry.S
index 5304d193c79d..b668aad3b762 100644
--- a/arch/arm64/kernel/entry.S
+++ b/arch/arm64/kernel/entry.S
@@ -15,6 +15,7 @@
 #include <asm/assembler.h>
 #include <asm/asm-offsets.h>
 #include <asm/asm_pointer_auth.h>
+#include <asm/bug.h>
 #include <asm/cpufeature.h>
 #include <asm/errno.h>
 #include <asm/esr.h>
diff --git a/arch/arm64/kernel/vmlinux.lds.S b/arch/arm64/kernel/vmlinux.lds.S
index 6827da7f3aa5..e1e7c0431b4d 100644
--- a/arch/arm64/kernel/vmlinux.lds.S
+++ b/arch/arm64/kernel/vmlinux.lds.S
@@ -10,7 +10,6 @@
 #include <asm-generic/vmlinux.lds.h>
 #include <asm/cache.h>
 #include <asm/kernel-pgtable.h>
-#include <asm/thread_info.h>
 #include <asm/memory.h>
 #include <asm/page.h>
 
diff --git a/arch/arm64/kvm/hyp-init.S b/arch/arm64/kvm/hyp-init.S
index 6e6ed5581eed..076544393c3c 100644
--- a/arch/arm64/kvm/hyp-init.S
+++ b/arch/arm64/kvm/hyp-init.S
@@ -6,6 +6,7 @@
 
 #include <linux/linkage.h>
 
+#include <asm/alternative.h>
 #include <asm/assembler.h>
 #include <asm/kvm_arm.h>
 #include <asm/kvm_mmu.h>
-- 
2.27.0.212.ge8ba1cc988-goog
