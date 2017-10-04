From: Josh Poimboeuf <jpoimboe@redhat.com>
Subject: [PATCH 02/13] x86/paravirt: Fix output constraint macro names
Date: Wed,  4 Oct 2017 10:58:23 -0500
Message-ID: <f8aad6bc7bcdb606b89f3d5dc5fb2303019cb3d0.1507128293.git.jpoimboe__44467.4266073436$1509079588$gmane$org@redhat.com>
References: <cover.1507128293.git.jpoimboe@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <cover.1507128293.git.jpoimboe@redhat.com>
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
Cc: Juergen Gross <jgross@suse.com>, Rusty Russell <rusty@rustcorp.com.au>, xen-devel@lists.xenproject.org, Peter Zijlstra <peterz@infradead.org>, Jiri Slaby <jslaby@suse.cz>, Boris Ostrovsky <boris.ostrovsky@oracle.com>, Mike Galbraith <efault@gmx.de>, linux-kernel@vger.kernel.org, Sasha Levin <alexander.levin@verizon.com>, Chris Wright <chrisw@sous-sol.org>, Thomas Gleixner <tglx@linutronix.de>, Andy Lutomirski <luto@kernel.org>, "H. Peter Anvin" <hpa@zytor.com>, Borislav Petkov <bp@alien8.de>, live-patching@vger.kernel.org, Alok Kataria <akataria@vmware.com>, virtualization@lists.linux-foundation.org, Linus Torvalds <torvalds@linux-foundation.org>, Ingo Molnar <mingo@kernel.org>
List-Id: virtualization@lists.linuxfoundation.org

Some of the paravirt '*_CLOBBERS' macros refer to output constraints
instead of clobbers, which makes the code extra confusing.  Rename the
output constraint related macros to '*_OUTPUTS'.

Signed-off-by: Josh Poimboeuf <jpoimboe@redhat.com>
---
 arch/x86/include/asm/paravirt_types.h | 24 ++++++++++++------------
 1 file changed, 12 insertions(+), 12 deletions(-)

diff --git a/arch/x86/include/asm/paravirt_types.h b/arch/x86/include/asm/paravirt_types.h
index 0e112f279514..e99e5ac3e036 100644
--- a/arch/x86/include/asm/paravirt_types.h
+++ b/arch/x86/include/asm/paravirt_types.h
@@ -466,12 +466,12 @@ int paravirt_disable_iospace(void);
 #define PVOP_CALL_ARG2(x)		"d" ((unsigned long)(x))
 #define PVOP_CALL_ARG3(x)		"c" ((unsigned long)(x))
 
-#define PVOP_VCALL_CLOBBERS		"=a" (__eax), "=d" (__edx),	\
+#define PVOP_VCALL_OUTPUTS		"=a" (__eax), "=d" (__edx),	\
 					"=c" (__ecx)
-#define PVOP_CALL_CLOBBERS		PVOP_VCALL_CLOBBERS
+#define PVOP_CALL_OUTPUTS		PVOP_VCALL_OUTPUTS
 
-#define PVOP_VCALLEE_CLOBBERS		"=a" (__eax), "=d" (__edx)
-#define PVOP_CALLEE_CLOBBERS		PVOP_VCALLEE_CLOBBERS
+#define PVOP_VCALLEE_OUTPUTS		"=a" (__eax), "=d" (__edx)
+#define PVOP_CALLEE_OUTPUTS		PVOP_VCALLEE_OUTPUTS
 
 #define EXTRA_CLOBBERS
 #define VEXTRA_CLOBBERS
@@ -488,14 +488,14 @@ int paravirt_disable_iospace(void);
 #define PVOP_CALL_ARG3(x)		"d" ((unsigned long)(x))
 #define PVOP_CALL_ARG4(x)		"c" ((unsigned long)(x))
 
-#define PVOP_VCALL_CLOBBERS	"=D" (__edi),				\
+#define PVOP_VCALL_OUTPUTS	"=D" (__edi),				\
 				"=S" (__esi), "=d" (__edx),		\
 				"=c" (__ecx)
-#define PVOP_CALL_CLOBBERS	PVOP_VCALL_CLOBBERS, "=a" (__eax)
+#define PVOP_CALL_OUTPUTS	PVOP_VCALL_OUTPUTS, "=a" (__eax)
 
 /* void functions are still allowed [re]ax for scratch */
-#define PVOP_VCALLEE_CLOBBERS	"=a" (__eax)
-#define PVOP_CALLEE_CLOBBERS	PVOP_VCALLEE_CLOBBERS
+#define PVOP_VCALLEE_OUTPUTS	"=a" (__eax)
+#define PVOP_CALLEE_OUTPUTS	PVOP_VCALLEE_OUTPUTS
 
 #define EXTRA_CLOBBERS	 , "r8", "r9", "r10", "r11"
 #define VEXTRA_CLOBBERS	 , "rax", "r8", "r9", "r10", "r11"
@@ -552,12 +552,12 @@ int paravirt_disable_iospace(void);
 	})
 
 #define __PVOP_CALL(rettype, op, pre, post, ...)			\
-	____PVOP_CALL(rettype, op, CLBR_ANY, PVOP_CALL_CLOBBERS,	\
+	____PVOP_CALL(rettype, op, CLBR_ANY, PVOP_CALL_OUTPUTS,		\
 		      EXTRA_CLOBBERS, pre, post, ##__VA_ARGS__)
 
 #define __PVOP_CALLEESAVE(rettype, op, pre, post, ...)			\
 	____PVOP_CALL(rettype, op.func, CLBR_RET_REG,			\
-		      PVOP_CALLEE_CLOBBERS, ,				\
+		      PVOP_CALLEE_OUTPUTS, ,				\
 		      pre, post, ##__VA_ARGS__)
 
 
@@ -576,13 +576,13 @@ int paravirt_disable_iospace(void);
 	})
 
 #define __PVOP_VCALL(op, pre, post, ...)				\
-	____PVOP_VCALL(op, CLBR_ANY, PVOP_VCALL_CLOBBERS,		\
+	____PVOP_VCALL(op, CLBR_ANY, PVOP_VCALL_OUTPUTS,		\
 		       VEXTRA_CLOBBERS,					\
 		       pre, post, ##__VA_ARGS__)
 
 #define __PVOP_VCALLEESAVE(op, pre, post, ...)				\
 	____PVOP_VCALL(op.func, CLBR_RET_REG,				\
-		      PVOP_VCALLEE_CLOBBERS, ,				\
+		      PVOP_VCALLEE_OUTPUTS, ,				\
 		      pre, post, ##__VA_ARGS__)
 
 
-- 
2.13.6
