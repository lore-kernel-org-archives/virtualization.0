Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 02053C433F5
	for <virtualization@archiver.kernel.org>; Tue, 11 Jan 2022 16:01:14 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id A391882F19;
	Tue, 11 Jan 2022 16:01:14 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id f2Ubem-ROauH; Tue, 11 Jan 2022 16:01:13 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 59BA882F11;
	Tue, 11 Jan 2022 16:01:13 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 2FC82C0030;
	Tue, 11 Jan 2022 16:01:13 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 394A3C001E
 for <virtualization@lists.linux-foundation.org>;
 Tue, 11 Jan 2022 16:01:11 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 2ED8140954
 for <virtualization@lists.linux-foundation.org>;
 Tue, 11 Jan 2022 16:01:11 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp4.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id FEB7DXDxWjvx
 for <virtualization@lists.linux-foundation.org>;
 Tue, 11 Jan 2022 16:01:10 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 852E74090B
 for <virtualization@lists.linux-foundation.org>;
 Tue, 11 Jan 2022 16:01:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1641916869;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=w+JebMSm+NWQNseFquuMYxQ9f/TuWpPmuI1F+BM5qUI=;
 b=g9VnRgYwseZjNuA0ZcvR2Qn7bLDKoeNFhM4mCKRDsSp4nvCK0xdJWT1I4zbHPLJeyy0Ujr
 v1+4lldkDe19DotqWl7ioXhk1MFI5i9+EOIdEB+QFJXYtHH3BfoGJfofi9/Z6rTa3aoHN3
 M2Vrf1txDSeajsYfwhmzIV1Sq6az0d4=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-663-Rvg6drFuM4yZXgoDmm1RQw-1; Tue, 11 Jan 2022 11:01:08 -0500
X-MC-Unique: Rvg6drFuM4yZXgoDmm1RQw-1
Received: by mail-wm1-f70.google.com with SMTP id
 m15-20020a7bce0f000000b003473d477618so1761195wmc.8
 for <virtualization@lists.linux-foundation.org>;
 Tue, 11 Jan 2022 08:01:07 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=w+JebMSm+NWQNseFquuMYxQ9f/TuWpPmuI1F+BM5qUI=;
 b=qq6+077RhXpX7fmuwWXVbCjBSleNW4rR+JBmUslB/ril7g297RhMN5cEeZ1EQLhXon
 Q015BGz2J11rbGQxNzvTxa+5JfiKT8tBloD4e8MWZLIL9RPgOUZ5NUFxQbDBurj4x5IH
 8kitje1E6vWFJ5XDOg387O5RevLY6SZP/ChVOJqHjdZwCDm4r24OrOHiOTA23ahgJgbt
 VAX1fT15Iez5yCIGZ6yzBQcqqOwTt+kaGWup/HsnmfGdTP3hkCFJCr6iHqMft9qN8O5T
 EMOuZjOT5+H2MByYjCiD1hQQEWazlsDarqTEM95YY/NWBUaDyDsGt7ZUnlsWptaw/Jhu
 Wwzg==
X-Gm-Message-State: AOAM531/ai2MgU9b3ApRhs1KB6m8aKstUIC4jvpyjG0xYhZlhiiww6ZC
 1REkXuq+a6v58PFrWH7V7JWMSlNl8pTdcBQilivcFqKtMOju2i2GUOG+EyhWFAeU8Xb3/aO1qtn
 uUO0x7E8ZwhBaiQWsW44fCjZJwlie+7gD6rJTCsQwwA==
X-Received: by 2002:a05:600c:2f90:: with SMTP id
 t16mr3029537wmn.69.1641916866681; 
 Tue, 11 Jan 2022 08:01:06 -0800 (PST)
X-Google-Smtp-Source: ABdhPJxOZfF+W9T8/BmfNBDTy2cy0+4vTRPgXObR/itTw+TdhafPCCvRXucvP8p8Ve0lCsQOG8t1rA==
X-Received: by 2002:a05:600c:2f90:: with SMTP id
 t16mr3029523wmn.69.1641916866474; 
 Tue, 11 Jan 2022 08:01:06 -0800 (PST)
Received: from redhat.com ([2.55.5.100])
 by smtp.gmail.com with ESMTPSA id m15sm2339305wmq.6.2022.01.11.08.01.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 11 Jan 2022 08:01:05 -0800 (PST)
Date: Tue, 11 Jan 2022 11:01:01 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Eli Cohen <elic@nvidia.com>
Subject: Re: [PATCH 1/4] vdpa: Protect vdpa reset with cf_mutex
Message-ID: <20220111105833-mutt-send-email-mst@kernel.org>
References: <20220111072217.101836-1-elic@nvidia.com>
MIME-Version: 1.0
In-Reply-To: <20220111072217.101836-1-elic@nvidia.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=mst@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: lvivier@redhat.com, virtualization@lists.linux-foundation.org,
 eperezma@redhat.com, si-wei.liu@oracle.com
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

On Tue, Jan 11, 2022 at 09:22:17AM +0200, Eli Cohen wrote:
> Call reset using the wrapper function vdpa_reset() to make sure the
> operation is serialized with cf_mutex.
> 
> Signed-off-by: Eli Cohen <elic@nvidia.com>

The motivation is vague here, this does not really explain.
Which operations are we trying to serialize?
Multiple reset requests from userspace?
Is anything broken right now without this patch?

> ---
>  drivers/vhost/vdpa.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/drivers/vhost/vdpa.c b/drivers/vhost/vdpa.c
> index 6e7edaf2472b..fe0bbea4dab6 100644
> --- a/drivers/vhost/vdpa.c
> +++ b/drivers/vhost/vdpa.c
> @@ -155,7 +155,6 @@ static long vhost_vdpa_get_status(struct vhost_vdpa *v, u8 __user *statusp)
>  static long vhost_vdpa_set_status(struct vhost_vdpa *v, u8 __user *statusp)
>  {
>  	struct vdpa_device *vdpa = v->vdpa;
> -	const struct vdpa_config_ops *ops = vdpa->config;
>  	u8 status, status_old;
>  	int ret, nvqs = v->nvqs;
>  	u16 i;
> @@ -177,7 +176,7 @@ static long vhost_vdpa_set_status(struct vhost_vdpa *v, u8 __user *statusp)
>  			vhost_vdpa_unsetup_vq_irq(v, i);
>  
>  	if (status == 0) {
> -		ret = ops->reset(vdpa);
> +		ret = vdpa_reset(vdpa);
>  		if (ret)
>  			return ret;
>  	} else
> -- 
> 2.34.1

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
