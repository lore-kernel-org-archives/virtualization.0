From: David Miller <davem@davemloft.net>
Subject: Re: [PATCH v2 net 0/7] virtio_net: Fix problems around XDP tx and
	napi_tx
Date: Wed, 30 Jan 2019 14:03:00 -0800 (PST)
Message-ID: <20190130.140300.1563734650837653016.davem__23553.7694812351$1548967306$gmane$org@davemloft.net>
References: <1548722759-2470-1-git-send-email-makita.toshiaki@lab.ntt.co.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <1548722759-2470-1-git-send-email-makita.toshiaki@lab.ntt.co.jp>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: makita.toshiaki@lab.ntt.co.jp
Cc: willemb@google.com, mst@redhat.com, netdev@vger.kernel.org, virtualization@lists.linux-foundation.org, brouer@redhat.com
List-Id: virtualization@lists.linuxfoundation.org

From: Toshiaki Makita <makita.toshiaki@lab.ntt.co.jp>
Date: Tue, 29 Jan 2019 09:45:52 +0900

> While I'm looking into how to account standard tx counters on XDP tx
> processing, I found several bugs around XDP tx and napi_tx.
> 
> Patch1: Fix oops on error path. Patch2 depends on this.
> Patch2: Fix memory corruption on freeing xdp_frames with napi_tx enabled.
> Patch3: Minor fix patch5 depends on.
> Patch4: Fix memory corruption on processing xdp_frames when XDP is disabled.
>   Also patch5 depends on this.
> Patch5: Fix memory corruption on processing xdp_frames while XDP is being
>   disabled.
> Patch6: Minor fix patch7 depends on.
> Patch7: Fix memory corruption on freeing sk_buff or xdp_frames when a normal
>   queue is reused for XDP and vise versa.
> 
> v2:
> - patch5: Make rcu_assign_pointer/synchronize_net conditional instead of
>           _virtnet_set_queues.
> - patch7: Use napi_consume_skb() instead of dev_consume_skb_any()
> 
> Signed-off-by: Toshiaki Makita <makita.toshiaki@lab.ntt.co.jp>

Series applied.
