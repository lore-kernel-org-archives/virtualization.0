From: Toshiaki Makita <makita.toshiaki@lab.ntt.co.jp>
Subject: Re: [RFC] virtio_net: add local_bh_disable() around
	u64_stats_update_begin
Date: Wed, 17 Oct 2018 10:13:38 +0900
Message-ID: <68582c17-27bf-43f4-cbe5-96ec712a704c__1929.73126327178$1539740739$gmane$org@lab.ntt.co.jp>
References: <20181016165545.guksrl23ulcudxrk@linutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20181016165545.guksrl23ulcudxrk@linutronix.de>
Content-Language: en-US
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>, netdev@vger.kernel.org, virtualization@lists.linux-foundation.org
Cc: tglx@linutronix.de, "David S. Miller" <davem@davemloft.net>, "Michael S. Tsirkin" <mst@redhat.com>
List-Id: virtualization@lists.linuxfoundation.org

On 2018/10/17 1:55, Sebastian Andrzej Siewior wrote:
> on 32bit, lockdep notices:
> | ================================
> | WARNING: inconsistent lock state
> | 4.19.0-rc8+ #9 Tainted: G        W
> | --------------------------------
> | inconsistent {SOFTIRQ-ON-W} -> {IN-SOFTIRQ-W} usage.
> | ip/1106 [HC0[0]:SC1[1]:HE1:SE0] takes:
> | (ptrval) (&syncp->seq#2){+.?.}, at: net_rx_action+0xc8/0x380
> | {SOFTIRQ-ON-W} state was registered at:
> |   lock_acquire+0x7e/0x170
> |   try_fill_recv+0x5fa/0x700
> |   virtnet_open+0xe0/0x180
> |   __dev_open+0xae/0x130
> |   __dev_change_flags+0x17f/0x200
> |   dev_change_flags+0x23/0x60
> |   do_setlink+0x2bb/0xa20
> |   rtnl_newlink+0x523/0x830
> |   rtnetlink_rcv_msg+0x14b/0x470
> |   netlink_rcv_skb+0x6e/0xf0
> |   rtnetlink_rcv+0xd/0x10
> |   netlink_unicast+0x16e/0x1f0
> |   netlink_sendmsg+0x1af/0x3a0
> |   ___sys_sendmsg+0x20f/0x240
> |   __sys_sendmsg+0x39/0x80
> |   sys_socketcall+0x13a/0x2a0
> |   do_int80_syscall_32+0x50/0x180
> |   restore_all+0x0/0xb2
> | irq event stamp: 3326
> | hardirqs last  enabled at (3326): [<c159e6d0>] net_rx_action+0x80/0x380
> | hardirqs last disabled at (3325): [<c159e6aa>] net_rx_action+0x5a/0x380
> | softirqs last  enabled at (3322): [<c14b440d>] virtnet_napi_enable+0xd/0x60
> | softirqs last disabled at (3323): [<c101d63d>] call_on_stack+0xd/0x50
> |
> | other info that might help us debug this:
> |  Possible unsafe locking scenario:
> |
> |        CPU0
> |        ----
> |   lock(&syncp->seq#2);
> |   <Interrupt>
> |     lock(&syncp->seq#2);
> |
> |  *** DEADLOCK ***

IIUC try_fill_recv is called only when NAPI is disabled from process
context, so there should be no point to race with virtnet_receive which
is called from NAPI handler.

I'm not sure what condition triggered this warning.


Toshiaki Makita


> 
> This is the "up" path which is not a hotpath. There is also
> refill_work().
> It might be unwise to add the local_bh_disable() to try_fill_recv()
> because if it is used mostly in BH so that local_bh_en+dis might be a
> waste of cycles.
> 
> Adding local_bh_disable() around try_fill_recv() for the non-BH call
> sites would render GFP_KERNEL pointless.
> 
> Also, ptr->var++ is not an atomic operation even on 64bit CPUs. Which
> means if try_fill_recv() runs on CPU0 (via virtnet_receive()) then the
> worker might run on CPU1.
> 
> Do we care or is this just stupid stats?  Any suggestions?
> 
> This warning appears since commit 461f03dc99cf6 ("virtio_net: Add kick stats").
> 
> Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
> ---
>  drivers/net/virtio_net.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
> index dab504ec5e502..d782160cfa882 100644
> --- a/drivers/net/virtio_net.c
> +++ b/drivers/net/virtio_net.c
> @@ -1206,9 +1206,11 @@ static bool try_fill_recv(struct virtnet_info *vi, struct receive_queue *rq,
>  			break;
>  	} while (rq->vq->num_free);
>  	if (virtqueue_kick_prepare(rq->vq) && virtqueue_notify(rq->vq)) {
> +		local_bh_disable();
>  		u64_stats_update_begin(&rq->stats.syncp);
>  		rq->stats.kicks++;
>  		u64_stats_update_end(&rq->stats.syncp);
> +		local_bh_enable();
>  	}
>  
>  	return !oom;
> 
