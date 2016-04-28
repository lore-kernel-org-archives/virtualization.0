From: "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: [PATCH V2 RFC] fixup! virtio: convert to use DMA api
Date: Thu, 28 Apr 2016 18:37:59 +0300
Message-ID: <20160428182341-mutt-send-email-mst__3650.8914934986$1461857901$gmane$org@redhat.com>
References: <20160427153345-mutt-send-email-mst@redhat.com>
	<20160427142331.GH17926@8bytes.org>
	<20160427172630-mutt-send-email-mst@redhat.com>
	<20160427145632.GI17926@8bytes.org>
	<20160427180007-mutt-send-email-mst@redhat.com>
	<1461770135.118304.152.camel@infradead.org>
	<20160427211635-mutt-send-email-mst@redhat.com>
	<1461784617.118304.181.camel@infradead.org>
	<20160428172039-mutt-send-email-mst@redhat.com>
	<1461856314.33870.98.camel@infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <1461856314.33870.98.camel@infradead.org>
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

On Thu, Apr 28, 2016 at 04:11:54PM +0100, David Woodhouse wrote:
> On Thu, 2016-04-28 at 17:34 +0300, Michael S. Tsirkin wrote:
> > I see work-arounds for broken IOMMUs but not for
> > individual devices. Could you point me to a more specific
> > example?
> 
> I think the closest example is probably quirk_ioat_snb_local_iommu().

OK, so for intel, it seems that it's enough to set
	pdev->dev.archdata.iommu = DUMMY_DEVICE_DOMAIN_INFO;
for the device.

Do I have to poke at each iommu implementation to find
a way to do this, or is there some way to do it
portably?

> If we see this particular device, we *know* what the topology actually
> looks like. We check the hardware setup, and if we're *not* being told
> the truth, then we stick it in bypass mode because we know it *isn't*
> actually being translated.
> 
> Actually, that's almost *identical* to what we want, isn't it?
> 
> Except instead of checking undocumented chipset registers, it wants to
> be checking "am I on a version of qemu known to lie about virtio being
> translated?"

Not exactly - I think that future versions of qemu might lie
about some devices but not others.

> > > We don't actually *need* it for the Intel IOMMU; all we need is for
> > > QEMU to stop lying in its DMAR tables.
> > We need it for legacy QEMU anyway, and it's not easy for QEMU to stop
> > lying about virtio, so we'll need it for a while.
> > I think it's easy for QEMU to stop lying about assigned devices,
> > so we don't need it for non-virtio devices.
> 
> Why is it easier for QEMU to tell the truth about assigned devices,
> than it is for virtio? Assuming they both remain actually untranslated
> for now, why's it easier to fix the DMAR table for one and not the
> other?
> 
> (Implementing translation of assigned devices is on my list, but it's a
> long way off).

DMAR is unfortunately not a good match for what people do with QEMU.

There is a patchset on list fixing translation of assigned
devices. So the fix for these will simply be to do translation for all
assigned devices. It's harder for virtio as it isn't always
processed in QEMU - there's vhost in kernel and an out of process
vhost-user plugin. So we can end up e.g. with modern QEMU which
does translate in-process virtio but not out of process one.

> > I don't see why how fwcfg can work here. It's a static thing,
> > devices can come and go with hotplug.
> 
> This touches on something you said elsewhere, that it's
> painful/impossible to hot-unplug a translated device and hot-plug an
> untranslated device in the same slot (and vice versa).
> 
> So let's assume for now that a given slot is indeed static, and either
> translated or untranslated. Like the DMAR table, the fwcfg can just
> give a list of slot which are (or aren't) translated.
> 
> And then you can *only* add a translated device to a translated slot,
> or an untranslated device to an untranslated slot.
> 
> All the internally-emulated devices *can* be either translated or
> untranslated. That's just a matter of software. Surely, you currently
> *can't* have translated assigned devices (until someone implements the
> whole VT-d page table shadowing or whatever), so you'll be barred from
> assigning a device to a slot which *previously* had an untranslated
> device. But so what? Put it in a different slot instead.

Unfortunately people got used to be able to put any device
in any slot, and built external tools around that ability.
It's rather painful to break this assumption.

> -- 
> dwmw2
> 
