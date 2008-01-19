From: Glauber de Oliveira Costa <gcosta@redhat.com>
Subject: [PATCH 6/6] export __supported_pte_mask
Date: Fri, 18 Jan 2008 23:59:10 -0200
Message-ID: <1200707981233-git-send-email-gcosta__15569.4049587057$1200708671$gmane$org@redhat.com>
References: <1200707950911-git-send-email-gcosta@redhat.com>
	<12007079562927-git-send-email-gcosta@redhat.com>
	<12007079613080-git-send-email-gcosta@redhat.com>
	<12007079663929-git-send-email-gcosta@redhat.com>
	<1200707971507-git-send-email-gcosta@redhat.com>
	<1200707976298-git-send-email-gcosta@redhat.com>
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <1200707976298-git-send-email-gcosta@redhat.com>
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

export __supported_pte_mask variable as GPL symbol.
lguest is a user of it.

Signed-off-by: Glauber de Oliveira Costa <gcosta@redhat.com>
---
 arch/x86/kernel/setup64.c |    2 ++
 1 files changed, 2 insertions(+), 0 deletions(-)

diff --git a/arch/x86/kernel/setup64.c b/arch/x86/kernel/setup64.c
index 8fa0de8..5cc1339 100644
--- a/arch/x86/kernel/setup64.c
+++ b/arch/x86/kernel/setup64.c
@@ -41,6 +41,8 @@ struct desc_ptr idt_descr = { 256 * 16 - 1, (unsigned long) idt_table };
 char boot_cpu_stack[IRQSTACKSIZE] __attribute__((section(".bss.page_aligned")));
 
 unsigned long __supported_pte_mask __read_mostly = ~0UL;
+EXPORT_SYMBOL_GPL(__supported_pte_mask);
+
 static int do_not_nx __cpuinitdata = 0;
 
 /* noexec=on|off
-- 
1.5.0.6
