From: Amit Shah <amit.shah@qumranet.com>
Subject: Re: [kvm-devel] [PATCH 2/2] KVM: Handle interrupts for PCI
	passthrough devices
Date: Fri, 2 May 2008 18:35:46 +0530
Message-ID: <200805021835.47565.amit.shah__42653.2085672536$1209733601$gmane$org@qumranet.com>
References: <1207817334-31775-1-git-send-email-amit.shah@qumranet.com>
	<200804222258.40644.amit.shah@qumranet.com>
	<481AEE65.2010303@qumranet.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <481AEE65.2010303@qumranet.com>
Content-Disposition: inline
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Avi Kivity <avi@qumranet.com>
Cc: chrisw@redhat.com, kvm-devel@lists.sourceforge.net, allen.m.kay@intel.com, virtualization@lists.linux-foundation.org, gcosta@redhat.com, BENAMI@il.ibm.com
List-Id: virtualization@lists.linuxfoundation.org

On Friday 02 May 2008 16:05:17 Avi Kivity wrote:
> Amit Shah wrote:
> >>> +static irqreturn_t
> >>> +kvm_pci_pt_dev_intr(int irq, void *dev_id)
> >>>
> >>> +{
> >>> +	struct kvm_pci_pt_dev_list *match;
> >>> +	struct kvm *kvm = (struct kvm *) dev_id;
> >>> +
> >>> +	if (!test_bit(irq, pt_irq_handled))
> >>> +		return IRQ_NONE;
> >>> +
> >>> +	if (test_bit(irq, pt_irq_pending))
> >>> +		return IRQ_HANDLED;
> >>
> >> Will the interrupt not fire immediately after this returns?
> >
> > Hmm. This is just an optimisation so that we don't have to look up the
> > list each time to find out which assigned device it is and (re)injecting
> > the interrupt. Also we avoid the (TODO) getting/releasing locks which
> > will be needed for the list lookup.
> >
> > Disabling interrupts for PCI devices isn't a good idea even if we don't
> > support shared interrupts. Any other ideas to avoid this from happening?
>
> I don't understand.  These are level-triggered interrupts, so if one
> fires and you don't disable it, it will fire again and again.

Yes, it does.

> Seems to me the only choice here is to mask the interrupt at the ioapic
> level, wait until the guest acks the interrupt, then unmask the interrupt.

OK; will that create problems if the line is shared?

> With the current code, how to the guest interrupt counters and the host
> interrupt counters compare?

The guest ticks along fine but the host count is quite huge. You're right in 
your observations; what I was only suggesting was that disabling a shared 
interrupt on the host while the guest acks it isn't a good idea.
