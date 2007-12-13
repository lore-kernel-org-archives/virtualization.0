From: Glauber de Oliveira Costa <gcosta@redhat.com>
Subject: [PATCH 10/19] provide tss_desc
Date: Thu, 13 Dec 2007 11:57:58 -0200
Message-ID: <11975543641360-git-send-email-gcosta__658.355750101869$1197565397$gmane$org@redhat.com>
References: <11975113122984-git-send-email-gcosta@redhat.com>
	<1197554287294-git-send-email-gcosta@redhat.com>
	<11975542952896-git-send-email-gcosta@redhat.com>
	<11975543001070-git-send-email-gcosta@redhat.com>
	<1197554307167-git-send-email-gcosta@redhat.com>
	<11975543173017-git-send-email-gcosta@redhat.com>
	<11975543382698-git-send-email-gcosta@redhat.com>
	<11975543442801-git-send-email-gcosta@redhat.com>
	<11975543492215-git-send-email-gcosta@redhat.com>
	<11975543543850-git-send-email-gcosta@redhat.com>
	<11975543592701-git-send-email-gcosta@redhat.com>
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <11975543592701-git-send-email-gcosta@redhat.com>
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
