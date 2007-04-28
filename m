From: James Bottomley <James.Bottomley@HansenPartnership.com>
Subject: Re: The virtuailization patches break Voyager.
Date: Sat, 28 Apr 2007 11:05:15 -0500
Message-ID: <1177776315.3688.43.camel@mulgrave.il.steeleye.com>
References: <m1mz0tgfxa.fsf@ebiederm.dsl.xmission.com>
	<4632FD3E.401@goop.org> <m1zm4sgaqt.fsf@ebiederm.dsl.xmission.com>
	<200704281134.53160.ak@suse.de>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <200704281134.53160.ak@suse.de>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Andi Kleen <ak@suse.de>
Cc: virtualization@lists.osdl.org, "Eric W. Biederman" <ebiederm@xmission.com>, "H. Peter Anvin" <hpa@zytor.com>, Andrew Morton <akpm@linux-foundation.org>
List-Id: virtualization@lists.linuxfoundation.org

On Sat, 2007-04-28 at 11:34 +0200, Andi Kleen wrote:
> > 
> > The sane pattern is and seems to has always been.
> > 
> > arch_function()
> > {
> >         platform_ops.platform_function();
> > }
> 
> Yes agreed. We'll slowly move there. Patches to accelerate it are
> welcome (for post .22) 
> 
> But you're flaming the wrong person for this really. Jeremy and other
> paravirt implementors have  done a lot of work of moving things into this 
> direction.
> 
> > At the same time I find it very distressing how many functions named
> > native_xxx we are accumulating.  Especially when all native refers is
> > to the default i386 subarch and not to anything particularly native.
> > Just one particular way something was implemented.
> 
> How else would you name and/or implement that?
> 
> > The fact that 2 level or 3 level page tables can't be selected at
> > runtime seems to be a failing to think of themselves as a generic 
> > a subarch mechanism.  I can't fault you to much for that one as
> > that is a little off the beaten path.
> 
> That would really require generic mm changes to do properly. I know
> PA-RISC does it without that, but that wouldn't fly on x86 I think
> because PAE and non PAE are more different there.

It's getting embarrassing to find myself responsible for practically
everything in this debate people regard as strange ...

I did this on PA-RISC to save code and indirect lookups in
interruptions.  It's not exactly runtime switchable.  What we do is make
32 bit processes use the two level structure and 64 bit ones the 3 level
structure.  Since almost every user level process is 32 bit (because the
instruction set is the same, like ppc and sparc, but not x86_64) it
really made no sense to waste the page table entries and the lookup
time.

What I did was to alter the page table layout so the first 4GB use a
2-level scheme and anything after that uses 3 levels, so the requested
virtual address does the switch. (it's modelled on the way inode lookups
are done ... you don't begin in the indirect table, you begin in the
direct one).

However, I think we can only do this because we have a software TLB
refill interruption not a HW page table walker.

James
