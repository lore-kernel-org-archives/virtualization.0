From: Stefano Garzarella <sgarzare@redhat.com>
Subject: Re: [PATCH] vsock/virtio: annotate 'the_virtio_vsock' RCU pointer
Date: Wed, 15 Jul 2020 16:34:46 +0200
Message-ID: <20200715143446.kfl3zb4vwkk4ic4r@steredhat>
References: <20200710121243.120096-1-sgarzare@redhat.com>
 <20200713065423-mutt-send-email-mst@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <kvm-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20200713065423-mutt-send-email-mst@kernel.org>
Sender: kvm-owner@vger.kernel.org
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: davem@davemloft.net, Stefan Hajnoczi <stefanha@redhat.com>, virtualization@lists.linux-foundation.org, linux-kernel@vger.kernel.org, netdev@vger.kernel.org, Jakub Kicinski <kuba@kernel.org>, kvm@vger.kernel.org
List-Id: virtualization@lists.linuxfoundation.org

On Mon, Jul 13, 2020 at 06:54:43AM -0400, Michael S. Tsirkin wrote:
> On Fri, Jul 10, 2020 at 02:12:43PM +0200, Stefano Garzarella wrote:
> > Commit 0deab087b16a ("vsock/virtio: use RCU to avoid use-after-free
> > on the_virtio_vsock") starts to use RCU to protect 'the_virtio_vsock'
> > pointer, but we forgot to annotate it.
> > 
> > This patch adds the annotation to fix the following sparse errors:
> > 
> >     net/vmw_vsock/virtio_transport.c:73:17: error: incompatible types in comparison expression (different address spaces):
> >     net/vmw_vsock/virtio_transport.c:73:17:    struct virtio_vsock [noderef] __rcu *
> >     net/vmw_vsock/virtio_transport.c:73:17:    struct virtio_vsock *
> >     net/vmw_vsock/virtio_transport.c:171:17: error: incompatible types in comparison expression (different address spaces):
> >     net/vmw_vsock/virtio_transport.c:171:17:    struct virtio_vsock [noderef] __rcu *
> >     net/vmw_vsock/virtio_transport.c:171:17:    struct virtio_vsock *
> >     net/vmw_vsock/virtio_transport.c:207:17: error: incompatible types in comparison expression (different address spaces):
> >     net/vmw_vsock/virtio_transport.c:207:17:    struct virtio_vsock [noderef] __rcu *
> >     net/vmw_vsock/virtio_transport.c:207:17:    struct virtio_vsock *
> >     net/vmw_vsock/virtio_transport.c:561:13: error: incompatible types in comparison expression (different address spaces):
> >     net/vmw_vsock/virtio_transport.c:561:13:    struct virtio_vsock [noderef] __rcu *
> >     net/vmw_vsock/virtio_transport.c:561:13:    struct virtio_vsock *
> >     net/vmw_vsock/virtio_transport.c:612:9: error: incompatible types in comparison expression (different address spaces):
> >     net/vmw_vsock/virtio_transport.c:612:9:    struct virtio_vsock [noderef] __rcu *
> >     net/vmw_vsock/virtio_transport.c:612:9:    struct virtio_vsock *
> >     net/vmw_vsock/virtio_transport.c:631:9: error: incompatible types in comparison expression (different address spaces):
> >     net/vmw_vsock/virtio_transport.c:631:9:    struct virtio_vsock [noderef] __rcu *
> >     net/vmw_vsock/virtio_transport.c:631:9:    struct virtio_vsock *
> > 
> > Fixes: 0deab087b16a ("vsock/virtio: use RCU to avoid use-after-free on the_virtio_vsock")
> > Reported-by: Michael S. Tsirkin <mst@redhat.com>
> > Signed-off-by: Stefano Garzarella <sgarzare@redhat.com>
> 
> 
> Acked-by: Michael S. Tsirkin <mst@redhat.com>
> 
> who's merging this? Dave?

I think so, but I forgot the 'net' tag :-(

I'll wait to see if Dave will queue this, otherwise I'll resend with
the 'net' tag.

Thanks,
Stefano
