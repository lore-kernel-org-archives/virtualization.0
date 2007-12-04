From: Glauber de Oliveira Costa <gcosta@redhat.com>
Subject: [PATCH 3/10] allow sched clock to be overridden by paravirt
Date: Tue,  4 Dec 2007 09:09:57 -0200
Message-ID: <11967666212496-git-send-email-gcosta__24884.3135232621$1196776625$gmane$org@redhat.com>
References: <11967666042130-git-send-email-gcosta@redhat.com>
	<11967666111489-git-send-email-gcosta@redhat.com>
	<11967666161585-git-send-email-gcosta@redhat.com>
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <11967666161585-git-send-email-gcosta@redhat.com>
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

This patch turns the sched_clock into native_sched_clock.
sched clock becomes a weak symbol, which can then give its
place to a paravirt definition.

Signed-off-by: Glauber de Oliveira Costa <gcosta@redhat.com>
---
 arch/x86/kernel/tsc_64.c |   15 ++++++++++++++-
 1 files changed, 14 insertions(+), 1 deletions(-)

diff --git a/arch/x86/kernel/tsc_64.c b/arch/x86/kernel/tsc_64.c
index 9c70af4..5158476 100644
--- a/arch/x86/kernel/tsc_64.c
+++ b/arch/x86/kernel/tsc_64.c
@@ -30,7 +30,7 @@ static unsigned long long cycles_2_ns(unsigned long long cyc)
 	return (cyc * cyc2ns_scale) >> NS_SCALE;
 }
 
-unsigned long long sched_clock(void)
+unsigned long long native_sched_clock(void)
 {
 	unsigned long a = 0;
 
@@ -44,6 +44,19 @@ unsigned long long sched_clock(void)
 	return cycles_2_ns(a);
 }
 
+/* We need to define a real function for sched_clock, to override the
+   weak default version */
+#ifdef CONFIG_PARAVIRT
+unsigned long long sched_clock(void)
+{
+	return paravirt_sched_clock();
+}
+#else
+unsigned long long
+sched_clock(void) __attribute__((alias("native_sched_clock")));
+#endif
+
+
 static int tsc_unstable;
 
 inline int check_tsc_unstable(void)
-- 
1.4.4.2
