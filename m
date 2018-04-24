From: David Miller <davem@davemloft.net>
Subject: Re: [PATCH] vhost_net: use packet weight for rx handler, too
Date: Tue, 24 Apr 2018 10:02:50 -0400 (EDT)
Message-ID: <20180424.100250.2051235227878473641.davem__43388.8465086513$1524578480$gmane$org@davemloft.net>
References: <11f2a27cee0c660a611af381ac1b68d9526095e3.1524556673.git.pabeni@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <11f2a27cee0c660a611af381ac1b68d9526095e3.1524556673.git.pabeni@redhat.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: pabeni@redhat.com
Cc: kvm@vger.kernel.org, mst@redhat.com, netdev@vger.kernel.org, virtualization@lists.linux-foundation.org, haibinzhang@tencent.com
List-Id: virtualization@lists.linuxfoundation.org

From: Paolo Abeni <pabeni@redhat.com>
Date: Tue, 24 Apr 2018 10:34:36 +0200

> Similar to commit a2ac99905f1e ("vhost-net: set packet weight of
> tx polling to 2 * vq size"), we need a packet-based limit for
> handler_rx, too - elsewhere, under rx flood with small packets,
> tx can be delayed for a very long time, even without busypolling.
> 
> The pkt limit applied to handle_rx must be the same applied by
> handle_tx, or we will get unfair scheduling between rx and tx.
> Tying such limit to the queue length makes it less effective for
> large queue length values and can introduce large process
> scheduler latencies, so a constant valued is used - likewise
> the existing bytes limit.
> 
> The selected limit has been validated with PVP[1] performance
> test with different queue sizes:
> 
> queue size		256	512	1024
> 
> baseline		366	354	362
> weight 128		715	723	670
> weight 256		740	745	733
> weight 512		600	460	583
> weight 1024		423	427	418
> 
> A packet weight of 256 gives peek performances in under all the
> tested scenarios.
> 
> No measurable regression in unidirectional performance tests has
> been detected.
> 
> [1] https://developers.redhat.com/blog/2017/06/05/measuring-and-comparing-open-vswitch-performance/
> 
> Signed-off-by: Paolo Abeni <pabeni@redhat.com>

Applied to net-next, thanks.
