From: Glauber de Oliveira Costa <gcosta@redhat.com>
Subject: [PATCH 21/25] [PATCH] export cpu_gdt_descr
Date: Wed,  8 Aug 2007 01:19:08 -0300
Message-ID: <11865468362401-git-send-email-gcosta__21177.4063100622$1186559113$gmane$org@redhat.com>
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
	<11865467931543-git-send-email-gcosta@redhat.com>
	<11865467973510-git-send-email-gcosta@redhat.com>
	<11865468003673-git-send-email-gcosta@redhat.com>
	<11865468043920-git-send-email-gcosta@redhat.com>
	<118654680831-git-send-email-gcosta@redhat.com>
	<11865468122642-git-send-email-gcosta@redhat.com>
	<11865468162812-git-send-email-gcosta@redhat.com>
	<1186546820708-git-send-email-gcosta@redhat.com>
	<11865468243612-git-send-email-gcosta@redhat.com>
	<11865468281860-git-send-email-gc!
	osta@redhat.com> <11865468321629-git-send-email-gcosta@redhat.com>
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <11865468321629-git-send-email-gcosta@redhat.com>
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

With paravirualization, hypervisors needs to handle the gdt,
that was right to this point only used at very early
inialization code. Hypervisors are commonly modules, so make
it an export

Signed-off-by: Glauber de Oliveira Costa <gcosta@redhat.com>
Signed-off-by: Steven Rostedt <rostedt@goodmis.org>
---
 arch/x86_64/kernel/x8664_ksyms.c |    6 ++++++
 1 files changed, 6 insertions(+), 0 deletions(-)

diff --git a/arch/x86_64/kernel/x8664_ksyms.c b/arch/x86_64/kernel/x8664_ksyms.c
index 77c25b3..8f10698 100644
--- a/arch/x86_64/kernel/x8664_ksyms.c
+++ b/arch/x86_64/kernel/x8664_ksyms.c
@@ -60,3 +60,9 @@ EXPORT_SYMBOL(init_level4_pgt);
 EXPORT_SYMBOL(load_gs_index);
 
 EXPORT_SYMBOL(_proxy_pda);
+
+#ifdef CONFIG_PARAVIRT
+extern unsigned long *cpu_gdt_descr;
+/* Virtualized guests may want to use it */
+EXPORT_SYMBOL(cpu_gdt_descr);
+#endif
-- 
1.4.4.2
