From: David Miller <davem@davemloft.net>
Subject: Re: [PATCH net] vhost_net: remove VHOST_NET_F_VIRTIO_NET_HDR support
Date: Sun, 10 Jun 2018 12:27:52 -0700 (PDT)
Message-ID: <20180610.122752.586267370739308245.davem@davemloft.net>
References: <1528429842-22835-1-git-send-email-jasowang@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
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
To: jasowang@redhat.com
Cc: netdev@vger.kernel.org, virtualization@lists.linux-foundation.org, linux-kernel@vger.kernel.org, kvm@vger.kernel.org, mst@redhat.com
List-Id: virtualization@lists.linuxfoundation.org

From: Jason Wang <jasowang@redhat.com>
Date: Fri,  8 Jun 2018 11:50:42 +0800

> This feature bit is duplicated with VIRTIO_F_ANY_LAYOUT, this means if
> a userpsace want to enable VRITIO_F_ANY_LAYOUT,
> VHOST_NET_F_VIRTIO_NET_HDR will be implied too. This is wrong and will
> break networking. Fixing this by safely removing
> VHOST_NET_F_VIRTIO_NET_HDR support. There should be very few or even
> no userspace can use this. Further cleanups could be done for
> -net-next for safety.
> 
> In the future, we need a vhost dedicated feature set/get ioctl()
> instead of reusing virtio ones.
> 
> Fixes: 4e9fa50c6ccbe ("vhost: move features to core")
> Signed-off-by: Jason Wang <jasowang@redhat.com>

I don't see this discussion as resolved yet so I'll mark this
as Deferred in patchwork.

Thanks.
