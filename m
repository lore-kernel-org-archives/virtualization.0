From: Daniel Vetter <daniel@ffwll.ch>
Subject: Re: [Outreachy kernel] [PATCH] drm/qxl: Replace
	drm_gem_object_reference/unreference() with _get/put()
Date: Wed, 21 Mar 2018 09:20:08 +0100
Message-ID: <20180321082008.GX14155__3135.72424133799$1521620295$gmane$org@phenom.ffwll.local>
References: <1521570567-22519-1-git-send-email-santhameena13@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <1521570567-22519-1-git-send-email-santhameena13@gmail.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Santha Meena Ramamoorthy <santhameena13@gmail.com>
Cc: airlied@linux.ie, linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org, virtualization@lists.linux-foundation.org, outreachy-kernel@googlegroups.com, seanpaul@chromium.org, daniel.vetter@intel.com, airlied@redhat.com
List-Id: virtualization@lists.linuxfoundation.org

On Tue, Mar 20, 2018 at 11:29:27AM -0700, Santha Meena Ramamoorthy wrote:
> Replace drm_gem_object_reference/unreference function with *_get/put()
> suffixes, because it is shorter and consistent with the kernel
> kref_get/put() functions. The following Coccinelle script was used:
> 
> @@
> expression e;
> @@
> 
> (
> -drm_gem_object_reference(e);
> +drm_gem_object_get(e);
> |
> -drm_gem_object_unreference(e);
> +drm_gem_object_put(e);
> |
> -drm_gem_object_unreference_unlocked(e);
> +drm_gem_object_put_unlocked(e);
> )
> 
> Signed-off-by: Santha Meena Ramamoorthy <santhameena13@gmail.com>

lgtm, thanks for your patch. Applied to drm-misc-next.
-Daniel

> ---
>  drivers/gpu/drm/qxl/qxl_display.c | 4 ++--
>  drivers/gpu/drm/qxl/qxl_dumb.c    | 2 +-
>  drivers/gpu/drm/qxl/qxl_fb.c      | 6 +++---
>  drivers/gpu/drm/qxl/qxl_gem.c     | 2 +-
>  drivers/gpu/drm/qxl/qxl_ioctl.c   | 4 ++--
>  drivers/gpu/drm/qxl/qxl_object.c  | 6 +++---
>  6 files changed, 12 insertions(+), 12 deletions(-)
> 
> diff --git a/drivers/gpu/drm/qxl/qxl_display.c b/drivers/gpu/drm/qxl/qxl_display.c
> index 9a9214a..ecb35ed 100644
> --- a/drivers/gpu/drm/qxl/qxl_display.c
> +++ b/drivers/gpu/drm/qxl/qxl_display.c
> @@ -309,7 +309,7 @@ void qxl_user_framebuffer_destroy(struct drm_framebuffer *fb)
>  	struct qxl_bo *bo = gem_to_qxl_bo(qxl_fb->obj);
>  
>  	WARN_ON(bo->shadow);
> -	drm_gem_object_unreference_unlocked(qxl_fb->obj);
> +	drm_gem_object_put_unlocked(qxl_fb->obj);
>  	drm_framebuffer_cleanup(fb);
>  	kfree(qxl_fb);
>  }
> @@ -1215,7 +1215,7 @@ qxl_user_framebuffer_create(struct drm_device *dev,
>  	ret = qxl_framebuffer_init(dev, qxl_fb, mode_cmd, obj, &qxl_fb_funcs);
>  	if (ret) {
>  		kfree(qxl_fb);
> -		drm_gem_object_unreference_unlocked(obj);
> +		drm_gem_object_put_unlocked(obj);
>  		return NULL;
>  	}
>  
> diff --git a/drivers/gpu/drm/qxl/qxl_dumb.c b/drivers/gpu/drm/qxl/qxl_dumb.c
> index 11085ab..c666b89 100644
> --- a/drivers/gpu/drm/qxl/qxl_dumb.c
> +++ b/drivers/gpu/drm/qxl/qxl_dumb.c
> @@ -82,6 +82,6 @@ int qxl_mode_dumb_mmap(struct drm_file *file_priv,
>  		return -ENOENT;
>  	qobj = gem_to_qxl_bo(gobj);
>  	*offset_p = qxl_bo_mmap_offset(qobj);
> -	drm_gem_object_unreference_unlocked(gobj);
> +	drm_gem_object_put_unlocked(gobj);
>  	return 0;
>  }
> diff --git a/drivers/gpu/drm/qxl/qxl_fb.c b/drivers/gpu/drm/qxl/qxl_fb.c
> index 23af3e3..3388914 100644
> --- a/drivers/gpu/drm/qxl/qxl_fb.c
> +++ b/drivers/gpu/drm/qxl/qxl_fb.c
> @@ -95,7 +95,7 @@ static void qxlfb_destroy_pinned_object(struct drm_gem_object *gobj)
>  	qxl_bo_kunmap(qbo);
>  	qxl_bo_unpin(qbo);
>  
> -	drm_gem_object_unreference_unlocked(gobj);
> +	drm_gem_object_put_unlocked(gobj);
>  }
>  
>  int qxl_get_handle_for_primary_fb(struct qxl_device *qdev,
> @@ -316,11 +316,11 @@ static int qxlfb_create(struct qxl_fbdev *qfbdev,
>  		qxl_bo_unpin(qbo);
>  	}
>  	if (fb && ret) {
> -		drm_gem_object_unreference_unlocked(gobj);
> +		drm_gem_object_put_unlocked(gobj);
>  		drm_framebuffer_cleanup(fb);
>  		kfree(fb);
>  	}
> -	drm_gem_object_unreference_unlocked(gobj);
> +	drm_gem_object_put_unlocked(gobj);
>  	return ret;
>  }
>  
> diff --git a/drivers/gpu/drm/qxl/qxl_gem.c b/drivers/gpu/drm/qxl/qxl_gem.c
> index 85f5467..f5c1e78 100644
> --- a/drivers/gpu/drm/qxl/qxl_gem.c
> +++ b/drivers/gpu/drm/qxl/qxl_gem.c
> @@ -98,7 +98,7 @@ int qxl_gem_object_create_with_handle(struct qxl_device *qdev,
>  		return r;
>  	/* drop reference from allocate - handle holds it now */
>  	*qobj = gem_to_qxl_bo(gobj);
> -	drm_gem_object_unreference_unlocked(gobj);
> +	drm_gem_object_put_unlocked(gobj);
>  	return 0;
>  }
>  
> diff --git a/drivers/gpu/drm/qxl/qxl_ioctl.c b/drivers/gpu/drm/qxl/qxl_ioctl.c
> index e8c0b10..e238a1a 100644
> --- a/drivers/gpu/drm/qxl/qxl_ioctl.c
> +++ b/drivers/gpu/drm/qxl/qxl_ioctl.c
> @@ -121,7 +121,7 @@ static int qxlhw_handle_to_bo(struct drm_file *file_priv, uint64_t handle,
>  	qobj = gem_to_qxl_bo(gobj);
>  
>  	ret = qxl_release_list_add(release, qobj);
> -	drm_gem_object_unreference_unlocked(gobj);
> +	drm_gem_object_put_unlocked(gobj);
>  	if (ret)
>  		return ret;
>  
> @@ -343,7 +343,7 @@ static int qxl_update_area_ioctl(struct drm_device *dev, void *data,
>  	qxl_bo_unreserve(qobj);
>  
>  out:
> -	drm_gem_object_unreference_unlocked(gobj);
> +	drm_gem_object_put_unlocked(gobj);
>  	return ret;
>  }
>  
> diff --git a/drivers/gpu/drm/qxl/qxl_object.c b/drivers/gpu/drm/qxl/qxl_object.c
> index f6b80fe..e9fb0ab 100644
> --- a/drivers/gpu/drm/qxl/qxl_object.c
> +++ b/drivers/gpu/drm/qxl/qxl_object.c
> @@ -211,13 +211,13 @@ void qxl_bo_unref(struct qxl_bo **bo)
>  	if ((*bo) == NULL)
>  		return;
>  
> -	drm_gem_object_unreference_unlocked(&(*bo)->gem_base);
> +	drm_gem_object_put_unlocked(&(*bo)->gem_base);
>  	*bo = NULL;
>  }
>  
>  struct qxl_bo *qxl_bo_ref(struct qxl_bo *bo)
>  {
> -	drm_gem_object_reference(&bo->gem_base);
> +	drm_gem_object_get(&bo->gem_base);
>  	return bo;
>  }
>  
> @@ -318,7 +318,7 @@ void qxl_bo_force_delete(struct qxl_device *qdev)
>  		list_del_init(&bo->list);
>  		mutex_unlock(&qdev->gem.mutex);
>  		/* this should unref the ttm bo */
> -		drm_gem_object_unreference_unlocked(&bo->gem_base);
> +		drm_gem_object_put_unlocked(&bo->gem_base);
>  	}
>  }
>  
> -- 
> 2.7.4
> 
> -- 
> You received this message because you are subscribed to the Google Groups "outreachy-kernel" group.
> To unsubscribe from this group and stop receiving emails from it, send an email to outreachy-kernel+unsubscribe@googlegroups.com.
> To post to this group, send email to outreachy-kernel@googlegroups.com.
> To view this discussion on the web visit https://groups.google.com/d/msgid/outreachy-kernel/1521570567-22519-1-git-send-email-santhameena13%40gmail.com.
> For more options, visit https://groups.google.com/d/optout.

-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
