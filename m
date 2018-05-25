From: "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: [RFC PATCH net-next 00/12] XDP batching for TUN/vhost_net
Date: Fri, 25 May 2018 20:53:10 +0300
Message-ID: <20180525205219-mutt-send-email-mst__5305.73648070476$1527270670$gmane$org@kernel.org>
References: <1526893473-20128-1-git-send-email-jasowang@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <1526893473-20128-1-git-send-email-jasowang@redhat.com>
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

On Mon, May 21, 2018 at 05:04:21PM +0800, Jason Wang wrote:
> Hi all:
> 
> We do not support XDP batching for TUN since it can only receive one
> packet a time from vhost_net. This series tries to remove this
> limitation by:
> 
> - introduce a TUN specific msg_control that can hold a pointer to an
>   array of XDP buffs
> - try copy and build XDP buff in vhost_net
> - store XDP buffs in an array and submit them once for every N packets
>   from vhost_net
> - since TUN can only do native XDP for datacopy packet, to simplify
>   the logic, split datacopy out logic and only do batching for
>   datacopy.

I like how this rework looks. Pls go ahead and repost as
non-RFC.

> With this series, TX PPS can improve about 34% from 2.9Mpps to
> 3.9Mpps when doing xdp_redirect_map between TAP and ixgbe.
> 
> Thanks
> 
> Jason Wang (12):
>   vhost_net: introduce helper to initialize tx iov iter
>   vhost_net: introduce vhost_exceeds_weight()
>   vhost_net: introduce vhost_has_more_pkts()
>   vhost_net: split out datacopy logic
>   vhost_net: batch update used ring for datacopy TX
>   tuntap: enable premmption early
>   tuntap: simplify error handling in tun_build_skb()
>   tuntap: tweak on the path of non-xdp case in tun_build_skb()
>   tuntap: split out XDP logic
>   vhost_net: build xdp buff
>   vhost_net: passing raw xdp buff to tun
>   vhost_net: batch submitting XDP buffers to underlayer sockets
> 
>  drivers/net/tun.c      | 226 +++++++++++++++++++++++++++----------
>  drivers/vhost/net.c    | 297 ++++++++++++++++++++++++++++++++++++++++++++-----
>  include/linux/if_tun.h |   7 ++
>  3 files changed, 444 insertions(+), 86 deletions(-)
> 
> -- 
> 2.7.4
