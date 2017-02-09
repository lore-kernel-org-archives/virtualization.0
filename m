From: "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: [PATCH] virtio: Try to untangle DMA coherency
Date: Thu, 9 Feb 2017 22:57:03 +0200
Message-ID: <20170209225635-mutt-send-email-mst@kernel.org>
References: <8a6494f6409c20b4609cd6bdcdd751f68b5c0564.1485951731.git.robin.murphy@arm.com>
	<20170201195732-mutt-send-email-mst@kernel.org>
	<20170201182659.GM8177@arm.com>
	<20170201210648-mutt-send-email-mst@kernel.org>
	<d6ded13e-aa48-023b-3a71-1c40aa5fced0@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <d6ded13e-aa48-023b-3a71-1c40aa5fced0@suse.de>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Alexander Graf <agraf@suse.de>
Cc: Mark Rutland <mark.rutland@arm.com>, rob.herring@linaro.org, devicetree@vger.kernel.org, Will Deacon <Will.Deacon@arm.com>, virtualization@lists.linux-foundation.org, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
List-Id: virtualization@lists.linuxfoundation.org

On Wed, Feb 08, 2017 at 01:58:10PM +0100, Alexander Graf wrote:
> On 02/01/2017 08:19 PM, Michael S. Tsirkin wrote:
> > On Wed, Feb 01, 2017 at 06:27:09PM +0000, Will Deacon wrote:
> > > On Wed, Feb 01, 2017 at 08:09:21PM +0200, Michael S. Tsirkin wrote:
> > > > On Wed, Feb 01, 2017 at 12:25:57PM +0000, Robin Murphy wrote:
> > > > > diff --git a/drivers/virtio/virtio_ring.c b/drivers/virtio/virtio_ring.c
> > > > > index 7e38ed79c3fc..961af25b385c 100644
> > > > > --- a/drivers/virtio/virtio_ring.c
> > > > > +++ b/drivers/virtio/virtio_ring.c
> > > > > @@ -20,6 +20,7 @@
> > > > >  #include <linux/virtio_ring.h>
> > > > >  #include <linux/virtio_config.h>
> > > > >  #include <linux/device.h>
> > > > > +#include <linux/property.h>
> > > > >  #include <linux/slab.h>
> > > > >  #include <linux/module.h>
> > > > >  #include <linux/hrtimer.h>
> > > > > @@ -160,10 +161,14 @@ static bool vring_use_dma_api(struct virtio_device *vdev)
> > > > >  		return true;
> > > > > 
> > > > >  	/*
> > > > > -	 * On ARM-based machines, the DMA ops will do the right thing,
> > > > > -	 * so always use them with legacy devices.
> > > > > +	 * On ARM-based machines, the coherent DMA ops will do the right
> > > > > +	 * thing, so always use them with legacy devices. However, using
> > > > > +	 * non-coherent DMA when the host *is* actually coherent, but has
> > > > > +	 * forgotten to tell us, is going to break badly; since this situation
> > > > > +	 * already exists in the wild, maintain the old behaviour there.
> > > > >  	 */
> > > > > -	if (IS_ENABLED(CONFIG_ARM) || IS_ENABLED(CONFIG_ARM64))
> > > > > +	if ((IS_ENABLED(CONFIG_ARM) || IS_ENABLED(CONFIG_ARM64)) &&
> > > > > +	    device_get_dma_attr(&vdev->dev) == DEV_DMA_COHERENT)
> > > > >  		return !virtio_has_feature(vdev, VIRTIO_F_VERSION_1);
> > > > > 
> > > > >  	return false;
> > > > 
> > > > This is exactly what I feared.
> > > 
> > > Yes, sorry about this. It works fine for virtio-pci (where "dma-coherent"
> > > is used) and it also works on the fastmodel if you disable cache-modelling
> > > (which is needed to make the thing run at a usable pace) so we didn't spot
> > > this in testing.
> > > 
> > > > Could we identify fastboot and do the special dance just for it?
> > > 
> > > [assuming you mean fastmodel instead of fastboot]
> > > 
> > > > I'd like to do that instead. It's fastboot doing the unreasonable thing
> > > > here and deviating from what every other legacy device without exception
> > > > did for years. If this means fastboot will need to update to virtio 1,
> > > > all the better.
> > > 
> > > The problem still exists with virtio 1, unless we require that the
> > > "dma-coherent" property is set/unset correctly when VIRTIO_F_IOMMU_PLATFORM
> > > is advertised by the device (which is what I suggested in my reply).
> > 
> > I'm not ignoring that, but I need to understand that part a bit better.
> > I'll reply to that patch in a day or two after looking at how _CCA is
> > supposed to work.
> > 
> > > We can't detect the fastmodel,
> > 
> > Surely, it puts a hardware id somewhere? I think you mean
> > fastmodel isn't always affected, right?
> > 
> > > but we could implicitly treat virtio-mmio
> > > devices as cache-coherent regardless of the "dma-coherent" flag. I already
> > > prototyped this, but I suspect the devicetree people will push back (and
> > > there's a similar patch needed for ACPI).
> > > 
> > > See below. Do you prefer this approach?
> > > 
> > > Will
> > > 
> > > --->8
> > 
> > I'd like to see basically
> > 
> > if (fastmodel)
> > 	a pile of special work-arounds
> > else
> > 	not less hacky but more common virtio work-arounds
> > 
> > :)
> > 
> > And then I can apply whatever comes from @arm.com and not
> > worry about breaking actual hardware.
> 
> I'm actually seeing the exact same breakage in QEMU right now, so it's not
> fast model related at all. In QEMU we also don't properly set the
> dma-coherent flag, so we run into cache coherency problems.
> 
> 
> Alex

But with latest revert QEMU should now work, right?

-- 
MST
