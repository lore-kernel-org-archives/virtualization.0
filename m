Return-Path: <SRS0=Wmx8=KA=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 35172C433ED
	for <virtualization@archiver.kernel.org>; Wed,  5 May 2021 10:49:45 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9F231613C0
	for <virtualization@archiver.kernel.org>; Wed,  5 May 2021 10:49:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9F231613C0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 351C4403A6;
	Wed,  5 May 2021 10:49:44 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id xBS-NgbzA7Ab; Wed,  5 May 2021 10:49:42 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTP id 5796940376;
	Wed,  5 May 2021 10:49:42 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 36C19C000D;
	Wed,  5 May 2021 10:49:42 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 6CCCAC0001
 for <virtualization@lists.linux-foundation.org>;
 Wed,  5 May 2021 10:49:41 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 4CCD0401CC
 for <virtualization@lists.linux-foundation.org>;
 Wed,  5 May 2021 10:49:41 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp2.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id g1JyDeSsdnC3
 for <virtualization@lists.linux-foundation.org>;
 Wed,  5 May 2021 10:49:40 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 6F5D640599
 for <virtualization@lists.linux-foundation.org>;
 Wed,  5 May 2021 10:49:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1620211779;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=kepYfRvy+pw+hud7fsEFtjdb3qbUJI2V6WWVyzSEr7Q=;
 b=Y4EI3Q3TOjcYK8fYzndppolPXbPGsWbNHN4s42pCJeeQ+cqvHmVM4uvc1q5nrmWR/39T3t
 bQOWacaFkpQaQBgze7nF7nDh1z0iLqWNjgFvddyeMzLO1L+fWpijnzZerVZVm6+s65rzZY
 dJfPJR5Zw5fUb1u4D+SDDRq63NnbgCo=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-94-UtXk0JBNNAy_SgFAIAbIUw-1; Wed, 05 May 2021 06:49:38 -0400
X-MC-Unique: UtXk0JBNNAy_SgFAIAbIUw-1
Received: by mail-ed1-f69.google.com with SMTP id
 o12-20020aa7d3cc0000b02903891695ceabso662838edr.3
 for <virtualization@lists.linux-foundation.org>;
 Wed, 05 May 2021 03:49:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=kepYfRvy+pw+hud7fsEFtjdb3qbUJI2V6WWVyzSEr7Q=;
 b=Mdpu03Sb5cCMZbZF2VqHyMMBhrEGVvgh8ENvTXMk6Ny91XgNmV+AHDV9hcUX9fL1eL
 VLlfoNNAt7tB/TbGQMyivEYx/1GlpLlo83VkG1DFiwBjv6gHT78Tb/zDM1HoxaXqmzEI
 Jq77sCJJv1xGS5dtVt0hCOXHpCBppM1xfq91blKzyEkm2gOq1PGCMvUjRFvtVbjPeQLr
 JZWZJN5xc6InoHK0F9LcsRHw1BnpUTHKGW4sQSz0jwda0mrQDKJ0u3zzZkRXTdiuWKT6
 a9pczbSJW6kZqOMNssnNO4JQcyoA/YIi/6K6TVUgThfonx1vW4jX2uQaMvton7cx6tn5
 7dmw==
X-Gm-Message-State: AOAM5328PZrAIiC7niOAgFQFIUW2BnS68+B3XeT9IF7gRxCAMPJt1DRZ
 jceQFM3giZF9Z9XSAt9JAw4UAsiyyJzX9aWCR+VysmYk2YmoDCSOb59Kx1dSL5ZXJOAfeaB/KJn
 RgAImIzFNLJf+1O2YcIShzfZZxftkfg5LVLP68zF8aA==
X-Received: by 2002:a17:906:1794:: with SMTP id
 t20mr24286744eje.119.1620211776635; 
 Wed, 05 May 2021 03:49:36 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxG0YyKh/QmVpzCvUQiUxWBVFwwR0KWdooSJoWzT/y9XLB+IRF0knCAh5IpwWf4APVnteT1sQ==
X-Received: by 2002:a17:906:1794:: with SMTP id
 t20mr24286720eje.119.1620211776430; 
 Wed, 05 May 2021 03:49:36 -0700 (PDT)
Received: from steredhat (host-79-18-148-79.retail.telecomitalia.it.
 [79.18.148.79])
 by smtp.gmail.com with ESMTPSA id c7sm7622390ede.37.2021.05.05.03.49.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 05 May 2021 03:49:36 -0700 (PDT)
Date: Wed, 5 May 2021 12:49:33 +0200
From: Stefano Garzarella <sgarzare@redhat.com>
To: "Jiang Wang ." <jiang.wang@bytedance.com>
Subject: Re: [RFC v2] virtio-vsock: add description for datagram type
Message-ID: <20210505104933.wgdn4gw56kle2mec@steredhat>
References: <20210413094722-mutt-send-email-mst@kernel.org>
 <20210413140351.6vmffxqnj4azpyzx@steredhat>
 <20210413155635-mutt-send-email-mst@kernel.org>
 <20210414065706.inmjuoxsexejbbxj@steredhat>
 <20210414031220-mutt-send-email-mst@kernel.org>
 <20210414093841.koerx2wsmszv4nnj@steredhat>
 <CAP_N_Z85c+GLTmqBkMrRGQzWFj73i=FSiU-hAP7bEmaKTNnc6g@mail.gmail.com>
 <CAP_N_Z9xPgyf=au4VD+fXF8iorZHHk7Q4-CbJCOVUeupG4v4sw@mail.gmail.com>
 <20210504161651.3b6fhi64d7g3jui4@steredhat>
 <CAP_N_Z_cYjTCUpmLAW0xskUM_kAi=8e7iU8RXsMRnYWOxhA5OA@mail.gmail.com>
MIME-Version: 1.0
In-Reply-To: <CAP_N_Z_cYjTCUpmLAW0xskUM_kAi=8e7iU8RXsMRnYWOxhA5OA@mail.gmail.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=sgarzare@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: cong.wang@bytedance.com, Xiongchun Duan <duanxiongchun@bytedance.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, cohuck@redhat.com,
 virtualization@lists.linux-foundation.org, xieyongji@bytedance.com,
 Stefan Hajnoczi <stefanha@redhat.com>, asias@redhat.com,
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

On Tue, May 04, 2021 at 10:06:02AM -0700, Jiang Wang . wrote:
>On Tue, May 4, 2021 at 9:16 AM Stefano Garzarella <sgarzare@redhat.com> wrote:
>>
>> Hi Jiang,
>>
>> On Mon, May 03, 2021 at 08:40:46PM -0700, Jiang Wang . wrote:
>> >Hi Stefano,
>> >
>> >I checked the VIRTIO_NET_F_MRG_RXBUF feature bit and I think vsock
>> >dgram can use that feature too.
>>
>> Cool, thanks for checking!
>
>NP.
>
>> >Do we want to make this feature a must-have or optional? One idea is
>> >to make it optional. When not
>>
>> I think optional is fine, and we should support it for all kind of
>> traffic (stream, dgram, seqpacket).
>
>Got it. I was thinking only for dgram originally, but I think it should be fine
>for stream and seqpacket too.
>
>Btw, I have a small implementation question. For now, the vsock
>allocates rx buffers with two scatterlist. One for header and one for the
>payload. After we enable VIRTIO_NET_F_MRG_RXBUF feature,
>do we still want to allocate buffers like that? Or could we just use
>one big scatterlist for the whole packet? I think using the same allocation
>method is fine, but it just may not line up with the real packets well since
>we will skip headers for the big packets except the first buffer.

Good question.

With mergeable buffer I think is better to remove the little buffer for 
the header in the scatterlist, this should also avoid to do two 
allocations per packet/buffer in the guest.

>
>> >supported, dgram rx buf is 16 KB which should be good in most cases.
>>
>> Why not 4 KB like for stream? Or we could make it configurable.
>
>OK. sure. 4 KB is fine with me. I mentioned 16 KB because I was thinking
>jumbo frames in the ethernet world. But  I just found out the jumbo frame
>is about 8 KB or 9 KB only.
>
>If we make it configurable, what kind of interface to use to configure it?
>In linux, we could use something like the sysfs interface. I guess we don't

Yes, something like that for the guest driver.

>need to specify that detail in the spec though. I will just put the size should
>be configurable in the spec.

Yeah, I remember that at some point we fixed an issue where the host 
always expected buffer of 4 KB.

Now it should support any buffer sizes less or equal to 64 KB.

>
>> >When VIRTIO_NET_F_MRG_RXBUF is supported, the rx buf is 4K and the max
>> >packet size is 64 KB.
>> >
>> >Also, just to make sure we are on the same page, the current vsock
>> >stream code can also split a
>> >big packet to multiple buffers and the receive side can assemble them
>> >together.
>>
>> Yes, sort of. Being a stream, there's no concept of a boundary.
>>
>> > But dgram cannot
>> >use that code because the dgram may drop a buffer in the driver code
>> >(if there is not enough space).
>> >That means dgram may drop some buffers at the beginning, in the end or in the
>> >middle of a pkt. And a packet may
>> >not be received as a complete one. Therefore, we need something like
>> >VIRTIO_NET_F_MRG_RXBUF.
>>
>> Yep.
>>
>> >
>> >If we want to leverage current stream code without using
>> >VIRTIO_NET_F_MRG_RXBUF,
>> >we could add a total_len and offset to the virtio_vsock_hdr. Then when sending
>> >packet, the device split the big packet to multiple small ones and
>> >each has a header. They will have the
>> >same total_len, but different offsets. On the driver side, the driver
>> >can check the total_len before
>> >enqueueing the big packet for the one with offset 0.
>> >If there is enough space, all the remaining packets will be received.
>> >If not, the remaining packets will be dropped.
>> >I feel this implementation might be easier than using
>> >VIRTIO_NET_F_MRG_RXBUF. But either one is fine with me.
>> >Any preference? Thanks.
>>
>> This is very similar to what we discussed with Michael. He pointed 
>> out
>> that it could be complicated and we could have several problems.
>>
>> For example, we should also provide an ID to prevent different 
>> fragments
>> from overlapping. Also we might have problems handling different 
>> flows
>> at the same time.
>>
>> Mergable buffers allow us to avoid these problems and also bring
>> advantages for the other types of traffic (stream, seqpacket).
>>
>> It also allows us to use a single header for the packet and all its
>> fragments.
>>
>> So IMHO, if there are no significant issues, the best way would be to
>> implement mergeable buffers in vsock,
>> I think there are only advantages to using this feature.
>
>Sure. Got it. I was thinking only about dgram, which is simpler than
>stream and seqpacket. For those two, they will have issues as you
>just mentioned.
>
>Also, just to make sure. For steam and seqpacket, supporting
>mergeable buffers is mainly for performance improvements,
>right? Or to save memory? I think functionally, they will be the
>same with or without
>mergeable buffers.

Yes, right!

> For dgram, the maximum supported packet size
>is increased when using MRG_RXBUF if the rx buf size is fixed,
>and it can save lots of memory.
>
>I am a little bit confused about the motivation to support mergeable
>buffers for stream and seqpacket. Could you remind me again? Sorry
>that if it was already mentioned in the old emails.

We can save the header overhead, using a single header for the entire 
"big" packet.

For example, in the current implementation, if the host has a 64KB 
buffer to send to the guest with a stream socket, must split it into 16 
packets, using a header for each fragment. With mergable buffers, we 
would save the extra header for each fragment by using a single initial 
header specifying the number of descriptors used.

>
>We could only support it on dgram since dgram has its own virtqueues.

Maybe for the initial implementation is fine, then we can add support 
also for other types.

Please, keep this in mind, so it will be easier to reuse it for other 
types.

>
>btw, my company email system automatically adds [External] to
>these emails, and I meant to remove it manually when I reply,
>but forgot to do that sometimes, so the email threading may not
>be very accurate.
>Sorry about that.

Don't worry :-)

Thanks,
Stefano

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
