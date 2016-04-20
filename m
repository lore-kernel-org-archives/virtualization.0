From: "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: [PATCH RFC] fixup! virtio: convert to use DMA api
Date: Wed, 20 Apr 2016 16:14:40 +0300
Message-ID: <20160420161338-mutt-send-email-mst@redhat.com>
References: <20160419190520-mutt-send-email-mst@redhat.com>
	<CALCETrWEo12k49kFmPA3NByXrLb8OYQEmDYoYgngQcxMZ=1Mzw@mail.gmail.com>
	<20160419191914-mutt-send-email-mst@redhat.com>
	<1461083204.20056.8.camel@infradead.org>
	<20160419204907-mutt-send-email-mst@redhat.com>
	<CALCETrXsbYj5c3j2em2-jrhBWp-VqRJd900s5WDdVUMCN2aiNg@mail.gmail.com>
	<20160419231437-mutt-send-email-mst@redhat.com>
	<CALCETrXqrbwvStj9MhKizceze56SAFH_hUJwsQ83NsSRzWiq8Q@mail.gmail.com>
	<20160419235212-mutt-send-email-mst@redhat.com>
	<CALCETrUif0iAFWFsz-i848yUO9WrXZ7q+Kx3-4wu-dQRiuCweg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <CALCETrUif0iAFWFsz-i848yUO9WrXZ7q+Kx3-4wu-dQRiuCweg@mail.gmail.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Andy Lutomirski <luto@amacapital.net>
Cc: Wei Liu <wei.liu2@citrix.com>, Andy Lutomirski <luto@kernel.org>, qemu-block@nongnu.org, Christian Borntraeger <borntraeger@de.ibm.com>, "qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>, peterx@redhat.com, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Amit Shah <amit.shah@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>, kvm list <kvm@vger.kernel.org>, Paolo Bonzini <pbonzini@redhat.com>, Linux Virtualization <virtualization@lists.linux-foundation.org>, David Woodhouse <dwmw2@infradead.org>
List-Id: virtualization@lists.linuxfoundation.org

On Tue, Apr 19, 2016 at 02:07:01PM -0700, Andy Lutomirski wrote:
> On Tue, Apr 19, 2016 at 1:54 PM, Michael S. Tsirkin <mst@redhat.com> wrote:
> > On Tue, Apr 19, 2016 at 01:27:29PM -0700, Andy Lutomirski wrote:
> >> On Tue, Apr 19, 2016 at 1:16 PM, Michael S. Tsirkin <mst@redhat.com> wrote:
> >> > On Tue, Apr 19, 2016 at 11:01:38AM -0700, Andy Lutomirski wrote:
> >> >> On Tue, Apr 19, 2016 at 10:49 AM, Michael S. Tsirkin <mst@redhat.com> wrote:
> >> >> > On Tue, Apr 19, 2016 at 12:26:44PM -0400, David Woodhouse wrote:
> >> >> >> On Tue, 2016-04-19 at 19:20 +0300, Michael S. Tsirkin wrote:
> >> >> >> >
> >> >> >> > > I thought that PLATFORM served that purpose.  Woudn't the host
> >> >> >> > > advertise PLATFORM support and, if the guest doesn't ack it, the host
> >> >> >> > > device would skip translation?  Or is that problematic for vfio?
> >> >> >> >
> >> >> >> > Exactly that's problematic for security.
> >> >> >> > You can't allow guest driver to decide whether device skips security.
> >> >> >>
> >> >> >> Right. Because fundamentally, this *isn't* a property of the endpoint
> >> >> >> device, and doesn't live in virtio itself.
> >> >> >>
> >> >> >> It's a property of the platform IOMMU, and lives there.
> >> >> >
> >> >> > It's a property of the hypervisor virtio implementation, and lives there.
> >> >>
> >> >> It is now, but QEMU could, in principle, change the way it thinks
> >> >> about it so that virtio devices would use the QEMU DMA API but ask
> >> >> QEMU to pass everything through 1:1.  This would be entirely invisible
> >> >> to guests but would make it be a property of the IOMMU implementation.
> >> >> At that point, maybe QEMU could find a (platform dependent) way to
> >> >> tell the guest what's going on.
> >> >>
> >> >> FWIW, as far as I can tell, PPC and SPARC really could, in principle,
> >> >> set up 1:1 mappings in the guest so that the virtio devices would work
> >> >> regardless of whether QEMU is ignoring the IOMMU or not -- I think the
> >> >> only obstacle is that the PPC and SPARC 1:1 mappings are currectly set
> >> >> up with an offset.  I don't know too much about those platforms, but
> >> >> presumably the layout could be changed so that 1:1 really was 1:1.
> >> >>
> >> >> --Andy
> >> >
> >> > Sure. Do you see any reason why the decision to do this can't be
> >> > keyed off the virtio feature bit?
> >>
> >> I can think of three types of virtio host:
> >>
> >> a) virtio always bypasses the IOMMU.
> >>
> >> b) virtio never bypasses the IOMMU (unless DMAR tables or similar say
> >> it does) -- i.e. virtio works like any other device.
> >>
> >> c) virtio may bypass the IOMMU depending on what the guest asks it to do.
> >
> > d) some virtio devices bypass the IOMMU and some don't,
> > e.g. it's harder to support IOMMU with vhost.
> >
> >
> >> If this is keyed off a virtio feature bit and anyone tries to
> >> implement (c), the vfio is going to have a problem.  And, if it's
> >> keyed off a virtio feature bit, then (a) won't work on Xen or similar
> >> setups unless the Xen hypervisor adds a giant and probably unreliable
> >> kludge to support it.  Meanwhile, 4.6-rc works fine under Xen on a
> >> default x86 QEMU configuration, and I'd really like to keep it that
> >> way.
> >>
> >> What could plausibly work using a virtio feature bit is for a device
> >> to say "hey, I'm a new device and I support the platform-defined IOMMU
> >> mechanism".  This bit would be *set* on default IOMMU-less QEMU
> >> configurations and on physical virtio PCI cards.
> >
> > And clear on xen.
> 
> How?  QEMU has no idea that the guest is running Xen.

I was under impression xen_enabled() is true in QEMU.
Am I wrong?

-- 
MST
