From: Zachary Amsden <zach@vmware.com>
Subject: RFC: const_udelay in 018-delay functions patch
Date: Tue, 24 Oct 2006 22:11:10 -0700
Message-ID: <453EF1EE.2000503@vmware.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="------------060103000703060302020304"
Return-path: <virtualization-bounces@lists.osdl.org>
List-Unsubscribe: <https://lists.osdl.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.osdl.org>
List-Help: <mailto:virtualization-request@lists.osdl.org?subject=help>
List-Subscribe: <https://lists.osdl.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.osdl.org?subject=subscribe>
Sender: virtualization-bounces@lists.osdl.org
Errors-To: virtualization-bounces@lists.osdl.org
To: Chris Wright <chrisw@sous-sol.org>, Rusty Russell <rusty@rustcorp.com.au>, Virtualization Mailing List <virtualization@lists.osdl.org>, Jeremy Fitzhardinge <jeremy@goop.org>
List-Id: virtualization@lists.linuxfoundation.org

This is a multi-part message in MIME format.
--------------060103000703060302020304
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

So I implemented udelay and ndelay through a single paravirt_op, 
const_udelay, instead of having either two separate paravirt-ops for 
udelay or ndelay, or a redundant const_udelay paravirt_op.  Anybody have 
any objection to reworking the patch this way?



--------------060103000703060302020304
Content-Type: text/plain;
 name="018-delay-functions.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="018-delay-functions.patch"

Add paravirtualized delay mechanisms to paravirt-ops.  There are two delays
used by native hardware that are unnecessary inside a virtual machine.  The
first of these is the hardware I/O delay used by io.h.  The second is udelay,
which is used in many places.  The only code that actually depends on a real
time delay in a virtual machine is SMP bootstrapping, which must wait for the
APs to come online.  For this purpose, I have introduced a way to override
the paravirt-ops implementation, by defining USE_REAL_TIME_DELAY before the
header files are included.  Similarly, the boot decompressor uses I/O
instructions, and it cannot yet use the paravirt-ops versions.  So it must
undefine CONFIG_PARAVIRT to prevent io_delay from being redefined.

Signed-off-by: Zachary Amsden <zach@vmware.com>

===================================================================
--- a/arch/i386/boot/compressed/misc.c
+++ b/arch/i386/boot/compressed/misc.c
@@ -9,6 +9,7 @@
  * High loaded stuff by Hans Lermen & Werner Almesberger, Feb. 1996
  */
 
+#undef CONFIG_PARAVIRT
 #include <linux/linkage.h>
 #include <linux/vmalloc.h>
 #include <linux/screen_info.h>
===================================================================
--- a/arch/i386/kernel/paravirt.c
+++ b/arch/i386/kernel/paravirt.c
@@ -21,6 +21,7 @@
 #include <asm/paravirt.h>
 #include <asm/desc.h>
 #include <asm/setup.h>
+#include <asm/delay.h>
 
 static fastcall void native_cpuid(unsigned int *eax, unsigned int *ebx,
 				  unsigned int *ecx, unsigned int *edx)
@@ -328,6 +329,11 @@ static fastcall void native_set_iopl_mas
 		      "popfl"
 		      : "=&r" (reg)
 		      : "i" (~X86_EFLAGS_IOPL), "r" (mask));
+}
+
+static fastcall void native_io_delay(void)
+{
+	asm volatile("outb %al,$0x80");
 }
 
 /* These are in entry.S */
@@ -445,6 +451,9 @@ struct paravirt_ops paravirt_ops = {
 	.write_idt_entry = native_write_idt_entry,
 
 	.set_iopl_mask = native_set_iopl_mask,
+	.io_delay = native_io_delay,
+	.const_udelay = __const_udelay,
+
 	.irq_enable_sysexit = native_irq_enable_sysexit,
 	.iret = native_iret,
 };
===================================================================
--- a/arch/i386/kernel/smpboot.c
+++ b/arch/i386/kernel/smpboot.c
@@ -33,6 +33,11 @@
  *		Dave Jones	:	Report invalid combinations of Athlon CPUs.
 *		Rusty Russell	:	Hacked into shape for new "hotplug" boot process. */
 
+
+/* SMP boot always wants to use real time delay to allow sufficient time for
+ * the APs to come online */
+#define USE_REAL_TIME_DELAY
+
 #include <linux/module.h>
 #include <linux/init.h>
 #include <linux/kernel.h>
===================================================================
--- a/drivers/net/de600.c
+++ b/drivers/net/de600.c
@@ -43,7 +43,6 @@ static const char version[] = "de600.c: 
  * modify the following "#define": (see <asm/io.h> for more info)
 #define REALLY_SLOW_IO
  */
-#define SLOW_IO_BY_JUMPING /* Looks "better" than dummy write to port 0x80 :-) */
 
 /* use 0 for production, 1 for verification, >2 for debug */
 #ifdef DE600_DEBUG
===================================================================
--- a/include/asm-i386/delay.h
+++ b/include/asm-i386/delay.h
@@ -15,6 +15,13 @@ extern void __const_udelay(unsigned long
 extern void __const_udelay(unsigned long usecs);
 extern void __delay(unsigned long loops);
 
+#if defined(CONFIG_PARAVIRT) && !defined(USE_REAL_TIME_DELAY)
+#define udelay(n) paravirt_ops.const_udelay((n) * 0x10c7ul)
+	
+#define ndelay(n) paravirt_ops.const_udelay((n) * 5ul)
+
+#else /* !PARAVIRT || USE_REAL_TIME_DELAY */
+
 #define udelay(n) (__builtin_constant_p(n) ? \
 	((n) > 20000 ? __bad_udelay() : __const_udelay((n) * 0x10c7ul)) : \
 	__udelay(n))
@@ -22,6 +29,7 @@ extern void __delay(unsigned long loops)
 #define ndelay(n) (__builtin_constant_p(n) ? \
 	((n) > 20000 ? __bad_ndelay() : __const_udelay((n) * 5ul)) : \
 	__ndelay(n))
+#endif
 
 void use_tsc_delay(void);
 
===================================================================
--- a/include/asm-i386/io.h
+++ b/include/asm-i386/io.h
@@ -256,11 +256,11 @@ static inline void flush_write_buffers(v
 
 #endif /* __KERNEL__ */
 
-#ifdef SLOW_IO_BY_JUMPING
-#define __SLOW_DOWN_IO "jmp 1f; 1: jmp 1f; 1:"
-#else
+#if defined(CONFIG_PARAVIRT) && !defined(USE_REAL_IO)
+#include <asm/paravirt.h>
+#else 
+
 #define __SLOW_DOWN_IO "outb %%al,$0x80;"
-#endif
 
 static inline void slow_down_io(void) {
 	__asm__ __volatile__(
@@ -270,6 +270,8 @@ static inline void slow_down_io(void) {
 #endif
 		: : );
 }
+
+#endif
 
 #ifdef CONFIG_X86_NUMAQ
 extern void *xquad_portio;    /* Where the IO area was mapped */
===================================================================
--- a/include/asm-i386/paravirt.h
+++ b/include/asm-i386/paravirt.h
@@ -98,6 +98,11 @@ struct paravirt_ops
 	void (fastcall *write_idt_entry)(void *dt, int entrynum, u64 entry);
 
 	void (fastcall *set_iopl_mask)(unsigned mask);
+	void (fastcall *io_delay)(void);
+
+	/* The native equivalents that are not fastcall, and presumably 
+	 * a nop in a VM, although driver domains may want real delay. */
+	void (*const_udelay)(unsigned long loops);
 
 	/* These two are jmp to, not actually called. */
 	void (fastcall *irq_enable_sysexit)(void);
@@ -224,6 +229,16 @@ static inline char *memory_setup(void)
 	return paravirt_ops.memory_setup();
 }
 
+/* The paravirtualized I/O functions */
+static inline void slow_down_io(void) {
+	paravirt_ops.io_delay();
+#ifdef REALLY_SLOW_IO
+	paravirt_ops.io_delay();
+	paravirt_ops.io_delay();
+	paravirt_ops.io_delay();
+#endif
+}
+
 /* These all sit in the .parainstructions section to tell us what to patch. */
 struct paravirt_patch {
 	u8 *instr; 		/* original instructions */

--------------060103000703060302020304
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

_______________________________________________
Virtualization mailing list
Virtualization@lists.osdl.org
https://lists.osdl.org/mailman/listinfo/virtualization

--------------060103000703060302020304--
