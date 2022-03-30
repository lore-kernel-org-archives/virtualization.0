Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E8E29C433EF
	for <virtualization@archiver.kernel.org>; Wed, 30 Mar 2022 05:09:41 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 7AF0C842A6;
	Wed, 30 Mar 2022 05:09:41 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 4eo4sCZEkuDU; Wed, 30 Mar 2022 05:09:40 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 0D1EA84436;
	Wed, 30 Mar 2022 05:09:40 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id B9D1EC001D;
	Wed, 30 Mar 2022 05:09:39 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 1EBE4C0012
 for <virtualization@lists.linux-foundation.org>;
 Wed, 30 Mar 2022 05:09:38 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 0AD4D417D3
 for <virtualization@lists.linux-foundation.org>;
 Wed, 30 Mar 2022 05:09:38 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp4.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id sGESQ4fCOgwd
 for <virtualization@lists.linux-foundation.org>;
 Wed, 30 Mar 2022 05:09:37 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp4.osuosl.org (Postfix) with ESMTPS id B17D9417C6
 for <virtualization@lists.linux-foundation.org>;
 Wed, 30 Mar 2022 05:09:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1648616975;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=eeYUD3XUajeRCNs/Vt/JYditXRCKbb5+uzBVBz/FB5c=;
 b=XZjM1g5OqGPSiVGTCcwgyOYtjwKxfAnepgxs7N6nVNg/btuqMwbxpbC504SrNzBcdLA8A2
 b32dspWCGaNtBpM5KBzjHGPbQH/ZrnNSyRfdOb3F7Mt9CFzVforf+vegZgqc69HHQFm1FX
 qSZsA68SC9ucmQbx77orrOa48IdYaZM=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-341-GCD7Mu7xMb2nYfnF1UInZQ-1; Wed, 30 Mar 2022 01:09:32 -0400
X-MC-Unique: GCD7Mu7xMb2nYfnF1UInZQ-1
Received: by mail-wr1-f72.google.com with SMTP id
 h33-20020adf9024000000b00203fcba8aadso5507736wrh.15
 for <virtualization@lists.linux-foundation.org>;
 Tue, 29 Mar 2022 22:09:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=eeYUD3XUajeRCNs/Vt/JYditXRCKbb5+uzBVBz/FB5c=;
 b=nvD5UwjIHx548yui7IAE+StNDRsvGjtm8F+Xz32R/IsBA2i/JGubTbex4SBplwZsCa
 x/aUYDcpmSvI1Qh76soj3Ojc0TqEj+Qx0Qaf3C+vcqjh3wGraKf0RSxO5ud0zkanGmhS
 suvUgZoRzuX29cTW8aK8PRWdUuXI4HRYnp2oshheeXEPdNoG0REVZMYEKMElwuKMSKQi
 ZUQnjoYHqex0ua+nmC9t6so0ALuXIcNQ5ZWBYfy3UJWjCgd3fV9XseRVe39siMln99fc
 9pPfRpRccOXII/P4t+eWFqnc/ruMh1OUHlBDL2EgWJbfSq3BfoJLkbdJjNm46O6LMQ1g
 rFHA==
X-Gm-Message-State: AOAM53082sOJGcfih2W3VPn7oQB+3+tcCU8fk3VeaI2I/9bpVeOveMah
 20hHD7TEaT9pSHnWpkzU9RQ+sL+ku4h+8zY83NiO6sVBTTxI1J8BOpgu+5k1lufMnlajUaLmcaP
 79oOAK5C+S5oF2rPxiKuYmVuYvVUzYxSR4FB5yAC+FA==
X-Received: by 2002:adf:908e:0:b0:1e7:bea7:3486 with SMTP id
 i14-20020adf908e000000b001e7bea73486mr33607448wri.401.1648616970762; 
 Tue, 29 Mar 2022 22:09:30 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwgm9skh/llpKb0wahMYt3d2fhdEpF8cYwvjfeh9spYqrd2U2SWbZElaXEnLNn1Y8P45g2Flg==
X-Received: by 2002:adf:908e:0:b0:1e7:bea7:3486 with SMTP id
 i14-20020adf908e000000b001e7bea73486mr33607435wri.401.1648616970488; 
 Tue, 29 Mar 2022 22:09:30 -0700 (PDT)
Received: from redhat.com ([2.52.9.207]) by smtp.gmail.com with ESMTPSA id
 az26-20020adfe19a000000b00204154a1d1fsm16140858wrb.88.2022.03.29.22.09.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 29 Mar 2022 22:09:29 -0700 (PDT)
Date: Wed, 30 Mar 2022 01:09:24 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Jason Wang <jasowang@redhat.com>
Subject: Re:
Message-ID: <20220330010646-mutt-send-email-mst@kernel.org>
References: <20220325060659-mutt-send-email-mst@kernel.org>
 <CACGkMEu4mRfNbJXJtAFzhyd55fD7phUDKnVtYW0aqRnQmT_bYw@mail.gmail.com>
 <20220328015757-mutt-send-email-mst@kernel.org>
 <CACGkMEu+fax6YYwhfbc1yoSxv6o1FTQyrOheVTmUfqGvmbAEfA@mail.gmail.com>
 <20220328062452-mutt-send-email-mst@kernel.org>
 <87fsn1f96e.ffs@tglx>
 <20220329100859-mutt-send-email-mst@kernel.org>
 <87v8vweie2.ffs@tglx>
 <20220329175426-mutt-send-email-mst@kernel.org>
 <CACGkMEv2j2cJkSFfxTmaRxJ+SH6actSCZsALjvvDUPgg0h-KeA@mail.gmail.com>
MIME-Version: 1.0
In-Reply-To: <CACGkMEv2j2cJkSFfxTmaRxJ+SH6actSCZsALjvvDUPgg0h-KeA@mail.gmail.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=mst@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
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

On Wed, Mar 30, 2022 at 10:38:06AM +0800, Jason Wang wrote:
> On Wed, Mar 30, 2022 at 6:04 AM Michael S. Tsirkin <mst@redhat.com> wrote:
> >
> > On Tue, Mar 29, 2022 at 08:13:57PM +0200, Thomas Gleixner wrote:
> > > On Tue, Mar 29 2022 at 10:37, Michael S. Tsirkin wrote:
> > > > On Tue, Mar 29, 2022 at 10:35:21AM +0200, Thomas Gleixner wrote:
> > > > We are trying to fix the driver since at the moment it does not
> > > > have the dev->ok flag at all.
> > > >
> > > > And I suspect virtio is not alone in that.
> > > > So it would have been nice if there was a standard flag
> > > > replacing the driver-specific dev->ok above, and ideally
> > > > would also handle the case of an interrupt triggering
> > > > too early by deferring the interrupt until the flag is set.
> > > >
> > > > And in fact, it does kind of exist: IRQF_NO_AUTOEN, and you would call
> > > > enable_irq instead of dev->ok = true, except
> > > > - it doesn't work with affinity managed IRQs
> > > > - it does not work with shared IRQs
> > > >
> > > > So using dev->ok as you propose above seems better at this point.
> > >
> > > Unless there is a big enough amount of drivers which could make use of a
> > > generic mechanism for that.
> > >
> > > >> If any driver does this in the wrong order, then the driver is
> > > >> broken.
> > > >
> > > > I agree, however:
> > > > $ git grep synchronize_irq `git grep -l request_irq drivers/net/`|wc -l
> > > > 113
> > > > $ git grep -l request_irq drivers/net/|wc -l
> > > > 397
> > > >
> > > > I suspect there are more drivers which in theory need the
> > > > synchronize_irq dance but in practice do not execute it.
> > >
> > > That really depends on when the driver requests the interrupt, when
> > > it actually enables the interrupt in the device itself
> >
> > This last point does not matter since we are talking about protecting
> > against buggy/malicious devices. They can inject the interrupt anyway
> > even if driver did not configure it.
> >
> > > and how the
> > > interrupt service routine works.
> > >
> > > So just doing that grep dance does not tell much. You really have to do
> > > a case by case analysis.
> > >
> > > Thanks,
> > >
> > >         tglx
> >
> >
> > I agree. In fact, at least for network the standard approach is to
> > request interrupts in the open call, virtio net is unusual
> > in doing it in probe. We should consider changing that.
> > Jason?
> 
> This probably works only for virtio-net and it looks like not trivial
> since we don't have a specific core API to request interrupts.
> 
> Thanks

We'll need a new API, for sure. E.g.  find vqs with no
callback on probe, and then virtio_request_vq_callbacks separately.

The existing API that specifies callbacks during find vqs
can be used by other drivers.

> >
> > --
> > MST
> >

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
