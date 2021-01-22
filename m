Return-Path: <SRS0=TOd4=GZ=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5E109C433E0
	for <virtualization@archiver.kernel.org>; Fri, 22 Jan 2021 09:57:54 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D6EF722DBF
	for <virtualization@archiver.kernel.org>; Fri, 22 Jan 2021 09:57:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D6EF722DBF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by whitealder.osuosl.org (Postfix) with ESMTP id 1F42F86ED2;
	Fri, 22 Jan 2021 09:57:53 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id U87WF+JsGr4d; Fri, 22 Jan 2021 09:57:52 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by whitealder.osuosl.org (Postfix) with ESMTP id 5377886E5A;
	Fri, 22 Jan 2021 09:57:52 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 1DF8FC08A1;
	Fri, 22 Jan 2021 09:57:52 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id B7633C013A
 for <virtualization@lists.linux-foundation.org>;
 Fri, 22 Jan 2021 09:57:50 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by silver.osuosl.org (Postfix) with ESMTP id A3BC72DAFA
 for <virtualization@lists.linux-foundation.org>;
 Fri, 22 Jan 2021 09:57:50 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id B2UgKlk63LGc
 for <virtualization@lists.linux-foundation.org>;
 Fri, 22 Jan 2021 09:57:49 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail-vk1-f174.google.com (mail-vk1-f174.google.com
 [209.85.221.174])
 by silver.osuosl.org (Postfix) with ESMTPS id 86A1722E89
 for <virtualization@lists.linux-foundation.org>;
 Fri, 22 Jan 2021 09:57:49 +0000 (UTC)
Received: by mail-vk1-f174.google.com with SMTP id b78so876208vke.12
 for <virtualization@lists.linux-foundation.org>;
 Fri, 22 Jan 2021 01:57:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=HqmXNnhOvww/se+uqGpbG2r6Wj6LjG3RtqIoCGkH17k=;
 b=Bqt3b8b7kp2zQsjWv07hRffU5ZdsKDvLLb7CTBAQdsqsw2qRHDDv257TenVn8PQ0eh
 7Faa1tfN668wJ7fnNrENLH7AoZ+Yz7eIgCNhVFIajtS786Ovqkv97Wr+V6k7E2k62MxY
 +zFfZILJZPCMb2mgb5PIp7UG3mhyPOfuQoIscUoL7KcMmyArbnUdaC0O1T1v40yAIWCH
 kb3Y/uHtCaFYyztgZ4c9IexZUktiJQ8TjmoyT1uO1aGHIVI3c5zzudaDyrdeK9RYpTX9
 cIrmQQoHomR+23NhDIIBOqW/csi0rItWAjz9B7IdKkogQi35H0szd9iVKvGtnr3lgOid
 vpug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=HqmXNnhOvww/se+uqGpbG2r6Wj6LjG3RtqIoCGkH17k=;
 b=CCsHedVvAxR0qZqgmjHNhbV7Jp1dsyHJJ+VJg1MVH+8NSPpQYDxlI/awBtS2EG+jJO
 NGJ1ngZfd+N6V2FhrQ087vFDNIZek2mBoZJxYZtZKrQsuCy2b5sypCkxaYoW45uv3c7Q
 ZaeUpuXO/Rg78DVuxI24icM579c3P8aowjp0w5qaFpnDe4b0DSArFmya0gb3sq56ju24
 hm4ePf/qaA21y2KU7On0CGDRTghKetWQzzP+Oc6s8iLCsulmue1qXrDLWSVWGURG/8vG
 hcdHFYr7vvc2U9TcChcRxFIPirtS/pUlnmUcfT/XP9lfOqnMUHcmWRIOcl3PYBDNUVX8
 QK9A==
X-Gm-Message-State: AOAM531Slj1OpTgm8fNeBZm5L9URu0tzo5t4RCB4UaUFVCCAfidMX+4t
 hJsOY5X/MrfCvWJi6PplnYLEqDGa6VBcipsjQPc61t1n220V3A==
X-Google-Smtp-Source: ABdhPJzQkvbtXPAnaOXaJNiT2RO7BkT9eaJIQxnmfKyCTkaPtmRekmQxRuUvkDQuHQpmYuEkgvFe4kOJ3FrZfm16N6Y=
X-Received: by 2002:a67:f997:: with SMTP id b23mr235525vsq.34.1611309056136;
 Fri, 22 Jan 2021 01:50:56 -0800 (PST)
MIME-Version: 1.0
References: <20210122092824.20971-1-guoqing.jiang@cloud.ionos.com>
 <20210122092824.20971-3-guoqing.jiang@cloud.ionos.com>
In-Reply-To: <20210122092824.20971-3-guoqing.jiang@cloud.ionos.com>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Fri, 22 Jan 2021 10:50:20 +0100
Message-ID: <CAPDyKFoPL4drfh3efKXyhXLp6Ce+j=oHwNd9VnVP4aaKQ0zmDQ@mail.gmail.com>
Subject: Re: [PATCH V2 2/2] block: remove unnecessary argument from
 blk_execute_rq
To: Guoqing Jiang <guoqing.jiang@cloud.ionos.com>, Jens Axboe <axboe@kernel.dk>
Cc: linux-block <linux-block@vger.kernel.org>, linux-nfs@vger.kernel.org,
 linux-scsi <linux-scsi@vger.kernel.org>,
 "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
 linux-nvme@lists.infradead.org, virtualization@lists.linux-foundation.org,
 Christoph Hellwig <hch@infradead.org>, linux-ide@vger.kernel.org,
 target-devel@vger.kernel.org
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

On Fri, 22 Jan 2021 at 10:28, Guoqing Jiang
<guoqing.jiang@cloud.ionos.com> wrote:
>
> We can remove 'q' from blk_execute_rq as well after the previous change
> in blk_execute_rq_nowait.
>
> And more importantly it never really was needed to start with given
> that we can trivial derive it from struct request.
>
> Cc: linux-scsi@vger.kernel.org
> Cc: virtualization@lists.linux-foundation.org
> Cc: linux-ide@vger.kernel.org
> Cc: linux-mmc@vger.kernel.org
> Cc: linux-nvme@lists.infradead.org
> Cc: linux-nfs@vger.kernel.org
> Signed-off-by: Guoqing Jiang <guoqing.jiang@cloud.ionos.com>

[...]

>  drivers/mmc/core/block.c          | 10 +++++-----

[...]

From mmc point of view, please add:

Acked-by: Ulf Hansson <ulf.hansson@linaro.org>

At the moment I don't think this will conflict with any changes to
mmc, but if that happens let's sort it then...

Kind regards
Uffe
_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
