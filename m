Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A1C02C433EF
	for <virtualization@archiver.kernel.org>; Tue, 29 Mar 2022 14:38:07 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 258044025E;
	Tue, 29 Mar 2022 14:38:07 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id fXDdC-tDsXfd; Tue, 29 Mar 2022 14:38:06 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 4F67B40277;
	Tue, 29 Mar 2022 14:38:05 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 2BB06C001D;
	Tue, 29 Mar 2022 14:38:05 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 854FDC0012
 for <virtualization@lists.linux-foundation.org>;
 Tue, 29 Mar 2022 14:38:03 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 73A168429F
 for <virtualization@lists.linux-foundation.org>;
 Tue, 29 Mar 2022 14:38:03 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp1.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 0E9o1AvYD7yp
 for <virtualization@lists.linux-foundation.org>;
 Tue, 29 Mar 2022 14:38:02 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp1.osuosl.org (Postfix) with ESMTPS id AF1B684249
 for <virtualization@lists.linux-foundation.org>;
 Tue, 29 Mar 2022 14:38:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1648564681;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=phRSkDpN4Oul95zrD2pvhXv5WfnDRoZp6xYqZyAQWOU=;
 b=RsYyzKnW8gRwPWMVBU8WjltJsOaoxn39OS2bHwJQBfI38uaWOIQWqrN5+82BPsXrczGqzQ
 QBfNPqiKE8MWTj2Es89LnS/oawrXjBgv1B5xhSlwoxGrDkvUtrJTTs1eLDSKMI3Mq6tfAy
 Sb1SGyZdyyXoAQrsEuJaqgMZYJwRxQQ=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-542-fIz_2yMLMoWOLLinM7QuJw-1; Tue, 29 Mar 2022 10:38:00 -0400
X-MC-Unique: fIz_2yMLMoWOLLinM7QuJw-1
Received: by mail-wm1-f70.google.com with SMTP id
 m185-20020a1c26c2000000b0038c9e1197f6so2051864wmm.4
 for <virtualization@lists.linux-foundation.org>;
 Tue, 29 Mar 2022 07:38:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=phRSkDpN4Oul95zrD2pvhXv5WfnDRoZp6xYqZyAQWOU=;
 b=BuOBflPpnT3wZH6+eYYN265cDSr2QQILrWzfZa1oH77QGO+Wi02nd9PJHV9AbOJEpm
 fr/SCk05VUtAOQaP5daKW9k8+Z3HmG1hyw1hKxKy9CUG5SPybKtk85zAcQVt9+GIIdkj
 RZE/yXBjshvj9Sthz5nwkWBWu/Ikti9zSFjyJQ71e/F9Gi6aPP0J9H1+d3bRjzb+Qdia
 PUkZA58PqGRzfgZnXDFSFls1dBFQP3rSUg9DAFLw7vzkEo/FQ3F5fo7TPDYoPmFgBVhc
 D8iIPDzNTBFMAVyr4Gu4BGXOYWb6AdHAJkHkhgBNOfKXDm26DS1sI9YyMJege70Gikey
 rYMw==
X-Gm-Message-State: AOAM5312uRf7xynjcG8RStNBaJODUIJ9v2ih/rz8TiVaA00lcJzCgTzF
 2KuiXg+up+MI4X62bU2TSwt9TPTTmON5d4rEm5F7iZaPzQX6bwfafJiUkwqB9neGpR3LFdmq2BK
 grkKzoZoC+Cc7GrNzzi2wBZ/69ItrqAhSqyXuqbtVUA==
X-Received: by 2002:a1c:f413:0:b0:37b:d1de:5762 with SMTP id
 z19-20020a1cf413000000b0037bd1de5762mr7472950wma.108.1648564678949; 
 Tue, 29 Mar 2022 07:37:58 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwHdbEkKXOoWfvK6LYBI3WT4Tuyh2gv+TYwixKz1bLZ9mvPfp452vVOpd5o/3N7r+dWpmKawA==
X-Received: by 2002:a1c:f413:0:b0:37b:d1de:5762 with SMTP id
 z19-20020a1cf413000000b0037bd1de5762mr7472914wma.108.1648564678647; 
 Tue, 29 Mar 2022 07:37:58 -0700 (PDT)
Received: from redhat.com ([2.52.9.207]) by smtp.gmail.com with ESMTPSA id
 14-20020a056000154e00b00203f8adde0csm19010792wry.32.2022.03.29.07.37.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 29 Mar 2022 07:37:57 -0700 (PDT)
Date: Tue, 29 Mar 2022 10:37:53 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Thomas Gleixner <tglx@linutronix.de>
Subject: Re:
Message-ID: <20220329100859-mutt-send-email-mst@kernel.org>
References: <Yj1hkpyUqJE9sQ2p@redhat.com>
 <CACGkMEunsuWhn+aB2dM7noU257M9JV6jDjkQXLyOA+GjEoz_iw@mail.gmail.com>
 <20220325050947-mutt-send-email-mst@kernel.org>
 <CACGkMEvioAVMmB+ab2xXB2YPECtwi1J55u8mRRk9-JAjFSZ8vg@mail.gmail.com>
 <20220325060659-mutt-send-email-mst@kernel.org>
 <CACGkMEu4mRfNbJXJtAFzhyd55fD7phUDKnVtYW0aqRnQmT_bYw@mail.gmail.com>
 <20220328015757-mutt-send-email-mst@kernel.org>
 <CACGkMEu+fax6YYwhfbc1yoSxv6o1FTQyrOheVTmUfqGvmbAEfA@mail.gmail.com>
 <20220328062452-mutt-send-email-mst@kernel.org>
 <87fsn1f96e.ffs@tglx>
MIME-Version: 1.0
In-Reply-To: <87fsn1f96e.ffs@tglx>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=mst@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: "Paul E. McKenney" <paulmck@kernel.org>,
 Peter Zijlstra <peterz@infradead.org>, Marc Zyngier <maz@kernel.org>,
 Keir Fraser <keirf@google.com>, linux-kernel <linux-kernel@vger.kernel.org>,
 virtualization <virtualization@lists.linux-foundation.org>
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

On Tue, Mar 29, 2022 at 10:35:21AM +0200, Thomas Gleixner wrote:
> On Mon, Mar 28 2022 at 06:40, Michael S. Tsirkin wrote:
> > On Mon, Mar 28, 2022 at 02:18:22PM +0800, Jason Wang wrote:
> >> > > So I think we might talk different issues:
> >> > >
> >> > > 1) Whether request_irq() commits the previous setups, I think the
> >> > > answer is yes, since the spin_unlock of desc->lock (release) can
> >> > > guarantee this though there seems no documentation around
> >> > > request_irq() to say this.
> >> > >
> >> > > And I can see at least drivers/video/fbdev/omap2/omapfb/dss/dispc.c is
> >> > > using smp_wmb() before the request_irq().
> 
> That's a complete bogus example especially as there is not a single
> smp_rmb() which pairs with the smp_wmb().
> 
> >> > > And even if write is ordered we still need read to be ordered to be
> >> > > paired with that.
> >
> > IMO it synchronizes with the CPU to which irq is
> > delivered. Otherwise basically all drivers would be broken,
> > wouldn't they be?
> > I don't know whether it's correct on all platforms, but if not
> > we need to fix request_irq.
> 
> There is nothing to fix:
> 
> request_irq()
>    raw_spin_lock_irq(desc->lock);       // ACQUIRE
>    ....
>    raw_spin_unlock_irq(desc->lock);     // RELEASE
> 
> interrupt()
>    raw_spin_lock(desc->lock);           // ACQUIRE
>    set status to IN_PROGRESS
>    raw_spin_unlock(desc->lock);         // RELEASE
>    invoke handler()
> 
> So anything which the driver set up _before_ request_irq() is visible to
> the interrupt handler. No?
> >> What happens if an interrupt is raised in the middle like:
> >> 
> >> smp_store_release(dev->irq_soft_enabled, true)
> >> IRQ handler
> >> synchornize_irq()
> 
> This is bogus. The obvious order of things is:
> 
>     dev->ok = false;
>     request_irq();
> 
>     moar_setup();
>     synchronize_irq();  // ACQUIRE + RELEASE
>     dev->ok = true;
> 
> The reverse operation on teardown:
> 
>     dev->ok = false;
>     synchronize_irq();  // ACQUIRE + RELEASE
> 
>     teardown();
> 
> So in both cases a simple check in the handler is sufficient:
> 
> handler()
>     if (!dev->ok)
>     	return;


Thanks a lot for the analysis Thomas. This is more or less what I was
thinking.

> 
> I'm not understanding what you folks are trying to "fix" here.

We are trying to fix the driver since at the moment it does not
have the dev->ok flag at all.


And I suspect virtio is not alone in that.
So it would have been nice if there was a standard flag
replacing the driver-specific dev->ok above, and ideally
would also handle the case of an interrupt triggering
too early by deferring the interrupt until the flag is set.

And in fact, it does kind of exist: IRQF_NO_AUTOEN, and you would call
enable_irq instead of dev->ok = true, except
- it doesn't work with affinity managed IRQs
- it does not work with shared IRQs

So using dev->ok as you propose above seems better at this point.

> If any
> driver does this in the wrong order, then the driver is broken.

I agree, however:
$ git grep synchronize_irq `git grep -l request_irq drivers/net/`|wc -l
113
$ git grep -l request_irq drivers/net/|wc -l
397

I suspect there are more drivers which in theory need the
synchronize_irq dance but in practice do not execute it.


> Sure, you can do the same with:
> 
>     dev->ok = false;
>     request_irq();
>     moar_setup();
>     smp_wmb();
>     dev->ok = true;
> 
> for the price of a smp_rmb() in the interrupt handler:
> 
> handler()
>     if (!dev->ok)
>     	return;
>     smp_rmb();
> 
> but that's only working for the setup case correctly and not for
> teardown.
> 
> Thanks,
> 
>         tglx

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
