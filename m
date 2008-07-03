From: Isaku Yamahata <yamahata@valinux.co.jp>
Subject: [PATCH] ia64: move function declaration,
	ia64_cpu_local_tick() from .c to .h
Date: Thu,  3 Jul 2008 15:54:37 +0900
Message-ID: <12150681053484-git-send-email-yamahata__1425.15832926637$1215068466$gmane$org@valinux.co.jp>
References: <1215068105921-git-send-email-yamahata@valinux.co.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <1215068105921-git-send-email-yamahata@valinux.co.jp>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: linux-ia64@vger.kernel.org
Cc: yamahata@valinux.co.jp, xen-ia64-devel@lists.xensource.com, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

eliminate the function declaration ia64_cpu_local_tick() in
process.c by defining in asm-ia64/timex.h
The same function will be used in a different .c file later.

Signed-off-by: Isaku Yamahata <yamahata@valinux.co.jp>
---
 arch/ia64/kernel/process.c |    1 -
 include/asm-ia64/timex.h   |    2 ++
 2 files changed, 2 insertions(+), 1 deletions(-)

diff --git a/arch/ia64/kernel/process.c b/arch/ia64/kernel/process.c
index a3a34b4..1fbd9b8 100644
--- a/arch/ia64/kernel/process.c
+++ b/arch/ia64/kernel/process.c
@@ -247,7 +247,6 @@ default_idle (void)
 /* We don't actually take CPU down, just spin without interrupts. */
 static inline void play_dead(void)
 {
-	extern void ia64_cpu_local_tick (void);
 	unsigned int this_cpu = smp_processor_id();
 
 	/* Ack it */
diff --git a/include/asm-ia64/timex.h b/include/asm-ia64/timex.h
index 05a6baf..4e03cfe 100644
--- a/include/asm-ia64/timex.h
+++ b/include/asm-ia64/timex.h
@@ -39,4 +39,6 @@ get_cycles (void)
 	return ret;
 }
 
+extern void ia64_cpu_local_tick (void);
+
 #endif /* _ASM_IA64_TIMEX_H */
-- 
1.5.3
