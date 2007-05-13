From: Al Viro <viro@ftp.linux.org.uk>
Subject: Re: [PATCH 1/5] lguest host feedback tidyups
Date: Sun, 13 May 2007 19:39:34 +0100
Message-ID: <20070513183934.GY4095__49068.9690610909$1179081648$gmane$org@ftp.linux.org.uk>
References: <1178846246.23513.21.camel@localhost.localdomain>
	<1178846354.23513.23.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <1178846354.23513.23.camel@localhost.localdomain>
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
Cc: Andrew Morton <akpm@linux-foundation.org>, Sam Ravnborg <sam@ravnborg.org>, lkml - Kernel Mailing List <linux-kernel@vger.kernel.org>, virtualization <virtualization@lists.linux-foundation.org>
List-Id: virtualization@lists.linuxfoundation.org

On Fri, May 11, 2007 at 11:19:14AM +1000, Rusty Russell wrote:
> @@ -218,7 +218,7 @@ u32 lgread_u32(struct lguest *lg, u32 ad
>  
>  	/* Don't let them access lguest binary */
>  	if (!lguest_address_ok(lg, addr, sizeof(val))
> -	    || get_user(val, (u32 __user *)addr) != 0)
> +	    || get_user(val, (__force u32 __user *)addr) != 0)
>  		kill_guest(lg, "bad read address %u", addr);
>  	return val;

*Ahem*

What kind of address are we really getting there?  IOW, where does it
ultimately come from?

>  	lock_cpu_hotplug();
>  	if (cpu_has_pge) { /* We have a broader idea of "global". */
>  		cpu_had_pge = 1;
> -		on_each_cpu(adjust_pge, 0, 0, 1);
> +		on_each_cpu(adjust_pge, (void *)0, 0, 1);

That's called NULL...

>  	case LHCALL_LOAD_TLS:
> -		guest_load_tls(lg, (struct desc_struct __user*)regs->edx);
> +		guest_load_tls(lg,
> +			       (__force struct desc_struct __user*)regs->edx);

Umm...  That's borderline OK, but...

>  static void push_guest_stack(struct lguest *lg, u32 __user **gstack, u32 val)
>  {
> -	lgwrite_u32(lg, (u32)--(*gstack), val);
> +	lgwrite_u32(lg, (__force u32)--(*gstack), val);
>  }

Now, _that_ is just plain dumb.  Why not declare that lgwrite_u32() as taking
u32 __user * as argument and kill the casts?

> -	lg->regs->esp = (u32)gstack + lg->page_offset;
> +	lg->regs->esp = (__force u32)gstack + lg->page_offset;

Yuck.  Cast to unsigned long (or uintptr_t), please.  In this case it is
legitimate.
