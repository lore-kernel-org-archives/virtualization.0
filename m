From: Glauber de Oliveira Costa <gcosta@redhat.com>
Subject: [PATCH 5/6] export check_tsc_unstable
Date: Fri, 18 Jan 2008 23:59:09 -0200
Message-ID: <1200707976298-git-send-email-gcosta__430.219717282121$1200708657$gmane$org@redhat.com>
References: <1200707950911-git-send-email-gcosta@redhat.com>
	<12007079562927-git-send-email-gcosta@redhat.com>
	<12007079613080-git-send-email-gcosta@redhat.com>
	<12007079663929-git-send-email-gcosta@redhat.com>
	<1200707971507-git-send-email-gcosta@redhat.com>
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <1200707971507-git-send-email-gcosta@redhat.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: lguest@ozlabs.org
Cc: linux-kernel@vger.kernel.org, Glauber de Oliveira Costa <gcosta@redhat.com>, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

Exporrt check_tsc_unstable function as GPL symbol. lguest is
a user of it.

Signed-off-by: Glauber de Oliveira Costa <gcosta@redhat.com>
---
 arch/x86/kernel/tsc_64.c |    4 +++-
 1 files changed, 3 insertions(+), 1 deletions(-)

diff --git a/arch/x86/kernel/tsc_64.c b/arch/x86/kernel/tsc_64.c
index c62f3b6..947554d 100644
--- a/arch/x86/kernel/tsc_64.c
+++ b/arch/x86/kernel/tsc_64.c
@@ -92,10 +92,12 @@ sched_clock(void) __attribute__((alias("native_sched_clock")));
 
 static int tsc_unstable;
 
-inline int check_tsc_unstable(void)
+int check_tsc_unstable(void)
 {
 	return tsc_unstable;
 }
+EXPORT_SYMBOL_GPL(check_tsc_unstable);
+
 #ifdef CONFIG_CPU_FREQ
 
 /* Frequency scaling support. Adjust the TSC based timer when the cpu frequency
-- 
1.5.0.6
