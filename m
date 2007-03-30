From: Rusty Russell <rusty@rustcorp.com.au>
Subject: Re: [LGUEST] updated nohz/hrtimer WIP patches (v04)
Date: Fri, 30 Mar 2007 12:08:21 +1000
Message-ID: <1175220502.12230.355.camel@localhost.localdomain>
References: <Line.LNX.4.64.0703261148040.13138@d.namei>
	<Line.LNX.4.64.0703291151270.12641@d.namei>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <Line.LNX.4.64.0703291151270.12641@d.namei>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: James Morris <jmorris@namei.org>
Cc: virtualization@lists.osdl.org
List-Id: virtualization@lists.linuxfoundation.org

On Thu, 2007-03-29 at 11:53 -0400, James Morris wrote:
> At http://namei.org/misc/lguest/patches/time/v04/
> =

> Just a resync to the latest upstream lguest patch queue, after some fun =

> with bare metal bugs and assorted churn.

Hi James!

	Thanks for the patch!  Nothing major to add, just some questions
mainly...

> diff --git a/drivers/lguest/core.c b/drivers/lguest/core.c
> index d8f136a..344b455 100644
> --- a/drivers/lguest/core.c
> +++ b/drivers/lguest/core.c
> @@ -393,6 +393,23 @@ int find_free_guest(void)
>  	return -1;
>  }
>  =

> +void guest_clockevent(struct lguest *lg, const ktime_t __user *u)

interrupts_and_traps.c might be a better place for this?  Similarly the
code currently in lguest_user.c, which is mainly for code dealing
with /dev/lguest.

> +	case LHCALL_CLOCKEVENT:
> +		guest_clockevent(lg, (ktime_t __user *)regs->edx);
> +		break;

Perhaps LHCALL_SET_CLOCKEVENT is a better name? Or were you thinking of
extending it?

> --- a/drivers/lguest/lguest.c
> +++ b/drivers/lguest/lguest.c
> @@ -62,6 +64,7 @@ #include <asm/e820.h>
>  #include <asm/pda.h>
>  #include <asm/asm-offsets.h>
>  #include <asm/mce.h>
> +#include "lg.h"

Hmm, this implies we've knotted the headers somehow.  "lg.h" is supposed
to be the internal header for lg.ko.  Perhaps something needs to be
moved to linux/lguest.h?

Thanks!
Rusty.
