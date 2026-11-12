Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.169
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794526103;
	b=niUtVVq1rZJyBYjt9Zvz9sAFpFVjx67sab0ppOJgpnagjn1agPGIvsSLEDqQw3Ev1uea
	 p0v1utnnkbhLm/8wEkhGSnahjAJgiWw+O8pQs9b5pMEf2niBHeiR/qV3mN/TjDyDg/Hs7
	 Ur/nW4lAW1X6wbOmbF6neg0Lzj91Q//k+JCKlp4mOWuqQQEAHhKi0BziMYz17e1/bCLuX
	 Iynv2ehuPpgzrHuWFdQZZKxjMarFemfmh2zYwsE95pnbHEKL8NKxSsg1O8mE2p6Gh1FAU
	 FZlraDN02EFfNIsCJTcX7uyAO+qd6rmFQfxPVvm6WacZR1HQv5eu0wCpCm0SiHq/TPg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794526103;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=321hEoTB1Au38FVGyj1DRnrNhfqydglF7rtHdrBTmUI=;
	b=vO4vzGpRwCpQxLn0Scj1iNoM61wzoVdcUsRbmcQCLuex7NaOF3c5T09eppyXZ0rYwpcQ
	 r0xHK+pANO6jqUKrEx2skJResRzO4+ZpawRUZ3y2FS7EERFYJmeO2QNzWeIGnFbLM/mAW
	 gl2gWTrwgJkoFNnXK+Ldf3dHqIwYl1NCl0RG0oDICJ51A5XA81G5uOx+JznBx4J5sl2Tt
	 aCj83VnEZXvhDYWCdXaBAbjv0zCZhMnqH+Ba/8e13sxPBKlfltUHzhnFPvyTvMoEYT0ls
	 VaaTT2HeJG7RWX0XzZ454/j37sPgn4GCnNm/OvCLrYgzHxByTjo78nNaQNnvLh6Zd4w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=LIfXqxEw;
	arc=none smtp.remote-ip=209.85.221.169
Received: from mail-vk1-f169.google.com (mail-vk1-f169.google.com [209.85.221.169])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83DDE606A32E
	for <virtualization@lists.linux.dev>; Thu, 12 Nov 2026 23:28:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 83DDE606A32E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=LIfXqxEw
Received: by mail-vk1-f169.google.com with SMTP id 71dfb90a1353d-5eaf34452a9so536667e0c.0
        for <virtualization@lists.linux.dev>; Thu, 12 Nov 2026 15:28:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794526101; x=1795130901; darn=lists.linux.dev;
        h=content-transfer-encoding:content-type:mime-version:subject
         :references:in-reply-to:message-id:cc:to:from:date:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=321hEoTB1Au38FVGyj1DRnrNhfqydglF7rtHdrBTmUI=;
        b=LIfXqxEwfZtiGXKNr43iW+2QQfEGXTzTmDI+GednRfNpL3sbyluOFhZg5w9YBqsQ0Q
         yg9HFoIhKPGhEVLI6SZrwwjlAxt7x+LSdscdesWvOA3WUbonOOVRQbDj+j+u9JYkoSWG
         dPKlCbxPiwujNQXew398ar9WYMBPek7gbc69hC8XeMh9B4i3CsOBLtvJkG2uc3EWAT6E
         XBJqvKp86EoYoENkHFemnwyNizBMoythmJfFsnnfcy0VkIs7U2NfCCmr/EKr8Eiy7xTW
         RcNB22c8DMuJ8dmm73tFmBLb2W+tBtKELQimXmK61R1O07Znx2j1RPR75UFQAZrEKMyP
         dl0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794526101; x=1795130901;
        h=content-transfer-encoding:content-type:mime-version:subject
         :references:in-reply-to:message-id:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=321hEoTB1Au38FVGyj1DRnrNhfqydglF7rtHdrBTmUI=;
        b=q5pfpfUSMSuPU3MfcRYB1LUrAItBUft4Gb/Pdr8XA/CqSuEizFQ9/1Njm93Ea30GWe
         ktbBBCAyWNc0Gl6PJh/g0xaobiqby8sXOMCadhBsS2tS/Ea7qysaVowfXzwjpexS/lMW
         pmheyxuegAblDjjN5jDzqHueAdLbbeiSo+ssN15bMYxVd4+k/mpeFr+RY17LnBYwZPpv
         v5nLK0ZpcsxMa4/1J0ZOlwXF6frL5Gpcn6jdTd9ttaiifb3U+P2P3K0Na4OIm9Udjfix
         V6PBOCgTMINNJbbk37ilrXRiCn2F/LFkX8Gvrk3PCBJYFmziTf6LKn4A9MGw9S0gJUag
         9IFw==
X-Forwarded-Encrypted: i=1; AL+hErGcPagpfIM4wMG1Khm7ajbtd5SL47+LrHfzotEPqkAi7Ny38XTzCQ4oaEO+sbwLzBIwtee52oWMOkf3DktSkQ==@lists.linux.dev
X-Gm-Message-State: APuU4Z+CrdpILH+ZQBRVO5A1TQuQZn9Jo+du20WMspfEbNjsn075oG9U
	KaCl1xYr4ibXR+R3qgjSEx441ya6uTJuo44rAoZ1gQrOwPWZ5a/D7dW+
X-Gm-Gg: AYBFou03WCyXYj5hamgaQE/Eyr9YKnL6AMrOm5pmDJ90YRdOKw9MI2uAn9gbaS84eQn
	+qFFly+nZtsNGag8BOYJWEuIV3qYxBDxESnci17tA9VoiaDrjkoiJrqVn711LQ03n9Ik6fbyBio
	hXb7mbTxqv1yFlVTG0NryyDlF0FIHoEjgy0UJ2MQuvOcuiuseg3jJGHg65s9s47akmFiRNC7OA4
	CvfVFjPg1VnNAcKenMV/ZXBHWXjStvl7l/t9og9bOikyNh8jApY9pQeUIHiseA/U8QY4HRGa8dP
	dPo1/VEdpfDKg+tINaWm6BdnsjMEv34QH84JJquwyr1zBjfLKo+O5Y8+Cu96l9ZHo6JNYGgZgVL
	L7BNC8zBo37WqxjN0K+p9oetJAtZlQCEGO9VIM42H7K54w+FeCMs4waUccp8tVGpxQXu28sMPhO
	5Mvdn5IjYvFNGyo+6ZTzauQlQdK6EQQwpiu1vvwlmbPNV8KQtcZU5S0fPezQRZZ7Z1GXHGj6pHs
	1qwmUN/bxxX1YWLc5cu0e3by6bOaCF5QmhCvy2cN9PX/M/cUwo/F9CWFcAn3D4vB5JzNw0HiaPs
	qY7UORcYcWg19pRIscZrYv9N0zYBZ4z42hEMoUrz5E2CeV1nM20x3uTNya7ZDSGeDFuxBteMfkc
	iyWzLFgZPO1FajQn6u9r8OfW4+w54saxLPsh4I5/HJw9brUeoP7TVw1REBBWJF/4=
X-Received: by 2002:a05:6122:20a2:b0:5ea:c984:5ad4 with SMTP id 71dfb90a1353d-5ee34678788mr153566e0c.2.1794526101301;
        Thu, 12 Nov 2026 15:28:21 -0800 (PST)
Received: from gmail.com (15.60.86.34.bc.googleusercontent.com. [34.86.60.15])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-5ee34e3255fsm343341e0c.4.2026.11.12.15.28.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Nov 2026 15:28:20 -0800 (PST)
Date: Thu, 12 Nov 2026 18:28:20 -0500
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: Antonio Quartulli <antonio@mandelbit.com>, 
 willemdebruijn.kernel@gmail.com, 
 jasowangio@gmail.com
Cc: Antonio Quartulli <antonio@mandelbit.com>, 
 andrew+netdev@lunn.ch, 
 davem@davemloft.net, 
 edumazet@kernel.org, 
 kuba@kernel.org, 
 pabeni@redhat.com, 
 horms@kernel.org, 
 mst@redhat.com, 
 eperezma@redhat.com, 
 shuah@kernel.org, 
 ast@kernel.org, 
 daniel@iogearbox.net, 
 hawk@kernel.org, 
 john.fastabend@gmail.com, 
 sdf@fomichev.me, 
 maheshb@google.com, 
 peterpenkov96@gmail.com, 
 netdev@vger.kernel.org, 
 virtualization@lists.linux.dev, 
 linux-kselftest@vger.kernel.org, 
 bpf@vger.kernel.org
Message-ID: <willemdebruijn.kernel.1122b304c2dc4@gmail.com>
In-Reply-To: <20261111014208.1795777-2-antonio@mandelbit.com>
References: <20261111014208.1795777-1-antonio@mandelbit.com>
 <20261111014208.1795777-2-antonio@mandelbit.com>
Subject: Re: [PATCH net v5 1/2] tun: bound the NAPI receive queue
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Post: <mailto:virtualization@lists.linux.dev>
List-Help: <mailto:virtualization+help@lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
List-Owner: <mailto:virtualization+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit

Antonio Quartulli wrote:
> With IFF_NAPI, tun_get_user() queues every written packet for NAPI on
> an unbounded list. When the poll runs asynchronously (threaded NAPI)
> and is slower than the writer, the queue grows until the system runs
> out of memory. An unprivileged user can do this from its own user and
> network namespaces, and the queued skbs are not charged to its memcg:
> in a test VM, a uid 1000 process limited to 128 MB caused a global OOM
> in ~6 seconds. The socket send buffer cannot bound this: tun sets it to
> INT_MAX, and the build_skb() and XDP batch paths do not check it.
> 
> Drop packets once more than netdev_max_backlog of them are queued, like
> enqueue_to_backlog() does, and count them as rx_dropped, before
> allocating and copying them. This covers write(), sendmsg() and the
> batches of XDP buffers vhost-net passes to tun_sendmsg(), which share
> the queue. Zerocopy buffers of dropped packets are completed. The check
> is lockless, so concurrent writers can each still add one packet.
> 
> The NAPI poll moved the whole queue out, processed up to its budget and
> put the rest back: while it ran, the queue looked empty to writers, so
> with the poll on another CPU the backlog could still grow without limit.
> Take at most budget packets instead, so that the queue never looks
> emptier than it is.
> 
> Dropping because the queue is full also schedules NAPI. vhost-net sends
> with MSG_MORE while it has more packets, and tun_get_user() schedules
> NAPI only after the last one or once more than NAPI_POLL_WEIGHT are
> queued. With a netdev_max_backlog below that, the queue would not drain
> until vhost-net ran out of packets; with zerocopy, vhost-net never
> would, as it stops sending when too many queued buffers are pending.
> 
> Reproducer, as an unprivileged user in a new user and network
> namespace, without kernel modifications or fault injection:
>   ip tuntap add t0 mode tun; ip addr add 10.11.0.1/24 dev t0
>   ip link add d0 type dummy; ip addr add 10.20.0.1/24 dev d0
>   ip link set t0 up; ip link set d0 up; sysctl net.ipv4.ip_forward=1
>   install ~500 iptables FORWARD rules and a MASQUERADE rule on d0
>   open t0 with IFF_TUN | IFF_NO_PI | IFF_NAPI
>   echo 1 > /sys/class/net/t0/threaded
>   write() 1400-byte IPv4 packets for 10.20.0.2 in a loop
> 
> Tested in an x86-64 VM with 1 and 2 vCPUs: with the reproducer running
> for 15 seconds, with 1400 to 65000-byte packets, memory use stays flat
> and the forwarding rate is unchanged; the tun kselftest passes, as it
> does without the patch; and the tun_vhost kselftest added by the next
> patch, which drives the vhost-net batch, copy and zerocopy paths,
> passes, while it fails without the patch.
> 
> Still open: the limit counts packets rather than bytes and applies per
> queue, so with large packets and many queues (IFF_MULTI_QUEUE works in a
> user namespace too) the queued skbs, which are not charged to the
> writer's memcg, can still add up to an OOM. This is hard to reach in
> practice: with large packets the writer's copy is slower than the NAPI
> poll, so the queue does not fill. With 64 KB writes the reproducer never
> reached the limit and memory use stayed flat.
> 
> Found while analysing the performance of the tun write path, and tested,
> with the help of an AI coding assistant (Claude Code).
> 
> Fixes: 943170998b20 ("tun: enable NAPI for TUN/TAP driver")
> Signed-off-by: Antonio Quartulli <antonio@mandelbit.com>
> ---
>  drivers/net/tun.c | 59 ++++++++++++++++++++++++++++++++++++++++-------
>  1 file changed, 51 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/net/tun.c b/drivers/net/tun.c
> index dcec7311e601..396e4295589f 100644
> --- a/drivers/net/tun.c
> +++ b/drivers/net/tun.c
> @@ -58,6 +58,7 @@
>  #include <linux/nsproxy.h>
>  #include <linux/virtio_net.h>
>  #include <linux/rcupdate.h>
> +#include <net/hotdata.h>
>  #include <net/net_namespace.h>
>  #include <net/netns/generic.h>
>  #include <net/rtnetlink.h>
> @@ -227,6 +228,16 @@ struct veth {
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
> +
>  static int tun_napi_receive(struct napi_struct *napi, int budget)
>  {
>  	struct tun_file *tfile = container_of(napi, struct tun_file, napi);
> @@ -237,21 +248,24 @@ static int tun_napi_receive(struct napi_struct *napi, int budget)
>  
>  	__skb_queue_head_init(&process_queue);
>  
> +	/* Take at most budget skbs, so that the queue never looks emptier to
> +	 * writers than it is.
> +	 */
>  	spin_lock(&queue->lock);
> -	skb_queue_splice_tail_init(queue, &process_queue);
> +	if (skb_queue_len(queue) <= budget) {
> +		skb_queue_splice_tail_init(queue, &process_queue);
> +	} else {
> +		while (skb_queue_len(&process_queue) < budget &&
> +		       (skb = __skb_dequeue(queue)))
> +			__skb_queue_tail(&process_queue, skb);
> +	}
>  	spin_unlock(&queue->lock);
>  
> -	while (received < budget && (skb = __skb_dequeue(&process_queue))) {
> +	while ((skb = __skb_dequeue(&process_queue))) {
>  		napi_gro_receive(napi, skb);
>  		++received;
>  	}
>  
> -	if (!skb_queue_empty(&process_queue)) {
> -		spin_lock(&queue->lock);
> -		skb_queue_splice(&process_queue, queue);
> -		spin_unlock(&queue->lock);
> -	}
> -
>  	return received;
>  }
>  
> @@ -1856,6 +1870,24 @@ static ssize_t tun_get_user(struct tun_struct *tun, struct tun_file *tfile,
>  			zerocopy = true;
>  	}
>  
> +	/* NAPI queue full: drop before allocating, and schedule NAPI, which a
> +	 * MSG_MORE sender may not have done yet. Lockless: concurrent writers
> +	 * can each still add one.
> +	 */
> +	if (tfile->napi_enabled &&
> +	    unlikely(tun_napi_queue_full(&tfile->sk.sk_write_queue))) {
> +		local_bh_disable();
> +		napi_schedule(&tfile->napi);
> +		local_bh_enable();
> +		if (msg_control) {
> +			struct ubuf_info *uarg = msg_control;
> +
> +			uarg->ops->complete(NULL, uarg, false);

call net_zcopy_put

even if the packet is dropped, the entire operation was without
fall-back to copying, so last argument is true.

also stops vhost-net from falling back onto copy mode
> +		}
> +		dev_core_stats_rx_dropped_inc(tun->dev);
> +		return total_len;
> +	}
> +
>  	if (!frags && tun_can_build_skb(tun, tfile, len, noblock, zerocopy)) {
>  		/* For the packet that is not easy to be processed
>  		 * (e.g gso or jumbo packet), we will do it at after
> @@ -2561,6 +2593,17 @@ static int tun_xdp_one(struct tun_struct *tun,
>  		return -EIO;
>  	}
>  
> +	/* NAPI queue full: drop, and schedule NAPI so that it drains even if
> +	 * nothing in this batch gets queued
> +	 */
> +	if (tfile->napi_enabled &&
> +	    unlikely(tun_napi_queue_full(&tfile->sk.sk_write_queue))) {
> +		napi_schedule(&tfile->napi);
> +		put_page(virt_to_head_page(xdp->data));
> +		dev_core_stats_rx_dropped_inc(tun->dev);
> +		return 0;
> +	}
> +
>  	xdp_prog = rcu_dereference(tun->xdp_prog);
>  	if (xdp_prog) {
>  		if (gso->gso_type) {
> -- 
> 2.56.0
> 


