From: "Michael S. Tsirkin" <mst@redhat.com>
Subject: sparse warnings in net/vmw_vsock/virtio_transport.c
Date: Fri, 10 Jul 2020 06:24:51 -0400
Message-ID: <20200710062421-mutt-send-email-mst@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <netdev-owner@vger.kernel.org>
Content-Disposition: inline
Sender: netdev-owner@vger.kernel.org
To: stefanha@redhat.com, sgarzare@redhat.com, virtualization@lists.linux-foundation.org, netdev@vger.kernel.org
List-Id: virtualization@lists.linuxfoundation.org

RCU trickery:

net/vmw_vsock/virtio_transport.c:73:17: error: incompatible types in comparison expression (different address spaces):
net/vmw_vsock/virtio_transport.c:73:17:    struct virtio_vsock [noderef] __rcu *
net/vmw_vsock/virtio_transport.c:73:17:    struct virtio_vsock *
net/vmw_vsock/virtio_transport.c:171:17: error: incompatible types in comparison expression (different address spaces):
net/vmw_vsock/virtio_transport.c:171:17:    struct virtio_vsock [noderef] __rcu *
net/vmw_vsock/virtio_transport.c:171:17:    struct virtio_vsock *
net/vmw_vsock/virtio_transport.c:207:17: error: incompatible types in comparison expression (different address spaces):
net/vmw_vsock/virtio_transport.c:207:17:    struct virtio_vsock [noderef] __rcu *
net/vmw_vsock/virtio_transport.c:207:17:    struct virtio_vsock *
net/vmw_vsock/virtio_transport.c:561:13: error: incompatible types in comparison expression (different address spaces):
net/vmw_vsock/virtio_transport.c:561:13:    struct virtio_vsock [noderef] __rcu *
net/vmw_vsock/virtio_transport.c:561:13:    struct virtio_vsock *
net/vmw_vsock/virtio_transport.c:612:9: error: incompatible types in comparison expression (different address spaces):
net/vmw_vsock/virtio_transport.c:612:9:    struct virtio_vsock [noderef] __rcu *
net/vmw_vsock/virtio_transport.c:612:9:    struct virtio_vsock *
net/vmw_vsock/virtio_transport.c:631:9: error: incompatible types in comparison expression (different address spaces):
net/vmw_vsock/virtio_transport.c:631:9:    struct virtio_vsock [noderef] __rcu *
net/vmw_vsock/virtio_transport.c:631:9:    struct virtio_vsock *
  CC [M]  net/vmw_vsock/virtio_transport.o

can you take a look at fixing this pls?

-- 
MST
