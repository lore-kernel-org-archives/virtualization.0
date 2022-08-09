Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7B11CC19F2D
	for <virtualization@archiver.kernel.org>; Tue,  9 Aug 2022 09:40:54 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 0F82A40573;
	Tue,  9 Aug 2022 09:40:54 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 0F82A40573
Authentication-Results: smtp2.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=gzw7WwVe
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id fKhGXkEzj4Ci; Tue,  9 Aug 2022 09:40:53 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 85E6640151;
	Tue,  9 Aug 2022 09:40:52 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 85E6640151
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 5CE6AC0033;
	Tue,  9 Aug 2022 09:40:52 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 27480C002D
 for <virtualization@lists.linux-foundation.org>;
 Tue,  9 Aug 2022 09:40:51 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id E83CB81769
 for <virtualization@lists.linux-foundation.org>;
 Tue,  9 Aug 2022 09:40:50 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org E83CB81769
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=gzw7WwVe
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id u9kW9KyNjx7N
 for <virtualization@lists.linux-foundation.org>;
 Tue,  9 Aug 2022 09:40:49 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 7EF1181761
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 7EF1181761
 for <virtualization@lists.linux-foundation.org>;
 Tue,  9 Aug 2022 09:40:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1660038048;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=IsT0KRKF2oYhoekZcw7g78m/8eltoernZwYx07lm7TU=;
 b=gzw7WwVeBCMy3nmtpOYs8g6e0hdoH0eYc11XAgNA7KjnqBxBlIj6pxmxeCyhSKNq22dg73
 u5WwU72cFD7MR011OusapHmSCsiw6F1pZT9PbXWIUXtekO0tGqsBpPc3zkh3OUVpjRy61W
 4TYoeDXift8fnKxG+iiLJAf8m7iRPwc=
Received: from mail-lj1-f199.google.com (mail-lj1-f199.google.com
 [209.85.208.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-125-w1z-vE6nNSyGk_K0MnCRuw-1; Tue, 09 Aug 2022 05:40:47 -0400
X-MC-Unique: w1z-vE6nNSyGk_K0MnCRuw-1
Received: by mail-lj1-f199.google.com with SMTP id
 by17-20020a05651c1a1100b0025e54bda6c7so3254660ljb.22
 for <virtualization@lists.linux-foundation.org>;
 Tue, 09 Aug 2022 02:40:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=IsT0KRKF2oYhoekZcw7g78m/8eltoernZwYx07lm7TU=;
 b=LJ/BKeuu4oJb6KtDHPlxIc4XmskbGhhsvXTDvaykiCn+Jm5rixb9Qe7Csc7RrfQ9DA
 LLBaHgLGWb23PqvFCHNYQmoOw0N7N53WIVqWbkWVDd8247DnPJzmBcj8ncDfia3FnE6u
 AaitWgq5coARizWHC4D9tQ7fl3JBJemzZ091HhHDciBJZroIV8WE+q++tR6lMN2TV83c
 Xq2an2fEqbYVpjhHHCjcQz59JXwDNHfARAmZ2a+OpJsNVRqc7RkHqjjEQz+ub/8PyIvv
 fbBtb326f+X4a9SQrOfM9tFgXW2ZOlZYNz08c6XxFh5LjJv/7ShMr83gtAswLSd73gzH
 oqhA==
X-Gm-Message-State: ACgBeo0xwXhVIoI4VSPFG08E/X7oZIVOvjhfnLcYYGv2GfwplR6Tt/5s
 L3weIIS4UN9EaO9uCS6ORC6KmpUMZQjZQmR5uQobb/a5PEiVxSkaK+VJZEep2nVRpsKMYii2y0M
 ejwzwyVxmMipNkx5FaIQkPAIMEIHIuqHB1RVLsO3lkDJH4PrWFl4T4AtKLg==
X-Received: by 2002:a05:651c:c98:b0:25e:6894:650 with SMTP id
 bz24-20020a05651c0c9800b0025e68940650mr7242976ljb.487.1660038045656; 
 Tue, 09 Aug 2022 02:40:45 -0700 (PDT)
X-Google-Smtp-Source: AA6agR6Hl+AHqtZCRawkTFKBBOWO/QDYTseLBz2eHA4TvbvMfW9GVChmxUoVtlZ+Hj6B7g0TFEBVYDhL7l99hA62+XY=
X-Received: by 2002:a05:651c:c98:b0:25e:6894:650 with SMTP id
 bz24-20020a05651c0c9800b0025e68940650mr7242963ljb.487.1660038045481; Tue, 09
 Aug 2022 02:40:45 -0700 (PDT)
MIME-Version: 1.0
References: <20220802044548.9031-1-gavinl@nvidia.com>
 <973632c6-3606-01fb-c584-a6d4774647d8@oracle.com>
 <c4c42174-dcf0-b1e1-a483-0447fbdb1c48@nvidia.com>
 <c173ba21-ad86-6360-5db7-df81de0b0350@oracle.com>
 <465efc4c-f41f-494e-8f2d-a87deae90c5d@nvidia.com>
 <CACGkMEsVG_62yJ5nGmp5ufF_xiEJk2TezQz-QFftF8ezKYLB8A@mail.gmail.com>
 <20220809052255-mutt-send-email-mst@kernel.org>
In-Reply-To: <20220809052255-mutt-send-email-mst@kernel.org>
From: Jason Wang <jasowang@redhat.com>
Date: Tue, 9 Aug 2022 17:40:34 +0800
Message-ID: <CACGkMEv=SXfhEhi2v23Q2-VZBa4Ji9JF1Dyd2PBWQHA44SiyCQ@mail.gmail.com>
Subject: Re: [virtio-dev] [PATCH] virtio-net: use mtu size as buffer length
 for big packets
To: "Michael S. Tsirkin" <mst@redhat.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Cc: alexander.h.duyck@intel.com, Virtio-Dev <virtio-dev@lists.oasis-open.org>,
 kubakici@wp.pl, sridhar.samudrala@intel.com, jesse.brandeburg@intel.com,
 gavi@nvidia.com, virtualization <virtualization@lists.linux-foundation.org>,
 "Hemminger, Stephen" <stephen@networkplumber.org>, loseweigh@gmail.com,
 davem <davem@davemloft.net>, Gavin Li <gavinl@nvidia.com>
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

On Tue, Aug 9, 2022 at 5:25 PM Michael S. Tsirkin <mst@redhat.com> wrote:
>
> On Tue, Aug 09, 2022 at 03:44:22PM +0800, Jason Wang wrote:
> > > +             unsigned int mtu = vi->dev->mtu;
>
> BTW should this not be max_mtu?

Yes.

> Otherwise if user configures mtu that
> is too small we'll add buffers that are too small.  some backends simply
> lock up if this happens (I think vhost does).

Probably not? If we run out of buffers, we will wait for the next
kick. (Otherwise it would be an guest triggerable behaviour)

> Maybe we should add a feature to allow packet drop if it's too small.

I may miss something but isn't this what most devices will do? (e.g
ethernet have a minimal packet length)

Thanks

> And send mtu guest to host while we are at it?
>
> --
> MST
>

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
