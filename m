Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5FDB3E80A9A
	for <virtualization@archiver.kernel.org>; Wed, 27 Sep 2023 07:34:48 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id AB2FE416A2;
	Wed, 27 Sep 2023 07:34:47 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org AB2FE416A2
Authentication-Results: smtp4.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=IV24D3Vc
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 27IFAAyIT557; Wed, 27 Sep 2023 07:34:46 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 6FA2E41602;
	Wed, 27 Sep 2023 07:34:45 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 6FA2E41602
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 44C74C0071;
	Wed, 27 Sep 2023 07:34:45 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 0BA7CC0032
 for <virtualization@lists.linux-foundation.org>;
 Wed, 27 Sep 2023 07:34:44 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id DB41561031
 for <virtualization@lists.linux-foundation.org>;
 Wed, 27 Sep 2023 07:34:43 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org DB41561031
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=IV24D3Vc
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id gPToOs44nqzW
 for <virtualization@lists.linux-foundation.org>;
 Wed, 27 Sep 2023 07:34:43 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 026D86102A
 for <virtualization@lists.linux-foundation.org>;
 Wed, 27 Sep 2023 07:34:42 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 026D86102A
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1695800081;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=VQQkzbHkwKvbUjj0WbZjfuE2ay8gjWtPd5Q/t3WKnBA=;
 b=IV24D3VcLoiVgCKig3J+dzBFej/siypqs85AaMLGAB4Oy7QGIQH96O0N+bF62rkXhWhB/a
 JiXBka6vULcX1LELcjM/akQSwNd4V70u8B0k9nOEnteIf9WquF6nX+lhnVxLOZnCNSPq7F
 U1adPZ1eEKbFQlLMhAL/P14dZAt3Ma0=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-139-qzaGNiD7P-ylICDkT9AHDA-1; Wed, 27 Sep 2023 03:34:40 -0400
X-MC-Unique: qzaGNiD7P-ylICDkT9AHDA-1
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-405535740d2so75893485e9.3
 for <virtualization@lists.linux-foundation.org>;
 Wed, 27 Sep 2023 00:34:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1695800079; x=1696404879;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=VQQkzbHkwKvbUjj0WbZjfuE2ay8gjWtPd5Q/t3WKnBA=;
 b=lSo9U3CL5INxZPjn/PshLFM0WQpdN1+xHNbevccEfORPEMqnamhCpbttm+hvEktglC
 UINB6GNNRGRaMYyRbrYdpIcq3fpge6Ix7Qmyn8ZDiKOubDhdUzDSapC2CdCcBYZFFBXf
 VbVOkp8qO9Zm/952Bplrx8MetFexyy3Sg6J6DbJl+siQWoQFm9rugztVAYAz8eb5O/LN
 s4Egt9vU9RawvnpJdzhQW4rMutQfg5YBTng1Vj6q4USANUCsJrslfaUSxjRfKKjYX91m
 wHCZt0qHStQlj6D2MpWYUAfG8wKQ9khNtTPKg4M2hZZTkixEK1kgG/UyikL2BTmHoPQr
 MyWg==
X-Gm-Message-State: AOJu0Yz22fxn4jr0soJz5oQYGeePCvBXbIWw1A9OFBqbxkhkisT4bX90
 pjMuk9hOkjS0LwHNkJDNcTHPwNHQ+W6W6Pm3m/LFfOQyLBXgGnSkHg5w4c0hSGuIgNjrIqnxJRZ
 cCA3iGf9mhMdn0k0+wkHmnBX7zswqma9EqCd3u7yzTw==
X-Received: by 2002:a05:600c:d5:b0:405:3dbc:8823 with SMTP id
 u21-20020a05600c00d500b004053dbc8823mr1254646wmm.12.1695800079123; 
 Wed, 27 Sep 2023 00:34:39 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFnZmkYOiHS5i6sh7ess3HJP64i/yX4oqCnk7AAXwH/cLkcjTdoQ8TWDw8MmUethf/PRXxO6g==
X-Received: by 2002:a05:600c:d5:b0:405:3dbc:8823 with SMTP id
 u21-20020a05600c00d500b004053dbc8823mr1254628wmm.12.1695800078722; 
 Wed, 27 Sep 2023 00:34:38 -0700 (PDT)
Received: from sgarzare-redhat ([46.222.19.70])
 by smtp.gmail.com with ESMTPSA id
 bh5-20020a05600c3d0500b004055858e7d8sm11631863wmb.7.2023.09.27.00.34.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 27 Sep 2023 00:34:38 -0700 (PDT)
Date: Wed, 27 Sep 2023 09:34:33 +0200
From: Stefano Garzarella <sgarzare@redhat.com>
To: Arseniy Krasnov <avkrasnov@salutedevices.com>
Subject: Re: [PATCH net-next v1 02/12] vsock: read from socket's error queue
Message-ID: <j7e5az5xrrqvvs64dhwaboi5d4ls5aueu3gyeyyasdqmzbsozu@fni6x6mliw3t>
References: <20230922052428.4005676-1-avkrasnov@salutedevices.com>
 <20230922052428.4005676-3-avkrasnov@salutedevices.com>
 <3oys2ouhlkitsjx7q7utp7wkitnnl4kisl2r54wwa2addd644p@jzyu7ubfrcog>
 <ed26b2b7-bafc-a964-00e2-70da66640e46@salutedevices.com>
MIME-Version: 1.0
In-Reply-To: <ed26b2b7-bafc-a964-00e2-70da66640e46@salutedevices.com>
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

On Tue, Sep 26, 2023 at 10:36:58PM +0300, Arseniy Krasnov wrote:
>
>
>On 26.09.2023 15:55, Stefano Garzarella wrote:
>> On Fri, Sep 22, 2023 at 08:24:18AM +0300, Arseniy Krasnov wrote:
>>> This adds handling of MSG_ERRQUEUE input flag in receive call. This flag
>>> is used to read socket's error queue instead of data queue. Possible
>>> scenario of error queue usage is receiving completions for transmission
>>> with MSG_ZEROCOPY flag. This patch also adds new defines: 'SOL_VSOCK'
>>> and 'VSOCK_RECVERR'.
>>>
>>> Signed-off-by: Arseniy Krasnov <avkrasnov@salutedevices.com>
>>> ---
>>> Changelog:
>>> v5(big patchset) -> v1:
>>> =A0* R-b tag removed, due to added defines to 'include/uapi/linux/vsock=
.h'.
>>> =A0=A0 Both 'SOL_VSOCK' and 'VSOCK_RECVERR' are needed by userspace, so
>>> =A0=A0 they were placed to 'include/uapi/linux/vsock.h'. At the same ti=
me,
>>> =A0=A0 the same define for 'SOL_VSOCK' was placed to 'include/linux/soc=
ket.h'.
>>> =A0=A0 This is needed because this file contains SOL_XXX defines for di=
fferent
>>> =A0=A0 types of socket, so it prevents situation when another new SOL_X=
XX
>>> =A0=A0 will use constant 287.
>>>
>>> include/linux/socket.h=A0=A0=A0=A0 | 1 +
>>> include/uapi/linux/vsock.h | 9 +++++++++
>>> net/vmw_vsock/af_vsock.c=A0=A0 | 6 ++++++
>>> 3 files changed, 16 insertions(+)
>>> create mode 100644 include/uapi/linux/vsock.h
>>>
>>> diff --git a/include/linux/socket.h b/include/linux/socket.h
>>> index 39b74d83c7c4..cfcb7e2c3813 100644
>>> --- a/include/linux/socket.h
>>> +++ b/include/linux/socket.h
>>> @@ -383,6 +383,7 @@ struct ucred {
>>> #define SOL_MPTCP=A0=A0=A0 284
>>> #define SOL_MCTP=A0=A0=A0 285
>>> #define SOL_SMC=A0=A0=A0=A0=A0=A0=A0 286
>>> +#define SOL_VSOCK=A0=A0=A0 287
>>>
>>> /* IPX options */
>>> #define IPX_TYPE=A0=A0=A0 1
>>> diff --git a/include/uapi/linux/vsock.h b/include/uapi/linux/vsock.h
>>> new file mode 100644
>>> index 000000000000..b25c1347a3b8
>>> --- /dev/null
>>> +++ b/include/uapi/linux/vsock.h
>>
>> We already have include/uapi/linux/vm_sockets.h
>>
>> Should we include these changes there instead of creating a new header?
>>
>>> @@ -0,0 +1,9 @@
>>> +/* SPDX-License-Identifier: GPL-2.0 WITH Linux-syscall-note */
>>> +#ifndef _UAPI_LINUX_VSOCK_H
>>> +#define _UAPI_LINUX_VSOCK_H
>>> +
>>> +#define SOL_VSOCK=A0=A0=A0 287
>>
>> Why we need to re-define this also here?
>
>Reason of this re-define is that SOL_VSOCK must be exported to userspace, =
so
>i place it to include/uapi/XXX. At the same time include/linux/socket.h co=
ntains
>constants for SOL_XXX and they goes sequentially in this file (e.g. one by=
 one,
>each new value is +1 to the previous). So if I add SOL_VSOCK to include/ua=
pi/XXX
>only, it is possible that someone will add new SOL_VERY_NEW_SOCKET =3D=3D =
287 to
>include/linux/socket.h in future. I think it is not good that two SOL_XXX =
will
>have same value.
>
>For example SOL_RDS and SOL_TIPS uses the same approach - there are two sa=
me defines:
>one in include/uapi/ and another is in include/linux/socket.h

Okay, I was confused, I though socket.h was the uapi one.
If others do the same, it's fine.

But why adding a new vsock.h instead of reusing vm_sockets.h?

>
>>
>> In that case, should we protect with some guards to avoid double
>> defines?
>
>May be:
>
>in include/linux/socket.h
>
>#ifndef SOL_VSOCK
>#define SOL_VSOCK 287
>#endif
>
>But not sure...

Nope, let's follow others definition.

Sorry for the confusion ;-)

>
>>
>>> +
>>> +#define VSOCK_RECVERR=A0=A0=A0 1
>>> +
>>> +#endif /* _UAPI_LINUX_VSOCK_H */
>>> diff --git a/net/vmw_vsock/af_vsock.c b/net/vmw_vsock/af_vsock.c
>>> index d841f4de33b0..4fd11bf34bc7 100644
>>> --- a/net/vmw_vsock/af_vsock.c
>>> +++ b/net/vmw_vsock/af_vsock.c
>>> @@ -110,6 +110,8 @@
>>> #include <linux/workqueue.h>
>>> #include <net/sock.h>
>>> #include <net/af_vsock.h>
>>> +#include <linux/errqueue.h>
>>> +#include <uapi/linux/vsock.h>
>>>
>>> static int __vsock_bind(struct sock *sk, struct sockaddr_vm *addr);
>>> static void vsock_sk_destruct(struct sock *sk);
>>> @@ -2137,6 +2139,10 @@ vsock_connectible_recvmsg(struct socket *sock, s=
truct msghdr *msg, size_t len,
>>> =A0=A0=A0=A0int err;
>>>
>>> =A0=A0=A0=A0sk =3D sock->sk;
>>> +
>>> +=A0=A0=A0 if (unlikely(flags & MSG_ERRQUEUE))
>>> +=A0=A0=A0=A0=A0=A0=A0 return sock_recv_errqueue(sk, msg, len, SOL_VSOC=
K, =

>>> VSOCK_RECVERR);
>>> +
>>> =A0=A0=A0=A0vsk =3D vsock_sk(sk);
>>> =A0=A0=A0=A0err =3D 0;
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
