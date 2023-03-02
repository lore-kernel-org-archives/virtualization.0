Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 91CF6C6FA8E
	for <virtualization@archiver.kernel.org>; Thu,  2 Mar 2023 13:39:01 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 0DD6682043;
	Thu,  2 Mar 2023 13:39:01 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 0DD6682043
Authentication-Results: smtp1.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=Zei47VLs
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id tO_F4isNL9bD; Thu,  2 Mar 2023 13:39:00 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 630AC8203C;
	Thu,  2 Mar 2023 13:38:59 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 630AC8203C
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 43E2FC0035;
	Thu,  2 Mar 2023 13:38:59 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 8CCE4C0032
 for <virtualization@lists.linux-foundation.org>;
 Thu,  2 Mar 2023 13:38:57 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 59CA841832
 for <virtualization@lists.linux-foundation.org>;
 Thu,  2 Mar 2023 13:38:57 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 59CA841832
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=Zei47VLs
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id BahEivcpI8bF
 for <virtualization@lists.linux-foundation.org>;
 Thu,  2 Mar 2023 13:38:56 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 37DF041751
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 37DF041751
 for <virtualization@lists.linux-foundation.org>;
 Thu,  2 Mar 2023 13:38:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1677764334;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=4ZdM39Rwm+APVNSKOoKjEHl8iHMadAxZ6z3x8N7ucVs=;
 b=Zei47VLsm/aZ1PCSOugc/UFqQ6gQTVHaMdniqqbszL7D6MrI9GQoq0ExXOsYgQUQN52a+F
 t4u67ett89Y6Ta96gRc6BWyzavZb+2WA58i9NgqF2YWsDikdj3nKLI7HSH7MulwTpwaZ0u
 puVhKb2Y1zBsNcSj5F53qVI4wkeMI0E=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-141-8-X00b1HMIylliKexu473Q-1; Thu, 02 Mar 2023 08:38:51 -0500
X-MC-Unique: 8-X00b1HMIylliKexu473Q-1
Received: by mail-wm1-f69.google.com with SMTP id
 l23-20020a7bc457000000b003e206cbce8dso5758231wmi.7
 for <virtualization@lists.linux-foundation.org>;
 Thu, 02 Mar 2023 05:38:50 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112; t=1677764330;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=4ZdM39Rwm+APVNSKOoKjEHl8iHMadAxZ6z3x8N7ucVs=;
 b=bvfhPKNQe6fRv3X+BVdpbUMcGujkQg5GO5Ue6zBCLe+B6orRlptqi936K6Y5hOfOue
 /B7mD7lIdgSe+/vDQvN7Lfr15orlhPTsse8VAeSitUVURHpMwtLaWUrEFZ8wVfayHAUc
 cbzwUoQbgiMcSm7m4mzhEnMmR+3yoaLFg3u55HjRlBZVCHMD/WxE6eWtBru99NKdGWJs
 6YDQUqrEXTaG9LS87cV1irEoBFvQA7rRhoTukjjQBb8Bbe2veB6IKxMisi3HOzFpOjiE
 JlqEBi4Vwd/ZRrgV9qkwNg1ezLj0A/NxItjqTuMTxqmrQkJDAr25mzHoOdGWikdyYlvq
 o8HA==
X-Gm-Message-State: AO0yUKVncYvK05AzK6/eFv6j1BuZ9wQBRmy6S6t73hWPSsOo+TPMN5vQ
 Wu/+Rx2Ys4xEl2K+ig7ygkONm5gkqouTVhZch+1imL95zIOlcpMTA778raQx4mmJgG6O5i6i2mH
 Eg/Ll7moAh4zz6rUGJDVXUJz9nI34bF+GdN55uvyniw==
X-Received: by 2002:a5d:56cb:0:b0:2c7:1b3d:1fb9 with SMTP id
 m11-20020a5d56cb000000b002c71b3d1fb9mr7355479wrw.50.1677764329883; 
 Thu, 02 Mar 2023 05:38:49 -0800 (PST)
X-Google-Smtp-Source: AK7set86niPGr89uB0anqISxCl4PutLnmZ7/ReX6UXFcr5ISdGk14j6U7XkC6IbLZNuiZojlUcc9Bw==
X-Received: by 2002:a5d:56cb:0:b0:2c7:1b3d:1fb9 with SMTP id
 m11-20020a5d56cb000000b002c71b3d1fb9mr7355466wrw.50.1677764329563; 
 Thu, 02 Mar 2023 05:38:49 -0800 (PST)
Received: from sgarzare-redhat (c-115-213.cust-q.wadsl.it. [212.43.115.213])
 by smtp.gmail.com with ESMTPSA id
 hg13-20020a05600c538d00b003d9aa76dc6asm3022317wmb.0.2023.03.02.05.38.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 02 Mar 2023 05:38:49 -0800 (PST)
Date: Thu, 2 Mar 2023 14:38:45 +0100
From: Stefano Garzarella <sgarzare@redhat.com>
To: Arseniy Krasnov <avkrasnov@sberdevices.ru>
Subject: Re: [RFC PATCH v1] vsock: check error queue to set EPOLLERR
Message-ID: <20230302133845.hglm4uregjsvrcrc@sgarzare-redhat>
References: <76e7698d-890b-d14d-fa34-da5dd7dd13d8@sberdevices.ru>
 <20230302100621.gk45unegjbqjgpxh@sgarzare-redhat>
 <3b38870c-7606-bf2e-8b17-21a75a1ed751@sberdevices.ru>
MIME-Version: 1.0
In-Reply-To: <3b38870c-7606-bf2e-8b17-21a75a1ed751@sberdevices.ru>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: Bobby Eshleman <bobby.eshleman@bytedance.com>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org,
 Eric Dumazet <edumazet@google.com>, oxffffaa@gmail.com, kernel@sberdevices.ru,
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

On Thu, Mar 02, 2023 at 02:41:29PM +0300, Arseniy Krasnov wrote:
>Hello!
>
>On 02.03.2023 13:06, Stefano Garzarella wrote:
>> On Wed, Mar 01, 2023 at 08:19:45AM +0300, Arseniy Krasnov wrote:
>>> EPOLLERR must be set not only when there is error on the socket, but al=
so
>>> when error queue of it is not empty (may be it contains some control
>>> messages). Without this patch 'poll()' won't detect data in error queue.
>>
>> Do you have a reproducer?
>>
>Dedicated reproducer - no:)
>To reproduce this issue, i used last MSG_ZEROCOPY patches. Completion was =
inserted to
>error queue, and 'poll()' didn't report about it. That was the reason, why=
 this patch
>was included to MSG_ZEROCOPY patchset. But also i think it is better to re=
duce number
>of patches in it(i'm working on v2), so it is good to handle this patch se=
parately.

Yep, absolutely!

>May be one way to reproduce it is use SO_TIMESTAMP(time info about skbuff =
will be queued
>to the error queue). IIUC this feature is implemented at socket layer and =
may work in
>vsock (but i'm not sure). Ok, i'll check it and try to implement reproduce=
r.
>
>IIUC, for future, policy for fixes is "for each fix implement reproducer i=
n vsock_test"?

Nope, but for each fix we should have a Fixes tag.

Usually we use vsock_test to check regressions on features and also the
behaviour of different transports.
My question was more about whether this problem was there before
supporting sk_buff or not, to figure out which Fixes tag to use.

>
>>> This patch is based on 'tcp_poll()'.
>>
>> LGTM but we should add a Fixes tag.
>> It's not clear to me whether the problem depends on when we switched to =
using sk_buff or was pre-existing.
>>
>> Do you have any idea when we introduced this issue?
>git blame shows, that this code exists since first commit to vsock:

Okay, but did we use sk_error_queue before supporting sk_buff?

Anyway, if we are not sure I think we can use the following Fixes tag,
I don't see any issue if we backport this patch also before supporting
sk_buff.

Thanks,
Stefano

>
>commit d021c344051af91f42c5ba9fdedc176740cbd238
>Author: Andy King <acking@vmware.com>
>Date:   Wed Feb 6 14:23:56 2013 +0000
>
>    VSOCK: Introduce VM Sockets
>
>For TCP same logic was added by:
>
>commit 4ed2d765dfaccff5ebdac68e2064b59125033a3b
>Author: Willem de Bruijn <willemb@google.com>
>Date:   Mon Aug 4 22:11:49 2014 -0400
>
>    net-timestamp: TCP timestamping
>
>
>>
>> Thanks,
>> Stefano
>>
>
>Thanks Arseniy
>
>>>
>>> Signed-off-by: Arseniy Krasnov <AVKrasnov@sberdevices.ru>
>>> ---
>>> net/vmw_vsock/af_vsock.c | 2 +-
>>> 1 file changed, 1 insertion(+), 1 deletion(-)
>>>
>>> diff --git a/net/vmw_vsock/af_vsock.c b/net/vmw_vsock/af_vsock.c
>>> index 19aea7cba26e..b5e51ef4a74c 100644
>>> --- a/net/vmw_vsock/af_vsock.c
>>> +++ b/net/vmw_vsock/af_vsock.c
>>> @@ -1026,7 +1026,7 @@ static __poll_t vsock_poll(struct file *file, str=
uct socket *sock,
>>> =A0=A0=A0=A0poll_wait(file, sk_sleep(sk), wait);
>>> =A0=A0=A0=A0mask =3D 0;
>>>
>>> -=A0=A0=A0 if (sk->sk_err)
>>> +=A0=A0=A0 if (sk->sk_err || !skb_queue_empty_lockless(&sk->sk_error_qu=
eue))
>>> =A0=A0=A0=A0=A0=A0=A0 /* Signify that there has been an error on this s=
ocket. */
>>> =A0=A0=A0=A0=A0=A0=A0 mask |=3D EPOLLERR;
>>>
>>> --=A0
>>> 2.25.1
>>>
>>
>

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
