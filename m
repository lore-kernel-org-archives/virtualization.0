Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0B330C54EED
	for <virtualization@archiver.kernel.org>; Mon, 30 Jan 2023 15:20:08 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 669A241506;
	Mon, 30 Jan 2023 15:20:08 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 669A241506
Authentication-Results: smtp4.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=ZixdiZEH
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id TVN8u4L-prDS; Mon, 30 Jan 2023 15:20:07 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTPS id BBB41414C5;
	Mon, 30 Jan 2023 15:20:04 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org BBB41414C5
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 9044DC0032;
	Mon, 30 Jan 2023 15:20:04 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id AD096C002B
 for <virtualization@lists.linux-foundation.org>;
 Mon, 30 Jan 2023 15:20:03 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 7A2C560FC8
 for <virtualization@lists.linux-foundation.org>;
 Mon, 30 Jan 2023 15:20:03 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 7A2C560FC8
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=ZixdiZEH
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id RBqTHNpQS5nL
 for <virtualization@lists.linux-foundation.org>;
 Mon, 30 Jan 2023 15:20:02 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org AD90A60FBF
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp3.osuosl.org (Postfix) with ESMTPS id AD90A60FBF
 for <virtualization@lists.linux-foundation.org>;
 Mon, 30 Jan 2023 15:20:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1675092001;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Ah3avzpBOJRu+37auLlVBnHx/4BkYm4lFjO5EaAcHnw=;
 b=ZixdiZEHXlxeG0tPYq9DWxZrGLaFHCbg9yQlNY27GtSmr8gr0MawR+p4NEFdBq7IqUuN6P
 w7pkxGT70zd1Kqnf/ko7SmX6OSIi1DZP0mTgP74U2UFwV6qrnPueYZ43MnsbVuYQxMEv7j
 oQItgestrlj5NsvAnvUu9oEL4vTCXcg=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-331-8eUoZ3BlOVGGpVM89SdN4w-1; Mon, 30 Jan 2023 10:20:00 -0500
X-MC-Unique: 8eUoZ3BlOVGGpVM89SdN4w-1
Received: by mail-wr1-f72.google.com with SMTP id
 r6-20020adff106000000b002bfe5fb9649so973383wro.14
 for <virtualization@lists.linux-foundation.org>;
 Mon, 30 Jan 2023 07:20:00 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Ah3avzpBOJRu+37auLlVBnHx/4BkYm4lFjO5EaAcHnw=;
 b=M2GK9Tm019Iq/0Xm4IYw4Uf8Zr7CbUzNV3cAAUFdP3dMe8LGhKSaLTiMSZFIH/p35N
 veGLEuW/UVW6pt1uhhKfxPjm5Sd++Ac4URGzrme60HzyoWbOkbnBeVjQUJqKEG6iAi87
 oq/eKM0OwblXDlNU0sCAAbaVGJY81xogn11a4XJkO6VtrJ5Zpw5e6Z7pIWaW2B7wb+11
 hm4Zmsr+VGU21jTaqiKZ/si5sVmtGHMqQOONBAbIGttcBsTg6bJm4A15O6qMa93laxpW
 3q33lZMq4apPTQggMVryiWfmkH2KUO97ChvN8YsEJQ2qNEG6K32TZSsjvS5AGHkvDwQD
 LV3Q==
X-Gm-Message-State: AFqh2kqml2yeSTJpbmf504AVqvEVVBrjU2rVRTgqsubIU0i8kaoQKkOA
 FzmF+ffWhahmjuISb47HFwMatziDKSYClIoe4YCOhywd1GSIuAc7zExaeQMEkhM3QERFAhuoamY
 UxUTYkhT7ft76w/L9jLbZ8bp5pLzBkLYiFkUyBTdx1w==
X-Received: by 2002:a05:600c:1e21:b0:3d0:7fee:8a70 with SMTP id
 ay33-20020a05600c1e2100b003d07fee8a70mr52242939wmb.19.1675091999184; 
 Mon, 30 Jan 2023 07:19:59 -0800 (PST)
X-Google-Smtp-Source: AMrXdXsu1w8+EO1CI/aqnigYPF7jxubbyQ5nAweq8tir4J7qtyJNK1XxMEfGlrHUe8RqvFQGuvEBew==
X-Received: by 2002:a05:600c:1e21:b0:3d0:7fee:8a70 with SMTP id
 ay33-20020a05600c1e2100b003d07fee8a70mr52242919wmb.19.1675091998974; 
 Mon, 30 Jan 2023 07:19:58 -0800 (PST)
Received: from redhat.com ([2.52.144.173]) by smtp.gmail.com with ESMTPSA id
 f9-20020a05600c4e8900b003d990372dd5sm18938810wmq.20.2023.01.30.07.19.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 30 Jan 2023 07:19:58 -0800 (PST)
Date: Mon, 30 Jan 2023 10:19:51 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH 22/23] vring: use bvec_set_page to initialize a bvec
Message-ID: <20230130101811-mutt-send-email-mst@kernel.org>
References: <20230130092157.1759539-1-hch@lst.de>
 <20230130092157.1759539-23-hch@lst.de>
MIME-Version: 1.0
In-Reply-To: <20230130092157.1759539-23-hch@lst.de>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: kvm@vger.kernel.org, virtualization@lists.linux-foundation.org,
 David Howells <dhowells@redhat.com>, linux-mm@kvack.org,
 Eric Dumazet <edumazet@google.com>, Marc Dionne <marc.dionne@auristor.com>,
 Mike Marshall <hubcap@omnibond.com>, Sagi Grimberg <sagi@grimberg.me>,
 Minchan Kim <minchan@kernel.org>, io-uring@vger.kernel.org,
 Jakub Kicinski <kuba@kernel.org>, Ilya Dryomov <idryomov@gmail.com>,
 Paolo Abeni <pabeni@redhat.com>, devel@lists.orangefs.org,
 linux-block@vger.kernel.org, Keith Busch <kbusch@kernel.org>,
 Xiubo Li <xiubli@redhat.com>,
 Trond Myklebust <trond.myklebust@hammerspace.com>,
 Jens Axboe <axboe@kernel.dk>,
 "Martin K. Petersen" <martin.petersen@oracle.com>, netdev@vger.kernel.org,
 Steve French <sfrench@samba.org>,
 Sergey Senozhatsky <senozhatsky@chromium.org>,
 Chuck Lever <chuck.lever@oracle.com>, Anna Schumaker <anna@kernel.org>,
 Andrew Morton <akpm@linux-foundation.org>,
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

On Mon, Jan 30, 2023 at 10:21:56AM +0100, Christoph Hellwig wrote:
> Use the bvec_set_page helper to initialize a bvec.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>

Acked-by: Michael S. Tsirkin <mst@redhat.com>

> ---
>  drivers/vhost/vringh.c | 5 ++---
>  1 file changed, 2 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/vhost/vringh.c b/drivers/vhost/vringh.c
> index 33eb941fcf1546..a1e27da544814a 100644
> --- a/drivers/vhost/vringh.c
> +++ b/drivers/vhost/vringh.c
> @@ -1126,9 +1126,8 @@ static int iotlb_translate(const struct vringh *vrh,
>  		size = map->size - addr + map->start;
>  		pa = map->addr + addr - map->start;
>  		pfn = pa >> PAGE_SHIFT;
> -		iov[ret].bv_page = pfn_to_page(pfn);
> -		iov[ret].bv_len = min(len - s, size);
> -		iov[ret].bv_offset = pa & (PAGE_SIZE - 1);
> +		bvec_set_page(&iov[ret], pfn_to_page(pfn), min(len - s, size),
> +			      pa & (PAGE_SIZE - 1));
>  		s += size;
>  		addr += size;
>  		++ret;
> -- 
> 2.39.0

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
