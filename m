From: Peter Zijlstra <peterz@infradead.org>
Subject: [PATCH 2/2] x86, paravirt: Fix bool return type for PVOP_CALL
Date: Thu, 08 Dec 2016 16:42:15 +0100
Message-ID: <20161208154349.346057680@infradead.org>
References: <20161208154213.952687487@infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline; filename=peterz-fix-paravirt-bool.patch
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: linux-kernel@vger.kernel.org, x86@kernel.org
Cc: Jeremy Fitzhardinge <jeremy@goop.org>, "Peter Zijlstra (Intel)" <peterz@infradead.org>, Pan Xinhui <xinhui.pan@linux.vnet.ibm.com>, Alok Kataria <akataria@vmware.com>, kernel test robot <xiaolong.ye@intel.com>, virtualization@lists.linux-foundation.org, Chris Wright <chrisw@sous-sol.org>, Borislav Petkov <bp@alien8.de>, Peter Anvin <hpa@zytor.com>, Paolo Bonzini <pbonzini@redhat.com>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@kernel.org>
List-Id: virtualization@lists.linuxfoundation.org

Commit 3cded4179481 ("x86/paravirt: Optimize native
pv_lock_ops.vcpu_is_preempted()") introduced a paravirt op with bool
return type [*]

It turns out that the PVOP_CALL*() macros miscompile when rettype is
bool. Code that looked like:

   83 ef 01                sub    $0x1,%edi
   ff 15 32 a0 d8 00       callq  *0xd8a032(%rip)        # ffffffff81e28120 <pv_lock_ops+0x20>
   84 c0                   test   %al,%al

ended up looking like so after PVOP_CALL1() was applied:

   83 ef 01                sub    $0x1,%edi
   48 63 ff                movslq %edi,%rdi
   ff 14 25 20 81 e2 81    callq  *0xffffffff81e28120
   48 85 c0                test   %rax,%rax

Note how it tests the whole of %rax, even though a typical bool return
function only sets %al, like:

  0f 95 c0                setne  %al
  c3                      retq

This is because ____PVOP_CALL() does:

		__ret = (rettype)__eax;

and while regular integer type casts truncate the result, a cast to
bool tests for any !0 value. Fix this by explicitly truncating to
sizeof(rettype) before casting.


[*] The actual bug should've been exposed in commit 446f3dc8cc0a
("locking/core, x86/paravirt: Implement vcpu_is_preempted(cpu) for KVM
and Xen guests") but that didn't properly implement the paravirt call.

Cc: Peter Anvin <hpa@zytor.com>
Cc: Ingo Molnar <mingo@kernel.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Borislav Petkov <bp@alien8.de>
Cc: Jeremy Fitzhardinge <jeremy@goop.org>
Cc: Chris Wright <chrisw@sous-sol.org>
Cc: Alok Kataria <akataria@vmware.com>
Cc: Rusty Russell <rusty@rustcorp.com.au>
Cc: virtualization@lists.linux-foundation.org
Cc: Pan Xinhui <xinhui.pan@linux.vnet.ibm.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>
Fixes: 3cded4179481 ("x86/paravirt: Optimize native pv_lock_ops.vcpu_is_preempted()")
Reported-by: kernel test robot <xiaolong.ye@intel.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 arch/x86/include/asm/paravirt_types.h |   14 +++++++++++++-
 1 file changed, 13 insertions(+), 1 deletion(-)

--- a/arch/x86/include/asm/paravirt_types.h
+++ b/arch/x86/include/asm/paravirt_types.h
@@ -508,6 +508,18 @@ int paravirt_disable_iospace(void);
 #define PVOP_TEST_NULL(op)	((void)op)
 #endif
 
+#define PVOP_RETMASK(rettype)						\
+	({	unsigned long __mask = ~0UL;				\
+		switch (sizeof(rettype)) {				\
+		case 1: __mask =       0xffUL; break;			\
+		case 2: __mask =     0xffffUL; break;			\
+		case 4: __mask = 0xffffffffUL; break;			\
+		default: break;						\
+		}							\
+		__mask;							\
+	})
+
+
 #define ____PVOP_CALL(rettype, op, clbr, call_clbr, extra_clbr,		\
 		      pre, post, ...)					\
 	({								\
@@ -535,7 +547,7 @@ int paravirt_disable_iospace(void);
 				       paravirt_clobber(clbr),		\
 				       ##__VA_ARGS__			\
 				     : "memory", "cc" extra_clbr);	\
-			__ret = (rettype)__eax;				\
+			__ret = (rettype)(__eax & PVOP_RETMASK(rettype));	\
 		}							\
 		__ret;							\
 	})
