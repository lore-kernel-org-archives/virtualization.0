Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 45D8AC54EE9
	for <virtualization@archiver.kernel.org>; Sun, 18 Sep 2022 06:56:56 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id BD3488443A;
	Sun, 18 Sep 2022 06:56:55 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org BD3488443A
Authentication-Results: smtp1.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=gVMvHDdR
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id xSlraSDqdGOX; Sun, 18 Sep 2022 06:56:55 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 3C6BB8443B;
	Sun, 18 Sep 2022 06:56:54 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 3C6BB8443B
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 0524DC0033;
	Sun, 18 Sep 2022 06:56:54 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 8166EC002D
 for <virtualization@lists.linux-foundation.org>;
 Sun, 18 Sep 2022 06:56:52 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 62F4A401D2
 for <virtualization@lists.linux-foundation.org>;
 Sun, 18 Sep 2022 06:56:52 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 62F4A401D2
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=gVMvHDdR
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id vbg17VgCQZv6
 for <virtualization@lists.linux-foundation.org>;
 Sun, 18 Sep 2022 06:56:51 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 6CF70400E2
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 6CF70400E2
 for <virtualization@lists.linux-foundation.org>;
 Sun, 18 Sep 2022 06:56:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1663484209;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=sG9TyI7RoPnjwpaWhat0D0T3kJaBGLVdSTh5KbAUUcc=;
 b=gVMvHDdRwceicYYF4WIdffpUzy3ffXzLyCmznZ9BveJ5wt3nrPF/hB9QZxB15lmh8fa4Za
 u0CQ5z2XSff9mt+8s5f7ISxTIKO3BrtiWs8ZZTLeo/KUNQLVYI5mv/yt4Z2c2YPSjJyCEB
 uAD2K3wicc5OyChB6mGBmDclRQd4H0M=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-76-DGS5SREgMrWLO5NLNNSM0g-1; Sun, 18 Sep 2022 02:56:48 -0400
X-MC-Unique: DGS5SREgMrWLO5NLNNSM0g-1
Received: by mail-wm1-f71.google.com with SMTP id
 i132-20020a1c3b8a000000b003b339a8556eso3903908wma.4
 for <virtualization@lists.linux-foundation.org>;
 Sat, 17 Sep 2022 23:56:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date;
 bh=sG9TyI7RoPnjwpaWhat0D0T3kJaBGLVdSTh5KbAUUcc=;
 b=rGuLgTOblGEekfKlWo0wU8F9HIoJRp0FdCWLWezb12AuLYzdY7S5Zi1c5um5N2UaIe
 eXylRVPd62sXHAWOLXeeJYbliktZfC/y5diHrL4Peve5jpdtqPDW3uQqEdq3kBg+v5Aw
 j12gJBNB5k0fBaYsoQXwvPEU3IZECFYjIJThAzAIqpDWDxJ4T7tL3QYjBkGIqHq2dE0D
 k3fcjRg/lSl9XabCOby1jZizs+NzD5wFWjuUelvBloX556+uzkgT7mYNEviAGeeHglYx
 L3lFDwShAQhvq9BaOqjbNMuLZ8zYyc21qQKR2NRgUsIdXs+z6Ymo0HV450EK+0P7+Xqm
 14rg==
X-Gm-Message-State: ACrzQf1Iy04s+woTgfsNISsQXgpPUhs2jLsFww4CYucd5xZXI7mKw4nZ
 gErTgfqvmDvlK23rgEYZVpNeiuImRBYwPHg049WQGorU0tyqDKrLr4teXRh9VQmiL03iRD2+A2+
 WAJ//xndDlnAZD8v/a4V7MQCQ1EQrZwQ4y2cyjUf+iw==
X-Received: by 2002:a05:600c:3d0e:b0:3b4:9bd1:10be with SMTP id
 bh14-20020a05600c3d0e00b003b49bd110bemr8322595wmb.101.1663484207095; 
 Sat, 17 Sep 2022 23:56:47 -0700 (PDT)
X-Google-Smtp-Source: AMsMyM5iIUW7rsfRxmxgbyvogqw0ojEaNVttP8YBNjx7GPrB3E7FfRzWRD1uIBXkiE/5kZG+Pd1Ykw==
X-Received: by 2002:a05:600c:3d0e:b0:3b4:9bd1:10be with SMTP id
 bh14-20020a05600c3d0e00b003b49bd110bemr8322576wmb.101.1663484206815; 
 Sat, 17 Sep 2022 23:56:46 -0700 (PDT)
Received: from redhat.com ([2.52.4.6]) by smtp.gmail.com with ESMTPSA id
 t12-20020a05600c128c00b003b4931eb435sm8312339wmd.26.2022.09.17.23.56.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 17 Sep 2022 23:56:46 -0700 (PDT)
Date: Sun, 18 Sep 2022 02:56:41 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: junbo4242@gmail.com
Subject: Re: [PATCH] Do not name control queue for virtio-net
Message-ID: <20220918025033-mutt-send-email-mst@kernel.org>
References: <20220917092857.3752357-1-junbo4242@gmail.com>
MIME-Version: 1.0
In-Reply-To: <20220917092857.3752357-1-junbo4242@gmail.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: Jesper Dangaard Brouer <hawk@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>, netdev@vger.kernel.org,
 John Fastabend <john.fastabend@gmail.com>, Alexei Starovoitov <ast@kernel.org>,
 virtualization@lists.linux-foundation.org, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, bpf@vger.kernel.org,
 Paolo Abeni <pabeni@redhat.com>, "David S. Miller" <davem@davemloft.net>,
 linux-kernel@vger.kernel.org
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

On Sat, Sep 17, 2022 at 09:28:57AM +0000, junbo4242@gmail.com wrote:
> From: Junbo <junbo4242@gmail.com>
> 
> In virtio drivers, the control queue always named <virtioX>-config.
> 
> Signed-off-by: Junbo <junbo4242@gmail.com>

I don't think that's right. config is the config interrupt.



> ---
>  drivers/net/virtio_net.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
> index 9cce7dec7366..0b3e74cfe201 100644
> --- a/drivers/net/virtio_net.c
> +++ b/drivers/net/virtio_net.c
> @@ -3469,7 +3469,8 @@ static int virtnet_find_vqs(struct virtnet_info *vi)
>  	/* Parameters for control virtqueue, if any */
>  	if (vi->has_cvq) {
>  		callbacks[total_vqs - 1] = NULL;
> -		names[total_vqs - 1] = "control";
> +		/* control virtqueue always named <virtioX>-config */
> +		names[total_vqs - 1] = "";
>  	}
>  
>  	/* Allocate/initialize parameters for send/receive virtqueues */
> -- 
> 2.31.1

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
