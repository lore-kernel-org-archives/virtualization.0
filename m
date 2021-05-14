Return-Path: <SRS0=Tn2H=KJ=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 81DE4C433B4
	for <virtualization@archiver.kernel.org>; Fri, 14 May 2021 05:49:18 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 06C0561440
	for <virtualization@archiver.kernel.org>; Fri, 14 May 2021 05:49:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 06C0561440
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=daynix.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id B55766064E;
	Fri, 14 May 2021 05:49:17 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id J1Qm14hatLfi; Fri, 14 May 2021 05:49:13 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTP id 4F0B46062A;
	Fri, 14 May 2021 05:49:13 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 24228C000E;
	Fri, 14 May 2021 05:49:13 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id EE384C0001
 for <virtualization@lists.linux-foundation.org>;
 Fri, 14 May 2021 05:49:10 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id DC2D36062A
 for <virtualization@lists.linux-foundation.org>;
 Fri, 14 May 2021 05:49:10 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 1oKH3OHAfL8Q
 for <virtualization@lists.linux-foundation.org>;
 Fri, 14 May 2021 05:49:06 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-ot1-x333.google.com (mail-ot1-x333.google.com
 [IPv6:2607:f8b0:4864:20::333])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 045F660625
 for <virtualization@lists.linux-foundation.org>;
 Fri, 14 May 2021 05:49:05 +0000 (UTC)
Received: by mail-ot1-x333.google.com with SMTP id
 t4-20020a05683014c4b02902ed26dd7a60so15466022otq.7
 for <virtualization@lists.linux-foundation.org>;
 Thu, 13 May 2021 22:49:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20150623.gappssmtp.com; s=20150623;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=bE06xAXCXCRjHxZIVvCKZFVX3we62E4nDMf17dk25ts=;
 b=N1aj48wfBA8fNXog/TNxwKCt1hOpvt3nk6RJEDP4coWUX2s7+9OH6R3QaLITJoxTrE
 Zzn+EXzYJhzRVDLXDunJXDPWRAQOP7W0GEDCsedZbqtO5C8ePdg5FixKLFwOhXriy6VH
 0f/WGx3ISGrBqNorGa4/HjdG7FK6YohsZNy6G4jAB4l4uz+izg3LXc2SkhVwDmV+GEyP
 auhpYNKA4q4C2ZCYunWce4JTb6nEDPr5I00fsv+hvFpsdf9jKvsVG8IsDByybgV9u4Rg
 4i6eHzJJ/52mWwaB9g+oMNmDR8u/HM6RUnuhbWWsKM3J5FXGw7XOdMVskvjFiYXhYysj
 ordg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=bE06xAXCXCRjHxZIVvCKZFVX3we62E4nDMf17dk25ts=;
 b=WDvyYJCnTu/isEsdR4EvEIWYwlyQM83uTzOiqpb0EnVG1oMsYIN6lOXL8cEk2zqljs
 DqfZE2i0WQ+yzdgu/XLIXVcnv9yQdIZbJZmPUPG6gonFij81dYdoH/UTUYslYI/9f/5W
 U3Xr0hVQp6l4GIP2JKOcK9saWfEQqkpyITC/1l3bKDGZtkbmqD92RqHvAPFvif9rq5ew
 H9Bwyp1lFiCjhWOxqprgdMXr/A0ICmmMXjkXGMn+CMx6BpdlXxv6RXRp+DCQT3R3DYon
 A8WalT11qNcXnl2Va2ZxEZ1xFhCLeSRTzC3WuK6b0l8eSXN5YSFrmQ0hGFLrlq2cuf1m
 x+xQ==
X-Gm-Message-State: AOAM530vazRYlj712ctQr5bKCuQO9sfjUjOnQVWG1ICmI2ewPoGnnBe9
 rMiQMJnnzNzPqKa5kWUq1LLzqXvQzGYi2Kp6rwzqCw==
X-Google-Smtp-Source: ABdhPJw6ecjfX4cA6xRIgJtvrTL3DdNwOpNQUZA+OEyZgZIY3AZNDInnxNRJJQlEAM6xDNSsTsXPqu5Gd6ve8wDX7eM=
X-Received: by 2002:a9d:8ce:: with SMTP id 72mr39720820otf.220.1620971344860; 
 Thu, 13 May 2021 22:49:04 -0700 (PDT)
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
 <CAOEp5Oe7FQQFbO7KDiyBPs1=ox+6rOimOwounTHBuVki2Y3DAg@mail.gmail.com>
 <CA+FuTSfr4gLwx0PaRCB1K=TUE_yawpnWx05U9yO0eQ1B+Pa+bg@mail.gmail.com>
In-Reply-To: <CA+FuTSfr4gLwx0PaRCB1K=TUE_yawpnWx05U9yO0eQ1B+Pa+bg@mail.gmail.com>
From: Yuri Benditovich <yuri.benditovich@daynix.com>
Date: Fri, 14 May 2021 08:48:52 +0300
Message-ID: <CAOEp5OfqX9r8Ku576tUWPGijGp+CyDewwEqsQRRsZSuDeOsqFw@mail.gmail.com>
Subject: Re: [PATCH 4/4] tun: indicate support for USO feature
To: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Cc: mst <mst@redhat.com>, netdev <netdev@vger.kernel.org>,
 linux-kernel <linux-kernel@vger.kernel.org>,
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

On Thu, May 13, 2021 at 11:43 PM Willem de Bruijn
<willemdebruijn.kernel@gmail.com> wrote:
>
> > > > > > So the question is what to do now:
> > > > > > A)
> > > > > > Finalize patches for guest TX and respective QEMU patches
> > > > > > Prepare RFC patches for guest RX, get ack on them
> > > > > > Change the spec
> > > > > > Finalize patches for guest RX according to the spec
> > > > > >
> > > > > > B)
> > > > > > Reject the patches for guest TX
> > > > > > Prepare RFC patches for everything, get ack on them
> > > > > > Change the spec
> > > > > > Finalize patches for everything according to the spec
> > > > > >
> > > > > > I'm for A) of course :)
> > > > >
> > > > > I'm for B :)
> > > > >
> > > > > The reasons are:
> > > > >
> > > > > 1) keep the assumption of tun_set_offload() to simply the logic and
> > > > > compatibility
> > > > > 2) it's hard or tricky to touch guest TX path only (e.g the
> > > > > virtio_net_hdr_from_skb() is called in both RX and TX)
> > > >
> > > > I suspect there is _some_ misunderstanding here.
> > > > I did not touch virtio_net_hdr_from_skb at all.
> > > >
> > >
> > > Typo, actually I meant virtio_net_hdr_to_skb().
> > OK.
> > 2) tun_get_user() which is guest TX - this is covered
> > 3) tap_get_user() which is guest TX - this is covered
> > 4) {t}packet_send() which is userspace TX - this is OK, the userspace
> > does not have this feature, it will never use USO
>
> What do you mean exactly? I can certainly imagine packet socket users
> that could benefit from using udp gso.
I've just tried to understand whether we have a real functional
problem due to the fact that I define the USO feature only for guest
TX path.
This set of patches modifies virtio_net_hdr_to_skb and Jason's comment
was that this procedure is called in both guest TX and RX, there are 4
places where the virtio_net_hdr_to_skb is called, userspace TX is one
of them.
AFAIU userspace 'socket' and 'user' backends of qemu do not have any
offloads at all so they will never use USO also.
Sorry for misunderstanding if any.
>
> When adding support for a new GSO type in virtio_net_hdr, it ideally
> is supported by all users of that interface. Alternatively, if some
> users do not support the flag, a call that sets the flag has to
> (continue to) fail hard, so that we can enable it at a later time.
I agree of course. IMO this is what I've tried to do. I did not have
in the initial plan to make Linux virtio-net to use the USO at all but
this should not present any problem (if I'm not mistaken).
_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
