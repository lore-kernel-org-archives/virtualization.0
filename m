From: Christian Borntraeger <borntraeger@de.ibm.com>
Subject: Re: [RFC 1/3] hvc_console: rework setup to replace irq functions with
	callbacks
Date: Mon, 13 Oct 2008 10:47:12 +0200
Message-ID: <200810131047.12748.borntraeger@de.ibm.com>
References: <200806031444.21945.borntraeger@de.ibm.com>
	<200810130951.31733.borntraeger@de.ibm.com>
	<1223886972.8157.241.camel@pasglop>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linuxppc-dev-bounces+glppd-linuxppc64-dev=m.gmane.org@ozlabs.org>
In-Reply-To: <1223886972.8157.241.camel@pasglop>
Content-Disposition: inline
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>
Sender: linuxppc-dev-bounces+glppd-linuxppc64-dev=m.gmane.org@ozlabs.org
Errors-To: linuxppc-dev-bounces+glppd-linuxppc64-dev=m.gmane.org@ozlabs.org
To: benh@kernel.crashing.org
Cc: Jeremy Fitzhardinge <jeremy@goop.org>, Virtualization Mailing List <virtualization@lists.osdl.org>, Rusty Russell <rusty@rustcorp.com.au>, LKML <linux-kernel@vger.kernel.org>, Linux PPC devel <linuxppc-dev@ozlabs.org>, Ingo Molnar <mingo@elte.hu>
List-Id: virtualization@lists.linuxfoundation.org

Am Montag, 13. Oktober 2008 schrieb Benjamin Herrenschmidt:
> 
> >  	if (--hp->count == 0) {
> > -		if (hp->ops->notifier_del)
> > -			hp->ops->notifier_del(hp, hp->data);
> > -
> >  		/* We are done with the tty pointer now. */
> >  		hp->tty = NULL;
> >  		spin_unlock_irqrestore(&hp->lock, flags);
> >  
> > +		if (hp->ops->notifier_del)
> > +			hp->ops->notifier_del(hp, hp->data);
> > +
> 
> I will try. Of course the risk here is that the interrupt happens
> after we set hp->tty to NULL, so we probably need to check within the
> interrupt handler for a NULL tty. I haven't checked if that's the case
> (I'm not in front of the code right now).

Even the old code (without my patch) was setting hp->tty to NULL before doing 
the irq_free, so that should be ok.

Christian
