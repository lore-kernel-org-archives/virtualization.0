From: Glauber de Oliveira Costa <gcosta@redhat.com>
Subject: [PATCH 1/3] [PATCH] put get_kernel_rpl in a common location
Date: Fri,  7 Dec 2007 14:22:40 -0200
Message-ID: <11970445742522-git-send-email-gcosta__49761.5776294426$1197054579$gmane$org@redhat.com>
References: <119704456265-git-send-email-gcosta@redhat.com>
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <119704456265-git-send-email-gcosta@redhat.com>
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
Cc: ehabkost@redhat.com, ak@suse.de, virtualization@lists.linux-foundation.org, chrisw@sous-sol.org, tglx@linutronix.de, anthony@codemonkey.ws, hpa@zytor.com, akpm@linux-foundation.org, Glauber de Oliveira Costa <gcosta@redhat.com>, mingo@elte.hu
List-Id: virtualization@lists.linuxfoundation.org

This macro is useful for both i386 and x86_64, so put it in a common
location, where both arches can grab it.

Signed-off-by: Glauber de Oliveira Costa <gcosta@redhat.com>
---
 include/asm-x86/segment.h    |    9 +++++++++
 include/asm-x86/segment_32.h |    3 ---
 2 files changed, 9 insertions(+), 3 deletions(-)

diff --git a/include/asm-x86/segment.h b/include/asm-x86/segment.h
index 6050682..b3a7a3e 100644
--- a/include/asm-x86/segment.h
+++ b/include/asm-x86/segment.h
@@ -1,5 +1,14 @@
+#ifndef _ASM_X86_SEGMENT_H_
+#define _ASM_X86_SEGMENT_H_
+
 #ifdef CONFIG_X86_32
 # include "segment_32.h"
 #else
 # include "segment_64.h"
 #endif
+
+#ifndef CONFIG_PARAVIRT
+#define get_kernel_rpl()  0
+#endif
+
+#endif
diff --git a/include/asm-x86/segment_32.h b/include/asm-x86/segment_32.h
index 597a47c..ff186e3 100644
--- a/include/asm-x86/segment_32.h
+++ b/include/asm-x86/segment_32.h
@@ -129,9 +129,6 @@
 #define SEGMENT_LDT		0x4
 #define SEGMENT_GDT		0x0
 
-#ifndef CONFIG_PARAVIRT
-#define get_kernel_rpl()  0
-#endif
 /*
  * Matching rules for certain types of segments.
  */
-- 
1.4.4.2
