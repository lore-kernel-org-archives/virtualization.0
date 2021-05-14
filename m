Return-Path: <SRS0=Tn2H=KJ=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C127FC433ED
	for <virtualization@archiver.kernel.org>; Fri, 14 May 2021 15:17:13 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4B17361451
	for <virtualization@archiver.kernel.org>; Fri, 14 May 2021 15:17:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4B17361451
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 0166E40485;
	Fri, 14 May 2021 15:17:13 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id R416BYcRRGJ8; Fri, 14 May 2021 15:17:12 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp2.osuosl.org (Postfix) with ESMTP id 9F4D840133;
	Fri, 14 May 2021 15:17:11 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 6E670C000D;
	Fri, 14 May 2021 15:17:11 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 2221FC0001
 for <virtualization@lists.linux-foundation.org>;
 Fri, 14 May 2021 15:17:10 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 0FF9940460
 for <virtualization@lists.linux-foundation.org>;
 Fri, 14 May 2021 15:17:10 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id MQ8JYlEGRIxZ
 for <virtualization@lists.linux-foundation.org>;
 Fri, 14 May 2021 15:17:09 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [216.205.24.124])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 4190240133
 for <virtualization@lists.linux-foundation.org>;
 Fri, 14 May 2021 15:17:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1621005428;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=PNg4cj3twh0gNAEuDstIatrLOJ+AW8O1LnSMliAVOnI=;
 b=G2CcfibaJWzE+Au27TTXwD6q9mgObLfv62M1X2r46HgPoU58BLUsq0zhXz+7aX4Tl/yOG5
 k/G0gRBfdFDMruVsrhWO68JsUj3STGkE1+RZTtWWr+KdgD/FEHjWRw51S+PpRMvq3BzAIu
 I0dGtistK8hF25o04u2Kqb28RojVNsQ=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-569-BGqmtb8AO_qRU8c8GSsmfQ-1; Fri, 14 May 2021 11:17:06 -0400
X-MC-Unique: BGqmtb8AO_qRU8c8GSsmfQ-1
Received: by mail-ed1-f69.google.com with SMTP id
 g7-20020aa7c5870000b02903888f809d62so16645890edq.23
 for <virtualization@lists.linux-foundation.org>;
 Fri, 14 May 2021 08:17:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=PNg4cj3twh0gNAEuDstIatrLOJ+AW8O1LnSMliAVOnI=;
 b=b0LjjmhqMA9Ud1Q5InWpCHmBJ4cml07EbUHkFNAK7Zs73+mTqZzWcJK51hdFl6eFPg
 b9V4yeHTvStJYt9ibksHNkzUF+orUZP5xu6yknrNR26/jRUmDUB0UzqZ/XCkXaASAtf5
 nVW5U/otQVf6/m34nLFtdrrjQbkV/34lcGV2CtnPvEEGpO+Sgj++PVQJTdyn/lx/j9+n
 mbPDTAWQ4adiH/A0+bvXua397MnVBE1a4HMSfD3MUBp7z2CWLz9aECzgZUr5MXT+ib6Z
 4ZDAV2nJ9ZGHaRclkfI8QCPi21lRKc+KUo2F1l6V9kaekDvk2cZ2VeQ7s4+FFO6tl3/K
 aNdg==
X-Gm-Message-State: AOAM530E6qZkTTzTedIvjYjrn96HIxBvYfTRY/FG1FxLtVec4AeBbjh0
 eKo5kD6SZptAzN/S5LTR554bY4NXFSGOUopBE6aw1FcZRNqTvTA7NFITaSAXIm9gObEPUdAEgMQ
 vRRIh5yl13Pc7xxKwPbdUHlcuT2xFID+mSRoQpGzs5Q==
X-Received: by 2002:a17:906:c9d8:: with SMTP id
 hk24mr49854677ejb.480.1621005424955; 
 Fri, 14 May 2021 08:17:04 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyynzDKq0Pye7IwuiIJQqRF3RXAA1FGmeNHrEfOAjPqF0aDbHFya3d4BHBZ4GjyVroazFXBtA==
X-Received: by 2002:a17:906:c9d8:: with SMTP id
 hk24mr49854651ejb.480.1621005424794; 
 Fri, 14 May 2021 08:17:04 -0700 (PDT)
Received: from steredhat (host-79-18-148-79.retail.telecomitalia.it.
 [79.18.148.79])
 by smtp.gmail.com with ESMTPSA id gt12sm3714545ejb.60.2021.05.14.08.17.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 14 May 2021 08:17:04 -0700 (PDT)
Date: Fri, 14 May 2021 17:17:01 +0200
From: Stefano Garzarella <sgarzare@redhat.com>
To: "Jiang Wang ." <jiang.wang@bytedance.com>
Subject: Re: [RFC v2] virtio-vsock: add description for datagram type
Message-ID: <20210514151701.6fp27qanjseom4tl@steredhat>
References: <20210414093841.koerx2wsmszv4nnj@steredhat>
 <CAP_N_Z85c+GLTmqBkMrRGQzWFj73i=FSiU-hAP7bEmaKTNnc6g@mail.gmail.com>
 <CAP_N_Z9xPgyf=au4VD+fXF8iorZHHk7Q4-CbJCOVUeupG4v4sw@mail.gmail.com>
 <20210504161651.3b6fhi64d7g3jui4@steredhat>
 <CAP_N_Z_cYjTCUpmLAW0xskUM_kAi=8e7iU8RXsMRnYWOxhA5OA@mail.gmail.com>
 <20210505104933.wgdn4gw56kle2mec@steredhat>
 <CAP_N_Z_DN+SYZ3E52HGdcmSfopBoNayKVzUdH7Nc2jUK5nfmLA@mail.gmail.com>
 <CAP_N_Z9yZ4ydXaEn1e=70pDh3FyDjrrxgzis4YTfyDoZ5c8k+g@mail.gmail.com>
 <20210510145055.y7mxqaq4zggajz5a@steredhat>
 <CAP_N_Z94Pi4k8Dv6cHR0CZ9RTLJeQ3VWQoQgLTCWE4k+A01xbg@mail.gmail.com>
MIME-Version: 1.0
In-Reply-To: <CAP_N_Z94Pi4k8Dv6cHR0CZ9RTLJeQ3VWQoQgLTCWE4k+A01xbg@mail.gmail.com>
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

On Thu, May 13, 2021 at 04:26:03PM -0700, Jiang Wang . wrote:
>On Mon, May 10, 2021 at 7:52 AM Stefano Garzarella <sgarzare@redhat.com> wrote:
>> On Fri, May 07, 2021 at 09:53:19AM -0700, Jiang Wang . wrote:

[...]

>I was thinking if we don't add two new virtqueues, then maybe we don't
>need to add new feature bit too? If the other end does not support
>dgram, then the packets will be just dropped. What do you think? Do
>we still need to add dgram feature bits? I can have a feature bit for
>mergeable buffer.

With seqpacket, where we reuse stream queues, we decided to add the new 
feature bit, so I guess we should do the same for dgram.

In this way the driver knows if the protocol is supported and we can 
avoid for example to open a listening socket.

Without the feature bit this would not be possible. I mean, the sender 
will get an error, but the receiver will never know if it can receive or 
not.

>> >What do you guys think? I remember Stefano mentioned that we should 
>> >add
>> >two new virtqueues for dgram. Stefano, do you have some specific reasons
>> >for that? Could we just keep using existing virtqueues? Thanks.
>>
>> My biggest concern was about the credit mechanism for datagrams. I mean
>> avoiding datagrams from crowding the queue without limits, preventing
>> streams from communicating.
>>
>> If you've found a way to limit datagram traffic, then maybe it's doable.
>
>I see. I will add some limit to dgram packets. Also, when the virtqueues
>are shared between stream and dgram, both of them need to grab a lock
>before using the virtqueue, so one will not completely block another one.

I'm not worried about the concurrent access that we definitely need to 
handle with a lock, but more about the uncontrolled packet sending that 
dgram might have, flooding the queues and preventing others from 
communicating.

So having 2 dedicated queues could avoid a credit mechanism at all for 
connection-less sockets, and simply the receiver discards packets that 
it can't handle.

Thanks,
Stefano

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
