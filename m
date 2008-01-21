From: Eduardo Habkost <ehabkost@redhat.com>
Subject: [PATCH 3/4] Don't set pagetable_setup_{start,done} hooks on x86_64
Date: Mon, 21 Jan 2008 19:48:52 -0200
Message-ID: <1200952133-31581-4-git-send-email-ehabkost__37003.3663617962$1200952600$gmane$org@redhat.com>
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

paravirt_pagetable_setup_{start,done}() are not used (yet) under x86_64,
and native_pagetable_setup_{start,done}() don't exist on x86_64. So they
don't need to be set.

Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
---
 arch/x86/kernel/paravirt.c |    2 ++
 1 files changed, 2 insertions(+), 0 deletions(-)

diff --git a/arch/x86/kernel/paravirt.c b/arch/x86/kernel/paravirt.c
index c67d331..37f38b7 100644
--- a/arch/x86/kernel/paravirt.c
+++ b/arch/x86/kernel/paravirt.c
@@ -367,8 +367,10 @@ struct pv_apic_ops pv_apic_ops = {
 };
 
 struct pv_mmu_ops pv_mmu_ops = {
+#ifndef CONFIG_X86_64
 	.pagetable_setup_start = native_pagetable_setup_start,
 	.pagetable_setup_done = native_pagetable_setup_done,
+#endif
 
 	.read_cr2 = native_read_cr2,
 	.write_cr2 = native_write_cr2,
-- 
1.5.3.4
