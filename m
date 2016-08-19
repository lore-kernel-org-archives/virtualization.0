From: Daniel Vetter <daniel@ffwll.ch>
Subject: Re: [PATCH] virtio-gpu: Use memdup_user() rather than duplicating
	its implementation
Date: Fri, 19 Aug 2016 09:50:49 +0200
Message-ID: <20160819075049.GV6232__12367.3022528694$1471593064$gmane$org@phenom.ffwll.local>
References: <401e68fc-5515-7a7a-be2e-503dee676b34@users.sourceforge.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <401e68fc-5515-7a7a-be2e-503dee676b34@users.sourceforge.net>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: SF Markus Elfring <elfring@users.sourceforge.net>
Cc: David Airlie <airlied@linux.ie>, kernel-janitors@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>, dri-devel@lists.freedesktop.org, virtualization@lists.linux-foundation.org, Julia Lawall <julia.lawall@lip6.fr>
List-Id: virtualization@lists.linuxfoundation.org

On Thu, Aug 18, 2016 at 10:42:06PM +0200, SF Markus Elfring wrote:
> From: Markus Elfring <elfring@users.sourceforge.net>
> Date: Thu, 18 Aug 2016 22:35:14 +0200
> 
> Reuse existing functionality from memdup_user() instead of keeping
> duplicate source code.
> 
> This issue was detected by using the Coccinelle software.
> 
> Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>

Applied to drm-misc.
-Daniel

> ---
>  drivers/gpu/drm/virtio/virtgpu_ioctl.c | 13 ++++---------
>  1 file changed, 4 insertions(+), 9 deletions(-)
> 
> diff --git a/drivers/gpu/drm/virtio/virtgpu_ioctl.c b/drivers/gpu/drm/virtio/virtgpu_ioctl.c
> index c046903..512e7cd 100644
> --- a/drivers/gpu/drm/virtio/virtgpu_ioctl.c
> +++ b/drivers/gpu/drm/virtio/virtgpu_ioctl.c
> @@ -152,15 +152,10 @@ static int virtio_gpu_execbuffer(struct drm_device *dev,
>  	if (ret)
>  		goto out_free;
>  
> -	buf = kmalloc(exbuf->size, GFP_KERNEL);
> -	if (!buf) {
> -		ret = -ENOMEM;
> -		goto out_unresv;
> -	}
> -	if (copy_from_user(buf, (void __user *)(uintptr_t)exbuf->command,
> -			   exbuf->size)) {
> -		kfree(buf);
> -		ret = -EFAULT;
> +	buf = memdup_user((void __user *)(uintptr_t)exbuf->command,
> +			  exbuf->size);
> +	if (IS_ERR(buf)) {
> +		ret = PTR_ERR(buf);
>  		goto out_unresv;
>  	}
>  	virtio_gpu_cmd_submit(vgdev, buf, exbuf->size,
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
