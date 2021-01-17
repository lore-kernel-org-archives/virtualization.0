Return-Path: <SRS0=cF9L=GU=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.5 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2441BC433DB
	for <virtualization@archiver.kernel.org>; Sun, 17 Jan 2021 21:55:47 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A6F7C224DE
	for <virtualization@archiver.kernel.org>; Sun, 17 Jan 2021 21:55:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A6F7C224DE
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 37F8B85BD5;
	Sun, 17 Jan 2021 21:55:46 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id KXzVm2xbsrTv; Sun, 17 Jan 2021 21:55:45 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 9D9A1856BF;
	Sun, 17 Jan 2021 21:55:45 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 7943FC088B;
	Sun, 17 Jan 2021 21:55:45 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 09221C013A
 for <virtualization@lists.linux-foundation.org>;
 Sun, 17 Jan 2021 21:55:44 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by hemlock.osuosl.org (Postfix) with ESMTP id E347887060
 for <virtualization@lists.linux-foundation.org>;
 Sun, 17 Jan 2021 21:55:43 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 4e0jWn6b-jbH
 for <virtualization@lists.linux-foundation.org>;
 Sun, 17 Jan 2021 21:55:42 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail-io1-f49.google.com (mail-io1-f49.google.com
 [209.85.166.49])
 by hemlock.osuosl.org (Postfix) with ESMTPS id C713E8705B
 for <virtualization@lists.linux-foundation.org>;
 Sun, 17 Jan 2021 21:55:42 +0000 (UTC)
Received: by mail-io1-f49.google.com with SMTP id y19so29261453iov.2
 for <virtualization@lists.linux-foundation.org>;
 Sun, 17 Jan 2021 13:55:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=date:from:to:cc:message-id:in-reply-to:references:subject
 :mime-version:content-transfer-encoding;
 bh=ctvjXGdaXDC97qx0Qw/h1S7m6/ENUO8dsG8lsqvyMR0=;
 b=Zn/utZQ2LyIY5hM+pKdrZ/so6TF+Ir1ZPEUjcGAhnl0ygr7GqTWHs96fxf2oQkhbT/
 L5UHoSiHCvvSjMhcAIOGfFUiT2Tx5bMDSVEBR8/nANpjAya2/g3K4wcAYytV3HA/lMek
 yc5dWAD+O/VbXmCL2X89HjaAPS2ZgTttceh+e765INTJHXEbLVP/mhYfIsToArB0n9WF
 GgMLKXZCbcP3Z7v7/j10+SNgIvyjixn4lYcWAZFy/nrZzg98zVZJGcT7seB8JTwdGLm6
 44tXgaP65moG4R339HpOwq2xUmckg5pH0dCabNMi7NCZ86s/uU6Qh0b1QJhMQorGWnOe
 tciw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:message-id:in-reply-to
 :references:subject:mime-version:content-transfer-encoding;
 bh=ctvjXGdaXDC97qx0Qw/h1S7m6/ENUO8dsG8lsqvyMR0=;
 b=UxLgMaE8Z3uPRcD7gQT4dhL8pVxQzYWrWsl7RaYMpjXd3tH6UwmVeIMXRlSkzDbOCT
 cNjjnYjWZ3r302HdDYLDOpftrwHG4RiSmpOPuvAhqjgWrgWEbSLV8G/Z/CtrHzwebt22
 qXdRLHahQg6wxrV/emZU8eXIgzh/P/lf1DqAkXBKyDG0Y2zM3dRT2kzmCr2B+mASjj6t
 acWtlU4jUf7aRNtOj3ZchHfELVslJ7PHtqvIPbKEKCkReeSmSM4S0nBxBWuVraCqckwF
 YDjeCBbLyrbDsuEJkYxzElhQu8J+SBMgDX7+xws3WhVZJyvlnm9mR0twibUEECHpHqNW
 An5g==
X-Gm-Message-State: AOAM530khxv4Q/FI/uPE2ymG03Rz3P3Wve+n3tgQp/K0fMlaj+yoPZir
 N/j8JdWKjSTI/gz61mS9Iwc=
X-Google-Smtp-Source: ABdhPJziosWOSWluRVKVQr/5EZMKm/WaIh6/0ez4lejrg2hLALeDDiyMzCvCUiGtxvOxP2dfLX5GrA==
X-Received: by 2002:a05:6e02:934:: with SMTP id
 o20mr4457175ilt.211.1610920542130; 
 Sun, 17 Jan 2021 13:55:42 -0800 (PST)
Received: from localhost ([172.243.146.206])
 by smtp.gmail.com with ESMTPSA id p126sm2880937iof.55.2021.01.17.13.55.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 17 Jan 2021 13:55:41 -0800 (PST)
Date: Sun, 17 Jan 2021 13:55:32 -0800
From: John Fastabend <john.fastabend@gmail.com>
To: Xuan Zhuo <xuanzhuo@linux.alibaba.com>, 
 netdev@vger.kernel.org
Message-ID: <6004b254ce7_2664208d0@john-XPS-13-9370.notmuch>
In-Reply-To: <579fa463bba42ac71591540a1811dca41d725350.1610764948.git.xuanzhuo@linux.alibaba.com>
References: <579fa463bba42ac71591540a1811dca41d725350.1610764948.git.xuanzhuo@linux.alibaba.com>
Subject: RE: [PATCH bpf-next] xsk: build skb by page
Mime-Version: 1.0
Cc: Miaohe Lin <linmiaohe@huawei.com>, Michal Kubecek <mkubecek@suse.cz>,
 Song Liu <songliubraving@fb.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Alexander Lobakin <alobakin@pm.me>, Alexei Starovoitov <ast@kernel.org>,
 virtualization@lists.linux-foundation.org,
 Meir Lichtinger <meirl@mellanox.com>, Andrew Lunn <andrew@lunn.ch>,
 Steffen Klassert <steffen.klassert@secunet.com>,
 Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
 Florian Fainelli <f.fainelli@gmail.com>,
 Daniel Borkmann <daniel@iogearbox.net>,
 Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
 John Fastabend <john.fastabend@gmail.com>, Andrii Nakryiko <andrii@kernel.org>,
 Yonghong Song <yhs@fb.com>,
 =?UTF-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn.topel@intel.com>,
 Jesper Dangaard Brouer <hawk@kernel.org>, KP Singh <kpsingh@kernel.org>,
 Jakub Kicinski <kuba@kernel.org>, Magnus Karlsson <magnus.karlsson@intel.com>,
 Willem de Bruijn <willemb@google.com>, Antoine Tenart <atenart@kernel.org>,
 "David S. Miller" <davem@davemloft.net>,
 Jonathan Lemon <jonathan.lemon@gmail.com>, bpf@vger.kernel.org,
 Martin KaFai Lau <kafai@fb.com>
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>

Xuan Zhuo wrote:
> This patch is used to construct skb based on page to save memory copy
> overhead.
> 
> This has one problem:
> 
> We construct the skb by fill the data page as a frag into the skb. In
> this way, the linear space is empty, and the header information is also
> in the frag, not in the linear space, which is not allowed for some
> network cards. For example, Mellanox Technologies MT27710 Family
> [ConnectX-4 Lx] will get the following error message:
> 
>     mlx5_core 0000:3b:00.1 eth1: Error cqe on cqn 0x817, ci 0x8, qn 0x1dbb, opcode 0xd, syndrome 0x1, vendor syndrome 0x68
>     00000000: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
>     00000010: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
>     00000020: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
>     00000030: 00 00 00 00 60 10 68 01 0a 00 1d bb 00 0f 9f d2
>     WQE DUMP: WQ size 1024 WQ cur size 0, WQE index 0xf, len: 64
>     00000000: 00 00 0f 0a 00 1d bb 03 00 00 00 08 00 00 00 00
>     00000010: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
>     00000020: 00 00 00 2b 00 08 00 00 00 00 00 05 9e e3 08 00
>     00000030: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
>     mlx5_core 0000:3b:00.1 eth1: ERR CQE on SQ: 0x1dbb
> 
> I also tried to use build_skb to construct skb, but because of the
> existence of skb_shinfo, it must be behind the linear space, so this
> method is not working. We can't put skb_shinfo on desc->addr, it will be
> exposed to users, this is not safe.
> 
> Finally, I added a feature NETIF_F_SKB_NO_LINEAR to identify whether the
> network card supports the header information of the packet in the frag
> and not in the linear space.
> 
> ---------------- Performance Testing ------------
> 
> The test environment is Aliyun ECS server.
> Test cmd:
> ```
> xdpsock -i eth0 -t  -S -s <msg size>
> ```
> 
> Test result data:
> 
> size    64      512     1024    1500
> copy    1916747 1775988 1600203 1440054
> page    1974058 1953655 1945463 1904478
> percent 3.0%    10.0%   21.58%  32.3%

Looks like a good perf bump. Some easy suggestions below

> +static struct sk_buff *xsk_build_skb(struct xdp_sock *xs,
> +				     struct xdp_desc *desc, int *err)
> +{

Passing a 'int *err' here is ugly IMO use the ERR_PTR/PTR_ERR macros
and roll it into the return value.

or maybe use the out: pattern used in the kernel, but just doing direct
returns like now but with ERR_PTR() would also be fine.

> +	struct sk_buff *skb ;
        struct sk_buff *skb = NULL;
        err = -ENOMEM;
> +
> +	if (xs->dev->features & NETIF_F_SKB_NO_LINEAR) {
> +		skb = xsk_build_skb_zerocopy(xs, desc);
> +		if (unlikely(!skb)) {
			goto out

> +			*err = -ENOMEM;
> +			return NULL;
> +		}
> +	} else {
> +		char *buffer;
> +		u64 addr;
> +		u32 len;
> +		int err;
> +
> +		len = desc->len;
> +		skb = sock_alloc_send_skb(&xs->sk, len, 1, &err);
> +		if (unlikely(!skb)) {
			goto out;
> +			*err = -ENOMEM;
> +			return NULL;
> +		}
> +
> +		skb_put(skb, len);
> +		addr = desc->addr;
> +		buffer = xsk_buff_raw_get_data(xs->pool, desc->addr);
> +		err = skb_store_bits(skb, 0, buffer, len);
> +
> +		if (unlikely(err)) {
> +			kfree_skb(skb);

			err = -EINVAL;
			goto out

> +			*err = -EINVAL;
> +			return NULL;
> +		}
> +	}
> +
> +	skb->dev = xs->dev;
> +	skb->priority = xs->sk.sk_priority;
> +	skb->mark = xs->sk.sk_mark;
> +	skb_shinfo(skb)->destructor_arg = (void *)(long)desc->addr;
> +	skb->destructor = xsk_destruct_skb;
> +
> +	return skb;

out:
	kfree_skb(skb)
	return ERR_PTR(err);

> +}
> +

Otherwise looks good thanks.
_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
