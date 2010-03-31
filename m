From: "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: [PATCH][QEMU][VHOST]fix feature bit handling for mergeable rx
	buffers
Date: Wed, 31 Mar 2010 13:12:03 +0300
Message-ID: <20100331101201.GG31085@redhat.com>
References: <201003301921.o2UJL5EH003473@lab1.dls>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <kvm-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <201003301921.o2UJL5EH003473@lab1.dls>
Sender: kvm-owner@vger.kernel.org
To: David L Stevens <dlstevens@us.ibm.com>
Cc: kvm@vger.kernel.org, virtualization@lists.osdl.org
List-Id: virtualization@lists.linuxfoundation.org

On Tue, Mar 30, 2010 at 12:21:05PM -0700, David L Stevens wrote:
> 
> This patch adds mergeable receive buffer support to qemu-kvm,
> to allow enabling it when vhost_net supports it.
> 
> It also adds a missing call to vhost_net_ack_features() to
> push acked features to vhost_net.
> 
> The patch is relative to Michael Tsirkin's qemu-kvm git tree.
> 
> 					+-DLS
> 
> Signed-off-by: David L Stevens <dlstevens@us.ibm.com>

Patch is well-formed, thanks!
BTW, where qemu-km and qemu share code, it is better
to send patch against qemu.

Since qemu-kvm generally carries kernel headers it needs, it might also
be a good idea to add if_tun to the kvm header directory.

> diff -ruNp qemu-kvm.mst/hw/vhost_net.c qemu-kvm.dls/hw/vhost_net.c
> --- qemu-kvm.mst/hw/vhost_net.c	2010-03-03 13:39:07.000000000 -0800
> +++ qemu-kvm.dls/hw/vhost_net.c	2010-03-29 20:37:34.000000000 -0700
> @@ -5,6 +5,7 @@
>  #include <sys/ioctl.h>
>  #include <linux/vhost.h>
>  #include <linux/virtio_ring.h>
> +#include <linux/if_tun.h>
>  #include <netpacket/packet.h>
>  #include <net/ethernet.h>
>  #include <net/if.h>
> @@ -38,15 +39,6 @@ unsigned vhost_net_get_features(struct v
>  	return features;
>  }
>  
> -void vhost_net_ack_features(struct vhost_net *net, unsigned features)
> -{
> -	net->dev.acked_features = net->dev.backend_features;
> -	if (features & (1 << VIRTIO_F_NOTIFY_ON_EMPTY))
> -		net->dev.acked_features |= (1 << VIRTIO_F_NOTIFY_ON_EMPTY);
> -	if (features & (1 << VIRTIO_RING_F_INDIRECT_DESC))
> -		net->dev.acked_features |= (1 << VIRTIO_RING_F_INDIRECT_DESC);
> -}
> -
>  static int vhost_net_get_fd(VLANClientState *backend)
>  {
>  	switch (backend->info->type) {
> @@ -58,6 +50,25 @@ static int vhost_net_get_fd(VLANClientSt
>  	}
>  }
>  
> +void vhost_net_ack_features(struct vhost_net *net, unsigned features)
> +{
> +	int vnet_hdr_sz = sizeof(struct virtio_net_hdr);
> +
> +	net->dev.acked_features = net->dev.backend_features;
> +	if (features & (1 << VIRTIO_F_NOTIFY_ON_EMPTY))
> +		net->dev.acked_features |= (1 << VIRTIO_F_NOTIFY_ON_EMPTY);
> +	if (features & (1 << VIRTIO_RING_F_INDIRECT_DESC))
> +		net->dev.acked_features |= (1 << VIRTIO_RING_F_INDIRECT_DESC);
> +	if (features & (1 << VIRTIO_NET_F_MRG_RXBUF)) {
> +		net->dev.acked_features |= (1 << VIRTIO_NET_F_MRG_RXBUF);
> +		vnet_hdr_sz = sizeof(struct virtio_net_hdr_mrg_rxbuf);
> +	}
> +#ifdef TUNSETVNETHDRSZ
> +	if (ioctl(vhost_net_get_fd(net->vc), TUNSETVNETHDRSZ, &vnet_hdr_sz) < 0)
> +		perror("TUNSETVNETHDRSZ");
> +#endif /* TUNSETVNETHDRSZ */

Note that this will break injecting raw packets after migration
(that code assumes header size is sizeof(struct virtio_net_hdr)).
Need to fix it.

So I think we are better off adding tap_set_vnet_header_size.
That function would:
- Remember current value, return success and do nothing
  if value is not changed.
- Try to change and return error if not.
- To get doubly sure, we can call TUNSETVNETHDRSZ with
  sizeof(struct virtio_net_hdr) at startup. If we get success
  once we should further on as well, otherwise we can exit.

An additional benefit is that tap driver will stay
localized in one file.

> +}
> +
>  struct vhost_net *vhost_net_init(VLANClientState *backend, int devfd)
>  {
>  	int r;
> diff -ruNp qemu-kvm.mst/hw/virtio-net.c qemu-kvm.dls/hw/virtio-net.c
> --- qemu-kvm.mst/hw/virtio-net.c	2010-03-03 13:39:07.000000000 -0800
> +++ qemu-kvm.dls/hw/virtio-net.c	2010-03-29 16:15:46.000000000 -0700
> @@ -211,12 +211,16 @@ static void virtio_net_set_features(Virt
>      n->mergeable_rx_bufs = !!(features & (1 << VIRTIO_NET_F_MRG_RXBUF));
>  
>      if (n->has_vnet_hdr) {
> +	struct vhost_net *vhost_net = tap_get_vhost_net(n->nic->nc.peer);
> +
>          tap_set_offload(n->nic->nc.peer,
>                          (features >> VIRTIO_NET_F_GUEST_CSUM) & 1,
>                          (features >> VIRTIO_NET_F_GUEST_TSO4) & 1,
>                          (features >> VIRTIO_NET_F_GUEST_TSO6) & 1,
>                          (features >> VIRTIO_NET_F_GUEST_ECN)  & 1,
>                          (features >> VIRTIO_NET_F_GUEST_UFO)  & 1);
> +	if (vhost_net)
> +		vhost_net_ack_features(vhost_net, features);


Good catch, thanks! I'll apply this separately.

>      }
>  }
>  
