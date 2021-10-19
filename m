Return-Path: <SRS0=CXPs=PH=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 47CCEC433EF
	for <virtualization@archiver.kernel.org>; Tue, 19 Oct 2021 13:22:25 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E7E586137E
	for <virtualization@archiver.kernel.org>; Tue, 19 Oct 2021 13:22:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org E7E586137E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id B1D3083CBC;
	Tue, 19 Oct 2021 13:22:24 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id bMzRzAIJHTN5; Tue, 19 Oct 2021 13:22:23 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 448C683CA6;
	Tue, 19 Oct 2021 13:22:23 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 07247C0011;
	Tue, 19 Oct 2021 13:22:23 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 06DD1C000D
 for <virtualization@lists.linux-foundation.org>;
 Tue, 19 Oct 2021 13:22:22 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id EA5DD83CB3
 for <virtualization@lists.linux-foundation.org>;
 Tue, 19 Oct 2021 13:22:21 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id w-6bC3hPM2aR
 for <virtualization@lists.linux-foundation.org>;
 Tue, 19 Oct 2021 13:22:21 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 5CB3C83CB6
 for <virtualization@lists.linux-foundation.org>;
 Tue, 19 Oct 2021 13:22:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1634649740;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=lUC3SODrnPeoXRhYqp+sh/Eda8v6wZliOMJ/QwwCLgE=;
 b=FZ567oiSAGlSH0NB2/lyzBoD5Uswq08AuLqH8FPTlijtaKyV3YFozCBVSKv1vbS4H4Xp6Y
 QxIf8xF3Y/FLl8yqNyRhBRNDA0pvHuMN4aiaA/pLcp6s8eNwxv0oLCDmyb5b8NWzWJSwv1
 GGCYuG6tj+7ZUHehoCVHwFNGH4tYRhU=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-72-tESjCynzOWGK_GAnN4WYTg-1; Tue, 19 Oct 2021 09:22:19 -0400
X-MC-Unique: tESjCynzOWGK_GAnN4WYTg-1
Received: by mail-wm1-f70.google.com with SMTP id
 204-20020a1c01d5000000b003101167101bso2532927wmb.3
 for <virtualization@lists.linux-foundation.org>;
 Tue, 19 Oct 2021 06:22:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=lUC3SODrnPeoXRhYqp+sh/Eda8v6wZliOMJ/QwwCLgE=;
 b=2+vc6ZxFNOgjmx2VpIuFv+y/p+uYcr9Hs/OhuukQUVyIm/eFVB9QAO3aUs9u3qkFLU
 jo5Hd9zTKiMJAn8fuqirCh+vbFY3M+gc0/LmkuF9V2cZN6AhEIrHIermny8GdwojHFAi
 JHtUq3ECgEVgWhJJExisq3CfJfTL2Up53s/Dz/MyDX6+bnf/mwXJbgxs+lKzpMO6Crib
 AqPaasjnFxUZGrdgHJcC+if5geDbgYBu/Yf92ZAgpf36upWtBrotdXPjKmziEyd6eduv
 KURRJcd4NsWbXVrcarC2xtyksVEFc5v3jbTIy9qUqv+nGv3bRyrXMzIPPsuqWrLI1g0/
 hErw==
X-Gm-Message-State: AOAM53160NPD77//QkEuM72C6MOSuqPTHBDzBPEpETiC9zQftNDWJWF5
 nDQq33zXAL7bxzlvjNuinK6Wr2PY1dn5o2aQrkBANWuNRb2rO+on1R675E0a4lIzliDNmAdSSrW
 u0gyydQm71k2S1WaLpYnXXewNbCikPHFv8VBD/US22Q==
X-Received: by 2002:a1c:9ad4:: with SMTP id c203mr6084949wme.41.1634649737931; 
 Tue, 19 Oct 2021 06:22:17 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzp/ZgW1gvHNYUz0DeRhFIf2WWl3vq6mKT3yIxAL98leuiao1cZ5+R7omFJ8Io/sw52TDd5Dg==
X-Received: by 2002:a1c:9ad4:: with SMTP id c203mr6084934wme.41.1634649737792; 
 Tue, 19 Oct 2021 06:22:17 -0700 (PDT)
Received: from redhat.com ([2.55.24.172])
 by smtp.gmail.com with ESMTPSA id x21sm2184249wmc.14.2021.10.19.06.22.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 19 Oct 2021 06:22:17 -0700 (PDT)
Date: Tue, 19 Oct 2021 09:22:14 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
Subject: Re: [PATCH v4 1/2] virtio_ring: fix style of
 virtqueue_add_indirect_packed
Message-ID: <20211019092158-mutt-send-email-mst@kernel.org>
References: <20211019115235.106507-1-xuanzhuo@linux.alibaba.com>
 <20211019115235.106507-2-xuanzhuo@linux.alibaba.com>
MIME-Version: 1.0
In-Reply-To: <20211019115235.106507-2-xuanzhuo@linux.alibaba.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=mst@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: "David S. Miller" <davem@davemloft.net>, Tiwei Bie <tiwei.bie@intel.com>,
 virtualization@lists.linux-foundation.org
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

On Tue, Oct 19, 2021 at 07:52:34PM +0800, Xuan Zhuo wrote:
> Align the arguments of virtqueue_add_indirect_packed() to the open ( to
> make it look prettier.
> 
> Signed-off-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
> Acked-by: Jason Wang <jasowang@redhat.com>

ok now update subject to match pls

> ---
>  drivers/virtio/virtio_ring.c | 12 ++++++------
>  1 file changed, 6 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/virtio/virtio_ring.c b/drivers/virtio/virtio_ring.c
> index dd95dfd85e98..91a46c4da87d 100644
> --- a/drivers/virtio/virtio_ring.c
> +++ b/drivers/virtio/virtio_ring.c
> @@ -1050,12 +1050,12 @@ static struct vring_packed_desc *alloc_indirect_packed(unsigned int total_sg,
>  }
>  
>  static int virtqueue_add_indirect_packed(struct vring_virtqueue *vq,
> -				       struct scatterlist *sgs[],
> -				       unsigned int total_sg,
> -				       unsigned int out_sgs,
> -				       unsigned int in_sgs,
> -				       void *data,
> -				       gfp_t gfp)
> +					 struct scatterlist *sgs[],
> +					 unsigned int total_sg,
> +					 unsigned int out_sgs,
> +					 unsigned int in_sgs,
> +					 void *data,
> +					 gfp_t gfp)
>  {
>  	struct vring_packed_desc *desc;
>  	struct scatterlist *sg;
> -- 
> 2.31.0

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
