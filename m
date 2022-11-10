Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B60F2C4332F
	for <virtualization@archiver.kernel.org>; Thu, 10 Nov 2022 03:47:57 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 36054405A6;
	Thu, 10 Nov 2022 03:47:57 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 36054405A6
Authentication-Results: smtp4.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=Tgb6Bmr8
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id rBMKR1xkt16B; Thu, 10 Nov 2022 03:47:56 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 81F7F4042F;
	Thu, 10 Nov 2022 03:47:55 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 81F7F4042F
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 5EF13C0033;
	Thu, 10 Nov 2022 03:47:55 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 4922BC002D
 for <virtualization@lists.linux-foundation.org>;
 Thu, 10 Nov 2022 03:47:53 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 144FF4049A
 for <virtualization@lists.linux-foundation.org>;
 Thu, 10 Nov 2022 03:47:53 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 144FF4049A
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id zVbvFxyerOY7
 for <virtualization@lists.linux-foundation.org>;
 Thu, 10 Nov 2022 03:47:51 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org B2E004042F
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp4.osuosl.org (Postfix) with ESMTPS id B2E004042F
 for <virtualization@lists.linux-foundation.org>;
 Thu, 10 Nov 2022 03:47:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1668052070;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=5wnyLGqWnXrVwpHf/LqVqqWLtFDmz9WDDkL1ZC0aJ6U=;
 b=Tgb6Bmr8+9MYgOsDJgJO4fe5U95EF7qdqYWf6XLpir5T2oprodCGYZx8c49ibcmP0Dl0xS
 Yv0ODDeqeOwnq5OTG4zoLUpmdaN+rVWHKcjaaMI3mMb72UMAHt1Iov3JZrokz71DBi4CeM
 wXfGTu8zRxXW8jj7nhakG5nFhKYV6v4=
Received: from mail-oa1-f69.google.com (mail-oa1-f69.google.com
 [209.85.160.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-349-fcQm4HcNM1ia6AfHNlUE0w-1; Wed, 09 Nov 2022 22:47:45 -0500
X-MC-Unique: fcQm4HcNM1ia6AfHNlUE0w-1
Received: by mail-oa1-f69.google.com with SMTP id
 586e51a60fabf-13b9bcc6b4cso475957fac.13
 for <virtualization@lists.linux-foundation.org>;
 Wed, 09 Nov 2022 19:47:45 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=5wnyLGqWnXrVwpHf/LqVqqWLtFDmz9WDDkL1ZC0aJ6U=;
 b=CixlyxBLuD6Wr+TQJPdWW5Ufa+au5zXKTyjeg9X/N1l/QmM6T/oW8nDsien/5KjaM7
 AwDQ7xGnw/S8Jd+xvddd01au1zog+bXNl8C5tAuzRrdpyS5U4K2ynAGDx7VcIojWdTw+
 h27WWgEWIJBbGVQnoSZEmMOi3f7nTS46VULpoVeXE7MRbDny7hUW4cXQV9jlJY3UOKvm
 bcwdyv9fwO59MKObPUp4W6v22l1xlMN/+71lOYhKlcgTukEj0sfRlGWt6TG+irK6WbKX
 0lR1mT4bi+DfCvwoGlUfe9Yara0wuhHzmIehzvfeoe4/jfylrZcPs1kMkUor95ySV4q7
 Esiw==
X-Gm-Message-State: ACrzQf1BXI+xijqPJEQUX/WBYS5fvmgHNBNqyHpI5KLdsjYKsyxLwvn5
 hQzRLkG/faiFuohfK/a5uvJd3SH8e7J6BnUcB8Gcr3DcSAO3GFmxwDDMlEQ4I7aicE3YSrmTcgO
 VIbY6XXRasxVvaH+/qFvSkQbkGxXlwud9AH77aa1BGi9UiANMxV7Iv+eB+w==
X-Received: by 2002:a05:6871:54e:b0:13b:29b7:e2e8 with SMTP id
 t14-20020a056871054e00b0013b29b7e2e8mr45757630oal.35.1668052065152; 
 Wed, 09 Nov 2022 19:47:45 -0800 (PST)
X-Google-Smtp-Source: AMsMyM4OG8TXscyRn+mvNZ5Q9caypOByTT7AsfeH9vDE9c7xEhzAoS8lLQpAWuyuFSiUnVRVjbupPFvOzyuw4NNzA0Q=
X-Received: by 2002:a05:6871:54e:b0:13b:29b7:e2e8 with SMTP id
 t14-20020a056871054e00b0013b29b7e2e8mr45757624oal.35.1668052064920; Wed, 09
 Nov 2022 19:47:44 -0800 (PST)
MIME-Version: 1.0
References: <20221101111655.1947-1-angus.chen@jaguarmicro.com>
 <CACGkMEs6ZTrf0NMXGuM=VYZC+zAujigiTG2CgE8gAdvxHc2Q7A@mail.gmail.com>
 <TY2PR06MB342458CA2B7B5B8FDCD3366185019@TY2PR06MB3424.apcprd06.prod.outlook.com>
In-Reply-To: <TY2PR06MB342458CA2B7B5B8FDCD3366185019@TY2PR06MB3424.apcprd06.prod.outlook.com>
From: Jason Wang <jasowang@redhat.com>
Date: Thu, 10 Nov 2022 11:47:33 +0800
Message-ID: <CACGkMEuQTob8DYwYAa20-3SdHWoZJ+EnxJCKm+xR4_gUHRcd8g@mail.gmail.com>
Subject: Re: [PATCH] virtio_pci: modify ENOENT to EINVAL
To: Angus Chen <angus.chen@jaguarmicro.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Cc: "virtualization@lists.linux-foundation.org"
 <virtualization@lists.linux-foundation.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "mst@redhat.com" <mst@redhat.com>
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

On Thu, Nov 10, 2022 at 11:31 AM Angus Chen <angus.chen@jaguarmicro.com> wrote:
>
> Hi Jason.
>
> > -----Original Message-----
> > From: Jason Wang <jasowang@redhat.com>
> > Sent: Wednesday, November 2, 2022 1:34 PM
> > To: Angus Chen <angus.chen@jaguarmicro.com>
> > Cc: mst@redhat.com; virtualization@lists.linux-foundation.org;
> > linux-kernel@vger.kernel.org; lingshan.zhu@intel.com
> > Subject: Re: [PATCH] virtio_pci: modify ENOENT to EINVAL
> >
> > On Tue, Nov 1, 2022 at 7:17 PM Angus Chen <angus.chen@jaguarmicro.com>
> > wrote:
> > >
> > > Virtio_crypto use max_data_queues+1 to setup vqs,
> > > we use vp_modern_get_num_queues to protect the vq range in setup_vq.
> > > We could enter index >= vp_modern_get_num_queues(mdev) in setup_vq
> > > if common->num_queues is not set well,and it return -ENOENT.
> > > It is better to use -EINVAL instead.
> >
> > I'm not sure I get this. It would be better to describe:
> >
> > 1) what kind of issues can we see if we return -ENOENT
> > 2) why -EINVAL can help in this case
> >
> > Thanks
> Thank you for your reply.
> We use a robot to test our dpu to get the return value of probe.
>  We often get ENOENT form ' setup_vq ' function because of device error.
> Most of time, my device can't handle queue_enable well.
> This time,we get 'ENOENT' because the device set max_data_queues bigger than num_queues.

Ok, I see, ENOENT is not very popular on linux but I'm not sure it's
worth bothering.

>
> I think EINVAL is used when the value of some parameter is wrong.
> Btw,it not a big deal,I can modify the robot to workaround.

Btw, the error code is not a part of the ABI, so depending on that is
kind of fragile.

Thanks

>
> >
> > >
> > > Signed-off-by: Angus Chen <angus.chen@jaguarmicro.com>
> > > ---
> > >  drivers/virtio/virtio_pci_modern.c | 2 +-
> > >  1 file changed, 1 insertion(+), 1 deletion(-)
> > >
> > > diff --git a/drivers/virtio/virtio_pci_modern.c
> > b/drivers/virtio/virtio_pci_modern.c
> > > index c3b9f2761849..edf2e18014cd 100644
> > > --- a/drivers/virtio/virtio_pci_modern.c
> > > +++ b/drivers/virtio/virtio_pci_modern.c
> > > @@ -303,7 +303,7 @@ static struct virtqueue *setup_vq(struct
> > virtio_pci_device *vp_dev,
> > >         int err;
> > >
> > >         if (index >= vp_modern_get_num_queues(mdev))
> > > -               return ERR_PTR(-ENOENT);
> > > +               return ERR_PTR(-EINVAL);
> > >
> > >         /* Check if queue is either not available or already active. */
> > >         num = vp_modern_get_queue_size(mdev, index);
> > > --
> > > 2.25.1
> > >
>

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
