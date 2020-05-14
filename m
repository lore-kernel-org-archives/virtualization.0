From: Gerd Hoffmann <kraxel@redhat.com>
Subject: Re: [PATCH v3 1/4] dma-buf: add support for virtio exported objects
Date: Thu, 14 May 2020 09:59:52 +0200
Message-ID: <20200514075952.zuc3zjtmasaqrw75@sirius.home.kraxel.org>
References: <20200311112004.47138-1-stevensd@chromium.org>
 <20200311112004.47138-2-stevensd@chromium.org>
 <CAKMK7uHFgiHLe9oiFBr-VR-6rU9-hLTpBTEVNh0ezyj54u70jw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-media-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <CAKMK7uHFgiHLe9oiFBr-VR-6rU9-hLTpBTEVNh0ezyj54u70jw@mail.gmail.com>
Sender: linux-media-owner@vger.kernel.org
To: Daniel Vetter <daniel@ffwll.ch>
Cc: David Stevens <stevensd@chromium.org>, Tomasz Figa <tfiga@chromium.org>, David Airlie <airlied@linux.ie>, "Michael S . Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>, Sumit Semwal <sumit.semwal@linaro.org>, Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, dri-devel <dri-devel@lists.freedesktop.org>, "open list:VIRTIO CORE, NET..." <virtualization@lists.linux-foundation.org>, "open list:DMA BUFFER SHARING FRAMEWORK" <linux-media@vger.kernel.org>, "moderated list:DMA BUFFER SHARING FRAMEWORK" <linaro-mm-sig@lists.linaro.org>, virtio-dev@lists.oasis-open.org
List-Id: virtualization@lists.linuxfoundation.org

  Hi,

> - for the runtime upcasting the usual approach is to check the ->ops
> pointer. Which means that would need to be the same for all virtio
> dma_bufs, which might get a bit awkward. But I'd really prefer we not
> add allocator specific stuff like this to dma-buf.

This is exactly the problem, it gets messy quickly, also when it comes
to using the drm_prime.c helpers ...

take care,
  Gerd
