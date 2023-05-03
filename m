Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 48941C77B75
	for <virtualization@archiver.kernel.org>; Wed,  3 May 2023 13:48:08 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id D762740609;
	Wed,  3 May 2023 13:48:07 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org D762740609
Authentication-Results: smtp2.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=c3dvYglS
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Ts0Qe4GTFcA9; Wed,  3 May 2023 13:48:06 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp2.osuosl.org (Postfix) with ESMTPS id E7C8F41CBC;
	Wed,  3 May 2023 13:48:05 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org E7C8F41CBC
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id BFC3FC0036;
	Wed,  3 May 2023 13:48:05 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 1BAD0C0036
 for <virtualization@lists.linux-foundation.org>;
 Wed,  3 May 2023 13:48:04 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id A5D9241DA6
 for <virtualization@lists.linux-foundation.org>;
 Wed,  3 May 2023 13:48:03 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org A5D9241DA6
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=c3dvYglS
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id zeGqRQ3Jjapp
 for <virtualization@lists.linux-foundation.org>;
 Wed,  3 May 2023 13:48:00 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 1609941BC1
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 1609941BC1
 for <virtualization@lists.linux-foundation.org>;
 Wed,  3 May 2023 13:47:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1683121678;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Ie41DSOUJAU9sN0ZbQyLZdZyXhPxd7Tk89Rx+HAMiRc=;
 b=c3dvYglSYz1RTANnHSY8UbKhB1fUeisnTlOdUopxcZPA+7zpUO6KvkpSN2KPQ+/yB5gW6g
 ohwjuvc+iSEZJrK5eQxlJeQgP8DLInhwd99J690nJ4N3C/LABYOSnfK2KyMzDlpWa9RNiK
 iEOb9sEJc9O4wOqF7OJ9QrBrvNujWXU=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-27-rjpabg6jPpCAQREfPgXmMw-1; Wed, 03 May 2023 09:47:57 -0400
X-MC-Unique: rjpabg6jPpCAQREfPgXmMw-1
Received: by mail-wr1-f72.google.com with SMTP id
 ffacd0b85a97d-30635d18e55so869088f8f.2
 for <virtualization@lists.linux-foundation.org>;
 Wed, 03 May 2023 06:47:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1683121676; x=1685713676;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=Ie41DSOUJAU9sN0ZbQyLZdZyXhPxd7Tk89Rx+HAMiRc=;
 b=VBsbtrdHn5RKklOZuIAmP60b6OVIKRK4hK/pAgOrWb6LoFAQzDyLASyj0eEQKXDU7r
 QS+cDwjvrTYhh1x1lYEgsYG/y3GV8M83S4p6Efe+kh+ShoB7ICXP6QX1TuJPFdO506gS
 2ETmEwVavWkOWlg3bRGcfKEqyGIR1s2qXcFqV8Wqt0Om5NHDMxZiUObcK+6G4O4EyV1y
 UM5hddbN+YMtEyYORiwWF/6rZRO38oXc3XJBNjQpqdIpSoWhq2min3iSC5gMhjn/DGBU
 YIigqFVclE4/dE3sUikDjH//OJrSMpQjSGphxqefKL4uUc3VYxbwnn7BuQyleoh+vI3X
 5Y+Q==
X-Gm-Message-State: AC+VfDzYxQ/MjF/yFQwmEOA1nXIEtuLMCZbZ+kvyIkcemlEmhxld6Oo7
 mMMIOlKbw/OqOVKamRLDlmJYmjgaAp07UO6vFzZSseXZQLqJAVlL5vWk5JUpmxLzEZtxItb422q
 q9L0eLKcON9hpY8xaoaDNX5ASAoPIMNbrCtOPDA7Gbw==
X-Received: by 2002:adf:f785:0:b0:306:36e7:db27 with SMTP id
 q5-20020adff785000000b0030636e7db27mr134493wrp.16.1683121676587; 
 Wed, 03 May 2023 06:47:56 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ6cZH0F+HvzDAV395wIYuXVRV3XvIp16M0hpF34ErYZx+dia96NntoSQ7QRSdTpZboHIQzbpQ==
X-Received: by 2002:adf:f785:0:b0:306:36e7:db27 with SMTP id
 q5-20020adff785000000b0030636e7db27mr134471wrp.16.1683121676209; 
 Wed, 03 May 2023 06:47:56 -0700 (PDT)
Received: from sgarzare-redhat ([185.29.96.107])
 by smtp.gmail.com with ESMTPSA id
 a13-20020a056000100d00b003063c130ef1sm2966147wrx.112.2023.05.03.06.47.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 03 May 2023 06:47:55 -0700 (PDT)
Date: Wed, 3 May 2023 15:47:51 +0200
From: Stefano Garzarella <sgarzare@redhat.com>
To: Arseniy Krasnov <avkrasnov@sberdevices.ru>
Subject: Re: [RFC PATCH v2 00/15] vsock: MSG_ZEROCOPY flag support
Message-ID: <23guh3txkghxpgcrcjx7h62qsoj3xgjhfzgtbmqp2slrz3rxr4@zya2z7kwt75l>
References: <20230423192643.1537470-1-AVKrasnov@sberdevices.ru>
 <i6swadylt57hrtxhpl5ag7s3dks536wg3vxoa7nuu2x37gxsbi@uj7od5ueq6yp>
 <a9ee9ef5-e707-65ff-3128-41d09fbe8655@sberdevices.ru>
MIME-Version: 1.0
In-Reply-To: <a9ee9ef5-e707-65ff-3128-41d09fbe8655@sberdevices.ru>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: Bobby Eshleman <bobby.eshleman@bytedance.com>, kvm@vger.kernel.org,
 "Michael S. Tsirkin" <mst@redhat.com>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org,
 oxffffaa@gmail.com, Eric Dumazet <edumazet@google.com>,
 Stefan Hajnoczi <stefanha@redhat.com>, kernel@sberdevices.ru,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
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
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="iso-8859-1"; Format="flowed"
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>

On Wed, May 03, 2023 at 04:11:59PM +0300, Arseniy Krasnov wrote:
>
>
>On 03.05.2023 15:52, Stefano Garzarella wrote:
>> Hi Arseniy,
>> Sorry for the delay, but I have been very busy.
>
>Hello, no problem!
>
>>
>> I can't apply this series on master or net-next, can you share with me
>> the base commit?
>
>Here is my base:
>https://git.kernel.org/pub/scm/linux/kernel/git/netdev/net-next.git/commit=
/?id=3Db103bab0944be030954e5de23851b37980218f54
>

Thanks, it worked!

>>
>> On Sun, Apr 23, 2023 at 10:26:28PM +0300, Arseniy Krasnov wrote:
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
>>>
>>> Difference with copy way is not significant. During packet allocation,
>>> non-linear skb is created, then I call 'pin_user_pages()' for each page
>>> from user's iov iterator and add each returned page to the skb as fragm=
ent.
>>> There are also some updates for vhost and guest parts of transport - in
>>> both cases i've added handling of non-linear skb for virtio part. vhost
>>> copies data from such skb to the guest's rx virtio buffers. In the gues=
t,
>>> virtio transport fills tx virtio queue with pages from skb.
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
>> Do you plan to fix this in the next versions?
>>
>> If it is too complicated, I think we can have this limitation until we
>> find a good solution.
>>
>
>I'll try to fix it again, but just didn't pay attention on it in v2.
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
>> So, IIUC if MSG_ZEROCOPY is set, but there isn't enough space in the
>> destination we temporarily disable zerocopy, also if MSG_ZEROCOPY is set.
>> Right?
>
>Exactly, user still needs to get completion (because SO_ZEROCOPY is enable=
d and
>MSG_ZEROCOPY flag as used). But completion structure contains information =
that
>there was copying instead of zerocopying.

Got it.

>
>>
>> If it is the case it seems reasonable to me.
>>
>>>
>>> 3) loopback transport is not supported, because it requires to implement
>>> =A0 non-linear skb handling in dequeue logic (as we "send" fragged skb
>>> =A0 and "receive" it from the same queue). I'm going to implement it in
>>> =A0 next versions.
>>>
>>> =A0 ^^^ fixed in v2
>>>
>>> 4) Current implementation sets max length of packet to 64KB. IIUC this
>>> =A0 is due to 'kmalloc()' allocated data buffers. I think, in case of
>>> =A0 MSG_ZEROCOPY this value could be increased, because 'kmalloc()' is
>>> =A0 not touched for data - user space pages are used as buffers. Also
>>> =A0 this limit trims every message which is > 64KB, thus such messages
>>> =A0 will be send in copy mode due to 'iov_offset' check in 2).
>>>
>>> =A0 ^^^ fixed in v2
>>>
>>> =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 P=
ATCHSET STRUCTURE
>>>
>>> Patchset has the following structure:
>>> 1) Handle non-linear skbuff on receive in virtio/vhost.
>>> 2) Handle non-linear skbuff on send in virtio/vhost.
>>> 3) Updates for AF_VSOCK.
>>> 4) Enable MSG_ZEROCOPY support on transports.
>>> 5) Tests/tools/docs updates.
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
>>> driver. So I compared only time which we spend in the 'send()' syscall.
>>> Then if this value will be combined with total number of transmitted
>>> bytes, we can get Gbit/s parameter. Also to avoid tx stalls due to not
>>> enough credit, receiver allocates same amount of space as sender needs.
>>>
>>> Sender:
>>> ./vsock_perf --sender <CID> --buf-size <buf size> --bytes 256M [--zc]
>>>
>>> Receiver:
>>> ./vsock_perf --vsk-size 256M
>>>
>>> G2H transmission (values are Gbit/s):
>>>
>>> *-------------------------------*
>>> |=A0=A0=A0=A0=A0=A0=A0=A0=A0 |=A0=A0=A0=A0=A0=A0=A0=A0 |=A0=A0=A0=A0=A0=
=A0=A0=A0=A0 |
>>> | buf size |=A0=A0 copy=A0 | zerocopy |
>>> |=A0=A0=A0=A0=A0=A0=A0=A0=A0 |=A0=A0=A0=A0=A0=A0=A0=A0 |=A0=A0=A0=A0=A0=
=A0=A0=A0=A0 |
>>> *-------------------------------*
>>> |=A0=A0 4KB=A0=A0=A0 |=A0=A0=A0 3=A0=A0=A0 |=A0=A0=A0 10=A0=A0=A0 |
>>> *-------------------------------*
>>> |=A0=A0 32KB=A0=A0 |=A0=A0=A0 9=A0=A0=A0 |=A0=A0=A0 45=A0=A0=A0 |
>>> *-------------------------------*
>>> |=A0=A0 256KB=A0 |=A0=A0=A0 24=A0=A0 |=A0=A0=A0 195=A0=A0 |
>>> *-------------------------------*
>>> |=A0=A0=A0 1M=A0=A0=A0 |=A0=A0=A0 27=A0=A0 |=A0=A0=A0 270=A0=A0 |
>>> *-------------------------------*
>>> |=A0=A0=A0 8M=A0=A0=A0 |=A0=A0=A0 22=A0=A0 |=A0=A0=A0 277=A0=A0 |
>>> *-------------------------------*
>>>
>>> H2G:
>>>
>>> *-------------------------------*
>>> |=A0=A0=A0=A0=A0=A0=A0=A0=A0 |=A0=A0=A0=A0=A0=A0=A0=A0 |=A0=A0=A0=A0=A0=
=A0=A0=A0=A0 |
>>> | buf size |=A0=A0 copy=A0 | zerocopy |
>>> |=A0=A0=A0=A0=A0=A0=A0=A0=A0 |=A0=A0=A0=A0=A0=A0=A0=A0 |=A0=A0=A0=A0=A0=
=A0=A0=A0=A0 |
>>> *-------------------------------*
>>> |=A0=A0 4KB=A0=A0=A0 |=A0=A0=A0 17=A0=A0 |=A0=A0=A0 11=A0=A0=A0 |
>>
>> Do you know why in this case zerocopy is slower in this case?
>> Could be the cost of pin/unpin pages?
>May be, i think i need to analyze such enormous difference more. Also about
>pin/unpin: i found that there is already implemented function to fill non-=
linear
>skb with pages from user's iov: __zerocopy_sg_from_iter() in net/core/data=
gram.c.
>It uses 'get_user_pages()' instead of 'pin_user_pages()'. May be in my cas=
e it
>is also valid to user 'get_XXX()' instead of 'pin_XXX()', because it is us=
ed by
>TCP MSG_ZEROCOPY and iouring MSG_ZEROCOPY.

If we can reuse them, it will be great!

>
>>
>>> *-------------------------------*
>>> |=A0=A0 32KB=A0=A0 |=A0=A0=A0 30=A0=A0 |=A0=A0=A0 66=A0=A0=A0 |
>>> *-------------------------------*
>>> |=A0=A0 256KB=A0 |=A0=A0=A0 38=A0=A0 |=A0=A0=A0 179=A0=A0 |
>>> *-------------------------------*
>>> |=A0=A0=A0 1M=A0=A0=A0 |=A0=A0=A0 38=A0=A0 |=A0=A0=A0 234=A0=A0 |
>>> *-------------------------------*
>>> |=A0=A0=A0 8M=A0=A0=A0 |=A0=A0=A0 28=A0=A0 |=A0=A0=A0 279=A0=A0 |
>>> *-------------------------------*
>>>
>>> Loopback:
>>>
>>> *-------------------------------*
>>> |=A0=A0=A0=A0=A0=A0=A0=A0=A0 |=A0=A0=A0=A0=A0=A0=A0=A0 |=A0=A0=A0=A0=A0=
=A0=A0=A0=A0 |
>>> | buf size |=A0=A0 copy=A0 | zerocopy |
>>> |=A0=A0=A0=A0=A0=A0=A0=A0=A0 |=A0=A0=A0=A0=A0=A0=A0=A0 |=A0=A0=A0=A0=A0=
=A0=A0=A0=A0 |
>>> *-------------------------------*
>>> |=A0=A0 4KB=A0=A0=A0 |=A0=A0=A0 8=A0=A0=A0 |=A0=A0=A0 7=A0=A0=A0=A0 |
>>> *-------------------------------*
>>> |=A0=A0 32KB=A0=A0 |=A0=A0=A0 34=A0=A0 |=A0=A0=A0 42=A0=A0=A0 |
>>> *-------------------------------*
>>> |=A0=A0 256KB=A0 |=A0=A0=A0 43=A0=A0 |=A0=A0=A0 83=A0=A0=A0 |
>>> *-------------------------------*
>>> |=A0=A0=A0 1M=A0=A0=A0 |=A0=A0=A0 40=A0=A0 |=A0=A0=A0 109=A0=A0 |
>>> *-------------------------------*
>>> |=A0=A0=A0 8M=A0=A0=A0 |=A0=A0=A0 40=A0=A0 |=A0=A0=A0 171=A0=A0 |
>>> *-------------------------------*
>>>
>>> I suppose that huge difference above between both modes has two reasons:
>>> 1) We don't need to copy data.
>>> 2) We don't need to allocate buffer for data, only for header.
>>>
>>> Zerocopy is faster than classic copy mode, but of course it requires
>>> specific architecture of application due to user pages pinning, buffer
>>> size and alignment.
>>>
>>> If host fails to send data with "Cannot allocate memory", check value
>>> /proc/sys/net/core/optmem_max - it is accounted during completion skb
>>> allocation.
>>
>> What the user needs to do? Increase it?
>>
>Yes, i'll update it.
>>>
>>> =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0 TESTING
>>>
>>> This patchset includes set of tests for MSG_ZEROCOPY feature. I tried to
>>> cover new code as much as possible so there are different cases for
>>> MSG_ZEROCOPY transmissions: with disabled SO_ZEROCOPY and several io
>>> vector types (different sizes, alignments, with unmapped pages). I also
>>> run tests with loopback transport and running vsockmon.
>>
>> Thanks for the test again :-)
>>
>> This cover letter is very good, with a lot of details, but please add
>> more details in each single patch, explaining the reason of the changes,
>> otherwise it is very difficult to review, because it is a very big
>> change.
>>
>> I'll do a per-patch review in the next days.
>
>Sure, thanks! In v3 i'm also working on io_uring test, because this thing =
also
>supports MSG_ZEROCOPY, so we can do virtio/vsock + MSG_ZEROCOPY + io_uring.

That would be cool!

Do you want to me to review these patches or it is better to wait for =

v3?

Thanks,
Stefano

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
