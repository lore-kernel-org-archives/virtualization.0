From: Stefano Stabellini <sstabellini@kernel.org>
Subject: Re: [PATCH] xen: introduce xen_vring_use_dma
Date: Wed, 1 Jul 2020 10:34:53 -0700 (PDT)
Message-ID: <alpine.DEB.2.21.2007011020320.8121@sstabellini-ThinkPad-T480s>
References: <20200624091732.23944-1-peng.fan@nxp.com> <20200624050355-mutt-send-email-mst@kernel.org> <alpine.DEB.2.21.2006241047010.8121@sstabellini-ThinkPad-T480s> <20200624163940-mutt-send-email-mst@kernel.org> <alpine.DEB.2.21.2006241351430.8121@sstabellini-ThinkPad-T480s>
 <20200624181026-mutt-send-email-mst@kernel.org> <alpine.DEB.2.21.2006251014230.8121@sstabellini-ThinkPad-T480s> <20200626110629-mutt-send-email-mst@kernel.org> <alpine.DEB.2.21.2006291621300.8121@sstabellini-ThinkPad-T480s>
 <20200701133456.GA23888@infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20200701133456.GA23888@infradead.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Christoph Hellwig <hch@infradead.org>
Cc: Stefano Stabellini <sstabellini@kernel.org>, jgross@suse.com, Peng Fan <peng.fan@nxp.com>, x86@kernel.org, konrad.wilk@oracle.com, jasowang@redhat.com, "Michael S. Tsirkin" <mst@redhat.com>, linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org, iommu@lists.linux-foundation.org, linux-imx@nxp.com, xen-devel@lists.xenproject.org, boris.ostrovsky@oracle.com, linux-arm-kernel@lists.infradead.org
List-Id: virtualization@lists.linuxfoundation.org

On Wed, 1 Jul 2020, Christoph Hellwig wrote:
> On Mon, Jun 29, 2020 at 04:46:09PM -0700, Stefano Stabellini wrote:
> > > I could imagine some future Xen hosts setting a flag somewhere in the
> > > platform capability saying "no xen specific flag, rely on
> > > "VIRTIO_F_ACCESS_PLATFORM". Then you set that accordingly in QEMU.
> > > How about that?
> > 
> > Yes, that would be fine and there is no problem implementing something
> > like that when we get virtio support in Xen. Today there are still no
> > virtio interfaces provided by Xen to ARM guests (no virtio-block/net,
> > etc.)
> > 
> > In fact, in both cases we are discussing virtio is *not* provided by
> > Xen; it is a firmware interface to something entirely different:
> > 
> > 1) virtio is used to talk to a remote AMP processor (RPMesg)
> > 2) virtio is used to talk to a secure-world firmware/OS (Trusty)
> >
> > VIRTIO_F_ACCESS_PLATFORM is not set by Xen in these cases but by RPMesg
> > and by Trusty respectively. I don't know if Trusty should or should not
> > set VIRTIO_F_ACCESS_PLATFORM, but I think Linux should still work
> > without issues.
> > 
> 
> Any virtio implementation that is not in control of the memory map
> (aka not the hypervisor) absolutely must set VIRTIO_F_ACCESS_PLATFORM,
> else it is completely broken.

Lots of broken virtio implementations out there it would seem :-(


> > The xen_domain() check in Linux makes it so that vring_use_dma_api
> > returns the opposite value on native Linux compared to Linux as Xen/ARM
> > DomU by "accident". By "accident" because there is no architectural
> > reason why Linux Xen/ARM DomU should behave differently compared to
> > native Linux in this regard.
> > 
> > I hope that now it is clearer why I think the if (xen_domain()) check
> > needs to be improved anyway, even if we fix generic dma_ops with virtio
> > interfaces missing VIRTIO_F_ACCESS_PLATFORM.
> 
> IMHO that Xen quirk should never have been added in this form..

Would you be in favor of a more flexible check along the lines of the
one proposed in the patch that started this thread:

    if (xen_vring_use_dma())
            return true;


xen_vring_use_dma would be implemented so that it returns true when
xen_swiotlb is required and false otherwise.
