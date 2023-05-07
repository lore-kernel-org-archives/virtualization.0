Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A00F2C77B75
	for <virtualization@archiver.kernel.org>; Sun,  7 May 2023 05:59:51 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 160F6821A3;
	Sun,  7 May 2023 05:59:51 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 160F6821A3
Authentication-Results: smtp1.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=PVIRIgzF
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id WcLI6RcmL7eO; Sun,  7 May 2023 05:59:50 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 9585D82176;
	Sun,  7 May 2023 05:59:49 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 9585D82176
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 76478C0037;
	Sun,  7 May 2023 05:59:49 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 539C4C002A
 for <virtualization@lists.linux-foundation.org>;
 Sun,  7 May 2023 05:59:48 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 1AF0082182
 for <virtualization@lists.linux-foundation.org>;
 Sun,  7 May 2023 05:59:48 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 1AF0082182
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id UcWp1XklIqg7
 for <virtualization@lists.linux-foundation.org>;
 Sun,  7 May 2023 05:59:47 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org D726E82176
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp1.osuosl.org (Postfix) with ESMTPS id D726E82176
 for <virtualization@lists.linux-foundation.org>;
 Sun,  7 May 2023 05:59:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1683439185;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=f3vnav72jiBSDlUv6QQjHr2dDSLqhQhKBN44HYd9MYY=;
 b=PVIRIgzFPvYoYUpO5hthYByew31SZbPVrry6AdwAtcrUOw4MKzgJOQY8J+hM5G2+D/LKXp
 NgqPqDgql4EJLCDzsewBfElS3HRq3qfFwk0ahql1ZfY/zwkBQ/Lje8dod3AyP0Y8W1ICPx
 FVGbU8Uk8OsYvYOKdxAdKfiK07GLAac=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-639-cuKpgvc1PnqeaerBmN4jwg-1; Sun, 07 May 2023 01:59:42 -0400
X-MC-Unique: cuKpgvc1PnqeaerBmN4jwg-1
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-3f321e60feaso12380635e9.0
 for <virtualization@lists.linux-foundation.org>;
 Sat, 06 May 2023 22:59:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1683439181; x=1686031181;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=f3vnav72jiBSDlUv6QQjHr2dDSLqhQhKBN44HYd9MYY=;
 b=FT5raPm+JklUUeNEB8ZDD60SblTS5/cMJ1nB8/bHBHBtiPSg8EsA6YqTI8D2Ld3CKA
 A4cVo1l0E++4q58KxuBZuMm9KEG5q8wT0OyV2Csc3FEDpDAV+SzhO3wDXluy7AJI9vOj
 yBXU7SPuVMWbs5ScNRYBtGzxuzN0X17Dol5Qe23L8Yt94BS+fUkX6ApVZaGzRRZmHjx5
 +QHcPWHnoEnpJO9Y1FEt/1fW77ytv/zYqYRmdQ6J+cSG1yY/hDnmw+HUgP/c5AbmhjyV
 PnhX0q/NtJH5Zld70OvZer7K32NOz1pM8jGyrX11KWrJsEv5jX2RvGM1pTVdhFnhPsif
 CUew==
X-Gm-Message-State: AC+VfDz+i1/1TMD7s9yZUnV3ZkfSbtHvkFS/bGjtKvpQZFH2VtB3IzcI
 GRD3663EBHS7KmxWI3wUhPr3A8FWts4bn5shX96GDt7jRqKiUQ3fGL3I/GIVASue4os4WwhvL7q
 bdr4Ly4pcSrNCb3nOQXIDxqzwl3OB+yW+ALLNhAScgA==
X-Received: by 2002:a7b:c3cf:0:b0:3f4:21cf:b4a4 with SMTP id
 t15-20020a7bc3cf000000b003f421cfb4a4mr793838wmj.20.1683439181083; 
 Sat, 06 May 2023 22:59:41 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ5DUhiBqArpzzgosy6y74xywVU2Y2452GBQMAxT+LK1BKQwrXh1Hycvooc6PGiDtpgWSWRPyQ==
X-Received: by 2002:a7b:c3cf:0:b0:3f4:21cf:b4a4 with SMTP id
 t15-20020a7bc3cf000000b003f421cfb4a4mr793825wmj.20.1683439180804; 
 Sat, 06 May 2023 22:59:40 -0700 (PDT)
Received: from redhat.com ([2.52.158.28]) by smtp.gmail.com with ESMTPSA id
 k22-20020a05600c0b5600b003f40049a65bsm11545710wmr.21.2023.05.06.22.59.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 06 May 2023 22:59:40 -0700 (PDT)
Date: Sun, 7 May 2023 01:59:35 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Hao Chen <chenh@yusur.tech>
Subject: Re: [PATCH] virtio_net: set default mtu to 1500 when 'Device maximum
 MTU' bigger than 1500
Message-ID: <20230507015819-mutt-send-email-mst@kernel.org>
References: <20230506021529.396812-1-chenh@yusur.tech>
MIME-Version: 1.0
In-Reply-To: <20230506021529.396812-1-chenh@yusur.tech>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: Xuan Zhuo <xuanzhuo@linux.alibaba.com>, zy@yusur.tech,
 "open list:NETWORKING DRIVERS" <netdev@vger.kernel.org>,
 open list <linux-kernel@vger.kernel.org>,
 "open list:VIRTIO CORE AND NET DRIVERS"
 <virtualization@lists.linux-foundation.org>,
 Eric Dumazet <edumazet@google.com>, huangml@yusur.tech,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 "David S. Miller" <davem@davemloft.net>
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

On Sat, May 06, 2023 at 10:15:29AM +0800, Hao Chen wrote:
> When VIRTIO_NET_F_MTU(3) Device maximum MTU reporting is supported.
> If offered by the device, device advises driver about the value of its
> maximum MTU. If negotiated, the driver uses mtu as the maximum
> MTU value. But there the driver also uses it as default mtu,
> some devices may have a maximum MTU greater than 1500, this may
> cause some large packages to be discarded, so I changed the MTU to a more
> general 1500 when 'Device maximum MTU' bigger than 1500.
> 
> Signed-off-by: Hao Chen <chenh@yusur.tech>

I don't see why not use the maximum. Bigger packets = better
performance.

> ---
>  drivers/net/virtio_net.c | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
> index 8d8038538fc4..e71c7d1b5f29 100644
> --- a/drivers/net/virtio_net.c
> +++ b/drivers/net/virtio_net.c
> @@ -4040,7 +4040,10 @@ static int virtnet_probe(struct virtio_device *vdev)
>  			goto free;
>  		}
>  
> -		dev->mtu = mtu;
> +		if (mtu > 1500)
> +			dev->mtu = 1500;
> +		else
> +			dev->mtu = mtu;
>  		dev->max_mtu = mtu;
>  	}
>  
> -- 
> 2.27.0

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
