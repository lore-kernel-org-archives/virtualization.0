Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BEFE3C4332F
	for <virtualization@archiver.kernel.org>; Sun,  4 Dec 2022 08:20:20 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 3E6C481CDC;
	Sun,  4 Dec 2022 08:20:20 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 3E6C481CDC
Authentication-Results: smtp1.osuosl.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=solid-run-com.20210112.gappssmtp.com header.i=@solid-run-com.20210112.gappssmtp.com header.a=rsa-sha256 header.s=20210112 header.b=vUUGkXvl
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id KFm-nOFY6kli; Sun,  4 Dec 2022 08:20:19 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp1.osuosl.org (Postfix) with ESMTPS id B19FC81C11;
	Sun,  4 Dec 2022 08:20:18 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org B19FC81C11
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 7E622C0033;
	Sun,  4 Dec 2022 08:20:18 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 74F09C002D
 for <virtualization@lists.linux-foundation.org>;
 Sun,  4 Dec 2022 08:20:17 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 3AA4641571
 for <virtualization@lists.linux-foundation.org>;
 Sun,  4 Dec 2022 08:20:17 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 3AA4641571
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key) header.d=solid-run-com.20210112.gappssmtp.com
 header.i=@solid-run-com.20210112.gappssmtp.com header.a=rsa-sha256
 header.s=20210112 header.b=vUUGkXvl
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id hVyKuGUQiRnV
 for <virtualization@lists.linux-foundation.org>;
 Sun,  4 Dec 2022 08:20:16 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org BE9C4414C8
Received: from mail-io1-xd2d.google.com (mail-io1-xd2d.google.com
 [IPv6:2607:f8b0:4864:20::d2d])
 by smtp4.osuosl.org (Postfix) with ESMTPS id BE9C4414C8
 for <virtualization@lists.linux-foundation.org>;
 Sun,  4 Dec 2022 08:20:15 +0000 (UTC)
Received: by mail-io1-xd2d.google.com with SMTP id n63so1258041iod.7
 for <virtualization@lists.linux-foundation.org>;
 Sun, 04 Dec 2022 00:20:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=solid-run-com.20210112.gappssmtp.com; s=20210112;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=gLNdW5CPndSqMECHGac70+2EvNdsPiAGPBehtR5zRIg=;
 b=vUUGkXvlLemqgOtWsbgpyfxBYkFbmYeU6Zp2YSBMWtH/pcJXQK52PqR+Yo4XbS5w3x
 Is3oT8jDRR9T2UKu+Lg3qP7Q2khbMhAOu8uhvtwzaWA7o9U2nx/yBB+6eiLqA6L66nBO
 swzAnKY+eq3qItKogNnYdayAW+v3VkDynemaUhmA0+K2a7IHwnwWVVDTCpn9pbiCjWgz
 VH8YhkGLGR0yFeZ26tPDdHNTyqmQcnxdEv9HPuJVxY6V5BjrGjB8Ania/7tV9K5ep7BJ
 vRz1BLa+/Fp3SiE9h6xAw/1k3mpYevW2pR91YV+7gV/i3n2enRIrEe0TqeZ8bJgSnzxt
 nI1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=gLNdW5CPndSqMECHGac70+2EvNdsPiAGPBehtR5zRIg=;
 b=Cg7J2WDSDe1YBWKrpwUmzBNtpQTRhRddl9mEfRfiJAYD2ZcKmk9m7DJls5Tc3pPufU
 lnfXkn1HcTHIrG1O+ID7LwwDSXPy5QhRr4PSRARxKN4guErxexzXMzKD24Tszp70AqAL
 ie4heTWMM8PHYm/sUwzLZkExx+S3MWWY138y7cZYVpWCBXr+OJUI551ERL6EX132aW3C
 mpPWsoF34F0pX7lckJt+CTbH/0Rd4TTcqPKCqm4t1S5BlNvys70GkLaU790D2ebc0u2h
 uiVU0v3aBEzehhUS2w5Xt8AVnWcazkh2vu+zAlQAutJBSoiVPvgw8/wCV2KG0EaV3Txc
 T/vw==
X-Gm-Message-State: ANoB5pl0+NsfU+ZRGy/o+ctQ9EPgY9Gb0cLfwrdkogqEm3eEP6Z60KfK
 N3N0/CxtUaVEf688QR7zEEGnGxnlRUOrqrZHOlcMqg==
X-Google-Smtp-Source: AA0mqf5m+335bWn+pSqa3MfOSpdA6vG0UjF7DcgKga3hIR5gtPRpSA0oHF0O0pyjF32EA6au3bdtNmTzUwUBxjcHwtE=
X-Received: by 2002:a02:6603:0:b0:375:9e02:b459 with SMTP id
 k3-20020a026603000000b003759e02b459mr35880405jac.30.1670142014761; Sun, 04
 Dec 2022 00:20:14 -0800 (PST)
MIME-Version: 1.0
References: <20221121085923.2717501-1-alvaro.karsz@solid-run.com>
 <1bd1c77e-d8c3-b04a-4fbc-bbc85391e630@nvidia.com>
 <20221124013830-mutt-send-email-mst@kernel.org>
 <Y3/WXWoV1jcJnohR@fedora>
 <CAJs=3_AY_1eGwsu5MvzUr4N03=3qgYiVdu5=EV+VSj6+yUYeyg@mail.gmail.com>
 <Y4UG6lQXbzxOix1/@fedora> <dc8bf007-a6f6-9824-63e1-9447335da732@nvidia.com>
 <20221129001239-mutt-send-email-mst@kernel.org>
 <b76ad252-3f6a-8f4b-cb2d-0a4f45860aae@nvidia.com>
In-Reply-To: <b76ad252-3f6a-8f4b-cb2d-0a4f45860aae@nvidia.com>
From: Alvaro Karsz <alvaro.karsz@solid-run.com>
Date: Sun, 4 Dec 2022 10:19:38 +0200
Message-ID: <CAJs=3_Bma3KiOW3Cah2KWiN34TG4c=bdw1bTjB71Fo_QLaKmXw@mail.gmail.com>
Subject: Re: [PATCH v2] virtio_blk: add VIRTIO_BLK_F_LIFETIME feature support
To: Chaitanya Kulkarni <chaitanyak@nvidia.com>
Cc: Jens Axboe <axboe@kernel.dk>, Paolo Bonzini <pbonzini@redhat.com>,
 "virtualization@lists.linux-foundation.org"
 <virtualization@lists.linux-foundation.org>,
 Stefan Hajnoczi <stefanha@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>
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

So, we could create a block-general lifetime ioctl with many reserved
bytes, or create a virtio block specific ioctl without reserved bytes
at all.
I think that we should keep it virtio specific, and if a new lifetime
command is added to the spec with more fields, we could create a new
ioctl.
Does Everyone agree?

> I think if you are going to pass struct virtio_blk_lifetime to
> userspace, better pass it as defined in the spec, in LE format.

> It's unusual for an ioctl to produce a struct that's not in CPU
> endianness. I think the kernel should deal with endianness here.

I'm not sure how to proceed with the endianness matter..

Alvaro
_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
