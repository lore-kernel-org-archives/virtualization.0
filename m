From: Glauber de Oliveira Costa <gcosta@redhat.com>
Subject: [PATCH 23/25 -v2] provide paravirt patching function
Date: Fri, 10 Aug 2007 16:12:35 -0300
Message-ID: <11867732713519-git-send-email-gcosta__34103.0500633225$1186785081$gmane$org@redhat.com>
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
	<1186773261537-git-send-email-gcosta@redhat.com>
	<11867732661840-git-send-email-gcosta@redhat.com>
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <11867732661840-git-send-email-gcosta@redhat.com>
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

This patch introduces apply_paravirt(), a function that shall
be called by i386/alternative.c to apply replacements to
paravirt_functions. It is defined to an do-nothing function
if paravirt is not enabled.

Signed-off-by: Glauber de Oliveira Costa <gcosta@redhat.com>
Signed-off-by: Steven Rostedt <rostedt@goodmis.org>
---
 include/asm-x86_64/alternative.h |    8 +++++---
 1 files changed, 5 insertions(+), 3 deletions(-)

diff --git a/include/asm-x86_64/alternative.h b/include/asm-x86_64/alternative.h
index ab161e8..e69a141 100644
--- a/include/asm-x86_64/alternative.h
+++ b/include/asm-x86_64/alternative.h
@@ -143,12 +143,14 @@ static inline void alternatives_smp_switch(int smp) {}
  */
 #define ASM_OUTPUT2(a, b) a, b
 
-struct paravirt_patch;
+struct paravirt_patch_site;
 #ifdef CONFIG_PARAVIRT
-void apply_paravirt(struct paravirt_patch *start, struct paravirt_patch *end);
+void apply_paravirt(struct paravirt_patch_site *start,
+				struct paravirt_patch_site *end);
 #else
 static inline void
-apply_paravirt(struct paravirt_patch *start, struct paravirt_patch *end)
+apply_paravirt(struct paravirt_patch_site *start,
+				struct paravirt_patch_site *end)
 {}
 #define __parainstructions NULL
 #define __parainstructions_end NULL
-- 
1.4.4.2
