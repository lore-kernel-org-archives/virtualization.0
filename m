Return-Path: <SRS0=LBOH=OZ=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C87A8C433EF
	for <virtualization@archiver.kernel.org>; Tue,  5 Oct 2021 11:40:29 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 71C6161529
	for <virtualization@archiver.kernel.org>; Tue,  5 Oct 2021 11:40:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 71C6161529
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 3C5E9400DE;
	Tue,  5 Oct 2021 11:40:29 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id IsRIDeT7ke_1; Tue,  5 Oct 2021 11:40:28 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 859E34011B;
	Tue,  5 Oct 2021 11:40:27 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 56C52C000F;
	Tue,  5 Oct 2021 11:40:27 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 2ED7CC000D
 for <virtualization@lists.linux-foundation.org>;
 Tue,  5 Oct 2021 11:40:26 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 003CA4058E
 for <virtualization@lists.linux-foundation.org>;
 Tue,  5 Oct 2021 11:40:26 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp4.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id cvcq1awrfruU
 for <virtualization@lists.linux-foundation.org>;
 Tue,  5 Oct 2021 11:40:25 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 62DCA403E5
 for <virtualization@lists.linux-foundation.org>;
 Tue,  5 Oct 2021 11:40:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1633434024;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=5jng+t/KM35rvlrjpFOnhlmQDfLsDuNmByDqJMmcgxQ=;
 b=Kgq3VI3mG6TPvUhfnt7RXpsaOSwukeO8aWPcZCOtcQXEpN5F/nkGfOeB7E7Jb10Y6/v3E1
 F2G7lMmgqwW8JQMvGrdD5bKYCDDs1/+1aLRF5PmagkB93ydnyIRR5ln9XgDoB1RBSyI4Ue
 ++k25W/jZ8gvacf/s00BsEFD4gcTTik=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-516-JXeaioh6O_mF_-qgddtkVw-1; Tue, 05 Oct 2021 07:40:22 -0400
X-MC-Unique: JXeaioh6O_mF_-qgddtkVw-1
Received: by mail-wr1-f69.google.com with SMTP id
 d13-20020adfa34d000000b00160aa1cc5f1so1920391wrb.14
 for <virtualization@lists.linux-foundation.org>;
 Tue, 05 Oct 2021 04:40:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
 :content-language:to:cc:references:from:in-reply-to
 :content-transfer-encoding;
 bh=5jng+t/KM35rvlrjpFOnhlmQDfLsDuNmByDqJMmcgxQ=;
 b=HBHpmsN1KxFCNaIsTzJOJZ7acACmavZyCXKwjJ9HHUECNzaruJnDOB43c7Z6/+cE5R
 CvCjp5g9YpEO7lJuA952gMweh3ozt2gZBeodMxSjuWjTLYfMNL6Kg9KDr16KvA5SgD2G
 +8xi/Q+FlxAC6fOt7d5OrXgxbIyoHvaQDLkwv7xU61bzBKOkHYcgtWEPRC3OaEcgSV9o
 gkzYKloDOOru2t+grtgDQREgfnEVdISvx2ru3mLMqsDnX3wkPT2TTFpUxEREXv163QGq
 S3bN9FgjXWUVhCa7OHiN2LwyNBRyk4AZAsapC1t7Rty+g11Qn/X0anoK0XnLOR3rvLZz
 a3qA==
X-Gm-Message-State: AOAM533Z2BCTkUcmXdev8DIe8RRX4F/IBKXoFjUqxtCWio7mhhocEnGL
 GQbYhBwAT5kBcXcIoHvjwbSnXYl4jvODgZNsx6UHaZLMrFkdZshU747mYVzbaW7EtB9o6rW2k1u
 bdakdyW1vo9qmfRgLqOYqTPmM0/aNEUZ65VrimgMyIg==
X-Received: by 2002:adf:f946:: with SMTP id q6mr20801004wrr.437.1633434021614; 
 Tue, 05 Oct 2021 04:40:21 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyazp3VBDOnWtSY8G3MjsohPMvzJyMJLtngLNsfvR7sWs6QI+KrltPbhmkHqKDnOIrXSYvmXQ==
X-Received: by 2002:adf:f946:: with SMTP id q6mr20800984wrr.437.1633434021441; 
 Tue, 05 Oct 2021 04:40:21 -0700 (PDT)
Received: from [192.168.100.42] ([82.142.3.114])
 by smtp.gmail.com with ESMTPSA id n14sm1823048wms.0.2021.10.05.04.40.20
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 05 Oct 2021 04:40:21 -0700 (PDT)
Message-ID: <637cd2e5-8584-3ef5-6de8-bf43b581d0d6@redhat.com>
Date: Tue, 5 Oct 2021 13:40:19 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.1.0
Subject: Re: [PATCH 0/4] hwrng: virtio - add an internal buffer
To: linux-kernel@vger.kernel.org
References: <20210922170903.577801-1-lvivier@redhat.com>
From: Laurent Vivier <lvivier@redhat.com>
In-Reply-To: <20210922170903.577801-1-lvivier@redhat.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=lvivier@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Language: en-US
Cc: Herbert Xu <herbert@gondor.apana.org.au>, amit@kernel.org,
 "Michael S . Tsirkin" <mst@redhat.com>, rusty@rustcorp.com.au,
 virtualization@lists.linux-foundation.org,
 Alexander Potapenko <glider@google.com>, linux-crypto@vger.kernel.org,
 Matt Mackall <mpm@selenic.com>, akong@redhat.com,
 Dmitriy Vyukov <dvyukov@google.com>
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

On 22/09/2021 19:08, Laurent Vivier wrote:
> hwrng core uses two buffers that can be mixed in the virtio-rng queue.
> 
> This series fixes the problem by adding an internal buffer in virtio-rng.
> 
> Once the internal buffer is added, we can fix two other problems:
> 
> - to be able to release the driver without waiting the device releases the
>    buffer
> 
> - actually returns some data when wait=0 as we can have some already
>    available data
> 
> It also tries to improve the performance by always having a buffer in
> the queue of the device.
> 
> Laurent Vivier (4):
>    hwrng: virtio - add an internal buffer
>    hwrng: virtio - don't wait on cleanup
>    hwrng: virtio - don't waste entropy
>    hwrng: virtio - always add a pending request
> 
>   drivers/char/hw_random/virtio-rng.c | 84 +++++++++++++++++++++--------
>   1 file changed, 63 insertions(+), 21 deletions(-)
> 

Any comment?

Do we need a v2?

Thanks,
Laurent

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
