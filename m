From: Glauber de Oliveira Costa <gcosta@redhat.com>
Subject: [PATCH 1/24] mm/sparse-vmemmap.c: make sure init_mm is included
Date: Fri,  9 Nov 2007 16:42:42 -0200
Message-ID: <11946337933104-git-send-email-gcosta__29278.7066115581$1194643858$gmane$org@redhat.com>
References: <11946337851964-git-send-email-gcosta@redhat.com>
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <11946337851964-git-send-email-gcosta@redhat.com>
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
Cc: lguest@ozlabs.org, kvm-devel@lists.sourceforge.net, ak@suse.de, virtualization@lists.linux-foundation.org, chrisw@sous-sol.org, tglx@linutronix.de, anthony@codemonkey.ws, akpm@linux-foundation.org, Glauber de Oliveira Costa <gcosta@redhat.com>, Linus Torvalds <torvalds@linux-foundation.org>, mingo@elte.hu
List-Id: virtualization@lists.linuxfoundation.org

mm/sparse-vmemmap.c uses init_mm in some places.  However, it is not
present in any of the headers currently included in the file.

init_mm is defined as extern in sched.h, so we add it to the headers list

Up to now, this problem was masked by the fact that functions like
set_pte_at() and pmd_populate_kernel() are usually macros that expand to
simpler variants that does not use the first parameter at all.

Signed-off-by: Glauber de Oliveira Costa <gcosta@redhat.com>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
Signed-off-by: Linus Torvalds <torvalds@linux-foundation.org>
---
 mm/sparse-vmemmap.c |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/mm/sparse-vmemmap.c b/mm/sparse-vmemmap.c
index d3b718b..22620f6 100644
--- a/mm/sparse-vmemmap.c
+++ b/mm/sparse-vmemmap.c
@@ -24,6 +24,7 @@
 #include <linux/module.h>
 #include <linux/spinlock.h>
 #include <linux/vmalloc.h>
+#include <linux/sched.h>
 #include <asm/dma.h>
 #include <asm/pgalloc.h>
 #include <asm/pgtable.h>
-- 
1.4.4.2
