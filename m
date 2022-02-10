Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 71507C433EF
	for <virtualization@archiver.kernel.org>; Thu, 10 Feb 2022 07:23:54 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 11BA240215;
	Thu, 10 Feb 2022 07:23:54 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id elo-kkzMD4G3; Thu, 10 Feb 2022 07:23:53 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTPS id A41FD401E7;
	Thu, 10 Feb 2022 07:23:52 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 79C49C0011;
	Thu, 10 Feb 2022 07:23:52 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 13F4CC000B
 for <virtualization@lists.linux-foundation.org>;
 Thu, 10 Feb 2022 07:23:51 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 00FDB4037C
 for <virtualization@lists.linux-foundation.org>;
 Thu, 10 Feb 2022 07:23:51 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp2.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 1W7p8iCPvaaM
 for <virtualization@lists.linux-foundation.org>;
 Thu, 10 Feb 2022 07:23:50 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 2970440127
 for <virtualization@lists.linux-foundation.org>;
 Thu, 10 Feb 2022 07:23:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1644477829;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=ceq+h6pyLcJE8lDQD7/Uv89e7ZbHt+Awtz79f2IG+wA=;
 b=agxXKbaaDmD53LN9sxSJiC15irRE2wyGGoujmOrtOnVJrQyQYLvePUwm3s86Ykdgz7lMRR
 zKgQl0+56TFKuJzzBmue+7sbe0tRcYh9lBI3KyLV1ayG2nE5nIlPtbaxfJz20I3UAHAMLN
 xZtMeRztvv46E88xTCH2Jafpum17uRM=
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-658-BXcPlkL1N8KkyivMY_Adwg-1; Thu, 10 Feb 2022 02:23:47 -0500
X-MC-Unique: BXcPlkL1N8KkyivMY_Adwg-1
Received: by mail-ed1-f71.google.com with SMTP id
 k5-20020a508ac5000000b00408dec8390aso2790481edk.13
 for <virtualization@lists.linux-foundation.org>;
 Wed, 09 Feb 2022 23:23:47 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=ceq+h6pyLcJE8lDQD7/Uv89e7ZbHt+Awtz79f2IG+wA=;
 b=vE78UOFHoOSFDZptnU3IOJPyG8U32jOGfaaGTdUk3jyhKqYM0RRE65vte0ewm/zx4p
 /GjWJQUNFxMVyXEgbHjm/HBUQJu9fICfN30mWBtMveUgZA93Jt1yU0Dp6avcWw8VQ/L+
 Wrc7zv7Yqsdks5ULgTDnMMUPqmjzco6teBwmzwmTQMfb2Yf5x2Gl/TpXf5UW2cx7wliQ
 YuqcDIM1MOO4L7d2To8WfVi0wHbHg5hzTENvEYM6E16sskePjuP5btZzC+HX9QAz/7/c
 pvzB1+z/KI/iLQh/U691Q66IbwtsBrSXgeG/eGds7ilPOI95wJL6C4bylzEauxwiefdI
 XxSw==
X-Gm-Message-State: AOAM531jRLOCMtUCy0oOqdqqeJF1TnieO6x8HwL0Lo98xbU4S01iVeY6
 5UWkX2loX2oG6nurCqXv1vcW7hGnycOR+LFimkUKAV6hzsvKnJyV0sMBf0d1yC2E9LrfQM6y2eb
 URpqYNO2vM6dRl46l2YtRAnoqbar1Whu4CXiNTgZVrw==
X-Received: by 2002:a05:6402:b1c:: with SMTP id
 bm28mr6857038edb.299.1644477826395; 
 Wed, 09 Feb 2022 23:23:46 -0800 (PST)
X-Google-Smtp-Source: ABdhPJyM9Av3U8CMtb+HUyYhDNUnlTEKQRuxt6w5X3ri0rXAfJGknuvg3b7lxz4SCGRkGFPZ++zLiA==
X-Received: by 2002:a05:6402:b1c:: with SMTP id
 bm28mr6857028edb.299.1644477826241; 
 Wed, 09 Feb 2022 23:23:46 -0800 (PST)
Received: from redhat.com ([2.55.139.162])
 by smtp.gmail.com with ESMTPSA id ck9sm3667076edb.61.2022.02.09.23.23.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 09 Feb 2022 23:23:45 -0800 (PST)
Date: Thu, 10 Feb 2022 02:23:42 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Jason Wang <jasowang@redhat.com>
Subject: Re: PING: [PATCH 0/3] Introduce akcipher service for virtio-crypto
Message-ID: <20220210022221-mutt-send-email-mst@kernel.org>
References: <20220121022438.1042547-1-pizhenwei@bytedance.com>
 <9d07cc9d-b3f1-6fc9-eca1-6124f7baf7e0@bytedance.com>
 <CACGkMEsxnFU5TnPGxU3TjFG6MWZhtCyu93f2qzeAq08ce6VJ_g@mail.gmail.com>
MIME-Version: 1.0
In-Reply-To: <CACGkMEsxnFU5TnPGxU3TjFG6MWZhtCyu93f2qzeAq08ce6VJ_g@mail.gmail.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=mst@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: helei.sig11@bytedance.com, linux-kernel <linux-kernel@vger.kernel.org>,
 zhenwei pi <pizhenwei@bytedance.com>,
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

On Thu, Feb 10, 2022 at 03:17:38PM +0800, Jason Wang wrote:
> On Thu, Feb 10, 2022 at 2:58 PM zhenwei pi <pizhenwei@bytedance.com> wrote:
> >
> > PING!
> 
> I think it would be helpful to get ack/reviewing from crypto gurus.

For sure, but with the robot warning some people might just assume
there's a problem and wait for the next version to review.
Just post v2, don't forget the changelog.

> Maybe Herbert?
> 
> Thanks
> 
> >
> > PS: Please ignore the warning from kernel test robot, I'll fix it in
> > next version.
> >
> > On 1/21/22 10:24 AM, zhenwei pi wrote:
> > > Introduce akcipher service, implement RSA algorithm, and a minor fix.
> > >
> > > zhenwei pi (3):
> > >    virtio_crypto: Introduce VIRTIO_CRYPTO_NOSPC
> > >    virtio-crypto: introduce akcipher service
> > >    virtio-crypto: implement RSA algorithm
> > >
> > >   drivers/crypto/virtio/Makefile                |   1 +
> > >   .../virtio/virtio_crypto_akcipher_algo.c      | 584 ++++++++++++++++++
> > >   drivers/crypto/virtio/virtio_crypto_common.h  |   3 +
> > >   drivers/crypto/virtio/virtio_crypto_core.c    |   6 +-
> > >   drivers/crypto/virtio/virtio_crypto_mgr.c     |  11 +
> > >   include/uapi/linux/virtio_crypto.h            |  98 ++-
> > >   6 files changed, 693 insertions(+), 10 deletions(-)
> > >   create mode 100644 drivers/crypto/virtio/virtio_crypto_akcipher_algo.c
> > >
> >
> > --
> > zhenwei pi
> >

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
