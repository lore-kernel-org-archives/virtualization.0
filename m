From: Glauber de Oliveira Costa <gcosta@redhat.com>
Subject: [PATCH 10/19] provide tss_desc
Date: Wed, 12 Dec 2007 10:53:55 -0200
Message-ID: <11974641042757-git-send-email-gcosta__92.7986031912909$1197474410$gmane$org@redhat.com>
References: <1196957800568-git-send-email-gcosta@redhat.com>
	<11974640441088-git-send-email-gcosta@redhat.com>
	<11974640522688-git-send-email-gcosta@redhat.com>
	<1197464057242-git-send-email-gcosta@redhat.com>
	<11974640653022-git-send-email-gcosta@redhat.com>
	<1197464070228-git-send-email-gcosta@redhat.com>
	<11974640752137-git-send-email-gcosta@redhat.com>
	<11974640813511-git-send-email-gcosta@redhat.com>
	<11974640872474-git-send-email-gcosta@redhat.com>
	<11974640932406-git-send-email-gcosta@redhat.com>
	<11974640983333-git-send-email-gcosta@redhat.com>
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <11974640983333-git-send-email-gcosta@redhat.com>
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

Provide a new type, tss_desc, to represent the tss descriptor
in a unified way accross x86_64 and i386

Signed-off-by: Glauber de Oliveira Costa <gcosta@redhat.com>
---
 include/asm-x86/desc_defs.h |    2 ++
 1 files changed, 2 insertions(+), 0 deletions(-)

diff --git a/include/asm-x86/desc_defs.h b/include/asm-x86/desc_defs.h
index 5a58fc1..c4d7874 100644
--- a/include/asm-x86/desc_defs.h
+++ b/include/asm-x86/desc_defs.h
@@ -70,9 +70,11 @@ struct ldttss_desc64 {
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
1.5.0.6
