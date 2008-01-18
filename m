From: Glauber de Oliveira Costa <gcosta@redhat.com>
Subject: [PATCH 1/10] add missing parameter for lookup_address
Date: Fri, 18 Jan 2008 15:20:16 -0200
Message-ID: <12006768362108-git-send-email-gcosta@redhat.com>
References: <12006768251548-git-send-email-gcosta@redhat.com>
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <12006768251548-git-send-email-gcosta@redhat.com>
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

lookup_address() receives two parameters, but efi_64.c call
is passing only one. It's actually preventing the tree from compiling

Signed-off-by: Glauber de Oliveira Costa <gcosta@redhat.com>
---
 arch/x86/kernel/efi_64.c |    3 ++-
 1 files changed, 2 insertions(+), 1 deletions(-)

diff --git a/arch/x86/kernel/efi_64.c b/arch/x86/kernel/efi_64.c
index f420819..1f8bbd9 100644
--- a/arch/x86/kernel/efi_64.c
+++ b/arch/x86/kernel/efi_64.c
@@ -45,9 +45,10 @@ static void __init early_mapping_set_exec(unsigned long start,
 					  int executable)
 {
 	pte_t *kpte;
+	int level;
 
 	while (start < end) {
-		kpte = lookup_address((unsigned long)__va(start));
+		kpte = lookup_address((unsigned long)__va(start), &level);
 		BUG_ON(!kpte);
 		if (executable)
 			set_pte(kpte, pte_mkexec(*kpte));
-- 
1.4.4.2
