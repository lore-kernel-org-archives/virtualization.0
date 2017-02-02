From: Will Deacon <will.deacon@arm.com>
Subject: Re: [PATCH] virtio: Try to untangle DMA coherency
Date: Thu, 2 Feb 2017 11:26:15 +0000
Message-ID: <20170202112614.GB30577__32768.3130199604$1486034783$gmane$org@arm.com>
References: <8a6494f6409c20b4609cd6bdcdd751f68b5c0564.1485951731.git.robin.murphy@arm.com>
	<20170201195732-mutt-send-email-mst@kernel.org>
	<20170201182659.GM8177@arm.com>
	<20170201210648-mutt-send-email-mst@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <20170201210648-mutt-send-email-mst@kernel.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: mark.rutland@arm.com, devicetree@vger.kernel.org, pawel.moll@arm.com, virtualization@lists.linux-foundation.org, robh+dt@kernel.org, Robin Murphy <robin.murphy@arm.com>, linux-arm-kernel@lists.infradead.org
List-Id: virtualization@lists.linuxfoundation.org

On Wed, Feb 01, 2017 at 09:19:22PM +0200, Michael S. Tsirkin wrote:
> On Wed, Feb 01, 2017 at 06:27:09PM +0000, Will Deacon wrote:
> > On Wed, Feb 01, 2017 at 08:09:21PM +0200, Michael S. Tsirkin wrote:
> > > I'd like to do that instead. It's fastboot doing the unreasonable thing
> > > here and deviating from what every other legacy device without exception
> > > did for years. If this means fastboot will need to update to virtio 1,
> > > all the better.
> > 
> > The problem still exists with virtio 1, unless we require that the
> > "dma-coherent" property is set/unset correctly when VIRTIO_F_IOMMU_PLATFORM
> > is advertised by the device (which is what I suggested in my reply).
> 
> I'm not ignoring that, but I need to understand that part a bit better.
> I'll reply to that patch in a day or two after looking at how _CCA is
> supposed to work.

Thanks. I do think that whatever solution we come up with for virtio 1
should influence what we do for legacy.

> > We can't detect the fastmodel,
> 
> Surely, it puts a hardware id somewhere? I think you mean
> fastmodel isn't always affected, right?

I don't think there's a hardware ID. The thing is, the fastmodel is a
toolkit for building all sorts of platforms: you can chop and change
the CPUs, the peripherals, the memory, the interrupt controller, the
interconnect etc. Pretty much everything can be customised. So, for
any fastmodel configuration that places virtio upstream of the SMMU
(which is common, because virtio is one of the few DMA-capable peripherals
that the fastmodel supports), we need to do something special.

> I'd like to see basically
> 
> if (fastmodel)
> 	a pile of special work-arounds
> else
> 	not less hacky but more common virtio work-arounds
> 
> :)
> 
> And then I can apply whatever comes from @arm.com and not
> worry about breaking actual hardware.

What we could do is call iommu_group_get(&vdev->dev) for legacy
devices if CONFIG_ARM64. If that returns non-NULL, then we know that
the device is upstream of an SMMU, which means it must be the fastmodel.

Will
