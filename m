From: David Miller <davem@davemloft.net>
Subject: Re: [PATCH net v2 0/2] vsock/virtio: fixes about packet delivery
 to monitoring devices
Date: Mon, 27 Apr 2020 10:18:19 -0700 (PDT)
Message-ID: <20200427.101819.498317950218972559.davem@davemloft.net>
References: <20200424150830.183113-1-sgarzare@redhat.com>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <kvm-owner@vger.kernel.org>
In-Reply-To: <20200424150830.183113-1-sgarzare@redhat.com>
Sender: kvm-owner@vger.kernel.org
To: sgarzare@redhat.com
Cc: jasowang@redhat.com, kuba@kernel.org, linux-kernel@vger.kernel.org, kvm@vger.kernel.org, mst@redhat.com, stefanha@redhat.com, virtualization@lists.linux-foundation.org, netdev@vger.kernel.org
List-Id: virtualization@lists.linuxfoundation.org

From: Stefano Garzarella <sgarzare@redhat.com>
Date: Fri, 24 Apr 2020 17:08:28 +0200

> During the review of v1, Stefan pointed out an issue introduced by
> that patch, where replies can appear in the packet capture before
> the transmitted packet.
> 
> While fixing my patch, reverting it and adding a new flag in
> 'struct virtio_vsock_pkt' (patch 2/2), I found that we already had
> that issue in vhost-vsock, so I fixed it (patch 1/2).
> 
> v1 -> v2:
> - reverted the v1 patch, to avoid that replies can appear in the
>   packet capture before the transmitted packet [Stefan]
> - added patch to fix packet delivering to monitoring devices in
>   vhost-vsock
> - added patch to check if the packet is already delivered to
>   monitoring devices
> 
> v1: https://patchwork.ozlabs.org/project/netdev/patch/20200421092527.41651-1-sgarzare@redhat.com/

Series applied, thank you.
