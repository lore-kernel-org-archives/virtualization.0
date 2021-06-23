Return-Path: <SRS0=2EET=LR=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 70282C48BC2
	for <virtualization@archiver.kernel.org>; Wed, 23 Jun 2021 20:10:04 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1954B608FE
	for <virtualization@archiver.kernel.org>; Wed, 23 Jun 2021 20:10:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1954B608FE
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id D3EF840295;
	Wed, 23 Jun 2021 20:10:03 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id ScWD7tTlWLWy; Wed, 23 Jun 2021 20:10:02 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTPS id B261240280;
	Wed, 23 Jun 2021 20:10:01 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 6781DC001A;
	Wed, 23 Jun 2021 20:10:01 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 5A791C000E
 for <virtualization@lists.linux-foundation.org>;
 Wed, 23 Jun 2021 20:10:00 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 48AA7400FC
 for <virtualization@lists.linux-foundation.org>;
 Wed, 23 Jun 2021 20:10:00 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp2.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id Tb8co3OALeAS
 for <virtualization@lists.linux-foundation.org>;
 Wed, 23 Jun 2021 20:09:59 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 8F632400C0
 for <virtualization@lists.linux-foundation.org>;
 Wed, 23 Jun 2021 20:09:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1624478998;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=SNHwVtAYqqtfz9mNkeT55CF9XxIVuvyFxJlzIeVcLAk=;
 b=T7kl5mwIocf6iUR8dEivC49xk7FE0taqlw2K7PSd9l5wHbAfc7P2y1U8rRmD1KmVaAixXO
 0Q3kckPJ9rPKDRhzlmq96XTCgBQRE44n3oqrrBhQAJZbQaoaZouXXLWFTGEbXTUBvD8xB3
 DUnlJ81xfjLKyH36UZ5GXDFlezZF4H0=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-172-9T3O4M8cM66dAOAc_tqm6Q-1; Wed, 23 Jun 2021 16:09:57 -0400
X-MC-Unique: 9T3O4M8cM66dAOAc_tqm6Q-1
Received: by mail-wm1-f70.google.com with SMTP id
 s80-20020a1ca9530000b02901cff732fde5so942104wme.6
 for <virtualization@lists.linux-foundation.org>;
 Wed, 23 Jun 2021 13:09:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=SNHwVtAYqqtfz9mNkeT55CF9XxIVuvyFxJlzIeVcLAk=;
 b=tXOJEQIQT0MQOhRO2hLORvvWf/gK63Vf7n4RCuvSe6hVRpsWyZz7TaGx4wS7QUjT4h
 wPn2sZ8o32wMyqRKzhwyQbQAc6v3WsR3x8NM/KIfrv2YtUH8HMcFAsyfN/VRlmDI0SHg
 uJdRiVggXgOa19ksJVL6V5XYW/6FxyquqvN2I3yZfrr5IlVDfd4N3QL60Uly140UDGG6
 gxxukOZWmnvsgGk0Ee2n/2vnyovqUxQ86snqmFDFhUy/Ok0O6E32Ci0TVGCeT/yHsEx4
 iwE4DQ+aqd9hR5Vy9rWNQgP3vLAB/7lmxfEPb+cfdCc4/E4depP4qccQ9gr8XT7ILMvH
 BKhw==
X-Gm-Message-State: AOAM531tM2Kp3VMpmI9T3wG+4+ZXDM08Nt9PxXuBbeQrvHajLQaWB0Ye
 gfclgHahRHb7jouTJr+COKPnV3TdcdIps7oADgz2oYHTPwbU2pobzIAqjZRxlJ6ySIsap4OqaDS
 DeKoqWtsrfvrJyeRYK52exdMiLha4+5WImEeqNYFTZw==
X-Received: by 2002:a1c:7212:: with SMTP id n18mr1676693wmc.58.1624478996040; 
 Wed, 23 Jun 2021 13:09:56 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJySpClCIQvpk/WXfIxuefSHcb638VT2EVIOvY1Um/TAJISNA6URG63qxqeWkIJOdkwi3J0frg==
X-Received: by 2002:a1c:7212:: with SMTP id n18mr1676677wmc.58.1624478995902; 
 Wed, 23 Jun 2021 13:09:55 -0700 (PDT)
Received: from redhat.com ([77.124.79.210])
 by smtp.gmail.com with ESMTPSA id p20sm836135wma.19.2021.06.23.13.09.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 23 Jun 2021 13:09:55 -0700 (PDT)
Date: Wed, 23 Jun 2021 16:09:52 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Neeraj Upadhyay <neeraju@codeaurora.org>
Subject: Re: [PATCH] vringh: Use wiov->used to check for read/write desc order
Message-ID: <20210623160923-mutt-send-email-mst@kernel.org>
References: <1624361873-6097-1-git-send-email-neeraju@codeaurora.org>
MIME-Version: 1.0
In-Reply-To: <1624361873-6097-1-git-send-email-neeraju@codeaurora.org>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=mst@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
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

On Tue, Jun 22, 2021 at 05:07:53PM +0530, Neeraj Upadhyay wrote:
> As iov->used is incremented when descriptors are processed
> in __vringh_iov(), use it to check for incorrect read
> and write descriptor order.

Could the commit log be clearer? why is wiov->i incorrect here?

> Signed-off-by: Neeraj Upadhyay <neeraju@codeaurora.org>
> ---
>  drivers/vhost/vringh.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/vhost/vringh.c b/drivers/vhost/vringh.c
> index 4af8fa2..14e2043 100644
> --- a/drivers/vhost/vringh.c
> +++ b/drivers/vhost/vringh.c
> @@ -359,7 +359,7 @@ __vringh_iov(struct vringh *vrh, u16 i,
>  			iov = wiov;
>  		else {
>  			iov = riov;
> -			if (unlikely(wiov && wiov->i)) {
> +			if (unlikely(wiov && wiov->used)) {
>  				vringh_bad("Readable desc %p after writable",
>  					   &descs[i]);
>  				err = -EINVAL;
> -- 
> QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum, 
> hosted by The Linux Foundation

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
