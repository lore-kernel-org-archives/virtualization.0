From: David Miller <davem@davemloft.net>
Subject: Re: [PATCH v2] virtio_net: CTRL_GUEST_OFFLOADS depends on CTRL_VQ
Date: Thu, 09 Jan 2020 18:33:39 -0800 (PST)
Message-ID: <20200109.183339.173768060466817001.davem__15832.0955046051$1578623700$gmane$org@davemloft.net>
References: <20200105132120.92370-1-mst@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20200105132120.92370-1-mst@redhat.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
 <mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
 <mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>
To: mst@redhat.com
Cc: adelva@google.com, willemdebruijn.kernel@gmail.com, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

From: "Michael S. Tsirkin" <mst@redhat.com>
Date: Sun, 5 Jan 2020 08:22:07 -0500

> The only way for guest to control offloads (as enabled by
> VIRTIO_NET_F_CTRL_GUEST_OFFLOADS) is by sending commands
> through CTRL_VQ. So it does not make sense to
> acknowledge VIRTIO_NET_F_CTRL_GUEST_OFFLOADS without
> VIRTIO_NET_F_CTRL_VQ.
> 
> The spec does not outlaw devices with such a configuration, so we have
> to support it. Simply clear VIRTIO_NET_F_CTRL_GUEST_OFFLOADS.
> Note that Linux is still crashing if it tries to
> change the offloads when there's no control vq.
> That needs to be fixed by another patch.
> 
> Reported-by: Alistair Delva <adelva@google.com>
> Reported-by: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
> Fixes: 3f93522ffab2 ("virtio-net: switch off offloads on demand if possible on XDP set")
> Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
> ---
> 
> Same patch as v1 but update documentation so it's clear it's not
> enough to fix the crash.

Where are we with this patch?  There seems to still be some unresolved
discussion about how we should actually handle this case.

Thanks.
