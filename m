Return-Path: <SRS0=yluT=M2=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_RED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 392C1C4338F
	for <virtualization@archiver.kernel.org>; Tue,  3 Aug 2021 06:22:31 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D3EE660EBB
	for <virtualization@archiver.kernel.org>; Tue,  3 Aug 2021 06:22:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org D3EE660EBB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 45A404037C;
	Tue,  3 Aug 2021 06:22:30 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id pKh3lN6Bywlk; Tue,  3 Aug 2021 06:22:28 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTPS id C709040102;
	Tue,  3 Aug 2021 06:22:27 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id A8CC3C001A;
	Tue,  3 Aug 2021 06:22:27 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 27838C000E
 for <virtualization@lists.linux-foundation.org>;
 Tue,  3 Aug 2021 06:22:27 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 1650A82F37
 for <virtualization@lists.linux-foundation.org>;
 Tue,  3 Aug 2021 06:22:27 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp1.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id x5ak4NcDsGpx
 for <virtualization@lists.linux-foundation.org>;
 Tue,  3 Aug 2021 06:22:25 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp1.osuosl.org (Postfix) with ESMTPS id C02EF82F13
 for <virtualization@lists.linux-foundation.org>;
 Tue,  3 Aug 2021 06:22:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1627971744;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=ofwSG05+cqdqfTm2t3p2kntFxSnEv6QKIgGTnP/SO6c=;
 b=ZYNb9aAj/KMbij709afrRcmEHRsI1obcKvvCVLEOwDV1VlI/i7wVBnx/E1qtxCbEMDDCTa
 ZpbcLCwYtMq7sHQlF6JJCjA5cONq15Cy4SXMA0EcHJizTNaU51wvSXNwIUUPsFns2OFvYl
 5lwcDSmZ0AZ1v/O02MMBdvtn6CobDO0=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-416-RWhG70iYNaaPlA80UMs9xA-1; Tue, 03 Aug 2021 02:22:22 -0400
X-MC-Unique: RWhG70iYNaaPlA80UMs9xA-1
Received: by mail-ej1-f69.google.com with SMTP id
 qf6-20020a1709077f06b029057e66b6665aso5623739ejc.18
 for <virtualization@lists.linux-foundation.org>;
 Mon, 02 Aug 2021 23:22:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=ofwSG05+cqdqfTm2t3p2kntFxSnEv6QKIgGTnP/SO6c=;
 b=WuDBFR/pkGfmupIMYAg4qaA4RYrbVPDyeNnwS6zzlyJUSF8TZw/5TtBDecnaSrMY9E
 qn8+iK8l1K+IHV0Jus9IBLV3ynIX3hEXo/jNAwUYkLsI5EcA7vvMVZR+Qxo/W/c9NobR
 wPIxwVjgmKqOLHydoMqg6vGtfYmEusgQ7LuKG57bjRwQ2qARO3JeyqmmmzHNEGuF2AUJ
 D+/4a4+c8xHwPhpFny5zWeK9VTFv7YscnZZO+0dpFJE2avkmEp5IkiPQaBdbYTVgG4Ny
 TCTuy7ob9R8aPUqzSG4h6rszQN50YptkaGkv5hCIczCZcFACkOHffri+DAqA7Gepv6M6
 OBtA==
X-Gm-Message-State: AOAM530bVUrrQf+/OFv4bFa9vNkdZ09iVI7LrMFnb+CT4NXjzxIdpqTi
 a9jz6syBzth5Bb8wYJ4e4lRAJKN2ykOYUiEf9pw9L9yfOi9dU7B+9zZkr9DVSMGj0a3VBnHObDG
 Dkf9PHlMr49aD0lxo8dnUfNaTJdg54+etfsFk0E7FVA==
X-Received: by 2002:aa7:dc49:: with SMTP id g9mr20956924edu.301.1627971741763; 
 Mon, 02 Aug 2021 23:22:21 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyzXnX/RUQ7BQhbm/QhFHmCb8jPB1tiRSttz+5eM5x5jf0nTsyuseGxjSxftiDCS7p5B/w6Fg==
X-Received: by 2002:aa7:dc49:: with SMTP id g9mr20956906edu.301.1627971741630; 
 Mon, 02 Aug 2021 23:22:21 -0700 (PDT)
Received: from redhat.com ([2.55.140.205])
 by smtp.gmail.com with ESMTPSA id ha26sm5662198ejb.87.2021.08.02.23.22.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 02 Aug 2021 23:22:21 -0700 (PDT)
Date: Tue, 3 Aug 2021 02:22:17 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Jakub Kicinski <kuba@kernel.org>
Subject: Re: [PATCH net-next] virtio-net: realign page_to_skb() after merges
Message-ID: <20210803022140-mutt-send-email-mst@kernel.org>
References: <20210802175729.2042133-1-kuba@kernel.org>
MIME-Version: 1.0
In-Reply-To: <20210802175729.2042133-1-kuba@kernel.org>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=mst@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: netdev@vger.kernel.org, davem@davemloft.net,
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

On Mon, Aug 02, 2021 at 10:57:29AM -0700, Jakub Kicinski wrote:
> We ended up merging two versions of the same patch set:
> 
> commit 8fb7da9e9907 ("virtio_net: get build_skb() buf by data ptr")
> commit 5c37711d9f27 ("virtio-net: fix for unable to handle page fault for address")
> 
> into net, and
> 
> commit 7bf64460e3b2 ("virtio-net: get build_skb() buf by data ptr")
> commit 6c66c147b9a4 ("virtio-net: fix for unable to handle page fault for address")
> 
> into net-next. Redo the merge from commit 126285651b7f ("Merge
> ra.kernel.org:/pub/scm/linux/kernel/git/netdev/net"), so that
> the most recent code remains.
> 
> Acked-by: Michael S. Tsirkin <mst@redhat.com>
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>

And maybe add

Fixes: 126285651b7f ("Merge ra.kernel.org:/pub/scm/linux/kernel/git/netdev/net")

so automated tools have an easier time finding this fixup.

> ---
>  drivers/net/virtio_net.c | 27 ++++++++-------------------
>  1 file changed, 8 insertions(+), 19 deletions(-)
> 
> diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
> index 56c3f8519093..74482a52f076 100644
> --- a/drivers/net/virtio_net.c
> +++ b/drivers/net/virtio_net.c
> @@ -380,7 +380,7 @@ static struct sk_buff *page_to_skb(struct virtnet_info *vi,
>  				   struct page *page, unsigned int offset,
>  				   unsigned int len, unsigned int truesize,
>  				   bool hdr_valid, unsigned int metasize,
> -				   bool whole_page)
> +				   unsigned int headroom)
>  {
>  	struct sk_buff *skb;
>  	struct virtio_net_hdr_mrg_rxbuf *hdr;
> @@ -398,28 +398,16 @@ static struct sk_buff *page_to_skb(struct virtnet_info *vi,
>  	else
>  		hdr_padded_len = sizeof(struct padded_vnet_hdr);
>  
> -	/* If whole_page, there is an offset between the beginning of the
> +	/* If headroom is not 0, there is an offset between the beginning of the
>  	 * data and the allocated space, otherwise the data and the allocated
>  	 * space are aligned.
>  	 *
>  	 * Buffers with headroom use PAGE_SIZE as alloc size, see
>  	 * add_recvbuf_mergeable() + get_mergeable_buf_len()
>  	 */
> -	if (whole_page) {
> -		/* Buffers with whole_page use PAGE_SIZE as alloc size,
> -		 * see add_recvbuf_mergeable() + get_mergeable_buf_len()
> -		 */
> -		truesize = PAGE_SIZE;
> -
> -		/* page maybe head page, so we should get the buf by p, not the
> -		 * page
> -		 */
> -		tailroom = truesize - len - offset_in_page(p);
> -		buf = (char *)((unsigned long)p & PAGE_MASK);
> -	} else {
> -		tailroom = truesize - len;
> -		buf = p;
> -	}
> +	truesize = headroom ? PAGE_SIZE : truesize;
> +	tailroom = truesize - len - headroom;
> +	buf = p - headroom;
>  
>  	len -= hdr_len;
>  	offset += hdr_padded_len;
> @@ -978,7 +966,8 @@ static struct sk_buff *receive_mergeable(struct net_device *dev,
>  				put_page(page);
>  				head_skb = page_to_skb(vi, rq, xdp_page, offset,
>  						       len, PAGE_SIZE, false,
> -						       metasize, true);
> +						       metasize,
> +						       VIRTIO_XDP_HEADROOM);
>  				return head_skb;
>  			}
>  			break;
> @@ -1029,7 +1018,7 @@ static struct sk_buff *receive_mergeable(struct net_device *dev,
>  	rcu_read_unlock();
>  
>  	head_skb = page_to_skb(vi, rq, page, offset, len, truesize, !xdp_prog,
> -			       metasize, !!headroom);
> +			       metasize, headroom);
>  	curr_skb = head_skb;
>  
>  	if (unlikely(!curr_skb))
> -- 
> 2.31.1

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
