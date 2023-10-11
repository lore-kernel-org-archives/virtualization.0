Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CF070CD6E67
	for <virtualization@archiver.kernel.org>; Wed, 11 Oct 2023 12:58:23 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 51B4D41EA0;
	Wed, 11 Oct 2023 12:58:23 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 51B4D41EA0
Authentication-Results: smtp4.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=dZqe64b4
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Um2EMdg-7IQd; Wed, 11 Oct 2023 12:58:22 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 81DC241E9B;
	Wed, 11 Oct 2023 12:58:21 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 81DC241E9B
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 4F8C3C0071;
	Wed, 11 Oct 2023 12:58:21 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 6175AC0032
 for <virtualization@lists.linux-foundation.org>;
 Wed, 11 Oct 2023 12:58:19 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 2F571611EA
 for <virtualization@lists.linux-foundation.org>;
 Wed, 11 Oct 2023 12:58:19 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 2F571611EA
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=dZqe64b4
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id XqB-0yl7F3X3
 for <virtualization@lists.linux-foundation.org>;
 Wed, 11 Oct 2023 12:58:18 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 00F2761021
 for <virtualization@lists.linux-foundation.org>;
 Wed, 11 Oct 2023 12:58:17 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 00F2761021
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1697029097;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=srINTOA9TWB2isXW3Sgrz+IUFVxpno9ZCmYhECMZXz8=;
 b=dZqe64b4crAQlgccazVb4Jym6VGy8BlVBlYOeQ5NhY/pnLk7sqt4qwYWCRSpJN3awPiD/Q
 6nvMfkW2W7mEVdZt/R5xr8CL8JB4nH3CW5GaUqz8UPMWD1vXwor/oLcSH23tpu5jC8gm/d
 XQ5qY9NCBjll6KZZS0uljs9531Eroao=
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-643-lnB8oNqSNpSIxDOK_UsjUw-1; Wed, 11 Oct 2023 08:58:05 -0400
X-MC-Unique: lnB8oNqSNpSIxDOK_UsjUw-1
Received: by mail-qk1-f199.google.com with SMTP id
 af79cd13be357-774382db0a5so742694985a.2
 for <virtualization@lists.linux-foundation.org>;
 Wed, 11 Oct 2023 05:58:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697029085; x=1697633885;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=srINTOA9TWB2isXW3Sgrz+IUFVxpno9ZCmYhECMZXz8=;
 b=F44a+aVuziXs3axxL2bg+/87tdMgJni0KLeFokMZUJsXtEDz8Pd5TM2ujgm9VdinLd
 c4TcWB4ZPFA6oG3NCT9xSF9XrnUIRZN4bv9K4f2yeIwx3E0tADA3D7iCPudwv/1S27N9
 kF5rKt8U4CCHx7YqdL1im5MfUbPocDJlNhFRAGJJqZhhMj1jIJyXRr5a7fMsBxdw51tc
 /utFtkQXgzx3upu0fVcf+ngKSuDLVmxSOzBtnlTHtIrPR62kB2XqhWYEPi91IXmf6MEp
 nx6TrzCnxrkso/4QXl2nPiI19LZCqwzMB6pNlCvh63VVjb/m8PNOwGwIbaGYzQsj76AM
 awyg==
X-Gm-Message-State: AOJu0Yypt2OIAQyPjFGmCFPGpUgVerA1UT0jBZxIVFE/BdR/ewDwxZ0U
 H1OroWmF1Wt5AySs5IPvtmeTlgllmBEYkWtjoDJKlZeg2TD7+6y2hY5Pa3KCh1aughv6F4U0fBt
 Wc3BCdzRzoUORvZowXqoL8n2wvfGUABqoOHaScohuig==
X-Received: by 2002:a05:620a:28c1:b0:772:64b3:889f with SMTP id
 l1-20020a05620a28c100b0077264b3889fmr23924386qkp.29.1697029085394; 
 Wed, 11 Oct 2023 05:58:05 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEat3sMaNphExceyLByW9stmPTXf2ifIIJ9bDX8SUeZpYDbCXHEF5UpdzIbTW2PMO+Wgc/Bfg==
X-Received: by 2002:a05:620a:28c1:b0:772:64b3:889f with SMTP id
 l1-20020a05620a28c100b0077264b3889fmr23924364qkp.29.1697029085125; 
 Wed, 11 Oct 2023 05:58:05 -0700 (PDT)
Received: from sgarzare-redhat (host-79-46-200-251.retail.telecomitalia.it.
 [79.46.200.251]) by smtp.gmail.com with ESMTPSA id
 u16-20020a05620a121000b0076cdc3b5beasm5193811qkj.86.2023.10.11.05.58.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 11 Oct 2023 05:58:04 -0700 (PDT)
Date: Wed, 11 Oct 2023 14:57:57 +0200
From: Stefano Garzarella <sgarzare@redhat.com>
To: Arseniy Krasnov <avkrasnov@salutedevices.com>
Subject: Re: [PATCH net-next v4 00/12] vsock/virtio: continue MSG_ZEROCOPY
 support
Message-ID: <eey4hfz43popgwlwtheapjefzmxea7dk733y3v6aqsrewhq3mq@lcmmhdpwvvzc>
References: <20231010191524.1694217-1-avkrasnov@salutedevices.com>
MIME-Version: 1.0
In-Reply-To: <20231010191524.1694217-1-avkrasnov@salutedevices.com>
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
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>

On Tue, Oct 10, 2023 at 10:15:12PM +0300, Arseniy Krasnov wrote:
>Hello,
>
>this patchset contains second and third parts of another big patchset
>for MSG_ZEROCOPY flag support:
>https://lore.kernel.org/netdev/20230701063947.3422088-1-AVKrasnov@sberdevices.ru/
>
>During review of this series, Stefano Garzarella <sgarzare@redhat.com>
>suggested to split it for three parts to simplify review and merging:
>
>1) virtio and vhost updates (for fragged skbs) (merged to net-next, see
>   link below)
>2) AF_VSOCK updates (allows to enable MSG_ZEROCOPY mode and read
>   tx completions) and update for Documentation/. <-- this patchset
>3) Updates for tests and utils. <-- this patchset
>
>Part 1) was merged:
>https://git.kernel.org/pub/scm/linux/kernel/git/netdev/net-next.git/commit/?id=71b263e79370348349553ecdf46f4a69eb436dc7
>
>Head for this patchset is:
>https://git.kernel.org/pub/scm/linux/kernel/git/netdev/net-next.git/commit/?id=19537e125cc7cf2da43a606f5bcebbe0c9aea4cc
>
>Link to v1:
>https://lore.kernel.org/netdev/20230922052428.4005676-1-avkrasnov@salutedevices.com/
>Link to v2:
>https://lore.kernel.org/netdev/20230930210308.2394919-1-avkrasnov@salutedevices.com/
>Link to v3:
>https://lore.kernel.org/netdev/20231007172139.1338644-1-avkrasnov@salutedevices.com/
>
>Changelog:
> v1 -> v2:
> * Patchset rebased and tested on new HEAD of net-next (see hash above).
> * See per-patch changelog after ---.
> v2 -> v3:
> * Patchset rebased and tested on new HEAD of net-next (see hash above).
> * See per-patch changelog after ---.
> v3 -> v4:
> * Patchset rebased and tested on new HEAD of net-next (see hash above).
> * See per-patch changelog after ---.

I think I fully reviewed the series ;-)

Tests are all passing here, including the new ones. I also added
vsock_perf and vsock_uring_test to my test suite!

So for vsock point of view everything looks fine.

Let's see if there is anything about net (MSG_ZEROCOPY flags, etc.)

Thanks,
Stefano

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
