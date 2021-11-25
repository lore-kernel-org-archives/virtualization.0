Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6C647C433EF
	for <virtualization@archiver.kernel.org>; Thu, 25 Nov 2021 07:00:43 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id EFEA24021F;
	Thu, 25 Nov 2021 07:00:42 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id x66Q1mQoIpN0; Thu, 25 Nov 2021 07:00:41 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 497F640018;
	Thu, 25 Nov 2021 07:00:41 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 184C3C0038;
	Thu, 25 Nov 2021 07:00:41 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 906EAC000A
 for <virtualization@lists.linux-foundation.org>;
 Thu, 25 Nov 2021 07:00:39 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 699B64019B
 for <virtualization@lists.linux-foundation.org>;
 Thu, 25 Nov 2021 07:00:39 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 8bBB9Jgt4b_N
 for <virtualization@lists.linux-foundation.org>;
 Thu, 25 Nov 2021 07:00:37 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 5AC0540018
 for <virtualization@lists.linux-foundation.org>;
 Thu, 25 Nov 2021 07:00:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1637823636;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=YvGutxBVxczmzzfrYB1SU+rxjor3OVuX04qAGxlXkWA=;
 b=GCkUuSwp3pG/dFEnu2vtYGD1mjm/XdgIvbc8hZhFeqzSLcHzwsyFhom5agGBcrIYVjmNvm
 P2q5iXPNemMjzB2qB1iEkoeafujxQzAc4HjxmV+RpDVeLtaoEkh0k2lSco591GtOFCZDJk
 AlG9giB0oU4OoGgtCYknHZVk/11/pms=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-477-7JzslypGPc25jfexHjr1hA-1; Thu, 25 Nov 2021 02:00:34 -0500
X-MC-Unique: 7JzslypGPc25jfexHjr1hA-1
Received: by mail-ed1-f69.google.com with SMTP id
 v1-20020aa7cd41000000b003e80973378aso4581218edw.14
 for <virtualization@lists.linux-foundation.org>;
 Wed, 24 Nov 2021 23:00:34 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=YvGutxBVxczmzzfrYB1SU+rxjor3OVuX04qAGxlXkWA=;
 b=Hb4UcCVT/y3Tw1wx0ivSumjZRQZlzZvPLO0lPV+mzYfcPJnqBkeSmALiy52obRSkuL
 jugAW52dQrkuLPRdUDnNeUYyGyWPVxz+1Oq/IBsU8ny6HfVzR0e4HUture01+nB0Og+M
 ztmBfmRP3KZjG2IyY4+x1i/UpYWk0ayll7a1XQDEIbylGljClH+gqOYoa1u3EmVziZL4
 LGAVU+Ob3jh5tvUEC6xk4odcWHxCVhL69ShQ8zlrWFBb4KegT3oa3wYLUSbrL1kja/IA
 fkjXSAbVgsxPpPvzVWN0xiANtAxIC1KEUEf7QMVDT5LOj+Y82C+DauwwFPiVPtEXqUPy
 HaEQ==
X-Gm-Message-State: AOAM530yK+BjSGLAsc77hLjwUB++ETIpIBkv9/H3MnStPSFCzpmUyWVh
 FigcItSooO0RU3chcpyJon4KgYwH76WcEyhuqs+r1UJF9cyMF57KJI6L3OvmUZz+9QdRbEd1tmc
 5jrFhhuMx1RUY3wDzEVBpYv0uuthCnhLMwOF3gorcWw==
X-Received: by 2002:a05:6402:514d:: with SMTP id
 n13mr37269603edd.380.1637823633714; 
 Wed, 24 Nov 2021 23:00:33 -0800 (PST)
X-Google-Smtp-Source: ABdhPJwt9AzGmm67AiDU2VeyIbtxIKZbPDa65Cxd5iNtULGb5LEPNWYW+LlxsIXin1YtDVEPx7kHTQ==
X-Received: by 2002:a05:6402:514d:: with SMTP id
 n13mr37269578edd.380.1637823633552; 
 Wed, 24 Nov 2021 23:00:33 -0800 (PST)
Received: from redhat.com ([45.15.18.67])
 by smtp.gmail.com with ESMTPSA id z8sm1418082edb.5.2021.11.24.23.00.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 24 Nov 2021 23:00:32 -0800 (PST)
Date: Thu, 25 Nov 2021 02:00:26 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Jason Wang <jasowang@redhat.com>
Subject: Re: [PATCH net] virtio-net: enable big mode correctly
Message-ID: <20211125015532-mutt-send-email-mst@kernel.org>
References: <20211125060547.11961-1-jasowang@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20211125060547.11961-1-jasowang@redhat.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=mst@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: netdev@vger.kernel.org, Eli Cohen <elic@nvidia.com>,
 linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org
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

On Thu, Nov 25, 2021 at 02:05:47PM +0800, Jason Wang wrote:
> When VIRTIO_NET_F_MTU feature is not negotiated, we assume a very
> large max_mtu. In this case, using small packet mode is not correct
> since it may breaks the networking when MTU is grater than
> ETH_DATA_LEN.
> 
> To have a quick fix, simply enable the big packet mode when
> VIRTIO_NET_F_MTU is not negotiated.

This will slow down dpdk hosts which disable mergeable buffers
and send standard MTU sized packets.

> We can do optimization on top.

I don't think it works like this, increasing mtu
from guest >4k never worked, we can't regress everyone's
performance with a promise to maybe sometime bring it back.

> Reported-by: Eli Cohen <elic@nvidia.com>
> Cc: Eli Cohen <elic@nvidia.com>
> Signed-off-by: Jason Wang <jasowang@redhat.com>
>
> ---
>  drivers/net/virtio_net.c | 7 ++++---
>  1 file changed, 4 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
> index 7c43bfc1ce44..83ae3ef5eb11 100644
> --- a/drivers/net/virtio_net.c
> +++ b/drivers/net/virtio_net.c
> @@ -3200,11 +3200,12 @@ static int virtnet_probe(struct virtio_device *vdev)
>  		dev->mtu = mtu;
>  		dev->max_mtu = mtu;
>  
> -		/* TODO: size buffers correctly in this case. */
> -		if (dev->mtu > ETH_DATA_LEN)
> -			vi->big_packets = true;
>  	}
>  
> +	/* TODO: size buffers correctly in this case. */
> +	if (dev->max_mtu > ETH_DATA_LEN)
> +		vi->big_packets = true;
> +
>  	if (vi->any_header_sg)
>  		dev->needed_headroom = vi->hdr_len;
>  
> -- 
> 2.25.1

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
