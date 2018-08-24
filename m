From: "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: [PATCH net] vhost: correctly check the iova range when waking
	virtqueue
Date: Fri, 24 Aug 2018 14:02:36 +0300
Message-ID: <20180824140231-mutt-send-email-mst__18051.570087164$1535108440$gmane$org@kernel.org>
References: <20180824085313.21798-1-jasowang@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <20180824085313.21798-1-jasowang@redhat.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Jason Wang <jasowang@redhat.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, kvm@vger.kernel.org, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

On Fri, Aug 24, 2018 at 04:53:13PM +0800, Jason Wang wrote:
> We don't wakeup the virtqueue if the first byte of pending iova range
> is the last byte of the range we just got updated. This will lead a
> virtqueue to wait for IOTLB updating forever. Fixing by correct the
> check and wake up the virtqueue in this case.
> 
> Fixes: 6b1e6cc7855b ("vhost: new device IOTLB API")
> Reported-by: Peter Xu <peterx@redhat.com>
> Signed-off-by: Jason Wang <jasowang@redhat.com>

Acked-by: Michael S. Tsirkin <mst@redhat.com>

> ---
> The patch is needed for -stable.
> ---
>  drivers/vhost/vhost.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/vhost/vhost.c b/drivers/vhost/vhost.c
> index 96c1d8400822..b13c6b4b2c66 100644
> --- a/drivers/vhost/vhost.c
> +++ b/drivers/vhost/vhost.c
> @@ -952,7 +952,7 @@ static void vhost_iotlb_notify_vq(struct vhost_dev *d,
>  	list_for_each_entry_safe(node, n, &d->pending_list, node) {
>  		struct vhost_iotlb_msg *vq_msg = &node->msg.iotlb;
>  		if (msg->iova <= vq_msg->iova &&
> -		    msg->iova + msg->size - 1 > vq_msg->iova &&
> +		    msg->iova + msg->size - 1 >= vq_msg->iova &&
>  		    vq_msg->type == VHOST_IOTLB_MISS) {
>  			vhost_poll_queue(&node->vq->poll);
>  			list_del(&node->node);
> -- 
> 2.17.1
