From: Avi Kivity <avi@qumranet.com>
Subject: Re: [PATCH] virtio_net: free transmit skbs in a timer
Date: Wed, 14 May 2008 11:59:59 +0300
Message-ID: <482AAA0F.2020607__15761.3794821829$1210755789$gmane$org@qumranet.com>
References: <1209565906-9019-1-git-send-email-markmc@redhat.com>
	<1210624663.14409.20.camel@muff> <48294776.3010504@qumranet.com>
	<200805141607.26306.rusty@rustcorp.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <200805141607.26306.rusty@rustcorp.com.au>
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
>> Sorry to barge in late, but IMO the timer should be on the host, which
>> is cheaper than on the guest (well, a 100ms timer is likely zero cost,
>> but  I still don't like it).
>>
>> the host should fire a tx completion interrupt whenever the completion
>> queue has "enough" entries, where we can define "enough" now as the
>> halfway mark or a timer expiry, whichever comes earlier.
>>
>> We can later improve "enough" to be "just enough so the timer never
>> triggers" and adjust it dynamically.  It probably doesn't matter for
>> Linux, but I don't want to punish guests that can do true async
>> networking and depend on timely completion notification.
>>     
>
> This implies that we should not be supressing notifications in the guest at 
> all (unless we're sure there are more packets to come, which currently we 
> never are: that needs new net infrastructure).
>   

We don't have to be sure, just reasonably confident.  If we see a stream 
of packets, we open the window, but set a timer in case we're wrong.  
The expectation is that the timer will only fire when tx rate drops (or 
tx stops completely).

> But that means we'd get a notification on every xmit at the moment.  
> Benchmarks anyone?
>   

Notification on every xmit will surely kill performance.  I'm trying to 
get batching to work but also good latency when the link is not saturated.

-- 
error compiling committee.c: too many arguments to function
