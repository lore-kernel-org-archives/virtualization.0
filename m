Received: from out30-110.freemail.mail.aliyun.com (out30-110.freemail.mail.aliyun.com [115.124.30.110])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CB7231E837
	for <virtualization@lists.linux.dev>; Tue, 24 Mar 2026 07:06:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.110
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774335998; cv=none; b=uKF4LP82smishflrwrfY+SO7bX3OEfpERO5y9bmuoVyHbuw3az8t+GqSpV2lc0MPkoRcZi2GBDjJWJRhnlJwIGYp0eWlOg84K03Az3SrDyMZB9XnaWxQ7oZcaf8zdfsPOqGQqrkzf7sZ9ur/q4+D8Cv/GKFhdy+Exk7crLsEVOM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774335998; c=relaxed/simple;
	bh=4sWa5lw1SnW2218zwPJGzfQo+Zu4TBtYZXct8Aus0rE=;
	h=Message-ID:Subject:Date:From:To:Cc:References:In-Reply-To; b=EfBD0fKRQ/otPfmO+IPbMboaLhxZGwWENFLbaRqbUDmUeoCEHGhFzIMhwB0rfJtfhwVrWv7a3J5eGtlhrs5r4B0XcalifN/PKnfWwiz65IoFosGjVsqldCxq4YzMOuBB8OqDvKu6Vnu7t//Is+ZLaj0WvWneonJADwcLSMC+m8E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=f2wnT9oW; arc=none smtp.client-ip=115.124.30.110
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="f2wnT9oW"
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1774335985; h=Message-ID:Subject:Date:From:To;
	bh=wwloc5AQbumDhzIV5EHrLVDgvQEAxkHTx8HtgJFMIpc=;
	b=f2wnT9oWH/6bQBJvTlret11czI3NbHrY2BxBlW42FhR1BOBCKIuUyjtXEKJk7zJZfUFeaJ0irG31Led69aOTSWfNrUgLnj/6Ijcls/x62Kh6T+Ag1BenyZEgs2Qj94otb7R5PFRaLUXPRQ44MZeMBy1VV94GMnrVhZtfmyZOfTc=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R811e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033032089153;MF=xuanzhuo@linux.alibaba.com;NM=1;PH=DS;RN=13;SR=0;TI=SMTPD_---0X.dgvMJ_1774335982;
Received: from localhost(mailfrom:xuanzhuo@linux.alibaba.com fp:SMTPD_---0X.dgvMJ_1774335982 cluster:ay36)
          by smtp.aliyun-inc.com;
          Tue, 24 Mar 2026 15:06:22 +0800
Message-ID: <1774335943.3427165-1-xuanzhuo@linux.alibaba.com>
Subject: Re: [PATCH net v2] virtio_net: Fix UAF on dst_ops when IFF_XMIT_DST_RELEASE is cleared and napi_tx is false
Date: Tue, 24 Mar 2026 15:05:43 +0800
From: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
To: xietangxin <xietangxin@yeah.net>
Cc: netdev@vger.kernel.org,
 virtualization@lists.linux.dev,
 linux-kernel@vger.kernel.org,
 stable@vger.kernel.org,
 xietangxin <xietangxin@yeah.net>,
 "Michael S . Tsirkin" <mst@redhat.com>,
 Jason Wang <jasowang@redhat.com>,
 "David S . Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>,
 Andrew Lunn <andrew+netdev@lunn.ch>,
 =?utf-8?q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>
References: <20260312025406.15641-1-xietangxin@yeah.net>
In-Reply-To: <20260312025406.15641-1-xietangxin@yeah.net>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>

On Thu, 12 Mar 2026 10:54:06 +0800, xietangxin <xietangxin@yeah.net> wrote:
> A UAF issue occurs when the virtio_net driver is configured with napi_tx=N
> and the device's IFF_XMIT_DST_RELEASE flag is cleared
> (e.g., during the configuration of tc route filter rules).
>
> When IFF_XMIT_DST_RELEASE is removed from the net_device, the network stack
> expects the driver to hold the reference to skb->dst until the packet
> is fully transmitted and freed. In virtio_net with napi_tx=N,
> skbs may remain in the virtio transmit ring for an extended period.
>
> If the network namespace is destroyed while these skbs are still pending,
> the corresponding dst_ops structure has freed. When a subsequent packet
> is transmitted, free_old_xmit() is triggered to clean up old skbs.
> It then calls dst_release() on the skb associated with the stale dst_entry.
> Since the dst_ops (referenced by the dst_entry) has already been freed,
> a UAF kernel paging request occurs.

Sorry, this sounds a bit off to me. We know that napi_tx=N merely prolongs the
presence of the skb on the device side. However, even without napi_tx=N, there
is no guarantee that the skb will be freed within any specific timeframe.
Therefore, napi_tx=N just makes the issue more reproducible; it is not the root
cause. Also, I'm surprised that the dst could be freed while it is still
referenced/held. I have a feeling that something is being overlooked here.

Thanks.

>
> fix it by adds skb_dst_drop(skb) in start_xmit to explicitly release
> the dst reference before the skb is queued in virtio_net.
>
> Call Trace:
>  Unable to handle kernel paging request at virtual address ffff80007e150000
>  CPU: 2 UID: 0 PID: 6236 Comm: ping Kdump: loaded Not tainted 7.0.0-rc1+ #6 PREEMPT
>   ...
>   percpu_counter_add_batch+0x3c/0x158 lib/percpu_counter.c:98 (P)
>   dst_release+0xe0/0x110  net/core/dst.c:177
>   skb_release_head_state+0xe8/0x108 net/core/skbuff.c:1177
>   sk_skb_reason_drop+0x54/0x2d8 net/core/skbuff.c:1255
>   dev_kfree_skb_any_reason+0x64/0x78 net/core/dev.c:3469
>   napi_consume_skb+0x1c4/0x3a0 net/core/skbuff.c:1527
>   __free_old_xmit+0x164/0x230  drivers/net/virtio_net.c:611 [virtio_net]
>   free_old_xmit drivers/net/virtio_net.c:1081 [virtio_net]
>   start_xmit+0x7c/0x530 drivers/net/virtio_net.c:3329 [virtio_net]
>   ...
>
> Reproduction Steps:
> NETDEV="enp3s0"
>
> config_qdisc_route_filter() {
>     tc qdisc del dev $NETDEV root
>     tc qdisc add dev $NETDEV root handle 1: prio
>     tc filter add dev $NETDEV parent 1:0 \
> 	protocol ip prio 100 route to 100 flowid 1:1
>     ip route add 192.168.1.100/32 dev $NETDEV realm 100
> }
>
> test_ns() {
>     ip netns add testns
>     ip link set $NETDEV netns testns
>     ip netns exec testns ifconfig $NETDEV  10.0.32.46/24
>     ip netns exec testns ping -c 1 10.0.32.1
>     ip netns del testns
> }
>
> config_qdisc_route_filter
>
> test_ns
> sleep 2
> test_ns
>
> Fixes: f2fc6a54585a ("[NETNS][IPV6] route6 - move ip6_dst_ops inside the network namespace")
> Cc: stable@vger.kernel.org
> Signed-off-by: xietangxin <xietangxin@yeah.net>
> ---
> change in v2: add cc stable and fix tag
>
> v1: https://lore.kernel.org/all/20260307035110.7121-1-xietangxin@yeah.net/
> ---
>  drivers/net/virtio_net.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
> index 72d6a9c6a..5b13a61b3 100644
> --- a/drivers/net/virtio_net.c
> +++ b/drivers/net/virtio_net.c
> @@ -3351,6 +3351,7 @@ static netdev_tx_t start_xmit(struct sk_buff *skb, struct net_device *dev)
>  	/* Don't wait up for transmitted skbs to be freed. */
>  	if (!use_napi) {
>  		skb_orphan(skb);
> +		skb_dst_drop(skb);
>  		nf_reset_ct(skb);
>  	}
>
> --
> 2.43.0
>
