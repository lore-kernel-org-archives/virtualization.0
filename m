Return-Path: <SRS0=ROIW=NA=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7ADC6C4338F
	for <virtualization@archiver.kernel.org>; Mon,  9 Aug 2021 09:36:04 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0C3516108D
	for <virtualization@archiver.kernel.org>; Mon,  9 Aug 2021 09:36:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 0C3516108D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id B776A606F6;
	Mon,  9 Aug 2021 09:36:03 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id h21uzEw4bjtg; Mon,  9 Aug 2021 09:36:03 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 61C52606F9;
	Mon,  9 Aug 2021 09:36:02 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 3963DC001A;
	Mon,  9 Aug 2021 09:36:02 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id AF8A5C000E
 for <virtualization@lists.linux-foundation.org>;
 Mon,  9 Aug 2021 09:36:00 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id AC02B4025C
 for <virtualization@lists.linux-foundation.org>;
 Mon,  9 Aug 2021 09:36:00 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp4.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id VIGq9fwFpGHc
 for <virtualization@lists.linux-foundation.org>;
 Mon,  9 Aug 2021 09:36:00 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 22D0040253
 for <virtualization@lists.linux-foundation.org>;
 Mon,  9 Aug 2021 09:35:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1628501759;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=DCwWzd2fcIf6s+EToMX9jy7QnM7tcAYbyJXAg/EPU7U=;
 b=dtEjopucmhIDcL2BTWkpfxYOy4ygpgatPOvB4fcVku7h7KBYuaLmMcwSn+LGJlVVfrMxWP
 oB113TURGbaAL6ntlvEdZ5bW2cQWyMOiDgVkGZ/bND42q7RCQBaIbkfa04LcY9WQ3gsQwL
 ctpDfHCTZ5GnYVJaZCPF4yEQXERv28Q=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-472-7b7UsecaPeWs_zkY7Fhhlg-1; Mon, 09 Aug 2021 05:35:55 -0400
X-MC-Unique: 7b7UsecaPeWs_zkY7Fhhlg-1
Received: by mail-ed1-f69.google.com with SMTP id
 v11-20020a056402348bb02903be68e116adso716160edc.14
 for <virtualization@lists.linux-foundation.org>;
 Mon, 09 Aug 2021 02:35:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=DCwWzd2fcIf6s+EToMX9jy7QnM7tcAYbyJXAg/EPU7U=;
 b=KiYwJdAM4bV3PHZiw2dPTJS6IjURb4s2ubmewxr+glzSBtRQP9oV98ha+uxYkKDdsh
 Yk38YuPp10ZATKo6FAqBEPnJf61bYUEDjoeMZ1RP5zN3lOFqvGcyX0fg5U10d3tbxYqQ
 PpAu7K9AnBrkI4Ay3P93K4AtKZSdYgjIkuqgFCrlkPvuirCmxV3UihEdMHQ4OVrfQ8am
 u+2wCcTqt4u635YcqRFw16pDdpwXEWlje6/ElTiRwnlGFK5nY5e9lFj5sfNY5trj0Tw6
 jRSUUzvuDy3bNnJi81DkSKk3KTdTUNHTiuG1LAKPyeOiZFVW+V/Q33Ci5F27TJcLfWTx
 EG4w==
X-Gm-Message-State: AOAM533Jbqq9ZetDpTTVx8V3XZc6H8SScZKBG+f7vTBLrOJnevv28/aF
 BAZiGZFBPC98sPWXwRNpEm/Ng7k6DWD8AULMo1yac1Iu2vJqrlyU6JDd0YuihBZGnxHonsapmu8
 wh5uvUtKQ8fZlEc7Q9JnPmsGmSFXWkW7GjUkpThrU3g==
X-Received: by 2002:a17:907:2712:: with SMTP id
 w18mr22166297ejk.302.1628501754741; 
 Mon, 09 Aug 2021 02:35:54 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyQ0PoL7f5ergJ7Gs2MRT0uFoNsKHh6BqUMU+kyKe+MtYxGKCOuwlwh2ztI2IUWMnyIhSEKQw==
X-Received: by 2002:a17:907:2712:: with SMTP id
 w18mr22166288ejk.302.1628501754619; 
 Mon, 09 Aug 2021 02:35:54 -0700 (PDT)
Received: from redhat.com ([2.55.145.148])
 by smtp.gmail.com with ESMTPSA id h10sm7613801edb.74.2021.08.09.02.35.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 09 Aug 2021 02:35:53 -0700 (PDT)
Date: Mon, 9 Aug 2021 05:35:49 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Eli Cohen <elic@nvidia.com>
Subject: Re: [PATCH 0/3] vdpa/mlx5: Add Control VQ and MAC and Multi queue
 support
Message-ID: <20210809053528-mutt-send-email-mst@kernel.org>
References: <20210809080043.169701-1-elic@nvidia.com>
MIME-Version: 1.0
In-Reply-To: <20210809080043.169701-1-elic@nvidia.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=mst@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: eperezma@redhat.com, virtualization@lists.linux-foundation.org
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

On Mon, Aug 09, 2021 at 11:00:40AM +0300, Eli Cohen wrote:
> Hi Michael,
> 
> First patch is just a cleaup.
> Second patch adds control virtqueue support for mlx5_vdpa and handle MAC
> configutations through the control VQ.
> Third patch adds multi queue support for mlx5_vdpa accepting
> configurations from the control VQ.

Threading broken again :(

> Eli Cohen (3):
>   vdpa/mlx5: Remove redundant header file inclusion
>   vdpa/mlx5: Add support for control VQ and MAC setting
>   vdpa/mlx5: Add multiqueue support
> 
>  drivers/vdpa/mlx5/core/mlx5_vdpa.h |  25 +-
>  drivers/vdpa/mlx5/core/mr.c        |  87 ++++--
>  drivers/vdpa/mlx5/core/resources.c |  41 +++
>  drivers/vdpa/mlx5/net/mlx5_vnet.c  | 471 +++++++++++++++++++++++++----
>  4 files changed, 549 insertions(+), 75 deletions(-)
> 
> -- 
> 2.31.1

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
