From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [RFC 1/3] hvc_console: rework setup to replace irq functions
	with callbacks (not word wrapped)
Date: Wed, 04 Jun 2008 19:06:42 +1000
Message-ID: <1212570402.9496.72.camel@pasglop>
References: <200806031444.21945.borntraeger@de.ibm.com>
	<200806031449.14385.borntraeger@de.ibm.com>
Reply-To: benh@kernel.crashing.org
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linuxppc-dev-bounces+glppd-linuxppc64-dev=m.gmane.org@ozlabs.org>
In-Reply-To: <200806031449.14385.borntraeger@de.ibm.com>
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
Cc: Linux PPC devel <linuxppc-dev@ozlabs.org>, Jeremy Fitzhardinge <jeremy@goop.org>, Rusty Russell <rusty@rustcorp.com.au>, LKML <linux-kernel@vger.kernel.org>, Virtualization Mailing List <virtualization@lists.osdl.org>
List-Id: virtualization@lists.linuxfoundation.org

On Tue, 2008-06-03 at 14:49 +0200, Christian Borntraeger wrote:
> This patch tries to change hvc_console to not use request_irq/free_irq if
> the backend does not use irqs. This allows virtio_console to use hvc_console
> without having a linker reference to request_irq/free_irq.
> 
> The irq specific code is moved to hvc_irq.c and selected by the drivers that
> use irqs (System p, System i, XEN).
> 
> I replaced "irq" with the opaque name "data". The request_irq and free_irq
> calls are replaced with notifier_add and notifier_del. I have also changed
> the code a bit to call the notifier_add and notifier_del inside the spinlock
> area as the callbacks are found via hp->ops.
> 
> Feedback is appreciated.

I haven't looked at the patch proper but I agree with the basic
premises. We routinely use hvc_console for things that don't have an
irq. In fact, David even did a backend hooking up to udbg which is
useful when bringing up weird stuffs :-)

Cheers,
Ben.
