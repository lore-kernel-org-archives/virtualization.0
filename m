From: Gerd Hoffmann <kraxel@redhat.com>
Subject: Re: [PATCH 2/2] drm/virtio: Support virtgpu exported resources
Date: Tue, 25 Feb 2020 07:15:38 +0100
Message-ID: <20200225061538.2qlkhfbhv2pl3oku@sirius.home.kraxel.org>
References: <20200219080637.61312-1-stevensd@chromium.org>
 <20200219080637.61312-3-stevensd@chromium.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-media-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20200219080637.61312-3-stevensd@chromium.org>
Sender: linux-media-owner@vger.kernel.org
To: David Stevens <stevensd@chromium.org>
Cc: David Airlie <airlied@linux.ie>, Daniel Vetter <daniel@ffwll.ch>, "Michael S . Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>, Sumit Semwal <sumit.semwal@linaro.org>, linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org, virtualization@lists.linux-foundation.org, linux-media@vger.kernel.org, linaro-mm-sig@lists.linaro.org, virtio-dev@lists.oasis-open.org
List-Id: virtualization@lists.linuxfoundation.org

  Hi,

> +struct dma_buf *virtgpu_gem_prime_export(struct drm_gem_object *obj,
> +					 int flags)
> +{
[ ... ]
> +}
> +
> +struct drm_gem_object *virtgpu_gem_prime_import(struct drm_device *dev,
> +						struct dma_buf *buf)
> +{
[ ... ]
> +}

More code duplication.

> diff --git a/include/uapi/linux/virtio_gpu.h b/include/uapi/linux/virtio_gpu.h
> index 0c85914d9369..9c428ef03060 100644
> --- a/include/uapi/linux/virtio_gpu.h
> +++ b/include/uapi/linux/virtio_gpu.h

API change should go to a separate patch.

> +/*
> + * VIRTIO_GPU_CMD_RESOURCE_ASSIGN_UUID
> + */
> +#define VIRTIO_GPU_F_CROSS_DEVICE        2

Hmm, how about VIRTIO_GPU_F_RESOURCE_UUID ?

> @@ -87,6 +92,7 @@ enum virtio_gpu_ctrl_type {
>  	VIRTIO_GPU_RESP_OK_CAPSET_INFO,
>  	VIRTIO_GPU_RESP_OK_CAPSET,
>  	VIRTIO_GPU_RESP_OK_EDID,
> +	VIRTIO_GPU_RESP_OK_RESOURCE_ASSIGN_UUID,

The "assign" doesn't make sense in the reply.  I'd name that
VIRTIO_GPU_RESP_OK_RESOURCE_UUID or just VIRTIO_GPU_RESP_OK_UUID,

> +/* VIRTIO_GPU_RESP_OK_RESOURCE_ASSIGN_UUID */
> +struct virtio_gpu_resp_resource_assign_uuid {
> +	struct virtio_gpu_ctrl_hdr hdr;
> +	__u8 uuid[16];
> +};

Same here.

cheers,
  Gerd
