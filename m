Return-Path: <SRS0=CL3f=KF=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_RED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5ACD2C433ED
	for <virtualization@archiver.kernel.org>; Mon, 10 May 2021 07:01:14 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E03196145C
	for <virtualization@archiver.kernel.org>; Mon, 10 May 2021 07:01:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E03196145C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 780CB83ACD;
	Mon, 10 May 2021 07:01:13 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id IOGN_C0WpYD5; Mon, 10 May 2021 07:01:12 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTP id 2AC0C83D2C;
	Mon, 10 May 2021 07:01:12 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 006F0C000D;
	Mon, 10 May 2021 07:01:11 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id A44A9C0001
 for <virtualization@lists.linux-foundation.org>;
 Mon, 10 May 2021 07:01:10 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 84DA583D2C
 for <virtualization@lists.linux-foundation.org>;
 Mon, 10 May 2021 07:01:10 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id rEiyL7PCdvZ5
 for <virtualization@lists.linux-foundation.org>;
 Mon, 10 May 2021 07:01:09 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [216.205.24.124])
 by smtp1.osuosl.org (Postfix) with ESMTPS id B0CA383ACD
 for <virtualization@lists.linux-foundation.org>;
 Mon, 10 May 2021 07:01:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1620630067;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=+Ccocry+LC8Oe8hSofuaYNRZNWwXj9OcoogwaqXg/EU=;
 b=gUWYliQaGs7jgLAe7AI7n97OtXiYe1hGbAZBlhnAA6HRwIZRhB/Ypof4u91ykB6mnrHsut
 +oBfjdcTE1zuOntrxM3UZd8grVFeZ4sbYQfnSacpWO9YlqEwQImvkrecIe6sNBeSzbO7hf
 PqeXzW4N30H1dpLpKCy5TRXRazuw0p4=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-313-uLbOYLcaN1SldkfMo5HTsg-1; Mon, 10 May 2021 03:01:05 -0400
X-MC-Unique: uLbOYLcaN1SldkfMo5HTsg-1
Received: by mail-ej1-f71.google.com with SMTP id
 zo1-20020a170906ff41b02903973107d7b5so4337525ejb.21
 for <virtualization@lists.linux-foundation.org>;
 Mon, 10 May 2021 00:01:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=+Ccocry+LC8Oe8hSofuaYNRZNWwXj9OcoogwaqXg/EU=;
 b=FxjUnTgV51kFOEsXQbSseQVYzaAQETD1etUqndmdvTPTLWG/dCFIQ1mDlmXSYnl1x/
 zd9O0HtVknFo63JxNwqJW0eNGuY9G+F11RhZ/nVIQu2FZXHrf6a4GfE6TcmLU7dobDRn
 Ky3gSvLgAfGKb7RxLLuMb84wecTiMQwWt3OZ6g3r/kINTbIw4RgZnDxJ41SAySt15ieh
 KZFVAB/UcRQY8NZ3fTNrg2xtHv44st8hMaV27ld5pSGR/Z+aEI9PSqWjv5UgCLgwwvwG
 amqv8mkUAGZ/Gi8YGtmTp7N7VS24MYUpAIX26D3uhbX89SqPfwirMejx+R84i0J+G40+
 U/vw==
X-Gm-Message-State: AOAM530uNSqXyrKsiVcd073F00DR7Ki9DU4sX4M84EP/Spv8c5bxpAaf
 HDm011IbxH+SmB7Y/ccC1nzHtVN8JEE6HYbkLEyms6VDFqkPvGe0u2mHBesUYL1sd6zlNdn6THu
 NBCURW3CWDJx1hHshXBGX0ibhSELevSct0MJsRaM6lQ==
X-Received: by 2002:a17:907:2663:: with SMTP id
 ci3mr23894274ejc.540.1620630063975; 
 Mon, 10 May 2021 00:01:03 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyhIhplVuPHeT7rXzzBN3tJyJ6NtNTIZsq1e3F5sXmvdr8VITGqlg4MplkKxm5ee2cDul6AQA==
X-Received: by 2002:a17:907:2663:: with SMTP id
 ci3mr23894254ejc.540.1620630063773; 
 Mon, 10 May 2021 00:01:03 -0700 (PDT)
Received: from steredhat (host-79-18-148-79.retail.telecomitalia.it.
 [79.18.148.79])
 by smtp.gmail.com with ESMTPSA id g13sm8392482ejx.51.2021.05.10.00.01.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 10 May 2021 00:01:03 -0700 (PDT)
Date: Mon, 10 May 2021 09:01:01 +0200
From: Stefano Garzarella <sgarzare@redhat.com>
To: Wan Jiabing <wanjiabing@vivo.com>
Subject: Re: [PATCH] vdpa_sim_blk: remove duplicate include of linux/blkdev.h
Message-ID: <20210510070101.iimcdu7zkmx5on6a@steredhat>
References: <20210510024307.7143-1-wanjiabing@vivo.com>
MIME-Version: 1.0
In-Reply-To: <20210510024307.7143-1-wanjiabing@vivo.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=sgarzare@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: Max Gurtovoy <mgurtovoy@nvidia.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org,
 Stefan Hajnoczi <stefanha@redhat.com>, kael_w@yeah.net
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
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>

On Mon, May 10, 2021 at 10:43:03AM +0800, Wan Jiabing wrote:
>In commit 7d189f617f83f ("vdpa_sim_blk: implement ramdisk behaviour")
>linux/blkdev.h was included here causing the duplicate include.
>Remove the later duplicate include.
>
>Signed-off-by: Wan Jiabing <wanjiabing@vivo.com>
>---
> drivers/vdpa/vdpa_sim/vdpa_sim_blk.c | 1 -
> 1 file changed, 1 deletion(-)
>
>diff --git a/drivers/vdpa/vdpa_sim/vdpa_sim_blk.c b/drivers/vdpa/vdpa_sim/vdpa_sim_blk.c
>index 5bfe1c281645..a790903f243e 100644
>--- a/drivers/vdpa/vdpa_sim/vdpa_sim_blk.c
>+++ b/drivers/vdpa/vdpa_sim/vdpa_sim_blk.c
>@@ -15,7 +15,6 @@
> #include <linux/blkdev.h>
> #include <linux/vringh.h>
> #include <linux/vdpa.h>
>-#include <linux/blkdev.h>
> #include <uapi/linux/virtio_blk.h>
>
> #include "vdpa_sim.h"
>-- 
>2.20.1
>

Ooops...

Thanks for fixing this!

Reviewed-by: Stefano Garzarella <sgarzare@redhat.com>

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
