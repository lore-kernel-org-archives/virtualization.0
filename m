From: Guillaume Gardet <Guillaume.Gardet@arm.com>
Subject: RE: [PATCH v5 2/3] drm/virtio: fix mmap page attributes
Date: Wed, 26 Feb 2020 16:52:22 +0000
Message-ID: <VI1PR0802MB223736CC0A877F9219E8B86383EA0@VI1PR0802MB2237.eurprd08.prod.outlook.com>
References: <20200226154752.24328-1-kraxel@redhat.com>
 <20200226154752.24328-3-kraxel@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Return-path: <stable-owner@vger.kernel.org>
In-Reply-To: <20200226154752.24328-3-kraxel@redhat.com>
Content-Language: en-US
Sender: stable-owner@vger.kernel.org
To: Gerd Hoffmann <kraxel@redhat.com>, "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>
Cc: "tzimmermann@suse.de" <tzimmermann@suse.de>, "gurchetansingh@chromium.org" <gurchetansingh@chromium.org>, "olvaffe@gmail.com" <olvaffe@gmail.com>, "stable@vger.kernel.org" <stable@vger.kernel.org>, David Airlie <airlied@linux.ie>, Daniel Vetter <daniel.vetter@ffwll.ch>, "open list:VIRTIO GPU DRIVER" <virtualization@lists.linux-foundation.org>, open list <linux-kernel@vger.kernel.org>
List-Id: virtualization@lists.linuxfoundation.org



> -----Original Message-----
> From: Gerd Hoffmann <kraxel@redhat.com>
> Sent: 26 February 2020 16:48
> To: dri-devel@lists.freedesktop.org
> Cc: tzimmermann@suse.de; gurchetansingh@chromium.org; olvaffe@gmail.com;
> Guillaume Gardet <Guillaume.Gardet@arm.com>; Gerd Hoffmann
> <kraxel@redhat.com>; stable@vger.kernel.org; David Airlie <airlied@linux.=
ie>;
> Daniel Vetter <daniel.vetter@ffwll.ch>; open list:VIRTIO GPU DRIVER
> <virtualization@lists.linux-foundation.org>; open list <linux-
> kernel@vger.kernel.org>
> Subject: [PATCH v5 2/3] drm/virtio: fix mmap page attributes
>
> virtio-gpu uses cached mappings, set
> drm_gem_shmem_object.map_cached accordingly.
>
> Cc: stable@vger.kernel.org
> Fixes: c66df701e783 ("drm/virtio: switch from ttm to gem shmem helpers")
> Reported-by: Gurchetan Singh <gurchetansingh@chromium.org>
> Reported-by: Guillaume Gardet <Guillaume.Gardet@arm.com>
> Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>

Tested-by: Guillaume Gardet <Guillaume.Gardet@arm.com>

> ---
>  drivers/gpu/drm/virtio/virtgpu_object.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/drivers/gpu/drm/virtio/virtgpu_object.c
> b/drivers/gpu/drm/virtio/virtgpu_object.c
> index 3d2a6d489bfc..59319435218f 100644
> --- a/drivers/gpu/drm/virtio/virtgpu_object.c
> +++ b/drivers/gpu/drm/virtio/virtgpu_object.c
> @@ -119,6 +119,7 @@ struct drm_gem_object *virtio_gpu_create_object(struc=
t
> drm_device *dev,
>  return NULL;
>
>  bo->base.base.funcs =3D &virtio_gpu_gem_funcs;
> +bo->base.map_cached =3D true;
>  return &bo->base.base;
>  }
>
> --
> 2.18.2

IMPORTANT NOTICE: The contents of this email and any attachments are confid=
ential and may also be privileged. If you are not the intended recipient, p=
lease notify the sender immediately and do not disclose the contents to any=
 other person, use it for any purpose, or store or copy the information in =
any medium. Thank you.
