From: Rusty Russell <rusty@rustcorp.com.au>
Subject: Re: [PATCH 1/5] lguest host feedback tidyups
Date: Mon, 14 May 2007 15:38:04 +1000
Message-ID: <1179121084.23513.186.camel__876.736132386391$1179121149$gmane$org@localhost.localdomain>
References: <1178846246.23513.21.camel@localhost.localdomain>
	<1178846354.23513.23.camel@localhost.localdomain>
	<20070513183934.GY4095@ftp.linux.org.uk>
	<1179107062.23513.152.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <1179107062.23513.152.camel@localhost.localdomain>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Al Viro <viro@ftp.linux.org.uk>
Cc: Andrew Morton <akpm@linux-foundation.org>, Sam Ravnborg <sam@ravnborg.org>, lkml - Kernel Mailing List <linux-kernel@vger.kernel.org>, virtualization <virtualization@lists.linux-foundation.org>
List-Id: virtualization@lists.linuxfoundation.org

On Mon, 2007-05-14 at 11:44 +1000, Rusty Russell wrote:
> On Sun, 2007-05-13 at 19:39 +0100, Al Viro wrote:
> > >  static void push_guest_stack(struct lguest *lg, u32 __user **gstack, u32 val)
> > >  {
> > > -	lgwrite_u32(lg, (u32)--(*gstack), val);
> > > +	lgwrite_u32(lg, (__force u32)--(*gstack), val);
> > >  }
> > 
> > Now, _that_ is just plain dumb.  Why not declare that lgwrite_u32() as taking
> > u32 __user * as argument and kill the casts?
> 
> Last I tried, this turns out to create even more casts.

But after thinking harder... changing the gstack type gets rid of three
casts, including that one.  Thanks!

How's this?
Rusty.
== 
Reduce number of casts in set_guest_interrupt().

Al Viro pointed out the ugly cast in push_lguest_stack(); as this is
only called from set_guest_interrupt() which casts the arg in the
first place, let's stick with unsigned long the whole way through.

Signed-off-by: Rusty Russell <rusty@rustcorp.com.au>

diff -r 16e417365c64 drivers/lguest/interrupts_and_traps.c
--- a/drivers/lguest/interrupts_and_traps.c	Mon May 14 15:05:48 2007 +1000
+++ b/drivers/lguest/interrupts_and_traps.c	Mon May 14 15:22:38 2007 +1000
@@ -16,24 +16,25 @@ static int idt_present(u32 lo, u32 hi)
 	return (hi & 0x8000);
 }
 
-static void push_guest_stack(struct lguest *lg, u32 __user **gstack, u32 val)
-{
-	lgwrite_u32(lg, (unsigned long)--(*gstack), val);
+static void push_guest_stack(struct lguest *lg, unsigned long *gstack, u32 val)
+{
+	*gstack -= 4;
+	lgwrite_u32(lg, *gstack, val);
 }
 
 static void set_guest_interrupt(struct lguest *lg, u32 lo, u32 hi, int has_err)
 {
-	u32 __user *gstack;
+	unsigned long gstack;
 	u32 eflags, ss, irq_enable;
 
 	/* If they want a ring change, we use new stack and push old ss/esp */
 	if ((lg->regs->ss&0x3) != GUEST_PL) {
-		gstack = (u32 __user *)guest_pa(lg, lg->esp1);
+		gstack = guest_pa(lg, lg->esp1);
 		ss = lg->ss1;
 		push_guest_stack(lg, &gstack, lg->regs->ss);
 		push_guest_stack(lg, &gstack, lg->regs->esp);
 	} else {
-		gstack = (u32 __user *)guest_pa(lg, lg->regs->esp);
+		gstack = guest_pa(lg, lg->regs->esp);
 		ss = lg->regs->ss;
 	}
 
@@ -53,7 +54,7 @@ static void set_guest_interrupt(struct l
 
 	/* Change the real stack so switcher returns to trap handler */
 	lg->regs->ss = ss;
-	lg->regs->esp = (unsigned long)gstack + lg->page_offset;
+	lg->regs->esp = gstack + lg->page_offset;
 	lg->regs->cs = (__KERNEL_CS|GUEST_PL);
 	lg->regs->eip = idt_address(lo, hi);
