From: Glauber de Oliveira Costa <gcosta@redhat.com>
Subject: [PATCH 4/10] put generic mm_hooks include into PARAVIRT
Date: Fri, 18 Jan 2008 15:20:19 -0200
Message-ID: <12006768521391-git-send-email-gcosta__32923.5265999616$1200686815$gmane$org@redhat.com>
References: <12006768251548-git-send-email-gcosta@redhat.com>
	<12006768362108-git-send-email-gcosta@redhat.com>
	<1200676842822-git-send-email-gcosta@redhat.com>
	<12006768473571-git-send-email-gcosta@redhat.com>
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <12006768473571-git-send-email-gcosta@redhat.com>
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

With PARAVIRT, we actually have arch_{dup,exit}_mmap functions,
so we can't include the generic header

Signed-off-by: Glauber de Oliveira Costa <gcosta@redhat.com>
---
 include/asm-x86/mmu_context_64.h |    2 ++
 1 files changed, 2 insertions(+), 0 deletions(-)

diff --git a/include/asm-x86/mmu_context_64.h b/include/asm-x86/mmu_context_64.h
index 7e2aa23..ad6dc82 100644
--- a/include/asm-x86/mmu_context_64.h
+++ b/include/asm-x86/mmu_context_64.h
@@ -7,7 +7,9 @@
 #include <asm/pda.h>
 #include <asm/pgtable.h>
 #include <asm/tlbflush.h>
+#ifndef CONFIG_PARAVIRT
 #include <asm-generic/mm_hooks.h>
+#endif
 
 /*
  * possibly do the LDT unload here?
-- 
1.4.4.2
