Return-Path: <SRS0=MByQ=KN=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_RED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F907C43461
	for <virtualization@archiver.kernel.org>; Tue, 18 May 2021 09:55:06 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BAB60610A1
	for <virtualization@archiver.kernel.org>; Tue, 18 May 2021 09:55:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BAB60610A1
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 85FFE4027F;
	Tue, 18 May 2021 09:55:05 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id efY7NAvlIDIJ; Tue, 18 May 2021 09:55:04 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp2.osuosl.org (Postfix) with ESMTP id 1D862400CD;
	Tue, 18 May 2021 09:55:04 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id EDBB0C000D;
	Tue, 18 May 2021 09:55:03 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 855A7C0001
 for <virtualization@lists.linux-foundation.org>;
 Tue, 18 May 2021 09:55:02 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 6708F84248
 for <virtualization@lists.linux-foundation.org>;
 Tue, 18 May 2021 09:55:02 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp1.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id Asb6Y1ij9N0N
 for <virtualization@lists.linux-foundation.org>;
 Tue, 18 May 2021 09:55:01 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp1.osuosl.org (Postfix) with ESMTPS id BC3118425B
 for <virtualization@lists.linux-foundation.org>;
 Tue, 18 May 2021 09:55:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1621331700;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=+VCDqtzyoP1/MzTBF9IVeYAYQ0ccxPfD6Ur9tV2oQ+o=;
 b=QxslfdtDobxarcH53NHc1d5Yvhmg2VC8nDhk3/a3yfeAJ6Yy1BRYx2S3ylP5cgriCo741d
 IE5LpTQobzL57pZfBfuJEeJhkqis5vvd9Qa22d5ux1eyTSC6KMKyukgKff7k8/jXV7F83g
 pkTgw6sRJZ6KC/iPjhZu6yC8c4DNJkw=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-34-iXrgX-gtMFa52U8J6Z7t8w-1; Tue, 18 May 2021 05:54:58 -0400
X-MC-Unique: iXrgX-gtMFa52U8J6Z7t8w-1
Received: by mail-wr1-f72.google.com with SMTP id
 u5-20020adf9e050000b029010df603f280so5313751wre.18
 for <virtualization@lists.linux-foundation.org>;
 Tue, 18 May 2021 02:54:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=+VCDqtzyoP1/MzTBF9IVeYAYQ0ccxPfD6Ur9tV2oQ+o=;
 b=VxOjnkU7hK/nhw4j6r5QE6/ELdMoGCFOx5Qcw/99r3rgC4Rfv4uOy8rWWk7N6g2QcG
 JCSQ4UDULRuc7lsYdk3AfCUgVsLbgwRN4JuPcLf10npNH31rQv3PROn/CsxlD/jJJCI7
 W487kaw30Gc8l5K3Zi7m2atLaHZtu/APJlpLbsX1DSq+pLNE3/XkvYIewqyQ1J7hkXpR
 m7uatjfY7INIrVlbHrkHCIYwLZ6TJBDuVjb6wbiGrHuoMIiNVT2nc+yABiSzp3QYgbpy
 YvmGdr4s5FLGYq1MdOH43jBKIQMxy53gLhmw4sEZ4A55gXW6ODAhwdBbO5Gf+49URYsB
 v7ow==
X-Gm-Message-State: AOAM5327NOlonuQXqdbSF+UiGsIGUc4wYWYVhQJZ7R2RgOWlDMIuWkU/
 6nqZjnd+GOcCrZw0QwrxI9wxGjWQZYopSfAkV1QeWZ4j6RQOtdHuNd7XHo0vCoqvr5Pfjxoye4U
 c12Ak7lO4a7QOYBhVi+dnGXspO9aK85VPoiEebceSQg==
X-Received: by 2002:a1c:ed0a:: with SMTP id l10mr4484503wmh.151.1621331697559; 
 Tue, 18 May 2021 02:54:57 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwtNhcvWHDo9BYsG3WxxnHpLZNjEaHmYXrXsXLGKZi1sCaVICC9ZVl/Fur/33Pf1AoORsMwvA==
X-Received: by 2002:a1c:ed0a:: with SMTP id l10mr4484493wmh.151.1621331697424; 
 Tue, 18 May 2021 02:54:57 -0700 (PDT)
Received: from redhat.com ([2a10:800c:1fa6:0:3809:fe0c:bb87:250e])
 by smtp.gmail.com with ESMTPSA id f6sm24076804wru.72.2021.05.18.02.54.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 18 May 2021 02:54:56 -0700 (PDT)
Date: Tue, 18 May 2021 05:54:54 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Xianting Tian <xianting.tian@linux.alibaba.com>
Subject: Re: [PATCH] virtio_net: Remove BUG() to aviod machine dead
Message-ID: <20210518055336-mutt-send-email-mst@kernel.org>
References: <a351fbe1-0233-8515-2927-adc826a7fb94@linux.alibaba.com>
MIME-Version: 1.0
In-Reply-To: <a351fbe1-0233-8515-2927-adc826a7fb94@linux.alibaba.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=mst@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 virtualization@lists.linux-foundation.org, kuba@kernel.org,
 davem@davemloft.net
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

typo in subject

On Tue, May 18, 2021 at 05:46:56PM +0800, Xianting Tian wrote:
> When met error, we output a print to avoid a BUG().
> 
> Signed-off-by: Xianting Tian <xianting.tian@linux.alibaba.com>
> ---
>  drivers/net/virtio_net.c | 5 ++---
>  1 file changed, 2 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
> index c921ebf3ae82..a66174d13e81 100644
> --- a/drivers/net/virtio_net.c
> +++ b/drivers/net/virtio_net.c
> @@ -1647,9 +1647,8 @@ static int xmit_skb(struct send_queue *sq, struct
> sk_buff *skb)
>  		hdr = skb_vnet_hdr(skb);
> 
>  	if (virtio_net_hdr_from_skb(skb, &hdr->hdr,
> -				    virtio_is_little_endian(vi->vdev), false,
> -				    0))
> -		BUG();
> +				virtio_is_little_endian(vi->vdev), false, 0))
> +		return -EPROTO;
> 

why EPROTO? can you add some comments to explain what is going on pls?

is this related to a malicious hypervisor thing?

don't we want at least a WARN_ON? Or _ONCE?

>  	if (vi->mergeable_rx_bufs)
>  		hdr->num_buffers = 0;
> -- 
> 2.17.1

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
