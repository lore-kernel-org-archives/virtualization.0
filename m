From: "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: [PATCH] vhost: vdpa: remove unnecessary null check
Date: Tue, 31 Mar 2020 10:03:12 -0400
Message-ID: <20200331100122-mutt-send-email-mst@kernel.org>
References: <20200330235040.GA9997@embeddedor>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20200330235040.GA9997@embeddedor>
Sender: linux-kernel-owner@vger.kernel.org
To: "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Cc: Jason Wang <jasowang@redhat.com>, Tiwei Bie <tiwei.bie@intel.com>, Eugenio =?iso-8859-1?Q?P=E9rez?= <eperezma@redhat.com>, kvm@vger.kernel.org, virtualization@lists.linux-foundation.org, netdev@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: virtualization@lists.linuxfoundation.org

On Mon, Mar 30, 2020 at 06:50:40PM -0500, Gustavo A. R. Silva wrote:
> container_of is never null, so this null check is
> unnecessary.
> 
> Addresses-Coverity-ID: 1492006 ("Logically dead code")
> Fixes: 20453a45fb06 ("vhost: introduce vDPA-based backend")
> Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>

Yes weird. Was the point to test i_cdev? Tiwei?

> ---
>  drivers/vhost/vdpa.c | 2 --
>  1 file changed, 2 deletions(-)
> 
> diff --git a/drivers/vhost/vdpa.c b/drivers/vhost/vdpa.c
> index 421f02a8530a..3d2cb811757a 100644
> --- a/drivers/vhost/vdpa.c
> +++ b/drivers/vhost/vdpa.c
> @@ -678,8 +678,6 @@ static int vhost_vdpa_open(struct inode *inode, struct file *filep)
>  	int nvqs, i, r, opened;
>  
>  	v = container_of(inode->i_cdev, struct vhost_vdpa, cdev);
> -	if (!v)
> -		return -ENODEV;
>  
>  	opened = atomic_cmpxchg(&v->opened, 0, 1);
>  	if (opened)
> -- 
> 2.26.0
