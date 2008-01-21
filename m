From: Eduardo Habkost <ehabkost@redhat.com>
Subject: [PATCH 1/4] Add missing semicolon to SWAPGS macro
Date: Mon, 21 Jan 2008 19:48:50 -0200
Message-ID: <1200952133-31581-2-git-send-email-ehabkost__29754.3122353547$1200952673$gmane$org@redhat.com>
References: <1200952133-31581-1-git-send-email-ehabkost@redhat.com>
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <1200952133-31581-1-git-send-email-ehabkost@redhat.com>
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
Cc: ehabkost@redhat.com, ak@suse.de, virtualization@lists.linux-foundation.org, chrisw@sous-sol.org, tglx@linutronix.de, anthony@codemonkey.ws, hpa@zytor.com, akpm@linux-foundation.org, mingo@elte.hu, roland@redhat.com
List-Id: virtualization@lists.linuxfoundation.org

Trivial compile fix.

Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
---
 include/asm-x86/paravirt.h |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/include/asm-x86/paravirt.h b/include/asm-x86/paravirt.h
index 52bcd9d..62cecb7 100644
--- a/include/asm-x86/paravirt.h
+++ b/include/asm-x86/paravirt.h
@@ -1329,7 +1329,7 @@ static inline unsigned long __raw_local_irq_save(void)
 #else
 #define SWAPGS								\
 	PARA_SITE(PARA_PATCH(pv_cpu_ops, PV_CPU_swapgs), CLBR_NONE,	\
-		  PV_SAVE_REGS						\
+		  PV_SAVE_REGS;						\
 		  call *pv_cpu_ops+PV_CPU_swapgs;			\
 		  PV_RESTORE_REGS					\
 		 )
-- 
1.5.3.4
