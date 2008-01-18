From: Glauber de Oliveira Costa <gcosta@redhat.com>
Subject: [PATCH 7/10] fill pv_cpu_ops structure with cr8 fields
Date: Fri, 18 Jan 2008 15:20:22 -0200
Message-ID: <12006768683247-git-send-email-gcosta@redhat.com>
References: <12006768251548-git-send-email-gcosta@redhat.com>
	<12006768362108-git-send-email-gcosta@redhat.com>
	<1200676842822-git-send-email-gcosta@redhat.com>
	<12006768473571-git-send-email-gcosta@redhat.com>
	<12006768521391-git-send-email-gcosta@redhat.com>
	<1200676857691-git-send-email-gcosta@redhat.com>
	<12006768631010-git-send-email-gcosta@redhat.com>
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <12006768631010-git-send-email-gcosta@redhat.com>
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

This patch fills in the read and write cr8 fields with their
native version

Signed-off-by: Glauber de Oliveira Costa <gcosta@redhat.com>
---
 arch/x86/kernel/paravirt.c |    4 ++++
 1 files changed, 4 insertions(+), 0 deletions(-)

diff --git a/arch/x86/kernel/paravirt.c b/arch/x86/kernel/paravirt.c
index c20b4f8..c67d331 100644
--- a/arch/x86/kernel/paravirt.c
+++ b/arch/x86/kernel/paravirt.c
@@ -319,6 +319,10 @@ struct pv_cpu_ops pv_cpu_ops = {
 	.read_cr4 = native_read_cr4,
 	.read_cr4_safe = native_read_cr4_safe,
 	.write_cr4 = native_write_cr4,
+#ifdef CONFIG_X86_64
+	.read_cr8 = native_read_cr8,
+	.write_cr8 = native_write_cr8,
+#endif
 	.wbinvd = native_wbinvd,
 	.read_msr = native_read_msr_safe,
 	.write_msr = native_write_msr_safe,
-- 
1.4.4.2
