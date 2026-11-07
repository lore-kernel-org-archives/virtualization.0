Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794075602;
	b=fWdrzaq7Nx5QBCUcCtMm2zvKGO3z++gfAOJZt6VnPluB1ZECl1JHc4Crf91icmmF1uQC
	 Mcgl+qafGstuJCRaT9PX9JLHIGvNQhRtuLXV/8itBzVqVwAcqJ8y0B2vPldD5OJCvepDS
	 jIj85mBp3IAYKLuBoTCtANN4ynTfskF9Dav2I+0LyhpCeehnoATMJfXvQMfZpANZ9mHeG
	 kkZkClq+tnJr8vNNNFgv/Am4DVVkCToe3k0nDs7/EEjaEyV8/NE2XmmaX0ybyhPhrn3qs
	 c5l/kTYvDHz+LU2kaSOaDMb5GAsh/FoOIdlBOkQsRawRyoF9Bmjj6qU8oFa4aI4Mw8A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794075602;
	h=Received:DKIM-Signature:Subject:From:To:Cc:Date:Message-ID:
	 In-Reply-To:References:X-sashiko-severity:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=f8mJm5d4kLlI9akJg6GXP3woAkNqP5oI/N5/BKzWuJo=;
	b=blcIqgUnoTe2IOCPJx9MCuV2+OPg/dnfWaJiYCYuaPYRE8+ZtpMr+No5ctjLVh340Iv5
	 fuGqfhdzhadH7Hfmut3tPD+BsRjMCRemfDeOk+Y201HiwNIc1bIWf2L76ll5oZyFtR78e
	 y62hJMroupIlWC8kLsGRLZk9IQuf9WIoXekKw1KiSCxF3Aef6DpbtgSj7z3IkQbzL2vUY
	 8lz3qW9P7IFHVCZ1wDxEsOgggUNu1/KqOE4iIWoEabb/D/cWCPbaYXxj3/AZXa/iWMF1E
	 hgcWzKPcAi63QvoW7qcFmHwCOREThS69mw16IYenokufEiehzDWitEFFdElg2TyTmDg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=bB27pO08;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77F04606A326;
	Sat,  7 Nov 2026 18:20:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=bB27pO08
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8E7001F0089F;
	Sat,  7 Nov 2026 18:20:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794075601;
	bh=f8mJm5d4kLlI9akJg6GXP3woAkNqP5oI/N5/BKzWuJo=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=bB27pO08PIUFAWgaeh+S1J9dJLJYAj+mo4fKkcZV8S7L7ZGuWc+Txdytj46u5bSVt
	 QFU3KngBfRrqWe2C14TRGXwAdBppXmkUEcp8674amEWoXf98oihSRwV67KfvFRQUzi
	 QN5X1q4Dnb9n/89aAvZCFltBgvxGUST3vefhkdtoZ9f5yQid/Xva0ZwTPR4SmH2wXH
	 nxik69KFJKP/5B9/LWekSvrephsgKTUeh7jUrGRceTkAOow9iHDSwHkliIzlS4qVro
	 RVtEa1cwC7n12iWi/UhSkkGirUPg7VNNN/S2dVtZoKI30L2cEr6aqWNx4fhRQS82vt
	 1o1Uw5RdNhWxw==
Subject: Re: [PATCH net v4 1/2] tun: bound the NAPI receive queue
From: netdev-bot+sashiko@kernel.org
To: antonio@mandelbit.com
Cc: willemdebruijn.kernel@gmail.com, jasowangio@gmail.com,
 andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@kernel.org,
 kuba@kernel.org, pabeni@redhat.com, horms@kernel.org, mst@redhat.com,
 eperezma@redhat.com, shuah@kernel.org, ast@kernel.org, daniel@iogearbox.net,
 hawk@kernel.org, john.fastabend@gmail.com, sdf@fomichev.me,
 maheshb@google.com, peterpenkov96@gmail.com, netdev@vger.kernel.org,
 virtualization@lists.linux.dev, linux-kselftest@vger.kernel.org,
 bpf@vger.kernel.org
Date: Sat, 07 Nov 2026 18:20:00 +0000
Message-ID: <179407560000.994134.16391797110127015278@kernel.org>
In-Reply-To: <20261103142232.1869185-2-antonio@mandelbit.com>
References: <20261103142232.1869185-2-antonio@mandelbit.com>
X-sashiko-severity: High
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Post: <mailto:virtualization@lists.linux.dev>
List-Help: <mailto:virtualization+help@lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
List-Owner: <mailto:virtualization+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0

Thank you for your contribution! Sashiko AI review found 1 potential
issue(s) to consider.

Critical: 0 · High: 1 · Medium: 0 · Low: 0

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [High] The fix limits the IFF_NAPI receive queue by packet count,
  separately for each tun_file.

--

tun: bound the NAPI receive queue

This commit limits the IFF_NAPI receive queue (sk_write_queue) of each
tun_file to netdev_max_backlog packets. Packets beyond that are dropped
and counted as rx_dropped in tun_get_user() and tun_xdp_one(). It also
moves the NAPI poll leftovers to a new per-tfile napi_process_queue,
which is only refilled once it is empty.

> diff --git a/drivers/net/tun.c b/drivers/net/tun.c
> index dcec7311e6011..a86750626953c 100644
> --- a/drivers/net/tun.c
> +++ b/drivers/net/tun.c

[ ... ]

> @@ -227,31 +230,40 @@ struct veth {
>  static void tun_flow_init(struct tun_struct *tun);
>  static void tun_flow_uninit(struct tun_struct *tun);
>  
> +/* In IFF_NAPI mode written packets wait in the tfile's sk_write_queue for the
> + * NAPI poll, which may run later in a kthread or ksoftirqd. Bound that queue
> + * like the per-CPU backlog of netif_rx().
> + */
> +static bool tun_napi_queue_full(const struct sk_buff_head *queue)
> +{
> +	return skb_queue_len_lockless(queue) >
> +	       READ_ONCE(net_hotdata.max_backlog);
> +}

[Severity: High]

Is a packet count per queue enough to stop the unprivileged global OOM
described in the commit message?

tun_napi_queue_full() counts skbs but does not look at their size. In
tun_get_user(), len comes from iov_iter_count() with no MTU or byte
cap, and sk_sndbuf is INT_MAX. tun_alloc_skb() puts anything beyond the
frag limit (about 544 KB with 4K pages) into the linear head:

drivers/net/tun.c:tun_alloc_skb() {
    ...
	if (len - linear > MAX_SKB_FRAGS * (PAGE_SIZE << PAGE_ALLOC_COSTLY_ORDER))
		linear = len - MAX_SKB_FRAGS * (PAGE_SIZE << PAGE_ALLOC_COSTLY_ORDER);
	skb = sock_alloc_send_pskb(sk, prepad + linear, len - linear, noblock,
				   &err, PAGE_ALLOC_COSTLY_ORDER);
    ...
}

napi_process_queue in tun_napi_receive() holds one batch while writers
refill sk_write_queue. So a single queue can pin about 2 * max_backlog
skbs, which is about 2000 by default:

- With 64 KB writes that is roughly 136 MB per queue.
- With writes near 1 MB it can reach the INT_MAX sk_wmem_alloc ceiling.

None of this memory is charged to the writer's memcg.

Packets don't even need to be oversized. tun_net_init() sets max_mtu to
MAX_MTU - hard_header_len, about 64 KB. MTU-sized packets are therefore
about 45 times larger than the 1400-byte packets in the reproducer.

The limit can also be multiplied without any privilege in the init
namespace. tun_set_iff() only checks CAP_NET_ADMIN in the device's user
namespace before allowing IFF_MULTI_QUEUE:

drivers/net/tun.c:tun_set_iff() {
    ...
		int queues = ifr->ifr_flags & IFF_MULTI_QUEUE ?
			     MAX_TAP_QUEUES : 1;

		if (!ns_capable(net->user_ns, CAP_NET_ADMIN))
			return -EPERM;
    ...
}

Each of up to 256 queues gets its own limit. On top of that, the same
user can create more tun devices and network namespaces.

The reproducer in the commit message writes 1400-byte packets on one
queue. Would the same reproducer still exhaust global memory with larger
writes, or with more queues or devices?

The "Still open" paragraph lists the packets-not-bytes and per-queue
limits. It doesn't say that the unprivileged OOM is still reachable,
even though the patch carries a Fixes: tag. The following tun_vhost
selftest patch in the series doesn't change drivers/net/tun.c, so this
gap seems to remain at the end of the series.

Would closing this need accounting by skb truesize or bytes, or charging
the queued skbs to the writer's memcg, rather than a packet count per
queue?

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261103142232.1869185-1-antonio%40mandelbit.com
