From: Dor Laor <dor.laor@gmail.com>
Subject: Re: [kvm-devel] [PATCH 2/3] virtio ring implementation
Date: Wed, 26 Sep 2007 11:08:03 +0200
Message-ID: <46FA2173.5050100__13555.08125057$1190798042$gmane$org@qumranet.com>
References: <1190625194.27805.199.camel@localhost.localdomain>	
	<1190625256.27805.201.camel@localhost.localdomain>	
	<1190625307.27805.203.camel@localhost.localdomain>	
	<46F7BF41.9060705@qumranet.com>	
	<1190727156.27805.332.camel@localhost.localdomain>	
	<46F94243.2000602@qumranet.com>
	<1190763475.2227.20.camel@localhost.localdomain>
Reply-To: dor.laor@qumranet.com
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <1190763475.2227.20.camel@localhost.localdomain>
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
Cc: kvm-devel <kvm-devel@lists.sourceforge.net>, virtualization <virtualization@lists.linux-foundation.org>
List-Id: virtualization@lists.linuxfoundation.org

Rusty Russell wrote:
> On Tue, 2007-09-25 at 19:15 +0200, Dor Laor wrote:
>   
>> At the moment it's not good enough, there is a potential race were the
>> guest optimistically turn off
>> the VRING_AVAIL_F_NO_INTERRUPT in the vring_restart and afterwards
>> finds there are more_used so
>> it consume them in the poll function. 
>> If in the middle, packets arrive the host will see the flag is off and
>> send irq.
>> In that case the above irq handler will report IRQ_NONE.
>>     
>
> Good point.  On the one hand, reporting IRQ_NONE occasionally is not
> fatal.  On the other, it'd be nice to get this right.
>
>   
>> It's also not trivial to cancel the optimistic approach in the restart
>> function since then there might be another race
>> that will result in missing irq reaching the guest.
>>     
>
> I did it optimistically because otherwise we need two barriers (and
> still have a window).
>
>   
>> I'll try to think of something better than a hypercall for switching
>> irq on/off.
>>     
>
> Erk.  That would be v. bad...
>   
Actually double barrier will satisfy non-shared irq lines and will 
report irq handling right.
The more complex scenario is shared irqs (pci...), since several devices 
are raising the irq line (level triggered)
in the same time, while the tap add receive packets it always leaves a 
potential race for irq handled return
value. So seems like we better not have shared irq and if only if shared 
irq is a must we should do the
naughty naughty things.

If returning IRQ_NONE once in a while is not too bad (including the 
matching windows implementation)
then there is no issue.
Dor.
