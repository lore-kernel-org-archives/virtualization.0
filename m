From: Jeff Garzik <jgarzik@pobox.com>
Subject: Re: [PATCH 2/3] Make IRQ handlers typesafe.
Date: Fri, 18 Jan 2008 15:43:59 -0500
Message-ID: <47910F8F.3040107__21175.1601579182$1200694224$gmane$org@pobox.com>
References: <200801190722.26154.rusty@rustcorp.com.au>
	<200801190725.24271.rusty@rustcorp.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <200801190725.24271.rusty@rustcorp.com.au>
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
Cc: Tejun Heo <htejun@gmail.com>, linux-pcmcia@lists.infradead.org, linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org, Andrew Morton <akpm@linux-foundation.org>, Ash Willis <ashwillis@programmer.net>
List-Id: virtualization@lists.linuxfoundation.org

Rusty Russell wrote:
> This patch lets interrupt handler functions have their natural type
> (ie. exactly match the data pointer type); for transition it allows
> the old irq_handler_t type as well.
> 
> To do this it uses a gcc extension, cast-to-union, which allows a type
> to be cast to any type within the union.  When used in a wrapper
> macro, it's a simple way of allowing one of several types.
> 
> (Some drivers now need to be cleaned up to compile, previous patch).
> 
> Signed-off-by: Rusty Russell <rusty@rustcorp.com.au>
> ---
>  include/linux/interrupt.h |   17 +++++++++++++++--
>  include/linux/kernel.h    |    7 +++++++
>  kernel/irq/devres.c       |   10 +++++-----
>  kernel/irq/manage.c       |    6 +++---
>  4 files changed, 30 insertions(+), 10 deletions(-)
> 
> diff -r 0fe1a980708b include/linux/interrupt.h
> --- a/include/linux/interrupt.h	Thu Jan 17 14:48:56 2008 +1100
> +++ b/include/linux/interrupt.h	Thu Jan 17 15:42:01 2008 +1100
> @@ -69,13 +69,26 @@ struct irqaction {
>  };
>  
>  extern irqreturn_t no_action(int cpl, void *dev_id);
> -extern int __must_check request_irq(unsigned int, irq_handler_t handler,
> +
> +/* Typesafe version of request_irq.  Also takes old-style void * handlers. */
> +#define request_irq(irq, handler, flags, name, dev_id)			\
> +	__request_irq((irq),						\
> +		      check_either_type((handler), irq_handler_t,	\
> +					int (*)(int, typeof(dev_id))),	\
> +		      (flags), (name), (dev_id))
> +
> +extern int __must_check __request_irq(unsigned int, irq_handler_t handler,
>  		       unsigned long, const char *, void *);
>  extern void free_irq(unsigned int, void *);
>  
>  struct device;
>  
> -extern int __must_check devm_request_irq(struct device *dev, unsigned int irq,
> +#define devm_request_irq(dev, irq, handler, flags, name, dev_id)	\
> +	__devm_request_irq((dev), (irq),				\
> +		      check_either_type((handler), irq_handler_t,	\
> +					int (*)(int, typeof(dev_id))),	\
> +		      (flags), (name), (dev_id))
> +extern int __must_check __devm_request_irq(struct device *dev, unsigned int irq,
>  			    irq_handler_t handler, unsigned long irqflags,
>  			    const char *devname, void *dev_id);

This is ugly and unnecessary.

Anything that does not use irq_handler_t is broken and should be fixed 
(as noted in last email, I think I've covered all this driver work already)

And if by definition everything uses irq_handler_t, there is no need for 
any of this "check_either_type" silliness.

	Jeff
