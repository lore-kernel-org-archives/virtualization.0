Return-Path: <SRS0=D/KU=OT=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8A7D1C433EF
	for <virtualization@archiver.kernel.org>; Wed, 29 Sep 2021 08:32:28 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 22921613A6
	for <virtualization@archiver.kernel.org>; Wed, 29 Sep 2021 08:32:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 22921613A6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id C71F1415AD;
	Wed, 29 Sep 2021 08:32:27 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 3ZJcAAZc0SAc; Wed, 29 Sep 2021 08:32:27 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 5E681414C0;
	Wed, 29 Sep 2021 08:32:26 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 3F019C000F;
	Wed, 29 Sep 2021 08:32:26 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 16D54C000D
 for <virtualization@lists.linux-foundation.org>;
 Wed, 29 Sep 2021 08:32:25 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 03278414C0
 for <virtualization@lists.linux-foundation.org>;
 Wed, 29 Sep 2021 08:32:25 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id n3McCeFWZZxV
 for <virtualization@lists.linux-foundation.org>;
 Wed, 29 Sep 2021 08:32:24 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [216.205.24.124])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 07C4F41486
 for <virtualization@lists.linux-foundation.org>;
 Wed, 29 Sep 2021 08:32:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1632904342;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=33L2kvYESyBjFzI5T12hFb+rWTsyBJjmF6Rb3+aaSJw=;
 b=DPhtQRATFXW5DUFG4STk4GLNZOfKTq2utGGfhyMf423oCtWqRNIPl0k9OwXB917mrfZEPg
 tQVRbCitHUN0IGWUpfghaY0cePxKbE5b3l4TfLfnb4LBnVKJPXKNj6Z6vMF5+2gn1Y3J1T
 kxSMUQ6vnDNnJ74psLR1lPqCkZIAoHg=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-247-ezEnHu_VNGeALqSWPCOZ9w-1; Wed, 29 Sep 2021 04:32:20 -0400
X-MC-Unique: ezEnHu_VNGeALqSWPCOZ9w-1
Received: by mail-wm1-f69.google.com with SMTP id
 p25-20020a1c5459000000b0030cac3d9db1so864547wmi.6
 for <virtualization@lists.linux-foundation.org>;
 Wed, 29 Sep 2021 01:32:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=33L2kvYESyBjFzI5T12hFb+rWTsyBJjmF6Rb3+aaSJw=;
 b=5RJc+MU/HdNbi1TOMEQFGdaG4ZSM3ZjFvP73YGlxbxEiq/NoCSy4DnMMJ0wYu3xdGK
 lOCk01V0UHYAKWgYJKqJqt0SFNt2I2Kn1YSdRtviz12oLog5pPGz7Vy1VxUgkKQmnjXI
 voeICs/YrDqp8GHuetwYexjj++5PQQcMsw33Z0ZPHTDO/FJW0b/wqfT6zgaV8GItV8rU
 F5ssLD4gHkJfrYTl4VZcJujW+p+BXbaFH2vvToREwJeiHzg+vx1x46vHdqAul3Y22CIe
 YpIhCRIPespEkveIesPX0sjqNIbOSCeG+GNKMkgZ+5NauyHBWO5G5bDYBMhb27lytkju
 V+Gg==
X-Gm-Message-State: AOAM531CpgPqiwaKktxy9jhp6nbAiqlQEb1+1w4HOraYjQvathQkIOUH
 ymIz4TxU9p9f9swoSATqPG7Q9/wVvRCTYyTEyEysj9USwFXaFFSKFqhWk+nS+417lnZfUQouyyQ
 sp/Piu48JulxaH/rlCj+jjBbAPqsVLsvMX7jRoBi5gQ==
X-Received: by 2002:a1c:4407:: with SMTP id r7mr9093100wma.69.1632904339559;
 Wed, 29 Sep 2021 01:32:19 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxiFH8QvVbSSfltUTVNYrFe4cgpOa802Pjd2dc9VAv6jOjC98+5gHvsdXJBd6/yPoXBjvvJDg==
X-Received: by 2002:a1c:4407:: with SMTP id r7mr9093089wma.69.1632904339405;
 Wed, 29 Sep 2021 01:32:19 -0700 (PDT)
Received: from redhat.com ([2.55.12.29])
 by smtp.gmail.com with ESMTPSA id l21sm851391wme.39.2021.09.29.01.32.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 29 Sep 2021 01:32:18 -0700 (PDT)
Date: Wed, 29 Sep 2021 04:32:15 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Cindy Lu <lulu@redhat.com>
Subject: Re: [PATCH] vhost-vdpa:fix the worng input in config_cb
Message-ID: <20210929043142-mutt-send-email-mst@kernel.org>
References: <20210929075437.12985-1-lulu@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20210929075437.12985-1-lulu@redhat.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=mst@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
 virtualization@lists.linux-foundation.org
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

On Wed, Sep 29, 2021 at 03:54:37PM +0800, Cindy Lu wrote:
> Fix the worng input in for config_cb,
> in function vhost_vdpa_config_cb, the input
> cb.private was used as struct vhost_vdpa,
> So the inuput was worng here, fix this issue
> 
> Signed-off-by: Cindy Lu <lulu@redhat.com>

Maybe add

Fixes: 776f395004d8 ("vhost_vdpa: Support config interrupt in vdpa")

and fix typos in the commit log.

> ---
>  drivers/vhost/vdpa.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/vhost/vdpa.c b/drivers/vhost/vdpa.c
> index 942666425a45..e532cbe3d2f7 100644
> --- a/drivers/vhost/vdpa.c
> +++ b/drivers/vhost/vdpa.c
> @@ -322,7 +322,7 @@ static long vhost_vdpa_set_config_call(struct vhost_vdpa *v, u32 __user *argp)
>  	struct eventfd_ctx *ctx;
>  
>  	cb.callback = vhost_vdpa_config_cb;
> -	cb.private = v->vdpa;
> +	cb.private = v;
>  	if (copy_from_user(&fd, argp, sizeof(fd)))
>  		return  -EFAULT;
>  
> -- 
> 2.21.3

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
