From: Glauber de Oliveira Costa <gcosta@redhat.com>
Subject: [PATCH 6/10] provide read and write cr8 paravirt hooks
Date: Fri, 18 Jan 2008 15:20:21 -0200
Message-ID: <12006768631010-git-send-email-gcosta@redhat.com>
References: <12006768251548-git-send-email-gcosta@redhat.com>
	<12006768362108-git-send-email-gcosta@redhat.com>
	<1200676842822-git-send-email-gcosta@redhat.com>
	<12006768473571-git-send-email-gcosta@redhat.com>
	<12006768521391-git-send-email-gcosta@redhat.com>
	<1200676857691-git-send-email-gcosta@redhat.com>
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <1200676857691-git-send-email-gcosta@redhat.com>
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
Cc: ehabkost@redhat.com, ak@suse.de, virtualization@lists.linux-foundation.org, chrisw@sous-sol.org, tglx@linutronix.de, anthony@codemonkey.ws, hpa@zytor.com, akpm@linux-foundation.org, Glauber de Oliveira Costa <gcosta@redhat.com>, mingo@elte.hu, roland@redhat.com
List-Id: virtualization@lists.linuxfoundation.org

Since the cr8 manipulation functions ended up staying in the tree,
they can't be defined just when PARAVIRT is off: In this patch,
those functions are defined for the PARAVIRT case too.

Signed-off-by: Glauber de Oliveira Costa <gcosta@redhat.com>
---
 include/asm-x86/system.h |   30 ++++++++++++++++--------------
 1 files changed, 16 insertions(+), 14 deletions(-)

diff --git a/include/asm-x86/system.h b/include/asm-x86/system.h
index 692c28c..a33c3f4 100644
--- a/include/asm-x86/system.h
+++ b/include/asm-x86/system.h
@@ -236,6 +236,20 @@ static inline void native_write_cr4(unsigned long val)
 	asm volatile("mov %0,%%cr4": :"r" (val), "m" (__force_order));
 }
 
+#ifdef CONFIG_X86_64
+static inline unsigned long native_read_cr8(void)
+{
+	unsigned long cr8;
+	asm volatile("movq %%cr8,%0" : "=r" (cr8));
+	return cr8;
+}
+
+static inline void native_write_cr8(unsigned long val)
+{
+	asm volatile("movq %0,%%cr8" :: "r" (val) : "memory");
+}
+#endif
+
 static inline void native_wbinvd(void)
 {
 	asm volatile("wbinvd": : :"memory");
@@ -253,21 +267,9 @@ static inline void native_wbinvd(void)
 #define read_cr4_safe()	(native_read_cr4_safe())
 #define write_cr4(x)	(native_write_cr4(x))
 #define wbinvd()	(native_wbinvd())
-
 #ifdef CONFIG_X86_64
-
-static inline unsigned long read_cr8(void)
-{
-	unsigned long cr8;
-	asm volatile("movq %%cr8,%0" : "=r" (cr8));
-	return cr8;
-}
-
-static inline void write_cr8(unsigned long val)
-{
-	asm volatile("movq %0,%%cr8" :: "r" (val) : "memory");
-}
-
+#define read_cr8()	(native_read_cr8())
+#define write_cr8(x)	(native_write_cr8(x))
 #endif
 
 /* Clear the 'TS' bit */
-- 
1.4.4.2
