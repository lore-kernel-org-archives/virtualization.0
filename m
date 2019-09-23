From: "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: [PATCH] vhost: It's better to use size_t for the 3rd parameter
	of vhost_exceeds_weight()
Date: Mon, 23 Sep 2019 04:07:15 -0400
Message-ID: <20190923040518-mutt-send-email-mst__1529.32716753043$1569226052$gmane$org@kernel.org>
References: <1569224801-101248-1-git-send-email-wangxu72@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <1569224801-101248-1-git-send-email-wangxu72@huawei.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: wangxu <wangxu72@huawei.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, kvm@vger.kernel.org, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

On Mon, Sep 23, 2019 at 03:46:41PM +0800, wangxu wrote:
> From: Wang Xu <wangxu72@huawei.com>
> 
> Caller of vhost_exceeds_weight(..., total_len) in drivers/vhost/net.c
> usually pass size_t total_len, which may be affected by rx/tx package.
> 
> Signed-off-by: Wang Xu <wangxu72@huawei.com>


Puts a bit more pressure on the register file ...
why do we care? Is there some way that it can
exceed INT_MAX?

> ---
>  drivers/vhost/vhost.c | 4 ++--
>  drivers/vhost/vhost.h | 7 ++++---
>  2 files changed, 6 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/vhost/vhost.c b/drivers/vhost/vhost.c
> index 36ca2cf..159223a 100644
> --- a/drivers/vhost/vhost.c
> +++ b/drivers/vhost/vhost.c
> @@ -412,7 +412,7 @@ static void vhost_dev_free_iovecs(struct vhost_dev *dev)
>  }
>  
>  bool vhost_exceeds_weight(struct vhost_virtqueue *vq,
> -			  int pkts, int total_len)
> +			  int pkts, size_t total_len)
>  {
>  	struct vhost_dev *dev = vq->dev;
>  
> @@ -454,7 +454,7 @@ static size_t vhost_get_desc_size(struct vhost_virtqueue *vq,
>  
>  void vhost_dev_init(struct vhost_dev *dev,
>  		    struct vhost_virtqueue **vqs, int nvqs,
> -		    int iov_limit, int weight, int byte_weight)
> +		    int iov_limit, int weight, size_t byte_weight)
>  {
>  	struct vhost_virtqueue *vq;
>  	int i;
> diff --git a/drivers/vhost/vhost.h b/drivers/vhost/vhost.h
> index e9ed272..8d80389d 100644
> --- a/drivers/vhost/vhost.h
> +++ b/drivers/vhost/vhost.h
> @@ -172,12 +172,13 @@ struct vhost_dev {
>  	wait_queue_head_t wait;
>  	int iov_limit;
>  	int weight;
> -	int byte_weight;
> +	size_t byte_weight;
>  };
>  


This just costs extra memory, and value is never large,
so I don't think this matters.

> -bool vhost_exceeds_weight(struct vhost_virtqueue *vq, int pkts, int total_len);
> +bool vhost_exceeds_weight(struct vhost_virtqueue *vq, int pkts,
> +			  size_t total_len);
>  void vhost_dev_init(struct vhost_dev *, struct vhost_virtqueue **vqs,
> -		    int nvqs, int iov_limit, int weight, int byte_weight);
> +		    int nvqs, int iov_limit, int weight, size_t byte_weight);
>  long vhost_dev_set_owner(struct vhost_dev *dev);
>  bool vhost_dev_has_owner(struct vhost_dev *dev);
>  long vhost_dev_check_owner(struct vhost_dev *);
> -- 
> 1.8.5.6
