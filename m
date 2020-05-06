From: Jesper Dangaard Brouer <brouer@redhat.com>
Subject: Re: [PATCH net-next 1/2] virtio-net: don't reserve space for vnet
 header for XDP
Date: Wed, 6 May 2020 10:21:23 +0200
Message-ID: <20200506102123.739f1233@carbon>
References: <20200506061633.16327-1-jasowang@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20200506061633.16327-1-jasowang@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Jason Wang <jasowang@redhat.com>
Cc: mst@redhat.com, virtualization@lists.linux-foundation.org, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, bpf@vger.kernel.org, brouer@redhat.com, "Jubran, Samih" <sameehj@amazon.com>
List-Id: virtualization@lists.linuxfoundation.org

On Wed,  6 May 2020 14:16:32 +0800
Jason Wang <jasowang@redhat.com> wrote:

> We tried to reserve space for vnet header before
> xdp.data_hard_start. But this is useless since the packet could be
> modified by XDP which may invalidate the information stored in the
> header and

IMHO above statements are wrong. XDP cannot access memory before
xdp.data_hard_start. Thus, it is safe to store a vnet headers before
xdp.data_hard_start. (The sfc driver also use this "before" area).

> there's no way for XDP to know the existence of the vnet header currently.

It is true that XDP is unaware of this area, which is the way it
should be.  Currently the area will survive after calling BPF/XDP.
After your change it will be overwritten in xdp_frame cases.


> So let's just not reserve space for vnet header in this case.

I think this is a wrong approach!

We are working on supporting GRO multi-buffer for XDP.  The vnet header
contains GRO information (see pahole below sign). It is currently not
used in the XDP case, but we will be working towards using it.  There
are a lot of unanswered questions on how this will be implemented.
Thus, I cannot layout how we are going to leverage this info yet, but
your patch are killing this info, which IHMO is going in the wrong
direction.


> Cc: Jesper Dangaard Brouer <brouer@redhat.com>
> Signed-off-by: Jason Wang <jasowang@redhat.com>
> ---
>  drivers/net/virtio_net.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
> index 11f722460513..98dd75b665a5 100644
> --- a/drivers/net/virtio_net.c
> +++ b/drivers/net/virtio_net.c
> @@ -684,8 +684,8 @@ static struct sk_buff *receive_small(struct net_device *dev,
>  			page = xdp_page;
>  		}
>  
> -		xdp.data_hard_start = buf + VIRTNET_RX_PAD + vi->hdr_len;
> -		xdp.data = xdp.data_hard_start + xdp_headroom;
> +		xdp.data_hard_start = buf + VIRTNET_RX_PAD;
> +		xdp.data = xdp.data_hard_start + xdp_headroom + vi->hdr_len;
>  		xdp.data_end = xdp.data + len;
>  		xdp.data_meta = xdp.data;
>  		xdp.rxq = &rq->xdp_rxq;
> @@ -845,7 +845,7 @@ static struct sk_buff *receive_mergeable(struct net_device *dev,
>  		 * the descriptor on if we get an XDP_TX return code.
>  		 */
>  		data = page_address(xdp_page) + offset;
> -		xdp.data_hard_start = data - VIRTIO_XDP_HEADROOM + vi->hdr_len;
> +		xdp.data_hard_start = data - VIRTIO_XDP_HEADROOM;
>  		xdp.data = data + vi->hdr_len;
>  		xdp.data_end = xdp.data + (len - vi->hdr_len);
>  		xdp.data_meta = xdp.data;



-- 
Best regards,
  Jesper Dangaard Brouer
  MSc.CS, Principal Kernel Engineer at Red Hat
  LinkedIn: http://www.linkedin.com/in/brouer



$ pahole -C virtio_net_hdr_mrg_rxbuf drivers/net/virtio_net.o
struct virtio_net_hdr_mrg_rxbuf {
	struct virtio_net_hdr hdr;                       /*     0    10 */
	__virtio16                 num_buffers;          /*    10     2 */

	/* size: 12, cachelines: 1, members: 2 */
	/* last cacheline: 12 bytes */
};


$ pahole -C virtio_net_hdr drivers/net/virtio_net.o
struct virtio_net_hdr {
	__u8                       flags;                /*     0     1 */
	__u8                       gso_type;             /*     1     1 */
	__virtio16                 hdr_len;              /*     2     2 */
	__virtio16                 gso_size;             /*     4     2 */
	__virtio16                 csum_start;           /*     6     2 */
	__virtio16                 csum_offset;          /*     8     2 */

	/* size: 10, cachelines: 1, members: 6 */
	/* last cacheline: 10 bytes */
};
