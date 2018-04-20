From: Daniel Vetter <daniel@ffwll.ch>
Subject: Re: [PATCH 1/2] qxl: fix qxl_release_{map,unmap}
Date: Fri, 20 Apr 2018 09:48:18 +0200
Message-ID: <20180420074818.GL31310__45251.2657190256$1524210392$gmane$org@phenom.ffwll.local>
References: <20180418054257.15388-1-kraxel@redhat.com>
	<20180418054257.15388-2-kraxel@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <20180418054257.15388-2-kraxel@redhat.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Gerd Hoffmann <kraxel@redhat.com>
Cc: David Airlie <airlied@linux.ie>, Dave Airlie <airlied@redhat.com>, open list <linux-kernel@vger.kernel.org>, dri-devel@lists.freedesktop.org, "open list:DRM DRIVER FOR QXL VIRTUAL GPU" <virtualization@lists.linux-foundation.org>
List-Id: virtualization@lists.linuxfoundation.org

On Wed, Apr 18, 2018 at 07:42:56AM +0200, Gerd Hoffmann wrote:
> s/PAGE_SIZE/PAGE_MASK/
> 
> Luckily release_offset is never larger than PAGE_SIZE, so the bug has no
> bad side effects and managed to stay unnoticed for years that way ...
> 
> Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>

Sweeet. Since the buggy code uses the same expression for page frame and
offset I don't think there's a security bug. You might still want to cc:
stable (since without you defacto can't ever use this feature).

Reviewed-by: Daniel Vetter <daniel.vetter@ffwll.ch>
> ---
>  drivers/gpu/drm/qxl/qxl_ioctl.c   | 4 ++--
>  drivers/gpu/drm/qxl/qxl_release.c | 6 +++---
>  2 files changed, 5 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/gpu/drm/qxl/qxl_ioctl.c b/drivers/gpu/drm/qxl/qxl_ioctl.c
> index e238a1a2ec..6cc9f3367f 100644
> --- a/drivers/gpu/drm/qxl/qxl_ioctl.c
> +++ b/drivers/gpu/drm/qxl/qxl_ioctl.c
> @@ -182,9 +182,9 @@ static int qxl_process_single_command(struct qxl_device *qdev,
>  		goto out_free_reloc;
>  
>  	/* TODO copy slow path code from i915 */
> -	fb_cmd = qxl_bo_kmap_atomic_page(qdev, cmd_bo, (release->release_offset & PAGE_SIZE));
> +	fb_cmd = qxl_bo_kmap_atomic_page(qdev, cmd_bo, (release->release_offset & PAGE_MASK));
>  	unwritten = __copy_from_user_inatomic_nocache
> -		(fb_cmd + sizeof(union qxl_release_info) + (release->release_offset & ~PAGE_SIZE),
> +		(fb_cmd + sizeof(union qxl_release_info) + (release->release_offset & ~PAGE_MASK),
>  		 u64_to_user_ptr(cmd->command), cmd->command_size);
>  
>  	{
> diff --git a/drivers/gpu/drm/qxl/qxl_release.c b/drivers/gpu/drm/qxl/qxl_release.c
> index 5d84a66fed..a0b4244d28 100644
> --- a/drivers/gpu/drm/qxl/qxl_release.c
> +++ b/drivers/gpu/drm/qxl/qxl_release.c
> @@ -411,10 +411,10 @@ union qxl_release_info *qxl_release_map(struct qxl_device *qdev,
>  	struct qxl_bo_list *entry = list_first_entry(&release->bos, struct qxl_bo_list, tv.head);
>  	struct qxl_bo *bo = to_qxl_bo(entry->tv.bo);
>  
> -	ptr = qxl_bo_kmap_atomic_page(qdev, bo, release->release_offset & PAGE_SIZE);
> +	ptr = qxl_bo_kmap_atomic_page(qdev, bo, release->release_offset & PAGE_MASK);
>  	if (!ptr)
>  		return NULL;
> -	info = ptr + (release->release_offset & ~PAGE_SIZE);
> +	info = ptr + (release->release_offset & ~PAGE_MASK);
>  	return info;
>  }
>  
> @@ -426,7 +426,7 @@ void qxl_release_unmap(struct qxl_device *qdev,
>  	struct qxl_bo *bo = to_qxl_bo(entry->tv.bo);
>  	void *ptr;
>  
> -	ptr = ((void *)info) - (release->release_offset & ~PAGE_SIZE);
> +	ptr = ((void *)info) - (release->release_offset & ~PAGE_MASK);
>  	qxl_bo_kunmap_atomic_page(qdev, bo, ptr);
>  }
>  
> -- 
> 2.9.3
> 
> _______________________________________________
> dri-devel mailing list
> dri-devel@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/dri-devel

-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
