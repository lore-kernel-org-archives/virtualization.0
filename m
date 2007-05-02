From: WANG Cong <xiyou.wangcong@gmail.com>
Subject: Re: [RELEASE] Lguest for 2.6.21
Date: Thu, 3 May 2007 03:33:03 +0800
Message-ID: <20070502193303.GA1502__12151.2890131728$1178152569$gmane$org@localhost.localdomain>
References: <1178117028.19815.14.camel@localhost.localdomain>
Reply-To: WANG Cong <xiyou.wangcong@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <1178117028.19815.14.camel@localhost.localdomain>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Rusty Russell <rusty@rustcorp.com.au>
Cc: lkml - Kernel Mailing List <linux-kernel@vger.kernel.org>, virtualization <virtualization@lists.linux-foundation.org>
List-Id: virtualization@lists.linuxfoundation.org

Hi Rusty!

I found you forgot to check the return value of copy_from_user, and here is the fix for drivers/lguest/interrupts_and_traps.c.

Signed-off-by: WANG Cong <xiyou.wangcong@gmail.com>

---

--- linux-2.6.21-rc7-mm2/drivers/lguest/interrupts_and_traps.c.orig	2007-05-03 03:10:44.000000000 +0800
+++ linux-2.6.21-rc7-mm2/drivers/lguest/interrupts_and_traps.c	2007-05-03 03:11:42.000000000 +0800
@@ -75,7 +75,8 @@ void maybe_do_interrupt(struct lguest *l
 		set_bit(0, lg->irqs_pending);
 
 	/* Mask out any interrupts they have blocked. */
-	copy_from_user(&blk, lg->lguest_data->blocked_interrupts, sizeof(blk));
+	if (copy_from_user(&blk, lg->lguest_data->blocked_interrupts, sizeof(blk)))
+		return;
 	bitmap_andnot(blk, lg->irqs_pending, blk, LGUEST_IRQS);
 
 	irq = find_first_bit(blk, LGUEST_IRQS);
