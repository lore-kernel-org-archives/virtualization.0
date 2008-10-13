From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [RFC 1/3] hvc_console: rework setup to replace irq functions
	with callbacks
Date: Mon, 13 Oct 2008 20:52:59 +1100
Message-ID: <1223891579.8157.251.camel@pasglop>
References: <200806031444.21945.borntraeger@de.ibm.com>
	<200810130951.31733.borntraeger@de.ibm.com>
	<1223886972.8157.241.camel@pasglop>
	<200810131047.12748.borntraeger@de.ibm.com>
Reply-To: benh@kernel.crashing.org
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linuxppc-dev-bounces+glppd-linuxppc64-dev=m.gmane.org@ozlabs.org>
In-Reply-To: <200810131047.12748.borntraeger@de.ibm.com>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>
Sender: linuxppc-dev-bounces+glppd-linuxppc64-dev=m.gmane.org@ozlabs.org
Errors-To: linuxppc-dev-bounces+glppd-linuxppc64-dev=m.gmane.org@ozlabs.org
To: Christian Borntraeger <borntraeger@de.ibm.com>
Cc: Jeremy Fitzhardinge <jeremy@goop.org>, Virtualization Mailing List <virtualization@lists.osdl.org>, Rusty Russell <rusty@rustcorp.com.au>, LKML <linux-kernel@vger.kernel.org>, Linux PPC devel <linuxppc-dev@ozlabs.org>, Ingo Molnar <mingo@elte.hu>
List-Id: virtualization@lists.linuxfoundation.org

On Mon, 2008-10-13 at 10:47 +0200, Christian Borntraeger wrote:
> > I will try. Of course the risk here is that the interrupt happens
> > after we set hp->tty to NULL, so we probably need to check within the
> > interrupt handler for a NULL tty. I haven't checked if that's the case
> > (I'm not in front of the code right now).
> 
> Even the old code (without my patch) was setting hp->tty to NULL before doing 
> the irq_free, so that should be ok.

Yup, just checked, it should be allright as long as it's cleared with
the spinlock held, which seems to be the case with your patch. I'll test
your fixup patch tomorrow to see if it clears the lockdep error.

Thanks !

Ben.
