From: Daniel Vetter <daniel@ffwll.ch>
Subject: Re: [PATCH v3 1/4] dma-buf: add support for virtio exported objects
Date: Thu, 14 May 2020 14:31:11 +0200
Message-ID: <20200514123111.GQ206103@phenom.ffwll.local>
References: <20200311112004.47138-1-stevensd@chromium.org>
 <20200311112004.47138-2-stevensd@chromium.org>
 <CAKMK7uHFgiHLe9oiFBr-VR-6rU9-hLTpBTEVNh0ezyj54u70jw@mail.gmail.com>
 <20200514075952.zuc3zjtmasaqrw75@sirius.home.kraxel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20200514075952.zuc3zjtmasaqrw75@sirius.home.kraxel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Gerd Hoffmann <kraxel@redhat.com>
Cc: Daniel Vetter <daniel@ffwll.ch>, David Stevens <stevensd@chromium.org>, Tomasz Figa <tfiga@chromium.org>, David Airlie <airlied@linux.ie>, "Michael S . Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>, Sumit Semwal <sumit.semwal@linaro.org>, Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, dri-devel <dri-devel@lists.freedesktop.org>, "open list:VIRTIO CORE, NET..." <virtualization@lists.linux-foundation.org>, "open list:DMA BUFFER SHARING FRAMEWORK" <linux-media@vger.kernel.org>, "moderated list:DMA BUFFER SHARING FRAMEWORK" <linaro-mm-sig@lists.linaro.org>, virtio-dev@lists.oasis-open.org
List-Id: virtualization@lists.linuxfoundation.org

On Thu, May 14, 2020 at 09:59:52AM +0200, Gerd Hoffmann wrote:
>   Hi,
> 
> > - for the runtime upcasting the usual approach is to check the ->ops
> > pointer. Which means that would need to be the same for all virtio
> > dma_bufs, which might get a bit awkward. But I'd really prefer we not
> > add allocator specific stuff like this to dma-buf.
> 
> This is exactly the problem, it gets messy quickly, also when it comes
> to using the drm_prime.c helpers ...

drm_prime.c helpers (not the core bits) exist becaues nvidia needed
something that wasnt EXPORT_SYMBOL_GPL.

I wouldn't shed a big tear if they don't fit anymore, they're kinda not
great to begin with. Much midlayer, not much of valued added, but at least
the _GPL is gone.
-Daniel
-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
