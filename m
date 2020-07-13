From: "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: [PATCH] vsock/virtio: annotate 'the_virtio_vsock' RCU pointer
Date: Mon, 13 Jul 2020 06:54:43 -0400
Message-ID: <20200713065423-mutt-send-email-mst@kernel.org>
References: <20200710121243.120096-1-sgarzare@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <kvm-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20200710121243.120096-1-sgarzare@redhat.com>
Sender: kvm-owner@vger.kernel.org
To: Stefano Garzarella <sgarzare@redhat.com>
Cc: davem@davemloft.net, Stefan Hajnoczi <stefanha@redhat.com>, virtualization@lists.linux-foundation.org, linux-kernel@vger.kernel.org, netdev@vger.kernel.org, Jakub Kicinski <kuba@kernel.org>, kvm@vger.kernel.org
List-Id: virtualization@lists.linuxfoundation.org

On Fri, Jul 10, 2020 at 02:12:43PM +0200, Stefano Garzarella wrote:
> Commit 0deab087b16a ("vsock/virtio: use RCU to avoid use-after-free
> on the_virtio_vsock") starts to use RCU to protect 'the_virtio_vsock'
> pointer, but we forgot to annotate it.
> 
> This patch adds the annotation to fix the following sparse errors:
> 
>     net/vmw_vsock/virtio_transport.c:73:17: error: incompatible types in comparison expression (different address spaces):
>     net/vmw_vsock/virtio_transport.c:73:17:    struct virtio_vsock [noderef] __rcu *
>     net/vmw_vsock/virtio_transport.c:73:17:    struct virtio_vsock *
>     net/vmw_vsock/virtio_transport.c:171:17: error: incompatible types in comparison expression (different address spaces):
>     net/vmw_vsock/virtio_transport.c:171:17:    struct virtio_vsock [noderef] __rcu *
>     net/vmw_vsock/virtio_transport.c:171:17:    struct virtio_vsock *
>     net/vmw_vsock/virtio_transport.c:207:17: error: incompatible types in comparison expression (different address spaces):
>     net/vmw_vsock/virtio_transport.c:207:17:    struct virtio_vsock [noderef] __rcu *
>     net/vmw_vsock/virtio_transport.c:207:17:    struct virtio_vsock *
>     net/vmw_vsock/virtio_transport.c:561:13: error: incompatible types in comparison expression (different address spaces):
>     net/vmw_vsock/virtio_transport.c:561:13:    struct virtio_vsock [noderef] __rcu *
>     net/vmw_vsock/virtio_transport.c:561:13:    struct virtio_vsock *
>     net/vmw_vsock/virtio_transport.c:612:9: error: incompatible types in comparison expression (different address spaces):
>     net/vmw_vsock/virtio_transport.c:612:9:    struct virtio_vsock [noderef] __rcu *
>     net/vmw_vsock/virtio_transport.c:612:9:    struct virtio_vsock *
>     net/vmw_vsock/virtio_transport.c:631:9: error: incompatible types in comparison expression (different address spaces):
>     net/vmw_vsock/virtio_transport.c:631:9:    struct virtio_vsock [noderef] __rcu *
>     net/vmw_vsock/virtio_transport.c:631:9:    struct virtio_vsock *
> 
> Fixes: 0deab087b16a ("vsock/virtio: use RCU to avoid use-after-free on the_virtio_vsock")
> Reported-by: Michael S. Tsirkin <mst@redhat.com>
> Signed-off-by: Stefano Garzarella <sgarzare@redhat.com>


Acked-by: Michael S. Tsirkin <mst@redhat.com>

who's merging this? Dave?

> ---
>  net/vmw_vsock/virtio_transport.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/net/vmw_vsock/virtio_transport.c b/net/vmw_vsock/virtio_transport.c
> index dfbaf6bd8b1c..2700a63ab095 100644
> --- a/net/vmw_vsock/virtio_transport.c
> +++ b/net/vmw_vsock/virtio_transport.c
> @@ -22,7 +22,7 @@
>  #include <net/af_vsock.h>
>  
>  static struct workqueue_struct *virtio_vsock_workqueue;
> -static struct virtio_vsock *the_virtio_vsock;
> +static struct virtio_vsock __rcu *the_virtio_vsock;
>  static DEFINE_MUTEX(the_virtio_vsock_mutex); /* protects the_virtio_vsock */
>  
>  struct virtio_vsock {
> -- 
> 2.26.2
