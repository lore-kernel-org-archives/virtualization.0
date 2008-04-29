From: Andi Kleen <andi@firstfloor.org>
Subject: Re: [PATCH] x86 DMA: Handle devices assigned to the guest by the host
Date: Tue, 29 Apr 2008 15:14:23 +0200
Message-ID: <87wsmghkgg.fsf__6806.75574481047$1209475220$gmane$org@basil.nowhere.org>
References: <1209465451-3758-1-git-send-email-amit.shah@qumranet.com>
	<1209465451-3758-2-git-send-email-amit.shah@qumranet.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <1209465451-3758-2-git-send-email-amit.shah@qumranet.com> (Amit
	Shah's message of "Tue, 29 Apr 2008 13:37:29 +0300")
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
Cc: chrisw@redhat.com, kvm-devel@lists.sourceforge.net, allen.m.kay@intel.com, linux-kernel@vger.kernel.org, gcosta@redhat.com, virtualization@lists.linux-foundation.org, BENAMI@il.ibm.com
List-Id: virtualization@lists.linuxfoundation.org

Amit Shah <amit.shah@qumranet.com> writes:
> diff --git a/arch/x86/kernel/pci-dma.c b/arch/x86/kernel/pci-dma.c
> index 388b113..678cafb 100644
> --- a/arch/x86/kernel/pci-dma.c
> +++ b/arch/x86/kernel/pci-dma.c
> @@ -443,6 +443,17 @@ dma_alloc_coherent(struct device *dev, size_t size, dma_addr_t *dma_handle,
>  		memset(memory, 0, size);
>  		if (!mmu) {
>  			*dma_handle = bus;
> +			if (unlikely(dma_ops->is_pv_device) &&
> +			    unlikely(dma_ops->is_pv_device(dev, dev->bus_id))) {

First double unlikely in a condition is useless. Just drop them.

And then ->is_xyz() in a generic vops interface is about as ugly
and non generic as you can get. dma_alloc_coherent is not performance
critical, so you should rather change the interface that ->alloc_coherent
is always called and the other handlers handle the !mmu case correctly.
In fact they need that already I guess (e.g. on DMAR there is not really
a nommu case) 

-Andi
