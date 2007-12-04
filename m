From: Glauber de Oliveira Costa <gcosta@redhat.com>
Subject: [PATCH 4/10] split get_cycles_sync
Date: Tue,  4 Dec 2007 09:09:58 -0200
Message-ID: <11967666263502-git-send-email-gcosta__39747.7800179788$1196776636$gmane$org@redhat.com>
References: <11967666042130-git-send-email-gcosta@redhat.com>
	<11967666111489-git-send-email-gcosta@redhat.com>
	<11967666161585-git-send-email-gcosta@redhat.com>
	<11967666212496-git-send-email-gcosta@redhat.com>
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <11967666212496-git-send-email-gcosta@redhat.com>
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
Cc: ehabkost@redhat.com, ak@suse.de, virtualization@lists.linux-foundation.org, chrisw@sous-sol.org, tglx@linutronix.de, anthony@codemonkey.ws, hpa@zytor.com, akpm@linux-foundation.org, Glauber de Oliveira Costa <gcosta@redhat.com>, mingo@elte.hu
List-Id: virtualization@lists.linuxfoundation.org

This patch splits get_cycles_sync() into  __get_cycles_sync(),
and the rdtscll part. Paravirt guests cannot issue rdtscl directly,
as it involves a function call in vdso area.

So, using the __get_cycles_sync() base, we introduce vget_cycles_sync,
which then calls the native version of rdtscll. Ideally, however, a guest
should define its own clocksource, together with a vread function

Signed-off-by: Glauber de Oliveira Costa <gcosta@redhat.com>
---
 arch/x86/kernel/tsc_64.c |    2 +-
 include/asm-x86/tsc.h    |   37 +++++++++++++++++++++++++++++++++----
 2 files changed, 34 insertions(+), 5 deletions(-)

diff --git a/arch/x86/kernel/tsc_64.c b/arch/x86/kernel/tsc_64.c
index 5158476..4502539 100644
--- a/arch/x86/kernel/tsc_64.c
+++ b/arch/x86/kernel/tsc_64.c
@@ -269,7 +269,7 @@ static cycle_t read_tsc(void)
 
 static cycle_t __vsyscall_fn vread_tsc(void)
 {
-	cycle_t ret = (cycle_t)get_cycles_sync();
+	cycle_t ret = (cycle_t)vget_cycles_sync();
 	return ret;
 }
 
diff --git a/include/asm-x86/tsc.h b/include/asm-x86/tsc.h
index 6baab30..d6cb056 100644
--- a/include/asm-x86/tsc.h
+++ b/include/asm-x86/tsc.h
@@ -33,14 +33,14 @@ static inline cycles_t get_cycles(void)
 }
 
 /* Like get_cycles, but make sure the CPU is synchronized. */
-static __always_inline cycles_t get_cycles_sync(void)
+static __always_inline cycles_t __get_cycles_sync(void)
 {
 	unsigned long long ret;
 	unsigned eax, edx;
 
 	/*
-  	 * Use RDTSCP if possible; it is guaranteed to be synchronous
- 	 * and doesn't cause a VMEXIT on Hypervisors
+	 * Use RDTSCP if possible; it is guaranteed to be synchronous
+	 * and doesn't cause a VMEXIT on Hypervisors
 	 */
 	alternative_io(ASM_NOP3, ".byte 0x0f,0x01,0xf9", X86_FEATURE_RDTSCP,
 		       ASM_OUTPUT2("=a" (eax), "=d" (edx)),
@@ -55,11 +55,40 @@ static __always_inline cycles_t get_cycles_sync(void)
 	 */
 	alternative_io("cpuid", ASM_NOP2, X86_FEATURE_SYNC_RDTSC,
 			  "=a" (eax), "0" (1) : "ebx","ecx","edx","memory");
-	rdtscll(ret);
 
+	return 0;
+}
+
+static __always_inline cycles_t get_cycles_sync(void)
+{
+	unsigned long long ret;
+	ret = __get_cycles_sync();
+	if (!ret)
+		rdtscll(ret);
 	return ret;
 }
 
+#ifdef CONFIG_PARAVIRT
+/*
+ * For paravirt guests, some functionalities are executed through function
+ * pointers in the various pvops structures.
+ * These function pointers exist inside the kernel and can not
+ * be accessed by user space. To avoid this, we make a copy of the
+ * get_cycles_sync (called in kernel) but force the use of native_read_tsc.
+ * Ideally, the guest should set up it's own clock and vread
+ */
+static __always_inline long long vget_cycles_sync(void)
+{
+	unsigned long long ret;
+	ret = __get_cycles_sync();
+	if (!ret)
+		ret = native_read_tsc();
+	return ret;
+}
+#else
+# define vget_cycles_sync() get_cycles_sync()
+#endif
+
 extern void tsc_init(void);
 extern void mark_tsc_unstable(char *reason);
 extern int unsynchronized_tsc(void);
-- 
1.4.4.2
