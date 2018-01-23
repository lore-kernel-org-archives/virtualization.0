From: "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: [PATCH net 2/2] vhost: do not try to access device IOTLB when
	not initialized
Date: Tue, 23 Jan 2018 17:58:10 +0200
Message-ID: <20180123175804-mutt-send-email-mst@kernel.org>
References: <1516699646-7321-1-git-send-email-jasowang@redhat.com>
	<1516699646-7321-2-git-send-email-jasowang@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <1516699646-7321-2-git-send-email-jasowang@redhat.com>
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
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

On Tue, Jan 23, 2018 at 05:27:26PM +0800, Jason Wang wrote:
> The code will try to access dev->iotlb when processing
> VHOST_IOTLB_INVALIDATE even if it was not initialized which may lead
> to NULL pointer dereference. Fixes this by check dev->iotlb before.
> 
> Fixes: 6b1e6cc7855b0 ("vhost: new device IOTLB API")
> Signed-off-by: Jason Wang <jasowang@redhat.com>

Acked-by: Michael S. Tsirkin <mst@redhat.com>

> ---
>  drivers/vhost/vhost.c | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/drivers/vhost/vhost.c b/drivers/vhost/vhost.c
> index 549771a..5727b18 100644
> --- a/drivers/vhost/vhost.c
> +++ b/drivers/vhost/vhost.c
> @@ -1015,6 +1015,10 @@ static int vhost_process_iotlb_msg(struct vhost_dev *dev,
>  		vhost_iotlb_notify_vq(dev, msg);
>  		break;
>  	case VHOST_IOTLB_INVALIDATE:
> +		if (!dev->iotlb) {
> +			ret = -EFAULT;
> +			break;
> +		}
>  		vhost_vq_meta_reset(dev);
>  		vhost_del_umem_range(dev->iotlb, msg->iova,
>  				     msg->iova + msg->size - 1);
> -- 
> 2.7.4
