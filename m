Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B3A1CC433F5
	for <virtualization@archiver.kernel.org>; Wed, 30 Mar 2022 02:38:26 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 3D1D3844F1;
	Wed, 30 Mar 2022 02:38:26 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id LMTl-PVPPpwz; Wed, 30 Mar 2022 02:38:25 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTPS id C78DC844EE;
	Wed, 30 Mar 2022 02:38:24 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id A7462C001D;
	Wed, 30 Mar 2022 02:38:24 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 648D9C0012
 for <virtualization@lists.linux-foundation.org>;
 Wed, 30 Mar 2022 02:38:23 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 3E321416EE
 for <virtualization@lists.linux-foundation.org>;
 Wed, 30 Mar 2022 02:38:23 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp4.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id mRwJo0E4Y4TQ
 for <virtualization@lists.linux-foundation.org>;
 Wed, 30 Mar 2022 02:38:22 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 4676A416DC
 for <virtualization@lists.linux-foundation.org>;
 Wed, 30 Mar 2022 02:38:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1648607900;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=0CM6n2cjBcYLkco5zRMxY738qqHj9I2QKT+KjQJ9qIc=;
 b=QzwFuvijxGgaw635BmJKerSs/ngs9GDBJe7gY8m57yqRo0+VOjmHfXKwYaFLhVmpdS8Wox
 79DcUV+EqBXOda9VGAxnVGBVXAAB0A2pMvUQ/bD6CixgI2YJl/VhLFkBeAdQyvauGip37s
 mTD5/rabwHnj/jeH9E8+2kWjrfoTyPE=
Received: from mail-lf1-f70.google.com (mail-lf1-f70.google.com
 [209.85.167.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-442-Shb4obXsMZSiOrMr-_DK2Q-1; Tue, 29 Mar 2022 22:38:19 -0400
X-MC-Unique: Shb4obXsMZSiOrMr-_DK2Q-1
Received: by mail-lf1-f70.google.com with SMTP id
 g11-20020a05651222cb00b0044a9b62320eso1973011lfu.8
 for <virtualization@lists.linux-foundation.org>;
 Tue, 29 Mar 2022 19:38:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=0CM6n2cjBcYLkco5zRMxY738qqHj9I2QKT+KjQJ9qIc=;
 b=HaeJnJRDS3BapPcAa6b+n7PB5gfpSxwXBXakKN/iAjcmxAywHxjOUIN2ii/Cq5YiNW
 h+4bYTMfHdpgnZE67j9OfNa8KOumPiubJ+hxaw4pS6gJJt4dsjjQeuC1yJaBpswRMkQT
 H9J4TMtvAE7JFF5RjrptK34PG7aBnx9otp8915aSU+FCD3l/Db3CdZ4SdF31dD1wGv6a
 bJ1rgm+xf7O/gp1hR6wMyWTUjirGgitoSNkizLNJtS/qR+skmgLRvnWf58AeWTv3kC6X
 y+iFQdFSEep+i1JsMI65qULz8hXAfPC4jaBMUx3b36E0HGF7f+H/sDS+ANE5zQRbJ2qO
 SDrg==
X-Gm-Message-State: AOAM533a0S+Iuz+MPpIgTQFMJLSHIuini12K69GVh0CXFpwxztKYCfwT
 XJbO7IYiFMoC7chTsrQFcSyrvO88VOhRjGZYsJKAizAx/ry7YGeMiFki1qhZAip0NJ5bY7aV9J6
 dUV4/3UN+gCgz51Y+QvHjQmlMfpgC5OuT1LmLM19U+uccbX4URQIOA+QQPw==
X-Received: by 2002:a05:6512:1395:b0:446:d382:79a5 with SMTP id
 p21-20020a056512139500b00446d38279a5mr5055797lfa.210.1648607897760; 
 Tue, 29 Mar 2022 19:38:17 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzsMNgPxQtJuVUUXSLLElqIoKTC9ua0/HO5bb6Fcre9c9W6UgWFNe6erYd0w1IGxGq19QreWNW8eV3nM3kpN4Y=
X-Received: by 2002:a05:6512:1395:b0:446:d382:79a5 with SMTP id
 p21-20020a056512139500b00446d38279a5mr5055782lfa.210.1648607897557; Tue, 29
 Mar 2022 19:38:17 -0700 (PDT)
MIME-Version: 1.0
References: <20220325050947-mutt-send-email-mst@kernel.org>
 <CACGkMEvioAVMmB+ab2xXB2YPECtwi1J55u8mRRk9-JAjFSZ8vg@mail.gmail.com>
 <20220325060659-mutt-send-email-mst@kernel.org>
 <CACGkMEu4mRfNbJXJtAFzhyd55fD7phUDKnVtYW0aqRnQmT_bYw@mail.gmail.com>
 <20220328015757-mutt-send-email-mst@kernel.org>
 <CACGkMEu+fax6YYwhfbc1yoSxv6o1FTQyrOheVTmUfqGvmbAEfA@mail.gmail.com>
 <20220328062452-mutt-send-email-mst@kernel.org> <87fsn1f96e.ffs@tglx>
 <20220329100859-mutt-send-email-mst@kernel.org> <87v8vweie2.ffs@tglx>
 <20220329175426-mutt-send-email-mst@kernel.org>
In-Reply-To: <20220329175426-mutt-send-email-mst@kernel.org>
From: Jason Wang <jasowang@redhat.com>
Date: Wed, 30 Mar 2022 10:38:06 +0800
Message-ID: <CACGkMEv2j2cJkSFfxTmaRxJ+SH6actSCZsALjvvDUPgg0h-KeA@mail.gmail.com>
Subject: Re:
To: "Michael S. Tsirkin" <mst@redhat.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=jasowang@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Cc: "Paul E. McKenney" <paulmck@kernel.org>,
 Peter Zijlstra <peterz@infradead.org>, Marc Zyngier <maz@kernel.org>,
 Keir Fraser <keirf@google.com>, linux-kernel <linux-kernel@vger.kernel.org>,
 virtualization <virtualization@lists.linux-foundation.org>,
 Thomas Gleixner <tglx@linutronix.de>
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

On Wed, Mar 30, 2022 at 6:04 AM Michael S. Tsirkin <mst@redhat.com> wrote:
>
> On Tue, Mar 29, 2022 at 08:13:57PM +0200, Thomas Gleixner wrote:
> > On Tue, Mar 29 2022 at 10:37, Michael S. Tsirkin wrote:
> > > On Tue, Mar 29, 2022 at 10:35:21AM +0200, Thomas Gleixner wrote:
> > > We are trying to fix the driver since at the moment it does not
> > > have the dev->ok flag at all.
> > >
> > > And I suspect virtio is not alone in that.
> > > So it would have been nice if there was a standard flag
> > > replacing the driver-specific dev->ok above, and ideally
> > > would also handle the case of an interrupt triggering
> > > too early by deferring the interrupt until the flag is set.
> > >
> > > And in fact, it does kind of exist: IRQF_NO_AUTOEN, and you would call
> > > enable_irq instead of dev->ok = true, except
> > > - it doesn't work with affinity managed IRQs
> > > - it does not work with shared IRQs
> > >
> > > So using dev->ok as you propose above seems better at this point.
> >
> > Unless there is a big enough amount of drivers which could make use of a
> > generic mechanism for that.
> >
> > >> If any driver does this in the wrong order, then the driver is
> > >> broken.
> > >
> > > I agree, however:
> > > $ git grep synchronize_irq `git grep -l request_irq drivers/net/`|wc -l
> > > 113
> > > $ git grep -l request_irq drivers/net/|wc -l
> > > 397
> > >
> > > I suspect there are more drivers which in theory need the
> > > synchronize_irq dance but in practice do not execute it.
> >
> > That really depends on when the driver requests the interrupt, when
> > it actually enables the interrupt in the device itself
>
> This last point does not matter since we are talking about protecting
> against buggy/malicious devices. They can inject the interrupt anyway
> even if driver did not configure it.
>
> > and how the
> > interrupt service routine works.
> >
> > So just doing that grep dance does not tell much. You really have to do
> > a case by case analysis.
> >
> > Thanks,
> >
> >         tglx
>
>
> I agree. In fact, at least for network the standard approach is to
> request interrupts in the open call, virtio net is unusual
> in doing it in probe. We should consider changing that.
> Jason?

This probably works only for virtio-net and it looks like not trivial
since we don't have a specific core API to request interrupts.

Thanks

>
> --
> MST
>

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
