From: "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: [PATCH] vhost_vdpa: Fix potential underflow in vhost_vdpa_mmap()
Date: Wed, 10 Jun 2020 05:39:35 -0400
Message-ID: <20200610053926-mutt-send-email-mst@kernel.org>
References: <20200610085852.GB5439@mwanda>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <kernel-janitors-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20200610085852.GB5439@mwanda>
Sender: kernel-janitors-owner@vger.kernel.org
To: Dan Carpenter <dan.carpenter@oracle.com>
Cc: Jason Wang <jasowang@redhat.com>, kvm@vger.kernel.org, virtualization@lists.linux-foundation.org, kernel-janitors@vger.kernel.org
List-Id: virtualization@lists.linuxfoundation.org

On Wed, Jun 10, 2020 at 11:58:52AM +0300, Dan Carpenter wrote:
> The "vma->vm_pgoff" variable is an unsigned long so if it's larger than
> INT_MAX then "index" can be negative leading to an underflow.  Fix this
> by changing the type of "index" to "unsigned long".
> 
> Fixes: ddd89d0a059d ("vhost_vdpa: support doorbell mapping via mmap")
> Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>

Applied, thanks!

> ---
>  drivers/vhost/vdpa.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/vhost/vdpa.c b/drivers/vhost/vdpa.c
> index 7580e34f76c10..a54b60d6623f0 100644
> --- a/drivers/vhost/vdpa.c
> +++ b/drivers/vhost/vdpa.c
> @@ -818,7 +818,7 @@ static int vhost_vdpa_mmap(struct file *file, struct vm_area_struct *vma)
>  	struct vdpa_device *vdpa = v->vdpa;
>  	const struct vdpa_config_ops *ops = vdpa->config;
>  	struct vdpa_notification_area notify;
> -	int index = vma->vm_pgoff;
> +	unsigned long index = vma->vm_pgoff;
>  
>  	if (vma->vm_end - vma->vm_start != PAGE_SIZE)
>  		return -EINVAL;
> -- 
> 2.26.2
