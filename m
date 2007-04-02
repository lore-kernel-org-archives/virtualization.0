From: Jeremy Fitzhardinge <jeremy@goop.org>
Subject: [patch 11/17] Fix patch site clobbers to include return register
Date: Sun, 01 Apr 2007 22:57:03 -0700
Message-ID: <20070402055704.967165514@goop.org>
References: <20070402055652.610711908@goop.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline; filename=paravirt-fix-clobbers.patch
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Andi Kleen <ak@suse.de>
Cc: virtualization@lists.osdl.org, Andrew Morton <akpm@linux-foundation.org>, lkml <linux-kernel@vger.kernel.org>
List-Id: virtualization@lists.linuxfoundation.org

Fix a few clobbers to include the return register.  The clobbers set
is the set of all registers modified (or may be modified) by the code
snippet, regardless of whether it was deliberate or accidental.

Signed-off-by: Jeremy Fitzhardinge <jeremy@xensource.com>
Cc: Rusty Russell <rusty@rustcorp.com.au>
Cc: Zachary Amsden <zach@vmware.com>

---
 arch/i386/kernel/entry.S    |    2 +-
 include/asm-i386/paravirt.h |   10 +++++-----
 2 files changed, 6 insertions(+), 6 deletions(-)

=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- a/arch/i386/kernel/entry.S
+++ b/arch/i386/kernel/entry.S
@@ -342,7 +342,7 @@ 1:	movl (%ebp),%ebp
 	jae syscall_badsys
 	call *sys_call_table(,%eax,4)
 	movl %eax,PT_EAX(%esp)
-	DISABLE_INTERRUPTS(CLBR_ECX|CLBR_EDX)
+	DISABLE_INTERRUPTS(CLBR_ANY)
 	TRACE_IRQS_OFF
 	movl TI_flags(%ebp), %ecx
 	testw $_TIF_ALLWORK_MASK, %cx
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- a/include/asm-i386/paravirt.h
+++ b/include/asm-i386/paravirt.h
@@ -532,7 +532,7 @@ static inline unsigned long __raw_local_
 				  "popl %%edx; popl %%ecx")
 		     : "=3Da"(f)
 		     : paravirt_type(save_fl),
-		       paravirt_clobber(CLBR_NONE)
+		       paravirt_clobber(CLBR_EAX)
 		     : "memory", "cc");
 	return f;
 }
@@ -622,15 +622,15 @@ 772:;						\
 =

 #define DISABLE_INTERRUPTS(clobbers)					\
 	PARA_SITE(PARA_PATCH(PARAVIRT_irq_disable), clobbers,		\
-		  pushl %ecx; pushl %edx;				\
+		  pushl %eax; pushl %ecx; pushl %edx;			\
 		  call *%cs:paravirt_ops+PARAVIRT_irq_disable;		\
-		  popl %edx; popl %ecx)					\
+		  popl %edx; popl %ecx; popl %eax)			\
 =

 #define ENABLE_INTERRUPTS(clobbers)					\
 	PARA_SITE(PARA_PATCH(PARAVIRT_irq_enable), clobbers,		\
-		  pushl %ecx; pushl %edx;				\
+		  pushl %eax; pushl %ecx; pushl %edx;			\
 		  call *%cs:paravirt_ops+PARAVIRT_irq_enable;		\
-		  popl %edx; popl %ecx)
+		  popl %edx; popl %ecx; popl %eax)
 =

 #define ENABLE_INTERRUPTS_SYSEXIT					\
 	PARA_SITE(PARA_PATCH(PARAVIRT_irq_enable_sysexit), CLBR_ANY,	\

-- =
