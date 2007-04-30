From: ebiederm@xmission.com (Eric W. Biederman)
Subject: [PATCH 06/12] i386: Minimum cpu detection cleanups.
Date: Mon, 30 Apr 2007 10:09:11 -0600
Message-ID: <m1mz0p4zfc.fsf_-_@ebiederm.dsl.xmission.com>
References: <m1d51l6f1y.fsf@ebiederm.dsl.xmission.com>
	<m18xc96eyq.fsf@ebiederm.dsl.xmission.com>
	<m14pmx6ewk.fsf_-_@ebiederm.dsl.xmission.com>
	<m1zm4p509a.fsf_-_@ebiederm.dsl.xmission.com>
	<m1vefd4zyj.fsf_-_@ebiederm.dsl.xmission.com>
	<m1r6q14zow.fsf_-_@ebiederm.dsl.xmission.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <m1r6q14zow.fsf_-_@ebiederm.dsl.xmission.com> (Eric
	W. Biederman's message of "Mon, 30 Apr 2007 10:03:27 -0600")
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
Cc: linux-kernel@vger.kernel.org, virtualization <virtualization@lists.linux-foundation.org>, "H. Peter Anvin" <hpa@zytor.com>, Andrew Morton <akpm@linux-foundation.org>
List-Id: virtualization@lists.linuxfoundation.org


This patch modifies verify_cpu to check for a 486 even when
REQUIRED_MASK1 == 0 

This patch modifies REQUIRED_MASK1 to require  PAE when CONFIG_X86_PAE
is set not when HIGHMEM64G is set, not that there is a functional
difference but it seems an obvious fix.

Signed-off-by: Eric W. Biederman <ebiederm@xmission.com>
---
 arch/i386/kernel/verify_cpu.S        |    7 ++-----
 include/asm-i386/required-features.h |    2 +-
 2 files changed, 3 insertions(+), 6 deletions(-)

diff --git a/arch/i386/kernel/verify_cpu.S b/arch/i386/kernel/verify_cpu.S
index ba9e03e..e51a869 100644
--- a/arch/i386/kernel/verify_cpu.S
+++ b/arch/i386/kernel/verify_cpu.S
@@ -4,10 +4,6 @@
 #include <asm/cpufeature.h>
 
 verify_cpu:
-#if REQUIRED_MASK1 == 0
-	xorl %eax,%eax
-	ret
-#endif
 	pushfl				# Save caller passed flags
 	pushl	$0			# Kill any dangerous flags
 	popfl
@@ -21,7 +17,7 @@ verify_cpu:
 	testl	$(1<<18),%eax
 	jz	bad
 #endif
-
+#if REQUIRED_MASK1 != 0
 	pushfl				# standard way to check for cpuid
 	popl	%eax
 	movl	%eax,%ebx
@@ -57,6 +53,7 @@ verify_cpu:
 	andl	$REQUIRED_MASK1,%edx
 	xorl	$REQUIRED_MASK1,%edx
 	jnz	bad
+#endif /* REQUIRED_MASK1 */
 
 	popfl
 	xor	%eax,%eax
diff --git a/include/asm-i386/required-features.h b/include/asm-i386/required-features.h
index 062407e..9db866c 100644
--- a/include/asm-i386/required-features.h
+++ b/include/asm-i386/required-features.h
@@ -11,7 +11,7 @@
    The real information is in arch/i386/Kconfig.cpu, this just converts
    the CONFIGs into a bitmask */
 
-#ifdef CONFIG_HIGHMEM64G
+#ifdef CONFIG_X86_PAE
 #define NEED_PAE	(1<<X86_FEATURE_PAE)
 #else
 #define NEED_PAE	0
-- 
1.5.1.1.181.g2de0
