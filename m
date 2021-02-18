Return-Path: <SRS0=I+ly=HU=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 41ED5C433DB
	for <virtualization@archiver.kernel.org>; Thu, 18 Feb 2021 00:46:28 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A6D6A61493
	for <virtualization@archiver.kernel.org>; Thu, 18 Feb 2021 00:46:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A6D6A61493
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 3D22D605CC
	for <virtualization@archiver.kernel.org>; Thu, 18 Feb 2021 00:46:27 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id YBIBa4YMSgxD for <virtualization@archiver.kernel.org>;
	Thu, 18 Feb 2021 00:46:25 +0000 (UTC)
Received: by smtp3.osuosl.org (Postfix, from userid 1001)
	id 10E59605D3; Thu, 18 Feb 2021 00:46:24 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTP id 3F9D7605B3;
	Thu, 18 Feb 2021 00:46:19 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 12AA5C000F;
	Thu, 18 Feb 2021 00:46:19 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 16688C000D
 for <virtualization@lists.linux-foundation.org>;
 Thu, 18 Feb 2021 00:46:18 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by fraxinus.osuosl.org (Postfix) with ESMTP id F1A418502A
 for <virtualization@lists.linux-foundation.org>;
 Thu, 18 Feb 2021 00:46:17 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id t4g2-Qd43sPK
 for <virtualization@lists.linux-foundation.org>;
 Thu, 18 Feb 2021 00:46:13 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail-il1-f174.google.com (mail-il1-f174.google.com
 [209.85.166.174])
 by fraxinus.osuosl.org (Postfix) with ESMTPS id 801C784FF9
 for <virtualization@lists.linux-foundation.org>;
 Thu, 18 Feb 2021 00:46:13 +0000 (UTC)
Received: by mail-il1-f174.google.com with SMTP id p15so16038ilq.8
 for <virtualization@lists.linux-foundation.org>;
 Wed, 17 Feb 2021 16:46:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=date:from:to:cc:message-id:in-reply-to:references:subject
 :mime-version:content-transfer-encoding;
 bh=FIejfxEN+OKZDYsEhrma7B8eOaQBPFZ4Xime0REzBl8=;
 b=BIOlUGP4CalqxEb+FaqBDN0+Y3g0ppyI7YfN6o54H+4pLr+cllZ4iGI9aTFi1jwTEX
 HifOemf56cvMLR9/zNW1R0zVcFKF/au3qNbP0oICWnfJxLrGiN1Wr3yj7qq+BoS4hIlh
 irsXcb9LhYsorTI84JQF8BDXKr489EgtrNjUcr9WYw5odNO1/GprPNH4amxGQvhhDrSx
 9h/4q4tm8tHRTGJ0sIGpFl6akHtmFFmIF7YDcXbgSekJH9zhLwwYyIXWvACEKNv8qvPj
 3+WV724wqWQ3rnzRRP+PXTBug4ohFcpYHzWCc4zc/IfylYpXTEDiL1vlwDeQ8HI+GFzo
 fH2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:message-id:in-reply-to
 :references:subject:mime-version:content-transfer-encoding;
 bh=FIejfxEN+OKZDYsEhrma7B8eOaQBPFZ4Xime0REzBl8=;
 b=dbH6Kbll5G6fztCwXIjOwTJe+G80r/Ibd3VSVABxRY/VgYNLz0crf/QxBQq+A1wKdq
 Vd9KahOCwzAtHwtZm0ZUvNfPizcvaZGYaXzUrLCoy2XVVnIn9zYB4CbOl4RCHGtIBM1b
 nvMZvT0/9BCOZuXaqavvpJQoJpRRnRYoYp5Zm2uQRbi77ikMquca99JlWqtfH4/UhLu1
 jBSIj3QKv2Avw+K3xhuBLDt+Qb4X56vXp2fI3crBw3G8VHZ4NmBxAJCUoFpEYp1GWvR9
 +zvzlmKO6XdqLMDyRgP4CNdv/EbfGIljgXcBjEqZ3WorZI1/AYmihZlGwVIhNImjuuUN
 WpqA==
X-Gm-Message-State: AOAM530ex5TxZFhYBMTUqWxqKbALl41l8zh6LAYG0WjIJwlOWc8rB84t
 Xi9QM6PYCqrh5RcThq65wUc=
X-Google-Smtp-Source: ABdhPJwDYJNSFnd2wxbwNHFifatEFpaDjjvkV2kZZAVjeyGYGigG85o4rzR5oxz3oajh9p91ZfeP+g==
X-Received: by 2002:a05:6e02:2142:: with SMTP id
 d2mr1492157ilv.249.1613609172754; 
 Wed, 17 Feb 2021 16:46:12 -0800 (PST)
Received: from localhost ([172.243.146.206])
 by smtp.gmail.com with ESMTPSA id y25sm2902166ioa.5.2021.02.17.16.46.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 17 Feb 2021 16:46:11 -0800 (PST)
Date: Wed, 17 Feb 2021 16:46:04 -0800
From: John Fastabend <john.fastabend@gmail.com>
To: Alexander Lobakin <alobakin@pm.me>, 
 Daniel Borkmann <daniel@iogearbox.net>, 
 Magnus Karlsson <magnus.karlsson@intel.com>
Message-ID: <602db8cc18aaf_fc5420827@john-XPS-13-9370.notmuch>
In-Reply-To: <20210217120003.7938-7-alobakin@pm.me>
References: <20210217120003.7938-1-alobakin@pm.me>
 <20210217120003.7938-7-alobakin@pm.me>
Subject: RE: [PATCH v7 bpf-next 6/6] xsk: build skb by page (aka generic
 zerocopy xmit)
Mime-Version: 1.0
Cc: Song Liu <songliubraving@fb.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Alexander Lobakin <alobakin@pm.me>, Alexei Starovoitov <ast@kernel.org>,
 virtualization@lists.linux-foundation.org,
 Xuan Zhuo <xuanzhuo@linux.alibaba.com>, Eric Dumazet <eric.dumazet@gmail.com>,
 John Fastabend <john.fastabend@gmail.com>, Andrii Nakryiko <andrii@kernel.org>,
 Dust Li <dust.li@linux.alibaba.com>, Yonghong Song <yhs@fb.com>,
 Paolo Abeni <pabeni@redhat.com>, Jesper Dangaard Brouer <hawk@kernel.org>,
 KP Singh <kpsingh@kernel.org>, Jakub Kicinski <kuba@kernel.org>,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 "David S. Miller" <davem@davemloft.net>,
 =?UTF-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@kernel.org>,
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

Alexander Lobakin wrote:
> From: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
> 
> This patch is used to construct skb based on page to save memory copy
> overhead.
> 
> This function is implemented based on IFF_TX_SKB_NO_LINEAR. Only the
> network card priv_flags supports IFF_TX_SKB_NO_LINEAR will use page to
> directly construct skb. If this feature is not supported, it is still
> necessary to copy data to construct skb.
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
> 
> Signed-off-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
> Reviewed-by: Dust Li <dust.li@linux.alibaba.com>
> [ alobakin:
>  - expand subject to make it clearer;
>  - improve skb->truesize calculation;
>  - reserve some headroom in skb for drivers;
>  - tailroom is not needed as skb is non-linear ]
> Signed-off-by: Alexander Lobakin <alobakin@pm.me>
> Acked-by: Magnus Karlsson <magnus.karlsson@intel.com>
> ---

[...]

> +	buffer = xsk_buff_raw_get_data(pool, addr);
> +	offset = offset_in_page(buffer);
> +	addr = buffer - pool->addrs;
> +
> +	for (copied = 0, i = 0; copied < len; i++) {
> +		page = pool->umem->pgs[addr >> PAGE_SHIFT];

Looks like we could walk off the end of pgs[] if len is larger than
the number of pgs? Do we need to guard against a misconfigured socket
causing a panic here? AFAIU len here is read from the user space
descriptor so is under user control. Or maybe I missed a check somewhere.

Thanks,
John


> +		get_page(page);
> +
> +		copy = min_t(u32, PAGE_SIZE - offset, len - copied);
> +		skb_fill_page_desc(skb, i, page, offset, copy);
> +
> +		copied += copy;
> +		addr += copy;
> +		offset = 0;
> +	}
> +
> +	skb->len += len;
> +	skb->data_len += len;
> +	skb->truesize += ts;
> +
> +	refcount_add(ts, &xs->sk.sk_wmem_alloc);
> +
> +	return skb;
> +}
> +
_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
