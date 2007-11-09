From: Glauber de Oliveira Costa <gcosta@redhat.com>
Subject: [PATCH 20/24] tweak io_64.h for paravirt.
Date: Fri,  9 Nov 2007 16:43:01 -0200
Message-ID: <11946338932611-git-send-email-gcosta__28106.2706410468$1194645972$gmane$org@redhat.com>
References: <11946337851964-git-send-email-gcosta@redhat.com>
	<11946337933104-git-send-email-gcosta@redhat.com>
	<11946337991750-git-send-email-gcosta@redhat.com>
	<11946338053158-git-send-email-gcosta@redhat.com>
	<11946338103068-git-send-email-gcosta@redhat.com>
	<1194633815833-git-send-email-gcosta@redhat.com>
	<11946338212915-git-send-email-gcosta@redhat.com>
	<11946338263902-git-send-email-gcosta@redhat.com>
	<1194633831882-git-send-email-gcosta@redhat.com>
	<11946338361369-git-send-email-gcosta@redhat.com>
	<11946338413283-git-send-email-gcosta@redhat.com>
	<11946338473652-git-send-email-gcosta@redhat.com>
	<1194633852469-git-send-email-gcosta@redhat.com>
	<1194633857930-git-send-email-gcosta@redhat.com>
	<11946338621966-git-send-email-gcosta@redhat.com>
	<11946338683305-git-send-email-gcosta@redhat.com>
	<1194633873306-git-send-email-gcosta@redhat.com>
	<1194633878886-git-send-email-gcosta@redhat.com>
	<11946338832681-git-send-email-gcosta@redhat.com>
	<1194633888761-git-send-email-gco! sta@redhat.com>
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <1194633888761-git-send-email-gcosta@redhat.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: linux-kernel@vger.kernel.org
Cc: lguest@ozlabs.org, kvm-devel@lists.sourceforge.net, ak@suse.de, virtualization@lists.linux-foundation.org, chrisw@sous-sol.org, tglx@linutronix.de, anthony@codemonkey.ws, akpm@linux-foundation.org, Glauber de Oliveira Costa <gcosta@redhat.com>, mingo@elte.hu
List-Id: virtualization@lists.linuxfoundation.org

We need something here because we can't call in and out instructions
directly. However, we have to be careful, because no indirections are
allowed in misc_64.c , and paravirt_ops is a kind of one. So just
call it directly there

Signed-off-by: Glauber de Oliveira Costa <gcosta@redhat.com>
Signed-off-by: Steven Rostedt <rostedt@goodmis.org>
Acked-by: Jeremy Fitzhardinge <jeremy@xensource.com>
---
 arch/x86/boot/compressed/misc_64.c |    6 +++++
 include/asm-x86/io_64.h            |   37 +++++++++++++++++++++++++++++------
 2 files changed, 36 insertions(+), 7 deletions(-)

diff --git a/arch/x86/boot/compressed/misc_64.c b/arch/x86/boot/compressed/misc_64.c
index 6ea015a..6640a17 100644
--- a/arch/x86/boot/compressed/misc_64.c
+++ b/arch/x86/boot/compressed/misc_64.c
@@ -9,6 +9,12 @@
  * High loaded stuff by Hans Lermen & Werner Almesberger, Feb. 1996
  */
 
+/*
+ * we have to be careful, because no indirections are allowed here, and
+ * paravirt_ops is a kind of one. As it will only run in baremetal anyway,
+ * we just keep it from happening
+ */
+#undef CONFIG_PARAVIRT
 #define _LINUX_STRING_H_ 1
 #define __LINUX_BITMAP_H 1
 
diff --git a/include/asm-x86/io_64.h b/include/asm-x86/io_64.h
index a037b07..57fcdd9 100644
--- a/include/asm-x86/io_64.h
+++ b/include/asm-x86/io_64.h
@@ -35,12 +35,24 @@
   *  - Arnaldo Carvalho de Melo <acme@conectiva.com.br>
   */
 
-#define __SLOW_DOWN_IO "\noutb %%al,$0x80"
+static inline void native_io_delay(void)
+{
+	asm volatile("outb %%al,$0x80" : : : "memory");
+}
 
-#ifdef REALLY_SLOW_IO
-#define __FULL_SLOW_DOWN_IO __SLOW_DOWN_IO __SLOW_DOWN_IO __SLOW_DOWN_IO __SLOW_DOWN_IO
+#if defined(CONFIG_PARAVIRT)
+#include <asm/paravirt.h>
 #else
-#define __FULL_SLOW_DOWN_IO __SLOW_DOWN_IO
+
+static inline void slow_down_io(void)
+{
+	native_io_delay();
+#ifdef REALLY_SLOW_IO
+	native_io_delay();
+	native_io_delay();
+	native_io_delay();
+#endif
+}
 #endif
 
 /*
@@ -52,9 +64,15 @@ static inline void out##s(unsigned x value, unsigned short port) {
 #define __OUT2(s,s1,s2) \
 __asm__ __volatile__ ("out" #s " %" s1 "0,%" s2 "1"
 
+#ifndef REALLY_SLOW_IO
+#define REALLY_SLOW_IO
+#define UNSET_REALLY_SLOW_IO
+#endif
+
 #define __OUT(s,s1,x) \
 __OUT1(s,x) __OUT2(s,s1,"w") : : "a" (value), "Nd" (port)); } \
-__OUT1(s##_p,x) __OUT2(s,s1,"w") __FULL_SLOW_DOWN_IO : : "a" (value), "Nd" (port));} \
+__OUT1(s##_p, x) __OUT2(s, s1, "w") : : "a" (value), "Nd" (port)); \
+		slow_down_io(); }
 
 #define __IN1(s) \
 static inline RETURN_TYPE in##s(unsigned short port) { RETURN_TYPE _v;
@@ -63,8 +81,13 @@ static inline RETURN_TYPE in##s(unsigned short port) { RETURN_TYPE _v;
 __asm__ __volatile__ ("in" #s " %" s2 "1,%" s1 "0"
 
 #define __IN(s,s1,i...) \
-__IN1(s) __IN2(s,s1,"w") : "=a" (_v) : "Nd" (port) ,##i ); return _v; } \
-__IN1(s##_p) __IN2(s,s1,"w") __FULL_SLOW_DOWN_IO : "=a" (_v) : "Nd" (port) ,##i ); return _v; } \
+__IN1(s) __IN2(s, s1, "w") : "=a" (_v) : "Nd" (port), ##i); return _v; } \
+__IN1(s##_p) __IN2(s, s1, "w") : "=a" (_v) : "Nd" (port), ##i);	  \
+				slow_down_io(); return _v; }
+
+#ifdef UNSET_REALLY_SLOW_IO
+#undef REALLY_SLOW_IO
+#endif
 
 #define __INS(s) \
 static inline void ins##s(unsigned short port, void * addr, unsigned long count) \
-- 
1.4.4.2
