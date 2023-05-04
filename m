Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 07BEBC77B7C
	for <virtualization@archiver.kernel.org>; Thu,  4 May 2023 07:06:24 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 7A70683EE5;
	Thu,  4 May 2023 07:06:24 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 7A70683EE5
Authentication-Results: smtp1.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=aGDu/bNB
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 9XLp5vDdj1NN; Thu,  4 May 2023 07:06:23 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTPS id E466583EE1;
	Thu,  4 May 2023 07:06:22 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org E466583EE1
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id BB1C2C0037;
	Thu,  4 May 2023 07:06:22 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 67707C002A
 for <virtualization@lists.linux-foundation.org>;
 Thu,  4 May 2023 07:06:21 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 3B21841DCC
 for <virtualization@lists.linux-foundation.org>;
 Thu,  4 May 2023 07:06:21 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 3B21841DCC
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=aGDu/bNB
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id lj6RosgRp5XV
 for <virtualization@lists.linux-foundation.org>;
 Thu,  4 May 2023 07:06:20 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org CEBB541DBB
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp2.osuosl.org (Postfix) with ESMTPS id CEBB541DBB
 for <virtualization@lists.linux-foundation.org>;
 Thu,  4 May 2023 07:06:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1683183978;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=7iM8ql6U32hllNnQM8/MvCWRLr14Z6gVQHMHyvjhAJs=;
 b=aGDu/bNBlBaZI0bP+pV1nVfaTezeIFModt2rR7Kk5AgxvU70TciGGgTBHA6x2hjJnx8uLb
 H9TtQUpy+zE82NnqPSVjGlt3rp1TTj2IBW1tOSOnNmatpK/pquKOO8ecMQWHn1u+IaxvyL
 7B1da+5Hun/+0jWnv6AyrJMYPorZcms=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-365-rH2iLM31MsOVdhZ-smhOpg-1; Thu, 04 May 2023 03:06:17 -0400
X-MC-Unique: rH2iLM31MsOVdhZ-smhOpg-1
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-3f315735edeso31328575e9.1
 for <virtualization@lists.linux-foundation.org>;
 Thu, 04 May 2023 00:06:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1683183976; x=1685775976;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=7iM8ql6U32hllNnQM8/MvCWRLr14Z6gVQHMHyvjhAJs=;
 b=hYapeqJemfBRKCj0CzF78+Rhr/sSmKpT4Te4xRNErcQyJhqOM1HA1dBrUJsG6m12zI
 ZD7Mn+JFsAgwSdnf4RqFmqKD71wE5btvD19dE0tTFPdDCDLJaRotsj8YJyG3oF5BcABb
 NipQ3lStMmoq5Yp13kWlIR+W0Aw+b7XtLFfn+1MHMubja+4CIBVb0UsM/pq5N0rDP+BO
 Zvt35bys1MV2HaiCKx8JdtHlqnVju46LZEnXZCYaqKYhQR+tTOZCbdUeMBYzkp2Uba4u
 TrR9yLz5MuVZOVLY5YIEJTdpz01XDWIvzY2Ej2x5N0o2LvNGSLkNQ2/xQGXO6n6u5quP
 A6LA==
X-Gm-Message-State: AC+VfDzxaXT9+yyqTxXB0yl9hsBsxbKm6A/7y3RUJQxQWNAyKXaKxs2O
 ggR2uwP7L2GUBZgzBjWOZ50a/giknYZgLq5IZU5WVgcS+pleY7p8R7cbz/wMRxxLO5nj2qPUn8d
 hbcvMvOrA/rUWwywiTmFYFa2hJYGmBRRCCK3vkPmQYA==
X-Received: by 2002:adf:f950:0:b0:2f1:b74:5d8a with SMTP id
 q16-20020adff950000000b002f10b745d8amr1675314wrr.5.1683183976224; 
 Thu, 04 May 2023 00:06:16 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ4CgwTMT0Nhemerdz6SF54k/h2cU7j+aMDelbq7ULOYa16/suNYC6YVRr/AAzrrM8mjZYvILA==
X-Received: by 2002:adf:f950:0:b0:2f1:b74:5d8a with SMTP id
 q16-20020adff950000000b002f10b745d8amr1675292wrr.5.1683183975895; 
 Thu, 04 May 2023 00:06:15 -0700 (PDT)
Received: from redhat.com ([31.187.78.120]) by smtp.gmail.com with ESMTPSA id
 s1-20020adff801000000b00300aee6c9cesm35957612wrp.20.2023.05.04.00.06.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 04 May 2023 00:06:15 -0700 (PDT)
Date: Thu, 4 May 2023 03:06:10 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Wenliang Wang <wangwenliang.1995@bytedance.com>
Subject: Re: [PATCH v4] virtio_net: suppress cpu stall when free_unused_bufs
Message-ID: <20230504030546-mutt-send-email-mst@kernel.org>
References: <1683167226-7012-1-git-send-email-wangwenliang.1995@bytedance.com>
MIME-Version: 1.0
In-Reply-To: <1683167226-7012-1-git-send-email-wangwenliang.1995@bytedance.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: xuanzhuo@linux.alibaba.com, willemdebruijn.kernel@gmail.com,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 zhengqi.arch@bytedance.com, virtualization@lists.linux-foundation.org,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, davem@davemloft.net
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

On Thu, May 04, 2023 at 10:27:06AM +0800, Wenliang Wang wrote:
> For multi-queue and large ring-size use case, the following error
> occurred when free_unused_bufs:
> rcu: INFO: rcu_sched self-detected stall on CPU.
> 
> Fixes: 986a4f4d452d ("virtio_net: multiqueue support")
> Signed-off-by: Wenliang Wang <wangwenliang.1995@bytedance.com>

Acked-by: Michael S. Tsirkin <mst@redhat.com>

Probably a good idea for stable, too.

> ---
> v2:
> -add need_resched check.
> -apply same logic to sq.
> v3:
> -use cond_resched instead.
> v4:
> -add fixes tag
> ---
>  drivers/net/virtio_net.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
> index 8d8038538fc4..a12ae26db0e2 100644
> --- a/drivers/net/virtio_net.c
> +++ b/drivers/net/virtio_net.c
> @@ -3560,12 +3560,14 @@ static void free_unused_bufs(struct virtnet_info *vi)
>  		struct virtqueue *vq = vi->sq[i].vq;
>  		while ((buf = virtqueue_detach_unused_buf(vq)) != NULL)
>  			virtnet_sq_free_unused_buf(vq, buf);
> +		cond_resched();
>  	}
>  
>  	for (i = 0; i < vi->max_queue_pairs; i++) {
>  		struct virtqueue *vq = vi->rq[i].vq;
>  		while ((buf = virtqueue_detach_unused_buf(vq)) != NULL)
>  			virtnet_rq_free_unused_buf(vq, buf);
> +		cond_resched();
>  	}
>  }
>  
> -- 
> 2.20.1

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
