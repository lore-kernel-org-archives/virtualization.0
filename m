From: Glauber de Oliveira Costa <gcosta@redhat.com>
Subject: [PATCH 23/25][V3] provide paravirt patching function
Date: Wed, 15 Aug 2007 09:49:43 -0300
Message-ID: <1187182447280-git-send-email-gcosta__18561.5169503309$1187183030$gmane$org@redhat.com>
References: <11871821854176-git-send-email-gcosta@redhat.com>
	<1187182197314-git-send-email-gcosta@redhat.com>
	<11871822062386-git-send-email-gcosta@redhat.com>
	<11871822163867-git-send-email-gcosta@redhat.com>
	<11871822244170-git-send-email-gcosta@redhat.com>
	<11871822342754-git-send-email-gcosta@redhat.com>
	<11871822421713-git-send-email-gcosta@redhat.com>
	<1187182253740-git-send-email-gcosta@redhat.com>
	<1187182268408-git-send-email-gcosta@redhat.com>
	<1187182282913-git-send-email-gcosta@redhat.com>
	<11871822951747-git-send-email-gcosta@redhat.com>
	<11871823042011-git-send-email-gcosta@redhat.com>
	<11871823151789-git-send-email-gcosta@redhat.com>
	<11871823273810-git-send-email-gcosta@redhat.com>
	<11871823373106-git-send-email-gcosta@redhat.com>
	<11871823673236-git-send-email-gcosta@redhat.com>
	<11871823782610-git-send-email-gcosta@redhat.com>
	<11871823892519-git-send-email-gcosta@redhat.com>
	<11871823991803-git-send-email-gcosta@redhat.com>
	<11871824081337-git-send-email-!
	gcosta@redhat.com> <11871824192375-git-send-email-gcosta@redhat.com>
	<11871824292046-git-send-email-gcosta@redhat.com>
	<1187182438167-git-send-email-gcosta@redhat.com>
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <1187182438167-git-send-email-gcosta@redhat.com>
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
