Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1B586C6FD1D
	for <virtualization@archiver.kernel.org>; Tue, 21 Mar 2023 08:31:33 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 3AA0B60E35;
	Tue, 21 Mar 2023 08:31:32 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 3AA0B60E35
Authentication-Results: smtp3.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=bjS8+W0Q
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id zDVZmRq5r1wC; Tue, 21 Mar 2023 08:31:31 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTPS id AD14860BEB;
	Tue, 21 Mar 2023 08:31:30 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org AD14860BEB
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id F02A1C0071;
	Tue, 21 Mar 2023 08:31:29 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 80D5DC0032
 for <virtualization@lists.linux-foundation.org>;
 Tue, 21 Mar 2023 08:31:28 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 62054402F2
 for <virtualization@lists.linux-foundation.org>;
 Tue, 21 Mar 2023 08:31:28 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 62054402F2
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=bjS8+W0Q
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id oCMgkwiiCp4t
 for <virtualization@lists.linux-foundation.org>;
 Tue, 21 Mar 2023 08:31:27 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 9538340112
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 9538340112
 for <virtualization@lists.linux-foundation.org>;
 Tue, 21 Mar 2023 08:31:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1679387486;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=xVYNxjgnVb0JFY+7c7KHAdgAuOx4HsFDK20pHkfB6C4=;
 b=bjS8+W0Qm8/poBuM8zy3FmJh8gAKFolG9ITL6nsvbDVtkHeCcfarWGXhXkCYLP2KyR98mX
 cwQ5FHaGNGOOXLx8VTdZ9dtEyj5aM+I3bZdStVK4HiM0Bq1Zmcbj257SLU363DN01pAcs2
 tLLoj6b0esnB99FtYI7rc13quCTqKdc=
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com
 [209.85.160.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-634-FaVVcL9kPueSgJCoCWgSkQ-1; Tue, 21 Mar 2023 04:31:24 -0400
X-MC-Unique: FaVVcL9kPueSgJCoCWgSkQ-1
Received: by mail-qt1-f197.google.com with SMTP id
 l17-20020ac84cd1000000b003bfbae42753so8300736qtv.12
 for <virtualization@lists.linux-foundation.org>;
 Tue, 21 Mar 2023 01:31:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112; t=1679387484;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=xVYNxjgnVb0JFY+7c7KHAdgAuOx4HsFDK20pHkfB6C4=;
 b=PmfCdyN5Zf7FJVvElNDeXX/1M8EDpbp/eEe8K7rI7G2wsBsXvY4cse6wVNgtvJXxbr
 Mt4aIWLQJSQcqIPngC2D5iip6BAEBAapVREiM+nP6MiKhvI2dJy2AgZqGdDZB1TpEEWT
 zCh63pU1Q3L6CIMZqBd5MSQJxu1IuE2Eb+jPavCGbFJLwBL+S7MCgAnZx6y5/Z92IKZd
 pZE9d2ptUq8QG12NHc6tmNxugV6ILxflyRjd+qczNZQqYcdPTnOm1pOyMF3YyCyjZSnI
 c5vx6ffVegKXW2pSrsinkuQC8CG4C+/JlDDFE0B+/hDIDxNjCK60VDchXWr06FZoX8mP
 CFzw==
X-Gm-Message-State: AO0yUKXrTE1B8Hpt8WRJSfIrBY1pl2+/L4An/J6CLi8DwZCnChFsGlzF
 hWd+V7uqdzhg6T9jnCexX1Wq8bEshJ9uV5rGttxgpH2siQ7IrTmTdBhtb/BOiKlY7LzjTsky6Kf
 PivKr4Q4FmU27bHBkx0cRvgqC6/ukI284iPxOpU7DZw==
X-Received: by 2002:ac8:4e56:0:b0:3bf:c371:789e with SMTP id
 e22-20020ac84e56000000b003bfc371789emr2992371qtw.14.1679387484561; 
 Tue, 21 Mar 2023 01:31:24 -0700 (PDT)
X-Google-Smtp-Source: AK7set8mAj/tW8Sor6IE+2uuuzeTZv1k3R2Mj59suaEEm8G9MRcPpnfF5V7q1374DrXGxP491bPB2w==
X-Received: by 2002:ac8:4e56:0:b0:3bf:c371:789e with SMTP id
 e22-20020ac84e56000000b003bfc371789emr2992359qtw.14.1679387484325; 
 Tue, 21 Mar 2023 01:31:24 -0700 (PDT)
Received: from sgarzare-redhat (host-82-57-51-170.retail.telecomitalia.it.
 [82.57.51.170]) by smtp.gmail.com with ESMTPSA id
 r16-20020a05620a299000b00746279f3fd5sm9035253qkp.9.2023.03.21.01.31.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 21 Mar 2023 01:31:23 -0700 (PDT)
Date: Tue, 21 Mar 2023 09:31:18 +0100
From: Stefano Garzarella <sgarzare@redhat.com>
To: Arseniy Krasnov <avkrasnov@sberdevices.ru>
Subject: Re: [RFC PATCH v1 1/3] virtio/vsock: fix header length on skb merging
Message-ID: <20230321083118.63pcdeklvjbqs3as@sgarzare-redhat>
References: <e141e6f1-00ae-232c-b840-b146bdb10e99@sberdevices.ru>
 <63445f2f-a0bb-153c-0e15-74a09ea26dc1@sberdevices.ru>
 <20230320145718.5gytg6t5pcz5rpnm@sgarzare-redhat>
 <329372cf-ef01-8a20-da6e-8c1f9795e41a@sberdevices.ru>
MIME-Version: 1.0
In-Reply-To: <329372cf-ef01-8a20-da6e-8c1f9795e41a@sberdevices.ru>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: Bobby Eshleman <bobby.eshleman@bytedance.com>, kvm@vger.kernel.org,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 virtualization@lists.linux-foundation.org, oxffffaa@gmail.com,
 Eric Dumazet <edumazet@google.com>, Stefan Hajnoczi <stefanha@redhat.com>,
 kernel@sberdevices.ru, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, "David S. Miller" <davem@davemloft.net>
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

On Mon, Mar 20, 2023 at 09:10:13PM +0300, Arseniy Krasnov wrote:
>
>
>On 20.03.2023 17:57, Stefano Garzarella wrote:
>> On Sun, Mar 19, 2023 at 09:51:06PM +0300, Arseniy Krasnov wrote:
>>> This fixes header length calculation of skbuff during data appending to
>>> it. When such skbuff is processed in dequeue callbacks, e.g. 'skb_pull()'
>>> is called on it, 'skb->len' is dynamic value, so it is impossible to use
>>> it in header, because value from header must be permanent for valid
>>> credit calculation ('rx_bytes'/'fwd_cnt').
>>>
>>> Fixes: 077706165717 ("virtio/vsock: don't use skbuff state to account credit")
>>
>> I don't understand how this commit introduced this problem, can you
>> explain it better?
>Sorry, seems i said it wrong a little bit. Before 0777, implementation was buggy, but
>exactly this problem was not actual - it didn't triggered somehow. I checked it with
>reproducer from this patch. But in 0777 as value from header was used to 'rx_bytes'
>calculation, bug become actual. Yes, may be it is not "Fixes:" for 0777, but critical
>addition. I'm not sure.
>>
>> Is it related more to the credit than to the size in the header itself?
>>
>It is related to size in header more.
>> Anyway, the patch LGTM, but we should explain better the issue.
>>
>
>Ok, I'll write it more clear in the commit message.

Okay, if 077706165717 triggered the problem, even if it was there from
before, then IMHO it is okay to use that commit in Fixes.

Please, explain it better in the message, so it's clear for everyone ;-)

Thanks,
Stefano

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
