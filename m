From: David Stevens <stevensd@chromium.org>
Subject: Re: [PATCH v3 4/4] drm/virtio: Support virtgpu exported resources
Date: Fri, 15 May 2020 16:26:15 +0900
Message-ID: <CAD=HUj5qcMLw__LfJizR6nzCR9Qmu21Sjk3i0j_8+=rxt1Hk=w@mail.gmail.com>
References: <20200311112004.47138-1-stevensd@chromium.org> <20200311112004.47138-5-stevensd@chromium.org>
 <20200513123326-mutt-send-email-mst@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <virtio-dev-return-7345-gcvd-virtio-dev=m.gmane-mx.org@lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
In-Reply-To: <20200513123326-mutt-send-email-mst@kernel.org>
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Gerd Hoffmann <kraxel@redhat.com>, David Airlie <airlied@linux.ie>, Daniel Vetter <daniel@ffwll.ch>, Jason Wang <jasowang@redhat.com>, Sumit Semwal <sumit.semwal@linaro.org>, Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, open list <linux-kernel@vger.kernel.org>, ML dri-devel <dri-devel@lists.freedesktop.org>, "open list:VIRTIO GPU DRIVER" <virtualization@lists.linux-foundation.org>, Linux Media Mailing List <linux-media@vger.kernel.org>, "moderated list:DMA BUFFER SHARING FRAMEWORK" <linaro-mm-sig@lists.linaro.org>, virtio-dev@lists.oasis-open.org
List-Id: virtualization@lists.linuxfoundation.org

> > +     if (virtio_has_feature(vgdev->vdev, VIRTIO_GPU_F_RESOURCE_UUID)) {
> > +             vgdev->has_resource_assign_uuid = true;
> > +     }
>
>
> Just a question: this relies on DMA bufs so I assume it is
> not really assumed to work when DMA API is bypassed, right?
> Rather than worry what does it mean, how about just
> disabling  this feature without PLATFORM_DMA for now?

By PLATFORM_DMA, do you mean CONFIG_DMA_SHARED_BUFFER? Virtio-gpu
depends on DRM, which selects that feature. So I think DMA bufs should
always be available when virtio-gpu is present.

-David
