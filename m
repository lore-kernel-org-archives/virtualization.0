Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3352EC433F5
	for <virtualization@archiver.kernel.org>; Thu, 19 May 2022 08:02:50 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id CEBA840600;
	Thu, 19 May 2022 08:02:49 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id XCtFTEnLD3dD; Thu, 19 May 2022 08:02:49 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 583BD400DA;
	Thu, 19 May 2022 08:02:48 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 307CEC0032;
	Thu, 19 May 2022 08:02:48 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 27562C002D
 for <virtualization@lists.linux-foundation.org>;
 Thu, 19 May 2022 08:02:47 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 11D4E4048D
 for <virtualization@lists.linux-foundation.org>;
 Thu, 19 May 2022 08:02:47 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id QoNxF9wDnOPq
 for <virtualization@lists.linux-foundation.org>;
 Thu, 19 May 2022 08:02:46 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 342FB400DA
 for <virtualization@lists.linux-foundation.org>;
 Thu, 19 May 2022 08:02:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1652947365;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=mBpdwym2ArG4EquWnWSi2ftom73RXQQa+Rs2uQPWbKQ=;
 b=LHQMQSUHiRGj6vv9A4x+UN4aJUlN8/oDsWNhfyWtQkmYn625XTwbAD9M2iUO9/kbNohxXF
 YaxBus9WICDEOR3APB3zXxTJgD48lh5CG1GP43EuKHm1xpWNCjywRuaKMsl6WqIWH/6hxA
 sOr1mbEJMIr+d7zqDb78A1pANjybjIQ=
Received: from mail-lf1-f70.google.com (mail-lf1-f70.google.com
 [209.85.167.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-332-xshEawrNNfOYHg3xbl2qww-1; Thu, 19 May 2022 04:02:43 -0400
X-MC-Unique: xshEawrNNfOYHg3xbl2qww-1
Received: by mail-lf1-f70.google.com with SMTP id
 w25-20020a05651234d900b0044023ac3f64so2323309lfr.0
 for <virtualization@lists.linux-foundation.org>;
 Thu, 19 May 2022 01:02:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=mBpdwym2ArG4EquWnWSi2ftom73RXQQa+Rs2uQPWbKQ=;
 b=uspU/RunrTgalIqdd31A/PhnpEQHhj0BK+Ulm09H2jW6IwGECuqGrEtHJEGE1Prmp3
 gstCLc6WijiniwUZN+WK2ySPAfET8NZCPWiCRF36CTdnU/GWTSF/NFQegaHDyXV8oMB8
 yOMLAxLr0CgNquai7OqkvT5/u/Peywklsg+TUWd3doKb+eAI/8lPtI4veqEviecrS659
 iocPc1sjk+72a+GxOByle3sT1fJzgjWI0kQUiMqVkVVMLbTS6wKepVWY+h97esSIUJHr
 bZRKMTvn2y15w2II6DtLZbbkPWVaAR2IVOYyeTTrJZRIBT/xx4E5bxDWh5u5nLpuzK/t
 xdjg==
X-Gm-Message-State: AOAM531p8RpTgc5m/MwHfmK+m0e2bAu1Fc3I2YV9F7PiGcSusZ0lms9A
 fiJfm7gFd5WMGQZeMOFX2gKRT6TmND8TBJwCRBRKxlWkjr8ktQcjtuNNkjuPw4F7u1O56Ln/+29
 K4/K5/D3knrLmGtdDdvOmGqUWN7LNNywDbShshJhg3CokPcNosBJE8S7rPA==
X-Received: by 2002:a05:6512:1395:b0:446:d382:79a5 with SMTP id
 p21-20020a056512139500b00446d38279a5mr2463618lfa.210.1652947362262; 
 Thu, 19 May 2022 01:02:42 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwnED6RSEVAGwD+6jZQlEqqnkm9njtiJZnFEYibosooBXmmsa4+cJ2PSgTUPo3sWmsUgAZgWgEnJrDT+wPlxRw=
X-Received: by 2002:a05:6512:1395:b0:446:d382:79a5 with SMTP id
 p21-20020a056512139500b00446d38279a5mr2463601lfa.210.1652947362047; Thu, 19
 May 2022 01:02:42 -0700 (PDT)
MIME-Version: 1.0
References: <20220518035951.94220-1-jasowang@redhat.com>
 <20220518035951.94220-7-jasowang@redhat.com>
 <87tu9nfaoe.fsf@redhat.com>
In-Reply-To: <87tu9nfaoe.fsf@redhat.com>
From: Jason Wang <jasowang@redhat.com>
Date: Thu, 19 May 2022 16:02:30 +0800
Message-ID: <CACGkMEsiMQ7zDZ6r-q2W=yFqW8WbMEwUc8OFd+o1JzUL-E19Ew@mail.gmail.com>
Subject: Re: [PATCH V5 6/9] virtio-ccw: implement synchronize_cbs()
To: Cornelia Huck <cohuck@redhat.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=jasowang@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Cc: linux-s390@vger.kernel.org, Peter Oberparleiter <oberpar@linux.ibm.com>,
 Cindy Lu <lulu@redhat.com>, "Paul E. McKenney" <paulmck@kernel.org>,
 mst <mst@redhat.com>, Peter Zijlstra <peterz@infradead.org>,
 Marc Zyngier <maz@kernel.org>, linux-kernel <linux-kernel@vger.kernel.org>,
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

On Wed, May 18, 2022 at 5:32 PM Cornelia Huck <cohuck@redhat.com> wrote:
>
> On Wed, May 18 2022, Jason Wang <jasowang@redhat.com> wrote:
>
> > This patch tries to implement the synchronize_cbs() for ccw. For the
> > vring_interrupt() that is called via virtio_airq_handler(), the
> > synchronization is simply done via the airq_info's lock. For the
> > vring_interrupt() that is called via virtio_ccw_int_handler(), a per
> > device rwlock is introduced ans used in the synchronization method.
>
> s/ans/and/
>

Will fix.

> >
> > Cc: Thomas Gleixner <tglx@linutronix.de>
> > Cc: Peter Zijlstra <peterz@infradead.org>
> > Cc: "Paul E. McKenney" <paulmck@kernel.org>
> > Cc: Marc Zyngier <maz@kernel.org>
> > Cc: Halil Pasic <pasic@linux.ibm.com>
> > Cc: Cornelia Huck <cohuck@redhat.com>
> > Cc: Vineeth Vijayan <vneethv@linux.ibm.com>
> > Cc: Peter Oberparleiter <oberpar@linux.ibm.com>
> > Cc: linux-s390@vger.kernel.org
> > Signed-off-by: Jason Wang <jasowang@redhat.com>
> > ---
> >  drivers/s390/virtio/virtio_ccw.c | 27 +++++++++++++++++++++++++++
> >  1 file changed, 27 insertions(+)
> >
> > diff --git a/drivers/s390/virtio/virtio_ccw.c b/drivers/s390/virtio/virtio_ccw.c
> > index d35e7a3f7067..22d36594bcdd 100644
> > --- a/drivers/s390/virtio/virtio_ccw.c
> > +++ b/drivers/s390/virtio/virtio_ccw.c
> > @@ -62,6 +62,7 @@ struct virtio_ccw_device {
> >       unsigned int revision; /* Transport revision */
> >       wait_queue_head_t wait_q;
> >       spinlock_t lock;
> > +     rwlock_t irq_lock;
> >       struct mutex io_lock; /* Serializes I/O requests */
> >       struct list_head virtqueues;
> >       bool is_thinint;
> > @@ -984,6 +985,27 @@ static const char *virtio_ccw_bus_name(struct virtio_device *vdev)
> >       return dev_name(&vcdev->cdev->dev);
> >  }
> >
> > +static void virtio_ccw_synchronize_cbs(struct virtio_device *vdev)
> > +{
> > +     struct virtio_ccw_device *vcdev = to_vc_device(vdev);
> > +     struct airq_info *info = vcdev->airq_info;
> > +
> > +     if (info) {
> > +             /*
> > +              * Synchronize with the vring_interrupt() with airq indicator
>
> Maybe
>
> /*
>  * This device uses adapter interrupts: synchronize with
>  * vring_interrupt() called by virtio_airq_handler() via the indicator
>  * area lock.
>  */
>

Fine.

> > +              */
> > +             write_lock_irq(&info->lock);
> > +             write_unlock_irq(&info->lock);
> > +     } else {
> > +             /*
> > +              * Synchronize with the vring_interrupt() called by
> > +              * virtio_ccw_int_handler().
>
> /*
>  * This device uses classic interrupts: synchronize with
>  * vring_interrupt() called by virtio_ccw_int_handler() via the
>  * per-device irq_lock.
>  */
>

Looks fine.

> > +              */
> > +             write_lock_irq(&vcdev->irq_lock);
> > +             write_unlock_irq(&vcdev->irq_lock);
> > +     }
> > +}
> > +
> >  static const struct virtio_config_ops virtio_ccw_config_ops = {
> >       .get_features = virtio_ccw_get_features,
> >       .finalize_features = virtio_ccw_finalize_features,
> > @@ -995,6 +1017,7 @@ static const struct virtio_config_ops virtio_ccw_config_ops = {
> >       .find_vqs = virtio_ccw_find_vqs,
> >       .del_vqs = virtio_ccw_del_vqs,
> >       .bus_name = virtio_ccw_bus_name,
> > +     .synchronize_cbs = virtio_ccw_synchronize_cbs,
> >  };
> >
> >
> > @@ -1106,6 +1129,8 @@ static void virtio_ccw_int_handler(struct ccw_device *cdev,
> >                       vcdev->err = -EIO;
> >       }
> >       virtio_ccw_check_activity(vcdev, activity);
> > +     /* Local interrupt should be disabled at this time */
>
> /* Interrupts are disabled here. */
>
> ?
>
> Interrupts enabled here would surely be a bug.

Right.

Thanks

>
> > +     read_lock(&vcdev->irq_lock);
> >       for_each_set_bit(i, indicators(vcdev),
> >                        sizeof(*indicators(vcdev)) * BITS_PER_BYTE) {
> >               /* The bit clear must happen before the vring kick. */
>

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
