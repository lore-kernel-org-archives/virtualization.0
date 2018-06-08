From: "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: [PATCH net] vhost_net: remove VHOST_NET_F_VIRTIO_NET_HDR support
Date: Fri, 8 Jun 2018 07:46:43 +0300
Message-ID: <20180608074115-mutt-send-email-mst__12381.9219101735$1528433104$gmane$org@kernel.org>
References: <1528429842-22835-1-git-send-email-jasowang@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <1528429842-22835-1-git-send-email-jasowang@redhat.com>
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

On Fri, Jun 08, 2018 at 11:50:42AM +0800, Jason Wang wrote:
> This feature bit is duplicated with VIRTIO_F_ANY_LAYOUT, this means if
> a userpsace want to enable VRITIO_F_ANY_LAYOUT,
> VHOST_NET_F_VIRTIO_NET_HDR will be implied too. This is wrong and will
> break networking.

What breaks networking exactly? VHOST_NET supported ANY_LAYOUT
from day one. For this reason it does not need to know about
VRITIO_F_ANY_LAYOUT and we reused the bit for other purposes.



> Fixing this by safely removing
> VHOST_NET_F_VIRTIO_NET_HDR support. There should be very few or even
> no userspace can use this.

Quite possibly, but it is hard to be sure. It seems safer to
maintain it unless there's an actual reason something's broken.

> Further cleanups could be done for
> -net-next for safety.
> 
> In the future, we need a vhost dedicated feature set/get ioctl()
> instead of reusing virtio ones.

Not just in the future, we might want to switch iommu
to a sane structure without the 64 bit padding bug
right now.

> 
> Fixes: 4e9fa50c6ccbe ("vhost: move features to core")

This tag makes no sense here IMHO. Looks like people are using some tool
that just looks at the earliest version where patch won't apply. The
commit in question just moved some code around.

> Signed-off-by: Jason Wang <jasowang@redhat.com>
> ---
>  drivers/vhost/net.c | 15 +++++----------
>  1 file changed, 5 insertions(+), 10 deletions(-)
> 
> diff --git a/drivers/vhost/net.c b/drivers/vhost/net.c
> index 986058a..83eef52 100644
> --- a/drivers/vhost/net.c
> +++ b/drivers/vhost/net.c
> @@ -69,7 +69,6 @@ MODULE_PARM_DESC(experimental_zcopytx, "Enable Zero Copy TX;"
>  
>  enum {
>  	VHOST_NET_FEATURES = VHOST_FEATURES |
> -			 (1ULL << VHOST_NET_F_VIRTIO_NET_HDR) |
>  			 (1ULL << VIRTIO_NET_F_MRG_RXBUF) |
>  			 (1ULL << VIRTIO_F_IOMMU_PLATFORM)
>  };
> @@ -1255,15 +1254,11 @@ static int vhost_net_set_features(struct vhost_net *n, u64 features)
>  			       (1ULL << VIRTIO_F_VERSION_1))) ?
>  			sizeof(struct virtio_net_hdr_mrg_rxbuf) :
>  			sizeof(struct virtio_net_hdr);
> -	if (features & (1 << VHOST_NET_F_VIRTIO_NET_HDR)) {
> -		/* vhost provides vnet_hdr */
> -		vhost_hlen = hdr_len;
> -		sock_hlen = 0;
> -	} else {
> -		/* socket provides vnet_hdr */
> -		vhost_hlen = 0;
> -		sock_hlen = hdr_len;
> -	}
> +
> +        /* socket provides vnet_hdr */
> +	vhost_hlen = 0;
> +	sock_hlen = hdr_len;
> +
>  	mutex_lock(&n->dev.mutex);
>  	if ((features & (1 << VHOST_F_LOG_ALL)) &&
>  	    !vhost_log_access_ok(&n->dev))
> -- 
> 2.7.4
