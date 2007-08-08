From: Glauber de Oliveira Costa <gcosta@redhat.com>
Subject: [PATCH 10/25] [PATCH] export math_state_restore
Date: Wed,  8 Aug 2007 01:18:57 -0300
Message-ID: <11865467931543-git-send-email-gcosta__33588.4549342611$1186557554$gmane$org@redhat.com>
References: <11865467522495-git-send-email-gcosta@redhat.com>
	<11865467592921-git-send-email-gcosta@redhat.com>
	<1186546763582-git-send-email-gcosta@redhat.com>
	<11865467662182-git-send-email-gcosta@redhat.com>
	<11865467702103-git-send-email-gcosta@redhat.com>
	<11865467741753-git-send-email-gcosta@redhat.com>
	<11865467773012-git-send-email-gcosta@redhat.com>
	<11865467812610-git-send-email-gcosta@redhat.com>
	<1186546785346-git-send-email-gcosta@redhat.com>
	<1186546789356-git-send-email-gcosta@redhat.com>
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <1186546789356-git-send-email-gcosta@redhat.com>
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
Cc: lguest@ozlabs.org, virtualization@lists.linux-foundation.org, chrisw@sous-sol.org, anthony@codemonkey.ws, akpm@linux-foundation.org, Glauber de Oliveira Costa <gcosta@redhat.com>, mingo@elte.hu
List-Id: virtualization@lists.linuxfoundation.org

Export math_state_restore symbol, so it can be used for hypervisors.
They are commonly loaded as modules.

Signed-off-by: Glauber de Oliveira Costa <gcosta@redhat.com>
Signed-off-by: Steven Rostedt <rostedt@goodmis.org>
---
 arch/x86_64/kernel/traps.c |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/arch/x86_64/kernel/traps.c b/arch/x86_64/kernel/traps.c
index 0388842..aacbe12 100644
--- a/arch/x86_64/kernel/traps.c
+++ b/arch/x86_64/kernel/traps.c
@@ -1081,6 +1081,7 @@ asmlinkage void math_state_restore(void)
 	task_thread_info(me)->status |= TS_USEDFPU;
 	me->fpu_counter++;
 }
+EXPORT_SYMBOL_GPL(math_state_restore);
 
 void __init trap_init(void)
 {
-- 
1.4.4.2
