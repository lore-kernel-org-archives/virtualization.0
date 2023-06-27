Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F04EDEB64DD
	for <virtualization@archiver.kernel.org>; Tue, 27 Jun 2023 07:53:41 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 8A72281261;
	Tue, 27 Jun 2023 07:53:41 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 8A72281261
Authentication-Results: smtp1.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=UAD+ri7l
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Tfx1iAc722fG; Tue, 27 Jun 2023 07:53:40 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 0D1008125B;
	Tue, 27 Jun 2023 07:53:40 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 0D1008125B
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id E0993C007C;
	Tue, 27 Jun 2023 07:53:39 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 13EF4C0037
 for <virtualization@lists.linux-foundation.org>;
 Tue, 27 Jun 2023 07:53:39 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id DF341416C9
 for <virtualization@lists.linux-foundation.org>;
 Tue, 27 Jun 2023 07:53:38 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org DF341416C9
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=UAD+ri7l
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id Xl0N05bnmMrW
 for <virtualization@lists.linux-foundation.org>;
 Tue, 27 Jun 2023 07:53:37 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 8968F416C3
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 8968F416C3
 for <virtualization@lists.linux-foundation.org>;
 Tue, 27 Jun 2023 07:53:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1687852416;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=IaGOS9wkr6YWqK+5U8u6i1zG6qs2tTQ6/raZM0kVnbg=;
 b=UAD+ri7lqzMasKsN4qgFRePCLP1FEU5lwOH2koBOF16zghLlDLd/+D3rgcoOZquke/EBvt
 Xe8oGOVH2d8xibn2UMbB9YeWEijy7yUHY70dvQ6nKujSk9qwQ7zffnDFynzJvwH+Bo8U56
 HIcQZdfUm/3Zsouqomv7NzZWsTGqJEQ=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-411-N5RNyoadMAav9tPUPaUwnA-1; Tue, 27 Jun 2023 03:53:34 -0400
X-MC-Unique: N5RNyoadMAav9tPUPaUwnA-1
Received: by mail-ej1-f70.google.com with SMTP id
 a640c23a62f3a-989249538a1so225685766b.1
 for <virtualization@lists.linux-foundation.org>;
 Tue, 27 Jun 2023 00:53:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1687852413; x=1690444413;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=IaGOS9wkr6YWqK+5U8u6i1zG6qs2tTQ6/raZM0kVnbg=;
 b=jWBpYh9+MBvH/8jbTMM5W++biwtN6Ou4+iWG7CLEKV58QF+O4XlRKH8cPaO5wxSghc
 72soJXeMydsRwJOVHg2Ys8P0y1WZiVfaPfr9pPs3Z+ivA5T9q4kENs49XFGHRHiRj+zU
 jj3cJQWPQ5d2fwURSLwUF3syWeZ6A0lM1FYOeTZdxdT6afdX1FvzH0HGjLQroivkzaY2
 MlPJQVltb2NvXcoY1558PXLGTKN4pAPgkyxAmFUuSjQZSyRmDbKyypbfGvaoJRogiU7z
 LaRvU5TF3E7cqjdoaB93Wa9buFODjl7n1PjMzwAChSM5b/erBH+PC/L1KSG91Mz5+dHL
 RSig==
X-Gm-Message-State: AC+VfDzxrtNwg4kRkGZwxPITw+0auA4Aq8LgQmQducGxLIt016mK/QHl
 L/gqlLfTR4G2fW+4nxUln+cgp0L0ktiVM9kLFLMah6mmtvV1GP49gG9ImaH+42Mr3UDTCGdMbV4
 d7EKnAig7eSIpUUwCjUVpyeADY7z4tTIA5mi4KiOCyg==
X-Received: by 2002:a17:906:974f:b0:989:21e4:6c6e with SMTP id
 o15-20020a170906974f00b0098921e46c6emr15445246ejy.53.1687852413616; 
 Tue, 27 Jun 2023 00:53:33 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ7iZHQ4sT71AvDVVWRhT6FBmJw3cWaMNmCzSmG2L5gutVyEA42mOg+6M3+BcIvlFY1BUoU07A==
X-Received: by 2002:a17:906:974f:b0:989:21e4:6c6e with SMTP id
 o15-20020a170906974f00b0098921e46c6emr15445236ejy.53.1687852413286; 
 Tue, 27 Jun 2023 00:53:33 -0700 (PDT)
Received: from sgarzare-redhat (host-87-11-6-160.retail.telecomitalia.it.
 [87.11.6.160]) by smtp.gmail.com with ESMTPSA id
 r21-20020a1709067fd500b00988781076e2sm4235786ejs.78.2023.06.27.00.53.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 27 Jun 2023 00:53:32 -0700 (PDT)
Date: Tue, 27 Jun 2023 09:53:30 +0200
From: Stefano Garzarella <sgarzare@redhat.com>
To: Arseniy Krasnov <avkrasnov@sberdevices.ru>
Subject: Re: [RFC PATCH v4 06/17] vsock: check error queue to set EPOLLERR
Message-ID: <pnbag2axu2uy7w2wrgiljutr3hifo3rltvkkc46wlrmhwzqr5b@pgaqr2m3iwof>
References: <20230603204939.1598818-1-AVKrasnov@sberdevices.ru>
 <20230603204939.1598818-7-AVKrasnov@sberdevices.ru>
 <rg3qxgiqqi5ltt4jcf3k5tcnynh2so5ascvrte4gywcfffusv4@qjz3tkumeq7g>
 <94a133e5-a180-a9b5-91cb-c0ca44af35ea@sberdevices.ru>
MIME-Version: 1.0
In-Reply-To: <94a133e5-a180-a9b5-91cb-c0ca44af35ea@sberdevices.ru>
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

On Tue, Jun 27, 2023 at 07:44:25AM +0300, Arseniy Krasnov wrote:
>
>
>On 26.06.2023 19:04, Stefano Garzarella wrote:
>> On Sat, Jun 03, 2023 at 11:49:28PM +0300, Arseniy Krasnov wrote:
>>> If socket's error queue is not empty, EPOLLERR must be set. Otherwise,
>>> reader of error queue won't detect data in it using EPOLLERR bit.
>>>
>>> Signed-off-by: Arseniy Krasnov <AVKrasnov@sberdevices.ru>
>>> ---
>>> net/vmw_vsock/af_vsock.c | 2 +-
>>> 1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> This patch looks like it can go even without this series.
>>
>> Is it a fix? Should we add a fixes tag?
>
>Yes, it is fix and I can exclude it from this set to reduce number
>of patches, but there is no reproducer for this without MSG_ZEROCOPY
>support - at this moment this feature is the only user of error queue
>for AF_VSOCK.

Okay, so it's fine to keep it here, but please mention in the comment =

that without MSG_ZEROCOPY it can't be reproduced.

That way we know that we don't have to backport into the stable =

branches.

Thanks,
Stefano

>
>Thanks, Arseniy
>
>>
>> Thanks,
>> Stefano
>>
>>>
>>> diff --git a/net/vmw_vsock/af_vsock.c b/net/vmw_vsock/af_vsock.c
>>> index efb8a0937a13..45fd20c4ed50 100644
>>> --- a/net/vmw_vsock/af_vsock.c
>>> +++ b/net/vmw_vsock/af_vsock.c
>>> @@ -1030,7 +1030,7 @@ static __poll_t vsock_poll(struct file *file, str=
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
