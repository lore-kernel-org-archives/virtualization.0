From: Gerd Hoffmann <kraxel@redhat.com>
Subject: Re: [PATCH] drm/virtio: fix ring free check
Date: Fri, 7 Feb 2020 07:46:30 +0100
Message-ID: <20200207064630.6p35spqres676cpq@sirius.home.kraxel.org>
References: <20200206111416.31269-1-kraxel@redhat.com>
 <CAPaKu7Tfp-thov9xCe-Gbq1zZe_uvDAno8SV_3tc=tU0gse=uA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <CAPaKu7Tfp-thov9xCe-Gbq1zZe_uvDAno8SV_3tc=tU0gse=uA@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Chia-I Wu <olvaffe@gmail.com>
Cc: ML dri-devel <dri-devel@lists.freedesktop.org>, Gurchetan Singh <gurchetansingh@chromium.org>, David Airlie <airlied@linux.ie>, Daniel Vetter <daniel@ffwll.ch>, "open list:VIRTIO GPU DRIVER" <virtualization@lists.linux-foundation.org>, open list <linux-kernel@vger.kernel.org>
List-Id: virtualization@lists.linuxfoundation.org

  Hi,

> > +       indirect = virtio_has_feature(vgdev->vdev, VIRTIO_RING_F_INDIRECT_DESC);
> > +       vqcnt = indirect ? 1 : elemcnt;
> Is the feature dynamic and require the lock held?  If not, the result
> can be cached and the fixup can happen before grabbing the lock

Not dynamic, so yes, caching makes sense.

cheers,
  Gerd
