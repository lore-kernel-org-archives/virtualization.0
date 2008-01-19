From: Tejun Heo <htejun@gmail.com>
Subject: Re: [PATCH 3/3] Makes lguest's irq handler typesafe
Date: Sat, 19 Jan 2008 10:40:37 +0900
Message-ID: <47915515.1020905__33294.04627807$1200706949$gmane$org@gmail.com>
References: <200801190722.26154.rusty@rustcorp.com.au>
	<200801190727.36567.rusty@rustcorp.com.au>
	<47913261.5000708@gmail.com>
	<200801191228.30363.rusty@rustcorp.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <200801191228.30363.rusty@rustcorp.com.au>
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
Cc: linux-pcmcia@lists.infradead.org, linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org, Andrew Morton <akpm@linux-foundation.org>, Ash Willis <ashwillis@programmer.net>, Jeff Garzik <jgarzik@pobox.com>
List-Id: virtualization@lists.linuxfoundation.org

Hello, Rusty.

Rusty Russell wrote:
> On Saturday 19 January 2008 10:12:33 Tejun Heo wrote:
>> Type safety is good but I doubt this would be worth the complexity.  It
>> has some benefits but there's much larger benefit in keeping things in
>> straight C.  People know that functions take fixed types and are also
>> familiar with the convention of passing void * for callback arguments.
>> IMHO, staying in line with those common knowledges easily trumps having
>> type checking on interrupt handler.
> 
> I sympathise with this argument, but I think just because people are familiar 
> with existing hacks shouldn't prevent improvement.  I think the resulting 
> code is clearer and more readable.
> 
> Even in the implementation, the tricky part is the check_either_type() macro: 
> the rest is straight-forward.

The change is a small one and both the cost and benefit aren't big.

>> Also, how often do we see a bug where things go wrong because interrupt
>> handler is given the wrong type of argument?  Even when such bug
>> happens, I doubt it can escape the developer's workstation if he/she is
>> paying any attention to testing.
> 
> I agree this one is unlikely.  But I am trying to spread type-safety more 
> widely (see previous kthread patches).
> 
> I like changing the kernel to make life simpler for developers.  We don't do 
> enough of it.

I'm in full agreement here but the cost / benefit equation doesn't seem
quite right to me.  If we're gonna convert all callbacks to take native
pointers, I'm fine with the irq handler part too.  If not, it just adds
confusion which is much worse than any benefit it can bring, so I think
the question is "do we want to change all callbacks to take native
pointer type instead of void pointer?".

-- 
tejun
