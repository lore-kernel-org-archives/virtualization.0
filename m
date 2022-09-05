Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5480DECAAA1
	for <virtualization@archiver.kernel.org>; Mon,  5 Sep 2022 07:15:39 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 9F14040358;
	Mon,  5 Sep 2022 07:15:38 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 9F14040358
Authentication-Results: smtp4.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=MbXoihDZ
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 6aXb9Y3y6dgT; Mon,  5 Sep 2022 07:15:37 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp4.osuosl.org (Postfix) with ESMTPS id A29024054A;
	Mon,  5 Sep 2022 07:15:36 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org A29024054A
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 42908C0032;
	Mon,  5 Sep 2022 07:15:36 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 47A94C002D
 for <virtualization@lists.linux-foundation.org>;
 Mon,  5 Sep 2022 07:15:34 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 221484019B
 for <virtualization@lists.linux-foundation.org>;
 Mon,  5 Sep 2022 07:15:34 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 221484019B
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=MbXoihDZ
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id vkujukncETuD
 for <virtualization@lists.linux-foundation.org>;
 Mon,  5 Sep 2022 07:15:32 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org D034B40146
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp2.osuosl.org (Postfix) with ESMTPS id D034B40146
 for <virtualization@lists.linux-foundation.org>;
 Mon,  5 Sep 2022 07:15:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1662362130;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=hzFuvUdPT4weoAmQZYG6aUVzxxQfH1SK+qmfNddDCPs=;
 b=MbXoihDZEWlXBDxvmYAT6jeHPLKGH6S6hlP+PrW6j9YWUdKjWPWxIDO1kd3MVq51F3O3ao
 N/9xjW9grmq+4t0RP5pymeKqt2f6XD9PpEbnB3cBuRgDB/zKdYBNhW7l8wu/JBhdSosUV7
 Simn13Ercldk4glWGjrkJW0liiGejMY=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-146-Bh2L5Ky-OiGX_FEY5CxkxA-1; Mon, 05 Sep 2022 03:15:29 -0400
X-MC-Unique: Bh2L5Ky-OiGX_FEY5CxkxA-1
Received: by mail-wm1-f69.google.com with SMTP id
 j3-20020a05600c1c0300b003a5e72421c2so5918886wms.1
 for <virtualization@lists.linux-foundation.org>;
 Mon, 05 Sep 2022 00:15:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date;
 bh=hzFuvUdPT4weoAmQZYG6aUVzxxQfH1SK+qmfNddDCPs=;
 b=xgA/OzvFVUfgaAZiS6JGEAxc7eWS8k2F6KXiQ23U7mG4Y8LQV4ZdicIxy1v0TcmoYy
 6BgB9344GgcrKcHLHQW/QJgL7fAdfQLj58NDjUymDA9VKpll/7BZGsJ02SgVXJYQlilC
 bWdJOjItreFSmsdR20fPY2SRauOtdwM4XgT83t8ayxbyu1UGOD/rdDC+tAFL0h9K25Ub
 aYwiGX6z1PGOBgCLOs6C93/qHanaq99f/UL9yRXXi0S4ow0j3cNjXR2QNF1g+MoELvir
 7/bT5FpeIw5gWxX9Kb59idZwQvQvW74gkqC3ZNmFXx1sh7kneaSeao3BuRl8DiNEdMgX
 ZCBg==
X-Gm-Message-State: ACgBeo0QO7+mKGR7Y9fpCs/Bff9mzOr+lmR0gImvOX/Hbn9R5Sl+DlLQ
 JesYSTuQELfGobYA8gxS2H1iXlBDV9hEH1xkJ18HJ2V23UqFZW6HEyHzQq1czDhMZcRItQ6WhYN
 AqJjrG56LUqojzxrzlL29oQer1VsxCQkWMFRAVdQbDQ==
X-Received: by 2002:a7b:c844:0:b0:3a9:70d2:bf23 with SMTP id
 c4-20020a7bc844000000b003a970d2bf23mr9738274wml.165.1662362128130; 
 Mon, 05 Sep 2022 00:15:28 -0700 (PDT)
X-Google-Smtp-Source: AA6agR7EtktGfU9VLNtKjgqj6Ye1h1XLW2E8fwnYaZd3O3gu/FYxDv2bAYX99j93n4GzCIeqkxwzdw==
X-Received: by 2002:a7b:c844:0:b0:3a9:70d2:bf23 with SMTP id
 c4-20020a7bc844000000b003a970d2bf23mr9738258wml.165.1662362127953; 
 Mon, 05 Sep 2022 00:15:27 -0700 (PDT)
Received: from redhat.com ([2.52.135.118]) by smtp.gmail.com with ESMTPSA id
 az19-20020a05600c601300b003a342933727sm17118233wmb.3.2022.09.05.00.15.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 05 Sep 2022 00:15:27 -0700 (PDT)
Date: Mon, 5 Sep 2022 03:15:24 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Jason Wang <jasowang@redhat.com>
Subject: Re: [PATCH net] virtio-net: add cond_resched() to the command
 waiting loop
Message-ID: <20220905031405-mutt-send-email-mst@kernel.org>
References: <20220905045341.66191-1-jasowang@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20220905045341.66191-1-jasowang@redhat.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 virtualization@lists.linux-foundation.org, edumazet@google.com,
 kuba@kernel.org, gautam.dawar@xilinx.com, pabeni@redhat.com,
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

On Mon, Sep 05, 2022 at 12:53:41PM +0800, Jason Wang wrote:
> Adding cond_resched() to the command waiting loop for a better
> co-operation with the scheduler. This allows to give CPU a breath to
> run other task(workqueue) instead of busy looping when preemption is
> not allowed.
> 
> What's more important. This is a must for some vDPA parent to work
> since control virtqueue is emulated via a workqueue for those parents.
> 
> Fixes: bda324fd037a ("vdpasim: control virtqueue support")

That's a weird commit to fix. so it fixes the simulator?

> Signed-off-by: Jason Wang <jasowang@redhat.com>
> ---
>  drivers/net/virtio_net.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
> index ece00b84e3a7..169368365d6a 100644
> --- a/drivers/net/virtio_net.c
> +++ b/drivers/net/virtio_net.c
> @@ -2000,8 +2000,10 @@ static bool virtnet_send_command(struct virtnet_info *vi, u8 class, u8 cmd,
>  	 * into the hypervisor, so the request should be handled immediately.
>  	 */
>  	while (!virtqueue_get_buf(vi->cvq, &tmp) &&
> -	       !virtqueue_is_broken(vi->cvq))
> +	       !virtqueue_is_broken(vi->cvq)) {
> +		cond_resched();
>  		cpu_relax();
> +	}

with cond_resched do we still need cpu_relax?

>  	return vi->ctrl->status == VIRTIO_NET_OK;
>  }
> -- 
> 2.25.1

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
