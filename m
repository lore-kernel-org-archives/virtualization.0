From: Rusty Russell <rusty@rustcorp.com.au>
Subject: [PATCH] Use correct macros in raid code, not raw asm
Date: Fri, 29 Dec 2006 10:34:21 +1100
Message-ID: <1167348861.30506.46.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1753823AbWL1Xef@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Andi Kleen <ak@muc.de>, Andrew Morton <akpm@osdl.org>, Linus Torvalds <torvalds@osdl.org>, Ingo Molnar <mingo@elte.hu>, Neil Brown <neilb@suse.de>
Cc: lkml - Kernel Mailing List <linux-kernel@vger.kernel.org>, virtualization <virtualization@lists.osdl.org>
List-Id: virtualization@lists.linuxfoundation.org

This make sure it's paravirtualized correctly when CONFIG_PARAVIRT=y.

Signed-off-by: Rusty Russell <rusty@rustcorp.com.au>

diff -r 4ff048622391 drivers/md/raid6x86.h
--- a/drivers/md/raid6x86.h	Thu Dec 28 16:52:54 2006 +1100
+++ b/drivers/md/raid6x86.h	Fri Dec 29 10:09:38 2006 +1100
@@ -75,13 +75,14 @@ static inline unsigned long raid6_get_fp
 	unsigned long cr0;
 
 	preempt_disable();
-	asm volatile("mov %%cr0,%0 ; clts" : "=r" (cr0));
+	cr0 = read_cr0();
+	clts();
 	return cr0;
 }
 
 static inline void raid6_put_fpu(unsigned long cr0)
 {
-	asm volatile("mov %0,%%cr0" : : "r" (cr0));
+	write_cr0(cr0);
 	preempt_enable();
 }
 
