From: "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: [PATCH v3] virtio_net: avoid using netif_tx_disable() for
	serializing tx routine
Date: Wed, 17 Oct 2018 11:09:20 -0400
Message-ID: <20181017110741-mutt-send-email-mst__6070.35126672617$1539788840$gmane$org@kernel.org>
References: <276ac5bb-90f7-5fb6-a826-0bb05ecfa069@redhat.com>
	<20181017104419.13003-1-ake@igel.co.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <20181017104419.13003-1-ake@igel.co.jp>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Ake Koomsin <ake@igel.co.jp>
Cc: netdev@vger.kernel.org, "David S. Miller" <davem@davemloft.net>, linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

On Wed, Oct 17, 2018 at 07:44:12PM +0900, Ake Koomsin wrote:
> Commit 713a98d90c5e ("virtio-net: serialize tx routine during reset")
> introduces netif_tx_disable() after netif_device_detach() in order to
> avoid use-after-free of tx queues. However, there are two issues.
> 
> 1) Its operation is redundant with netif_device_detach() in case the
>    interface is running.
> 2) In case of the interface is not running before suspending and
>    resuming, the tx does not get resumed by netif_device_attach().
>    This results in losing network connectivity.
> 
> It is better to use netif_tx_lock_bh()/netif_tx_unlock_bh() instead for
> serializing tx routine during reset. This also preserves the symmetry
> of netif_device_detach() and netif_device_attach().
> 
> Fixes commit 713a98d90c5e ("virtio-net: serialize tx routine during reset")
> Signed-off-by: Ake Koomsin <ake@igel.co.jp>

Acked-by: Michael S. Tsirkin <mst@redhat.com>

Thanks a lot for debugging!
Seems like stable material to me, right?

> ---
>  drivers/net/virtio_net.c | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
> index 3f5aa59c37b7..3e2c041d76ac 100644
> --- a/drivers/net/virtio_net.c
> +++ b/drivers/net/virtio_net.c
> @@ -2267,8 +2267,9 @@ static void virtnet_freeze_down(struct virtio_device *vdev)
>  	/* Make sure no work handler is accessing the device */
>  	flush_work(&vi->config_work);
>  
> +	netif_tx_lock_bh(vi->dev);
>  	netif_device_detach(vi->dev);
> -	netif_tx_disable(vi->dev);
> +	netif_tx_unlock_bh(vi->dev);
>  	cancel_delayed_work_sync(&vi->refill);
>  
>  	if (netif_running(vi->dev)) {
> @@ -2304,7 +2305,9 @@ static int virtnet_restore_up(struct virtio_device *vdev)
>  		}
>  	}
>  
> +	netif_tx_lock_bh(vi->dev);
>  	netif_device_attach(vi->dev);
> +	netif_tx_unlock_bh(vi->dev);
>  	return err;
>  }
>  
> -- 
> 2.19.1
