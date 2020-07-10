From: Stefano Garzarella <sgarzare@redhat.com>
Subject: Re: sparse warnings in net/vmw_vsock/virtio_transport.c
Date: Fri, 10 Jul 2020 12:41:03 +0200
Message-ID: <20200710104103.qp47ml6rgsr4l6t7@steredhat>
References: <20200710062421-mutt-send-email-mst@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20200710062421-mutt-send-email-mst@kernel.org>
Content-Disposition: inline
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
 <mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
 <mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: netdev@vger.kernel.org, stefanha@redhat.com, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

On Fri, Jul 10, 2020 at 06:24:51AM -0400, Michael S. Tsirkin wrote:
> RCU trickery:
> 
> net/vmw_vsock/virtio_transport.c:73:17: error: incompatible types in comparison expression (different address spaces):
> net/vmw_vsock/virtio_transport.c:73:17:    struct virtio_vsock [noderef] __rcu *
> net/vmw_vsock/virtio_transport.c:73:17:    struct virtio_vsock *
> net/vmw_vsock/virtio_transport.c:171:17: error: incompatible types in comparison expression (different address spaces):
> net/vmw_vsock/virtio_transport.c:171:17:    struct virtio_vsock [noderef] __rcu *
> net/vmw_vsock/virtio_transport.c:171:17:    struct virtio_vsock *
> net/vmw_vsock/virtio_transport.c:207:17: error: incompatible types in comparison expression (different address spaces):
> net/vmw_vsock/virtio_transport.c:207:17:    struct virtio_vsock [noderef] __rcu *
> net/vmw_vsock/virtio_transport.c:207:17:    struct virtio_vsock *
> net/vmw_vsock/virtio_transport.c:561:13: error: incompatible types in comparison expression (different address spaces):
> net/vmw_vsock/virtio_transport.c:561:13:    struct virtio_vsock [noderef] __rcu *
> net/vmw_vsock/virtio_transport.c:561:13:    struct virtio_vsock *
> net/vmw_vsock/virtio_transport.c:612:9: error: incompatible types in comparison expression (different address spaces):
> net/vmw_vsock/virtio_transport.c:612:9:    struct virtio_vsock [noderef] __rcu *
> net/vmw_vsock/virtio_transport.c:612:9:    struct virtio_vsock *
> net/vmw_vsock/virtio_transport.c:631:9: error: incompatible types in comparison expression (different address spaces):
> net/vmw_vsock/virtio_transport.c:631:9:    struct virtio_vsock [noderef] __rcu *
> net/vmw_vsock/virtio_transport.c:631:9:    struct virtio_vsock *
>   CC [M]  net/vmw_vsock/virtio_transport.o
> 
> can you take a look at fixing this pls?

Thanks for reporting!

We should annotate 'the_virtio_vsock' with __rcu.

I'll send a patch to fix these warnings.

Thanks,
Stefano
