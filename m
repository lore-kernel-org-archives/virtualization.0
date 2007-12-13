From: Glauber de Oliveira Costa <gcosta@redhat.com>
Subject: [PATCH 04/19] removed unused variable
Date: Thu, 13 Dec 2007 11:57:52 -0200
Message-ID: <11975543173017-git-send-email-gcosta__39664.6050656729$1197565159$gmane$org@redhat.com>
References: <11975113122984-git-send-email-gcosta@redhat.com>
	<1197554287294-git-send-email-gcosta@redhat.com>
	<11975542952896-git-send-email-gcosta@redhat.com>
	<11975543001070-git-send-email-gcosta@redhat.com>
	<1197554307167-git-send-email-gcosta@redhat.com>
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <1197554307167-git-send-email-gcosta@redhat.com>
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

This variable is not used anywere, and is then removed

Signed-off-by: Glauber de Oliveira Costa <gcosta@redhat.com>
---
 include/asm-x86/desc_64.h |    5 -----
 1 files changed, 0 insertions(+), 5 deletions(-)

diff --git a/include/asm-x86/desc_64.h b/include/asm-x86/desc_64.h
index 1c26dbb..660cc84 100644
--- a/include/asm-x86/desc_64.h
+++ b/include/asm-x86/desc_64.h
@@ -30,11 +30,6 @@ static inline unsigned long __store_tr(void)
 
 #define store_tr(tr) (tr) = __store_tr()
 
-/*
- * This is the ldt that every process will get unless we need
- * something other than this.
- */
-extern struct desc_struct default_ldt[];
 extern struct gate_struct idt_table[];
 extern struct desc_ptr cpu_gdt_descr[];
 
-- 
1.5.0.6
