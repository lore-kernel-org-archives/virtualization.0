From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Subject: Re: [PATCH net] virtio_net: CTRL_GUEST_OFFLOADS depends on CTRL_VQ
Date: Mon, 23 Dec 2019 14:56:47 -0500
Message-ID: <CA+FuTSfq5v3-0VYmTG7YFFUqT8uG53eXXhqc8WvVvMbp3s0nvA__13604.3793916301$1577131061$gmane$org@mail.gmail.com>
References: <20191223140322.20013-1-mst@redhat.com>
 <CANDihLHPk5khpv-f-M+qhkzgTkygAts38GGb-HChg-VL2bo+Uw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <CANDihLHPk5khpv-f-M+qhkzgTkygAts38GGb-HChg-VL2bo+Uw@mail.gmail.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
 <mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
 <mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>
To: Alistair Delva <adelva@google.com>
Cc: Willem de Bruijn <willemdebruijn.kernel@gmail.com>, "Michael S. Tsirkin" <mst@redhat.com>, Network Development <netdev@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, virtualization@lists.linux-foundation.org, "David S. Miller" <davem@davemloft.net>
List-Id: virtualization@lists.linuxfoundation.org

00fffe0ff0 DR7: 0000000000000400
> > Call Trace:
> >  ? preempt_count_add+0x58/0xb0
> >  ? _raw_spin_lock_irqsave+0x36/0x70
> >  ? _raw_spin_unlock_irqrestore+0x1a/0x40
> >  ? __wake_up+0x70/0x190
> >  virtnet_set_features+0x90/0xf0 [virtio_net]
> >  __netdev_update_features+0x271/0x980
> >  ? nlmsg_notify+0x5b/0xa0
> >  dev_disable_lro+0x2b/0x190
> >  ? inet_netconf_notify_devconf+0xe2/0x120
> >  devinet_sysctl_forward+0x176/0x1e0
> >  proc_sys_call_handler+0x1f0/0x250
> >  proc_sys_write+0xf/0x20
> >  __vfs_write+0x3e/0x190
> >  ? __sb_start_write+0x6d/0xd0
> >  vfs_write+0xd3/0x190
> >  ksys_write+0x68/0xd0
> >  __ia32_sys_write+0x14/0x20
> >  do_fast_syscall_32+0x86/0xe0
> >  entry_SYSENTER_compat+0x7c/0x8e
> >
> > A similar crash will likely trigger when enabling XDP.
> >
> > Reported-by: Alistair Delva <adelva@google.com>
> > Reported-by: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
> > Fixes: 3f93522ffab2 ("virtio-net: switch off offloads on demand if possible on XDP set")
> > Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
> > ---
> >
> > Lightly tested.
> >
> > Alistair, could you please test and confirm that this resolves the
> > crash for you?
>
> This patch doesn't work. The reason is that NETIF_F_LRO is also turned
> on by TSO4/TSO6, which your patch didn't check for. So it ends up
> going through the same path and crashing in the same way.
>
>         if (virtio_has_feature(vdev, VIRTIO_NET_F_GUEST_TSO4) ||
>             virtio_has_feature(vdev, VIRTIO_NET_F_GUEST_TSO6))
>                 dev->features |= NETIF_F_LRO;
>
> It sounds like this patch is fixing something slightly differently to
> my patch fixed. virtnet_set_features() doesn't care about
> GUEST_OFFLOADS, it only tests against NETIF_F_LRO. Even if "offloads"
> is zero, it will call virtnet_set_guest_offloads(), which triggers the
> crash.


Interesting. It's surprising that it is trying to configure a flag
that is not configurable, i.e., absent from dev->hw_features
after Michael's change.

> So either we need to ensure NETIF_F_LRO is never set, or

LRO might be available, just not configurable. Indeed this was what I
observed in the past.
