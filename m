Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 15AB4C433F5
	for <virtualization@archiver.kernel.org>; Wed, 11 May 2022 08:59:07 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id A1D7360B9A;
	Wed, 11 May 2022 08:59:07 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id xsIj3j9f-JkI; Wed, 11 May 2022 08:59:06 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 4050C60BBD;
	Wed, 11 May 2022 08:59:06 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 139A1C0039;
	Wed, 11 May 2022 08:59:06 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id EB155C002D
 for <virtualization@lists.linux-foundation.org>;
 Wed, 11 May 2022 08:59:04 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id CAB0B81340
 for <virtualization@lists.linux-foundation.org>;
 Wed, 11 May 2022 08:59:04 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp1.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id VUw1QuAjJOzq
 for <virtualization@lists.linux-foundation.org>;
 Wed, 11 May 2022 08:59:03 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp1.osuosl.org (Postfix) with ESMTPS id C858D83216
 for <virtualization@lists.linux-foundation.org>;
 Wed, 11 May 2022 08:59:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1652259541;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=yoGeyphSepardEf41QcL1JLghov0W4AMX9bIl+aH1nM=;
 b=CK1wCbO8+fW9Kn9VfO5muDnmfWHTziMAW+g/wFGk3B/JGYgPMA435N6JW4YBK6ShSH5xSR
 rq54GTHhQ9IeQKzWPLWbWr3BhHPCB1o1OYWLNk51+KatK9i1O/frj1PxYY7IjyCahMxc58
 8RL4b+OVI3fdapfymrp1DrnreKEVA+o=
Received: from mail-lf1-f70.google.com (mail-lf1-f70.google.com
 [209.85.167.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-561-TN5k0u1hMDGnecdJknNU8g-1; Wed, 11 May 2022 04:58:58 -0400
X-MC-Unique: TN5k0u1hMDGnecdJknNU8g-1
Received: by mail-lf1-f70.google.com with SMTP id
 g2-20020a0565123b8200b004725c7af360so548821lfv.19
 for <virtualization@lists.linux-foundation.org>;
 Wed, 11 May 2022 01:58:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=yoGeyphSepardEf41QcL1JLghov0W4AMX9bIl+aH1nM=;
 b=s/1wRGSLSLVrl9jvljchI8kMNxHTbhLeQ0hJc/jnX5qU95lIK69VIDQXeHG3Z+E/xX
 qUQvkVKHNG9RpgO3xlOfKmixEnc8BHIY66uDIR9avvRdPJi1P0p/yz563wyc2s9DcY5F
 EUezW4VD9VWiQvkiTtyJyP44X4Jly1zLGxr0BnItnkXiWbXgvxYbVp4eeauiaFBvdJmr
 ClaKR6TKwja88iGGwwdHksB305RB+RV46uZjVH2EUFY/UZraOZxNkCuMgjElt76mhK/g
 SbZxbsWi28fuISPKxTGuLxXUWJRPiQl84J3A02eL72GPjdsI65+KB7mUtHYPmcMKiuFr
 V0vA==
X-Gm-Message-State: AOAM530yCHkATEzWnb9QaGunkTwDkP7NAoixIfqHEORLu7/P8s8chROl
 M+acMZUy9sBNnICpZ3YscHmVVMsbiEyT5Gzqc2TwWez6+SNpiMbY+xDZVJ19lEsXgaS/nuG3n2U
 3hVxSa1/jXF/nrTqbu9xV+rYgcyWsjNkZqxXrUcDxyDly3L14NLwZ98vlYA==
X-Received: by 2002:ac2:4e14:0:b0:474:1f4d:9b86 with SMTP id
 e20-20020ac24e14000000b004741f4d9b86mr12432606lfr.257.1652259536955; 
 Wed, 11 May 2022 01:58:56 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxhoUKK046Hk4wwh632lBSQIvz0Gb2nt3PwbE+4jQq+SUbuyBn9aimQzYyODOcHcNl99FU4YVjonRabwAYO/Xg=
X-Received: by 2002:ac2:4e14:0:b0:474:1f4d:9b86 with SMTP id
 e20-20020ac24e14000000b004741f4d9b86mr12432585lfr.257.1652259536769; Wed, 11
 May 2022 01:58:56 -0700 (PDT)
MIME-Version: 1.0
References: <20220507071954.14455-1-jasowang@redhat.com>
 <20220507071954.14455-7-jasowang@redhat.com>
 <20220510072451-mutt-send-email-mst@kernel.org>
 <CACGkMEvWFyEqeeXYEmbU4TWtnj9Ku6J7jLK_7MueuFvpR7FiGg@mail.gmail.com>
 <87r150bi0d.fsf@redhat.com>
In-Reply-To: <87r150bi0d.fsf@redhat.com>
From: Jason Wang <jasowang@redhat.com>
Date: Wed, 11 May 2022 16:58:45 +0800
Message-ID: <CACGkMEtPk9P4KhJ5wTOLj9CZoKDx9-X_5uLRVBag692x4s9SrA@mail.gmail.com>
Subject: Re: [PATCH V4 6/9] virtio-ccw: implement synchronize_cbs()
To: Cornelia Huck <cohuck@redhat.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=jasowang@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Cc: Cindy Lu <lulu@redhat.com>, "Paul E. McKenney" <paulmck@kernel.org>,
 "Michael S. Tsirkin" <mst@redhat.com>, Peter Zijlstra <peterz@infradead.org>,
 Marc Zyngier <maz@kernel.org>, linux-kernel <linux-kernel@vger.kernel.org>,
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

On Wed, May 11, 2022 at 4:17 PM Cornelia Huck <cohuck@redhat.com> wrote:
>
> On Wed, May 11 2022, Jason Wang <jasowang@redhat.com> wrote:
>
> > On Tue, May 10, 2022 at 7:28 PM Michael S. Tsirkin <mst@redhat.com> wrote:
> >>
> >> On Sat, May 07, 2022 at 03:19:51PM +0800, Jason Wang wrote:
> >> > @@ -1106,6 +1130,7 @@ static void virtio_ccw_int_handler(struct ccw_device *cdev,
> >> >                       vcdev->err = -EIO;
> >> >       }
> >> >       virtio_ccw_check_activity(vcdev, activity);
> >> > +     read_lock_irqsave(&vcdev->irq_lock, flags);
> >> >       for_each_set_bit(i, indicators(vcdev),
> >> >                        sizeof(*indicators(vcdev)) * BITS_PER_BYTE) {
> >> >               /* The bit clear must happen before the vring kick. */
> >>
> >> Cornelia sent a lockdep trace on this.
> >>
> >> Basically I think this gets the irqsave/restore logic wrong.
> >> It attempts to disable irqs in the handler (which is an interrupt
> >> anyway).
> >
> > The reason I use irqsave/restore is that it can be called from process
> > context (if I was not wrong), e.g from io_subchannel_quiesce().
>
> io_subchannel_quiesce() should disable interrupts, though? Otherwise, it
> would be a bug.

Right, it was protected by a spin_lock_irq(), but I can see other
cdev->handler() in e.g device_fsm.c, the irq status is not obvious, do
they have the same assumption which IRQ is disabled?

Thanks

>

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
