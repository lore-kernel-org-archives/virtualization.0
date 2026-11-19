Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.161.44
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795117005;
	b=SDiQI0UEM4rAtm1hHonW9J+/C/zSeaH6tV5Dp8Ia8kvLD77L+QsVzffOpESvatmBESUJ
	 Crtk4XJfRGiWm7YA9tDE8GZK6zzjjgE8TnNl+2Gj1DO0GZ0GXXVcrqjk4tyw2XowZEv4r
	 CBybxXW1BEQHp+XZAFJV6AaqnVtVAPGYTY42KtlnZv4EQL3PC7i5GTTLRb2MxXEqRtmj/
	 YRZ9vBEVbneVqiXiqQBFSYv/dELp8+kvHRfIxUCf0oxUGdDRnmtk2OC526XRTYAKGz1UG
	 yZXY9pxR9cSVf29svK6DqB0X5GdcfWIm7zauz/HgGHjKV5COdpCNxmCxl0w8G9HeVJA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795117005;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=Z/2L9IovMD4zBIgZcsGeAkwPGqc72zduF1TmecAsP2U=;
	b=tl1I7n9zFu9lRf9MqXdrt3J4bOhg5G0sU1xMeiMZCEE1qdNG/1yo7eGH1h2Gq9tl1srv
	 GZdMNRjX/fz396E1+e4lD3h/VYJ0IDsU7287ymlX9uqIDMYb1i3J7tLpTQ4M1Gd+sERgH
	 3PcsxXYxq38jaNHCNiE6VnIVZB+WGTB8V6cObV/wlQVR5wG0Y+Wbf8OELNZ1LWo6OVDMz
	 iMKrRlcrFtefwBDiVCFQ2f0afu8l4jAmGOnZ98jFNIjzE6MZX24kUCkxU8svxoX9CrtnI
	 o8uzntHxriBJ8IFPeAIokGel5abt9MQSGOmWOubl5C6nW6WRJtV3M0RrehMtyIb1KQg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=EZRYV2a8;
	arc=none smtp.remote-ip=209.85.161.44
Received: from mail-oo1-f44.google.com (mail-oo1-f44.google.com [209.85.161.44])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB2EA606A326
	for <virtualization@lists.linux.dev>; Thu, 19 Nov 2026 19:36:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org EB2EA606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=EZRYV2a8
Received: by mail-oo1-f44.google.com with SMTP id 006d021491bc7-71ad099391dso57557eaf.3
        for <virtualization@lists.linux.dev>; Thu, 19 Nov 2026 11:36:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795117004; x=1795721804; darn=lists.linux.dev;
        h=content-transfer-encoding:content-type:mime-version:subject
         :references:in-reply-to:message-id:cc:to:from:date:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=Z/2L9IovMD4zBIgZcsGeAkwPGqc72zduF1TmecAsP2U=;
        b=EZRYV2a8iGbvb+eINCz0ARe9gLaOYSO77YsLAIugb4QQ94WSzh/3l1cwv4zAkQhjyp
         VpsF3J9K4En7C0r+N/7hRjYOeEx7h7pIexJjsBnr66OGbWXvC/FFXxuqbrmgmka06RS3
         IKE79yqAJjzkbCkwnCx+NCb5y5WKRMMGO2TPm+givXvue6g7Qy+g2UNMg2Fi1ITG0wBe
         Bh8VBSPI/N/W7sLsgf/8mWXMxGRXl/RVDOQtXKY6NRhFn+EiSwMVnSMvv8Bt7k+9wsaR
         ttzvvPBBjl7UHXo5Qhkfpv+8KcDoz52ALZIyWWmbN+8yyagnm46UjpSU/A21k46V4Brz
         ePgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795117004; x=1795721804;
        h=content-transfer-encoding:content-type:mime-version:subject
         :references:in-reply-to:message-id:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Z/2L9IovMD4zBIgZcsGeAkwPGqc72zduF1TmecAsP2U=;
        b=P4bikBxewrwOJWNes8Jo/Y2viw//89FI012aypsyLzgeMxft3XExPogm/8D9T6LOtL
         Lg5s55gYJmecg+UHqz+H3VWNSze13Xnq16HTYxLXFQj86FGOTQMp/wu90IGZLgdz7zOl
         NYX+74nUkGNY5AQdqCcM+SL2f5lXwuwsDdCWpRSIkn+x+gwDA3a+PjOxPcysIRcUpQsk
         hsaJZCKZpUa5IZw+iyJlGOwFV/BxMTF5QNMEU9hZrOPjq0+jwQ/M9P16dv2v1J+8byR3
         tg9iWUuMWynPhmQZISSxLlS1QtNstmotKMFHbNertpuCNsWr9g9YqI62baV6HK5rv1Wy
         PkCQ==
X-Forwarded-Encrypted: i=1; AL+hErGC4DYysaq0lrlX6oE7RBTTifEilOh3MMnlx/5dL68fwmHl1+1u3obqeooDYafO+GPAdlDgp76B0tYpdU5YdA==@lists.linux.dev
X-Gm-Message-State: APuU4Z+9oCm7uu8K4bdDAe7YEoJNc2GzK09iIlzVFItJmJYco+nyvFFW
	vyydzmpv7I+qJOzrvoV4DJ9y0L2q8IezNyHUxCbaRJwv+72valSHm1AO
X-Gm-Gg: AYBFou2h9pcOucfyMBMHjhdUt20fY7KpuMkyuS+MBoJBZFQTqhLfvNjybs8NV3n/K3p
	1t6x+l91wdMxFGWofKNuuFsQ+Dqqj+ZL9EtQ11toxJB/ux2NATaosn8YXa+GVBxuqnmjz7yFfpW
	5/qR5AGGjsDqAY48b9NHzLDUVNUBPjI6rcODpFBwIa1DH7ATOv8/JFZBBdtmXUl9xAlCkUWj6VQ
	i+Fkl12IF2sC7ZTEGN+by+b2L65G5lFXx+d9Qoje4moYcjWd1z2h5H3un55eyTo7oeDeTM5gwSt
	GWP27vw3zuk+anLxgC8eyni3bY+WqupZoyxtfrLUtEoqUnXSeMqIyH1YRLg9hZhqOWuUp8uEy7Y
	Q6HwmSfmcXMyCoUuV4m+JOE/VXu1Ctdu7KBMZ+039gZh9UF3+nptGTJ4k/CToeaTDC/92kg5d9G
	5YhXHUgJjemwSFAQwUsPPEb48ONHmAmJ54Pyh6W7xkdJQqkk0FQelSRGhwMmBqfDzOhUD+1eFSk
	oGYQATuN/t9oKAYUHLNkiprAKqfIztQ6gLZKAUwKJyLRFKc2SO5quZXKINoSjAEPblCCkQPiyG/
	3mVrfhSYmDk8tgFfwodQlV5neN/a8VseuKZEFbpqe8p8Bok/oWY5//WAShJ4z2W0wuw3/f7Mb4Z
	PYIFGW7w6IRar/frtRNxPNA1Sy7gjGBiu1PItDfA6JML4kTeeQl2jvfHAgQhOcOIyfH4u83SjFy
	2hOlWCtStU/Q==
X-Received: by 2002:a05:6820:1c98:b0:6b1:bb82:f7a3 with SMTP id 006d021491bc7-71b39209557mr740286eaf.5.1795117003758;
        Thu, 19 Nov 2026 11:36:43 -0800 (PST)
Received: from gmail.com (15.60.86.34.bc.googleusercontent.com. [34.86.60.15])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-863168dd6e7sm435223a34.12.2026.11.19.11.36.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Nov 2026 11:36:43 -0800 (PST)
Date: Thu, 19 Nov 2026 14:36:42 -0500
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
 ast@kernel.org, 
 daniel@iogearbox.net, 
 hawk@kernel.org, 
 john.fastabend@gmail.com, 
 sdf@fomichev.me, 
 maheshb@google.com, 
 peterpenkov96@gmail.com, 
 netdev@vger.kernel.org, 
 virtualization@lists.linux.dev, 
 bpf@vger.kernel.org
Message-ID: <willemdebruijn.kernel.24840892273e@gmail.com>
In-Reply-To: <20261119153056.353156-1-antonio@mandelbit.com>
References: <20261119153056.353156-1-antonio@mandelbit.com>
Subject: Re: [PATCH net v7] tun: bound the NAPI receive queue
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
> an unbounded list. When the poll runs asynchronously (threaded NAPI or
> ksoftirqd) and is slower than the writer, the queue grows until the
> system runs out of memory. An unprivileged user can do this from its own
> user and network namespaces, and the queued skbs are not charged to its
> memcg: in a test VM, a uid 1000 process limited to 128 MB caused a
> global OOM in ~6 seconds. The socket send buffer does not help: tun sets
> it to INT_MAX by default, the build_skb() path is only used while it is
> INT_MAX, and the XDP batch path never checks it.
> 
> Drop packets once more than netdev_max_backlog of them are queued, like
> enqueue_to_backlog() does, and count them as rx_dropped; the write still
> reports success, as for a full backlog. The check sits where packets are
> queued for NAPI, in tun_get_user() and in tun_xdp_one() for the batches
> vhost-net passes, so packets consumed by XDP or delivered through
> IFF_NAPI_FRAGS are not affected. A dropped zerocopy skb completes its
> buffer when freed. The check is lockless, so concurrent writers can each
> still add one packet.
> 
> The NAPI poll moved the whole queue out, processed up to its budget and
> put the rest back: while it ran, the queue looked empty to writers, so
> with the poll on another CPU the backlog could still grow without limit.
> Take at most budget packets instead: the rest stays on the queue writers
> check.
> 
> Dropping also schedules NAPI. vhost-net sends with MSG_MORE while it has
> more packets, and tun_get_user() schedules NAPI only for a packet
> without it or once more than NAPI_POLL_WEIGHT are queued. With a
> netdev_max_backlog below that, the queue fills first and the packet
> without MSG_MORE is dropped too: nothing would schedule NAPI, and the
> queued packets, with zerocopy also their buffers, would wait forever.
> 
> Reproducer, as an unprivileged user in a new user and network
> namespace, without kernel modifications or fault injection:
>   ip tuntap add t0 mode tun; ip addr add 10.11.0.1/24 dev t0
>   ip link add d0 type dummy; ip addr add 10.20.0.1/24 dev d0
>   ip link set t0 up; ip link set d0 up; sysctl net.ipv4.ip_forward=1
>   install ~500 iptables FORWARD rules, to slow down the poll, and a
>   MASQUERADE rule on d0
>   open t0 with IFF_TUN | IFF_NO_PI | IFF_NAPI
>   echo 1 > /sys/class/net/t0/threaded
>   write() 1400-byte IPv4 packets for 10.20.0.2 in a loop
> 
> Found by code inspection while analysing the performance of the tun
> write path. Tested in an x86-64 VM on net, with 1 and 2 vCPUs: the
> reproducer causes a global OOM without the patch, while with it memory
> use stays flat and the forwarding rate is unchanged; the tun kselftest
> passes; a local vhost-net test of the batch, copy and zerocopy paths
> with netdev_max_backlog set to 8 passes, and fails without the patch;
> an XDP program on the device sees every packet while the excess is
> dropped.
> 
> Still open: neither the packet size nor the queued memory is bounded,
> and the skbs are not charged to the writer's memcg. A single write can
> create an skb of several hundred KB, so even one queue can hold a lot,
> and IFF_MULTI_QUEUE (allowed in a user namespace) and more devices
> multiply it. This bounds the queue as enqueue_to_backlog() bounds the
> per-CPU backlog; charging the skbs to the writer is left to a follow-up.
> 
> Fixes: 943170998b20 ("tun: enable NAPI for TUN/TAP driver")
> Signed-off-by: Antonio Quartulli <antonio@mandelbit.com>

Reviewed-by: Willem de Bruijn <willemb@google.com>
