From: Felix Kuehling <felix.kuehling-5C7GfCeVMHo@public.gmane.org>
Subject: Re: [PATCH 1/6] amdgpu: a NULL ->mm does not mean a thread is a
 kthread
Date: Mon, 6 Apr 2020 12:07:18 -0400
Message-ID: <b5eaf9dd-fc20-cf56-9efb-e6be848964bf@amd.com>
References: <20200404094101.672954-1-hch@lst.de>
 <20200404094101.672954-2-hch@lst.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20200404094101.672954-2-hch-jcswGhMUV9g@public.gmane.org>
Content-Language: en-US
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Christoph Hellwig <hch-jcswGhMUV9g@public.gmane.org>, Linus Torvalds <torvalds-de/tnXTf+JLsfHDXvbKv3WD2FQJk+8+b@public.gmane.org>, Andrew Morton <akpm-de/tnXTf+JLsfHDXvbKv3WD2FQJk+8+b@public.gmane.org>
Cc: Al Viro <viro-RmSDqhL/yNMiFSDQTTA3OLVCufUGDwFn@public.gmane.org>, Alex Deucher <alexander.deucher-5C7GfCeVMHo@public.gmane.org>, Zhenyu Wang <zhenyuw-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>, Zhi Wang <zhi.a.wang-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, Felipe Balbi <balbi-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, "Michael S. Tsirkin" <mst-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>, Jason Wang <jasowang-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>, Jens Axboe <axboe-tSWWG44O7X1aa/9Udqfwiw@public.gmane.org>, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org, intel-gvt-dev-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org, intel-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, virtualization-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, linux-fsdevel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, io-uring-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-mm-Bw31MaZKKs3YtjvyW6yDsg@public.gmane.org
List-Id: virtualization@lists.linuxfoundation.org

Am 2020-04-04 um 5:40 a.m. schrieb Christoph Hellwig:
> Use the proper API instead.
>
> Fixes: 70539bd795002 ("drm/amd: Update MEC HQD loading code for KFD")
> Signed-off-by: Christoph Hellwig <hch-jcswGhMUV9g@public.gmane.org>

Reviewed-by: Felix Kuehling <Felix.Kuehling-5C7GfCeVMHo@public.gmane.org>


> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h
> index 13feb313e9b3..4db143c19dcc 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h
> @@ -190,7 +190,7 @@ uint8_t amdgpu_amdkfd_get_xgmi_hops_count(struct kgd_dev *dst, struct kgd_dev *s
>  			pagefault_disable();				\
>  			if ((mmptr) == current->mm) {			\
>  				valid = !get_user((dst), (wptr));	\
> -			} else if (current->mm == NULL) {		\
> +			} else if (current->flags & PF_KTHREAD) {	\
>  				use_mm(mmptr);				\
>  				valid = !get_user((dst), (wptr));	\
>  				unuse_mm(mmptr);			\
