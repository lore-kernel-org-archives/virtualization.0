From: Glauber de Oliveira Costa <gcosta@redhat.com>
Subject: [PATCH 08/19] modify write_ldt function
Date: Thu, 13 Dec 2007 11:57:56 -0200
Message-ID: <11975543543850-git-send-email-gcosta__13417.6281434067$1197565547$gmane$org@redhat.com>
References: <11975113122984-git-send-email-gcosta@redhat.com>
	<1197554287294-git-send-email-gcosta@redhat.com>
	<11975542952896-git-send-email-gcosta@redhat.com>
	<11975543001070-git-send-email-gcosta@redhat.com>
	<1197554307167-git-send-email-gcosta@redhat.com>
	<11975543173017-git-send-email-gcosta@redhat.com>
	<11975543382698-git-send-email-gcosta@redhat.com>
	<11975543442801-git-send-email-gcosta@redhat.com>
	<11975543492215-git-send-email-gcosta@redhat.com>
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <11975543492215-git-send-email-gcosta@redhat.com>
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

This patch modifies the write_ldt() function to make use
of the new struct desc_struct instead of entry_1 and entry_2
entries

Signed-off-by: Glauber de Oliveira Costa <gcosta@redhat.com>
---
 arch/x86/kernel/ldt.c |   15 +++++++--------
 1 files changed, 7 insertions(+), 8 deletions(-)

diff --git a/arch/x86/kernel/ldt.c b/arch/x86/kernel/ldt.c
index a8cdca3..7eb0c8a 100644
--- a/arch/x86/kernel/ldt.c
+++ b/arch/x86/kernel/ldt.c
@@ -186,7 +186,7 @@ static int read_default_ldt(void __user *ptr, unsigned long bytecount)
 static int write_ldt(void __user *ptr, unsigned long bytecount, int oldmode)
 {
 	struct mm_struct *mm = current->mm;
-	__u32 entry_1, entry_2;
+	struct desc_struct ldt;
 	int error;
 	struct user_desc ldt_info;
 
@@ -218,21 +218,20 @@ static int write_ldt(void __user *ptr, unsigned long bytecount, int oldmode)
 	/* Allow LDTs to be cleared by the user. */
 	if (ldt_info.base_addr == 0 && ldt_info.limit == 0) {
 		if (oldmode || LDT_empty(&ldt_info)) {
-			entry_1 = 0;
-			entry_2 = 0;
+			memset(&ldt, 0, sizeof(ldt));
 			goto install;
 		}
 	}
 
-	entry_1 = LDT_entry_a(&ldt_info);
-	entry_2 = LDT_entry_b(&ldt_info);
+	ldt.a = LDT_entry_a(&ldt_info);
+	ldt.b = LDT_entry_b(&ldt_info);
 	if (oldmode)
-		entry_2 &= ~(1 << 20);
+		ldt.avl = 0;
 
 	/* Install the new entry ...  */
 install:
-	write_ldt_entry(mm->context.ldt, ldt_info.entry_number, entry_1,
-			entry_2);
+	write_ldt_entry(mm->context.ldt, ldt_info.entry_number,
+			ldt.a, ldt.b);
 	error = 0;
 
 out_unlock:
-- 
1.5.0.6
