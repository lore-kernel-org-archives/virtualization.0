Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EFF92C77B61
	for <virtualization@archiver.kernel.org>; Fri, 28 Apr 2023 01:09:33 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 7F07B41DF0;
	Fri, 28 Apr 2023 01:09:33 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 7F07B41DF0
Authentication-Results: smtp4.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=DZXSTqNJ
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id ZuPyh9AxtjMO; Fri, 28 Apr 2023 01:09:32 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTPS id C637B41DAA;
	Fri, 28 Apr 2023 01:09:31 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org C637B41DAA
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 9F784C0036;
	Fri, 28 Apr 2023 01:09:31 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 67C0CC002A
 for <virtualization@lists.linux-foundation.org>;
 Fri, 28 Apr 2023 01:09:29 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 33FCC83C8A
 for <virtualization@lists.linux-foundation.org>;
 Fri, 28 Apr 2023 01:09:29 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 33FCC83C8A
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=DZXSTqNJ
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 7Mj0GKdupssf
 for <virtualization@lists.linux-foundation.org>;
 Fri, 28 Apr 2023 01:09:28 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 846D383B1E
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 846D383B1E
 for <virtualization@lists.linux-foundation.org>;
 Fri, 28 Apr 2023 01:09:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1682644167;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=vDlMjQQs9oNd1rM1Ie1hZYk7Gu1+pdqFqGgkpF/yxbI=;
 b=DZXSTqNJUsv5wdNWTswQJp8aSfoleaQ1eesrm+5RhO88YzlGH42G8Kp14HtdLvdlwYzbGH
 8z61Fy+1GcXpw/KVjBCg64rgRhMKypuT0No7DL/6GB0oUA7BLpMeQCpD5gVjv+0w0nnjQ8
 JZ45FkegG6wMxTCKWCAv8njwKrFK/i0=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-175-YukIjdzZOV6YviFe62bqwA-1; Thu, 27 Apr 2023 21:09:25 -0400
X-MC-Unique: YukIjdzZOV6YviFe62bqwA-1
Received: by mail-wr1-f72.google.com with SMTP id
 ffacd0b85a97d-2ff4bc7a770so5162502f8f.3
 for <virtualization@lists.linux-foundation.org>;
 Thu, 27 Apr 2023 18:09:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1682644164; x=1685236164;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=vDlMjQQs9oNd1rM1Ie1hZYk7Gu1+pdqFqGgkpF/yxbI=;
 b=hsg6UDOil00W00d1wGrfLovV/p9RLZysU4wOJP6sAPj1ZNz+5Ih79H/GtKT7rynPQs
 84hMtXZC8hqUs7Xxh8YtTRxGRCcmoNQ5oZO/xAFOTwvEo9IsMa4nuhTwR2oKhUIzy0tr
 WJ8qoF9BhdFHI06Pzpnw39tuvbbDReBVKWh2H+QGloF3oNefp52THaV0LuI0IlnuMVhc
 1O54iuXemLC8mstd0hSsa+FeGYYG0d02JyQ4sth9K1iQ3yUjUuZfdKBjX/37vbm/waEU
 zNY0PUsWQEHiXaX0NnkgNB7TeScN8H2mGcIlvkfngv1xU6u18Pvn6qRHtyab4TRLnHcK
 JGyw==
X-Gm-Message-State: AC+VfDyED027qD3yVfU+MLihCrq3UsoY8zPF77sV0LKl7/PDwAKn0z/+
 2LV9mxsBcqnoH64pJ9aVRE87bmY73BzjvTjtQQSy57HgDdVYq0zFPDK40hFnMci7Pq9Q7QmglK+
 SAz7xWSe/veL/ao+Hl3+f+uNh3OjXkJ00jOAHnEHmfg==
X-Received: by 2002:adf:dd90:0:b0:304:b967:956f with SMTP id
 x16-20020adfdd90000000b00304b967956fmr706843wrl.8.1682644164583; 
 Thu, 27 Apr 2023 18:09:24 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ4fv40ETH5op2sNv7xlB+MUhzP96QeT1eiO1SHh4pfOCErUxvz9m5RaLdAL6HtipgJ+xEF8MA==
X-Received: by 2002:adf:dd90:0:b0:304:b967:956f with SMTP id
 x16-20020adfdd90000000b00304b967956fmr706834wrl.8.1682644164304; 
 Thu, 27 Apr 2023 18:09:24 -0700 (PDT)
Received: from redhat.com ([2.52.19.183]) by smtp.gmail.com with ESMTPSA id
 e22-20020a5d5956000000b003012030a0c6sm19719410wri.18.2023.04.27.18.09.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 27 Apr 2023 18:09:23 -0700 (PDT)
Date: Thu, 27 Apr 2023 21:09:20 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Wenliang Wang <wangwenliang.1995@bytedance.com>
Subject: Re: [PATCH v2] virtio_net: suppress cpu stall when free_unused_bufs
Message-ID: <20230427210851-mutt-send-email-mst@kernel.org>
References: <1682585517.595783-3-xuanzhuo@linux.alibaba.com>
 <20230427104618.3297348-1-wangwenliang.1995@bytedance.com>
MIME-Version: 1.0
In-Reply-To: <20230427104618.3297348-1-wangwenliang.1995@bytedance.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 virtualization@lists.linux-foundation.org, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, davem@davemloft.net
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

On Thu, Apr 27, 2023 at 06:46:18PM +0800, Wenliang Wang wrote:
> For multi-queue and large ring-size use case, the following error
> occurred when free_unused_bufs:
> rcu: INFO: rcu_sched self-detected stall on CPU.
> 
> Signed-off-by: Wenliang Wang <wangwenliang.1995@bytedance.com>

pls send vN+1 as a new thread not as a reply in existing thread of vN.

> ---
> v2:
> -add need_resched check.
> -apply same logic to sq.
> ---
>  drivers/net/virtio_net.c | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
> index ea1bd4bb326d..573558b69a60 100644
> --- a/drivers/net/virtio_net.c
> +++ b/drivers/net/virtio_net.c
> @@ -3559,12 +3559,16 @@ static void free_unused_bufs(struct virtnet_info *vi)
>  		struct virtqueue *vq = vi->sq[i].vq;
>  		while ((buf = virtqueue_detach_unused_buf(vq)) != NULL)
>  			virtnet_sq_free_unused_buf(vq, buf);
> +		if (need_resched())
> +			schedule();
>  	}
>  
>  	for (i = 0; i < vi->max_queue_pairs; i++) {
>  		struct virtqueue *vq = vi->rq[i].vq;
>  		while ((buf = virtqueue_detach_unused_buf(vq)) != NULL)
>  			virtnet_rq_free_unused_buf(vq, buf);
> +		if (need_resched())
> +			schedule();
>  	}
>  }
>  
> -- 
> 2.20.1

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
