Return-Path: <SRS0=O+Fm=GY=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8FBCCC433E0
	for <virtualization@archiver.kernel.org>; Thu, 21 Jan 2021 15:41:42 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 09DAD2073C
	for <virtualization@archiver.kernel.org>; Thu, 21 Jan 2021 15:41:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 09DAD2073C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by hemlock.osuosl.org (Postfix) with ESMTP id 8809B871C3;
	Thu, 21 Jan 2021 15:41:41 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id eSrnosXUNqK4; Thu, 21 Jan 2021 15:41:40 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by hemlock.osuosl.org (Postfix) with ESMTP id C7274871B8;
	Thu, 21 Jan 2021 15:41:40 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 9DFD8C088B;
	Thu, 21 Jan 2021 15:41:40 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 05DB4C013A
 for <virtualization@lists.linux-foundation.org>;
 Thu, 21 Jan 2021 15:41:39 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by fraxinus.osuosl.org (Postfix) with ESMTP id DECBA86268
 for <virtualization@lists.linux-foundation.org>;
 Thu, 21 Jan 2021 15:41:38 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 0Y4IH4WRuaCC
 for <virtualization@lists.linux-foundation.org>;
 Thu, 21 Jan 2021 15:41:38 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com
 [209.85.128.45])
 by fraxinus.osuosl.org (Postfix) with ESMTPS id ED8A186142
 for <virtualization@lists.linux-foundation.org>;
 Thu, 21 Jan 2021 15:41:37 +0000 (UTC)
Received: by mail-wm1-f45.google.com with SMTP id c128so1922306wme.2
 for <virtualization@lists.linux-foundation.org>;
 Thu, 21 Jan 2021 07:41:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=klestWo2PrKy4XdpOkRsUnFJCmCxs6ZGgiiFSXp8mGQ=;
 b=mU4IBbICRoLVDsuNxMDJFuEkpp9tbf4k8j3PtFt2VR35nz4BZs3UaU90Fh+axknRnT
 L3Q+FwtIv/Ab+PfwyfcpGz1aUcYibXm+TtvpF4zmjQRQRQYbPa0eSmBz1CkVVR5fNkGf
 kmtxemTIos+nJNF1AIthX9pI6XV2Upa+r78jrQmvYfuI91V/561+7aHc7dVcA2L++5iC
 PM4pu7+lk++zVjq40dveVN6WgiLynkHhtrpUZClReXbfKX6LG2q0I+z/tfA72rFk8O3f
 /Wp3bthwzixQRmkKDOond1m422rCSb3KUxV2SeaDsHc5ZRcqPAkRwNeLYRjbUJE61I7J
 YFDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=klestWo2PrKy4XdpOkRsUnFJCmCxs6ZGgiiFSXp8mGQ=;
 b=CrdPmb/Bh7BenVUEO8DmMKBdrW4ntWuDqr2puQrbopmp3DH5ijanz9tkchiAD5W3Rj
 yNfQqW9ZLdWPVwu5H3/tRDN+BNitp1RtUEqFT/HYfdk8D3B0bZ1CqCPJWvffuTeIY93+
 fD5L7rlOZVdkX3dHHxCs7AB1nqQZfXXI5cPAKDtQG80aUFODIj7OE8kacPGVTcC1hsye
 qA8tzfYgJ+EqSYbuRAfikHdQfppEvSedBgmxtIoajdNyyGhbMPCR4USazGDcWf3QhDj1
 OYqxEXmmhlXER+8jpKrvvI84LhsYU8t9XjKWuXcTvAUL2L2dYf+ZoYvprdyjRb+ic9ke
 fkhA==
X-Gm-Message-State: AOAM531KjTm2g7hCdKLVikQFrO2rDN1tmSXQi8W144MFf+hjYJ4+pLpE
 LYXwTeFfKUJnxd6zMmiyX98=
X-Google-Smtp-Source: ABdhPJxP00z10/zywWz/crjSBdXq0t5+AHIDngQEQAu1TF/ApaslqqbKVD698mBRmijbupfBA3lWMQ==
X-Received: by 2002:a1c:e2d7:: with SMTP id z206mr7370319wmg.99.1611243696441; 
 Thu, 21 Jan 2021 07:41:36 -0800 (PST)
Received: from [192.168.1.101] ([37.171.116.45])
 by smtp.gmail.com with ESMTPSA id h23sm8311369wmi.26.2021.01.21.07.41.34
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 21 Jan 2021 07:41:35 -0800 (PST)
Subject: Re: [PATCH bpf-next v3 3/3] xsk: build skb by page
To: Xuan Zhuo <xuanzhuo@linux.alibaba.com>, bpf@vger.kernel.org
References: <cover.1611236588.git.xuanzhuo@linux.alibaba.com>
 <340f1dfa40416dd966a56e08507daba82d633088.1611236588.git.xuanzhuo@linux.alibaba.com>
From: Eric Dumazet <eric.dumazet@gmail.com>
Message-ID: <dcee4592-9fa9-adbb-55ca-58a962076e7a@gmail.com>
Date: Thu, 21 Jan 2021 16:41:33 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
MIME-Version: 1.0
In-Reply-To: <340f1dfa40416dd966a56e08507daba82d633088.1611236588.git.xuanzhuo@linux.alibaba.com>
Content-Language: en-US
Cc: Song Liu <songliubraving@fb.com>, Martin KaFai Lau <kafai@fb.com>,
 Jesper Dangaard Brouer <hawk@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>, "Michael S. Tsirkin" <mst@redhat.com>,
 Yonghong Song <yhs@fb.com>, John Fastabend <john.fastabend@gmail.com>,
 Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko <andrii@kernel.org>,
 =?UTF-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@kernel.org>, netdev@vger.kernel.org,
 Jonathan Lemon <jonathan.lemon@gmail.com>, KP Singh <kpsingh@kernel.org>,
 Jakub Kicinski <kuba@kernel.org>, virtualization@lists.linux-foundation.org,
 "David S. Miller" <davem@davemloft.net>,
 Magnus Karlsson <magnus.karlsson@intel.com>
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



On 1/21/21 2:47 PM, Xuan Zhuo wrote:
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
> ---
>  net/xdp/xsk.c | 104 ++++++++++++++++++++++++++++++++++++++++++++++++----------
>  1 file changed, 86 insertions(+), 18 deletions(-)
> 
> diff --git a/net/xdp/xsk.c b/net/xdp/xsk.c
> index 4a83117..38af7f1 100644
> --- a/net/xdp/xsk.c
> +++ b/net/xdp/xsk.c
> @@ -430,6 +430,87 @@ static void xsk_destruct_skb(struct sk_buff *skb)
>  	sock_wfree(skb);
>  }
>  
> +static struct sk_buff *xsk_build_skb_zerocopy(struct xdp_sock *xs,
> +					      struct xdp_desc *desc)
> +{
> +	u32 len, offset, copy, copied;
> +	struct sk_buff *skb;
> +	struct page *page;
> +	void *buffer;
> +	int err, i;
> +	u64 addr;
> +
> +	skb = sock_alloc_send_skb(&xs->sk, 0, 1, &err);
> +	if (unlikely(!skb))
> +		return ERR_PTR(err);
> +
> +	addr = desc->addr;
> +	len = desc->len;
> +
> +	buffer = xsk_buff_raw_get_data(xs->pool, addr);
> +	offset = offset_in_page(buffer);
> +	addr = buffer - xs->pool->addrs;
> +
> +	for (copied = 0, i = 0; copied < len; i++) {
> +		page = xs->pool->umem->pgs[addr >> PAGE_SHIFT];
> +
> +		get_page(page);
> +
> +		copy = min_t(u32, PAGE_SIZE - offset, len - copied);
> +
> +		skb_fill_page_desc(skb, i, page, offset, copy);
> +
> +		copied += copy;
> +		addr += copy;
> +		offset = 0;
> +	}
> +
> +	skb->len += len;
> +	skb->data_len += len;

> +	skb->truesize += len;

This is not the truesize, unfortunately.

We need to account for the number of pages, not number of bytes.

> +
> +	refcount_add(len, &xs->sk.sk_wmem_alloc);
> +
> +	return skb;
> +}
> +


_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
