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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 37F73C433E6
	for <virtualization@archiver.kernel.org>; Thu, 18 Feb 2021 05:51:19 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9C28564D99
	for <virtualization@archiver.kernel.org>; Thu, 18 Feb 2021 05:51:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9C28564D99
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 4DCD2860C4;
	Thu, 18 Feb 2021 05:51:18 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 58IzEJNUVW53; Thu, 18 Feb 2021 05:51:17 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 78FCE8608D;
	Thu, 18 Feb 2021 05:51:17 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 5C975C000E;
	Thu, 18 Feb 2021 05:51:17 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 07086C000D
 for <virtualization@lists.linux-foundation.org>;
 Thu, 18 Feb 2021 05:51:16 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by whitealder.osuosl.org (Postfix) with ESMTP id F3E67864F6
 for <virtualization@lists.linux-foundation.org>;
 Thu, 18 Feb 2021 05:51:15 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id j9czSit4py+v
 for <virtualization@lists.linux-foundation.org>;
 Thu, 18 Feb 2021 05:51:14 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail-il1-f179.google.com (mail-il1-f179.google.com
 [209.85.166.179])
 by whitealder.osuosl.org (Postfix) with ESMTPS id D51258649A
 for <virtualization@lists.linux-foundation.org>;
 Thu, 18 Feb 2021 05:51:14 +0000 (UTC)
Received: by mail-il1-f179.google.com with SMTP id e7so497211ile.7
 for <virtualization@lists.linux-foundation.org>;
 Wed, 17 Feb 2021 21:51:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=date:from:to:cc:message-id:in-reply-to:references:subject
 :mime-version:content-transfer-encoding;
 bh=1MiXI1ghzyDJbbFlIYODMYli9/N2JgiwurFchZ9firo=;
 b=dEBmN7prep6VSAQphqNi5WtJV6Fv9Y0sSG8g+DH+WqFF3soIzqH/sc3anKxEM7hqgF
 oybeCMKfrDFUCehJlWR731HqDZ+AaoF+GSgKRLMvbFjc3ILgnrh9SIqNnEt/gYIck31K
 2ymaCUdFyNORx5Dfw3Xub+LTH9JMqzRlRKoQ+bsOjC90fWtvmB9TdWKVnIDvq/vMIpdZ
 lFtOEJNbyVZj2W6Mr747dHg3aIR+qgKtEly+VdDTZ2DXFJC+fZk0Et5K6UjQMt7VLrV5
 ti7l3VZGFz4Ddwhc3nEyp4yhuBRhQyv+akSh3+KVViFaTs6FtF0QhmZ6xNePtHPnRgPZ
 uyJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:message-id:in-reply-to
 :references:subject:mime-version:content-transfer-encoding;
 bh=1MiXI1ghzyDJbbFlIYODMYli9/N2JgiwurFchZ9firo=;
 b=dHNmZcaBUxknrl86V7Sqwb1MqCgX9zc+b1ydNfheMDEPCb9zXMxvyFgJInCcE/u7/a
 R2v+o5Byu28EMjE53Rk/rHfVZ3Lh3jC95i3vH4quumJ0lYkEipgnwduKF/w/OxzdNcW1
 eXTa+9Uh/NdjSWTYpH94WUrj6p1eEc+UtWzKq6gRrqroN4DPg3pm389VLwuCqcstexM7
 aFTs4JasO+YXXZ7lxU/VkOUK+8km0hdaWilRQDU2CTwa2VCmHhPPP4ULza9vnm/cQDRh
 uDtzXf1sotwIHrIL69xb0/6JM2U1NFfIvEbFzAABXGCwQBiA955CV52kxnhCSauofcMb
 NzsQ==
X-Gm-Message-State: AOAM5326/rAVT7W/sM1uWUrl7yaurxzmxlqhCOuZkOMlTS6ID9TIxslT
 rs162+RbVZVp6mQBEp1ISh0=
X-Google-Smtp-Source: ABdhPJwf4UBkV7ifcird11DTwA51LcyMnqHR7AdEo+L5paqAu0t48ISl/VVRDyTLTn24RA1B9tvqGw==
X-Received: by 2002:a05:6e02:1a25:: with SMTP id
 g5mr2470754ile.73.1613627474096; 
 Wed, 17 Feb 2021 21:51:14 -0800 (PST)
Received: from localhost ([172.243.146.206])
 by smtp.gmail.com with ESMTPSA id e195sm3795840iof.51.2021.02.17.21.51.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 17 Feb 2021 21:51:13 -0800 (PST)
Date: Wed, 17 Feb 2021 21:51:07 -0800
From: John Fastabend <john.fastabend@gmail.com>
To: Xuan Zhuo <xuanzhuo@linux.alibaba.com>, 
 John Fastabend <john.fastabend@gmail.com>
Message-ID: <602e004b4286_1e7da2082a@john-XPS-13-9370.notmuch>
In-Reply-To: <1613615475.9629707-1-xuanzhuo@linux.alibaba.com>
References: <602db8cc18aaf_fc5420827@john-XPS-13-9370.notmuch>
 <1613615475.9629707-1-xuanzhuo@linux.alibaba.com>
Subject: Re: RE: [PATCH v7 bpf-next 6/6] xsk: build skb by page (aka generic
 zerocopy xmit)
Mime-Version: 1.0
Cc: Song Liu <songliubraving@fb.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Alexander Lobakin <alobakin@pm.me>, Alexei Starovoitov <ast@kernel.org>,
 virtualization@lists.linux-foundation.org,
 Eric Dumazet <eric.dumazet@gmail.com>,
 John Fastabend <john.fastabend@gmail.com>, Andrii Nakryiko <andrii@kernel.org>,
 Dust Li <dust.li@linux.alibaba.com>, Yonghong Song <yhs@fb.com>,
 Paolo Abeni <pabeni@redhat.com>, Jesper Dangaard Brouer <hawk@kernel.org>,
 KP Singh <kpsingh@kernel.org>, Jakub Kicinski <kuba@kernel.org>,
 Magnus Karlsson <magnus.karlsson@intel.com>,
 Daniel Borkmann <daniel@iogearbox.net>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, "David S. Miller" <davem@davemloft.net>,
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

Xuan Zhuo wrote:
> On Wed, 17 Feb 2021 16:46:04 -0800, John Fastabend <john.fastabend@gmail.com> wrote:
> > Alexander Lobakin wrote:
> > > From: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
> > >
> > > This patch is used to construct skb based on page to save memory copy
> > > overhead.
> > >
> > > This function is implemented based on IFF_TX_SKB_NO_LINEAR. Only the
> > > network card priv_flags supports IFF_TX_SKB_NO_LINEAR will use page to
> > > directly construct skb. If this feature is not supported, it is still
> > > necessary to copy data to construct skb.
> > >
> > > ---------------- Performance Testing ------------
> > >
> > > The test environment is Aliyun ECS server.
> > > Test cmd:
> > > ```
> > > xdpsock -i eth0 -t  -S -s <msg size>
> > > ```
> > >
> > > Test result data:
> > >
> > > size    64      512     1024    1500
> > > copy    1916747 1775988 1600203 1440054
> > > page    1974058 1953655 1945463 1904478
> > > percent 3.0%    10.0%   21.58%  32.3%
> > >
> > > Signed-off-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
> > > Reviewed-by: Dust Li <dust.li@linux.alibaba.com>
> > > [ alobakin:
> > >  - expand subject to make it clearer;
> > >  - improve skb->truesize calculation;
> > >  - reserve some headroom in skb for drivers;
> > >  - tailroom is not needed as skb is non-linear ]
> > > Signed-off-by: Alexander Lobakin <alobakin@pm.me>
> > > Acked-by: Magnus Karlsson <magnus.karlsson@intel.com>
> > > ---
> >
> > [...]
> >
> > > +	buffer = xsk_buff_raw_get_data(pool, addr);
> > > +	offset = offset_in_page(buffer);
> > > +	addr = buffer - pool->addrs;
> > > +
> > > +	for (copied = 0, i = 0; copied < len; i++) {
> > > +		page = pool->umem->pgs[addr >> PAGE_SHIFT];
> >
> > Looks like we could walk off the end of pgs[] if len is larger than
> > the number of pgs? Do we need to guard against a misconfigured socket
> > causing a panic here? AFAIU len here is read from the user space
> > descriptor so is under user control. Or maybe I missed a check somewhere.
> >
> > Thanks,
> > John
> >
> 
> Don't worry about this, the legality of desc has been checked.
> 
> xskq_cons_peek_desc -> xskq_cons_read_desc ->
>                    xskq_cons_is_valid_desc -> xp_validate_desc

Ah OK I didn't dig past the cons_read_desc(). In that case LGTM.

Acked-by: John Fastabend <john.fastabend@gmail.com>
_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
