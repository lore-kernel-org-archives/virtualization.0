From: "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: [PATCH 2/3] virtio-net: Introduce RSS receive steering feature
Date: Sun, 1 Mar 2020 03:49:20 -0500
Message-ID: <20200301034703-mutt-send-email-mst@kernel.org>
References: <20200229171301.15234-1-yuri.benditovich@daynix.com>
 <20200229171301.15234-3-yuri.benditovich@daynix.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20200229171301.15234-3-yuri.benditovich@daynix.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Yuri Benditovich <yuri.benditovich@daynix.com>
Cc: jasowang@redhat.com, virtualization@lists.linux-foundation.org, linux-kernel@vger.kernel.org, yan@daynix.com
List-Id: virtualization@lists.linuxfoundation.org

On Sat, Feb 29, 2020 at 07:13:00PM +0200, Yuri Benditovich wrote:
> RSS (Receive-side scaling) defines hash calculation
> rules and decision on receive virtqueue according to
> the calculated hash, provided mask to apply and
> provided indirection table containing indices of
> receive virqueues. The driver sends the control
> command to enable multiqueue and provide parameters
> for receive steering.
> 
> Signed-off-by: Yuri Benditovich <yuri.benditovich@daynix.com>
> ---
>  include/uapi/linux/virtio_net.h | 42 +++++++++++++++++++++++++++++++--
>  1 file changed, 40 insertions(+), 2 deletions(-)
> 
> diff --git a/include/uapi/linux/virtio_net.h b/include/uapi/linux/virtio_net.h
> index 6e26a2cc6ad0..7a342657fb6c 100644
> --- a/include/uapi/linux/virtio_net.h
> +++ b/include/uapi/linux/virtio_net.h
> @@ -57,6 +57,7 @@
>  					 * Steering */
>  #define VIRTIO_NET_F_CTRL_MAC_ADDR 23	/* Set MAC address */
>  
> +#define VIRTIO_NET_F_RSS	  60	/* Supports RSS RX steering */
>  #define VIRTIO_NET_F_RSC_EXT	  61	/* extended coalescing info */
>  #define VIRTIO_NET_F_STANDBY	  62	/* Act as standby for another device
>  					 * with the same MAC.
> @@ -70,6 +71,17 @@
>  #define VIRTIO_NET_S_LINK_UP	1	/* Link is up */
>  #define VIRTIO_NET_S_ANNOUNCE	2	/* Announcement is needed */
>  
> +/* supported/enabled hash types */
> +#define VIRTIO_NET_RSS_HASH_TYPE_IPv4          (1 << 0)
> +#define VIRTIO_NET_RSS_HASH_TYPE_TCPv4         (1 << 1)
> +#define VIRTIO_NET_RSS_HASH_TYPE_UDPv4         (1 << 2)
> +#define VIRTIO_NET_RSS_HASH_TYPE_IPv6          (1 << 3)
> +#define VIRTIO_NET_RSS_HASH_TYPE_TCPv6         (1 << 4)
> +#define VIRTIO_NET_RSS_HASH_TYPE_UDPv6         (1 << 5)
> +#define VIRTIO_NET_RSS_HASH_TYPE_IP_EX         (1 << 6)
> +#define VIRTIO_NET_RSS_HASH_TYPE_TCP_EX        (1 << 7)
> +#define VIRTIO_NET_RSS_HASH_TYPE_UDP_EX        (1 << 8)
> +
>  struct virtio_net_config {
>  	/* The config defining mac address (if VIRTIO_NET_F_MAC) */
>  	__u8 mac[ETH_ALEN];
> @@ -93,6 +105,12 @@ struct virtio_net_config {
>  	 * Any other value stands for unknown.
>  	 */
>  	__u8 duplex;
> +	/* maximal size of RSS key */
> +	__u8 rss_max_key_size;
> +	/* maximal number of indirection table entries */
> +	__u16 rss_max_indirection_table_length;

This mirrors spec language. However I just stumbled upon this:

https://en.wikipedia.org/wiki/Maximal_and_minimal_elements

which seems to say maximal means "local maximum".
So I think we should fix both the spec and this header to
say "maximum" instead of "maximal".

Thanks!



> +	/* bitmask of supported VIRTIO_NET_RSS_HASH_ types */
> +	__u32 supported_hash_types;
>  } __attribute__((packed));
>  
>  /*
> @@ -236,7 +254,9 @@ struct virtio_net_ctrl_mac {
>  
>  /*
>   * Control Receive Flow Steering
> - *
> + */
> +#define VIRTIO_NET_CTRL_MQ   4
> +/*
>   * The command VIRTIO_NET_CTRL_MQ_VQ_PAIRS_SET
>   * enables Receive Flow Steering, specifying the number of the transmit and
>   * receive queues that will be used. After the command is consumed and acked by
> @@ -249,11 +269,29 @@ struct virtio_net_ctrl_mq {
>  	__virtio16 virtqueue_pairs;
>  };
>  
> -#define VIRTIO_NET_CTRL_MQ   4
>   #define VIRTIO_NET_CTRL_MQ_VQ_PAIRS_SET        0
>   #define VIRTIO_NET_CTRL_MQ_VQ_PAIRS_MIN        1
>   #define VIRTIO_NET_CTRL_MQ_VQ_PAIRS_MAX        0x8000
>  
> +/*
> + * The command VIRTIO_NET_CTRL_MQ_RSS_CONFIG has the same effect as
> + * VIRTIO_NET_CTRL_MQ_VQ_PAIRS_SET does and additionally configures
> + * the receive steering to use a hash calculated for incoming packet
> + * to decide on receive virtqueue to place the packet. The command
> + * also provides parameters to calculate a hash and receive virtqueue.
> + */
> +struct virtio_net_rss_config {
> +	__virtio32 hash_types;
> +	__virtio16 indirection_table_mask;
> +	__virtio16 unclassified_queue;
> +	__virtio16 indirection_table[1/* + indirection_table_mask*/];
> +	__virtio16 max_tx_vq;
> +	__u8 hash_key_length;
> +	__u8 hash_key_data[/*hash_key_length*/];
> +};


Should use __le and not __virtio.
__virtio is for legacy types which sometimes have variable endian-ness.


> +
> + #define VIRTIO_NET_CTRL_MQ_RSS_CONFIG          1
> +
>  /*
>   * Control network offloads
>   *
> -- 
> 2.17.1
