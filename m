From: Chris Wright <chrisw@sous-sol.org>
Subject: Re: [PATCH 1/5] Skip timer works.patch
Date: Thu, 16 Nov 2006 02:28:46 -0800
Message-ID: <20061116102846.GC1397@sequoia.sous-sol.org>
References: <20061027145650.GA37582@muc.de> <45425976.3090508@vmware.com>
	<200610271416.12548.ak@suse.de> <4546669F.8020706@vmware.com>
	<20061030225016.GA95732@muc.de>
	<20061115080323.GK1397@sequoia.sous-sol.org>
	<455ACDEC.7010808@vmware.com>
	<20061115224053.GO1397@sequoia.sous-sol.org>
	<20061116032702.GH9579@bingen.suse.de>
	<20061115210630.94bf8824.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <virtualization-bounces@lists.osdl.org>
Content-Disposition: inline
In-Reply-To: <20061115210630.94bf8824.akpm@osdl.org>
List-Unsubscribe: <https://lists.osdl.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.osdl.org>
List-Help: <mailto:virtualization-request@lists.osdl.org?subject=help>
List-Subscribe: <https://lists.osdl.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.osdl.org?subject=subscribe>
Sender: virtualization-bounces@lists.osdl.org
Errors-To: virtualization-bounces@lists.osdl.org
To: Andrew Morton <akpm@osdl.org>
Cc: Chris Wright <chrisw@sous-sol.org>, virtualization@lists.osdl.org, Andi Kleen <ak@muc.de>
List-Id: virtualization@lists.linuxfoundation.org

* Andrew Morton (akpm@osdl.org) wrote:
> wtf?  How come patches leave here in working order and keep arriving brok=
en?

I think the trees are in sync, and it's actually a bug that's .config
dependent.  Basically, the STI_STRING and CLI_STRING are not useable
the way they get used:

#define CLI_STRING paravirt_alt("pushl %ecx; pushl %edx;"		\
		     "call *paravirt_ops+PARAVIRT_irq_disable;"		\
		     "popl %edx; popl %ecx",				\
		     PARAVIRT_IRQ_DISABLE, CLBR_EAX)

#define STI_STRING paravirt_alt("pushl %ecx; pushl %edx;"		\
		     "call *paravirt_ops+PARAVIRT_irq_enable;"		\
		     "popl %edx; popl %ecx",				\
		     PARAVIRT_IRQ_ENABLE, CLBR_EAX)

#ifndef CONFIG_PROVE_LOCKING <-- that's part of the problem (must be
                                 on in most configs)
static inline void __raw_spin_lock_flags(raw_spinlock_t *lock, unsigned lon=
g flags)
{
	asm volatile(
		"\n1:\t"
		LOCK_PREFIX " ; decb %0\n\t"  <-- here the operand is =

                                                  numerically referred to
		"jns 5f\n"
		"2:\t"
		"testl $0x200, %1\n\t"
		"jz 4f\n\t"
		STI_STRING "\n"  <-- here we have code that does =

                                     "pushl %ecx; pushl %edx;", not %%ecx
		"3:\t"
		"rep;nop\n\t"
		"cmpb $0, %0\n\t"
		"jle 3b\n\t"
		CLI_STRING "\n\t"
		"jmp 1b\n"
		"4:\t"
		"rep;nop\n\t"
		"cmpb $0, %0\n\t"
		"jg 1b\n\t"
		"jmp 4b\n"
		"5:\n\t"
		: "+m" (lock->slock)
		: "r" (flags)
		: "memory" CLI_STI_CLOBBERS);
}
#endif

So, Andi's patch, is needed and correct AFAICT.  Fixes all ff, mm, pv trees=
...

thanks,
-chris


i386: Get paravirt ops to compile

TBD should be folded into the original patches

Signed-off-by: Andi Kleen <ak@suse.de>

=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- linux.orig/include/asm-i386/paravirt.h
+++ linux/include/asm-i386/paravirt.h
@@ -454,16 +454,20 @@ static inline unsigned long __raw_local_
 	return f;
 }
 =

-#define CLI_STRING paravirt_alt("pushl %ecx; pushl %edx;"		\
-		     "call *paravirt_ops+PARAVIRT_irq_disable;"		\
-		     "popl %edx; popl %ecx",				\
+#define CLI_STRING paravirt_alt("pushl %%ecx; pushl %%edx;"		\
+		     "call *paravirt_ops+%c[irq_disable];"		\
+		     "popl %%edx; popl %%ecx",				\
 		     PARAVIRT_IRQ_DISABLE, CLBR_EAX)
 =

-#define STI_STRING paravirt_alt("pushl %ecx; pushl %edx;"		\
-		     "call *paravirt_ops+PARAVIRT_irq_enable;"		\
-		     "popl %edx; popl %ecx",				\
+#define STI_STRING paravirt_alt("pushl %%ecx; pushl %%edx;"		\
+		     "call *paravirt_ops+%c[irq_enable];"		\
+		     "popl %%edx; popl %%ecx",				\
 		     PARAVIRT_IRQ_ENABLE, CLBR_EAX)
 #define CLI_STI_CLOBBERS , "%eax"
+#define CLI_STI_INPUT_ARGS \
+	,								\
+	[irq_disable] "i" (offsetof(struct paravirt_ops, irq_disable)),	\
+	[irq_enable] "i" (offsetof(struct paravirt_ops, irq_enable))
 =

 #else  /* __ASSEMBLY__ */
 =

Index: linux/include/asm-i386/spinlock.h
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- linux.orig/include/asm-i386/spinlock.h
+++ linux/include/asm-i386/spinlock.h
@@ -13,6 +13,7 @@
 #define CLI_STRING	"cli"
 #define STI_STRING	"sti"
 #define CLI_STI_CLOBBERS
+#define CLI_STI_INPUT_ARGS
 #endif /* CONFIG_PARAVIRT */
 =

 /*
@@ -58,26 +59,27 @@ static inline void __raw_spin_lock_flags
 {
 	asm volatile(
 		"\n1:\t"
-		LOCK_PREFIX " ; decb %0\n\t"
+		LOCK_PREFIX " ; decb %[slock]\n\t"
 		"jns 5f\n"
 		"2:\t"
-		"testl $0x200, %1\n\t"
+		"testl $0x200, %[flags]\n\t"
 		"jz 4f\n\t"
 		STI_STRING "\n"
 		"3:\t"
 		"rep;nop\n\t"
-		"cmpb $0, %0\n\t"
+		"cmpb $0, %[slock]\n\t"
 		"jle 3b\n\t"
 		CLI_STRING "\n\t"
 		"jmp 1b\n"
 		"4:\t"
 		"rep;nop\n\t"
-		"cmpb $0, %0\n\t"
+		"cmpb $0, %[slock]\n\t"
 		"jg 1b\n\t"
 		"jmp 4b\n"
 		"5:\n\t"
-		: "+m" (lock->slock)
-		: "r" (flags)
+		: [slock] "+m" (lock->slock)
+		: [flags] "r" (flags)
+	 	  CLI_STI_INPUT_ARGS
 		: "memory" CLI_STI_CLOBBERS);
 }
 #endif
