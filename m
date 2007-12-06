From: Glauber de Oliveira Costa <gcosta@redhat.com>
Subject: [PATCH 16/19] provide tss_desc
Date: Thu,  6 Dec 2007 14:16:37 -0200
Message-ID: <11969578811685-git-send-email-gcosta__14250.017310451$1196968550$gmane$org@redhat.com>
References: <1196957800568-git-send-email-gcosta@redhat.com>
	<11969578092869-git-send-email-gcosta@redhat.com>
	<11969578142514-git-send-email-gcosta@redhat.com>
	<11969578193406-git-send-email-gcosta@redhat.com>
	<11969578242463-git-send-email-gcosta@redhat.com>
	<11969578292944-git-send-email-gcosta@redhat.com>
	<11969578343061-git-send-email-gcosta@redhat.com>
	<11969578383955-git-send-email-gcosta@redhat.com>
	<11969578431489-git-send-email-gcosta@redhat.com>
	<11969578483552-git-send-email-gcosta@redhat.com>
	<11969578534185-git-send-email-gcosta@redhat.com>
	<11969578581299-git-send-email-gcosta@redhat.com>
	<1196957863723-git-send-email-gcosta@redhat.com>
	<11969578671479-git-send-email-gcosta@redhat.com>
	<119695787262-git-send-email-gcosta@redhat.com>
	<11969578773678-git-send-email-gcosta@redhat.com>
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <11969578773678-git-send-email-gcosta@redhat.com>
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

Provide a new type, tss_desc, to represent the tss descriptor
in a unified way accross x86_64 and i386

Signed-off-by: Glauber de Oliveira Costa <gcosta@redhat.com>
---
 include/asm-x86/desc_defs.h |    2 ++
 1 files changed, 2 insertions(+), 0 deletions(-)

diff --git a/include/asm-x86/desc_defs.h b/include/asm-x86/desc_defs.h
index 3bfb7d9..d4ae70d 100644
--- a/include/asm-x86/desc_defs.h
+++ b/include/asm-x86/desc_defs.h
@@ -80,9 +80,11 @@ struct ldttss_desc64 {
 #ifdef CONFIG_X86_64
 typedef struct gate_struct64 gate_desc;
 typedef struct ldttss_desc64 ldt_desc;
+typedef struct ldttss_desc64 tss_desc;
 #else
 typedef struct desc_struct gate_desc;
 typedef struct desc_struct ldt_desc;
+typedef struct desc_struct tss_desc;
 #endif
 
 struct desc_ptr {
-- 
1.4.4.2
