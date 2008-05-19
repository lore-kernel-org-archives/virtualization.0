From: Avi Kivity <avi@qumranet.com>
Subject: Re: [PATCH] virtio_net: free transmit skbs in a timer
Date: Mon, 19 May 2008 16:26:15 +0300
Message-ID: <48317FF7.1020707@qumranet.com>
References: <1209565906-9019-1-git-send-email-markmc@redhat.com>
	<200805191152.28409.rusty@rustcorp.com.au>
	<483155D4.2090700@qumranet.com>
	<200805192221.52072.rusty@rustcorp.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <200805192221.52072.rusty@rustcorp.com.au>
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
Cc: Anthony Liguori <aliguori@us.ibm.com>, linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

Rusty Russell wrote:
>>>
>>> Well, we do have such a thing, in the ring suppression flags.
>>>       
>> Can you point me at this?
>>     
>
> Ah, sorry, I misunderstood.  No, we don't have a threshold like this, we
> have an all-or-nothing flag in each direction.
>
>   

Please point me anyway?

> We have the ability to add new fields to the rings.  I've put it on my
> TODO to benchmark what this does.  It may or may not help.  In this case,
> notification when there are no more packets in xmit ring would be
> sufficient.  We already kick the host when we fill a ring even if
> it says it doesn't need it, perhaps this would be symmetry.
>   

Notification on ring full is too late with smp.  You need to warn the 
other side in advance.

The reason I'm interested in adjustable thresholds is that you can then 
to tx mitigation without (usually) suffering the worst-case latency when 
you aren't streaming or streaming slower than what you tuned for.

>   
>>>   Note that DaveM
>>> is talking about moving network tx queue into the net drivers themselves,
>>> which will make them much more efficient (ie. drain entire queue before
>>> kick), which may again change the balance of what the Right Thing is.
>>>       
>> That depends on whether Linux knows whether more packets are coming.
>>     
>
> The current problem is that hard_start_xmit gets called with a packet, and 
> has no idea if there are more in the tx queue.  By having the driver control
> the queue, it can at least tell that.
>   

Yes, definitely an improvement, esp. for sendfile().

> The question remains whether this will be sufficient for tx mitigation.  A
> program may be about to write more to the socket, and we can't know that.
> But it can hardly hurt.
>
>   

Right.

-- 
error compiling committee.c: too many arguments to function
