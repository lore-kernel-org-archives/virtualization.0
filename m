From: Gerd Hoffmann <kraxel@redhat.com>
Subject: Re: [PATCH v2 4/4] drm/virtio: Support virtgpu exported resources
Date: Wed, 4 Mar 2020 09:01:19 +0100
Message-ID: <20200304080119.i55opxkhk4kdt4hp@sirius.home.kraxel.org>
References: <20200302121524.7543-1-stevensd@chromium.org>
 <20200302121524.7543-5-stevensd@chromium.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-media-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20200302121524.7543-5-stevensd@chromium.org>
Sender: linux-media-owner@vger.kernel.org
To: David Stevens <stevensd@chromium.org>
Cc: David Airlie <airlied@linux.ie>, Daniel Vetter <daniel@ffwll.ch>, "Michael S . Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>, Sumit Semwal <sumit.semwal@linaro.org>, Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org, virtualization@lists.linux-foundation.org, linux-media@vger.kernel.org, linaro-mm-sig@lists.linaro.org, virtio-dev@lists.oasis-open.org
List-Id: virtualization@lists.linuxfoundation.org

  Hi,

> +	if (vgdev->has_resource_assign_uuid) {
> +		spin_lock(&vgdev->resource_export_lock);
> +		if (bo->uuid_state == UUID_NOT_INITIALIZED) {
> +			bo->uuid_state = UUID_INITIALIZING;
> +			needs_init = true;
> +		}
> +		spin_unlock(&vgdev->resource_export_lock);
> +
> +		if (needs_init) {
> +			ret = virtio_gpu_cmd_resource_assign_uuid(vgdev, bo);

You can submit a fenced command, then wait on the fence here.  Removes
the need for UUID_INITIALIZING.

Also note that this function will be called only once, on the first
export.  When exporting the same object again drm will simply reuse
the existing dmabuf.  You can drop UUID_NOT_INITIALIZED and needs_init.

So you are left with only two uuid_state states.  You could turn uuid
into a pointer, so it gets only allocated when needed.  Also uuid ==
NULL can be used for "uuid not available" then.

cheers,
  Gerd
