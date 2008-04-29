From: Amit Shah <amit.shah@qumranet.com>
Subject: Re: [PATCH] x86 DMA: Handle devices assigned to the guest by the host
Date: Tue, 29 Apr 2008 19:19:23 +0530
Message-ID: <200804291919.23853.amit.shah__9562.86035147986$1209477095$gmane$org@qumranet.com>
References: <1209465451-3758-1-git-send-email-amit.shah@qumranet.com>
	<1209465451-3758-2-git-send-email-amit.shah@qumranet.com>
	<87wsmghkgg.fsf@basil.nowhere.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <87wsmghkgg.fsf@basil.nowhere.org>
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
To: Andi Kleen <andi@firstfloor.org>
Cc: chrisw@redhat.com, kvm-devel@lists.sourceforge.net, allen.m.kay@intel.com, linux-kernel@vger.kernel.org, gcosta@redhat.com, virtualization@lists.linux-foundation.org, BENAMI@il.ibm.com
List-Id: virtualization@lists.linuxfoundation.org

On Tuesday 29 April 2008 18:44:23 Andi Kleen wrote:
> Amit Shah <amit.shah@qumranet.com> writes:
> > diff --git a/arch/x86/kernel/pci-dma.c b/arch/x86/kernel/pci-dma.c
> > index 388b113..678cafb 100644
> > --- a/arch/x86/kernel/pci-dma.c
> > +++ b/arch/x86/kernel/pci-dma.c
> > @@ -443,6 +443,17 @@ dma_alloc_coherent(struct device *dev, size_t size,
> > dma_addr_t *dma_handle, memset(memory, 0, size);
> >  		if (!mmu) {
> >  			*dma_handle = bus;
> > +			if (unlikely(dma_ops->is_pv_device) &&
> > +			    unlikely(dma_ops->is_pv_device(dev, dev->bus_id))) {
>
> First double unlikely in a condition is useless. Just drop them.
>
> And then ->is_xyz() in a generic vops interface is about as ugly
> and non generic as you can get. dma_alloc_coherent is not performance
> critical, so you should rather change the interface that ->alloc_coherent
> is always called and the other handlers handle the !mmu case correctly.
> In fact they need that already I guess (e.g. on DMAR there is not really
> a nommu case)

This point came up the last time I sent out the patch; we should do this as 
well as implement stackable dma_ops (the need for that is evident in the next 
patch).

Thanks for the observation; this should be the next step.

Amit.
