From: "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: [PATCH -next] virtio-balloon: Make virtballoon_free_page_report
 static
Date: Thu, 2 Apr 2020 09:06:38 -0400
Message-ID: <20200402090550-mutt-send-email-mst@kernel.org>
References: <20200402024302.35192-1-yuehaibing@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20200402024302.35192-1-yuehaibing@huawei.com>
Sender: linux-kernel-owner@vger.kernel.org
To: YueHaibing <yuehaibing@huawei.com>
Cc: jasowang@redhat.com, virtualization@lists.linux-foundation.org, linux-kernel@vger.kernel.org
List-Id: virtualization@lists.linuxfoundation.org

On Thu, Apr 02, 2020 at 10:43:02AM +0800, YueHaibing wrote:
> Fix sparse warning:
> 
> drivers/virtio/virtio_balloon.c:168:5: warning:
>  symbol 'virtballoon_free_page_report' was not declared. Should it be static?
> 
> Reported-by: Hulk Robot <hulkci@huawei.com>
> Signed-off-by: YueHaibing <yuehaibing@huawei.com>

This is for the mm tree right? You need to tag the subject
appropriately and copy the relevant lists.

> ---
>  drivers/virtio/virtio_balloon.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/virtio/virtio_balloon.c b/drivers/virtio/virtio_balloon.c
> index 0ef16566c3f3..bc10f94718e3 100644
> --- a/drivers/virtio/virtio_balloon.c
> +++ b/drivers/virtio/virtio_balloon.c
> @@ -165,8 +165,9 @@ static void tell_host(struct virtio_balloon *vb, struct virtqueue *vq)
>  
>  }
>  
> +static
>  int virtballoon_free_page_report(struct page_reporting_dev_info *pr_dev_info,
> -				   struct scatterlist *sg, unsigned int nents)
> +				 struct scatterlist *sg, unsigned int nents)
>  {
>  	struct virtio_balloon *vb =
>  		container_of(pr_dev_info, struct virtio_balloon, pr_dev_info);
> -- 
> 2.17.1
> 
