From: Gerd Hoffmann <kraxel@redhat.com>
Subject: Re: [PATCH v3 0/4] Support virtio cross-device resources
Date: Fri, 20 Mar 2020 07:48:30 +0100
Message-ID: <20200320064830.svdgh4xuxbxz6bc4@sirius.home.kraxel.org>
References: <20200311112004.47138-1-stevensd@chromium.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-media-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20200311112004.47138-1-stevensd@chromium.org>
Sender: linux-media-owner@vger.kernel.org
To: David Stevens <stevensd@chromium.org>
Cc: David Airlie <airlied@linux.ie>, Daniel Vetter <daniel@ffwll.ch>, "Michael S . Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>, Sumit Semwal <sumit.semwal@linaro.org>, Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org, virtualization@lists.linux-foundation.org, linux-media@vger.kernel.org, linaro-mm-sig@lists.linaro.org, virtio-dev@lists.oasis-open.org
List-Id: virtualization@lists.linuxfoundation.org

On Wed, Mar 11, 2020 at 08:20:00PM +0900, David Stevens wrote:
> This patchset implements the current proposal for virtio cross-device
> resource sharing [1], with minor changes based on recent comments. It
> is expected that this will be used to import virtio resources into the
> virtio-video driver currently under discussion [2].
> 
> This patchset adds a new hook to dma-buf, for querying the dma-buf's
> underlying virtio UUID. This hook is then plumbed through DRM PRIME
> buffers, and finally implemented in virtgpu.

Looks all fine to me.  We should wait for the virtio protocol update
(patch 3/4) being accepted into the virtio specification.  When this is
done I'll go commit this to drm-misc-next.

cheers,
  Gerd
