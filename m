Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C0FB0C77B73
	for <virtualization@archiver.kernel.org>; Mon,  1 May 2023 14:15:25 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 46B1740B93;
	Mon,  1 May 2023 14:15:25 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 46B1740B93
Authentication-Results: smtp2.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=LAMQYw8G
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id NpfHSjMKdm9w; Mon,  1 May 2023 14:15:24 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp2.osuosl.org (Postfix) with ESMTPS id C3B7C40491;
	Mon,  1 May 2023 14:15:23 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org C3B7C40491
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id AC959C0037;
	Mon,  1 May 2023 14:15:23 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id E9C26C002A
 for <virtualization@lists.linux-foundation.org>;
 Mon,  1 May 2023 14:15:22 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id D1EFE81E56
 for <virtualization@lists.linux-foundation.org>;
 Mon,  1 May 2023 14:15:22 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org D1EFE81E56
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=LAMQYw8G
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id aOepFo5q-Hb5
 for <virtualization@lists.linux-foundation.org>;
 Mon,  1 May 2023 14:15:22 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 249E881E13
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 249E881E13
 for <virtualization@lists.linux-foundation.org>;
 Mon,  1 May 2023 14:15:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1682950521;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Y06KhFiSRmxfz+95pafw0MpGOEwTRg5/RLAX9104Y+A=;
 b=LAMQYw8GA1rM6JUI7nYDav29spS5L1XCk8QyRQ7iy1IeHcLxlgiUhv3diNYudA9bG6Jwo1
 WFQpexga6E7J+kW5o8Pcmc7Pr3hEAheXYfDrZK34nKmVDeYWwPQfkn0udzFKo7KqGbvNoY
 geHKWpLrN5zmfY+pYCnFb38I0DkqkhA=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-576-eikWCMw4PsGFJK5Ur8BbRA-1; Mon, 01 May 2023 10:15:01 -0400
X-MC-Unique: eikWCMw4PsGFJK5Ur8BbRA-1
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-3f1793d6363so7171055e9.1
 for <virtualization@lists.linux-foundation.org>;
 Mon, 01 May 2023 07:15:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1682950499; x=1685542499;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Y06KhFiSRmxfz+95pafw0MpGOEwTRg5/RLAX9104Y+A=;
 b=bGZQSUB/+Ugp76boGOrDPO/hPN/28WTCKESfdH091+ECL7bnV7uORwmlI+bGJWmz1i
 ui0yB3aIZHumjsKIVwSwudkSlPgGvc8MC5NBXuTQH/2KTV9TaeTqSsboayHta6XeEbJX
 PI2xvyXqCKS6fd5QCrde1Yh0sDfqJaNqzUgOTaOFdWpU5+zjq2yhhkMfNH3nFz1ooSsE
 HaVe4NssFJzYcoafdcn9P58KGZrxjt8NGLViyybQYLKnP+JpbJpufnre7THuQQKSqQcG
 Y322BdPpwyfByGSfGwp9+9mtBH06RW4tffFnAX8+ktCoe2BBDXZFbzilF0G2EcK1Tlku
 x69g==
X-Gm-Message-State: AC+VfDy5UJGcPa1V4slEzKF42W04e1UnONpWJUd/BHRQDwbISU71dwbc
 7YIu73dk3SKkMK5PqzgUN8+kNLqyElIU4tH1PWO0O77TUgEW7OrKzsnyt09npk0yduMLyaw9hIK
 H4Ehjip+G3xzVT+iDQae5OYiIpnmu6KJeaQL9FflcAA==
X-Received: by 2002:a7b:c5d9:0:b0:3ed:b048:73f4 with SMTP id
 n25-20020a7bc5d9000000b003edb04873f4mr9553259wmk.5.1682950499073; 
 Mon, 01 May 2023 07:14:59 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ7y0Up0kde569/l4iM+Ve0RAZmTBkiozrp7NzXkC2ctDGii5Zttu8Ai2doElpYS4GvXCAS9ZQ==
X-Received: by 2002:a7b:c5d9:0:b0:3ed:b048:73f4 with SMTP id
 n25-20020a7bc5d9000000b003edb04873f4mr9553246wmk.5.1682950498792; 
 Mon, 01 May 2023 07:14:58 -0700 (PDT)
Received: from redhat.com ([31.210.184.46]) by smtp.gmail.com with ESMTPSA id
 h16-20020a05600c315000b003f173a2b2f6sm36487588wmo.12.2023.05.01.07.14.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 01 May 2023 07:14:58 -0700 (PDT)
Date: Mon, 1 May 2023 10:14:55 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Feng Liu <feliu@nvidia.com>
Subject: Re: [PATCH net v1 2/2] virtio_net: Close queue pairs using helper
 function
Message-ID: <20230501101450-mutt-send-email-mst@kernel.org>
References: <20230428224346.68211-1-feliu@nvidia.com>
MIME-Version: 1.0
In-Reply-To: <20230428224346.68211-1-feliu@nvidia.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: Xuan Zhuo <xuanzhuo@linux.alibaba.com>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org,
 William Tu <witu@nvidia.com>, bpf@vger.kernel.org
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

On Fri, Apr 28, 2023 at 06:43:46PM -0400, Feng Liu wrote:
> Use newly introduced helper function that exactly does the same of
> closing the queue pairs.
> 
> Signed-off-by: Feng Liu <feliu@nvidia.com>
> Reviewed-by: William Tu <witu@nvidia.com>
> Reviewed-by: Parav Pandit <parav@nvidia.com>

Acked-by: Michael S. Tsirkin <mst@redhat.com>

> ---
>  drivers/net/virtio_net.c | 7 ++-----
>  1 file changed, 2 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
> index fc6ee833a09f..5cd78e154d14 100644
> --- a/drivers/net/virtio_net.c
> +++ b/drivers/net/virtio_net.c
> @@ -2319,11 +2319,8 @@ static int virtnet_close(struct net_device *dev)
>  	/* Make sure refill_work doesn't re-enable napi! */
>  	cancel_delayed_work_sync(&vi->refill);
>  
> -	for (i = 0; i < vi->max_queue_pairs; i++) {
> -		virtnet_napi_tx_disable(&vi->sq[i].napi);
> -		napi_disable(&vi->rq[i].napi);
> -		xdp_rxq_info_unreg(&vi->rq[i].xdp_rxq);
> -	}
> +	for (i = 0; i < vi->max_queue_pairs; i++)
> +		virtnet_disable_qp(vi, i);
>  
>  	return 0;
>  }
> -- 
> 2.37.1 (Apple Git-137.1)

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
