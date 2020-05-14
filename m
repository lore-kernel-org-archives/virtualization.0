From: Daniel Vetter <daniel@ffwll.ch>
Subject: Re: [PATCH v3 1/4] dma-buf: add support for virtio exported objects
Date: Thu, 14 May 2020 14:30:07 +0200
Message-ID: <20200514123007.GP206103@phenom.ffwll.local>
References: <20200311112004.47138-1-stevensd@chromium.org>
 <20200311112004.47138-2-stevensd@chromium.org>
 <CAKMK7uHFgiHLe9oiFBr-VR-6rU9-hLTpBTEVNh0ezyj54u70jw@mail.gmail.com>
 <CAD=HUj6k-y1=64zY8ZFOQBZ7WSUWiQfvkiTpXXt10JB_CGqk1A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-media-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <CAD=HUj6k-y1=64zY8ZFOQBZ7WSUWiQfvkiTpXXt10JB_CGqk1A@mail.gmail.com>
Sender: linux-media-owner@vger.kernel.org
To: David Stevens <stevensd@chromium.org>
Cc: Daniel Vetter <daniel@ffwll.ch>, Tomasz Figa <tfiga@chromium.org>, Gerd Hoffmann <kraxel@redhat.com>, David Airlie <airlied@linux.ie>, "Michael S . Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>, Sumit Semwal <sumit.semwal@linaro.org>, Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, dri-devel <dri-devel@lists.freedesktop.org>, "open list:VIRTIO CORE, NET..." <virtualization@lists.linux-foundation.org>, "open list:DMA BUFFER SHARING FRAMEWORK" <linux-media@vger.kernel.org>, "moderated list:DMA BUFFER SHARING FRAMEWORK" <linaro-mm-sig@lists.linaro.org>, virtio-dev@lists.oasis-open.org
List-Id: virtualization@lists.linuxfoundation.org

On Thu, May 14, 2020 at 05:19:40PM +0900, David Stevens wrote:
> Sorry for the duplicate reply, didn't notice this until now.
> 
> > Just storing
> > the uuid should be doable (assuming this doesn't change during the
> > lifetime of the buffer), so no need for a callback.
> 
> Directly storing the uuid doesn't work that well because of
> synchronization issues. The uuid needs to be shared between multiple
> virtio devices with independent command streams, so to prevent races
> between importing and exporting, the exporting driver can't share the
> uuid with other drivers until it knows that the device has finished
> registering the uuid. That requires a round trip to and then back from
> the device. Using a callback allows the latency from that round trip
> registration to be hidden.

Uh, that means you actually do something and there's locking involved.
Makes stuff more complicated, invariant attributes are a lot easier
generally. Registering that uuid just always doesn't work, and blocking
when you're exporting?
-Daniel
-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
