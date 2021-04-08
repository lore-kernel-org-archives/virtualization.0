Return-Path: <SRS0=B6Di=JF=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A6C7C433B4
	for <virtualization@archiver.kernel.org>; Thu,  8 Apr 2021 16:14:10 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2847D610F8
	for <virtualization@archiver.kernel.org>; Thu,  8 Apr 2021 16:14:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2847D610F8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id DF392607A0;
	Thu,  8 Apr 2021 16:14:09 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id QWXEO1l1-fj6; Thu,  8 Apr 2021 16:14:09 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTP id 7CE1B605F4;
	Thu,  8 Apr 2021 16:14:08 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 5D1E7C000C;
	Thu,  8 Apr 2021 16:14:08 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 2E29EC000A
 for <virtualization@lists.linux-foundation.org>;
 Thu,  8 Apr 2021 16:14:07 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 28F95605FC
 for <virtualization@lists.linux-foundation.org>;
 Thu,  8 Apr 2021 16:14:07 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id ChU6vUCHaaNR
 for <virtualization@lists.linux-foundation.org>;
 Thu,  8 Apr 2021 16:14:06 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 6A5FC605F4
 for <virtualization@lists.linux-foundation.org>;
 Thu,  8 Apr 2021 16:14:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1617898445;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=tiGczM3NjQg2RlbRAZL20iIbNh/VV314Y+QwmuKeXgE=;
 b=Xr8SyFr/pNFLpmbN/6DitBUdCk+s6XK5gc0uvSl2/3LCfcfFAiZee+pGaCv1YOJdfn5Jmb
 iKujFgX79ryv9b8RKJbZAQNMMoTdUCUaHq9Tn5Y3hM7r16FwcvhToWGkUphVJxA4Y7u+6A
 RWTSJ0ke3mQRKumk8WxyhRMjWlPyGfQ=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-56-S8bELK5cMFyyQxksgoyE_w-1; Thu, 08 Apr 2021 12:14:03 -0400
X-MC-Unique: S8bELK5cMFyyQxksgoyE_w-1
Received: by mail-wr1-f70.google.com with SMTP id l3so1182077wrp.13
 for <virtualization@lists.linux-foundation.org>;
 Thu, 08 Apr 2021 09:14:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=tiGczM3NjQg2RlbRAZL20iIbNh/VV314Y+QwmuKeXgE=;
 b=TJ53byrY3NITl3m82Df/9mHsPUTNqgm8V6xkpGhoas1LI6K1jGuM5hE8xQid7Z1883
 MLrEMlu4t2HWTVy5+2iDNE103+7ztYLhyOQ346gdSriXJ+SJPNCwUKabfQcjpihhJxIz
 9aQbvstL36lzIkERdluxO/sYDjppn+K4i5r5cd1qXYYvfZ7ZZk9OcHqsCYzja8t0MPkN
 6JXVGT6o1Dlt4H186luP0fK8mwnc7TcYkE5p/v7dj+C9sMH0IakhGEncYstxu2utfF7D
 H7ZU4nwishLdbvrc6TCRHGrG7JfEfw4w9fBJbI4GN8LzCSwLzb2wBvPt70NneSIfuWCQ
 HpHw==
X-Gm-Message-State: AOAM530Ve5QBZdUr4o6ICDuulGn5vUpA2LQgXcg6zYvWZXltcgo8o+Cq
 Z5mahprjSpvifGzQwqM84rK2dHhIdoQbZ5lgjFgVt/1yk+u4fIPAsQmtJP9stY6zj8YMlq/m8xz
 xpVCbd0PdOdvg4nW7VDN3e4nCTCVG9YxuglH4yPAnbw==
X-Received: by 2002:adf:d1e8:: with SMTP id g8mr12281408wrd.175.1617898442414; 
 Thu, 08 Apr 2021 09:14:02 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxNMtc/xkLnEYAlU+YHnDFPitJ2afyI9htyNG1uxKsbnTqmPm5o5/+5i6BRMJO64VVdGyLNjA==
X-Received: by 2002:adf:d1e8:: with SMTP id g8mr12281391wrd.175.1617898442278; 
 Thu, 08 Apr 2021 09:14:02 -0700 (PDT)
Received: from redhat.com ([2a10:800e:f0d3:0:b69b:9fb8:3947:5636])
 by smtp.gmail.com with ESMTPSA id k127sm15264099wmf.19.2021.04.08.09.14.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 08 Apr 2021 09:14:01 -0700 (PDT)
Date: Thu, 8 Apr 2021 12:13:58 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Eli Cohen <elic@nvidia.com>
Subject: Re: update of MST's linux-next
Message-ID: <20210408121306-mutt-send-email-mst@kernel.org>
References: <20210408062941.GA2383@mtl-vdi-166.wap.labs.mlnx>
MIME-Version: 1.0
In-Reply-To: <20210408062941.GA2383@mtl-vdi-166.wap.labs.mlnx>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=mst@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: virtualization@lists.linux-foundation.org
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

On Thu, Apr 08, 2021 at 09:29:41AM +0300, Eli Cohen wrote:
> Hi Michael,
> 
> can you please update your linux-next branch with bits from other
> subsystems? There are fixes that we need to send and rely on code from
> those trees.
> 
> Moreover, there have been some patches that were reviewed but cannot be
> found in your branch.  Can you please pull those too into your branch?


Working on that. Anything you have in mind
pls feel free to remind me to make sure I don't miss it.

> Thanks,
> Eli

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
