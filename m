Return-Path: <SRS0=J7l7=KI=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.5 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD018C433B4
	for <virtualization@archiver.kernel.org>; Thu, 13 May 2021 20:35:47 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2FC726121E
	for <virtualization@archiver.kernel.org>; Thu, 13 May 2021 20:35:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2FC726121E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id CAFEA4033A;
	Thu, 13 May 2021 20:35:46 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id JwICOoqaDCTT; Thu, 13 May 2021 20:35:45 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp4.osuosl.org (Postfix) with ESMTP id 2FA3D402EF;
	Thu, 13 May 2021 20:35:45 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 00BCEC000D;
	Thu, 13 May 2021 20:35:45 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 62381C0001
 for <virtualization@lists.linux-foundation.org>;
 Thu, 13 May 2021 20:35:43 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 3BCD04033A
 for <virtualization@lists.linux-foundation.org>;
 Thu, 13 May 2021 20:35:43 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id G688UdLvVnnS
 for <virtualization@lists.linux-foundation.org>;
 Thu, 13 May 2021 20:35:41 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com
 [IPv6:2a00:1450:4864:20::62b])
 by smtp4.osuosl.org (Postfix) with ESMTPS id E53964038A
 for <virtualization@lists.linux-foundation.org>;
 Thu, 13 May 2021 20:35:40 +0000 (UTC)
Received: by mail-ej1-x62b.google.com with SMTP id k10so10433916ejj.8
 for <virtualization@lists.linux-foundation.org>;
 Thu, 13 May 2021 13:35:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=4OSP4b7wpVi2J0VIXLzXQpYaouwViNp+zix3X51TtRM=;
 b=jULfFAQdup+JfQHyGNJe5gViVXOpfKZCPJbE4aABtwAQlIyYMLruaAymHorBENW7LV
 6pvAO2R4lC6uUDYEOkb2xu40DTKaKml5fQajfG2EmM0hS3O2NAa5kfec62L5iXXKfqk8
 mqweY9rc4duXqwNVSuQ00GtNYGEYr+fgr50a0i+d39Y7eXE6EO6UN/Kj22auNPrFs0wM
 srFbcdTcD2IwBZ/hLxi0+ZbitC9kx2/VlUk8HznczXbBSgHNbdP+GYBk/XrDDqgDpbS6
 F8hKcswHBIqwzalmTMSBhA24UZj/r8952Si6xy8qs1KARhQWn9VNADNoH33CF1+R40hc
 eWSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=4OSP4b7wpVi2J0VIXLzXQpYaouwViNp+zix3X51TtRM=;
 b=IVEE6qKGGn8tCcIXll6KYUTSrXibBEIR5GPPQ19IVMx9U8CW4u/udMbWcF8X1x6ehs
 sBZckiYZ8JOGydut1kPeE+RLz2ApOnYAJkwfSvL6mlFfyuqjPv92x/trpz3e0A7OyFFp
 /3Qoi2X3C56HV0AHbRFMPE0NyAjC3eqnmz50eFTpFVEhKQQlY+SRDwe+T5jIsYY+FRiF
 YgmGmzwaDyPj9GlG9TCgHzfx9Ic+fFfNyp0drTZyBMHIMPbTCo7yVMPjIMBRPSnRBGSP
 5PXXMi76yLvK59OxfbE34V4R1zMocRoHxj9T7tmfdfELaMcOMC3IECfc45avHgWrgWLU
 0uLg==
X-Gm-Message-State: AOAM532AcSROmeSxFyK6PaaSqhtnoaz5muJqGBnhnKKPW8Z9fcAIHtXN
 n/so3AmGs3t8jRTjLCASG4/QeykiWQ/xlQ==
X-Google-Smtp-Source: ABdhPJy2F/8pEwXhPCV86pPS+fyOEa3QPGLB+4Nbu1YhuMllSlau+ha9LHN+pEn02TfoSLk76aWYKg==
X-Received: by 2002:a17:907:3f1c:: with SMTP id
 hq28mr44739880ejc.349.1620938138769; 
 Thu, 13 May 2021 13:35:38 -0700 (PDT)
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com.
 [209.85.128.48])
 by smtp.gmail.com with ESMTPSA id b9sm3169334edt.2.2021.05.13.13.35.35
 for <virtualization@lists.linux-foundation.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 13 May 2021 13:35:36 -0700 (PDT)
Received: by mail-wm1-f48.google.com with SMTP id
 82-20020a1c01550000b0290142562ff7c9so447810wmb.3
 for <virtualization@lists.linux-foundation.org>;
 Thu, 13 May 2021 13:35:35 -0700 (PDT)
X-Received: by 2002:a7b:c94b:: with SMTP id i11mr34607045wml.120.1620938135207; 
 Thu, 13 May 2021 13:35:35 -0700 (PDT)
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
In-Reply-To: <CACGkMEu4NdyMoFKbyUGG1aGX+K=ShMZuVuMKYPauEBYz5pxYzA@mail.gmail.com>
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Date: Thu, 13 May 2021 16:34:57 -0400
X-Gmail-Original-Message-ID: <CA+FuTScV+AJ+O3shOMLjUcy+PjBE8uWqCNt0FXWnq9L3gzrvaw@mail.gmail.com>
Message-ID: <CA+FuTScV+AJ+O3shOMLjUcy+PjBE8uWqCNt0FXWnq9L3gzrvaw@mail.gmail.com>
Subject: Re: [PATCH 4/4] tun: indicate support for USO feature
To: Jason Wang <jasowang@redhat.com>
Cc: Willem de Bruijn <willemdebruijn.kernel@gmail.com>, mst <mst@redhat.com>,
 netdev <netdev@vger.kernel.org>, linux-kernel <linux-kernel@vger.kernel.org>,
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

> > But surprisingly when TUN receives TUN_F_UFO it does not propagate it
> > anywhere, there is no corresponding NETIF flag.
>
> (It looks like I drop the community and other ccs accidentally, adding
> them back and sorry)
>
> Actually, there is one, NETIF_F_GSO_UDP.
>
> Kernel used to have NETIF_F_UFO, but it was removed due to bugs and
> the lack of real hardware support. Then we found it breaks uABI, so
> Willem tries to make it appear for userspace again, and then it was
> renamed to NETIF_F_GSO_UDP.
>
> But I think it's a bug that we don't proporate TUN_F_UFO to NETIF
> flag, this is a must for the driver that doesn't support
> VIRTIO_NET_F_GUEST_UFO. I just try to disable all offloads and
> mrg_rxbuf, then netperf UDP_STREAM from host to guest gives me bad
> length packet in the guest.
>
> Willem, I think we probably need to fix this.

We had to add back support for the kernel to accept UFO packets from
userspace over tuntap.

The kernel does not generate such packets, so a guest should never be
concerned of receiving UFO packets.

Perhaps i'm misunderstanding the problem here.
_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
