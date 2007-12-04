From: Glauber de Oliveira Costa <gcosta@redhat.com>
Subject: [PATCH 7/10] change rdpmc interface
Date: Tue,  4 Dec 2007 14:03:57 -0200
Message-ID: <11967842762820-git-send-email-gcosta@redhat.com>
References: 20071204140939.GA16328@elte.hu
	<11967842402729-git-send-email-gcosta@redhat.com>
	<11967842482873-git-send-email-gcosta@redhat.com>
	<11967842531735-git-send-email-gcosta@redhat.com>
	<11967842573035-git-send-email-gcosta@redhat.com>
	<11967842622658-git-send-email-gcosta@redhat.com>
	<119678426719-git-send-email-gcosta@redhat.com>
	<11967842711043-git-send-email-gcosta@redhat.com>
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <11967842711043-git-send-email-gcosta@redhat.com>
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

the rdpmc instruction gets a counter argument in rcx. However,
the i386 version was ignoring it. To make both x86_64 and i386 versions
the same, as well as to comply with the instruction semantics, this
parameter is added in the i386 version

Signed-off-by: Glauber de Oliveira Costa <gcosta@redhat.com>
---
 include/asm-x86/msr.h      |    6 +++---
 include/asm-x86/paravirt.h |    2 +-
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/include/asm-x86/msr.h b/include/asm-x86/msr.h
index 0296358..ce2a257 100644
--- a/include/asm-x86/msr.h
+++ b/include/asm-x86/msr.h
@@ -90,10 +90,10 @@ static inline unsigned long long native_read_tsc(void)
 	return val;
 }
 
-static inline unsigned long long native_read_pmc(void)
+static inline unsigned long long native_read_pmc(int counter)
 {
 	unsigned long long val;
-	asm volatile("rdpmc" : "=A" (val));
+	asm volatile("rdpmc" : "=A" (val) : "c" (counter));
 	return val;
 }
 
@@ -150,7 +150,7 @@ static inline int wrmsr_safe(u32 __msr, u32 __low, u32 __high)
 
 #define rdpmc(counter,low,high)					\
 	do {							\
-		u64 _l = native_read_pmc();			\
+		u64 _l = native_read_pmc(counter);		\
 		(low)  = (u32)_l;				\
 		(high) = (u32)(_l >> 32);			\
 	} while(0)
diff --git a/include/asm-x86/paravirt.h b/include/asm-x86/paravirt.h
index f59d370..4a7be97 100644
--- a/include/asm-x86/paravirt.h
+++ b/include/asm-x86/paravirt.h
@@ -118,7 +118,7 @@ struct pv_cpu_ops {
 	int (*write_msr)(unsigned int msr, u64 val);
 
 	u64 (*read_tsc)(void);
-	u64 (*read_pmc)(void);
+	u64 (*read_pmc)(int counter);
 
 	/* These two are jmp to, not actually called. */
 	void (*irq_enable_sysexit)(void);
-- 
1.4.4.2
