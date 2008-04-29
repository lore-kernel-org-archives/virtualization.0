From: Andi Kleen <andi@firstfloor.org>
Subject: Re: [PATCH] KVM PV Guest: Implement paravirtualized DMA
Date: Tue, 29 Apr 2008 15:31:32 +0200
Message-ID: <87od7shjnv.fsf__12651.0482783944$1209476475$gmane$org@basil.nowhere.org>
References: <1209465451-3758-1-git-send-email-amit.shah@qumranet.com>
	<1209465451-3758-2-git-send-email-amit.shah@qumranet.com>
	<1209465451-3758-3-git-send-email-amit.shah@qumranet.com>
	<1209465451-3758-4-git-send-email-amit.shah@qumranet.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <1209465451-3758-4-git-send-email-amit.shah@qumranet.com> (Amit
	Shah's message of "Tue, 29 Apr 2008 13:37:31 +0300")
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
> +
> +static struct page *page;
> +static unsigned long page_gfn;
Bad variable names

> +
> +const struct dma_mapping_ops *orig_dma_ops;

I suspect real dma ops stacking will need some further thought than
your simple hacks
> +
> +	match = find_matching_pt_dev(&pt_devs_head, &pv_pci_info);
> +	if (match) {
> +		r = match->is_pv;
> +		goto out;
> +	}
> +
> +	memcpy(page_address(page), &pv_pci_info, sizeof(pv_pci_info));

Note that on 32bit page_address() might be not mapped.


> +
> +	npages = get_order(size) + 1;

Are you sure that's correct? It looks quite bogus. order is a 2 logarithm,
normally npages = 1 << order

if you want  npages from order the correct  need 1 << order

Haven't read further, but to be honest the code doesn't seem to be anywhere
near merging quality.

-Andi
