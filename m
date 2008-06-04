From: Christian Borntraeger <borntraeger@de.ibm.com>
Subject: Re: [RFC 1/3] hvc_console: rework setup to replace irq functions with
	callbacks
Date: Wed, 4 Jun 2008 13:15:42 +0200
Message-ID: <200806041315.42593.borntraeger@de.ibm.com>
References: <200806031444.21945.borntraeger@de.ibm.com>
	<200806031445.22561.borntraeger@de.ibm.com>
	<200806041013.40692.rusty@rustcorp.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linuxppc-dev-bounces+glppd-linuxppc64-dev=m.gmane.org@ozlabs.org>
In-Reply-To: <200806041013.40692.rusty@rustcorp.com.au>
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
To: Rusty Russell <rusty@rustcorp.com.au>
Cc: Linux PPC devel <linuxppc-dev@ozlabs.org>, Jeremy Fitzhardinge <jeremy@goop.org>, LKML <linux-kernel@vger.kernel.org>, Virtualization Mailing List <virtualization@lists.osdl.org>
List-Id: virtualization@lists.linuxfoundation.org

Am Mittwoch, 4. Juni 2008 schrieb Rusty Russell:
> Two questions.  Is it possible to make the timer backoff a third kind of 
> notifier?

I can try. The timer handling code is sprinkled a bit in hvc_console but it 
should be possible.

> And is it possible to make the dependency static, rather than  
> dynamic, or does someone need two options at runtime?

Not sure. Some drivers pass get the irq number from another component. If the 
number is 0, the console is poll driven, otherwise irq driven.
