Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E84CBC433F5
	for <virtualization@archiver.kernel.org>; Tue, 12 Apr 2022 06:56:07 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 7D95D410C6;
	Tue, 12 Apr 2022 06:56:07 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 4fAKmoOfT_8V; Tue, 12 Apr 2022 06:56:06 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTPS id D47CC410C2;
	Tue, 12 Apr 2022 06:56:05 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 92801C0082;
	Tue, 12 Apr 2022 06:56:05 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 00E66C002F
 for <virtualization@lists.linux-foundation.org>;
 Tue, 12 Apr 2022 06:56:04 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id D473760F04
 for <virtualization@lists.linux-foundation.org>;
 Tue, 12 Apr 2022 06:56:03 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp3.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id x6VsSiNRe_Ki
 for <virtualization@lists.linux-foundation.org>;
 Tue, 12 Apr 2022 06:56:02 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 8ECDA60E36
 for <virtualization@lists.linux-foundation.org>;
 Tue, 12 Apr 2022 06:56:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1649746561;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=GN5vkjRmgkPNx751McI5DU0rpDoKJKayXCERhKWgOHo=;
 b=auJ523HLMwOV18ObSx+6XCSN+jPKB1mAccykpXjUAu7wjGgsrlEtZo/72JMWpkKq7WVw+G
 bYpl2xHKbmo1HVDTIipp3kjuxb+kNpM84r76mQ7lhSSjriUPSL7NjZ4SKLok89NGegs98X
 6Cg/NT+tkuYlvoAD8WEXAK27TSTGZec=
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-447-evi6gyzpO3unXxojIu_CKg-1; Tue, 12 Apr 2022 02:55:58 -0400
X-MC-Unique: evi6gyzpO3unXxojIu_CKg-1
Received: by mail-ed1-f71.google.com with SMTP id
 eg29-20020a056402289d00b0041d6db0fbc9so5050602edb.9
 for <virtualization@lists.linux-foundation.org>;
 Mon, 11 Apr 2022 23:55:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=GN5vkjRmgkPNx751McI5DU0rpDoKJKayXCERhKWgOHo=;
 b=BCwF10ZzTXA+wXaE3d+RAxEWbVth/oNdkRWEtjtLeXVBM0MgKAWULniJWmMDoodKaU
 IXxg2Ww9wLOB1uVfpx9n0Ip/cUe1IlPtBBMGwTUUWv7ZGsCrBG8Yj9NGvoIQQs6dnzly
 /j2Hum8gMy5OpYnte5iZXrB/GhQ1yaRdn3ARWbl56xEBOZGyJ4RBnm1oI8E+2avKXmgt
 ltpV0gsM/fyApEB9aeRKLDp0DJLcnc12leXE8vPUyA9ZvjSlZa3XyHtCyFiRs81oq4cZ
 T+rJeUV9yG7f7VVmPGTwOnKLX7nFmyHs2ZIJFiYLfHXMq0CjlbkRhg3/apIDdfsMAFKO
 jN/A==
X-Gm-Message-State: AOAM533mz0BBy5zaOBacIgJCnlXn9UoCXFSK9JdA5LUMUmjYbdAx67t9
 lu7dqV6Zg/CsD3ux5kS3fy2wbF4w5Vq6Aia3eojD4G3x+VAqItNGwHtGqhF6ICs3dW5D8YOy9w7
 R8SNeQQ+rL7E1wNmEsIBDkXW3LpOHi6tWyJqOma5VIw==
X-Received: by 2002:aa7:cc96:0:b0:410:b9ac:241 with SMTP id
 p22-20020aa7cc96000000b00410b9ac0241mr37641961edt.246.1649746557015; 
 Mon, 11 Apr 2022 23:55:57 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxGPxug4QSaPb0hUaH35LBenThin66afliFP6NyNmncmrZUcM1TJgpijjoRwtDcypb/fdXkvA==
X-Received: by 2002:aa7:cc96:0:b0:410:b9ac:241 with SMTP id
 p22-20020aa7cc96000000b00410b9ac0241mr37641949edt.246.1649746556825; 
 Mon, 11 Apr 2022 23:55:56 -0700 (PDT)
Received: from redhat.com ([2.52.1.156]) by smtp.gmail.com with ESMTPSA id
 c4-20020a170906340400b006d077e850b5sm12693341ejb.23.2022.04.11.23.55.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 11 Apr 2022 23:55:56 -0700 (PDT)
Date: Tue, 12 Apr 2022 02:55:52 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Thomas Gleixner <tglx@linutronix.de>
Subject: Re:
Message-ID: <20220412025405-mutt-send-email-mst@kernel.org>
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
> 
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

Does this need to be if (!READ_ONCE(dev->ok)) ?



> I'm not understanding what you folks are trying to "fix" here. If any
> driver does this in the wrong order, then the driver is broken.
> 
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
