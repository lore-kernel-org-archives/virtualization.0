From: Amit Shah <amit.shah@qumranet.com>
Subject: Re: [PATCH] KVM PV Guest: Implement paravirtualized DMA
Date: Tue, 29 Apr 2008 19:29:17 +0530
Message-ID: <200804291929.18733.amit.shah__6719.47276355258$1209477613$gmane$org@qumranet.com>
References: <1209465451-3758-1-git-send-email-amit.shah@qumranet.com>
	<1209465451-3758-4-git-send-email-amit.shah@qumranet.com>
	<87od7shjnv.fsf@basil.nowhere.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <87od7shjnv.fsf@basil.nowhere.org>
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

On Tuesday 29 April 2008 19:01:32 Andi Kleen wrote:
> Amit Shah <amit.shah@qumranet.com> writes:

> > +const struct dma_mapping_ops *orig_dma_ops;
>
> I suspect real dma ops stacking will need some further thought than
> your simple hacks

Yes; that's something we're planning to do.

> Haven't read further, but to be honest the code doesn't seem to be anywhere
> near merging quality.

I'm basically using these patches to test the PCI passthrough functionality 
(by which we can assign host PCI devices to a guest OS via KVM). While other 
methods of handling DMA operations are being worked on (1-1 mapping of the 
guest in the host address space and virtualization-aware IOMMU translations), 
this patchset provides a quick way to check if things indeed work.

However, if some version of this patch can be useful upstream, I'll be glad to 
work on that. That said, as you point out, we need stackable dma ops as well 
as getting rid of the is_pv_device() function in dma_ops and that's something 
that can be done right away.

Thanks for the review!

Amit
