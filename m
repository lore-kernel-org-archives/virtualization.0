Return-Path: <SRS0=Tn2H=KJ=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7FD51C43461
	for <virtualization@archiver.kernel.org>; Fri, 14 May 2021 07:38:57 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 03E6561452
	for <virtualization@archiver.kernel.org>; Fri, 14 May 2021 07:38:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 03E6561452
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=daynix.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 868254012E;
	Fri, 14 May 2021 07:38:56 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id maAQpvn-NsKZ; Fri, 14 May 2021 07:38:55 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTP id 07AB24012A;
	Fri, 14 May 2021 07:38:54 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id CC048C000D;
	Fri, 14 May 2021 07:38:54 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id EC7EBC0001
 for <virtualization@lists.linux-foundation.org>;
 Fri, 14 May 2021 07:38:53 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id DFDCB605F9
 for <virtualization@lists.linux-foundation.org>;
 Fri, 14 May 2021 07:38:53 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp3.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=daynix-com.20150623.gappssmtp.com
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id b2BkaWdm4xPO
 for <virtualization@lists.linux-foundation.org>;
 Fri, 14 May 2021 07:38:53 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-oo1-xc2b.google.com (mail-oo1-xc2b.google.com
 [IPv6:2607:f8b0:4864:20::c2b])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 2AEDF605EE
 for <virtualization@lists.linux-foundation.org>;
 Fri, 14 May 2021 07:38:53 +0000 (UTC)
Received: by mail-oo1-xc2b.google.com with SMTP id
 j17-20020a4ad6d10000b02901fef5280522so6196162oot.0
 for <virtualization@lists.linux-foundation.org>;
 Fri, 14 May 2021 00:38:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20150623.gappssmtp.com; s=20150623;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=vLowYfteA+ucPyvyyoQpMI476zm+fyQH6C5ncpnpK5E=;
 b=AYk72NwD5Q3AzJdlfMcjSDolwuKh6xqP/rjNsmWzcoa/+Qu5YhHpWqZo1aUKAzLIv0
 ICAA1RY7CZXcksq2+uGo33ifQlK7+xMSrYLMazMUNMsBfX/lKtdas+bRz0jNb8NJSDjR
 NszP6uDYsaA4OsOtdXYMYItno9bQxuGnNdlaY4K9yoBDPoYnHUUzkrQUnANC4uwhD9xn
 Tb9CSvNHZ0Hs1fSInn+yUEx1YeWrQJ/OQ9zz7buXzDn/+t/nNzZO/qEIdRKrWO8gfsoJ
 lyWu0gHWooSM67NF0PPyyM34fCoPed4R6XIAotCAvTfb060LzBT7cnKRqqzFw9QwiVFb
 qe3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=vLowYfteA+ucPyvyyoQpMI476zm+fyQH6C5ncpnpK5E=;
 b=JwuSdEMTumVDc8UopRsOQxRtdHjGQgiH7afT4BvsE2ckKL2+amYfjKQ2wZsHMc7fFN
 8iGG0VMD7k7tv5o0SOAt11JgYdvXCRggYURz5vviic0GSU/IN5YGx+kpWfc5xbk7qOBb
 t1xoN1c4EXkvFqSizzlXpp9YPRkIyM/clz5P0wLf/r/GzZMbyvM5LL3NwlGeQBo73X1L
 7KP1oPpk+3Xu7i6h48Sg7Kaml5S0K/pYDaksUPfiRgo1ok+ivRmU7JKPXqVN34ZKvgnx
 xiVyU5X7fTT60LM0nZaW+MiORFBwL1aIEJcLAlyp6d/vnfG8BwLjcUHjGOZ54iRQY/iU
 XtHg==
X-Gm-Message-State: AOAM531LzvW5M8GCUnT613E03Sxv4K94jbNfLk4js7PPFwWuehrCH9DE
 +231zXfD1oGWhNtjJf8jEA9JtRuwCS8dM67xlNXsYQ==
X-Google-Smtp-Source: ABdhPJwS1fSKvV1YIb9Gu98m+Ob1K+gDnK+Fe1TYbqTQc1uLfyMToTcidxd+FUgOrDr3q3AMCSBbn2CU9cbW97R66N8=
X-Received: by 2002:a05:6820:100a:: with SMTP id
 v10mr31723524oor.55.1620977932134; 
 Fri, 14 May 2021 00:38:52 -0700 (PDT)
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
 <CACGkMEuUF1vDNWbL9dRr1ZM4vFTLwc3j9uB-66451U1NvQ+2EA@mail.gmail.com>
In-Reply-To: <CACGkMEuUF1vDNWbL9dRr1ZM4vFTLwc3j9uB-66451U1NvQ+2EA@mail.gmail.com>
From: Yuri Benditovich <yuri.benditovich@daynix.com>
Date: Fri, 14 May 2021 10:38:39 +0300
Message-ID: <CAOEp5OcozfSWszTm9VArOAH+wm2Fo8tH1QJDsLPZD8ieBLtg-g@mail.gmail.com>
Subject: Re: [PATCH 4/4] tun: indicate support for USO feature
To: Jason Wang <jasowang@redhat.com>
Cc: Willem de Bruijn <willemdebruijn.kernel@gmail.com>, mst <mst@redhat.com>,
 netdev <netdev@vger.kernel.org>, linux-kernel <linux-kernel@vger.kernel.org>,
 virtualization <virtualization@lists.linux-foundation.org>,
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

On Fri, May 14, 2021 at 10:16 AM Jason Wang <jasowang@redhat.com> wrote:
>
> On Fri, May 14, 2021 at 4:35 AM Willem de Bruijn
> <willemdebruijn.kernel@gmail.com> wrote:
> >
> > > > But surprisingly when TUN receives TUN_F_UFO it does not propagate it
> > > > anywhere, there is no corresponding NETIF flag.
> > >
> > > (It looks like I drop the community and other ccs accidentally, adding
> > > them back and sorry)
> > >
> > > Actually, there is one, NETIF_F_GSO_UDP.
> > >
> > > Kernel used to have NETIF_F_UFO, but it was removed due to bugs and
> > > the lack of real hardware support. Then we found it breaks uABI, so
> > > Willem tries to make it appear for userspace again, and then it was
> > > renamed to NETIF_F_GSO_UDP.
> > >
> > > But I think it's a bug that we don't proporate TUN_F_UFO to NETIF
> > > flag, this is a must for the driver that doesn't support
> > > VIRTIO_NET_F_GUEST_UFO. I just try to disable all offloads and
> > > mrg_rxbuf, then netperf UDP_STREAM from host to guest gives me bad
> > > length packet in the guest.
> > >
> > > Willem, I think we probably need to fix this.
> >
> > We had to add back support for the kernel to accept UFO packets from
> > userspace over tuntap.
> >
> > The kernel does not generate such packets, so a guest should never be
> > concerned of receiving UFO packets.
>
> That's my feeling as well.
>
> But when I:
>
> 1) turn off all guest gso feature and mrg rx buffers, in this case
> virtio-net will only allocate 1500 bytes for each packet
> 2) doing netperf (UDP_STREAM) from local host to guest, I see packet
> were truncated in the guest

Is it possible that the virtio-net does not disable UFO offload?
IMO it sets NETIF_F_LRO too bravely.
>
> >
> > Perhaps i'm misunderstanding the problem here.
> >
>
> I will re-check and get back to you.
> (probably need a while since I will not be online for the next week).
>
> Thanks
>
_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
