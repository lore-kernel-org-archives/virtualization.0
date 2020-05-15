From: Daniel Vetter <daniel@ffwll.ch>
Subject: Re: [PATCH v3 1/4] dma-buf: add support for virtio exported objects
Date: Fri, 15 May 2020 16:03:06 +0200
Message-ID: <20200515140306.GF206103@phenom.ffwll.local>
References: <20200311112004.47138-1-stevensd@chromium.org>
 <20200311112004.47138-2-stevensd@chromium.org>
 <CAKMK7uHFgiHLe9oiFBr-VR-6rU9-hLTpBTEVNh0ezyj54u70jw@mail.gmail.com>
 <CAD=HUj6k-y1=64zY8ZFOQBZ7WSUWiQfvkiTpXXt10JB_CGqk1A@mail.gmail.com>
 <20200514123007.GP206103@phenom.ffwll.local>
 <CAD=HUj7452eFfn9i=JWm54Mke3Lew-7AWYeoKZLAjCSg7eLO6A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <CAD=HUj7452eFfn9i=JWm54Mke3Lew-7AWYeoKZLAjCSg7eLO6A@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: David Stevens <stevensd@chromium.org>
Cc: Tomasz Figa <tfiga@chromium.org>, Gerd Hoffmann <kraxel@redhat.com>, David Airlie <airlied@linux.ie>, "Michael S . Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>, Sumit Semwal <sumit.semwal@linaro.org>, Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, dri-devel <dri-devel@lists.freedesktop.org>, "open list:VIRTIO CORE, NET..." <virtualization@lists.linux-foundation.org>, "open list:DMA BUFFER SHARING FRAMEWORK" <linux-media@vger.kernel.org>, "moderated list:DMA BUFFER SHARING FRAMEWORK" <linaro-mm-sig@lists.linaro.org>, virtio-dev@lists.oasis-open.org, Daniel Vetter <daniel@ffwll.ch>
List-Id: virtualization@lists.linuxfoundation.org

On Fri, May 15, 2020 at 02:07:06PM +0900, David Stevens wrote:
> On Thu, May 14, 2020 at 9:30 PM Daniel Vetter <daniel@ffwll.ch> wrote:
> > On Thu, May 14, 2020 at 05:19:40PM +0900, David Stevens wrote:
> > > Sorry for the duplicate reply, didn't notice this until now.
> > >
> > > > Just storing
> > > > the uuid should be doable (assuming this doesn't change during the
> > > > lifetime of the buffer), so no need for a callback.
> > >
> > > Directly storing the uuid doesn't work that well because of
> > > synchronization issues. The uuid needs to be shared between multiple
> > > virtio devices with independent command streams, so to prevent races
> > > between importing and exporting, the exporting driver can't share the
> > > uuid with other drivers until it knows that the device has finished
> > > registering the uuid. That requires a round trip to and then back from
> > > the device. Using a callback allows the latency from that round trip
> > > registration to be hidden.
> >
> > Uh, that means you actually do something and there's locking involved.
> > Makes stuff more complicated, invariant attributes are a lot easier
> > generally. Registering that uuid just always doesn't work, and blocking
> > when you're exporting?
> 
> Registering the id at creation and blocking in gem export is feasible,
> but it doesn't work well for systems with a centralized buffer
> allocator that doesn't support batch allocations (e.g. gralloc). In
> such a system, the round trip latency would almost certainly be
> included in the buffer allocation time. At least on the system I'm
> working on, I suspect that would add 10s of milliseconds of startup
> latency to video pipelines (although I haven't benchmarked the
> difference). Doing the blocking as late as possible means most or all
> of the latency can be hidden behind other pipeline setup work.
> 
> In terms of complexity, I think the synchronization would be basically
> the same in either approach, just in different locations. All it would
> do is alleviate the need for a callback to fetch the UUID.

Hm ok. I guess if we go with the older patch, where this all is a lot more
just code in virtio, doing an extra function to allocate the uuid sounds
fine. Then synchronization is entirely up to the virtio subsystem and not
a dma-buf problem (and hence not mine). You can use dma_resv_lock or so,
but no need to. But with callbacks potentially going both ways things
always get a bit interesting wrt locking - this is what makes peer2peer
dma-buf so painful right now. Hence I'd like to avoid that if needed, at
least at the dma-buf level. virtio code I don't mind what you do there :-)

Cheers, Daniel
-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
