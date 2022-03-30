Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1A4F3C433EF
	for <virtualization@archiver.kernel.org>; Wed, 30 Mar 2022 05:53:40 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id A5C5360BAF;
	Wed, 30 Mar 2022 05:53:40 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id JwlKrnLPJ-XQ; Wed, 30 Mar 2022 05:53:40 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 570D560BD8;
	Wed, 30 Mar 2022 05:53:39 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 2B9FCC001D;
	Wed, 30 Mar 2022 05:53:39 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id AE17CC0012
 for <virtualization@lists.linux-foundation.org>;
 Wed, 30 Mar 2022 05:53:37 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 9AF8760BD8
 for <virtualization@lists.linux-foundation.org>;
 Wed, 30 Mar 2022 05:53:37 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id BgAW2CrzkT_N
 for <virtualization@lists.linux-foundation.org>;
 Wed, 30 Mar 2022 05:53:37 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp3.osuosl.org (Postfix) with ESMTPS id E0A0B60BAF
 for <virtualization@lists.linux-foundation.org>;
 Wed, 30 Mar 2022 05:53:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1648619615;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=SiJN+ilVZ4I67/S1tYHmk8OsCjr1KyukiifyvUBRqz8=;
 b=bSHwL/fOkoLbSeLukbzAnl+uC86MwujoxOHHu7E15zhyMxAl9h4/lHmPXQ67w3uP8lvt5j
 cLw7KYiwV2vJ8H9HSyoYtSEl9KR/pbUy42DRMSf0MZIUD0ZaUCgsaEu3ar/pXppVsuIV4U
 19WDnrrKaCKgl4FDVVIazm0krKb4VMI=
Received: from mail-lf1-f72.google.com (mail-lf1-f72.google.com
 [209.85.167.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-492-zg3Fbhg_PJe2gIHUG6sFGQ-1; Wed, 30 Mar 2022 01:53:31 -0400
X-MC-Unique: zg3Fbhg_PJe2gIHUG6sFGQ-1
Received: by mail-lf1-f72.google.com with SMTP id
 u29-20020ac251dd000000b0044a245bcc1aso6118662lfm.7
 for <virtualization@lists.linux-foundation.org>;
 Tue, 29 Mar 2022 22:53:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=SiJN+ilVZ4I67/S1tYHmk8OsCjr1KyukiifyvUBRqz8=;
 b=PeJ50q5k7YASMeSqJledxTORCI4yOtwjEusFHQqixumlbgBSt1gh4V9SokMj8cS/br
 WGJbAsbGgpjyR6hfpsms+yjxY/0i3PaGlRttnx9zBH/zisXfPqye6ccsgGWIDSnXwX3V
 oH/MS+uUpe1ltPaa5iLxzU9ldXTLfG1RjyrM5LzEML4/jjHp38htIWQ391f/QBkF72Rh
 6lzo2VG0VdEI9yD4AQLMoKxf6bmJaFqToDnvpUgqZPArZSL1dDVo3r3tnCcQ4HexZaDo
 Nk3CgmU2zQxFnN0wlYYu4F130cGkoBlwtJuy6ARJBMPGAMTsKeS02ulY7WKeI7jAFzo0
 h8OQ==
X-Gm-Message-State: AOAM533K2EF10p4mqVhwVng4fBnWFGLXqPEiqcUCVhOgHicyNI1qfPf6
 55nFL+aB1DTXrABgVTkURlp+woNxbyYFN70+ZukF0wpNQZrBQNKRzNbSVcOcYi56EHj+NSevAvu
 HsAswvXInsu3E1jQajEveMz7mqrAhu9+9gBU0aX160o/jVhT5kITfPTQgXw==
X-Received: by 2002:a05:651c:b0c:b0:247:e4b7:d4a0 with SMTP id
 b12-20020a05651c0b0c00b00247e4b7d4a0mr5481708ljr.177.1648619610377; 
 Tue, 29 Mar 2022 22:53:30 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJximUtRievmpSEKXGB135CLUMN3LHkErjpMQdk2DotSEFBtM7XBqy5ZoLLyIftc/DHz3FjQd+e/ovEu9mxXO+k=
X-Received: by 2002:a05:651c:b0c:b0:247:e4b7:d4a0 with SMTP id
 b12-20020a05651c0b0c00b00247e4b7d4a0mr5481696ljr.177.1648619610146; Tue, 29
 Mar 2022 22:53:30 -0700 (PDT)
MIME-Version: 1.0
References: <20220325060659-mutt-send-email-mst@kernel.org>
 <CACGkMEu4mRfNbJXJtAFzhyd55fD7phUDKnVtYW0aqRnQmT_bYw@mail.gmail.com>
 <20220328015757-mutt-send-email-mst@kernel.org>
 <CACGkMEu+fax6YYwhfbc1yoSxv6o1FTQyrOheVTmUfqGvmbAEfA@mail.gmail.com>
 <20220328062452-mutt-send-email-mst@kernel.org> <87fsn1f96e.ffs@tglx>
 <20220329100859-mutt-send-email-mst@kernel.org> <87v8vweie2.ffs@tglx>
 <20220329175426-mutt-send-email-mst@kernel.org>
 <CACGkMEv2j2cJkSFfxTmaRxJ+SH6actSCZsALjvvDUPgg0h-KeA@mail.gmail.com>
 <20220330010646-mutt-send-email-mst@kernel.org>
In-Reply-To: <20220330010646-mutt-send-email-mst@kernel.org>
From: Jason Wang <jasowang@redhat.com>
Date: Wed, 30 Mar 2022 13:53:18 +0800
Message-ID: <CACGkMEuObEd7Gov2AH6Ch0VjAvn5=2MBcC2V3_FkriZULVfpcQ@mail.gmail.com>
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

On Wed, Mar 30, 2022 at 1:09 PM Michael S. Tsirkin <mst@redhat.com> wrote:
>
> On Wed, Mar 30, 2022 at 10:38:06AM +0800, Jason Wang wrote:
> > On Wed, Mar 30, 2022 at 6:04 AM Michael S. Tsirkin <mst@redhat.com> wrote:
> > >
> > > On Tue, Mar 29, 2022 at 08:13:57PM +0200, Thomas Gleixner wrote:
> > > > On Tue, Mar 29 2022 at 10:37, Michael S. Tsirkin wrote:
> > > > > On Tue, Mar 29, 2022 at 10:35:21AM +0200, Thomas Gleixner wrote:
> > > > > We are trying to fix the driver since at the moment it does not
> > > > > have the dev->ok flag at all.
> > > > >
> > > > > And I suspect virtio is not alone in that.
> > > > > So it would have been nice if there was a standard flag
> > > > > replacing the driver-specific dev->ok above, and ideally
> > > > > would also handle the case of an interrupt triggering
> > > > > too early by deferring the interrupt until the flag is set.
> > > > >
> > > > > And in fact, it does kind of exist: IRQF_NO_AUTOEN, and you would call
> > > > > enable_irq instead of dev->ok = true, except
> > > > > - it doesn't work with affinity managed IRQs
> > > > > - it does not work with shared IRQs
> > > > >
> > > > > So using dev->ok as you propose above seems better at this point.
> > > >
> > > > Unless there is a big enough amount of drivers which could make use of a
> > > > generic mechanism for that.
> > > >
> > > > >> If any driver does this in the wrong order, then the driver is
> > > > >> broken.
> > > > >
> > > > > I agree, however:
> > > > > $ git grep synchronize_irq `git grep -l request_irq drivers/net/`|wc -l
> > > > > 113
> > > > > $ git grep -l request_irq drivers/net/|wc -l
> > > > > 397
> > > > >
> > > > > I suspect there are more drivers which in theory need the
> > > > > synchronize_irq dance but in practice do not execute it.
> > > >
> > > > That really depends on when the driver requests the interrupt, when
> > > > it actually enables the interrupt in the device itself
> > >
> > > This last point does not matter since we are talking about protecting
> > > against buggy/malicious devices. They can inject the interrupt anyway
> > > even if driver did not configure it.
> > >
> > > > and how the
> > > > interrupt service routine works.
> > > >
> > > > So just doing that grep dance does not tell much. You really have to do
> > > > a case by case analysis.
> > > >
> > > > Thanks,
> > > >
> > > >         tglx
> > >
> > >
> > > I agree. In fact, at least for network the standard approach is to
> > > request interrupts in the open call, virtio net is unusual
> > > in doing it in probe. We should consider changing that.
> > > Jason?
> >
> > This probably works only for virtio-net and it looks like not trivial
> > since we don't have a specific core API to request interrupts.
> >
> > Thanks
>
> We'll need a new API, for sure. E.g.  find vqs with no
> callback on probe, and then virtio_request_vq_callbacks separately.
>
> The existing API that specifies callbacks during find vqs
> can be used by other drivers.

Ok, I will do it.

Thanks

>
> > >
> > > --
> > > MST
> > >
>

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
