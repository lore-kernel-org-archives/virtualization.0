From: "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: [PATCH V2 RFC] fixup! virtio: convert to use DMA api
Date: Sun, 1 May 2016 13:37:49 +0300
Message-ID: <20160501132934-mutt-send-email-mst@redhat.com>
References: <20160427172630-mutt-send-email-mst@redhat.com>
	<20160427145632.GI17926@8bytes.org>
	<20160427180007-mutt-send-email-mst@redhat.com>
	<1461770135.118304.152.camel@infradead.org>
	<20160427211635-mutt-send-email-mst@redhat.com>
	<1461784617.118304.181.camel@infradead.org>
	<20160428172039-mutt-send-email-mst@redhat.com>
	<1461856314.33870.98.camel@infradead.org>
	<20160428182341-mutt-send-email-mst@redhat.com>
	<1461858505.33870.108.camel@infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <1461858505.33870.108.camel@infradead.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: David Woodhouse <dwmw2@infradead.org>
Cc: Wei Liu <wei.liu2@citrix.com>, Stefan Hajnoczi <stefanha@redhat.com>, qemu-block@nongnu.org, Stefano Stabellini <stefano.stabellini@eu.citrix.com>, Joerg Roedel <joro@8bytes.org>, qemu-devel@nongnu.org, peterx@redhat.com, linux-kernel@vger.kernel.org, Christian Borntraeger <borntraeger@de.ibm.com>, iommu@lists.linux-foundation.org, Andy Lutomirski <luto@kernel.org>, kvm@vger.kernel.org, Amit Shah <amit.shah@redhat.com>, pbonzini@redhat.com, virtualization@lists.linux-foundation.org, Anthony PERARD <anthony.perard@citrix.com>
List-Id: virtualization@lists.linuxfoundation.org

On Thu, Apr 28, 2016 at 04:48:25PM +0100, David Woodhouse wrote:
> On Thu, 2016-04-28 at 18:37 +0300, Michael S. Tsirkin wrote:
> > OK, so for intel, it seems that it's enough to set
> > 	pdev->dev.archdata.iommu = DUMMY_DEVICE_DOMAIN_INFO;
> > for the device.
> 
> Yes, currently. Although that's vile. In fact what we *want* to happen
> is for the intel-iommu code simply to decline to provide DMA ops for
> this device, and let it fall back to the swiotlb or no-op DMA ops, as
> appropriate.
> 
> As it is, we have the intel-iommu DMA ops *unconditionally, and they
> have a hack to manually fall back to calling swiotlb. It's all just
> horrid, which is why I want to clean it up with nice per-device DMA ops
> and discovery thereof :)
> 
> > Do I have to poke at each iommu implementation to find
> > a way to do this, or is there some way to do it
> > portably?
> 
> There *will* be.... Christoph has already done some of the cleanup in
> this space, and I need to take stock of what he's already done, and
> finish off the parts I want to build on top of it.
> 
> > Not exactly - I think that future versions of qemu might lie
> > about some devices but not others.
> 
> Can we keep this simple?
> 
> QEMU currently lies about some devices. Let's implement a heuristic for
> the guest OS to know about that, and react accordingly.
> 
> Then let's fix QEMU to tell the truth. All the time, unconditionally.
> Even on POWER/ARM where there's no obvious *way* for it to tell the
> truth (because you don't have the flexibility that DMAR tables do), and
> we need to devise a way to put it in the device-tree or fwcfg or
> something else.

Right.  Unfortunately all these aren't easy to implement at all.
So I'm inclined to go the "something else" route.
It has the added benefit of giving us a heuristic for free.

> And only once QEMU consistently tells the *truth*, then we can start to
> do new stuff and let it actually change its behaviour.
> 
> > DMAR is unfortunately not a good match for what people do with QEMU.
> > 
> > There is a patchset on list fixing translation of assigned
> > devices. So the fix for these will simply be to do translation for
> > all assigned devices. It's harder for virtio as it isn't always
> > processed in QEMU - there's vhost in kernel and an out of process
> > vhost-user plugin. So we can end up e.g. with modern QEMU which
> > does translate in-process virtio but not out of process one.
> 
> Right... just stop. Fix QEMU to tell the truth first, and *then* once
> we can trust it, we can start to change its behaviour. :)
> 
> > Unfortunately people got used to be able to put any device
> > in any slot, and built external tools around that ability.
> > It's rather painful to break this assumption.
> 
> Well, if you just said you have a patch set which allows translation of
> assigned devices then you are most of the way there, aren't you? We
> just need to fix the out-of-process virtio case, and everything can be
> either translated or untranslated?

Absolutely. But that "just" will take a while.  With out of process
there's always a chance that remote doesn't implement translation. E.g.
new QEMU running on an old host kernel.

> -- 
> dwmw2
> 
