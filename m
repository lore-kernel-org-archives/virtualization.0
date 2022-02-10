Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 78AA6C433F5
	for <virtualization@archiver.kernel.org>; Thu, 10 Feb 2022 07:17:58 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 2746860E76;
	Thu, 10 Feb 2022 07:17:58 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id zg9s4BPD_t44; Thu, 10 Feb 2022 07:17:57 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp3.osuosl.org (Postfix) with ESMTPS id AED1860E71;
	Thu, 10 Feb 2022 07:17:56 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 88504C0011;
	Thu, 10 Feb 2022 07:17:56 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 9B658C000B
 for <virtualization@lists.linux-foundation.org>;
 Thu, 10 Feb 2022 07:17:55 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 7CE8340167
 for <virtualization@lists.linux-foundation.org>;
 Thu, 10 Feb 2022 07:17:55 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp4.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id uZR-LdqMGN6O
 for <virtualization@lists.linux-foundation.org>;
 Thu, 10 Feb 2022 07:17:54 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp4.osuosl.org (Postfix) with ESMTPS id A4C8240118
 for <virtualization@lists.linux-foundation.org>;
 Thu, 10 Feb 2022 07:17:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1644477473;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=sTTuT1wpA5V7YCk5otpnqf5l5jYPgeufibvl+UEqn2c=;
 b=ZOxG36gyBnKuGxgtSWrGn7to9do5WTBhQCXpeDzxCc5GeJaMhsUgIzp0mXhL9AL62xNG1Y
 +Au9r/0fa6suYe/u5quKYwAqNTOXoGWDi3ZWQwWLWhpushXLllodPSrH547tkO+9q8JH+C
 HBO0S4+HVMECK3vzqprArbBLhxn/4yM=
Received: from mail-lj1-f199.google.com (mail-lj1-f199.google.com
 [209.85.208.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-642-pMoODRbfODihAfIVtB9BgQ-1; Thu, 10 Feb 2022 02:17:51 -0500
X-MC-Unique: pMoODRbfODihAfIVtB9BgQ-1
Received: by mail-lj1-f199.google.com with SMTP id
 y19-20020a2e9793000000b0023f158d6cc0so2193736lji.10
 for <virtualization@lists.linux-foundation.org>;
 Wed, 09 Feb 2022 23:17:50 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=sTTuT1wpA5V7YCk5otpnqf5l5jYPgeufibvl+UEqn2c=;
 b=o0qBv3oxPk4XJPF6UN7TaIibDG62Jerl8w/pvTew+FNw+BHIxK98xkJItshjkVNXY8
 3cebvrWoUjWCPx2Ewdmr/e6r1QJ60wjMe4fXIWn1OOxzkgLuLRdMlTr5KE25E12jlpce
 dNR54UknoKPrn8kNkzXiZu85XVQO7QiUh1zj7BSjD6qjxzCeVxavcVflwEtdFOkgZtnU
 wxrvofQJBRna21b3jPOV7nmth9NVyXoiAAlvMWiGwAjVgznUVorSjT1kfnkz54X9CQ9n
 cc8JahtSlZHddPEcx1kgWUxW1nV9wLeAUf6BjDwXJAQ1pwTY5ji1DOQuSP+cQbfKjzpo
 7sWg==
X-Gm-Message-State: AOAM531KE4vsveFGKgWQBt5Ez044dZ1VokSVwsPIYmtfBMgKrAvDPzvl
 Y6vtjNMCio+FyE40DK7H1v36savLu6KZ5+UoV66gk90mLdvi6sz7JSzmZhMjgTqvlYPIihZJa7w
 DGxTsNGoOuVK3a36RTJ0Hscu7eWXl3NLLieFI04RAqwTWOunlaXr6TtcKbg==
X-Received: by 2002:a05:6512:3401:: with SMTP id
 i1mr4335990lfr.629.1644477469722; 
 Wed, 09 Feb 2022 23:17:49 -0800 (PST)
X-Google-Smtp-Source: ABdhPJxUZBEMHIZcF/XRpUs2UnPvBf2bdlBn1YAVjX3H39EwXxKO5k6jiLG/IEtXn0SyNmkzAr6Jv4pBMsj4aeyw8JM=
X-Received: by 2002:a05:6512:3401:: with SMTP id
 i1mr4335979lfr.629.1644477469533; 
 Wed, 09 Feb 2022 23:17:49 -0800 (PST)
MIME-Version: 1.0
References: <20220121022438.1042547-1-pizhenwei@bytedance.com>
 <9d07cc9d-b3f1-6fc9-eca1-6124f7baf7e0@bytedance.com>
In-Reply-To: <9d07cc9d-b3f1-6fc9-eca1-6124f7baf7e0@bytedance.com>
From: Jason Wang <jasowang@redhat.com>
Date: Thu, 10 Feb 2022 15:17:38 +0800
Message-ID: <CACGkMEsxnFU5TnPGxU3TjFG6MWZhtCyu93f2qzeAq08ce6VJ_g@mail.gmail.com>
Subject: Re: PING: [PATCH 0/3] Introduce akcipher service for virtio-crypto
To: zhenwei pi <pizhenwei@bytedance.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=jasowang@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Cc: helei.sig11@bytedance.com, mst <mst@redhat.com>,
 linux-kernel <linux-kernel@vger.kernel.org>,
 virtualization <virtualization@lists.linux-foundation.org>,
 linux-crypto@vger.kernel.org
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>

On Thu, Feb 10, 2022 at 2:58 PM zhenwei pi <pizhenwei@bytedance.com> wrote:
>
> PING!

I think it would be helpful to get ack/reviewing from crypto gurus.
Maybe Herbert?

Thanks

>
> PS: Please ignore the warning from kernel test robot, I'll fix it in
> next version.
>
> On 1/21/22 10:24 AM, zhenwei pi wrote:
> > Introduce akcipher service, implement RSA algorithm, and a minor fix.
> >
> > zhenwei pi (3):
> >    virtio_crypto: Introduce VIRTIO_CRYPTO_NOSPC
> >    virtio-crypto: introduce akcipher service
> >    virtio-crypto: implement RSA algorithm
> >
> >   drivers/crypto/virtio/Makefile                |   1 +
> >   .../virtio/virtio_crypto_akcipher_algo.c      | 584 ++++++++++++++++++
> >   drivers/crypto/virtio/virtio_crypto_common.h  |   3 +
> >   drivers/crypto/virtio/virtio_crypto_core.c    |   6 +-
> >   drivers/crypto/virtio/virtio_crypto_mgr.c     |  11 +
> >   include/uapi/linux/virtio_crypto.h            |  98 ++-
> >   6 files changed, 693 insertions(+), 10 deletions(-)
> >   create mode 100644 drivers/crypto/virtio/virtio_crypto_akcipher_algo.c
> >
>
> --
> zhenwei pi
>

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
