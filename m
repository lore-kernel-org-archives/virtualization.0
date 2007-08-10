From: Glauber de Oliveira Costa <gcosta@redhat.com>
Subject: [PATCH 21/25 -v2] export cpu_gdt_descr
Date: Fri, 10 Aug 2007 16:12:33 -0300
Message-ID: <1186773261537-git-send-email-gcosta__1855.89685938812$1186784784$gmane$org@redhat.com>
References: <1186773157329-git-send-email-gcosta@redhat.com>
	<11867731633002-git-send-email-gcosta@redhat.com>
	<11867731681763-git-send-email-gcosta@redhat.com>
	<11867731732274-git-send-email-gcosta@redhat.com>
	<11867731781610-git-send-email-gcosta@redhat.com>
	<11867731831138-git-send-email-gcosta@redhat.com>
	<11867731882768-git-send-email-gcosta@redhat.com>
	<11867731932688-git-send-email-gcosta@redhat.com>
	<11867731981891-git-send-email-gcosta@redhat.com>
	<1186773203887-git-send-email-gcosta@redhat.com>
	<11867732082735-git-send-email-gcosta@redhat.com>
	<11867732121974-git-send-email-gcosta@redhat.com>
	<1186773217875-git-send-email-gcosta@redhat.com>
	<11867732221652-git-send-email-gcosta@redhat.com>
	<11867732273108-git-send-email-gcosta@redhat.com>
	<11867732323106-git-send-email-gcosta@redhat.com>
	<11867732373232-git-send-email-gcosta@redhat.com>
	<11867732424024-git-send-email-gcosta@redhat.com>
	<11867732461037-git-send-email-gcosta@redhat.com>
	<11867732511513-git-send-email!
	-gcosta@redhat.com> <11867732562020-git-send-email-gcosta@redhat.com>
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <11867732562020-git-send-email-gcosta@redhat.com>
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

[  updates from v1
   * make it an EXPORT_SYMBOL_GPL.
   Suggested by Arjan van de Ven
]

Signed-off-by: Glauber de Oliveira Costa <gcosta@redhat.com>
Signed-off-by: Steven Rostedt <rostedt@goodmis.org>
---
 arch/x86_64/kernel/x8664_ksyms.c |    6 ++++++
 1 files changed, 6 insertions(+), 0 deletions(-)

diff --git a/arch/x86_64/kernel/x8664_ksyms.c b/arch/x86_64/kernel/x8664_ksyms.c
index 77c25b3..2d3932d 100644
--- a/arch/x86_64/kernel/x8664_ksyms.c
+++ b/arch/x86_64/kernel/x8664_ksyms.c
@@ -60,3 +60,9 @@ EXPORT_SYMBOL(init_level4_pgt);
 EXPORT_SYMBOL(load_gs_index);
 
 EXPORT_SYMBOL(_proxy_pda);
+
+#ifdef CONFIG_PARAVIRT
+extern unsigned long *cpu_gdt_descr;
+/* Virtualized guests may want to use it */
+EXPORT_SYMBOL_GPL(cpu_gdt_descr);
+#endif
-- 
1.4.4.2
