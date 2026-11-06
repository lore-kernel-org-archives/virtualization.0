Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.217.43
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793999052;
	b=TINDVu+2zf6EVjk+5VxNJYarSD3b10RNY4U3/H5grodj13cTWVWp8CC0TSLUTjT3TaKC
	 xuN3LL3pbojiA/+6N9TXo13BDRmcyF0iIbA0HSJx8ZPB2etJgUAt+UQQcNx/XUNuWx/xs
	 +aG1vEa0r3A7sZ1yX0QKjzFQ9VTQK+0m3k+T5W1eu9oNmss9TTda4iHIUyZN0/oBMGt04
	 5gnh6sX2TOchuZc5kSPzdalJwBRS5fVkEKURym+T4GRKox2ZDw3IX8KzfTKDFDMk6aeC5
	 Lgz/CPMT8kY2GWwya3qXbRw/07X6ilhhPOGMeojJZVcwXBIkYZDn+xRC1ViFQShGv1A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793999052;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=9rbAT6HOHtgTNmvUZ4uTgxskj8ClF6GOt0gfNlKXaVw=;
	b=UW/RP3SzBOZTHhR7phtmeY8vanp9KQhPdI1xF8+6NLgIBM/ga/LnIc4fDeeEDfcKE6wu
	 GrIurYkI8yv25xl81TIsDXf8yAe+dEkzA96Ehhj+XLF64IkbZjSpOQ00XzeM19KI12Pz3
	 vIlXdXuEIUtj0p5PGoMTi0PBKefpG1WcKDl1UFW21SPQjAAo5aDPkyAI4807oop5M8JQ5
	 DePVxckYG4heh7m/HF41x4P3/MfKm13v3lIM5t+qghXzShwvjWFAQ2pL7PwD52vRvi/CX
	 AFVkDZPIXnavPtbVABmp4OdVDK6CTC92Iy5jSkjT335qD00lbAD0LEUzFZ9aOqdO56A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=c1EGlj5Q;
	arc=none smtp.remote-ip=209.85.217.43
Received: from mail-vs1-f43.google.com (mail-vs1-f43.google.com [209.85.217.43])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68E5B606A333
	for <virtualization@lists.linux.dev>; Fri,  6 Nov 2026 21:04:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 68E5B606A333
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=c1EGlj5Q
Received: by mail-vs1-f43.google.com with SMTP id ada2fe7eead31-7d06763335aso373664137.2
        for <virtualization@lists.linux.dev>; Fri, 06 Nov 2026 13:04:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793999050; x=1794603850; darn=lists.linux.dev;
        h=content-transfer-encoding:content-type:mime-version:subject
         :references:in-reply-to:message-id:cc:to:from:date:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=9rbAT6HOHtgTNmvUZ4uTgxskj8ClF6GOt0gfNlKXaVw=;
        b=c1EGlj5QBG/qVypv5pjmgBkPAljTAojgbLIgflvQFchrKsdt6dqYBqIl0w5heaOiFp
         NGLJ1Dsg2hiq7Etz28ZKARrDgzgJFXHEO08Ej6I0PLKcDMdVK+cVbdgEZPuQrnfhO2x4
         tPGqV7qnEUpV4hr54N7oXTB/N8WDsNIYV4k1Tlxj1U/FsKa3VMwEykZo2K/w6lCuVIN5
         +GHYu+mMoQNCaclAdNP6/lzsIq16De1DKUpHJAGzFhdIkp8TH5hpep9tEhLUKN5JzWxG
         TGRZfN7Bedo+IKXHoiQdqKw1KOm+Kw+xyMQ0HuVWlLVW1LYhRUxJxUOYF3dXdNW41B3S
         bx+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793999050; x=1794603850;
        h=content-transfer-encoding:content-type:mime-version:subject
         :references:in-reply-to:message-id:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=9rbAT6HOHtgTNmvUZ4uTgxskj8ClF6GOt0gfNlKXaVw=;
        b=DYuyyHLgWjBfvjQRjqW5/ic4vArKi/nvhPuSA1+w4wRm8wDfQ/pkxia0aQvqxPJC2U
         +sycIUIYkLXLK2xTWv6eW6NECd73Yk1j8Pvd6s01ALYDikG25FlH1SZQrqhOMC9DKU1b
         OCiDQBqDa2QqHgX42QexhI1N6FWcUxMNRMHSyU1OPYbgJFldgn1adiXpTSf9NYZfGm2r
         3IkUIva6a5f3w4haAhjBerHxtZzyS0mczNHWRpqPdtt8EZSVUjI+xB1vmIKTguKninph
         rKsaW1qHCiFs6PwG7VQACWnPdR8fuUcAYFzNgRBgQ8krNeTP7O83kM4Nv8p/a2cCAaz7
         4kEg==
X-Forwarded-Encrypted: i=1; AL+hErGvYIi5UdGT9UA0MvyS2nFPQsGu+e8uhio8Ot+jhpY03+qvjW2Xb5+p7GeQLvGY4c32VybOeFweV7QysLEKUA==@lists.linux.dev
X-Gm-Message-State: APuU4Z/vjxtgZcXTFft3nR7lPZQNdZ+LB21Bdq89UY4jSd0vebgzkWic
	SEBn/WD8v6fNBscXWixE+28vfkUkim6i1tl4hFK6ZmV8RoTn56gb18tx
X-Gm-Gg: AYBFou2uNMgZe7HDd996JWN08jcDTGx7ug1TXoNR4nJnvsNWfCZHu5CPoyQLGnjMRdi
	aKDpdB9hROh7Co051+c3MgSC+tHExCwDiLXEgibj+S5MHZEO8nu0iPrKX9pGlhSTTjO6EYHoEkg
	9jOXz7/ZHJguJU1cZp0svJY3P0k5Ocl3FtEXWoKEpcl53I+fM+16LfhKwIFt/CLFqO0ukzBiH43
	YRlcOq9ToST/Vwrrv9OlRuAAWA/EY7jwmjwHqyIoy90FoD5zueWGQjk5f9GSFtrDvyM2PWwBH8j
	8nZYNfIuvOxOWBidrtcQ7U/MUjHLDEYE4jqylX3OJfFOR9H1jQQTP9dLJVomJwloXxaCNXewkTF
	QX752+7RG48e3S+8XLGQ+OSPdAcAi0cp5No98SBmd6bzgmxFupJvDEv+xRNAeUWH+kz52LE7H3W
	oELZeXIa/qXO9I4PS2mAY3ke82MNKNHgYnitlqFWJdpC9g7gGlt++vNxrGawO+hjPdLVg5z+VON
	e+GYEP+aOJLPFOqYOKFmB4vWsgrbAa0MtDgJ7vmqou8L1gdgP75oTlbd8Bek8weHoBhY8uddu1V
	DAOSgqWAufIk8HTR/uleh5V542Un9+noIJLgnngIKrnafs3gvihDyXCy4Cm7e1pAXfhNCknYPpX
	2XwkZdxMbvqpeJQxNj8BekvKYbPDJcsImTswUpG+UWtxrxGOhcxhNbWJn/8Q01trb40cbMos=
X-Received: by 2002:a05:6102:6cc:b0:7d2:7c63:59fd with SMTP id ada2fe7eead31-7d2a169a84amr1938421137.34.1793999050220;
        Fri, 06 Nov 2026 13:04:10 -0800 (PST)
Received: from gmail.com (223.230.150.34.bc.googleusercontent.com. [34.150.230.223])
        by smtp.gmail.com with ESMTPSA id ada2fe7eead31-7d2a89a75b2sm2222405137.5.2026.11.06.13.04.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Nov 2026 13:04:09 -0800 (PST)
Date: Fri, 06 Nov 2026 16:04:08 -0500
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
Message-ID: <willemdebruijn.kernel.20268598d87e6@gmail.com>
In-Reply-To: <20261103142232.1869185-2-antonio@mandelbit.com>
References: <20261103142232.1869185-1-antonio@mandelbit.com>
 <20261103142232.1869185-2-antonio@mandelbit.com>
Subject: Re: [PATCH net v4 1/2] tun: bound the NAPI receive queue
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
> enqueue_to_backlog() does, and count them as rx_dropped: before
> allocating and copying them where possible, and again under the queue
> lock before queueing. This covers write(), sendmsg() and the batches of
> XDP buffers vhost-net passes to tun_sendmsg(), which share the queue.
> Zerocopy buffers of packets dropped early are completed.
> 
> The NAPI poll moves the whole queue out, processes up to its budget and
> puts the rest back: while it runs, the queue looks empty to writers, so
> with the poll on another CPU the backlog still grows without limit. Keep
> the leftovers on a queue of their own and take the next batch only once
> it is empty, like process_backlog() does, so that neither queue holds
> more than the limit.
> 
> Dropping because the queue is full also schedules NAPI, in all three
> places. vhost-net sends with MSG_MORE while it has more packets, and
> tun_get_user() schedules NAPI only after the last one or once more than
> NAPI_POLL_WEIGHT are queued. With a netdev_max_backlog below that, the
> queue would not drain until vhost-net ran out of packets; with zerocopy,
> vhost-net never would, as it stops sending when too many queued buffers
> are pending.
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
> for 15 seconds, memory use stays flat and the forwarding rate is
> unchanged; the tun kselftest passes, as it does without the patch; and
> the tun_vhost kselftest added by the next patch, which drives the
> vhost-net batch, copy and zerocopy paths, passes, while it fails without
> the patch.
> 
> Still open: the limit counts packets rather than bytes and applies per
> queue, up to about twice the limit can be in flight (queued plus taken
> by the poll), and the queued skbs are still not charged to the writer's
> memcg.
> 
> Fixes: 943170998b20 ("tun: enable NAPI for TUN/TAP driver")
> Signed-off-by: Antonio Quartulli <antonio@mandelbit.com>

This is quite a complex solution.

Can we perhaps simplify it a bit? For instance:

On tx only keep the lockless check. Number of packets that can bypass
that is bounded, by the number of competing threads.

On rx avoid the new queue, by not temporary presenting an empty queue:

        spin_lock(&queue->lock);
        if (skb_queue_len(queue) <= budget) {
            skb_queue_splice_tail_init(queue, &process_queue);
        } else {
            while (skb_queue_len(&process_queue) < budget &&
                   (skb = __skb_dequeue(queue)))
                __skb_queue_tail(&process_queue, skb);
        }
        spin_unlock(&queue->lock);




> ---
>  drivers/net/tun.c | 82 +++++++++++++++++++++++++++++++++++++++--------
>  1 file changed, 68 insertions(+), 14 deletions(-)
> 
> diff --git a/drivers/net/tun.c b/drivers/net/tun.c
> index 770b8fe085c3..ea99ee0aee2b 100644
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
> @@ -140,6 +141,8 @@ struct tun_file {
>  		unsigned int ifindex;
>  	};
>  	struct napi_struct napi;
> +	/* NAPI poll only: skbs taken off sk_write_queue, not yet received */
> +	struct sk_buff_head napi_process_queue;
>  	bool napi_enabled;
>  	bool napi_frags_enabled;
>  	struct mutex napi_mutex;	/* Protects access to the above napi */
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
> +
>  static int tun_napi_receive(struct napi_struct *napi, int budget)
>  {
>  	struct tun_file *tfile = container_of(napi, struct tun_file, napi);
> +	struct sk_buff_head *process_queue = &tfile->napi_process_queue;
>  	struct sk_buff_head *queue = &tfile->sk.sk_write_queue;
> -	struct sk_buff_head process_queue;
>  	struct sk_buff *skb;
>  	int received = 0;
>  
> -	__skb_queue_head_init(&process_queue);
> -
> -	spin_lock(&queue->lock);
> -	skb_queue_splice_tail_init(queue, &process_queue);
> -	spin_unlock(&queue->lock);
> -
> -	while (received < budget && (skb = __skb_dequeue(&process_queue))) {
> +	while (received < budget) {
> +		/* Refill only when empty: leftovers are not put back on the
> +		 * queue writers check, so neither queue exceeds the limit.
> +		 */
> +		if (skb_queue_empty(process_queue)) {
> +			spin_lock(&queue->lock);
> +			skb_queue_splice_tail_init(queue, process_queue);
> +			spin_unlock(&queue->lock);
> +			if (skb_queue_empty(process_queue))
> +				break;
> +		}
> +		skb = __skb_dequeue(process_queue);
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
> @@ -572,6 +584,8 @@ static void tun_queue_purge(struct tun_file *tfile)
>  		tun_ptr_free(ptr);
>  
>  	skb_queue_purge(&tfile->sk.sk_write_queue);
> +	/* NAPI is disabled by now */
> +	__skb_queue_purge(&tfile->napi_process_queue);
>  	skb_queue_purge(&tfile->sk.sk_error_queue);
>  }
>  
> @@ -1856,6 +1870,23 @@ static ssize_t tun_get_user(struct tun_struct *tun, struct tun_file *tfile,
>  			zerocopy = true;
>  	}
>  
> +	/* NAPI queue full: drop before allocating, and schedule NAPI, which a
> +	 * MSG_MORE sender may not have done yet. Rechecked under the lock.
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
> +		}
> +		dev_core_stats_rx_dropped_inc(tun->dev);
> +		return total_len;
> +	}
> +
>  	if (!frags && tun_can_build_skb(tun, tfile, len, noblock, zerocopy)) {
>  		/* For the packet that is not easy to be processed
>  		 * (e.g gso or jumbo packet), we will do it at after
> @@ -2045,6 +2076,17 @@ static ssize_t tun_get_user(struct tun_struct *tun, struct tun_file *tfile,
>  			goto free_skb;
>  		}
>  
> +		/* NAPI queue full: drop, as above */
> +		if (unlikely(tun_napi_queue_full(queue))) {
> +			spin_unlock(&queue->lock);
> +			napi_schedule(&tfile->napi);
> +			local_bh_enable();
> +			rcu_read_unlock();
> +			dev_core_stats_rx_dropped_inc(tun->dev);
> +			drop_reason = SKB_DROP_REASON_FULL_RING;
> +			goto free_skb;
> +		}
> +
>  		__skb_queue_tail(queue, skb);
>  		queue_len = skb_queue_len(queue);
>  		spin_unlock(&queue->lock);
> @@ -2649,6 +2691,17 @@ static int tun_xdp_one(struct tun_struct *tun,
>  			return -EBUSY;
>  		}
>  
> +		/* NAPI queue full: drop, and schedule NAPI so that it drains
> +		 * even if nothing in this batch gets queued
> +		 */
> +		if (unlikely(tun_napi_queue_full(queue))) {
> +			spin_unlock(&queue->lock);
> +			napi_schedule(&tfile->napi);
> +			kfree_skb_reason(skb, SKB_DROP_REASON_FULL_RING);
> +			dev_core_stats_rx_dropped_inc(tun->dev);
> +			return 0;
> +		}
> +
>  		__skb_queue_tail(queue, skb);
>  		spin_unlock(&queue->lock);
>  		ret = 1;
> @@ -3571,6 +3624,7 @@ static int tun_chr_open(struct inode *inode, struct file * file)
>  	}
>  
>  	mutex_init(&tfile->napi_mutex);
> +	__skb_queue_head_init(&tfile->napi_process_queue);
>  	RCU_INIT_POINTER(tfile->tun, NULL);
>  	tfile->flags = 0;
>  	tfile->ifindex = 0;
> -- 
> 2.56.0
> 


