Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E59DBC433F5
	for <virtualization@archiver.kernel.org>; Wed, 11 May 2022 09:28:39 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 935D1610A6;
	Wed, 11 May 2022 09:28:39 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 7LkVIyiR-HS0; Wed, 11 May 2022 09:28:38 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 4CF3161096;
	Wed, 11 May 2022 09:28:38 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 238DDC0032;
	Wed, 11 May 2022 09:28:38 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id A2549C002D
 for <virtualization@lists.linux-foundation.org>;
 Wed, 11 May 2022 09:28:37 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 82B8B41752
 for <virtualization@lists.linux-foundation.org>;
 Wed, 11 May 2022 09:28:37 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp4.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id T00wXNdGqqGj
 for <virtualization@lists.linux-foundation.org>;
 Wed, 11 May 2022 09:28:36 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 94A0841635
 for <virtualization@lists.linux-foundation.org>;
 Wed, 11 May 2022 09:28:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1652261315;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=fnj3eCg7s0TS1ramQcFiuiKen3jow8jquS3FS71SHPU=;
 b=BCUPGe44b/hdkwItpnMRh1T9feKiDLKtsTIREvUFIJRvDVJJYepXH4UwKhjFWZK0DlmTSO
 B8wPM3eF3RwuAK0khSa9SJpyhY2p0F1syB3G7NWQvRYcK/Yv6dRE9JqGALRBAUR1bbZqI+
 aVBwQLMZ3lG9dHLNtVteHwZYDium/aY=
Received: from mail-lj1-f198.google.com (mail-lj1-f198.google.com
 [209.85.208.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-108-Uo4c3AYgO5WhJX0enWmWug-1; Wed, 11 May 2022 05:28:24 -0400
X-MC-Unique: Uo4c3AYgO5WhJX0enWmWug-1
Received: by mail-lj1-f198.google.com with SMTP id
 k8-20020a2e92c8000000b0024f249d1770so517047ljh.23
 for <virtualization@lists.linux-foundation.org>;
 Wed, 11 May 2022 02:28:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=fnj3eCg7s0TS1ramQcFiuiKen3jow8jquS3FS71SHPU=;
 b=bIutSaXoYVoztFi6L/0+p9mqkEVXkVZ2PnwBZ33Wwyem41TiBOZeXGzobYsDRYz9wW
 LmDHs9hFKJvoz478kiKFG5/uUN9idvlE7qxnnDUGoRLWXyx1NboW6v1NhZTYqforSuRh
 r6i3pSUrCJSWM/0iQRRQnO1+KBM+YuS5JzxaGGA0Bt0X1wzv769YALHJv+KC96iipPAz
 pREn6ZSBny+UXBtHrIzguRagojaNmHYszw03n3eyHp8aQ2+3gvLmWHbvGiZcUnE7EO3i
 bXYmQfumk8url8JRagKjF5GffVi+KPkXdWKRtIiUSBcbneyrL2ie2Whhpg3t9Tc8kDDE
 JS3w==
X-Gm-Message-State: AOAM530+Lcmn0HNQjDtxahZ5qnSXpRgk/006Aa5/J4ZOxUlw0NOPTS4A
 5eNIicAyTXe6PTPb8IBl0KByx/00PR7vzlgA5MtYjb8O1nrTVIAAmKmc7H8yW58Usd51nO+0E3x
 dpqoywZfLCfv9oAxhTt9X18XXBqnqqZQFdpp+/CW898/f8AGROQRuKJjWkA==
X-Received: by 2002:a05:6512:1395:b0:446:d382:79a5 with SMTP id
 p21-20020a056512139500b00446d38279a5mr18757585lfa.210.1652261303108; 
 Wed, 11 May 2022 02:28:23 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJziEsE0wruGYH+kUCMRRSImc8q7QCatle/uLfreXdxbIWtU4dwTUYlK/rx6iWNQiOJla5rpc0/Sn+mLSDLqQ1Y=
X-Received: by 2002:a05:6512:1395:b0:446:d382:79a5 with SMTP id
 p21-20020a056512139500b00446d38279a5mr18757555lfa.210.1652261302901; Wed, 11
 May 2022 02:28:22 -0700 (PDT)
MIME-Version: 1.0
References: <20220507071954.14455-1-jasowang@redhat.com>
 <20220507071954.14455-7-jasowang@redhat.com>
 <20220510072451-mutt-send-email-mst@kernel.org>
 <CACGkMEvWFyEqeeXYEmbU4TWtnj9Ku6J7jLK_7MueuFvpR7FiGg@mail.gmail.com>
 <87r150bi0d.fsf@redhat.com>
 <CACGkMEtPk9P4KhJ5wTOLj9CZoKDx9-X_5uLRVBag692x4s9SrA@mail.gmail.com>
 <87lev8bffh.fsf@redhat.com>
In-Reply-To: <87lev8bffh.fsf@redhat.com>
From: Jason Wang <jasowang@redhat.com>
Date: Wed, 11 May 2022 17:28:11 +0800
Message-ID: <CACGkMEviB6-SmJmbV3h2zhaTwnep=WQLdnHXRc6D+UUxRXijfg@mail.gmail.com>
Subject: Re: [PATCH V4 6/9] virtio-ccw: implement synchronize_cbs()
To: Cornelia Huck <cohuck@redhat.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=jasowang@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Cc: Peter Oberparleiter <oberpar@linux.ibm.com>, Cindy Lu <lulu@redhat.com>,
 "Paul E. McKenney" <paulmck@kernel.org>, "Michael S. Tsirkin" <mst@redhat.com>,
 Peter Zijlstra <peterz@infradead.org>, Marc Zyngier <maz@kernel.org>,
 linux-kernel <linux-kernel@vger.kernel.org>,
 virtualization <virtualization@lists.linux-foundation.org>,
 Halil Pasic <pasic@linux.ibm.com>, eperezma <eperezma@redhat.com>,
 Vineeth Vijayan <vneethv@linux.ibm.com>, Thomas Gleixner <tglx@linutronix.de>
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

On Wed, May 11, 2022 at 5:13 PM Cornelia Huck <cohuck@redhat.com> wrote:
>
> On Wed, May 11 2022, Jason Wang <jasowang@redhat.com> wrote:
>
> > On Wed, May 11, 2022 at 4:17 PM Cornelia Huck <cohuck@redhat.com> wrote:
> >>
> >> On Wed, May 11 2022, Jason Wang <jasowang@redhat.com> wrote:
> >>
> >> > On Tue, May 10, 2022 at 7:28 PM Michael S. Tsirkin <mst@redhat.com> wrote:
> >> >>
> >> >> On Sat, May 07, 2022 at 03:19:51PM +0800, Jason Wang wrote:
> >> >> > @@ -1106,6 +1130,7 @@ static void virtio_ccw_int_handler(struct ccw_device *cdev,
> >> >> >                       vcdev->err = -EIO;
> >> >> >       }
> >> >> >       virtio_ccw_check_activity(vcdev, activity);
> >> >> > +     read_lock_irqsave(&vcdev->irq_lock, flags);
> >> >> >       for_each_set_bit(i, indicators(vcdev),
> >> >> >                        sizeof(*indicators(vcdev)) * BITS_PER_BYTE) {
> >> >> >               /* The bit clear must happen before the vring kick. */
> >> >>
> >> >> Cornelia sent a lockdep trace on this.
> >> >>
> >> >> Basically I think this gets the irqsave/restore logic wrong.
> >> >> It attempts to disable irqs in the handler (which is an interrupt
> >> >> anyway).
> >> >
> >> > The reason I use irqsave/restore is that it can be called from process
> >> > context (if I was not wrong), e.g from io_subchannel_quiesce().
> >>
> >> io_subchannel_quiesce() should disable interrupts, though? Otherwise, it
> >> would be a bug.
> >
> > Right, it was protected by a spin_lock_irq(), but I can see other
> > cdev->handler() in e.g device_fsm.c, the irq status is not obvious, do
> > they have the same assumption which IRQ is disabled?
>
> Yes, that should be the case for any invocations via the fsm as well.
>

Ok.

> It's been some time since I've worked on that part of the code, though,
> so let's cc: the s390 cio maintainers so that they can speak up if I'm
> wrong.

Ok, I will do that.

Thanks

>

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
