Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E36D2C433F5
	for <virtualization@archiver.kernel.org>; Thu, 26 May 2022 23:25:13 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 7538C61570;
	Thu, 26 May 2022 23:25:13 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id IQFwjWu1DDel; Thu, 26 May 2022 23:25:12 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 192386156C;
	Thu, 26 May 2022 23:25:12 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id DAB72C0032;
	Thu, 26 May 2022 23:25:11 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id DE8DDC002D
 for <virtualization@lists.linux-foundation.org>;
 Thu, 26 May 2022 23:25:10 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id BF8E7847F2
 for <virtualization@lists.linux-foundation.org>;
 Thu, 26 May 2022 23:25:10 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp1.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id DdC8BXR0riDt
 for <virtualization@lists.linux-foundation.org>;
 Thu, 26 May 2022 23:25:10 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp1.osuosl.org (Postfix) with ESMTPS id E8A73847EE
 for <virtualization@lists.linux-foundation.org>;
 Thu, 26 May 2022 23:25:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1653607508;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=9X8JUoVO3ItYFMP0lxBdt9F+7PIN+J/Kt3iw5v3WE2U=;
 b=FV79u2Ot+BRUau6iUpMOPgquetsClJTMU4+q74Aws8dfCaSILTIiFD65zR9N1iC1dQmf51
 PdT7LAVUE4419tr+cC7fbIQwesxLUzBMiz+Z+geqMuzh8eNvW83m1pJiu0FvIuK90BG+Vj
 Xdo6k0n4MESzy/saNWdn1xebSSixPF0=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-325-RRwUDSLEOh2PVBmAUWL3lQ-1; Thu, 26 May 2022 19:25:07 -0400
X-MC-Unique: RRwUDSLEOh2PVBmAUWL3lQ-1
Received: by mail-wm1-f70.google.com with SMTP id
 bg40-20020a05600c3ca800b00394779649b1so3782639wmb.3
 for <virtualization@lists.linux-foundation.org>;
 Thu, 26 May 2022 16:25:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=9X8JUoVO3ItYFMP0lxBdt9F+7PIN+J/Kt3iw5v3WE2U=;
 b=4+D5yK/aDyZVsntqUszUYtEwMPwvsWwOcT2taUggKnYp6uzA9UVT6bc3pvuDUVQNY/
 Vd7iXOlgp7UGAPJKljVHRukkz7MZwzNY2WPKeAxZk8U2Zl/VJG+iKNHemqctgCfltdqu
 gougmhTOU4eQyifBmt/AukzpuRXbuIVo5k5vwLoXqGd8fosEr/FBh3nV02dyqFGwKmMZ
 lEWUGpJDr4yxhi3j1GdjpJEJKbkT8d/s562DWK8aEsHau0i+yY8JFR6smyttJ2RD1259
 9kwmG1iJvqESM7a9Tfsdf9pIuEp0raI9DvGaXPr9Yi3uDNfhGIwctEhHvoqO5PAFqDbb
 Pt9A==
X-Gm-Message-State: AOAM5309fwJJQKOnrg7s6eJCjjvOCyxmBPmRHDTVgEYhA3zRsemfGsQl
 EY/2ikJKuawvC2oGBdqzjKovsErr54Bj9z9rNQO/uP7Q9ncHJncDXh6mV3Lwzu9dTmzwLob3WKd
 EaCdrFT+qXsFSzIY95uKNSqtco7bOJr/khfUKy29F+g==
X-Received: by 2002:a5d:6d8c:0:b0:20e:72ce:c9d9 with SMTP id
 l12-20020a5d6d8c000000b0020e72cec9d9mr29002634wrs.598.1653607505620; 
 Thu, 26 May 2022 16:25:05 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJz6jLtwn+a7vihIpXB+X9zxsi4oW40VzxI37oPu2ky+U6YhL+3ESFEOquhhiPVK7ZSiEhjghw==
X-Received: by 2002:a5d:6d8c:0:b0:20e:72ce:c9d9 with SMTP id
 l12-20020a5d6d8c000000b0020e72cec9d9mr29002625wrs.598.1653607505366; 
 Thu, 26 May 2022 16:25:05 -0700 (PDT)
Received: from redhat.com ([2.55.29.191]) by smtp.gmail.com with ESMTPSA id
 8-20020a1c0208000000b003942a244ed1sm466085wmc.22.2022.05.26.16.25.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 26 May 2022 16:25:04 -0700 (PDT)
Date: Thu, 26 May 2022 19:25:00 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Subject: Re: [PATCH] vhost-vdpa: Fix some error handling path in
 vhost_vdpa_process_iotlb_msg()
Message-ID: <20220526192401-mutt-send-email-mst@kernel.org>
References: <89ef0ae4c26ac3cfa440c71e97e392dcb328ac1b.1653227924.git.christophe.jaillet@wanadoo.fr>
MIME-Version: 1.0
In-Reply-To: <89ef0ae4c26ac3cfa440c71e97e392dcb328ac1b.1653227924.git.christophe.jaillet@wanadoo.fr>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=mst@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: kvm@vger.kernel.org, netdev@vger.kernel.org,
 kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org,
 virtualization@lists.linux-foundation.org,
 Gautam Dawar <gautam.dawar@xilinx.com>, dan.carpenter@oracle.com
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

On Sun, May 22, 2022 at 03:59:01PM +0200, Christophe JAILLET wrote:
> In the error paths introduced by the commit in the Fixes tag, a mutex may
> be left locked.
> Add the correct goto instead of a direct return.
> 
> Fixes: a1468175bb17 ("vhost-vdpa: support ASID based IOTLB API")
> Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>

Acked-by: Michael S. Tsirkin <mst@redhat.com>

> ---
> WARNING: This patch only fixes the goto vs return mix-up in this function.
> However, the 2nd hunk looks really spurious to me. I think that the:
> -		return -EINVAL;
> +		r = -EINVAL;
> +		goto unlock;
> should be done only in the 'if (!iotlb)' block.
> 
> As I don't know this code, I just leave it as-is but draw your attention
> in case this is another bug lurking.
> ---
>  drivers/vhost/vdpa.c | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/vhost/vdpa.c b/drivers/vhost/vdpa.c
> index 1f1d1c425573..3e86080041fc 100644
> --- a/drivers/vhost/vdpa.c
> +++ b/drivers/vhost/vdpa.c
> @@ -1000,7 +1000,8 @@ static int vhost_vdpa_process_iotlb_msg(struct vhost_dev *dev, u32 asid,
>  		if (!as) {
>  			dev_err(&v->dev, "can't find and alloc asid %d\n",
>  				asid);
> -			return -EINVAL;
> +			r = -EINVAL;
> +			goto unlock;
>  		}
>  		iotlb = &as->iotlb;
>  	} else
> @@ -1013,7 +1014,8 @@ static int vhost_vdpa_process_iotlb_msg(struct vhost_dev *dev, u32 asid,
>  		}
>  		if (!iotlb)
>  			dev_err(&v->dev, "no iotlb for asid %d\n", asid);
> -		return -EINVAL;
> +		r = -EINVAL;
> +		goto unlock;
>  	}
>  
>  	switch (msg->type) {
> -- 
> 2.34.1

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
