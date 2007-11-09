From: Glauber de Oliveira Costa <gcosta@redhat.com>
Subject: [PATCH 11/24] read/write_crX, clts and wbinvd for 64-bit paravirt
Date: Fri,  9 Nov 2007 16:42:52 -0200
Message-ID: <11946338473652-git-send-email-gcosta__22841.4307967343$1194643899$gmane$org@redhat.com>
References: <11946337851964-git-send-email-gcosta@redhat.com>
	<11946337933104-git-send-email-gcosta@redhat.com>
	<11946337991750-git-send-email-gcosta@redhat.com>
	<11946338053158-git-send-email-gcosta@redhat.com>
	<11946338103068-git-send-email-gcosta@redhat.com>
	<1194633815833-git-send-email-gcosta@redhat.com>
	<11946338212915-git-send-email-gcosta@redhat.com>
	<11946338263902-git-send-email-gcosta@redhat.com>
	<1194633831882-git-send-email-gcosta@redhat.com>
	<11946338361369-git-send-email-gcosta@redhat.com>
	<11946338413283-git-send-email-gcosta@redhat.com>
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <11946338413283-git-send-email-gcosta@redhat.com>
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
Cc: lguest@ozlabs.org, kvm-devel@lists.sourceforge.net, ak@suse.de, virtualization@lists.linux-foundation.org, chrisw@sous-sol.org, tglx@linutronix.de, anthony@codemonkey.ws, akpm@linux-foundation.org, Glauber de Oliveira Costa <gcosta@redhat.com>, mingo@elte.hu
List-Id: virtualization@lists.linuxfoundation.org

This patch introduces, and patch callers when needed, native
versions for read/write_crX functions, clts and wbinvd.

Signed-off-by: Glauber de Oliveira Costa <gcosta@redhat.com>
Signed-off-by: Steven Rostedt <rostedt@goodmis.org>
Acked-by: Jeremy Fitzhardinge <jeremy@xensource.com>
---
 arch/x86/mm/pageattr_64.c |    3 ++-
 1 files changed, 2 insertions(+), 1 deletions(-)

diff --git a/arch/x86/mm/pageattr_64.c b/arch/x86/mm/pageattr_64.c
index 14ab327..3a483a8 100644
--- a/arch/x86/mm/pageattr_64.c
+++ b/arch/x86/mm/pageattr_64.c
@@ -13,6 +13,7 @@
 #include <asm/tlbflush.h>
 #include <asm/uaccess.h>
 #include <asm/io.h>
+#include <asm/paravirt.h>
 
 pte_t *lookup_address(unsigned long address)
 {
@@ -84,7 +85,7 @@ static void flush_kernel_map(void *arg)
 	   much cheaper than WBINVD. */
 	/* clflush is still broken. Disable for now. */
 	if (1 || !cpu_has_clflush) {
-		asm volatile("wbinvd" ::: "memory");
+		wbinvd();
 	} else {
 		list_for_each_entry(pg, l, lru) {
 			void *addr = page_address(pg);
-- 
1.4.4.2
