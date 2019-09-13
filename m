From: Gerd Hoffmann <kraxel@redhat.com>
Subject: Re: [RFC PATCH] drm/virtio: Export resource handles via DMA-buf API
Date: Fri, 13 Sep 2019 10:07:07 +0200
Message-ID: <20190913080707.unhyoezesvfhx5np__33667.4016945594$1568362040$gmane$org@sirius.home.kraxel.org>
References: <20190912094121.228435-1-tfiga@chromium.org>
	<20190912123821.rraib5entkcxt5p5@sirius.home.kraxel.org>
	<CAAFQd5AFXfu7ysFCi1XQS61DK8nbSk5-=UHkvpYWDtFae5YQ6Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <CAAFQd5AFXfu7ysFCi1XQS61DK8nbSk5-=UHkvpYWDtFae5YQ6Q@mail.gmail.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Tomasz Figa <tfiga@chromium.org>
Cc: Zach Reizner <zachr@chromium.org>, David Airlie <airlied@linux.ie>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, dri-devel <dri-devel@lists.freedesktop.org>, virtualization@lists.linux-foundation.org, Keiichi Watanabe <keiichiw@chromium.org>, stevensd@chromium.org, Daniel Vetter <daniel@ffwll.ch>, =?utf-8?B?U3TDqXBoYW5l?= Marchesin <marcheu@chromium.org>, Pawel Osciak <posciak@chromium.org>
List-Id: virtualization@lists.linuxfoundation.org

  Hi,

> > > To seamlessly enable buffer sharing with drivers using such frameworks,
> > > make the virtio-gpu driver expose the resource handle as the DMA address
> > > of the buffer returned from the DMA-buf mapping operation.  Arguably, the
> > > resource handle is a kind of DMA address already, as it is the buffer
> > > identifier that the device needs to access the backing memory, which is
> > > exactly the same role a DMA address provides for native devices.
> 
> First of all, thanks for taking a look at this.
> 
> > No.  A scatter list has guest dma addresses, period.  Stuffing something
> > else into a scatterlist is asking for trouble, things will go seriously
> > wrong when someone tries to use such a fake scatterlist as real scatterlist.
> 
> What is a "guest dma address"? The definition of a DMA address in the
> Linux DMA API is an address internal to the DMA master address space.
> For virtio, the resource handle namespace may be such an address
> space.

No.  DMA master address space in virtual machines is pretty much the
same it is on physical machines.  So, on x86 without iommu, identical
to (guest) physical address space.  You can't re-define it like that.

> However, we could as well introduce a separate DMA address
> space if resource handles are not the right way to refer to the memory
> from other virtio devices.

s/other virtio devices/other devices/

dma-bufs are for buffer sharing between devices, not limited to virtio.
You can't re-define that in some virtio-specific way.

> > Also note that "the DMA address of the buffer" is bonkers in virtio-gpu
> > context.  virtio-gpu resources are not required to be physically
> > contigous in memory, so typically you actually need a scatter list to
> > describe them.
> 
> There is no such requirement even on a bare metal system, see any
> system that has an IOMMU, which is typical on ARM/ARM64. The DMA
> address space must be contiguous only from the DMA master point of
> view.

Yes, the iommu (if present) could remap your scatterlist that way.  You
can't depend on that though.

What is the plan here?  Host-side buffer sharing I guess?  So you are
looking for some way to pass buffer handles from the guest to the host,
even in case those buffers are not created by your driver but imported
from somewhere else?

cheers,
  Gerd
