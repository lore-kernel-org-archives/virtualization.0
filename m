From: Steven Rostedt <rostedt@goodmis.org>
Subject: [RFC/PATCH PV_OPS X86_64 02/17] paravirt_ops - msr
Date: Thu, 08 Mar 2007 01:01:56 -0500
Message-ID: <1173333716.25848.3.camel@localhost.localdomain>
References: <20070308054422.820010000@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
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
To: virtualization@lists.osdl.org
Cc: Chris Wright <chrisw@sous-sol.org>, Glauber de Oliveira Costa <gcosta@redhat.com>
List-Id: virtualization@lists.linuxfoundation.org

plain text document attachment (xx-paravirt-msr-header.patch)
Code consolidations of msr routines for paravirt ops.

Signed-off-by: Steven Rostedt srostedt@redhat.com
Signed-off-by: Glauber de Oliveira Costa <gcosta@redhat.com>



Index: clean-start/include/asm-x86_64/msr.h
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- clean-start.orig/include/asm-x86_64/msr.h
+++ clean-start/include/asm-x86_64/msr.h
@@ -2,6 +2,62 @@
 #define X86_64_MSR_H 1
 =

 #ifndef __ASSEMBLY__
+#include <asm/errno.h>
+
+static inline void native_cpuid(unsigned int *eax, unsigned int *ebx,
+				 unsigned int *ecx, unsigned int *edx)
+{
+	__asm__("cpuid"
+		: "=3Da" (*eax),
+		  "=3Db" (*ebx),
+		  "=3Dc" (*ecx),
+		  "=3Dd" (*edx)
+		: "0" (*eax), "2" (*ecx));
+}
+
+/* wrmsr with exception handling */
+static inline int native_write_msr_safe(unsigned int msr, unsigned long va=
l)
+{
+	int err;
+	asm volatile("2: wrmsr ; xorl %0,%0\n"
+		     "1:\n\t"
+		     ".section .fixup,\"ax\"\n\t"
+		     "3:  movl %4,%0 ; jmp 1b\n\t"
+		     ".previous\n\t"
+ 		     ".section __ex_table,\"a\"\n"
+		     "   .align 8\n\t"
+		     "   .quad 2b,3b\n\t"
+		     ".previous"
+		     : "=3Da" (err)
+		     : "c" (msr), "0" ((u32)val), "d" ((u32)(val>>32)),
+		       "i" (-EFAULT));
+	return err;
+}
+
+/* rdmsr with exception handling */
+static inline unsigned long native_read_msr_safe(unsigned int msr, int *er=
r)
+{
+	unsigned long a, b;
+
+	  asm volatile ("1:       rdmsr\n"
+                      "2:\n"
+                      ".section .fixup,\"ax\"\n"
+                      "3:       movl %4,%0\n"
+                      " jmp 2b\n"
+                      ".previous\n"
+                      ".section __ex_table,\"a\"\n"
+                      " .align 8\n"
+                      " .quad 1b,3b\n"
+                      ".previous":"=3D&bDS" (*err), "=3Da"(a), "=3Dd"(b)
+                      :"c"(msr), "i"(-EIO), "0"(0));
+	return a | (b << 32);
+}
+
+#ifdef CONFIG_PARAVIRT
+#include <asm/paravirt.h>
+#else
+
+#define __cpuid native_cpuid
 /*
  * Access to machine-specific registers (available on 586 and better only)
  * Note: the rd* operations modify the parameters directly (without using
@@ -28,37 +84,18 @@
 =

 #define wrmsrl(msr,val) wrmsr(msr,(__u32)((__u64)(val)),((__u64)(val))>>32=
) =

 =

-/* wrmsr with exception handling */
-#define wrmsr_safe(msr,a,b) ({ int ret__;			\
-	asm volatile("2: wrmsr ; xorl %0,%0\n"			\
-		     "1:\n\t"					\
-		     ".section .fixup,\"ax\"\n\t"		\
-		     "3:  movl %4,%0 ; jmp 1b\n\t"		\
-		     ".previous\n\t"				\
- 		     ".section __ex_table,\"a\"\n"		\
-		     "   .align 8\n\t"				\
-		     "   .quad 	2b,3b\n\t"			\
-		     ".previous"				\
-		     : "=3Da" (ret__)				\
-		     : "c" (msr), "0" (a), "d" (b), "i" (-EFAULT)); \
-	ret__; })
-
-#define checking_wrmsrl(msr,val) wrmsr_safe(msr,(u32)(val),(u32)((val)>>32=
))
-
-#define rdmsr_safe(msr,a,b) \
-	({ int ret__;						\
-	  asm volatile ("1:       rdmsr\n"			\
-                      "2:\n"					\
-                      ".section .fixup,\"ax\"\n"		\
-                      "3:       movl %4,%0\n"			\
-                      " jmp 2b\n"				\
-                      ".previous\n"				\
-                      ".section __ex_table,\"a\"\n"		\
-                      " .align 8\n"				\
-                      " .quad 1b,3b\n"				\
-                      ".previous":"=3D&bDS" (ret__), "=3Da"(*(a)), "=3Dd"(=
*(b))\
-                      :"c"(msr), "i"(-EIO), "0"(0));		\
-	  ret__; })		=

+#define wrmsr_safe(msr,val1,val2)					\
+		native_write_msr_safe(msr,(u64)(val1)|(u64)(val2)<<32)
+
+#define rdmsr_safe(msr,val1,val2)				\
+	({							\
+		int __err;					\
+		unsigned long __val;				\
+		__val =3D native_read_msr_safe(msr, &__err);	\
+		*val1 =3D (u32)__val;				\
+		*val2 =3D (u32)(__val>>32);			\
+		__err;						\
+	})
 =

 #define rdtsc(low,high) \
      __asm__ __volatile__("rdtsc" : "=3Da" (low), "=3Dd" (high))
@@ -66,8 +103,6 @@
 #define rdtscl(low) \
      __asm__ __volatile__ ("rdtsc" : "=3Da" (low) : : "edx")
 =

-#define rdtscp(low,high,aux) \
-     asm volatile (".byte 0x0f,0x01,0xf9" : "=3Da" (low), "=3Dd" (high), "=
=3Dc" (aux))
 =

 #define rdtscll(val) do { \
      unsigned int __a,__d; \
@@ -75,42 +110,43 @@
      (val) =3D ((unsigned long)__a) | (((unsigned long)__d)<<32); \
 } while(0)
 =

+#define rdpmc(counter,low,high) \
+     __asm__ __volatile__("rdpmc" \
+			  : "=3Da" (low), "=3Dd" (high) \
+			  : "c" (counter))
+
+#define rdtscp(low,high,aux) \
+     asm volatile (".byte 0x0f,0x01,0xf9" : "=3Da" (low), "=3Dd" (high), "=
=3Dc" (aux))
+
 #define rdtscpll(val, aux) do { \
      unsigned long __a, __d; \
      asm volatile (".byte 0x0f,0x01,0xf9" : "=3Da" (__a), "=3Dd" (__d), "=
=3Dc" (aux)); \
      (val) =3D (__d << 32) | __a; \
 } while (0)
 =

+#define checking_wrmsrl(msr,val) native_write_msr_safe(msr, val)
+
+#endif /* CONFIG_PARAVIRT */
+
 #define write_tsc(val1,val2) wrmsr(0x10, val1, val2)
 =

 #define write_rdtscp_aux(val) wrmsr(0xc0000103, val, 0)
 =

-#define rdpmc(counter,low,high) \
-     __asm__ __volatile__("rdpmc" \
-			  : "=3Da" (low), "=3Dd" (high) \
-			  : "c" (counter))
-
-static inline void cpuid(int op, unsigned int *eax, unsigned int *ebx,
+static inline void cpuid(unsigned int op, unsigned int *eax, unsigned int =
*ebx,
 			 unsigned int *ecx, unsigned int *edx)
 {
-	__asm__("cpuid"
-		: "=3Da" (*eax),
-		  "=3Db" (*ebx),
-		  "=3Dc" (*ecx),
-		  "=3Dd" (*edx)
-		: "0" (op));
+	*eax =3D op;
+	*ecx =3D 0;
+	__cpuid(eax, ebx, ecx, edx);
 }
 =

 /* Some CPUID calls want 'count' to be placed in ecx */
-static inline void cpuid_count(int op, int count, int *eax, int *ebx, int =
*ecx,
-	       	int *edx)
+static inline void cpuid_count(int op, int count,
+			 int *eax, int *ebx, int *ecx, int *edx)
 {
-	__asm__("cpuid"
-		: "=3Da" (*eax),
-		  "=3Db" (*ebx),
-		  "=3Dc" (*ecx),
-		  "=3Dd" (*edx)
-		: "0" (op), "c" (count));
+	*eax =3D op;
+	*ecx =3D count;
+	__cpuid(eax, ebx, ecx, edx);
 }
 =

 /*
@@ -118,42 +154,34 @@ static inline void cpuid_count(int op, i
  */
 static inline unsigned int cpuid_eax(unsigned int op)
 {
-	unsigned int eax;
-
-	__asm__("cpuid"
-		: "=3Da" (eax)
-		: "0" (op)
-		: "bx", "cx", "dx");
+	unsigned int eax, ebx, ecx, edx;
+	eax =3D op;
+	ecx =3D 0;
+	__cpuid(&eax, &ebx, &ecx, &edx);
 	return eax;
 }
 static inline unsigned int cpuid_ebx(unsigned int op)
 {
-	unsigned int eax, ebx;
-
-	__asm__("cpuid"
-		: "=3Da" (eax), "=3Db" (ebx)
-		: "0" (op)
-		: "cx", "dx" );
+	unsigned int eax, ebx, ecx, edx;
+	eax =3D op;
+	ecx =3D 0;
+	__cpuid(&eax, &ebx, &ecx, &edx);
 	return ebx;
 }
 static inline unsigned int cpuid_ecx(unsigned int op)
 {
-	unsigned int eax, ecx;
-
-	__asm__("cpuid"
-		: "=3Da" (eax), "=3Dc" (ecx)
-		: "0" (op)
-		: "bx", "dx" );
+	unsigned int eax, ebx, ecx, edx;
+	eax =3D op;
+	ecx =3D 0;
+	__cpuid(&eax, &ebx, &ecx, &edx);
 	return ecx;
 }
 static inline unsigned int cpuid_edx(unsigned int op)
 {
-	unsigned int eax, edx;
-
-	__asm__("cpuid"
-		: "=3Da" (eax), "=3Dd" (edx)
-		: "0" (op)
-		: "bx", "cx");
+	unsigned int eax, ebx, ecx, edx;
+	eax =3D op;
+	ecx =3D 0;
+	__cpuid(&eax, &ebx, &ecx, &edx);
 	return edx;
 }
 =


--
