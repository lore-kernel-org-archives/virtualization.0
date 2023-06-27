Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AA415EB64D9
	for <virtualization@archiver.kernel.org>; Tue, 27 Jun 2023 08:03:56 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 4D3E560E89;
	Tue, 27 Jun 2023 08:03:56 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 4D3E560E89
Authentication-Results: smtp3.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=RW4TnC4E
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id WsvhS-8Ghq8h; Tue, 27 Jun 2023 08:03:55 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp3.osuosl.org (Postfix) with ESMTPS id AC78F61167;
	Tue, 27 Jun 2023 08:03:54 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org AC78F61167
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 97157C0DD5;
	Tue, 27 Jun 2023 08:03:54 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id B19EDC0037
 for <virtualization@lists.linux-foundation.org>;
 Tue, 27 Jun 2023 08:03:52 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 99E2E8134F
 for <virtualization@lists.linux-foundation.org>;
 Tue, 27 Jun 2023 08:03:52 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 99E2E8134F
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=RW4TnC4E
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id bRT3g66VRzmC
 for <virtualization@lists.linux-foundation.org>;
 Tue, 27 Jun 2023 08:03:52 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org D05088132C
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp1.osuosl.org (Postfix) with ESMTPS id D05088132C
 for <virtualization@lists.linux-foundation.org>;
 Tue, 27 Jun 2023 08:03:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1687853030;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=lP7TnuDcLltzpIl6PbyCFq5YcrBT0OHcqbbRWvHt8GI=;
 b=RW4TnC4E5LCx3x8jpYi27WVpSHJG+1CcApBxx4BMAJOasWaRveZz/jGk0nLb6HCcNqUej1
 KC11VZG+leB0X5BZtzONwlBpMBtdbKDENYwcoM869ezju359wW+Z7YdfEsHu9MAhhrhFft
 1LJq7LQC/5NgosQ4foCqSg2wPBBxO6k=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-64-h-nXMOQmPeCv5u5wDxeG7w-1; Tue, 27 Jun 2023 04:03:48 -0400
X-MC-Unique: h-nXMOQmPeCv5u5wDxeG7w-1
Received: by mail-ej1-f69.google.com with SMTP id
 a640c23a62f3a-94a348facbbso247374966b.1
 for <virtualization@lists.linux-foundation.org>;
 Tue, 27 Jun 2023 01:03:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1687852720; x=1690444720;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=lP7TnuDcLltzpIl6PbyCFq5YcrBT0OHcqbbRWvHt8GI=;
 b=ihShV1ORmLt+OmyhpjqRjN19g7QZh97K0psAUpxwejxpR7kBk+fYgojj92rifG4BL/
 H6wTdLO5yYg+g0UXhtOdLSeXJiR+z5/eydST/coiDuAVP8tZ6tvXgTX3qgcZeFcgxGLX
 ReiAvoFJpWtkX63YgxBQl8QP/CXatt14ztndApnbY/x+7XYNg3lvjbQ59odQnjDFWkzC
 oOte4UejC0blrfF3mHaAYuBAq7cB5FKEbLiJrp4PKxXsb96ish2qiTIIN00CbglKYQQ1
 NAHWMAr7a1fOi9VFi+s6WxzSxvLKL3r5jlMNJXggRKrUjGQIU6iQHe/43MBLEkjptrSN
 5U+g==
X-Gm-Message-State: AC+VfDzGso3CrCNDY8aioac5eX7YY3f0EexU5Mry8DPRqhqJ9iu6umCB
 wFLSnyWr2ZZcz3SMjgSASsTA3AetcPaiVOnUzUUTk/Z5ubk1BHLnYIgpGNY3hCMg4BCGpHvzPvq
 DFH85rE9dTsoGgnVYA8D37V44qqOESpRCZP7N7Lc9xg==
X-Received: by 2002:a17:907:7293:b0:988:d841:7f8d with SMTP id
 dt19-20020a170907729300b00988d8417f8dmr20588110ejc.71.1687852720273; 
 Tue, 27 Jun 2023 00:58:40 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ7Z/tM/gaNroDjLrNnUmnljiX/qH4WmzORhNLz3fZPpTiwtq7Yuehq0VVWZN1uDhbc2Myv9fw==
X-Received: by 2002:a17:907:7293:b0:988:d841:7f8d with SMTP id
 dt19-20020a170907729300b00988d8417f8dmr20588100ejc.71.1687852719994; 
 Tue, 27 Jun 2023 00:58:39 -0700 (PDT)
Received: from sgarzare-redhat (host-87-11-6-160.retail.telecomitalia.it.
 [87.11.6.160]) by smtp.gmail.com with ESMTPSA id
 u13-20020a1709064acd00b00991f773d9c3sm1109508ejt.76.2023.06.27.00.58.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 27 Jun 2023 00:58:39 -0700 (PDT)
Date: Tue, 27 Jun 2023 09:58:37 +0200
From: Stefano Garzarella <sgarzare@redhat.com>
To: Arseniy Krasnov <avkrasnov@sberdevices.ru>
Subject: Re: [RFC PATCH v4 07/17] vsock: read from socket's error queue
Message-ID: <3ek3jnkp7iu6ypc6kq7iarx45bc4hkrmko4mtfqke6nvrjmsiu@mnvs66r2sejc>
References: <20230603204939.1598818-1-AVKrasnov@sberdevices.ru>
 <20230603204939.1598818-8-AVKrasnov@sberdevices.ru>
 <sq5jlfhhlj347uapazqnotc5rakzdvj33ruzqwxdjsfx275m5r@dxujwphcffkl>
 <4d532e35-c03c-fbf6-0744-9397e269750d@sberdevices.ru>
MIME-Version: 1.0
In-Reply-To: <4d532e35-c03c-fbf6-0744-9397e269750d@sberdevices.ru>
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

On Tue, Jun 27, 2023 at 07:49:00AM +0300, Arseniy Krasnov wrote:
>
>
>On 26.06.2023 19:08, Stefano Garzarella wrote:
>> On Sat, Jun 03, 2023 at 11:49:29PM +0300, Arseniy Krasnov wrote:
>>> This adds handling of MSG_ERRQUEUE input flag in receive call. This flag
>>> is used to read socket's error queue instead of data queue. Possible
>>> scenario of error queue usage is receiving completions for transmission
>>> with MSG_ZEROCOPY flag.
>>>
>>> Signed-off-by: Arseniy Krasnov <AVKrasnov@sberdevices.ru>
>>> ---
>>> include/linux/socket.h=A0=A0 | 1 +
>>> net/vmw_vsock/af_vsock.c | 5 +++++
>>> 2 files changed, 6 insertions(+)
>>>
>>> diff --git a/include/linux/socket.h b/include/linux/socket.h
>>> index bd1cc3238851..d79efd026880 100644
>>> --- a/include/linux/socket.h
>>> +++ b/include/linux/socket.h
>>> @@ -382,6 +382,7 @@ struct ucred {
>>> #define SOL_MPTCP=A0=A0=A0 284
>>> #define SOL_MCTP=A0=A0=A0 285
>>> #define SOL_SMC=A0=A0=A0=A0=A0=A0=A0 286
>>> +#define SOL_VSOCK=A0=A0=A0 287
>>
>> Maybe this change should go in another patch where we describe that
>> we need to support setsockopt()
>
>Ok, You mean patch which handles SO_ZEROCOPY option in af_vsock.c as Bobby=
 suggested? No
>problem, but in this case there will be no user for this define there - th=
is option
>(SO_ZEROCOPY) uses SOL_SOCKET level, not SOL_VSOCK.

Got it, so it is fine to leave it here.

Just mention that we are defining SOL_VSOCK in the commit description.

Thanks,
Stefano

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
