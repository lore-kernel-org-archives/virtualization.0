Return-Path: <SRS0=CL3f=KF=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_RED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 41FB0C433B4
	for <virtualization@archiver.kernel.org>; Mon, 10 May 2021 14:51:07 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D109E6109F
	for <virtualization@archiver.kernel.org>; Mon, 10 May 2021 14:51:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D109E6109F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 81A2D4053C;
	Mon, 10 May 2021 14:51:06 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id mMIGk2XsVtcY; Mon, 10 May 2021 14:51:05 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTP id 1105F4053B;
	Mon, 10 May 2021 14:51:05 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id DD95AC000D;
	Mon, 10 May 2021 14:51:04 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 257BAC0001
 for <virtualization@lists.linux-foundation.org>;
 Mon, 10 May 2021 14:51:03 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 13D1783E9A
 for <virtualization@lists.linux-foundation.org>;
 Mon, 10 May 2021 14:51:03 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp1.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 7r7nNcKzdF-p
 for <virtualization@lists.linux-foundation.org>;
 Mon, 10 May 2021 14:51:02 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 55CFD83E6C
 for <virtualization@lists.linux-foundation.org>;
 Mon, 10 May 2021 14:51:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1620658261;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=MRMkG1PJqhe6ws++2WTHcqNIdL8mLsR3eP8BArKE114=;
 b=c+2+ps6VMtn1wWTRIXihdFZX/Lz93/WIAnwEZ4GAbQqX7g1ScCn58x/btbXhH4RtWH0E44
 DgK0cPTyefkx2pmyXZIDr8rzi75LpF9ZAy+rA5Yce+v7G/TvTusQwx51YEbS2N+J6PzmJO
 YTLoCIimXss7jJy7amUPvha5C8ttbSI=
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-532-BjWm8XGSN4OMqW2gbyDL3Q-1; Mon, 10 May 2021 10:50:59 -0400
X-MC-Unique: BjWm8XGSN4OMqW2gbyDL3Q-1
Received: by mail-ed1-f71.google.com with SMTP id
 d8-20020a0564020008b0290387d38e3ce0so9190383edu.1
 for <virtualization@lists.linux-foundation.org>;
 Mon, 10 May 2021 07:50:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=MRMkG1PJqhe6ws++2WTHcqNIdL8mLsR3eP8BArKE114=;
 b=ZEhx7uiv9rCyilLrbEJh7pftdFVomhYt+GaAf/ru9t3WD4tqtEn18lrq5tKXPBDMHW
 5Qx9Qx+cq9XftrRZBU8bXEgO6mYlSbFDLcZvLhpILY9zAX6dVRNAwfESjMhj2r91/FEh
 oD3Tf2+LO6QbA074jNVodn1tvILWbAzzytVnlZVa2ZlyBkhGGZEG9Gk1nGAEjJhxJ1WJ
 d1V5Yb7ab5KyOskXzRSqMjfh9SsMpBMug5AEY9vhXTukJm0EvPC8+KhBvR/aUkFuKgJT
 b9FmmBPQOJFvGS4SmpSbrilL/sSWIg1awnARQgGp+HQpMmzjz4X+DYc9m9t8PEu4H7QT
 vYVg==
X-Gm-Message-State: AOAM531xEY+1M3tcqYE0N9Wc30qFJehnwoo/xXdaZnh4Nwbu4blF5x/o
 GH8mBRPmLtzZeMYV+roksBOpbGqVc1oHfy8Uq5TVrAv91NZA7drzfzl2REMVa1vzsl3E4zoZ9gX
 RzqfxHWKpmOQTZQcVojlNAMEFrplFNmdtpaDEVvJ4mg==
X-Received: by 2002:a17:906:cb1:: with SMTP id
 k17mr25951694ejh.307.1620658257871; 
 Mon, 10 May 2021 07:50:57 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJx/GCM330o1tpq0E0aJSj0pVRuTTSK+xep5C1euZx4kooyIR6egHjHjJjZ1T/14qIThdffu+w==
X-Received: by 2002:a17:906:cb1:: with SMTP id
 k17mr25951674ejh.307.1620658257669; 
 Mon, 10 May 2021 07:50:57 -0700 (PDT)
Received: from steredhat (host-79-18-148-79.retail.telecomitalia.it.
 [79.18.148.79])
 by smtp.gmail.com with ESMTPSA id q16sm11690465edv.61.2021.05.10.07.50.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 10 May 2021 07:50:57 -0700 (PDT)
Date: Mon, 10 May 2021 16:50:55 +0200
From: Stefano Garzarella <sgarzare@redhat.com>
To: "Jiang Wang ." <jiang.wang@bytedance.com>
Subject: Re: [RFC v2] virtio-vsock: add description for datagram type
Message-ID: <20210510145055.y7mxqaq4zggajz5a@steredhat>
References: <20210414065706.inmjuoxsexejbbxj@steredhat>
 <20210414031220-mutt-send-email-mst@kernel.org>
 <20210414093841.koerx2wsmszv4nnj@steredhat>
 <CAP_N_Z85c+GLTmqBkMrRGQzWFj73i=FSiU-hAP7bEmaKTNnc6g@mail.gmail.com>
 <CAP_N_Z9xPgyf=au4VD+fXF8iorZHHk7Q4-CbJCOVUeupG4v4sw@mail.gmail.com>
 <20210504161651.3b6fhi64d7g3jui4@steredhat>
 <CAP_N_Z_cYjTCUpmLAW0xskUM_kAi=8e7iU8RXsMRnYWOxhA5OA@mail.gmail.com>
 <20210505104933.wgdn4gw56kle2mec@steredhat>
 <CAP_N_Z_DN+SYZ3E52HGdcmSfopBoNayKVzUdH7Nc2jUK5nfmLA@mail.gmail.com>
 <CAP_N_Z9yZ4ydXaEn1e=70pDh3FyDjrrxgzis4YTfyDoZ5c8k+g@mail.gmail.com>
MIME-Version: 1.0
In-Reply-To: <CAP_N_Z9yZ4ydXaEn1e=70pDh3FyDjrrxgzis4YTfyDoZ5c8k+g@mail.gmail.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=sgarzare@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: cong.wang@bytedance.com, Xiongchun Duan <duanxiongchun@bytedance.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, cohuck@redhat.com,
 virtualization@lists.linux-foundation.org, xieyongji@bytedance.com,
 Stefan Hajnoczi <stefanha@redhat.com>,
 Arseny Krasnov <arseny.krasnov@kaspersky.com>
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

On Fri, May 07, 2021 at 09:53:19AM -0700, Jiang Wang . wrote:
>Hi guys,
>
>I have one question about adding two new virtqueues for dgram. One new
>thought is that we don't add two new virtqueues but keep using existing
>virtqueues for both stream and dgram.
>
>At the beginning when I first thought about supporting dgram, I thought
>adding two new virtqueues would be easier and have better performance.
>But now, after the prototype is done, I think that to keep using
>existing virtqueues is also not complicated and could in fact be simpler.
>The performance difference may not be very big.

I honestly didn't think it was easier to use two new queues, quite the 
opposite.

>
>Original code has about 3 places which have assumptions about the
>virtqueues are only used by the stream. But we can change those codes.
>One place is to check pkt len. We can check only for stream pkts.
>Another two are in tx and rx code path where if queued replies pkts are
>too much, the code will stop the rx queue and resume later. We can keep
>that same logic. The dgram will be affected a little bit but that should
>be fine I think. Are there any other places that we should fix?

Did you take a look at Arseny's series?
I think he's already found the places where to check the type and it 
seems to me they are the places you listed.

>
>In short, the virtqueues are in a lower level and can support multiple
>flows and socket types. Use existing virtqueues also make it more
>compatible with old versions.

It's not clear to me how compatibility is improved. Can you elaborate on 
this?

>
>What do you guys think? I remember Stefano mentioned that we should add
>two new virtqueues for dgram. Stefano, do you have some specific reasons
>for that? Could we just keep using existing virtqueues? Thanks.
>

My biggest concern was about the credit mechanism for datagrams. I mean 
avoiding datagrams from crowding the queue without limits, preventing 
streams from communicating.

If you've found a way to limit datagram traffic, then maybe it's doable.

Thanks,
Stefano

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
