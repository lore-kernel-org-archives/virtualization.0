From: Rusty Russell <rusty@rustcorp.com.au>
Subject: Re: [PATCH 1/5] lguest host feedback tidyups
Date: Mon, 14 May 2007 11:44:22 +1000
Message-ID: <1179107062.23513.152.camel__20721.6027462438$1179107130$gmane$org@localhost.localdomain>
References: <1178846246.23513.21.camel@localhost.localdomain>
	<1178846354.23513.23.camel@localhost.localdomain>
	<20070513183934.GY4095@ftp.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20070513183934.GY4095@ftp.linux.org.uk>
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

On Sun, 2007-05-13 at 19:39 +0100, Al Viro wrote:
> On Fri, May 11, 2007 at 11:19:14AM +1000, Rusty Russell wrote:
> > @@ -218,7 +218,7 @@ u32 lgread_u32(struct lguest *lg, u32 ad
> >  
> >  	/* Don't let them access lguest binary */
> >  	if (!lguest_address_ok(lg, addr, sizeof(val))
> > -	    || get_user(val, (u32 __user *)addr) != 0)
> > +	    || get_user(val, (__force u32 __user *)addr) != 0)
> >  		kill_guest(lg, "bad read address %u", addr);
> >  	return val;
> 
> *Ahem*
> 
> What kind of address are we really getting there?  IOW, where does it
> ultimately come from?

Hi Al,

	This patch has been superseded.  But to clarify, the address generally
comes from a guest register.  My confusion came from sparse warnings on
the above code like the following:

	warning: cast removes address space of expression

I inserted __force, but it's actually caused by the "addr" being a
"u32": if it's an "unsigned long" sparse doesn't warn.  This is a win
anyway: although the code is i386-specific at the moment, that will
change.  I prefer to use u32 rather than unsigned long to declare
registers (eg. if I ever wanted to support 32 bit guests on a 64 bit
host), but that's not even a consideration at this stage.

> >  	lock_cpu_hotplug();
> >  	if (cpu_has_pge) { /* We have a broader idea of "global". */
> >  		cpu_had_pge = 1;
> > -		on_each_cpu(adjust_pge, 0, 0, 1);
> > +		on_each_cpu(adjust_pge, (void *)0, 0, 1);
> 
> That's called NULL...

	Yes, but this is clearer.  Here's adjust_pge:

static void adjust_pge(void *on)
{
	if (on)
		write_cr4(read_cr4() | X86_CR4_PGE);
	else
		write_cr4(read_cr4() & ~X86_CR4_PGE);
}

And here's the two calls to it:

		on_each_cpu(adjust_pge, (void *)0, 0, 1);
...
		on_each_cpu(adjust_pge, (void *)1, 0, 1);

> >  	case LHCALL_LOAD_TLS:
> > -		guest_load_tls(lg, (struct desc_struct __user*)regs->edx);
> > +		guest_load_tls(lg,
> > +			       (__force struct desc_struct __user*)regs->edx);
> 
> Umm...  That's borderline OK, but...

Yeah, gone in replacement patch.

> >  static void push_guest_stack(struct lguest *lg, u32 __user **gstack, u32 val)
> >  {
> > -	lgwrite_u32(lg, (u32)--(*gstack), val);
> > +	lgwrite_u32(lg, (__force u32)--(*gstack), val);
> >  }
> 
> Now, _that_ is just plain dumb.  Why not declare that lgwrite_u32() as taking
> u32 __user * as argument and kill the casts?

Last I tried, this turns out to create even more casts.

> > -	lg->regs->esp = (u32)gstack + lg->page_offset;
> > +	lg->regs->esp = (__force u32)gstack + lg->page_offset;
> 
> Yuck.  Cast to unsigned long (or uintptr_t), please.  In this case it is
> legitimate.

Indeed, replacement patch uses unsigned long.

Thanks,
Rusty.
