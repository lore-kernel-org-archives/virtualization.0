From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [RFC 1/3] hvc_console: rework setup to replace irq functions
	with callbacks
Date: Mon, 13 Oct 2008 19:36:12 +1100
Message-ID: <1223886972.8157.241.camel@pasglop>
References: <200806031444.21945.borntraeger@de.ibm.com>
	 <200806031445.22561.borntraeger@de.ibm.com>
	 <1223875013.8157.230.camel@pasglop>
	 <200810130951.31733.borntraeger@de.ibm.com>
Reply-To: benh@kernel.crashing.org
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1757588AbYJMIoS@vger.kernel.org>
In-Reply-To: <200810130951.31733.borntraeger@de.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Christian Borntraeger <borntraeger@de.ibm.com>
Cc: Linux PPC devel <linuxppc-dev@ozlabs.org>, Virtualization Mailing List <virtualization@lists.osdl.org>, Jeremy Fitzhardinge <jeremy@goop.org>, Rusty Russell <rusty@rustcorp.com.au>, LKML <linux-kernel@vger.kernel.org>, Ingo Molnar <mingo@elte.hu>
List-Id: virtualization@lists.linuxfoundation.org


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

I will try. Of course the risk here is that the interrupt happens
after we set hp->tty to NULL, so we probably need to check within the
interrupt handler for a NULL tty. I haven't checked if that's the case
(I'm not in front of the code right now).

Ben.
