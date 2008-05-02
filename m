From: Avi Kivity <avi@qumranet.com>
Subject: Re: [kvm-devel] [PATCH 2/2] KVM: Handle interrupts for PCI passthrough
	devices
Date: Fri, 02 May 2008 13:35:17 +0300
Message-ID: <481AEE65.2010303__29791.5842188106$1209724762$gmane$org@qumranet.com>
References: <1207817334-31775-1-git-send-email-amit.shah@qumranet.com>
	<1207817334-31775-3-git-send-email-amit.shah@qumranet.com>
	<4801C60B.3050401@qumranet.com>
	<200804222258.40644.amit.shah@qumranet.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <200804222258.40644.amit.shah@qumranet.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Amit Shah <amit.shah@qumranet.com>
Cc: chrisw@redhat.com, kvm-devel@lists.sourceforge.net, allen.m.kay@intel.com, virtualization@lists.linux-foundation.org, gcosta@redhat.com, BENAMI@il.ibm.com
List-Id: virtualization@lists.linuxfoundation.org

Amit Shah wrote:
>   
>>> +static irqreturn_t
>>> +kvm_pci_pt_dev_intr(int irq, void *dev_id)
>>>       
>>> +{
>>> +	struct kvm_pci_pt_dev_list *match;
>>> +	struct kvm *kvm = (struct kvm *) dev_id;
>>> +
>>> +	if (!test_bit(irq, pt_irq_handled))
>>> +		return IRQ_NONE;
>>> +
>>> +	if (test_bit(irq, pt_irq_pending))
>>> +		return IRQ_HANDLED;
>>>       
>> Will the interrupt not fire immediately after this returns?
>>     
>
> Hmm. This is just an optimisation so that we don't have to look up the list 
> each time to find out which assigned device it is and (re)injecting the 
> interrupt. Also we avoid the (TODO) getting/releasing locks which will be 
> needed for the list lookup.
>
> Disabling interrupts for PCI devices isn't a good idea even if we don't 
> support shared interrupts. Any other ideas to avoid this from happening?
>
>   

I don't understand.  These are level-triggered interrupts, so if one 
fires and you don't disable it, it will fire again and again.

Seems to me the only choice here is to mask the interrupt at the ioapic 
level, wait until the guest acks the interrupt, then unmask the interrupt.

With the current code, how to the guest interrupt counters and the host 
interrupt counters compare?


-- 
I have a truly marvellous patch that fixes the bug which this
signature is too narrow to contain.
