From: Glauber de Oliveira Costa <gcosta@redhat.com>
Subject: [PATCH 03/15] cleanup write_tsc
Date: Thu, 20 Dec 2007 18:03:58 -0200
Message-ID: <11981812041672-git-send-email-gcosta@redhat.com>
References: <11981810504172-git-send-email-gcosta@redhat.com>
	<11981811293763-git-send-email-gcosta@redhat.com>
	<11981811852758-git-send-email-gcosta@redhat.com>
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <11981811852758-git-send-email-gcosta@redhat.com>
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

write_tsc() does not need to be enclosed in any paravirt closure,
as it uses wrmsr(). So we rip off the duplicate in msr.h
and the definition from paravirt.h

Signed-off-by: Glauber de Oliveira Costa <gcosta@redhat.com>
---
 include/asm-x86/msr.h      |    2 --
 include/asm-x86/paravirt.h |    2 --
 2 files changed, 0 insertions(+), 4 deletions(-)

Index: linux-2.6-x86/include/asm-x86/msr.h
===================================================================
--- linux-2.6-x86.orig/include/asm-x86/msr.h	2007-12-20 19:06:59.000000000 -0800
+++ linux-2.6-x86/include/asm-x86/msr.h	2007-12-20 19:07:18.000000000 -0800
@@ -153,8 +153,6 @@
 #define rdtscll(val)						\
 	((val) = native_read_tsc())
 
-#define write_tsc(val1,val2) wrmsr(0x10, val1, val2)
-
 #define rdpmc(counter,low,high)					\
 	do {							\
 		u64 _l = native_read_pmc(counter);		\
Index: linux-2.6-x86/include/asm-x86/paravirt.h
===================================================================
--- linux-2.6-x86.orig/include/asm-x86/paravirt.h	2007-12-20 19:07:17.000000000 -0800
+++ linux-2.6-x86/include/asm-x86/paravirt.h	2007-12-20 19:07:18.000000000 -0800
@@ -657,8 +657,6 @@
 }
 #define calculate_cpu_khz() (pv_time_ops.get_cpu_khz())
 
-#define write_tsc(val1,val2) wrmsr(0x10, val1, val2)
-
 static inline unsigned long long paravirt_read_pmc(int counter)
 {
 	return PVOP_CALL1(u64, pv_cpu_ops.read_pmc, counter);
