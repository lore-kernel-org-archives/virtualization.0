From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Subject: Re: [PATCH net-next V2] virtio_net: ethtool tx napi configuration
Date: Thu, 13 Sep 2018 11:20:06 -0400
Message-ID: <CAF=yD-LSgCEnL_kTH44A8-FH3nut3y=bonf4Bgf75=jd=D64hw__10427.1428929225$1536851923$gmane$org@mail.gmail.com>
References: <20180913053545.18585-1-jasowang@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20180913053545.18585-1-jasowang@redhat.com>
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
Cc: Willem de Bruijn <willemb@google.com>, "Michael S. Tsirkin" <mst@redhat.com>, Network Development <netdev@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, virtualization@lists.linux-foundation.org, David Miller <davem@davemloft.net>
List-Id: virtualization@lists.linuxfoundation.org

On Thu, Sep 13, 2018 at 1:40 AM Jason Wang <jasowang@redhat.com> wrote:
>
> Implement ethtool .set_coalesce (-C) and .get_coalesce (-c) handlers.
> Interrupt moderation is currently not supported, so these accept and
> display the default settings of 0 usec and 1 frame.
>
> Toggle tx napi through a bit in tx-frames. So as to not interfere
> with possible future interrupt moderation, value 1 means tx napi while
> value 0 means not.
>
> To properly synchronize with the data path, tx napi is disabled and
> tx lock is held when changing the value of napi weight. And two more
> places that can access tx napi weight:
>
> - speculative tx polling in rx napi, we can leave it as is since it
>   not a must for correctness.
> - skb_xmit_done(), one more check of napi weight is added before
>   trying to enable tx to avoid tx to be disabled forever if napi is
>   disabled after skb_xmit_done() but before the napi
>
> Link: https://patchwork.ozlabs.org/patch/948149/
> Suggested-by: Jason Wang <jasowang@redhat.com>
> Signed-off-by: Willem de Bruijn <willemb@google.com>
> Signed-off-by: Jason Wang <jasowang@redhat.com>
> ---
> Changes from V1:
> - try to synchronize with datapath to allow changing mode when
>   interface is up.
> - use tx-frames 0 as to disable tx napi while tx-frames 1 to enable tx napi
> ---
>  drivers/net/virtio_net.c | 64 +++++++++++++++++++++++++++++++++++++++-
>  1 file changed, 63 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
> index 765920905226..6e70864f5899 100644
> --- a/drivers/net/virtio_net.c
> +++ b/drivers/net/virtio_net.c
> @@ -66,6 +66,8 @@ DECLARE_EWMA(pkt_len, 0, 64)
>
>  #define VIRTNET_DRIVER_VERSION "1.0.0"
>
> +static const u32 ethtool_coalesce_napi_mask = (1UL << 10);
> +

This is no longer needed

>  static const unsigned long guest_offloads[] = {
>         VIRTIO_NET_F_GUEST_TSO4,
>         VIRTIO_NET_F_GUEST_TSO6,
> @@ -1444,7 +1446,10 @@ static int virtnet_poll_tx(struct napi_struct *napi, int budget)
>
>         virtqueue_napi_complete(napi, sq->vq, 0);
>
> -       if (sq->vq->num_free >= 2 + MAX_SKB_FRAGS)
> +       /* Check napi.weight to avoid tx stall since it could be set
> +        * to zero by ethtool after skb_xmit_done().
> +        */
> +       if (sq->vq->num_free >= 2 + MAX_SKB_FRAGS || !sq->napi.weight)
>                 netif_tx_wake_queue(txq);

I see. This assumes that the napi handler will always be called on
conversion from napi to no-napi mode.

That is safe to assume because if it isn't called (and will not call
netif_tx_wake_queue) that implies that napi was not scheduled, and
thus the tx interrupt was not suppressed and thus there was no tx
completion work to be scheduled?

>
>         return 0;
> @@ -2181,6 +2186,61 @@ static int virtnet_get_link_ksettings(struct net_device *dev,
>         return 0;
>  }
>
> +static int virtnet_set_coalesce(struct net_device *dev,
> +                               struct ethtool_coalesce *ec)
> +{
> +       struct ethtool_coalesce ec_default = {
> +               .cmd = ETHTOOL_SCOALESCE,
> +               .rx_max_coalesced_frames = 1,
> +       };
> +       struct virtnet_info *vi = netdev_priv(dev);
> +       int i, napi_weight;
> +
> +       if (ec->tx_max_coalesced_frames > 1)
> +               return -EINVAL;
> +
> +       ec_default.tx_max_coalesced_frames = ec->tx_max_coalesced_frames;
> +       napi_weight = ec->tx_max_coalesced_frames ? NAPI_POLL_WEIGHT : 0;
> +
> +       /* disallow changes to fields not explicitly tested above */
> +       if (memcmp(ec, &ec_default, sizeof(ec_default)))
> +               return -EINVAL;
> +
> +       if (napi_weight ^ vi->sq[0].napi.weight) {
> +               for (i = 0; i < vi->max_queue_pairs; i++) {
> +                       struct netdev_queue *txq =
> +                              netdev_get_tx_queue(vi->dev, i);
> +
> +                       virtnet_napi_tx_disable(&vi->sq[i].napi);
> +                       __netif_tx_lock_bh(txq);
> +                       vi->sq[i].napi.weight = napi_weight;
> +                       __netif_tx_unlock_bh(txq);
> +                       virtnet_napi_tx_enable(vi, vi->sq[i].vq,
> +                                              &vi->sq[i].napi);
> +               }
> +       }
> +
> +       return 0;
> +}
> +
> +static int virtnet_get_coalesce(struct net_device *dev,
> +                               struct ethtool_coalesce *ec)
> +{
> +       struct ethtool_coalesce ec_default = {
> +               .cmd = ETHTOOL_GCOALESCE,
> +               .rx_max_coalesced_frames = 1,
> +               .tx_max_coalesced_frames = 0,

no need to explicitly initialize to 0 (unless you did this for
documentation purposes, which is fine).

> +       };
> +       struct virtnet_info *vi = netdev_priv(dev);
> +
> +       memcpy(ec, &ec_default, sizeof(ec_default));
> +
> +       if (vi->sq[0].napi.weight)
> +               ec->tx_max_coalesced_frames = 1;
> +
> +       return 0;
> +}
> +
>  static void virtnet_init_settings(struct net_device *dev)
>  {
>         struct virtnet_info *vi = netdev_priv(dev);
> @@ -2219,6 +2279,8 @@ static const struct ethtool_ops virtnet_ethtool_ops = {
>         .get_ts_info = ethtool_op_get_ts_info,
>         .get_link_ksettings = virtnet_get_link_ksettings,
>         .set_link_ksettings = virtnet_set_link_ksettings,
> +       .set_coalesce = virtnet_set_coalesce,
> +       .get_coalesce = virtnet_get_coalesce,
>  };
>
>  static void virtnet_freeze_down(struct virtio_device *vdev)
> --
> 2.17.1
>
