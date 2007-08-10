From: Glauber de Oliveira Costa <gcosta@redhat.com>
Subject: [PATCH 1/25 -v2] header file move
Date: Fri, 10 Aug 2007 16:12:13 -0300
Message-ID: <11867731633002-git-send-email-gcosta__5203.72451651401$1186783368$gmane$org@redhat.com>
References: <1186773157329-git-send-email-gcosta@redhat.com>
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <1186773157329-git-send-email-gcosta@redhat.com>
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

Later on, the paravirt_ops patch will deference the vm_area_struct
in asm/pgtable.h. It means this define must be after the struct
definition

Signed-off-by: Glauber de Oliveira Costa <gcosta@redhat.com>
Signed-off-by: Steven Rostedt <rostedt@goodmis.org>
---
 include/linux/mm.h |   14 +++++++++-----
 1 files changed, 9 insertions(+), 5 deletions(-)

diff --git a/include/linux/mm.h b/include/linux/mm.h
index 655094d..c3f8561 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -35,11 +35,6 @@ extern int sysctl_legacy_va_layout;
 #define sysctl_legacy_va_layout 0
 #endif
 
-#include <asm/page.h>
-#include <asm/pgtable.h>
-#include <asm/processor.h>
-
-#define nth_page(page,n) pfn_to_page(page_to_pfn((page)) + (n))
 
 /*
  * Linux kernel virtual memory manager primitives.
@@ -113,6 +108,15 @@ struct vm_area_struct {
 #endif
 };
 
+#include <asm/page.h>
+/*
+ * pgtable.h must be included after the definition of vm_area_struct.
+ * x86_64 pgtable.h is one of the dereferencers of this struct
+ */
+#include <asm/pgtable.h>
+#include <asm/processor.h>
+
+#define nth_page(page,n) pfn_to_page(page_to_pfn((page)) + (n))
 extern struct kmem_cache *vm_area_cachep;
 
 /*
-- 
1.4.4.2
