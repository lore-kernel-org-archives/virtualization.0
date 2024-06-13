Received: from mail-wr1-f66.google.com (mail-wr1-f66.google.com [209.85.221.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E567A14534B
	for <virtualization@lists.linux.dev>; Thu, 13 Jun 2024 14:49:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.66
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718290154; cv=none; b=Q3jgRSABwrQ5uFXc3z04vcGWHXWikCa9qKM2UHs0XQgmxl12zlw54FEm82mB0cRallDEjgI9DbSr+hpBIL7lrLTOO+KXnTg95enz96nvOEnbtWFZSsn2K0oocCHGABcJlxP86l4rzZrMZ16iejDgz5jHq9I/3Ue4fCNwRxwCv0E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718290154; c=relaxed/simple;
	bh=jl6jRSsRorbqeGrAfCD1Mg5hCP+HaCGsXUQF0b59Tvc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XMSMeFZn/BKLSKrYFvtSBNTYWWWnclpfg/0PUvqdQ8+sdSuAXVj2vqsxEmvXmUzpsrgXdRbOMkEqFN06bO8Jm170Z/EuuPoju2jAs7lGrKd8LXW2JNeuGgdN6bbfDNlKJdFhN7yKer4FOY4gErbE3C/Jktg0ulrQloEmqTEp/mc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us; spf=none smtp.mailfrom=resnulli.us; dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b=i7XpgQXX; arc=none smtp.client-ip=209.85.221.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=resnulli.us
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="i7XpgQXX"
Received: by mail-wr1-f66.google.com with SMTP id ffacd0b85a97d-35f1bc2ab37so1096617f8f.1
        for <virtualization@lists.linux.dev>; Thu, 13 Jun 2024 07:49:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1718290151; x=1718894951; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=wShLhYnuISf+2hpf/eQPXGR1lsTej2ilkcqXvyes8eo=;
        b=i7XpgQXX46K9wRhNTiMlhLKIC/+BnuAG2YgbtBoCTbFdMwp9zItaWoFDkSEVs8s1dP
         SFcIiimLLifB09hH+oRK6AnkBMhNLNPfJDxoUzXOM1OL5MVvyW9DK4RFE4hvGSMNiFoY
         6MifFsIA6xiv7UAeVZu3+N/TvKL0RVabgKVirKR7sj7C5UsPpJJORNLRvUyW9D6hEtch
         2gK3mRMptF8WYbzqWQt6Bu1JQoV703ZX473PW/UkGGlFxzFFTD8qVxg8T2ztVyeC3pJT
         yi0wslJTHAziW/SvLTHuPu/NhygUBkOaHduOj2ysEdW7Q+2Ws2JLP20rVlnTah4dlYil
         nmJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718290151; x=1718894951;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wShLhYnuISf+2hpf/eQPXGR1lsTej2ilkcqXvyes8eo=;
        b=YhgUvdtHVLGbbb62QDfbt+uKDeOddGv/yY2x8sXQh+ca/gsCwN8sDXjH9YA6Yu8Bgt
         5ufoHf713EhTaMhyoeob8Oj8yPDqL0LbY2QzuweshfxcV7jcjiqilDAWHPPCFYuVMEan
         1wf1hPavbV3CemGj0UCV+vvM5oIKrRF9eTvk4mGSP1U8d6Oa8/ySceSfu7qOTIbKjXA8
         3OjQGCn7OQBaZ7ikZLrwEsw8PMh0ttScVWllyril0ImyvebL4vK3B1xO0J5sZ+kMo1Nq
         SDcEjeDT64UU9/puK0b6Sdn92PkkcJmtGb+H459UUhWfrcFVMGj+gb+lT86JLKjk255f
         X5tw==
X-Forwarded-Encrypted: i=1; AJvYcCXv1s1xC1wp2odcnlIiU4sLwlL7HDJKawjnYZghT3+ohokkijhARfuVlzkT6vwfJlUq3VVreI9uPZ1hNsokVFUQT7HIPsgq6t0m9UGMkEU=
X-Gm-Message-State: AOJu0Yy2GbxaxQT03PBh3aJz667qfnnX+5IrzAnaFvtrPhrge+nVZ82H
	BAW8HtPTdyx4AKijse0F3taF5TZTeCzuVEB3hdmU7Q4i4iGTMYqHP7lGbpvKcko=
X-Google-Smtp-Source: AGHT+IG9qCPzOg3WirqPZDwbhAXKL6Yb6zrCLWQTcYobNNvr0Q7AYb3xE9mlM13c1KuhNPOrCXygng==
X-Received: by 2002:adf:db47:0:b0:360:71df:b157 with SMTP id ffacd0b85a97d-36071dfb2f1mr1921045f8f.56.1718290151141;
        Thu, 13 Jun 2024 07:49:11 -0700 (PDT)
Received: from localhost ([193.47.165.251])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3607509c8acsm1916907f8f.48.2024.06.13.07.49.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Jun 2024 07:49:10 -0700 (PDT)
Date: Thu, 13 Jun 2024 16:49:07 +0200
From: Jiri Pirko <jiri@resnulli.us>
To: Denis Arefev <arefev@swemel.ru>
Cc: "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	Eugenio =?iso-8859-1?Q?P=E9rez?= <eperezma@redhat.com>,
	virtualization@lists.linux.dev, linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org, Eric Dumazet <edumazet@google.com>,
	lvc-project@linuxtesting.org
Subject: Re: [PATCH v2] net: missing check virtio
Message-ID: <ZmsG41ezsAfok_fs@nanopsycho.orion>
References: <20240613095448.27118-1-arefev@swemel.ru>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240613095448.27118-1-arefev@swemel.ru>

Thu, Jun 13, 2024 at 11:54:48AM CEST, arefev@swemel.ru wrote:
>Two missing check in virtio_net_hdr_to_skb() allowed syzbot
>to crash kernels again
>
>1. After the skb_segment function the buffer may become non-linear
>(nr_frags != 0), but since the SKBTX_SHARED_FRAG flag is not set anywhere
>the __skb_linearize function will not be executed, then the buffer will
>remain non-linear. Then the condition (offset >= skb_headlen(skb))
>becomes true, which causes WARN_ON_ONCE in skb_checksum_help.
>
>2. The struct sk_buff and struct virtio_net_hdr members must be
>mathematically related.
>(gso_size) must be greater than (needed) otherwise WARN_ON_ONCE.
>(remainder) must be greater than (needed) otherwise WARN_ON_ONCE.
>(remainder) may be 0 if division is without remainder.
>
>offset+2 (4191) > skb_headlen() (1116)
>WARNING: CPU: 1 PID: 5084 at net/core/dev.c:3303 skb_checksum_help+0x5e2/0x740 net/core/dev.c:3303
>Modules linked in:
>CPU: 1 PID: 5084 Comm: syz-executor336 Not tainted 6.7.0-rc3-syzkaller-00014-gdf60cee26a2e #0
>Hardware name: Google Compute Engine/Google Compute Engine, BIOS Google 11/10/2023
>RIP: 0010:skb_checksum_help+0x5e2/0x740 net/core/dev.c:3303
>Code: 89 e8 83 e0 07 83 c0 03 38 d0 7c 08 84 d2 0f 85 52 01 00 00 44 89 e2 2b 53 74 4c 89 ee 48 c7 c7 40 57 e9 8b e8 af 8f dd f8 90 <0f> 0b 90 90 e9 87 fe ff ff e8 40 0f 6e f9 e9 4b fa ff ff 48 89 ef
>RSP: 0018:ffffc90003a9f338 EFLAGS: 00010286
>RAX: 0000000000000000 RBX: ffff888025125780 RCX: ffffffff814db209
>RDX: ffff888015393b80 RSI: ffffffff814db216 RDI: 0000000000000001
>RBP: ffff8880251257f4 R08: 0000000000000001 R09: 0000000000000000
>R10: 0000000000000000 R11: 0000000000000001 R12: 000000000000045c
>R13: 000000000000105f R14: ffff8880251257f0 R15: 000000000000105d
>FS:  0000555555c24380(0000) GS:ffff8880b9900000(0000) knlGS:0000000000000000
>CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
>CR2: 000000002000f000 CR3: 0000000023151000 CR4: 00000000003506f0
>DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
>DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
>Call Trace:
> <TASK>
> ip_do_fragment+0xa1b/0x18b0 net/ipv4/ip_output.c:777
> ip_fragment.constprop.0+0x161/0x230 net/ipv4/ip_output.c:584
> ip_finish_output_gso net/ipv4/ip_output.c:286 [inline]
> __ip_finish_output net/ipv4/ip_output.c:308 [inline]
> __ip_finish_output+0x49c/0x650 net/ipv4/ip_output.c:295
> ip_finish_output+0x31/0x310 net/ipv4/ip_output.c:323
> NF_HOOK_COND include/linux/netfilter.h:303 [inline]
> ip_output+0x13b/0x2a0 net/ipv4/ip_output.c:433
> dst_output include/net/dst.h:451 [inline]
> ip_local_out+0xaf/0x1a0 net/ipv4/ip_output.c:129
> iptunnel_xmit+0x5b4/0x9b0 net/ipv4/ip_tunnel_core.c:82
> ipip6_tunnel_xmit net/ipv6/sit.c:1034 [inline]
> sit_tunnel_xmit+0xed2/0x28f0 net/ipv6/sit.c:1076
> __netdev_start_xmit include/linux/netdevice.h:4940 [inline]
> netdev_start_xmit include/linux/netdevice.h:4954 [inline]
> xmit_one net/core/dev.c:3545 [inline]
> dev_hard_start_xmit+0x13d/0x6d0 net/core/dev.c:3561
> __dev_queue_xmit+0x7c1/0x3d60 net/core/dev.c:4346
> dev_queue_xmit include/linux/netdevice.h:3134 [inline]
> packet_xmit+0x257/0x380 net/packet/af_packet.c:276
> packet_snd net/packet/af_packet.c:3087 [inline]
> packet_sendmsg+0x24ca/0x5240 net/packet/af_packet.c:3119
> sock_sendmsg_nosec net/socket.c:730 [inline]
> __sock_sendmsg+0xd5/0x180 net/socket.c:745
> __sys_sendto+0x255/0x340 net/socket.c:2190
> __do_sys_sendto net/socket.c:2202 [inline]
> __se_sys_sendto net/socket.c:2198 [inline]
> __x64_sys_sendto+0xe0/0x1b0 net/socket.c:2198
> do_syscall_x64 arch/x86/entry/common.c:51 [inline]
> do_syscall_64+0x40/0x110 arch/x86/entry/common.c:82
> entry_SYSCALL_64_after_hwframe+0x63/0x6b
>
>Found by Linux Verification Center (linuxtesting.org) with Syzkaller
>
>Signed-off-by: Denis Arefev <arefev@swemel.ru>

Could you please provide "Fixes" blaming the commit which itroduced the
bug?


>---
> V1 -> V2: incorrect type in argument 2
> include/linux/virtio_net.h | 11 +++++++++++
> 1 file changed, 11 insertions(+)
>
>diff --git a/include/linux/virtio_net.h b/include/linux/virtio_net.h
>index 4dfa9b69ca8d..d1d7825318c3 100644
>--- a/include/linux/virtio_net.h
>+++ b/include/linux/virtio_net.h
>@@ -56,6 +56,7 @@ static inline int virtio_net_hdr_to_skb(struct sk_buff *skb,
> 	unsigned int thlen = 0;
> 	unsigned int p_off = 0;
> 	unsigned int ip_proto;
>+	u64 ret, remainder, gso_size;
> 
> 	if (hdr->gso_type != VIRTIO_NET_HDR_GSO_NONE) {
> 		switch (hdr->gso_type & ~VIRTIO_NET_HDR_GSO_ECN) {
>@@ -98,6 +99,16 @@ static inline int virtio_net_hdr_to_skb(struct sk_buff *skb,
> 		u32 off = __virtio16_to_cpu(little_endian, hdr->csum_offset);
> 		u32 needed = start + max_t(u32, thlen, off + sizeof(__sum16));
> 
>+		if (hdr->gso_size) {
>+			gso_size = __virtio16_to_cpu(little_endian, hdr->gso_size);
>+			ret = div64_u64_rem(skb->len, gso_size, &remainder);
>+			if (!(ret && (hdr->gso_size > needed) &&
>+						((remainder > needed) || (remainder == 0)))) {
>+				return -EINVAL;
>+			}
>+			skb_shinfo(skb)->tx_flags |= SKBFL_SHARED_FRAG;
>+		}
>+
> 		if (!pskb_may_pull(skb, needed))
> 			return -EINVAL;
> 
>-- 
>2.25.1
>
>
