Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 25E92C433EF
	for <virtualization@archiver.kernel.org>; Thu, 12 May 2022 03:29:57 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id BBE8E4191A;
	Thu, 12 May 2022 03:29:56 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id aLs41rhjEjzz; Thu, 12 May 2022 03:29:55 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 024B641752;
	Thu, 12 May 2022 03:29:55 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id CC432C0032;
	Thu, 12 May 2022 03:29:54 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 6A895C002D
 for <virtualization@lists.linux-foundation.org>;
 Thu, 12 May 2022 03:29:54 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 4A4AF60BBA
 for <virtualization@lists.linux-foundation.org>;
 Thu, 12 May 2022 03:29:54 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp3.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id ZD0YJt4GPiBo
 for <virtualization@lists.linux-foundation.org>;
 Thu, 12 May 2022 03:29:53 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 8441F60B8E
 for <virtualization@lists.linux-foundation.org>;
 Thu, 12 May 2022 03:29:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1652326192;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=oiuB6/1rpu58Tvln0nC0vsy2jP9iWIIb82ww3FDDrRc=;
 b=CzFUDnJDGhEZEOgBrhOo53SWe0HaEhTrRxeluhaBRNGllZj28Gad+zdyPdoiMeZBKB6OuP
 lLx/nvg6HV3XtowELRx8UFJt4sOJiwuRUURx4hgdrDu3R7vm7kwkGWjw+oH8H1AvFBJ+pi
 QhUJ8ImLePAsxdSNSU3jVmRW5R/eOaA=
Received: from mail-lf1-f69.google.com (mail-lf1-f69.google.com
 [209.85.167.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-176-XW2BfVUbPYqn6i984fegtQ-1; Wed, 11 May 2022 23:29:51 -0400
X-MC-Unique: XW2BfVUbPYqn6i984fegtQ-1
Received: by mail-lf1-f69.google.com with SMTP id
 e10-20020a05651236ca00b00474337bbe36so1635319lfs.2
 for <virtualization@lists.linux-foundation.org>;
 Wed, 11 May 2022 20:29:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=oiuB6/1rpu58Tvln0nC0vsy2jP9iWIIb82ww3FDDrRc=;
 b=ZAx5WPB2jhdbGkueLyUEMdhvzy94Km41aIWliLWUXloe4hJ02qr8VGirP1OdDCA6/u
 XGCvpn7yshsXVAvLJk19eRUhpd7qGomEIIoJJyeyLRvAp/HrPgnRuRBu0BhSHg+FeqC2
 o50fVprBP+rgmXt3kK3beFeGmPsE6MJQ7FfbTVfxYDXAwa26h8sz9Q9hClgt1ioMduKs
 wiprpz9pKu+rPFh7zDTessar/+10oCsAoLhRl3E6aFennNpCYoSjmeqMC0HuP4v/FvKG
 MieGPT3aKgfoHj378/uetP+If9VsIcytbpyJnh+jDbjWiBtZbESg5AxJB+cVMQKAUav9
 bSdA==
X-Gm-Message-State: AOAM532oezYvAMIOrHTXmtk38/Ys7kgzduuddsOV/LH7oGCxjf3omOZr
 uQIvuuybKx7TscDA3F6jzVFlA0p8nNZ8asiAqGOa1+z7hJF/AkpSxPv+5Czwn6bGs476SbQ7K0g
 vgDPCyEz0Vd2VdMWydorWfPgvzkECAHLB7KdkAPVgEs7/NBsqpjqCY0hGKA==
X-Received: by 2002:a05:651c:89:b0:250:87c9:d4e6 with SMTP id
 9-20020a05651c008900b0025087c9d4e6mr19554532ljq.315.1652326189667; 
 Wed, 11 May 2022 20:29:49 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxvGZl7k97bjA3gCsBTaYT9EmgeyM3io1yNju3NEal0LqRm3HelICd4QB0dYrDMJ/jB6zAA972jJiPUWWm1pPU=
X-Received: by 2002:a05:651c:89:b0:250:87c9:d4e6 with SMTP id
 9-20020a05651c008900b0025087c9d4e6mr19554516ljq.315.1652326189448; Wed, 11
 May 2022 20:29:49 -0700 (PDT)
MIME-Version: 1.0
References: <20220507071954.14455-1-jasowang@redhat.com>
 <20220507071954.14455-7-jasowang@redhat.com>
 <20220510072451-mutt-send-email-mst@kernel.org>
 <CACGkMEvWFyEqeeXYEmbU4TWtnj9Ku6J7jLK_7MueuFvpR7FiGg@mail.gmail.com>
 <87r150bi0d.fsf@redhat.com>
 <CACGkMEtPk9P4KhJ5wTOLj9CZoKDx9-X_5uLRVBag692x4s9SrA@mail.gmail.com>
 <87lev8bffh.fsf@redhat.com>
 <CACGkMEviB6-SmJmbV3h2zhaTwnep=WQLdnHXRc6D+UUxRXijfg@mail.gmail.com>
 <YnvNmtPgip5knLHP@tuxmaker.boeblingen.de.ibm.com>
In-Reply-To: <YnvNmtPgip5knLHP@tuxmaker.boeblingen.de.ibm.com>
From: Jason Wang <jasowang@redhat.com>
Date: Thu, 12 May 2022 11:29:38 +0800
Message-ID: <CACGkMEuMXMTcV7TF7qje5z2H6sXqShcWRRMVatFh5yneDfPwgA@mail.gmail.com>
Subject: Re: [PATCH V4 6/9] virtio-ccw: implement synchronize_cbs()
To: Vineeth Vijayan <vneethv@linux.ibm.com>
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

On Wed, May 11, 2022 at 10:52 PM Vineeth Vijayan <vneethv@linux.ibm.com> wrote:
>
> On Wed, May 11, 2022 at 05:28:11PM +0800, Jason Wang wrote:
> > On Wed, May 11, 2022 at 5:13 PM Cornelia Huck <cohuck@redhat.com> wrote:
> > >
> > > On Wed, May 11 2022, Jason Wang <jasowang@redhat.com> wrote:
> > >
> > > > On Wed, May 11, 2022 at 4:17 PM Cornelia Huck <cohuck@redhat.com> wrote:
> > > >>
> > > >> On Wed, May 11 2022, Jason Wang <jasowang@redhat.com> wrote:
> > > >>
> > > >> > On Tue, May 10, 2022 at 7:28 PM Michael S. Tsirkin <mst@redhat.com> wrote:
> > > >> >>
> > > >> >> On Sat, May 07, 2022 at 03:19:51PM +0800, Jason Wang wrote:
> > > >> >> > @@ -1106,6 +1130,7 @@ static void virtio_ccw_int_handler(struct ccw_device *cdev,
> > > >> >> >                       vcdev->err = -EIO;
> > > >> >> >       }
> > > >> >> >       virtio_ccw_check_activity(vcdev, activity);
> > > >> >> > +     read_lock_irqsave(&vcdev->irq_lock, flags);
> > > >> >> >       for_each_set_bit(i, indicators(vcdev),
> > > >> >> >                        sizeof(*indicators(vcdev)) * BITS_PER_BYTE) {
> > > >> >> >               /* The bit clear must happen before the vring kick. */
> > > >> >>
> > > >> >> Cornelia sent a lockdep trace on this.
> > > >> >>
> > > >> >> Basically I think this gets the irqsave/restore logic wrong.
> > > >> >> It attempts to disable irqs in the handler (which is an interrupt
> > > >> >> anyway).
> > > >> >
> > > >> > The reason I use irqsave/restore is that it can be called from process
> > > >> > context (if I was not wrong), e.g from io_subchannel_quiesce().
> > > >>
> > > >> io_subchannel_quiesce() should disable interrupts, though? Otherwise, it
> > > >> would be a bug.
> > > >
> > > > Right, it was protected by a spin_lock_irq(), but I can see other
> > > > cdev->handler() in e.g device_fsm.c, the irq status is not obvious, do
> > > > they have the same assumption which IRQ is disabled?
> > >
> > > Yes, that should be the case for any invocations via the fsm as well.
> > >
> >
> > Ok.
> >
> > > It's been some time since I've worked on that part of the code, though,
> > > so let's cc: the s390 cio maintainers so that they can speak up if I'm
> > > wrong.
> >
> > Ok, I will do that.
> >
> > Thanks
> >
> > >
> Thank you Corny to looking in to this. I agree, the cdev->handler is
> called with lock held. And as you mentioned, in the fsm these handler
> invocations are done with IRQ disabled, which will otherwise end up in a
> deadlock.
> thanks.
>

Thanks a lot for the confirmation, I will use
spin_lock()/spin_unlock() in the next version.

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
