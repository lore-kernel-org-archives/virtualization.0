From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [RFC 1/3] hvc_console: rework setup to replace irq functions
	with callbacks
Date: Tue, 14 Oct 2008 11:38:34 +1100
Message-ID: <1223944714.8157.300.camel@pasglop>
References: <200806031444.21945.borntraeger@de.ibm.com>
	 <200806031445.22561.borntraeger@de.ibm.com>
	 <1223875013.8157.230.camel@pasglop>
	 <200810130951.31733.borntraeger@de.ibm.com>
Reply-To: benh@kernel.crashing.org
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1761079AbYJNAmW@vger.kernel.org>
In-Reply-To: <200810130951.31733.borntraeger@de.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Christian Borntraeger <borntraeger@de.ibm.com>
Cc: Linux PPC devel <linuxppc-dev@ozlabs.org>, Virtualization Mailing List <virtualization@lists.osdl.org>, Jeremy Fitzhardinge <jeremy@goop.org>, Rusty Russell <rusty@rustcorp.com.au>, LKML <linux-kernel@vger.kernel.org>, Ingo Molnar <mingo@elte.hu>
List-Id: virtualization@lists.linuxfoundation.org


> Hmmm. 
> Can you try if this patch fixes the lockdep trace?

Yup, the patch fixes it, I'll commit it via the powerpc.git tree if you
don't have any objection.

Cheers,
Ben.

> This would be analog to
> commit b1b135c8d619cb2c7045d6ee4e48375882518bb5
> Author: Christian Borntraeger <borntraeger@de.ibm.com>
> Date:   Thu Aug 7 09:18:34 2008 +0200
> 
>     fix spinlock recursion in hvc_console
> 
>     commit 611e097d7707741a336a0677d9d69bec40f29f3d
>     Author: Christian Borntraeger <borntraeger@de.ibm.com>
>     hvc_console: rework setup to replace irq functions with callbacks
>     introduced a spinlock recursion problem.
> 
> 
> Signed-off-by: Christian Borntraeger<borntraeger@de.ibm.com>
> ---
>  drivers/char/hvc_console.c |   10 +++++-----
>  1 file changed, 5 insertions(+), 5 deletions(-)
> 
> Index: linux-2.6/drivers/char/hvc_console.c
> ===================================================================
> --- linux-2.6.orig/drivers/char/hvc_console.c
> +++ linux-2.6/drivers/char/hvc_console.c
> @@ -367,13 +367,13 @@ static void hvc_close(struct tty_struct 
>  	spin_lock_irqsave(&hp->lock, flags);
>  
>  	if (--hp->count == 0) {
> -		if (hp->ops->notifier_del)
> -			hp->ops->notifier_del(hp, hp->data);
> -
>  		/* We are done with the tty pointer now. */
>  		hp->tty = NULL;
>  		spin_unlock_irqrestore(&hp->lock, flags);
>  
> +		if (hp->ops->notifier_del)
> +			hp->ops->notifier_del(hp, hp->data);
> +
>  		/*
>  		 * Chain calls chars_in_buffer() and returns immediately if
>  		 * there is no buffered data otherwise sleeps on a wait queue
> @@ -416,11 +416,11 @@ static void hvc_hangup(struct tty_struct
>  	hp->n_outbuf = 0;
>  	hp->tty = NULL;
>  
> +	spin_unlock_irqrestore(&hp->lock, flags);
> +
>  	if (hp->ops->notifier_del)
>  			hp->ops->notifier_del(hp, hp->data);
>  
> -	spin_unlock_irqrestore(&hp->lock, flags);
> -
>  	while(temp_open_count) {
>  		--temp_open_count;
>  		kref_put(&hp->kref, destroy_hvc_struct);
