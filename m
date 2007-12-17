From: Glauber de Oliveira Costa <gcosta@redhat.com>
Subject: [PATCH 16/21] [PATCH] unify mm_segment_t definition
Date: Mon, 17 Dec 2007 20:52:39 -0200
Message-ID: <11979320451308-git-send-email-gcosta__21558.3059042276$1197943702$gmane$org@redhat.com>
References: <11979319641796-git-send-email-gcosta@redhat.com>
	<1197931971748-git-send-email-gcosta@redhat.com>
	<11979319763641-git-send-email-gcosta@redhat.com>
	<11979319811234-git-send-email-gcosta@redhat.com>
	<11979319853319-git-send-email-gcosta@redhat.com>
	<11979319903443-git-send-email-gcosta@redhat.com>
	<11979319953427-git-send-email-gcosta@redhat.com>
	<11979320011968-git-send-email-gcosta@redhat.com>
	<1197932006634-git-send-email-gcosta@redhat.com>
	<11979320114180-git-send-email-gcosta@redhat.com>
	<11979320163651-git-send-email-gcosta@redhat.com>
	<11979320211287-git-send-email-gcosta@redhat.com>
	<11979320252102-git-send-email-gcosta@redhat.com>
	<11979320302030-git-send-email-gcosta@redhat.com>
	<11979320354186-git-send-email-gcosta@redhat.com>
	<11979320401316-git-send-email-gcosta@redhat.com>
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <11979320401316-git-send-email-gcosta@redhat.com>
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

This patch moves the mm_segment_t structure definition to processor.h
This makes mmsegment.h file useless, and it is deleted.

Signed-off-by: Glauber de Oliveira Costa <gcosta@redhat.com>
---
 include/asm-x86/mmsegment.h      |    8 --------
 include/asm-x86/processor.h      |    5 +++++
 include/asm-x86/processor_32.h   |    5 -----
 include/asm-x86/processor_64.h   |    1 -
 include/asm-x86/thread_info_64.h |    2 +-
 5 files changed, 6 insertions(+), 15 deletions(-)

Index: linux-2.6-x86/include/asm-x86/mmsegment.h
===================================================================
--- linux-2.6-x86.orig/include/asm-x86/mmsegment.h
+++ /dev/null
@@ -1,8 +0,0 @@
-#ifndef _ASM_MMSEGMENT_H
-#define _ASM_MMSEGMENT_H 1
-
-typedef struct {
-	unsigned long seg;
-} mm_segment_t;
-
-#endif
Index: linux-2.6-x86/include/asm-x86/processor.h
===================================================================
--- linux-2.6-x86.orig/include/asm-x86/processor.h
+++ linux-2.6-x86/include/asm-x86/processor.h
@@ -420,6 +420,11 @@ struct extended_sigtable {
 	struct extended_signature sigs[0];
 };
 
+typedef struct {
+	unsigned long seg;
+} mm_segment_t;
+
+
 /*
  * create a kernel thread without removing it from tasklists
  */
Index: linux-2.6-x86/include/asm-x86/processor_32.h
===================================================================
--- linux-2.6-x86.orig/include/asm-x86/processor_32.h
+++ linux-2.6-x86/include/asm-x86/processor_32.h
@@ -103,11 +103,6 @@ union i387_union {
 	struct i387_soft_struct soft;
 };
 
-typedef struct {
-	unsigned long seg;
-} mm_segment_t;
-
-
 #define INIT_THREAD  {							\
 	.sp0 = sizeof(init_stack) + (long)&init_stack,			\
 	.vm86_info = NULL,						\
Index: linux-2.6-x86/include/asm-x86/processor_64.h
===================================================================
--- linux-2.6-x86.orig/include/asm-x86/processor_64.h
+++ linux-2.6-x86/include/asm-x86/processor_64.h
@@ -14,7 +14,6 @@
 #include <asm/msr.h>
 #include <asm/current.h>
 #include <asm/system.h>
-#include <asm/mmsegment.h>
 #include <linux/personality.h>
 #include <asm/desc_defs.h>
 
Index: linux-2.6-x86/include/asm-x86/thread_info_64.h
===================================================================
--- linux-2.6-x86.orig/include/asm-x86/thread_info_64.h
+++ linux-2.6-x86/include/asm-x86/thread_info_64.h
@@ -21,7 +21,7 @@
 #ifndef __ASSEMBLY__
 struct task_struct;
 struct exec_domain;
-#include <asm/mmsegment.h>
+#include <asm/processor.h>
 
 struct thread_info {
 	struct task_struct	*task;		/* main task structure */
