Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 437CBEB64D9
	for <virtualization@archiver.kernel.org>; Tue, 27 Jun 2023 08:01:32 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id B757A60792;
	Tue, 27 Jun 2023 08:01:31 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org B757A60792
Authentication-Results: smtp3.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=Ik1N6zEH
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id WhA6X2vz2vM4; Tue, 27 Jun 2023 08:01:30 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 19E0C60E02;
	Tue, 27 Jun 2023 08:01:30 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 19E0C60E02
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id E8604C007C;
	Tue, 27 Jun 2023 08:01:29 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id BA16DC0037
 for <virtualization@lists.linux-foundation.org>;
 Tue, 27 Jun 2023 08:01:28 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 86952418FF
 for <virtualization@lists.linux-foundation.org>;
 Tue, 27 Jun 2023 08:01:28 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 86952418FF
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=Ik1N6zEH
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id RwfQmcBwnkd0
 for <virtualization@lists.linux-foundation.org>;
 Tue, 27 Jun 2023 08:01:27 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 98332418B5
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 98332418B5
 for <virtualization@lists.linux-foundation.org>;
 Tue, 27 Jun 2023 08:01:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1687852886;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=oZVrQ3elX4XCNFCp5FYtuzZCCkQ+mBaJA/Ngz6/9n5g=;
 b=Ik1N6zEHugtTkZMHBO8RaSFEYfSdcFwTRy46W6JyZKsdi1KmbBNgH4W5sXxTKcdCO27Rss
 pGYUti0Q8lx1sreQwZFOjuy5J/ZZWUUxx/xn0NQSTV1k23d8k2dm1HqJbyoJLtcche6OB4
 Fe+8/GL3tzNebNsJuZKmM4xBBvWH6u8=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-458-TYVPs2EaNTeE5WvYfH212w-1; Tue, 27 Jun 2023 04:01:24 -0400
X-MC-Unique: TYVPs2EaNTeE5WvYfH212w-1
Received: by mail-ej1-f69.google.com with SMTP id
 a640c23a62f3a-9877da14901so313065466b.1
 for <virtualization@lists.linux-foundation.org>;
 Tue, 27 Jun 2023 01:01:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1687852883; x=1690444883;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=oZVrQ3elX4XCNFCp5FYtuzZCCkQ+mBaJA/Ngz6/9n5g=;
 b=Ji0v8sVopvLnj/rZzVv7GhEhZODCr9d67v2OnR6hi6YlKBCKrfuFNkKr2726Ru0Ebx
 SS5rhVE833rSnjJ5DTnBqQwN+ZM6immkhAg5M//tJ/N+3NltkCMn7kDh093q/eDMKzcA
 Pxalet1fi+KxB7snlInP1jemRmrREs+sm+4xeUYJPbbLz+2KOsgUtV/+uV5hZF69M8cn
 fKQ65WVnLERIYjxQEWsZdr56i/f7CmqLT2jA7NT0JBSBqbnhYgeUnKmGob1teilNviMB
 eFYlRCQ9YAOfodfJJOh5MOSUHKPpoQ1rCgIEgPnbzPNX7CqWshIyHcwb7VrEgK10qwr1
 3zBw==
X-Gm-Message-State: AC+VfDyVp2SKahbZSygY+dLyg0U+pAjeuI4/s/zjlYu+/ffkft2tTwQW
 kzPYQBYHIMz57ec20p/VySI1MirRi19kf77BrAhbGHUCmKCTTlfXoPp8r2/tOWSXCFMFVVG6NGz
 hlFbRmmJ90jhpKBl5m/18Ehr/np/2ZIByprD8kTu0hg==
X-Received: by 2002:a17:907:16a1:b0:988:d1d5:cd5b with SMTP id
 hc33-20020a17090716a100b00988d1d5cd5bmr22462646ejc.75.1687852883137; 
 Tue, 27 Jun 2023 01:01:23 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ7Z0J/vWmfnxp6OJSKZUcEDuPdK0byEs7sKI3sU5hfyvYS5pWlrPir4/Xy8z0GyEbfTC147Zw==
X-Received: by 2002:a17:907:16a1:b0:988:d1d5:cd5b with SMTP id
 hc33-20020a17090716a100b00988d1d5cd5bmr22462601ejc.75.1687852882783; 
 Tue, 27 Jun 2023 01:01:22 -0700 (PDT)
Received: from sgarzare-redhat (host-87-11-6-160.retail.telecomitalia.it.
 [87.11.6.160]) by smtp.gmail.com with ESMTPSA id
 re3-20020a170906d8c300b00977ca5de275sm4307511ejb.13.2023.06.27.01.01.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 27 Jun 2023 01:01:22 -0700 (PDT)
Date: Tue, 27 Jun 2023 10:01:11 +0200
From: Stefano Garzarella <sgarzare@redhat.com>
To: Arseniy Krasnov <avkrasnov@sberdevices.ru>
Subject: Re: [RFC PATCH v4 00/17] vsock: MSG_ZEROCOPY flag support
Message-ID: <vqh472etosyyht53hd3bafvtuaedwhqsuqwdbmfkd6lyvxkkgq@mnp42ujut5ox>
References: <20230603204939.1598818-1-AVKrasnov@sberdevices.ru>
 <kilgxopbdguge4bd6pfdjb3oqzemttwzf4na54xurwl62hi7uc@2njjwuhox3al>
 <352508dd-1ea2-5d2d-9ccf-dfcfbd2bb911@sberdevices.ru>
MIME-Version: 1.0
In-Reply-To: <352508dd-1ea2-5d2d-9ccf-dfcfbd2bb911@sberdevices.ru>
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

On Tue, Jun 27, 2023 at 07:55:58AM +0300, Arseniy Krasnov wrote:
>
>
>On 26.06.2023 19:15, Stefano Garzarella wrote:
>> On Sat, Jun 03, 2023 at 11:49:22PM +0300, Arseniy Krasnov wrote:

[...]

>>>
>>> =A0=A0=A0=A0=A0=A0=A0=A0=A0 LET'S SPLIT PATCHSET TO MAKE REVIEW EASIER
>>>
>>> In v3 Stefano Garzarella <sgarzare@redhat.com> asked to split this patc=
hset
>>> for several parts, because it looks too big for review. I think in this
>>> version (v4) we can do it in the following way:
>>>
>>> [0001 - 0005] - this is preparation for virtio/vhost part.
>>> [0006 - 0009] - this is preparation for AF_VSOCK part.
>>> [0010 - 0013] - these patches allows to trigger logic from the previous
>>> =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 two parts.
>>> [0014 - rest] - updates for doc, tests, utils. This part doesn't touch
>>> =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 kernel code and looks not cr=
itical.
>>
>> Yeah, I like this split, but I'd include 14 in the (10, 13) group.
>>
>> I have reviewed most of them and I think we are well on our way :-)
>> I've already seen that Bobby suggested changes for v5, so I'll review
>> that version better.
>>
>> Great work so far!
>
>Hello Stefano!

Hi Arseniy :-)

>
>Thanks for review! I left some questions, but most of comments are clear
>for me. So I guess that idea of split is that I still keep all patches in
>a big single patchset, but preserve structure described above and we will
>do review process step by step according split?
>
>Or I should split this patchset for 3 separated sets? I guess this will be
>more complex to review...

If the next is still RFC, a single series is fine.

Thanks,
Stefano

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
