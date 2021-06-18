Return-Path: <SRS0=81yh=LM=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E3190C48BDF
	for <virtualization@archiver.kernel.org>; Fri, 18 Jun 2021 14:45:05 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7EF406128C
	for <virtualization@archiver.kernel.org>; Fri, 18 Jun 2021 14:45:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7EF406128C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 31F934041E;
	Fri, 18 Jun 2021 14:45:05 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id aVAHRbLWpT33; Fri, 18 Jun 2021 14:45:04 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 8E7B24042D;
	Fri, 18 Jun 2021 14:45:03 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 43BE5C000D;
	Fri, 18 Jun 2021 14:45:03 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 277DFC000B
 for <virtualization@lists.linux-foundation.org>;
 Fri, 18 Jun 2021 14:45:02 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 1B0894042D
 for <virtualization@lists.linux-foundation.org>;
 Fri, 18 Jun 2021 14:45:02 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 62isauICe8Qc
 for <virtualization@lists.linux-foundation.org>;
 Fri, 18 Jun 2021 14:45:00 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [216.205.24.124])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 9ABE44041E
 for <virtualization@lists.linux-foundation.org>;
 Fri, 18 Jun 2021 14:45:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1624027499;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=V/WnAvrrvHUpmCgAw99j9Kec2UebwacAruxQ8zG2B7M=;
 b=HT/1qc79JJhwxg1eyPIDD8eAEH4x9FW/mGHmz1SMLECqj33avFExyGg7kGRifrERlwP9mo
 0n0xoz+5JU+e5LdFdXi3zpNyQzYHuy0lMtycLO00V2StWH/yxbm7jCIyJ3nTwoceJGymNe
 aYfQjiJWtSbOVY6w5gQzgDVRFxanuPs=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-247-98cB2hkbNPSsyvCAhj8KyQ-1; Fri, 18 Jun 2021 10:44:57 -0400
X-MC-Unique: 98cB2hkbNPSsyvCAhj8KyQ-1
Received: by mail-ej1-f72.google.com with SMTP id
 n19-20020a1709067253b029043b446e4a03so4075391ejk.23
 for <virtualization@lists.linux-foundation.org>;
 Fri, 18 Jun 2021 07:44:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=V/WnAvrrvHUpmCgAw99j9Kec2UebwacAruxQ8zG2B7M=;
 b=tBrhDiOvsbAXKf1a57XwTWyQ/Wsd7XGroamz2lawbbIn/qXwsvI5RlcPGuTS1IXzkH
 JFzRJ3JbunBlplxli0UKPE6X3ic7DIB8UF67iQmmoUKwP2pDgktrDc2MIdb/Xip5KvSu
 pqCPY/bglNEUt3Y/c0G11SaBmD6Q8KG9mbaCRA22/xdCDpSgYVm5bb9dyTLOLzCqv77p
 2Zmgcob1B5tziwznenYXxjuJYLI11BgZK9UO5tsRuSXAWFYBz2Oag6TWJd993EPJbDp/
 tZyWg2angAp82t9l91XZDo1M+uF4IQwpxybEAcOZOvldU6xG2F0lept9UjdNFxxPnCTr
 hLQg==
X-Gm-Message-State: AOAM533eJmfaVcmz6tCw8zlml8VoV7v0UT3cvKgK8cJPc5OK8Cmp9HMn
 HoCrFbZM90hDWQgkpasWHy70k7wLlEpDtmPXFslEZpvRatZR0zyqS5JLuPHWGU9IWurzWzg9dvQ
 qtzhPL83EyKgLHX0+PX3gIEYKKYzQJ9VsEaCs/bzfTg==
X-Received: by 2002:a50:fe84:: with SMTP id d4mr3407521edt.204.1624027496831; 
 Fri, 18 Jun 2021 07:44:56 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzK4Z8Hr0HyQjHs6Puo8AmSdgMXl6TuIWEB1lOjBOybncOitI6nTXoOqO4csz4fz/xLxynwbg==
X-Received: by 2002:a50:fe84:: with SMTP id d4mr3407501edt.204.1624027496686; 
 Fri, 18 Jun 2021 07:44:56 -0700 (PDT)
Received: from steredhat.lan ([5.170.128.175])
 by smtp.gmail.com with ESMTPSA id c18sm6178818edt.97.2021.06.18.07.44.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 18 Jun 2021 07:44:56 -0700 (PDT)
Date: Fri, 18 Jun 2021 16:44:51 +0200
From: Stefano Garzarella <sgarzare@redhat.com>
To: "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: [PATCH v11 11/18] virtio/vsock: dequeue callback for
 SOCK_SEQPACKET
Message-ID: <20210618144451.6gmeqtfawdjpvgkv@steredhat.lan>
References: <20210611110744.3650456-1-arseny.krasnov@kaspersky.com>
 <20210611111241.3652274-1-arseny.krasnov@kaspersky.com>
 <20210618134423.mksgnbmchmow4sgh@steredhat.lan>
 <20210618095006-mutt-send-email-mst@kernel.org>
MIME-Version: 1.0
In-Reply-To: <20210618095006-mutt-send-email-mst@kernel.org>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=sgarzare@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: Andra Paraschiv <andraprs@amazon.com>, kvm@vger.kernel.org,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 virtualization@lists.linux-foundation.org, oxffffaa@gmail.com,
 Norbert Slusarek <nslusarek@gmx.net>, Stefan Hajnoczi <stefanha@redhat.com>,
 Colin Ian King <colin.king@canonical.com>, Jakub Kicinski <kuba@kernel.org>,
 Arseny Krasnov <arseny.krasnov@kaspersky.com>,
 "David S. Miller" <davem@davemloft.net>
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

On Fri, Jun 18, 2021 at 09:51:44AM -0400, Michael S. Tsirkin wrote:
>On Fri, Jun 18, 2021 at 03:44:23PM +0200, Stefano Garzarella wrote:
>> Hi Arseny,
>> the series looks great, I have just a question below about
>> seqpacket_dequeue.
>>
>> I also sent a couple a simple fixes, it would be great if you can review
>> them:
>> https://lore.kernel.org/netdev/20210618133526.300347-1-sgarzare@redhat.com/
>
>So given this was picked into net next, what's the plan? Just make spec
>follow code? We can wait and see, if there are issues with the spec just
>remember to mask the feature before release.

Yep, the spec patches was already posted, but not merged yet: 
https://lists.oasis-open.org/archives/virtio-comment/202105/msg00017.html

The changes are quite small and they are aligned with the current 
implementation.

Anyway, I perfectly agree with you about waiting and mask it before 
v5.14 release if there are any issue.

Thanks,
Stefano

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
