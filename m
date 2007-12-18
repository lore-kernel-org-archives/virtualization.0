From: Avi Kivity <avi@qumranet.com>
Subject: Re: [kvm-devel] [virtio-net][PATCH] Don't arm tx hrtimer with
 a	constant 500us each transmit
Date: Tue, 18 Dec 2007 07:30:08 +0200
Message-ID: <47675AE0.8050808__38595.1876211495$1197956233$gmane$org@qumranet.com>
References: <475FD9E8.1060109@qumranet.com>
	<200712181101.14916.rusty@rustcorp.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <200712181101.14916.rusty@rustcorp.com.au>
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
Cc: kvm-devel <kvm-devel@lists.sourceforge.net>, netdev@vger.kernel.org, dor.laor@qumranet.com, virtualization <virtualization@lists.linux-foundation.org>
List-Id: virtualization@lists.linuxfoundation.org

Rusty Russell wrote:
> On Wednesday 12 December 2007 23:54:00 Dor Laor wrote:
>   
>> commit 763769621d271d92204ed27552d75448587c1ac0
>> Author: Dor Laor <dor.laor@qumranet.com>
>> Date:   Wed Dec 12 14:52:00 2007 +0200
>>
>>     [virtio-net][PATCH] Don't arm tx hrtimer with a constant 50us each
>> transmit
>>
>>     The current start_xmit sets 500us hrtimer to kick the host.
>>     The problem is that if another xmit happens before the timer was
>> fired then
>>     the first xmit will have to wait additional 500us.
>>     This patch does not re-arm the timer if there is existing one.
>>     This will shorten the latency for tx.
>>     
>
> Hi Dor!
>
>     Yes, I pondered this when I wrote the code.  On the one hand, it's a 
> low-probability pathological corner case, on the other, your patch reduces 
> the number of timer reprograms in the normal case.
>   

One thing that came up in our discussions is to let the host do the 
timer processing instead of the guest.  When tx exit mitigation is 
enabled, the guest bumps the queue pointer, but carefully refrains from 
kicking the host.  The host polls the tx pointer using a timer, kicking 
itself periodically; if polling yields no packets it disables tx exit 
mitigation.  This saves the guest the bother of programming the timer, 
which presumably requires an exit if the timer is the closest one to 
expiration.

[btw, this can be implemented in virtqueue rather than virtio-net, no?]

-- 
Any sufficiently difficult bug is indistinguishable from a feature.
