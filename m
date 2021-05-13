Return-Path: <SRS0=J7l7=KI=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 047A1C433ED
	for <virtualization@archiver.kernel.org>; Thu, 13 May 2021 14:47:05 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A2F2E61370
	for <virtualization@archiver.kernel.org>; Thu, 13 May 2021 14:47:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A2F2E61370
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 588EE8450A;
	Thu, 13 May 2021 14:47:04 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id ro5Rp4RhgMff; Thu, 13 May 2021 14:47:03 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTP id 05AFD84500;
	Thu, 13 May 2021 14:47:03 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id DA55DC000D;
	Thu, 13 May 2021 14:47:02 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id EEA73C0001
 for <virtualization@lists.linux-foundation.org>;
 Thu, 13 May 2021 14:47:00 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id DC96D606BD
 for <virtualization@lists.linux-foundation.org>;
 Thu, 13 May 2021 14:47:00 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp3.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id qF5LOLAXNVNT
 for <virtualization@lists.linux-foundation.org>;
 Thu, 13 May 2021 14:47:00 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [216.205.24.124])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 25DF96066D
 for <virtualization@lists.linux-foundation.org>;
 Thu, 13 May 2021 14:46:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1620917219;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=rGg3l/7n8SNDT+a7ouZ0AJr+1X0/uEbg6PfCHzDeJoQ=;
 b=DaXC4Vr90H3qXrSmGdfXHfU1wXHAPhqIFhKU44BIpW/sHtUtwuOXbMl6m/HK99ukiC1qLx
 lbnox7GuOAVPv8hyXHm6vStOhE0msAbq4lwMg+7bfj9uPmbCtD877HpTWILjGeUBWmdcQ4
 0hTgFSMkQnwxp0Mt+A+S7Y+KdRtzsU8=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-65-XTEpezqHNTuxRtvs_gu4Gw-1; Thu, 13 May 2021 10:46:57 -0400
X-MC-Unique: XTEpezqHNTuxRtvs_gu4Gw-1
Received: by mail-ed1-f72.google.com with SMTP id
 y17-20020a0564023591b02903886c26ada4so14776838edc.5
 for <virtualization@lists.linux-foundation.org>;
 Thu, 13 May 2021 07:46:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=rGg3l/7n8SNDT+a7ouZ0AJr+1X0/uEbg6PfCHzDeJoQ=;
 b=SeIozNrNPhyLOFfZZjuO8zBhq3jpM/9CkUPA1zH817AfeAp3vd6LEukBXBnRgo8eql
 XDjdNwyGIilBz2TjAPcpdY0z+cTCmemzFci6GwYK90yhoGj3hrmEAEj+dKt59WBiNfgL
 +XjMRRvtkCODuhV/DPqKfGbiG4pCwNB//ijM0YohH1m+HqYU5EGYnonCY/3ba8bdwUkW
 jYPl8PMuIhPPv1198IStIHYvZw+ev4G2VB7S+OxU2i8BWVPMk5MxUvZhV4O7J7d2x2Mq
 aFY1ZR5FeaiAmIPqmV4WutfLW3MTS+bbmxxzC+IRpAS4EQMQywW3mA1B4UZz2lM+0Y8h
 AKtg==
X-Gm-Message-State: AOAM531IhB/GbQiVRYtkJ4b6nnKbVnCY8MHjx+H83PafdmtKSWNwxHZa
 /OCVU1L31stEmc72qmhgblD3IcXc21zWI5EAvinEg2zR617iCX5yLO2AuaeVMjptbG+Ydeawy+Z
 gKdd8ADHib4yswYY4ue3b2uhUd+SW9Pe+GLmQSl5lBw==
X-Received: by 2002:a17:907:3e28:: with SMTP id
 hp40mr21283574ejc.523.1620917216307; 
 Thu, 13 May 2021 07:46:56 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwzSceLI37ohYl3OTJmHxOffRDbF3BNal57WXUnEN0Xk+EFEMUtvnnXnlAzBST0LnZ+IGqHEw==
X-Received: by 2002:a17:907:3e28:: with SMTP id
 hp40mr21283545ejc.523.1620917216075; 
 Thu, 13 May 2021 07:46:56 -0700 (PDT)
Received: from steredhat (host-79-18-148-79.retail.telecomitalia.it.
 [79.18.148.79])
 by smtp.gmail.com with ESMTPSA id i8sm2536335edu.64.2021.05.13.07.46.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 13 May 2021 07:46:55 -0700 (PDT)
Date: Thu, 13 May 2021 16:46:53 +0200
From: Stefano Garzarella <sgarzare@redhat.com>
To: Arseny Krasnov <arseny.krasnov@kaspersky.com>
Subject: Re: [RFC PATCH v9 19/19] af_vsock: serialize writes to shared socket
Message-ID: <20210513144653.ogzfvypqpjsz2iga@steredhat>
References: <20210508163027.3430238-1-arseny.krasnov@kaspersky.com>
 <20210508163738.3432975-1-arseny.krasnov@kaspersky.com>
 <20210513140150.ugw6foy742fxan4w@steredhat>
MIME-Version: 1.0
In-Reply-To: <20210513140150.ugw6foy742fxan4w@steredhat>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=sgarzare@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: Andra Paraschiv <andraprs@amazon.com>, kvm@vger.kernel.org,
 "Michael S. Tsirkin" <mst@redhat.com>, netdev@vger.kernel.org, stsp2@yandex.ru,
 linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org,
 oxffffaa@gmail.com, Norbert Slusarek <nslusarek@gmx.net>,
 Stefan Hajnoczi <stefanha@redhat.com>,
 Colin Ian King <colin.king@canonical.com>, Jakub Kicinski <kuba@kernel.org>,
 "David S. Miller" <davem@davemloft.net>, Jorgen Hansen <jhansen@vmware.com>
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

On Thu, May 13, 2021 at 04:01:50PM +0200, Stefano Garzarella wrote:
>On Sat, May 08, 2021 at 07:37:35PM +0300, Arseny Krasnov wrote:
>>This add logic, that serializes write access to single socket
>>by multiple threads. It is implemented be adding field with TID
>>of current writer. When writer tries to send something, it checks
>>that field is -1(free), else it sleep in the same way as waiting
>>for free space at peers' side.
>>
>>Signed-off-by: Arseny Krasnov <arseny.krasnov@kaspersky.com>
>>---
>>include/net/af_vsock.h   |  1 +
>>net/vmw_vsock/af_vsock.c | 10 +++++++++-
>>2 files changed, 10 insertions(+), 1 deletion(-)
>
>I think you forgot to move this patch at the beginning of the series.
>It's important because in this way we can backport to stable branches 
>easily.
>
>About the implementation, can't we just add a mutex that we hold until 
>we have sent all the payload?

Re-thinking, I guess we can't because we have the timeout to deal 
with...

>
>I need to check other implementations like TCP.
>

Thanks,
Stefano

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
