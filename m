Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0B486C433F5
	for <virtualization@archiver.kernel.org>; Thu, 12 May 2022 03:31:26 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id A1FF440BB3;
	Thu, 12 May 2022 03:31:26 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id e9w5fSdH3KVc; Thu, 12 May 2022 03:31:25 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 5086F400B8;
	Thu, 12 May 2022 03:31:25 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 29B55C0032;
	Thu, 12 May 2022 03:31:25 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 9F4C4C002D
 for <virtualization@lists.linux-foundation.org>;
 Thu, 12 May 2022 03:31:24 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 8E96080A5B
 for <virtualization@lists.linux-foundation.org>;
 Thu, 12 May 2022 03:31:24 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp1.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id zTi2tsMyFz0v
 for <virtualization@lists.linux-foundation.org>;
 Thu, 12 May 2022 03:31:24 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp1.osuosl.org (Postfix) with ESMTPS id D696D83E47
 for <virtualization@lists.linux-foundation.org>;
 Thu, 12 May 2022 03:31:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1652326282;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=LUr5X5h8hRE0PnlgrOtChIFOYcrivzITnEPdm8C72JY=;
 b=RrIuWQOCCqMEpgnY58ReSZRpq9GjeoZQCIeiAU+SXwsfxrxWTiOX6QIwOQza/cry9KhOh3
 eOpPnSKTXOliSwJ6WEzZo7mcuwqNKWQHelktOIukJ7POO6eHAsvWJQJ7tSme30Xr7zIbgu
 JJxxUt150QOtRdHHPFGbIhyUxJ+vzQQ=
Received: from mail-lf1-f72.google.com (mail-lf1-f72.google.com
 [209.85.167.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-453-ObfdSXB6OdSRKNJwnNnC7A-1; Wed, 11 May 2022 23:31:21 -0400
X-MC-Unique: ObfdSXB6OdSRKNJwnNnC7A-1
Received: by mail-lf1-f72.google.com with SMTP id
 v13-20020a056512096d00b004487e1503d0so1635365lft.4
 for <virtualization@lists.linux-foundation.org>;
 Wed, 11 May 2022 20:31:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=LUr5X5h8hRE0PnlgrOtChIFOYcrivzITnEPdm8C72JY=;
 b=gbO2yAFHVL9J+35ieqUFsm7ivYtYeMXvWhsSwKquSJnOqADJBULaEiUEzvf8QRtvE7
 Iarw7CGqDDdo7oAt/zUeB6NG7kY1NnBM4CdBKryXOMxqXXDVVytAQVSaO4ul2vbAlQQ+
 P300vjuUkAz2KDZCBZ4ht/p06G1J0erbuLdxQ+8pUh+sq0qJJCu3NUn6ubKd3j3uVVvU
 Sp71UTXxPQdrLdoEsbeSoTfrjuHH4woKDskHZ0zWU8vzuYyZeDiio59VJ9FYOMwn7Kjo
 mTz5FbxKfllHPo6Es7gn9J6E8KLtuPTEmcH7QrWiiNJMtZk48V7C9caM3tYM/LR6Aeew
 usqA==
X-Gm-Message-State: AOAM530HKje4PC8CQ3J1CBZ68KgLaP/QolA+fg+WY46MchDRfqKJJtCs
 zQpXzPfIHYrC++vkd3/AxD7VyZfhXWDF5nFCReKAMODCUlYBwRGBVfr3fG13eC5jhC+7mVquoNI
 My0Wlfrjy8QK16v/oxWQdAn24D4aM0zvJKnYRUFNm6kcVzvIaSvGbBpSWXA==
X-Received: by 2002:a05:6512:a91:b0:473:bb9e:fc80 with SMTP id
 m17-20020a0565120a9100b00473bb9efc80mr22777065lfu.471.1652326280138; 
 Wed, 11 May 2022 20:31:20 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxL74hmVi0c35qfwJAdBbA1TQkUse++PX5SHOyzwIoFsRXFU5MORZIllAgA+C0om00e9hUfHj6Tj80AAcL5ffE=
X-Received: by 2002:a05:6512:a91:b0:473:bb9e:fc80 with SMTP id
 m17-20020a0565120a9100b00473bb9efc80mr22777045lfu.471.1652326279972; Wed, 11
 May 2022 20:31:19 -0700 (PDT)
MIME-Version: 1.0
References: <20220507071954.14455-1-jasowang@redhat.com>
 <875ymd3fd1.fsf@redhat.com>
 <CACGkMEvfkUpsY4LRTuH7w18DZdq+w3=Ef6b-0sG0XvzVUVKdzg@mail.gmail.com>
 <20220511160147.46cbf2fb.pasic@linux.ibm.com>
In-Reply-To: <20220511160147.46cbf2fb.pasic@linux.ibm.com>
From: Jason Wang <jasowang@redhat.com>
Date: Thu, 12 May 2022 11:31:08 +0800
Message-ID: <CACGkMEtaN6tZrwp3rsxu4Hn1Rev2P06X3BaR4X1cqDxnRdPCKg@mail.gmail.com>
Subject: Re: [PATCH V4 0/9] rework on the IRQ hardening of virtio
To: Halil Pasic <pasic@linux.ibm.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=jasowang@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Cc: Cindy Lu <lulu@redhat.com>, "Paul E. McKenney" <paulmck@kernel.org>,
 mst <mst@redhat.com>, Peter Zijlstra <peterz@infradead.org>,
 Marc Zyngier <maz@kernel.org>, Cornelia Huck <cohuck@redhat.com>,
 linux-kernel <linux-kernel@vger.kernel.org>,
 virtualization <virtualization@lists.linux-foundation.org>,
 eperezma <eperezma@redhat.com>, Thomas Gleixner <tglx@linutronix.de>
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

On Wed, May 11, 2022 at 10:02 PM Halil Pasic <pasic@linux.ibm.com> wrote:
>
> On Wed, 11 May 2022 10:22:59 +0800
> Jason Wang <jasowang@redhat.com> wrote:
>
> > >        CPU0
> > >        ----
> > >   lock(&vcdev->irq_lock);
> > >   <Interrupt>
> > >     lock(&vcdev->irq_lock);
> > >
> > >  *** DEADLOCK ***
> >
> > It looks to me we need to use write_lock_irq()/write_unlock_irq() to
> > do the synchronization.
> >
> > And we probably need to keep the
> > read_lock_irqsave()/read_lock_irqrestore() logic since I can see the
> > virtio_ccw_int_handler() to be called from process context (e.g from
> > the io_subchannel_quiesce()).
> >
>
> Sounds correct.

As Cornelia and Vineeth pointed out, all the paths the vring_interrupt
is called with irq disabled.

So I will use spin_lock()/spin_unlock() in the next version.

Thanks

>
> Regards,
> Halil
>

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
