Return-Path: <SRS0=Tn2H=KJ=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DA4DFC433B4
	for <virtualization@archiver.kernel.org>; Fri, 14 May 2021 07:16:44 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 75BC761446
	for <virtualization@archiver.kernel.org>; Fri, 14 May 2021 07:16:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 75BC761446
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 0A307401E6;
	Fri, 14 May 2021 07:16:44 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id OQdSFU_7cHcz; Fri, 14 May 2021 07:16:43 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp2.osuosl.org (Postfix) with ESMTP id 9CDCF4012A;
	Fri, 14 May 2021 07:16:42 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 7DD64C000E;
	Fri, 14 May 2021 07:16:42 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id CDA3EC0001
 for <virtualization@lists.linux-foundation.org>;
 Fri, 14 May 2021 07:16:40 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id B466C83BA3
 for <virtualization@lists.linux-foundation.org>;
 Fri, 14 May 2021 07:16:40 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp1.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 9iRsbrhNeudQ
 for <virtualization@lists.linux-foundation.org>;
 Fri, 14 May 2021 07:16:40 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [216.205.24.124])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 038DB842E4
 for <virtualization@lists.linux-foundation.org>;
 Fri, 14 May 2021 07:16:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1620976598;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=bs6XAiqm+++NgmbBMX048ZVKuxbmYHB+gyl0ZWTysSo=;
 b=MwCo7bEv1VPzabRx5mhMx/E6wmhardxdBFiXLcFSRpMNy+nh8jm8Y+95xQaCVp9b7p1EiN
 IPO7TBQ8lcvx6a8wlofPA+2U0x1gaahi5xqHzB5eu6qrX04NWDbqTaq5gLeCLN8tAFqJbr
 Ta1/dECfoWcbLx6NBGUyjzcndnHjn6I=
Received: from mail-lj1-f199.google.com (mail-lj1-f199.google.com
 [209.85.208.199]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-593-iWEjLOl-M-6tHdi469CaqQ-1; Fri, 14 May 2021 03:16:36 -0400
X-MC-Unique: iWEjLOl-M-6tHdi469CaqQ-1
Received: by mail-lj1-f199.google.com with SMTP id
 h1-20020a2e9ec10000b02900edf305c2e1so6050344ljk.12
 for <virtualization@lists.linux-foundation.org>;
 Fri, 14 May 2021 00:16:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=bs6XAiqm+++NgmbBMX048ZVKuxbmYHB+gyl0ZWTysSo=;
 b=pixA6K+tRsWXkVQAau5uRT82HyDbnVAbi6MAk5m/FY1P3+b4YBswsG6BQL605rl/Q6
 7bRvGQIjCcmD8TIy5qaVL0tsAUxU0oO59US4lz2b0GF9n2xY0BhtRex5ZPSyvBwsc63z
 X2uM5qEBKJyW79bZvnQ3/ehT40EvW7UmAX3SZOxRH1RNXllkhFsWc83faxOTYqJWCUYK
 mZO/wQZVvcopKiGZ51y2D8k8zUQbY1TAVJQTWYdy9bnsKM9ITsU6HofdYhTKl9+uA+x/
 C9VyJRvbDK8eV3tiWBEcuuSB5NLiJ+eqMBYpvim0AxiPPUbCTS2c87/mtxlSLBAbRnf1
 H+lg==
X-Gm-Message-State: AOAM532fp/Bz8rj8NuuMbnWxAgSWq0WtT027CIntbZpJUIv6AebJkaoa
 vRR9898C1V3E1MyPE0Wz6ILbi2FSauKqhW++wCWgZHC42XFYUNkzhIbtrtuZpGysF+EYoWGr8RK
 oIfBmYEj1mBzXyu9cSoz6CLh80g2jo5s8o6ueZbTwtN57I18D3DRTw4w2+A==
X-Received: by 2002:a05:6512:1027:: with SMTP id
 r7mr13858036lfr.153.1620976595431; 
 Fri, 14 May 2021 00:16:35 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJylEHgvD1At56XNI5YMYNsfY9iCPgmWpzVeYV6PPpvkCHSx7kuHth0tuPQkubc2oMXxR1C5ZImuUDudNmzwUls=
X-Received: by 2002:a05:6512:1027:: with SMTP id
 r7mr13858008lfr.153.1620976595150; 
 Fri, 14 May 2021 00:16:35 -0700 (PDT)
MIME-Version: 1.0
References: <20210511044253.469034-1-yuri.benditovich@daynix.com>
 <20210511044253.469034-5-yuri.benditovich@daynix.com>
 <eb8c4984-f0cc-74ee-537f-fc60deaaaa73@redhat.com>
 <CAOEp5OdrCDPx4ijLcEOm=Wxma6hc=nyqw4Xm6bggBxvgtR0tbg@mail.gmail.com>
 <89759261-3a72-df6c-7a81-b7a48abfad44@redhat.com>
 <CAOEp5Ocm9Q69Fv=oeyCs01F9J4nCTPiOPpw9_BRZ0WnF+LtEFQ@mail.gmail.com>
 <CACGkMEsZBCzV+d_eLj1aYT+pkS5m1QAy7q8rUkNsdV0C8aL8tQ@mail.gmail.com>
 <CAOEp5OeSankfA6urXLW_fquSMrZ+WYXDtKNacort1UwR=WgxqA@mail.gmail.com>
 <CACGkMEt3bZrdqbWtWjSkXvv5v8iCHiN8hkD3T602RZnb6nPd9A@mail.gmail.com>
 <CAOEp5Odw=eaQWZCXr+U8PipPtO1Avjw-t3gEdKyvNYxuNa5TfQ@mail.gmail.com>
 <CACGkMEuqXaJxGqC+CLoq7k4XDu+W3E3Kk3WvG-D6tnn2K4ZPNA@mail.gmail.com>
 <CAOEp5OfB62SQzxMj_GkVD4EM=Z+xf43TPoTZwMbPPa3BsX2ooA@mail.gmail.com>
 <CACGkMEu4NdyMoFKbyUGG1aGX+K=ShMZuVuMKYPauEBYz5pxYzA@mail.gmail.com>
 <CA+FuTScV+AJ+O3shOMLjUcy+PjBE8uWqCNt0FXWnq9L3gzrvaw@mail.gmail.com>
In-Reply-To: <CA+FuTScV+AJ+O3shOMLjUcy+PjBE8uWqCNt0FXWnq9L3gzrvaw@mail.gmail.com>
From: Jason Wang <jasowang@redhat.com>
Date: Fri, 14 May 2021 15:16:23 +0800
Message-ID: <CACGkMEuUF1vDNWbL9dRr1ZM4vFTLwc3j9uB-66451U1NvQ+2EA@mail.gmail.com>
Subject: Re: [PATCH 4/4] tun: indicate support for USO feature
To: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=jasowang@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Cc: mst <mst@redhat.com>, netdev <netdev@vger.kernel.org>,
 linux-kernel <linux-kernel@vger.kernel.org>,
 virtualization <virtualization@lists.linux-foundation.org>,
 Yuri Benditovich <yuri.benditovich@daynix.com>,
 Yan Vugenfirer <yan@daynix.com>, Jakub Kicinski <kuba@kernel.org>,
 davem <davem@davemloft.net>
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

On Fri, May 14, 2021 at 4:35 AM Willem de Bruijn
<willemdebruijn.kernel@gmail.com> wrote:
>
> > > But surprisingly when TUN receives TUN_F_UFO it does not propagate it
> > > anywhere, there is no corresponding NETIF flag.
> >
> > (It looks like I drop the community and other ccs accidentally, adding
> > them back and sorry)
> >
> > Actually, there is one, NETIF_F_GSO_UDP.
> >
> > Kernel used to have NETIF_F_UFO, but it was removed due to bugs and
> > the lack of real hardware support. Then we found it breaks uABI, so
> > Willem tries to make it appear for userspace again, and then it was
> > renamed to NETIF_F_GSO_UDP.
> >
> > But I think it's a bug that we don't proporate TUN_F_UFO to NETIF
> > flag, this is a must for the driver that doesn't support
> > VIRTIO_NET_F_GUEST_UFO. I just try to disable all offloads and
> > mrg_rxbuf, then netperf UDP_STREAM from host to guest gives me bad
> > length packet in the guest.
> >
> > Willem, I think we probably need to fix this.
>
> We had to add back support for the kernel to accept UFO packets from
> userspace over tuntap.
>
> The kernel does not generate such packets, so a guest should never be
> concerned of receiving UFO packets.

That's my feeling as well.

But when I:

1) turn off all guest gso feature and mrg rx buffers, in this case
virtio-net will only allocate 1500 bytes for each packet
2) doing netperf (UDP_STREAM) from local host to guest, I see packet
were truncated in the guest

>
> Perhaps i'm misunderstanding the problem here.
>

I will re-check and get back to you.
(probably need a while since I will not be online for the next week).

Thanks

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
