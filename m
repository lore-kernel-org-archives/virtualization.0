From: "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: [PATCH 2/2] virtio-net: dynamic network offloads configuration
Date: Wed, 27 Mar 2013 17:26:29 +0200
Message-ID: <20130327152629.GB29249@redhat.com>
References: <1364391798-8058-1-git-send-email-dmitry@daynix.com>
	<1364391798-8058-3-git-send-email-dmitry@daynix.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <1364391798-8058-3-git-send-email-dmitry@daynix.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Dmitry Fleytman <dmitry@daynix.com>
Cc: Yan Vugenfirer <yan@daynix.com>, Dmitry Fleytman <dfleytma@redhat.com>, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

On Wed, Mar 27, 2013 at 03:43:18PM +0200, Dmitry Fleytman wrote:
> From: Dmitry Fleytman <dfleytma@redhat.com>
> 
> Virtio-net driver currently negotiates network offloads
> on startup via features mechanism and have no ability to
> change offloads state later.
> This patch introduced a new control command that allows
> to configure device network offloads state dynamically.
> The patch also introduces a new feature flag
> VIRTIO_NET_F_CTRL_OFFLD.
> 
> Signed-off-by: Dmitry Fleytman <dfleytma@redhat.com>
> ---
>  hw/virtio-net.c | 110 +++++++++++++++++++++++++++++++++++++++++++++++---------
>  hw/virtio-net.h |  19 ++++++++++
>  2 files changed, 113 insertions(+), 16 deletions(-)
> 
> diff --git a/hw/virtio-net.c b/hw/virtio-net.c
> index 4bb49eb..0c23126 100644
> --- a/hw/virtio-net.c
> +++ b/hw/virtio-net.c
> @@ -21,7 +21,7 @@
>  #include "hw/virtio-net.h"
>  #include "hw/vhost_net.h"
>  
> -#define VIRTIO_NET_VM_VERSION    11
> +#define VIRTIO_NET_VM_VERSION    12

This will break cross-version migration, we do it differently now:
- disable feature with old machine types
- only pass offloads around if feature set
- same for receive side

>  
>  #define MAC_TABLE_ENTRIES    64
>  #define MAX_VLAN    (1 << 12)   /* Per 802.1Q definition */
> @@ -360,6 +360,48 @@ static uint32_t virtio_net_bad_features(VirtIODevice *vdev)
>      return features;
>  }
>  
> +static void virtio_net_apply_offloads(VirtIONet *n)
> +{
> +    tap_set_offload(qemu_get_subqueue(n->nic, 0)->peer,
> +                    !!(n->curr_offloads & VIRTIO_NET_OFFLOAD_GUEST_CSUM),
> +                    !!(n->curr_offloads & VIRTIO_NET_OFFLOAD_GUEST_TSO4),
> +                    !!(n->curr_offloads & VIRTIO_NET_OFFLOAD_GUEST_TSO6),
> +                    !!(n->curr_offloads & VIRTIO_NET_OFFLOAD_GUEST_ECN),
> +                    !!(n->curr_offloads & VIRTIO_NET_OFFLOAD_GUEST_UFO));
> +}
> +
> +static uint32_t virtio_net_offloads_by_features(uint32_t features)
> +{
> +    uint32_t offloads = 0;
> +
> +    if ((1 << VIRTIO_NET_F_GUEST_CSUM) & features) {
> +        offloads |= VIRTIO_NET_OFFLOAD_GUEST_CSUM;
> +    }
> +
> +    if ((1 << VIRTIO_NET_F_GUEST_TSO4) & features) {
> +        offloads |= VIRTIO_NET_OFFLOAD_GUEST_TSO4;
> +    }
> +
> +    if ((1 << VIRTIO_NET_F_GUEST_TSO6) & features) {
> +        offloads |= VIRTIO_NET_OFFLOAD_GUEST_TSO6;
> +    }
> +
> +    if ((1 << VIRTIO_NET_F_GUEST_ECN) & features) {
> +        offloads |= VIRTIO_NET_OFFLOAD_GUEST_ECN;
> +    }
> +
> +    if ((1 << VIRTIO_NET_F_GUEST_UFO) & features) {
> +        offloads |= VIRTIO_NET_OFFLOAD_GUEST_UFO;
> +    }
> +
> +    return offloads;
> +}
> +
> +static inline uint32_t virtio_net_supported_offloads(VirtIONet *n)
> +{
> +    return virtio_net_offloads_by_features(n->vdev.guest_features);
> +}
> +
>  static void virtio_net_set_features(VirtIODevice *vdev, uint32_t features)
>  {
>      VirtIONet *n = to_virtio_net(vdev);
> @@ -371,12 +413,8 @@ static void virtio_net_set_features(VirtIODevice *vdev, uint32_t features)
>      virtio_net_set_mrg_rx_bufs(n, !!(features & (1 << VIRTIO_NET_F_MRG_RXBUF)));
>  
>      if (n->has_vnet_hdr) {
> -        tap_set_offload(qemu_get_subqueue(n->nic, 0)->peer,
> -                        (features >> VIRTIO_NET_F_GUEST_CSUM) & 1,
> -                        (features >> VIRTIO_NET_F_GUEST_TSO4) & 1,
> -                        (features >> VIRTIO_NET_F_GUEST_TSO6) & 1,
> -                        (features >> VIRTIO_NET_F_GUEST_ECN)  & 1,
> -                        (features >> VIRTIO_NET_F_GUEST_UFO)  & 1);
> +        n->curr_offloads = virtio_net_offloads_by_features(features);
> +        virtio_net_apply_offloads(n);
>      }
>  
>      for (i = 0;  i < n->max_queues; i++) {
> @@ -422,6 +460,42 @@ static int virtio_net_handle_rx_mode(VirtIONet *n, uint8_t cmd,
>      return VIRTIO_NET_OK;
>  }
>  
> +static int virtio_net_handle_offloads(VirtIONet *n, uint8_t cmd,
> +                                     struct iovec *iov, unsigned int iov_cnt)
> +{
> +    uint32_t offloads;
> +    size_t s;
> +
> +    if (!((1 << VIRTIO_NET_F_CTRL_OFFLD) & n->vdev.guest_features)) {
> +        return VIRTIO_NET_ERR;
> +    }
> +
> +    s = iov_to_buf(iov, iov_cnt, 0, &offloads, sizeof(offloads));
> +    if (s != sizeof(offloads)) {
> +        return VIRTIO_NET_ERR;
> +    }
> +
> +    if (cmd == VIRTIO_NET_CTRL_OFFLOADS_SET) {
> +        uint32_t supported_offloads;
> +
> +        if (!n->has_vnet_hdr) {
> +            return VIRTIO_NET_ERR;
> +        }
> +
> +        supported_offloads = virtio_net_supported_offloads(n);
> +        if (offloads & ~supported_offloads) {
> +            return VIRTIO_NET_ERR;
> +        }
> +
> +        n->curr_offloads = offloads;
> +        virtio_net_apply_offloads(n);

In the spec you said that only features
available in the offloads can be
enabled. Probably a good idea to validate
and error if that's not the case.

> +
> +        return VIRTIO_NET_OK;
> +    } else {
> +        return VIRTIO_NET_ERR;
> +    }
> +}
> +
>  static int virtio_net_handle_mac(VirtIONet *n, uint8_t cmd,
>                                   struct iovec *iov, unsigned int iov_cnt)
>  {
> @@ -590,6 +664,8 @@ static void virtio_net_handle_ctrl(VirtIODevice *vdev, VirtQueue *vq)
>              status = virtio_net_handle_vlan_table(n, ctrl.cmd, iov, iov_cnt);
>          } else if (ctrl.class == VIRTIO_NET_CTRL_MQ) {
>              status = virtio_net_handle_mq(n, ctrl.cmd, &elem);
> +        } else if (ctrl.class == VIRTIO_NET_CTRL_OFFLOADS) {
> +            status = virtio_net_handle_offloads(n, ctrl.cmd, iov, iov_cnt);
>          }
>  
>          s = iov_from_buf(elem.in_sg, elem.in_num, 0, &status, sizeof(status));
> @@ -1099,6 +1175,7 @@ static void virtio_net_save(QEMUFile *f, void *opaque)
>              qemu_put_be32(f, n->vqs[i].tx_waiting);
>          }
>      }
> +    qemu_put_be32(f, n->curr_offloads);

>  }
>  
>  static int virtio_net_load(QEMUFile *f, void *opaque, int version_id)
> @@ -1155,15 +1232,6 @@ static int virtio_net_load(QEMUFile *f, void *opaque, int version_id)
>              error_report("virtio-net: saved image requires vnet_hdr=on");
>              return -1;
>          }
> -
> -        if (n->has_vnet_hdr) {
> -            tap_set_offload(qemu_get_queue(n->nic)->peer,
> -                    (n->vdev.guest_features >> VIRTIO_NET_F_GUEST_CSUM) & 1,
> -                    (n->vdev.guest_features >> VIRTIO_NET_F_GUEST_TSO4) & 1,
> -                    (n->vdev.guest_features >> VIRTIO_NET_F_GUEST_TSO6) & 1,
> -                    (n->vdev.guest_features >> VIRTIO_NET_F_GUEST_ECN)  & 1,
> -                    (n->vdev.guest_features >> VIRTIO_NET_F_GUEST_UFO)  & 1);
> -        }
>      }
>  
>      if (version_id >= 9) {
> @@ -1197,6 +1265,16 @@ static int virtio_net_load(QEMUFile *f, void *opaque, int version_id)
>          }
>      }
>  
> +    if (version_id >= 11) {
> +        n->curr_offloads = qemu_get_be32(f);
> +    } else {
> +        n->curr_offloads = virtio_net_supported_offloads(n);
> +    }
> +
> +    if (n->has_vnet_hdr) {
> +        virtio_net_apply_offloads(n);
> +    }
> +
>      virtio_net_set_queues(n);
>  
>      /* Find the first multicast entry in the saved MAC filter */
> diff --git a/hw/virtio-net.h b/hw/virtio-net.h
> index 4d1a8cd..649a4e8 100644
> --- a/hw/virtio-net.h
> +++ b/hw/virtio-net.h
> @@ -27,6 +27,8 @@
>  /* The feature bitmap for virtio net */
>  #define VIRTIO_NET_F_CSUM       0       /* Host handles pkts w/ partial csum */
>  #define VIRTIO_NET_F_GUEST_CSUM 1       /* Guest handles pkts w/ partial csum */
> +#define VIRTIO_NET_F_CTRL_OFFLD 2       /* Control channel offload
> +                                         * configuration support */
>  #define VIRTIO_NET_F_MAC        5       /* Host has given MAC address. */
>  #define VIRTIO_NET_F_GSO        6       /* Host handles pkts w/ any GSO type */
>  #define VIRTIO_NET_F_GUEST_TSO4 7       /* Guest can handle TSOv4 in. */
> @@ -182,6 +184,7 @@ typedef struct VirtIONet {
>      uint16_t max_queues;
>      uint16_t curr_queues;
>      size_t config_size;
> +    uint32_t curr_offloads;
>  } VirtIONet;
>  
>  #define VIRTIO_NET_CTRL_MAC    1
> @@ -221,6 +224,21 @@ struct virtio_net_ctrl_mq {
>   #define VIRTIO_NET_CTRL_MQ_VQ_PAIRS_MIN        1
>   #define VIRTIO_NET_CTRL_MQ_VQ_PAIRS_MAX        0x8000
>  
> +/*
> + * Control network offloads
> + *
> + * Dynamic offloads are available with the
> + * VIRTIO_NET_F_CTRL_OFFLD feature bit.
> + */
> +#define VIRTIO_NET_CTRL_OFFLOADS   5
> + #define VIRTIO_NET_CTRL_OFFLOADS_SET        0
> +
> +#define VIRTIO_NET_OFFLOAD_GUEST_CSUM       1
> +#define VIRTIO_NET_OFFLOAD_GUEST_TSO4       2
> +#define VIRTIO_NET_OFFLOAD_GUEST_TSO6       4
> +#define VIRTIO_NET_OFFLOAD_GUEST_ECN        8
> +#define VIRTIO_NET_OFFLOAD_GUEST_UFO       16
> +
>  #define DEFINE_VIRTIO_NET_FEATURES(_state, _field) \
>          DEFINE_VIRTIO_COMMON_FEATURES(_state, _field), \
>          DEFINE_PROP_BIT("csum", _state, _field, VIRTIO_NET_F_CSUM, true), \
> @@ -241,6 +259,7 @@ struct virtio_net_ctrl_mq {
>          DEFINE_PROP_BIT("ctrl_vlan", _state, _field, VIRTIO_NET_F_CTRL_VLAN, true), \
>          DEFINE_PROP_BIT("ctrl_rx_extra", _state, _field, VIRTIO_NET_F_CTRL_RX_EXTRA, true), \
>          DEFINE_PROP_BIT("ctrl_mac_addr", _state, _field, VIRTIO_NET_F_CTRL_MAC_ADDR, true), \
> +        DEFINE_PROP_BIT("ctrl_offload", _state, _field, VIRTIO_NET_F_CTRL_OFFLD, true), \
>          DEFINE_PROP_BIT("mq", _state, _field, VIRTIO_NET_F_MQ, false)
>  
>  #endif
> -- 
> 1.8.1.4
