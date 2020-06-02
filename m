From: "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: [PATCH 1/6] vhost: allow device that does not depend on vhost
 worker
Date: Tue, 2 Jun 2020 01:01:58 -0400
Message-ID: <20200602005904-mutt-send-email-mst@kernel.org>
References: <20200529080303.15449-1-jasowang@redhat.com>
 <20200529080303.15449-2-jasowang@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <netdev-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20200529080303.15449-2-jasowang@redhat.com>
Sender: netdev-owner@vger.kernel.org
To: Jason Wang <jasowang@redhat.com>
Cc: kvm@vger.kernel.org, virtualization@lists.linux-foundation.org, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, rob.miller@broadcom.com, lingshan.zhu@intel.com, eperezma@redhat.com, lulu@redhat.com, shahafs@mellanox.com, hanand@xilinx.com, mhabets@solarflare.com, gdawar@xilinx.com, saugatm@xilinx.com, vmireyno@marvell.com, zhangweining@ruijie.com.cn, eli@mellanox.com
List-Id: virtualization@lists.linuxfoundation.org

On Fri, May 29, 2020 at 04:02:58PM +0800, Jason Wang wrote:
> diff --git a/drivers/vhost/vhost.c b/drivers/vhost/vhost.c
> index d450e16c5c25..70105e045768 100644
> --- a/drivers/vhost/vhost.c
> +++ b/drivers/vhost/vhost.c
> @@ -166,11 +166,16 @@ static int vhost_poll_wakeup(wait_queue_entry_t *wait, unsigned mode, int sync,
>  			     void *key)
>  {
>  	struct vhost_poll *poll = container_of(wait, struct vhost_poll, wait);
> +	struct vhost_work *work = &poll->work;
>  
>  	if (!(key_to_poll(key) & poll->mask))
>  		return 0;
>  
> -	vhost_poll_queue(poll);
> +	if (!poll->dev->use_worker)
> +		work->fn(work);
> +	else
> +		vhost_poll_queue(poll);
> +
>  	return 0;
>  }
>

So a wakeup function wakes up eventfd directly.

What if user supplies e.g. the same eventfd as ioeventfd?

Won't this cause infinite loops?

-- 
MST
