Return-Path: <SRS0=jrxE=KP=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_RED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 27473C433ED
	for <virtualization@archiver.kernel.org>; Thu, 20 May 2021 07:35:48 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BD92860FE5
	for <virtualization@archiver.kernel.org>; Thu, 20 May 2021 07:35:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BD92860FE5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 8055A605CD;
	Thu, 20 May 2021 07:35:47 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id pkWt69hTfPgi; Thu, 20 May 2021 07:35:46 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTP id 3C45B60628;
	Thu, 20 May 2021 07:35:46 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id F41B5C000E;
	Thu, 20 May 2021 07:35:45 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 9FB07C0001
 for <virtualization@lists.linux-foundation.org>;
 Thu, 20 May 2021 07:35:44 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 78979400AB
 for <virtualization@lists.linux-foundation.org>;
 Thu, 20 May 2021 07:35:44 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp2.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 4Df25vCpJIBd
 for <virtualization@lists.linux-foundation.org>;
 Thu, 20 May 2021 07:35:43 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [216.205.24.124])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 47A9240198
 for <virtualization@lists.linux-foundation.org>;
 Thu, 20 May 2021 07:35:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1621496141;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=c2GC6XfcAGM7klDITVVJQzbY0FDd+BlAJFrTDoANgwk=;
 b=i3AZHTyrCrZ0+/w4ZhB1hQPD1w7N8dZp4b5hGYBAZLqinpMhUdsajaKxY9uOurc6mUoVGg
 zAUztllzJu9SFlWS31rUv7qTgvLhx/rVq24H8KLZQ98uhMSccELzIFvHtZia6G7IcO/xb8
 Bp3LwJM+SLFpl5TZQg1lE9i2i2UIdAU=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-423-IOBUjqo4NACVSM1Icvx1Pw-1; Thu, 20 May 2021 03:35:40 -0400
X-MC-Unique: IOBUjqo4NACVSM1Icvx1Pw-1
Received: by mail-ed1-f69.google.com with SMTP id
 q18-20020a50cc920000b029038cf491864cso9066554edi.14
 for <virtualization@lists.linux-foundation.org>;
 Thu, 20 May 2021 00:35:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=c2GC6XfcAGM7klDITVVJQzbY0FDd+BlAJFrTDoANgwk=;
 b=Mv282Y0BzNmtWe5HSzrwciuwdv70GfUTjMSq9c6w66t4X5UQ9JC6fGG9DpXq85ANh/
 MEU+5u8IJrFu05hO/D8StXsiYeO6n8B/PCN7decaOi9u1fahlyaF2Iso+bxLHzy6f5Fr
 ZpAYs82qlL0X78KtBfAFs6fIGDbD5tBMxu9KVxiwnENCExM2kdrXuRO+D+8xzgMugb2u
 GcXwaxZ9mtDyaf0maRJbdtVp1O0TN8n+yMBR5DfEmhHE7Qh7u2BBgPKVYA88hcpbDxZ2
 mRfK5Cbyhy67qOzi8uMBiD/nl64UMaVdlct0378wKtnNS50jruWuXsLdyNt1WsLcEAW4
 L5Pg==
X-Gm-Message-State: AOAM533Xsp+kctg2i5w863EKShuN1SNi5n+86tD1D24uwvfnUChZf7e7
 vcUo1jOQ1Yb4ioFqP4MMzni/Pr3NyQB2ByrU5uGKMwjpqE0Wb+KydeUedcj5i7TRCpAelTpIs0U
 3xxQbo32QfHsUJIs9u5W9n0iNeS/DcLwfOXkO40ziSg==
X-Received: by 2002:a17:906:5fd1:: with SMTP id
 k17mr3268856ejv.78.1621496138923; 
 Thu, 20 May 2021 00:35:38 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJz3yNqbBi9L1vw+iCsmEmnynKc2Wo1hueUUMZwRAIdxoVlgOwjm86mz7dHambL3NGBp2Mtvog==
X-Received: by 2002:a17:906:5fd1:: with SMTP id
 k17mr3268844ejv.78.1621496138769; 
 Thu, 20 May 2021 00:35:38 -0700 (PDT)
Received: from steredhat (host-79-18-148-79.retail.telecomitalia.it.
 [79.18.148.79])
 by smtp.gmail.com with ESMTPSA id ga3sm951545ejb.34.2021.05.20.00.35.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 20 May 2021 00:35:38 -0700 (PDT)
Date: Thu, 20 May 2021 09:35:36 +0200
From: Stefano Garzarella <sgarzare@redhat.com>
To: Xianting Tian <xianting.tian@linux.alibaba.com>
Subject: Re: [PATCH] virtio_net: Remove BUG() to aviod machine dead
Message-ID: <20210520073536.wwt35gsz62bv27hm@steredhat>
References: <a351fbe1-0233-8515-2927-adc826a7fb94@linux.alibaba.com>
MIME-Version: 1.0
In-Reply-To: <a351fbe1-0233-8515-2927-adc826a7fb94@linux.alibaba.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=sgarzare@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: mst@redhat.com, netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
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
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>

If you need to respin, there is a typo in the title s/aviod/avoid/

On Tue, May 18, 2021 at 05:46:56PM +0800, Xianting Tian wrote:
>When met error, we output a print to avoid a BUG().
>
>Signed-off-by: Xianting Tian <xianting.tian@linux.alibaba.com>
>---
> drivers/net/virtio_net.c | 5 ++---
> 1 file changed, 2 insertions(+), 3 deletions(-)
>
>diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
>index c921ebf3ae82..a66174d13e81 100644
>--- a/drivers/net/virtio_net.c
>+++ b/drivers/net/virtio_net.c
>@@ -1647,9 +1647,8 @@ static int xmit_skb(struct send_queue *sq, 
>struct sk_buff *skb)
> 		hdr = skb_vnet_hdr(skb);
>
> 	if (virtio_net_hdr_from_skb(skb, &hdr->hdr,
>-				    virtio_is_little_endian(vi->vdev), false,
>-				    0))
>-		BUG();
>+				virtio_is_little_endian(vi->vdev), false, 0))
                                 ^
                                 This change is not related.

>+		return -EPROTO;
>
> 	if (vi->mergeable_rx_bufs)
> 		hdr->num_buffers = 0;
>-- 
>2.17.1
>

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
