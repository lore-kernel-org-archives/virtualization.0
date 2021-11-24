Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AAF58C433EF
	for <virtualization@archiver.kernel.org>; Wed, 24 Nov 2021 01:20:00 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 2A9A54039A;
	Wed, 24 Nov 2021 01:20:00 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Raa85VFVIx1D; Wed, 24 Nov 2021 01:19:58 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 132F940169;
	Wed, 24 Nov 2021 01:19:58 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id E9C74C002E;
	Wed, 24 Nov 2021 01:19:57 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id D2A03C0012
 for <virtualization@lists.linux-foundation.org>;
 Wed, 24 Nov 2021 01:19:55 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id AB12640183
 for <virtualization@lists.linux-foundation.org>;
 Wed, 24 Nov 2021 01:19:55 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id XyYVvrE3hTzx
 for <virtualization@lists.linux-foundation.org>;
 Wed, 24 Nov 2021 01:19:54 +0000 (UTC)
X-Greylist: delayed 00:26:31 by SQLgrey-1.8.0
Received: from www62.your-server.de (www62.your-server.de [213.133.104.62])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 1394C40169
 for <virtualization@lists.linux-foundation.org>;
 Wed, 24 Nov 2021 01:19:53 +0000 (UTC)
Received: from sslproxy06.your-server.de ([78.46.172.3])
 by www62.your-server.de with esmtpsa (TLSv1.3:TLS_AES_256_GCM_SHA384:256)
 (Exim 4.92.3) (envelope-from <daniel@iogearbox.net>)
 id 1mpgWd-000D8T-BM; Wed, 24 Nov 2021 01:52:39 +0100
Received: from [85.1.206.226] (helo=linux.home)
 by sslproxy06.your-server.de with esmtpsa (TLSv1.3:TLS_AES_256_GCM_SHA384:256)
 (Exim 4.92) (envelope-from <daniel@iogearbox.net>)
 id 1mpgWc-000FwW-CI; Wed, 24 Nov 2021 01:52:38 +0100
Subject: Re: [PATCH v2 net-next 21/26] ice: add XDP and XSK generic
 per-channel statistics
To: Alexander Lobakin <alexandr.lobakin@intel.com>,
 "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>
References: <20211123163955.154512-1-alexandr.lobakin@intel.com>
 <20211123163955.154512-22-alexandr.lobakin@intel.com>
From: Daniel Borkmann <daniel@iogearbox.net>
Message-ID: <77407c26-4e32-232c-58e0-2d601d781f84@iogearbox.net>
Date: Wed, 24 Nov 2021 01:52:36 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <20211123163955.154512-22-alexandr.lobakin@intel.com>
Content-Language: en-US
X-Authenticated-Sender: daniel@iogearbox.net
X-Virus-Scanned: Clear (ClamAV 0.103.3/26362/Tue Nov 23 10:18:04 2021)
Cc: Song Liu <songliubraving@fb.com>, Sergey Ryazanov <ryazanov.s.a@gmail.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Vladimir Oltean <vladimir.oltean@nxp.com>, Alexei Starovoitov <ast@kernel.org>,
 Andrei Vagin <avagin@gmail.com>, Tony Nguyen <anthony.l.nguyen@intel.com>,
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
 Ioana Ciornei <ioana.ciornei@nxp.com>, Noam Dagan <ndagan@amazon.com>,
 Leon Romanovsky <leon@kernel.org>, Jonathan Corbet <corbet@lwn.net>,
 linux-rdma@vger.kernel.org, linux-doc@vger.kernel.org,
 John Fastabend <john.fastabend@gmail.com>,
 Russell King <linux@armlinux.org.uk>, Arthur Kiyanovski <akiyano@amazon.com>,
 Cong Wang <cong.wang@bytedance.com>, Martin Habets <habetsm.xilinx@gmail.com>,
 Lorenzo Bianconi <lorenzo@kernel.org>,
 Maciej Fijalkowski <maciej.fijalkowski@intel.com>,
 Jesper Dangaard Brouer <hawk@kernel.org>,
 Johannes Berg <johannes.berg@intel.com>, KP Singh <kpsingh@kernel.org>,
 Andrii Nakryiko <andrii@kernel.org>, Claudiu Manoil <claudiu.manoil@nxp.com>,
 Yonghong Song <yhs@fb.com>, Shay Agroskin <shayagr@amazon.com>,
 Marcin Wojtas <mw@semihalf.com>, David Arinzon <darinzon@amazon.com>,
 David Ahern <dsahern@kernel.org>,
 =?UTF-8?Q?Toke_H=c3=b8iland-J=c3=b8rgensen?= <toke@redhat.com>,
 virtualization@lists.linux-foundation.org, linux-kernel@vger.kernel.org,
 Edward Cree <ecree.xilinx@gmail.com>, Yajun Deng <yajun.deng@linux.dev>,
 netdev@vger.kernel.org, Saeed Bishara <saeedb@amazon.com>,
 Michal Swiatkowski <michal.swiatkowski@linux.intel.com>, bpf@vger.kernel.org,
 Saeed Mahameed <saeedm@nvidia.com>, Martin KaFai Lau <kafai@fb.com>
X-BeenThere: virtualization@lists.linux-foundation.org
X-Mailman-Version: 2.1.15
Precedence: list
List-Id: Linux virtualization <virtualization.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>, 
 <mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>, 
 <mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>

Hi Alexander,

On 11/23/21 5:39 PM, Alexander Lobakin wrote:
[...]

Just commenting on ice here as one example (similar applies to other drivers):

> diff --git a/drivers/net/ethernet/intel/ice/ice_txrx_lib.c b/drivers/net/ethernet/intel/ice/ice_txrx_lib.c
> index 1dd7e84f41f8..7dc287bc3a1a 100644
> --- a/drivers/net/ethernet/intel/ice/ice_txrx_lib.c
> +++ b/drivers/net/ethernet/intel/ice/ice_txrx_lib.c
> @@ -258,6 +258,8 @@ static void ice_clean_xdp_irq(struct ice_tx_ring *xdp_ring)
>   		xdp_ring->next_dd = ICE_TX_THRESH - 1;
>   	xdp_ring->next_to_clean = ntc;
>   	ice_update_tx_ring_stats(xdp_ring, total_pkts, total_bytes);
> +	xdp_update_tx_drv_stats(&xdp_ring->xdp_stats->xdp_tx, total_pkts,
> +				total_bytes);
>   }
> 
>   /**
> @@ -277,6 +279,7 @@ int ice_xmit_xdp_ring(void *data, u16 size, struct ice_tx_ring *xdp_ring)
>   		ice_clean_xdp_irq(xdp_ring);
> 
>   	if (!unlikely(ICE_DESC_UNUSED(xdp_ring))) {
> +		xdp_update_tx_drv_full(&xdp_ring->xdp_stats->xdp_tx);
>   		xdp_ring->tx_stats.tx_busy++;
>   		return ICE_XDP_CONSUMED;
>   	}
> diff --git a/drivers/net/ethernet/intel/ice/ice_xsk.c b/drivers/net/ethernet/intel/ice/ice_xsk.c
> index ff55cb415b11..62ef47a38d93 100644
> --- a/drivers/net/ethernet/intel/ice/ice_xsk.c
> +++ b/drivers/net/ethernet/intel/ice/ice_xsk.c
> @@ -454,42 +454,58 @@ ice_construct_skb_zc(struct ice_rx_ring *rx_ring, struct xdp_buff **xdp_arr)
>    * @xdp: xdp_buff used as input to the XDP program
>    * @xdp_prog: XDP program to run
>    * @xdp_ring: ring to be used for XDP_TX action
> + * @lrstats: onstack Rx XDP stats
>    *
>    * Returns any of ICE_XDP_{PASS, CONSUMED, TX, REDIR}
>    */
>   static int
>   ice_run_xdp_zc(struct ice_rx_ring *rx_ring, struct xdp_buff *xdp,
> -	       struct bpf_prog *xdp_prog, struct ice_tx_ring *xdp_ring)
> +	       struct bpf_prog *xdp_prog, struct ice_tx_ring *xdp_ring,
> +	       struct xdp_rx_drv_stats_local *lrstats)
>   {
>   	int err, result = ICE_XDP_PASS;
>   	u32 act;
> 
> +	lrstats->bytes += xdp->data_end - xdp->data;
> +	lrstats->packets++;
> +
>   	act = bpf_prog_run_xdp(xdp_prog, xdp);
> 
>   	if (likely(act == XDP_REDIRECT)) {
>   		err = xdp_do_redirect(rx_ring->netdev, xdp, xdp_prog);
> -		if (err)
> +		if (err) {
> +			lrstats->redirect_errors++;
>   			goto out_failure;
> +		}
> +		lrstats->redirect++;
>   		return ICE_XDP_REDIR;
>   	}
> 
>   	switch (act) {
>   	case XDP_PASS:
> +		lrstats->pass++;
>   		break;
>   	case XDP_TX:
>   		result = ice_xmit_xdp_buff(xdp, xdp_ring);
> -		if (result == ICE_XDP_CONSUMED)
> +		if (result == ICE_XDP_CONSUMED) {
> +			lrstats->tx_errors++;
>   			goto out_failure;
> +		}
> +		lrstats->tx++;
>   		break;
>   	default:
>   		bpf_warn_invalid_xdp_action(act);
> -		fallthrough;
> +		lrstats->invalid++;
> +		goto out_failure;
>   	case XDP_ABORTED:
> +		lrstats->aborted++;
>   out_failure:
>   		trace_xdp_exception(rx_ring->netdev, xdp_prog, act);
> -		fallthrough;
> +		result = ICE_XDP_CONSUMED;
> +		break;
>   	case XDP_DROP:
>   		result = ICE_XDP_CONSUMED;
> +		lrstats->drop++;
>   		break;
>   	}

Imho, the overall approach is way too bloated. I can see the packets/bytes but now we
have 3 counter updates with return codes included and then the additional sync of the
on-stack counters into the ring counters via xdp_update_rx_drv_stats(). So we now need
ice_update_rx_ring_stats() as well as xdp_update_rx_drv_stats() which syncs 10 different
stat counters via u64_stats_add() into the per ring ones. :/

I'm just taking our XDP L4LB in Cilium as an example: there we already count errors and
export them via per-cpu map that eventually lead to XDP_DROP cases including the /reason/
which caused the XDP_DROP (e.g. Prometheus can then scrape these insights from all the
nodes in the cluster). Given the different action codes are very often application specific,
there's not much debugging that you can do when /only/ looking at `ip link xdpstats` to
gather insight on *why* some of these actions were triggered (e.g. fib lookup failure, etc).
If really of interest, then maybe libxdp could have such per-action counters as opt-in in
its call chain..

In the case of ice_run_xdp() today, we already bump total_rx_bytes/total_rx_pkts under
XDP and update ice_update_rx_ring_stats(). I do see the case for XDP_TX and XDP_REDIRECT
where we run into driver-specific errors that are /outside of the reach/ of the BPF prog.
For example, we've been running into errors from XDP_TX in ice_xmit_xdp_ring() in the
past during testing, and were able to pinpoint the location as xdp_ring->tx_stats.tx_busy
was increasing. These things are useful and would make sense to standardize for XDP context.

But then it also seems like above in ice_xmit_xdp_ring() we now need to bump counters
twice just for sake of ethtool vs xdp counters which sucks a bit, would be nice to only
having to do it once:

 >   	if (!unlikely(ICE_DESC_UNUSED(xdp_ring))) {
 > +		xdp_update_tx_drv_full(&xdp_ring->xdp_stats->xdp_tx);
 >   		xdp_ring->tx_stats.tx_busy++;
 >   		return ICE_XDP_CONSUMED;
 >   	}

Anyway, but just to reiterate, for troubleshooting I do care about anomalous events that
led to drops in the driver e.g. due to no space in ring or DMA errors (XDP_TX), or more
detailed insights in xdp_do_redirect() when errors occur (XDP_REDIRECT), very much less
about the action code given the prog has the full error context here already.

One more comment/question on the last doc update patch (I presume you only have dummy
numbers in there from testing?):

+For some interfaces, standard XDP statistics are available.
+It can be accessed the same ways, e.g. `ip`::
+
+  $ ip link xdpstats dev enp178s0
+  16: enp178s0:
+  xdp-channel0-rx_xdp_packets: 0
+  xdp-channel0-rx_xdp_bytes: 1
+  xdp-channel0-rx_xdp_errors: 2

What are the semantics on xdp_errors? Summary of xdp_redirect_errors, xdp_tx_errors and
xdp_xmit_errors? Or driver specific defined?

+  xdp-channel0-rx_xdp_aborted: 3
+  xdp-channel0-rx_xdp_drop: 4
+  xdp-channel0-rx_xdp_invalid: 5
+  xdp-channel0-rx_xdp_pass: 6
[...]

+  xdp-channel0-rx_xdp_redirect: 7
+  xdp-channel0-rx_xdp_redirect_errors: 8
+  xdp-channel0-rx_xdp_tx: 9
+  xdp-channel0-rx_xdp_tx_errors: 10
+  xdp-channel0-tx_xdp_xmit_packets: 11
+  xdp-channel0-tx_xdp_xmit_bytes: 12
+  xdp-channel0-tx_xdp_xmit_errors: 13
+  xdp-channel0-tx_xdp_xmit_full: 14

 From a user PoV to avoid confusion, maybe should be made more clear that the latter refers
to xsk.

> @@ -507,6 +523,7 @@ int ice_clean_rx_irq_zc(struct ice_rx_ring *rx_ring, int budget)
>   {
>   	unsigned int total_rx_bytes = 0, total_rx_packets = 0;
>   	u16 cleaned_count = ICE_DESC_UNUSED(rx_ring);
> +	struct xdp_rx_drv_stats_local lrstats = { };
>   	struct ice_tx_ring *xdp_ring;
>   	unsigned int xdp_xmit = 0;
>   	struct bpf_prog *xdp_prog;
> @@ -548,7 +565,8 @@ int ice_clean_rx_irq_zc(struct ice_rx_ring *rx_ring, int budget)
>   		xsk_buff_set_size(*xdp, size);
>   		xsk_buff_dma_sync_for_cpu(*xdp, rx_ring->xsk_pool);
> 
> -		xdp_res = ice_run_xdp_zc(rx_ring, *xdp, xdp_prog, xdp_ring);
> +		xdp_res = ice_run_xdp_zc(rx_ring, *xdp, xdp_prog, xdp_ring,
> +					 &lrstats);
>   		if (xdp_res) {
>   			if (xdp_res & (ICE_XDP_TX | ICE_XDP_REDIR))
>   				xdp_xmit |= xdp_res;
> @@ -598,6 +616,7 @@ int ice_clean_rx_irq_zc(struct ice_rx_ring *rx_ring, int budget)
> 
>   	ice_finalize_xdp_rx(xdp_ring, xdp_xmit);
>   	ice_update_rx_ring_stats(rx_ring, total_rx_packets, total_rx_bytes);
> +	xdp_update_rx_drv_stats(&rx_ring->xdp_stats->xsk_rx, &lrstats);
> 
>   	if (xsk_uses_need_wakeup(rx_ring->xsk_pool)) {
>   		if (failure || rx_ring->next_to_clean == rx_ring->next_to_use)
> @@ -629,6 +648,7 @@ static bool ice_xmit_zc(struct ice_tx_ring *xdp_ring, int budget)
>   		struct ice_tx_buf *tx_buf;
> 
>   		if (unlikely(!ICE_DESC_UNUSED(xdp_ring))) {
> +			xdp_update_tx_drv_full(&xdp_ring->xdp_stats->xsk_tx);
>   			xdp_ring->tx_stats.tx_busy++;
>   			work_done = false;
>   			break;
> @@ -686,11 +706,11 @@ ice_clean_xdp_tx_buf(struct ice_tx_ring *xdp_ring, struct ice_tx_buf *tx_buf)
>    */
>   bool ice_clean_tx_irq_zc(struct ice_tx_ring *xdp_ring, int budget)
>   {
> -	int total_packets = 0, total_bytes = 0;
>   	s16 ntc = xdp_ring->next_to_clean;
> +	u32 xdp_frames = 0, xdp_bytes = 0;
> +	u32 xsk_frames = 0, xsk_bytes = 0;
>   	struct ice_tx_desc *tx_desc;
>   	struct ice_tx_buf *tx_buf;
> -	u32 xsk_frames = 0;
>   	bool xmit_done;
> 
>   	tx_desc = ICE_TX_DESC(xdp_ring, ntc);

Thanks,
Daniel
_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
