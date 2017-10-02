From: Daniel Vetter <daniel@ffwll.ch>
Subject: Re: [PATCH] drm/virtio: Replace instances of reference/unreference
	with get/put
Date: Mon, 2 Oct 2017 09:49:07 +0200
Message-ID: <20171002074907.hdhmnqkuo2deceoa__16923.824864398$1506930576$gmane$org@phenom.ffwll.local>
References: <1506679419-7130-1-git-send-email-srishtishar@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <1506679419-7130-1-git-send-email-srishtishar@gmail.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Srishti Sharma <srishtishar@gmail.com>
Cc: daniel.vetter@ffwll.ch, linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org, virtualization@lists.linux-foundation.org, outreachy-kernel@googlegroups.com, seanpaul@chromium.org
List-Id: virtualization@lists.linuxfoundation.org

On Fri, Sep 29, 2017 at 03:33:39PM +0530, Srishti Sharma wrote:
> Replace reference/unreference with get/put as it is consistent
> with the kernel coding style. Done using the following semantic
> patch by coccinelle.
> 
> @r@
> expression e;
> @@
> 
> -drm_gem_object_unreference_unlocked(e);
> +drm_gem_object_put_unlocked(e);
> 
> Signed-off-by: Srishti Sharma <srishtishar@gmail.com>

Applied to drm-misc-next, thanks.
-Daniel

> ---
>  drivers/gpu/drm/virtio/virtgpu_display.c |  4 ++--
>  drivers/gpu/drm/virtio/virtgpu_gem.c     |  4 ++--
>  drivers/gpu/drm/virtio/virtgpu_ioctl.c   | 12 ++++++------
>  3 files changed, 10 insertions(+), 10 deletions(-)
> 
> diff --git a/drivers/gpu/drm/virtio/virtgpu_display.c b/drivers/gpu/drm/virtio/virtgpu_display.c
> index b6d5205..41b0930 100644
> --- a/drivers/gpu/drm/virtio/virtgpu_display.c
> +++ b/drivers/gpu/drm/virtio/virtgpu_display.c
> @@ -53,7 +53,7 @@ static void virtio_gpu_user_framebuffer_destroy(struct drm_framebuffer *fb)
>  	struct virtio_gpu_framebuffer *virtio_gpu_fb
>  		= to_virtio_gpu_framebuffer(fb);
>  
> -	drm_gem_object_unreference_unlocked(virtio_gpu_fb->obj);
> +	drm_gem_object_put_unlocked(virtio_gpu_fb->obj);
>  	drm_framebuffer_cleanup(fb);
>  	kfree(virtio_gpu_fb);
>  }
> @@ -327,7 +327,7 @@ virtio_gpu_user_framebuffer_create(struct drm_device *dev,
>  	ret = virtio_gpu_framebuffer_init(dev, virtio_gpu_fb, mode_cmd, obj);
>  	if (ret) {
>  		kfree(virtio_gpu_fb);
> -		drm_gem_object_unreference_unlocked(obj);
> +		drm_gem_object_put_unlocked(obj);
>  		return NULL;
>  	}
>  
> diff --git a/drivers/gpu/drm/virtio/virtgpu_gem.c b/drivers/gpu/drm/virtio/virtgpu_gem.c
> index 72ad7b1..92fb277 100644
> --- a/drivers/gpu/drm/virtio/virtgpu_gem.c
> +++ b/drivers/gpu/drm/virtio/virtgpu_gem.c
> @@ -72,7 +72,7 @@ int virtio_gpu_gem_create(struct drm_file *file,
>  	*obj_p = &obj->gem_base;
>  
>  	/* drop reference from allocate - handle holds it now */
> -	drm_gem_object_unreference_unlocked(&obj->gem_base);
> +	drm_gem_object_put_unlocked(&obj->gem_base);
>  
>  	*handle_p = handle;
>  	return 0;
> @@ -130,7 +130,7 @@ int virtio_gpu_mode_dumb_mmap(struct drm_file *file_priv,
>  		return -ENOENT;
>  	obj = gem_to_virtio_gpu_obj(gobj);
>  	*offset_p = virtio_gpu_object_mmap_offset(obj);
> -	drm_gem_object_unreference_unlocked(gobj);
> +	drm_gem_object_put_unlocked(gobj);
>  	return 0;
>  }
>  
> diff --git a/drivers/gpu/drm/virtio/virtgpu_ioctl.c b/drivers/gpu/drm/virtio/virtgpu_ioctl.c
> index b94bd54..0528edb 100644
> --- a/drivers/gpu/drm/virtio/virtgpu_ioctl.c
> +++ b/drivers/gpu/drm/virtio/virtgpu_ioctl.c
> @@ -86,7 +86,7 @@ static void virtio_gpu_unref_list(struct list_head *head)
>  		bo = buf->bo;
>  		qobj = container_of(bo, struct virtio_gpu_object, tbo);
>  
> -		drm_gem_object_unreference_unlocked(&qobj->gem_base);
> +		drm_gem_object_put_unlocked(&qobj->gem_base);
>  	}
>  }
>  
> @@ -304,7 +304,7 @@ static int virtio_gpu_resource_create_ioctl(struct drm_device *dev, void *data,
>  		}
>  		return ret;
>  	}
> -	drm_gem_object_unreference_unlocked(obj);
> +	drm_gem_object_put_unlocked(obj);
>  
>  	rc->res_handle = res_id; /* similiar to a VM address */
>  	rc->bo_handle = handle;
> @@ -341,7 +341,7 @@ static int virtio_gpu_resource_info_ioctl(struct drm_device *dev, void *data,
>  
>  	ri->size = qobj->gem_base.size;
>  	ri->res_handle = qobj->hw_res_handle;
> -	drm_gem_object_unreference_unlocked(gobj);
> +	drm_gem_object_put_unlocked(gobj);
>  	return 0;
>  }
>  
> @@ -389,7 +389,7 @@ static int virtio_gpu_transfer_from_host_ioctl(struct drm_device *dev,
>  out_unres:
>  	virtio_gpu_object_unreserve(qobj);
>  out:
> -	drm_gem_object_unreference_unlocked(gobj);
> +	drm_gem_object_put_unlocked(gobj);
>  	return ret;
>  }
>  
> @@ -439,7 +439,7 @@ static int virtio_gpu_transfer_to_host_ioctl(struct drm_device *dev, void *data,
>  out_unres:
>  	virtio_gpu_object_unreserve(qobj);
>  out:
> -	drm_gem_object_unreference_unlocked(gobj);
> +	drm_gem_object_put_unlocked(gobj);
>  	return ret;
>  }
>  
> @@ -462,7 +462,7 @@ static int virtio_gpu_wait_ioctl(struct drm_device *dev, void *data,
>  		nowait = true;
>  	ret = virtio_gpu_object_wait(qobj, nowait);
>  
> -	drm_gem_object_unreference_unlocked(gobj);
> +	drm_gem_object_put_unlocked(gobj);
>  	return ret;
>  }
>  
> -- 
> 2.7.4
> 

-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
