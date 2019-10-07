From: "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: [PATCH RFC net-next 2/2] drivers: net: virtio_net: Add
	tx_timeout function
Date: Mon, 7 Oct 2019 03:51:40 -0400
Message-ID: <20191007034402-mutt-send-email-mst@kernel.org>
References: <20191006184515.23048-1-jcfaracco@gmail.com>
	<20191006184515.23048-3-jcfaracco@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <20191006184515.23048-3-jcfaracco@gmail.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: jcfaracco@gmail.com
Cc: dnmendes76@gmail.com, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org, davem@davemloft.net
List-Id: virtualization@lists.linuxfoundation.org

On Sun, Oct 06, 2019 at 03:45:15PM -0300, jcfaracco@gmail.com wrote:
> From: Julio Faracco <jcfaracco@gmail.com>
> 
> To enable dev_watchdog, virtio_net should have a tx_timeout defined 
> (.ndo_tx_timeout). This is only a skeleton to throw a warn message. It 
> notifies the event in some specific queue of device. This function 
> still counts tx_timeout statistic and consider this event as an error 
> (one error per queue), reporting it.
> 
> Signed-off-by: Julio Faracco <jcfaracco@gmail.com>
> Signed-off-by: Daiane Mendes <dnmendes76@gmail.com>
> Cc: Jason Wang <jasowang@redhat.com>
> ---
>  drivers/net/virtio_net.c | 27 +++++++++++++++++++++++++++
>  1 file changed, 27 insertions(+)
> 
> diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
> index 27f9b212c9f5..4b703b4b9441 100644
> --- a/drivers/net/virtio_net.c
> +++ b/drivers/net/virtio_net.c
> @@ -2585,6 +2585,29 @@ static int virtnet_set_features(struct net_device *dev,
>  	return 0;
>  }
>  
> +static void virtnet_tx_timeout(struct net_device *dev)
> +{
> +	struct virtnet_info *vi = netdev_priv(dev);
> +	u32 i;
> +
> +	/* find the stopped queue the same way dev_watchdog() does */

not really - the watchdog actually looks at trans_start.

> +	for (i = 0; i < vi->curr_queue_pairs; i++) {
> +		struct send_queue *sq = &vi->sq[i];
> +
> +		if (!netif_xmit_stopped(netdev_get_tx_queue(dev, i)))
> +			continue;
> +
> +		u64_stats_update_begin(&sq->stats.syncp);
> +		sq->stats.tx_timeouts++;
> +		u64_stats_update_end(&sq->stats.syncp);
> +
> +		netdev_warn(dev, "TX timeout on send queue: %d, sq: %s, vq: %d, name: %s\n",
> +			    i, sq->name, sq->vq->index, sq->vq->name);

this seems to assume any running queue is timed out.
doesn't look right.

also - there's already a warning in this case in the core. do we need another one?

> +		dev->stats.tx_errors++;



> +	}
> +}
> +
>  static const struct net_device_ops virtnet_netdev = {
>  	.ndo_open            = virtnet_open,
>  	.ndo_stop   	     = virtnet_close,
> @@ -2600,6 +2623,7 @@ static const struct net_device_ops virtnet_netdev = {
>  	.ndo_features_check	= passthru_features_check,
>  	.ndo_get_phys_port_name	= virtnet_get_phys_port_name,
>  	.ndo_set_features	= virtnet_set_features,
> +	.ndo_tx_timeout		= virtnet_tx_timeout,
>  };
>  
>  static void virtnet_config_changed_work(struct work_struct *work)
> @@ -3018,6 +3042,9 @@ static int virtnet_probe(struct virtio_device *vdev)
>  	dev->netdev_ops = &virtnet_netdev;
>  	dev->features = NETIF_F_HIGHDMA;
>  
> +	/* Set up dev_watchdog cycle. */
> +	dev->watchdog_timeo = 5 * HZ;
> +

Seems to be still broken with napi_tx = false.

>  	dev->ethtool_ops = &virtnet_ethtool_ops;
>  	SET_NETDEV_DEV(dev, &vdev->dev);
>  
> -- 
> 2.21.0
