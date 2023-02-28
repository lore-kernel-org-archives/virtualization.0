Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 85C9AC64EC7
	for <virtualization@archiver.kernel.org>; Tue, 28 Feb 2023 10:23:55 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 0DB8041878;
	Tue, 28 Feb 2023 10:23:55 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 0DB8041878
Authentication-Results: smtp4.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=UIPDcC3P
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id LHAa-yYR1m1Z; Tue, 28 Feb 2023 10:23:43 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 21C5540925;
	Tue, 28 Feb 2023 10:23:42 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 21C5540925
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id E08D4C0032;
	Tue, 28 Feb 2023 10:23:41 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 98B62C002B
 for <virtualization@lists.linux-foundation.org>;
 Tue, 28 Feb 2023 10:23:40 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 5FA4581EF2
 for <virtualization@lists.linux-foundation.org>;
 Tue, 28 Feb 2023 10:23:40 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 5FA4581EF2
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=UIPDcC3P
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id YPEE9VGJ3698
 for <virtualization@lists.linux-foundation.org>;
 Tue, 28 Feb 2023 10:23:39 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org CF05581EBE
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp1.osuosl.org (Postfix) with ESMTPS id CF05581EBE
 for <virtualization@lists.linux-foundation.org>;
 Tue, 28 Feb 2023 10:23:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1677579817;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=OvKhGeO2umMXGqYN12idGLqKCRqabz3Yc1oP/HPSiS4=;
 b=UIPDcC3P/Rr8JkA1MGnvQ9PMNPl9SGcgU2mqBlM8dn58fG9BuKNTeWTcgXIoq8wgDHVvF7
 p9UUd9Xhfju0JmyL5cFJiwiF/fXWVLR9pLbxp2YzQpo+GAdMwKebP0ITj55ERv0r7EchHm
 oqpeS71UFUS6OS8C3/9PCgq6AEAiaFw=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-223-iUb5jAbNNreaspZOtaRQug-1; Tue, 28 Feb 2023 05:23:34 -0500
X-MC-Unique: iUb5jAbNNreaspZOtaRQug-1
Received: by mail-wm1-f69.google.com with SMTP id
 n27-20020a05600c3b9b00b003e9ca0f4677so4067325wms.8
 for <virtualization@lists.linux-foundation.org>;
 Tue, 28 Feb 2023 02:23:34 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=OvKhGeO2umMXGqYN12idGLqKCRqabz3Yc1oP/HPSiS4=;
 b=BztpgHHUekIFptvs3tvWECmDL3RR54kE36V0pQNVPaYo1pV5wjrfrL6f2/a7tOusPT
 hDVdBh63RCnCcZMoftkhT/fwQEsE10/7eturBBnM0S2zO2JsYfcnR0vd5WSd4Uo3F/eh
 LNu2MeMqfbZq+A6eFMK687lmyNjLvQ9ZiyUKvUtpMDIXT1COHFeCZ1ThHhfq+Vlas3SV
 5CGHYuVY1H2jJHA1Tu/9d31C8EyHG5Bhe2ViBDSxwAfsUm0QfHKFPF2E8hbhfSwcoEBs
 a9+O9JGnuEQ1Hv69PAtLFTrKNyG0vppDnh6v1spEW2RvHmd+g/FHzJram1oznXSqvDnM
 roFw==
X-Gm-Message-State: AO0yUKU5KxoswNAT9BMlNDeR11e6ReZdhOFNoEJbOeZyqv9h4gUZI8Sr
 V93LiASD8ee2p7SR7e2arws1k+9TvJiYqIcV8wC4zWDeU+RLfA0D86U1wjmi72tBtYjOFc4S1y+
 hrtEz1fCCHYhNC+GKjScCeYwuojZ4df6IPnuoLZojIw==
X-Received: by 2002:adf:d0cb:0:b0:2c5:76bd:c0f3 with SMTP id
 z11-20020adfd0cb000000b002c576bdc0f3mr1687633wrh.6.1677579813241; 
 Tue, 28 Feb 2023 02:23:33 -0800 (PST)
X-Google-Smtp-Source: AK7set/QLRsohYSI63gc/ez/L0rUkUtRkTXGbabSm3HO5lIrYqM1UsYTFdGo7UldUJyZ7WQ2iw9+vw==
X-Received: by 2002:adf:d0cb:0:b0:2c5:76bd:c0f3 with SMTP id
 z11-20020adfd0cb000000b002c576bdc0f3mr1687611wrh.6.1677579812804; 
 Tue, 28 Feb 2023 02:23:32 -0800 (PST)
Received: from sgarzare-redhat ([212.43.115.213])
 by smtp.gmail.com with ESMTPSA id
 l15-20020a05600012cf00b002be505ab59asm9508192wrx.97.2023.02.28.02.23.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 28 Feb 2023 02:23:32 -0800 (PST)
Date: Tue, 28 Feb 2023 11:23:23 +0100
From: Stefano Garzarella <sgarzare@redhat.com>
To: Krasnov Arseniy <AVKrasnov@sberdevices.ru>, bobbyeshleman@gmail.com
Subject: Re: [RFC PATCH v1 00/12] vsock: MSG_ZEROCOPY flag support
Message-ID: <20230228102323.7nhlr47vtfongt3b@sgarzare-redhat>
References: <0e7c6fc4-b4a6-a27b-36e9-359597bba2b5@sberdevices.ru>
 <20230216133350.nmutrel7s5fjpkwm@sgarzare-redhat>
 <c5f75607-1dca-39f8-5320-f734203aa8a5@sberdevices.ru>
MIME-Version: 1.0
In-Reply-To: <c5f75607-1dca-39f8-5320-f734203aa8a5@sberdevices.ru>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: Krasnov Arseniy <oxffffaa@gmail.com>,
 "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "virtualization@lists.linux-foundation.org"
 <virtualization@lists.linux-foundation.org>,
 Eric Dumazet <edumazet@google.com>, Stefan Hajnoczi <stefanha@redhat.com>,
 kernel <kernel@sberdevices.ru>, Jakub Kicinski <kuba@kernel.org>,
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
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="iso-8859-1"; Format="flowed"
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>

On Mon, Feb 20, 2023 at 08:59:32AM +0000, Krasnov Arseniy wrote:
>On 16.02.2023 16:33, Stefano Garzarella wrote:
>> Hi Arseniy,
>> sorry for the delay, but I was offline.
>
>Hello! Sure no problem!, i was also offline a little bit so i'm replying
>just now
>
>>
>> On Mon, Feb 06, 2023 at 06:51:55AM +0000, Arseniy Krasnov wrote:
>>> Hello,
>>>
>>> =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0 DESCRIPTION
>>>
>>> this is MSG_ZEROCOPY feature support for virtio/vsock. I tried to follow
>>> current implementation for TCP as much as possible:
>>>
>>> 1) Sender must enable SO_ZEROCOPY flag to use this feature. Without this
>>> =A0 flag, data will be sent in "classic" copy manner and MSG_ZEROCOPY
>>> =A0 flag will be ignored (e.g. without completion).
>>>
>>> 2) Kernel uses completions from socket's error queue. Single completion
>>> =A0 for single tx syscall (or it can merge several completions to single
>>> =A0 one). I used already implemented logic for MSG_ZEROCOPY support:
>>> =A0 'msg_zerocopy_realloc()' etc.
>>
>> I will review for the vsock point of view. Hope some net maintainers can
>> comment about SO_ZEROCOPY.
>>
>> Anyway I think is a good idea to keep it as close as possible to the TCP
>> implementation.
>>
>>>
>>> Difference with copy way is not significant. During packet allocation,
>>> non-linear skb is created, then I call 'get_user_pages()' for each page
>>> from user's iov iterator (I think i don't need 'pin_user_pages()' as
>>
>> Are these pages exposed to the host via virtqueues? If so, I think we
>> should pin them. What happens if the host accesses them but these pages
>> have been unmapped?
>
>Yes, user pages with data will be used by the virtio device.
>'pin' - You mean use 'pin_user_pages()'? Unmapped - You mean guest
> will unmap it, while host must access it to copy packet? Such pages
> have incremented refcount by 'get_user_pages()', so page is locked
> and memory and will be locked until host finishes copying data.

Yep, I got it while reviewing patch 7 ;-)

> I think it is better to discuss things related to 'get/pin_user_pages()'
> in one place, for example in 07/12 where this function is called.

Agree!

>
>>
>>> there is no backing storage for these pages) and add each returned page
>>> to the skb as fragment. There are also some updates for vhost and guest
>>> parts of transport - in both cases i've added handling of non-linear skb
>>> for virtio part. vhost copies data from such skb to the guest's rx virt=
io
>>> buffers. In the guest, virtio transport fills virtio queue with pages
>>> from skb.
>>>
>>> I think doc in Documentation/networking/msg_zerocopy.rst could be also
>>> updated in next versions.
>>
>> Yep, good idea.
>
>Ack, i'll do it in v2.
>
>>
>>>
>>> This version has several limits/problems:
>>>
>>> 1) As this feature totally depends on transport, there is no way (or it
>>> =A0 is difficult) to check whether transport is able to handle it or not
>>> =A0 during SO_ZEROCOPY setting. Seems I need to call AF_VSOCK specific
>>> =A0 setsockopt callback from setsockopt callback for SOL_SOCKET, but th=
is
>>> =A0 leads to lock problem, because both AF_VSOCK and SOL_SOCKET callback
>>> =A0 are not considered to be called from each other. So in current vers=
ion
>>> =A0 SO_ZEROCOPY is set successfully to any type (e.g. transport) of
>>> =A0 AF_VSOCK socket, but if transport does not support MSG_ZEROCOPY,
>>> =A0 tx routine will fail with EOPNOTSUPP.
>>
>> I'll take a look, but if we have no alternative, I think it's okay to
>> make tx fail.>
>
>Thanks
>
>>>
>>> 2) When MSG_ZEROCOPY is used, for each tx system call we need to enqueue
>>> =A0 one completion. In each completion there is flag which shows how tx
>>> =A0 was performed: zerocopy or copy. This leads that whole message must
>>> =A0 be send in zerocopy or copy way - we can't send part of message with
>>> =A0 copying and rest of message with zerocopy mode (or vice versa). Now,
>>> =A0 we need to account vsock credit logic, e.g. we can't send whole data
>>> =A0 once - only allowed number of bytes could sent at any moment. In ca=
se
>>> =A0 of copying way there is no problem as in worst case we can send sin=
gle
>>> =A0 bytes, but zerocopy is more complex because smallest transmission
>>> =A0 unit is single page. So if there is not enough space at peer's side
>>> =A0 to send integer number of pages (at least one) - we will wait, thus
>>> =A0 stalling tx side. To overcome this problem i've added simple rule -
>>> =A0 zerocopy is possible only when there is enough space at another side
>>> =A0 for whole message (to check, that current 'msghdr' was already used
>>> =A0 in previous tx iterations i use 'iov_offset' field of it's iov iter=
).
>>
>> I see the problem and I think your approach is the right one.
>>
>>>
>>> 3) loopback transport is not supported, because it requires to implement
>>> =A0 non-linear skb handling in dequeue logic (as we "send" fragged skb
>>> =A0 and "receive" it from the same queue). I'm going to implement it in
>>> =A0 next versions.
>>
>> loopback is useful for testing and debugging, so it would be great to
>> have the support, but if it's too complicated, we can do it later.
>>
>
>Ok, i'll implement it in v2.
>
>>>
>>> 4) Current implementation sets max length of packet to 64KB. IIUC this
>>> =A0 is due to 'kmalloc()' allocated data buffers. I think, in case of
>>
>> Yep, I think so.
>> When I started touching this code, the limit was already there.
>> As you said, I think it was introduced to have a limit on (host/device
>> side?) allocation, but buf_alloc might be enough, so maybe we could
>> also remove it for copy mode.
>> The only problem I see is compatibility with old devices/drivers, so
>> maybe we need a feature in the spec to say the limit is gone, or have a
>> field in the virtio config space where the device specifies its limit
>> (for the driver, the limit is implicitly that of the buffer allocated
>> and put in the virtqueue).
>>
>> This reminded me that Laura had proposed something similar before,
>> maybe we should take it up again:
>> https://markmail.org/message/3el4ckeakfilg5wo
>>
>>> =A0 MSG_ZEROCOPY this value could be increased, because 'kmalloc()' is
>>> =A0 not touched for data - user space pages are used as buffers. Also
>>> =A0 this limit trims every message which is > 64KB, thus such messages
>>> =A0 will be send in copy mode due to 'iov_offset' check in 2).
>>
>> The host still needs to allocate and copy, so maybe the limitation
>> could be to avoid large allocations in the host, but actually the host
>> can use vmalloc because it doesn't need them to be contiguous.
>>
>
>Hmmm, I think it is possible to solve this situation in the following
>way - i can keep limitation for 64KB for copy mode, and remove it for
>zero copy, but I'll limit each packet size to 64KB(of course technically
>it is not exactly 64KB, it is min(max packet size, MAX_SKB_FRAGS * PAGE_SI=
ZE)
>where max packet size is 64Kb, but for simplicity  let's call this limit 6=
4Kb:) ).
>E.g. when zerocopy transmission needs to send for example 129Kb(of course
>peer's free space is big enough and this check is passed), I'll won't trim
>129Kb to 64Kb + 64Kb + 1Kb in the current manner - by returning to af_vsoc=
k.c
>after sending every skb. I'll alloc several skbs, (3 in this case - 64Kb +=
 64Kb + 1Kb)
>in single call to the transport. Completion arg will be attached
>only to the last one skb, and send these 3 skbs. Host still processes
>64Kb(let it be 64Kb for simplicity again :) ) packets - no big allocations.

Make sense to me!

>Moreover, i think that this logic could be a little optimization for
>copy mode - why we allocate single skb and always return to af_vsock.c?

@Bobby, can you help us here?

>May be we can iterate needed number of skbs in the loop and send them.

Yep, I think is doable.

>
>Also about vmalloc(), IIUC there is already this idea which replaces 'kmal=
loc()'
>to 'kvmalloc()'.

Yep, I think it is already merged:
0e3f72931fc4 ("vhost/vsock: Use kvmalloc/kvfree for larger packets.")

But this is in the vhost transport (device emulation running in the =

host), where we don't need that the pages are pinned.

>
>>>
>>> =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0 PERFORMANCE
>>>
>>> Performance: it is a little bit tricky to compare performance between
>>> copy and zerocopy transmissions. In zerocopy way we need to wait when
>>> user buffers will be released by kernel, so it something like synchrono=
us
>>> path (wait until device driver will process it), while in copy way we
>>> can feed data to kernel as many as we want, don't care about device
>>> driver. So I compared only time which we spend in 'sendmsg()' syscall.
>>> Also there is limit from 4) above so max buffer size is 64KB. I've
>>> tested this patchset in the nested VM, but i think for V1 it is not a
>>> big deal.
>>>
>>> Sender:
>>> ./vsock_perf --sender <CID> --buf-size <buf size> --bytes 60M [--zc]
>>>
>>> Receiver:
>>> ./vsock_perf --vsk-size 256M
>>>
>>> Number in cell is seconds which senders spends inside tx syscall.
>>>
>>> Guest to host transmission:
>>>
>>> *-------------------------------*
>>> |=A0=A0=A0=A0=A0=A0=A0=A0=A0 |=A0=A0=A0=A0=A0=A0=A0=A0 |=A0=A0=A0=A0=A0=
=A0=A0=A0=A0 |
>>> | buf size |=A0=A0 copy=A0 | zerocopy |
>>> |=A0=A0=A0=A0=A0=A0=A0=A0=A0 |=A0=A0=A0=A0=A0=A0=A0=A0 |=A0=A0=A0=A0=A0=
=A0=A0=A0=A0 |
>>> *-------------------------------*
>>> |=A0=A0 4KB=A0=A0=A0 |=A0 0.26=A0=A0 |=A0=A0 0.042=A0 |
>>> *-------------------------------*
>>> |=A0=A0 16KB=A0=A0 |=A0 0.11=A0=A0 |=A0=A0 0.014=A0 |
>>> *-------------------------------*
>>> |=A0=A0 32KB=A0=A0 |=A0 0.05=A0=A0 |=A0=A0 0.009=A0 |
>>> *-------------------------------*
>>> |=A0=A0 64KB=A0=A0 |=A0 0.04=A0=A0 |=A0=A0 0.005=A0 |
>>> *-------------------------------*
>>>
>>> Host to guest transmission:
>>>
>>> *--------------------------------*
>>> |=A0=A0=A0=A0=A0=A0=A0=A0=A0 |=A0=A0=A0=A0=A0=A0=A0=A0=A0 |=A0=A0=A0=A0=
=A0=A0=A0=A0=A0 |
>>> | buf size |=A0=A0 copy=A0=A0 | zerocopy |
>>> |=A0=A0=A0=A0=A0=A0=A0=A0=A0 |=A0=A0=A0=A0=A0=A0=A0=A0=A0 |=A0=A0=A0=A0=
=A0=A0=A0=A0=A0 |
>>> *--------------------------------*
>>> |=A0=A0 4KB=A0=A0=A0 |=A0=A0 0.049=A0 |=A0=A0 0.034=A0 |
>>> *--------------------------------*
>>> |=A0=A0 16KB=A0=A0 |=A0=A0 0.03=A0=A0 |=A0=A0 0.024=A0 |
>>> *--------------------------------*
>>> |=A0=A0 32KB=A0=A0 |=A0=A0 0.025=A0 |=A0=A0 0.01=A0=A0 |
>>> *--------------------------------*
>>> |=A0=A0 64KB=A0=A0 |=A0=A0 0.028=A0 |=A0=A0 0.01=A0=A0 |
>>> *--------------------------------*
>>>
>>> If host fails to send data with "Cannot allocate memory", check value
>>> /proc/sys/net/core/optmem_max - it is accounted during completion skb
>>> allocation.
>>>
>>> Zerocopy is faster than classic copy mode, but of course it requires
>>> specific architecture of application due to user pages pinning, buffer
>>> size and alignment. In next versions i'm going to fix 64KB barrier to
>>> perform tests with bigger buffer sizes.
>>
>> Yep, I see.
>> Adjusting vsock_perf to compare also Gbps (can io_uring helps in this
>> case to have more requests in-flight?) would be great.
>>
>
>Yes, i'll add Gbps. Also I thought about adding io_uring test to
>the current test suite because io_uring also have MSG_ZEROCOPY
>type of request, and interesting thing is that io_uring uses it's
>own already allocated uarg.

Cool!

>
>>>
>>> =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0 TESTING
>>>
>>> This patchset includes set of tests for MSG_ZEROCOPY feature. I tried to
>>> cover new code as much as possible so there are different cases for
>>> MSG_ZEROCOPY transmissions: with disabled SO_ZEROCOPY and several io
>>> vector types (different sizes, alignments, with unmapped pages).
>>
>> Great! Thanks for adding the tests!
>>
>> I'll go through the patches between today and Monday.
>> Sorry again for taking so long!
>
>Sure, Thanks for review! I think we are not hurry :)

Yep, thank you for this work!

Stefano

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
