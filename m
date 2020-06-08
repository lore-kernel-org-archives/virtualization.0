From: David Stevens <stevensd@chromium.org>
Subject: Re: [PATCH v3 4/4] drm/virtio: Support virtgpu exported resources
Date: Mon, 8 Jun 2020 19:36:55 +0900
Message-ID: <CAD=HUj6kF2JFyC9c0CY5_f-cv6r97501Z2f8D9x0VhQpRen+bw@mail.gmail.com>
References: <20200311112004.47138-1-stevensd@chromium.org> <20200311112004.47138-5-stevensd@chromium.org>
 <20200513123326-mutt-send-email-mst@kernel.org> <CAD=HUj5qcMLw__LfJizR6nzCR9Qmu21Sjk3i0j_8+=rxt1Hk=w@mail.gmail.com>
 <20200608054234-mutt-send-email-mst@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <virtio-dev-return-7451-gcvd-virtio-dev=m.gmane-mx.org@lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
In-Reply-To: <20200608054234-mutt-send-email-mst@kernel.org>
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Gerd Hoffmann <kraxel@redhat.com>, David Airlie <airlied@linux.ie>, Daniel Vetter <daniel@ffwll.ch>, Jason Wang <jasowang@redhat.com>, Sumit Semwal <sumit.semwal@linaro.org>, Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, open list <linux-kernel@vger.kernel.org>, ML dri-devel <dri-devel@lists.freedesktop.org>, "open list:VIRTIO GPU DRIVER" <virtualization@lists.linux-foundation.org>, Linux Media Mailing List <linux-media@vger.kernel.org>, "moderated list:DMA BUFFER SHARING FRAMEWORK" <linaro-mm-sig@lists.linaro.org>, virtio-dev@lists.oasis-open.org
List-Id: virtualization@lists.linuxfoundation.org

On Mon, Jun 8, 2020 at 6:43 PM Michael S. Tsirkin <mst@redhat.com> wrote:
>
> On Fri, May 15, 2020 at 04:26:15PM +0900, David Stevens wrote:
> > > > +     if (virtio_has_feature(vgdev->vdev, VIRTIO_GPU_F_RESOURCE_UUID)) {
> > > > +             vgdev->has_resource_assign_uuid = true;
> > > > +     }
> > >
> > >
> > > Just a question: this relies on DMA bufs so I assume it is
> > > not really assumed to work when DMA API is bypassed, right?
> > > Rather than worry what does it mean, how about just
> > > disabling  this feature without PLATFORM_DMA for now?
> >
> > By PLATFORM_DMA, do you mean CONFIG_DMA_SHARED_BUFFER?
>
> Sorry, no. I mean VIRTIO_F_IOMMU_PLATFORM which in the
> future will be renamed to VIRTIO_F_PLATFORM_ACCESS.

Shouldn't things work independent of whether or not that feature is
set? If a virtio driver properly uses the dma_buf APIs (which virtgpu
seems to), then that should take care of any mapping/synchronization
related to VIRTIO_F_IOMMU_PLATFORM. If anything, the case where
VIRTIO_F_IOMMU_PLATFORM isn't set is easier, since then we know that
the "the device has same access [sic] to memory addresses supplied to
it as the driver has", according to the specification.

-David
