Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7BC21C433F5
	for <virtualization@archiver.kernel.org>; Tue, 21 Dec 2021 09:02:40 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 095AF40907;
	Tue, 21 Dec 2021 09:02:40 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id t5Zt0r9yEwCz; Tue, 21 Dec 2021 09:02:39 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 8F1F240909;
	Tue, 21 Dec 2021 09:02:38 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 49E12C001E;
	Tue, 21 Dec 2021 09:02:38 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 6B503C0012
 for <virtualization@lists.linux-foundation.org>;
 Tue, 21 Dec 2021 09:02:36 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 58B6B60D70
 for <virtualization@lists.linux-foundation.org>;
 Tue, 21 Dec 2021 09:02:36 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp3.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 5-IkyYMqKZR5
 for <virtualization@lists.linux-foundation.org>;
 Tue, 21 Dec 2021 09:02:35 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 0A13460A97
 for <virtualization@lists.linux-foundation.org>;
 Tue, 21 Dec 2021 09:02:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1640077353;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=qF7c5WRQK3kgT2I3qpX7xNt19cSGSHA3QxXq86S3fRE=;
 b=K7+t0KkzQwJ3WRtYZlOUQfiseMsPSvvaNAdUE58RRpOHHcFpRUv+b9CZtKc9CE2J3uPf3I
 CY9K1MbTioyqoH2dE/a7eU8je8q2vum8XhJMjPr96iIfeC8Iu/8jd3AwjiU14gj4lGpqDD
 NwIPDluQ+3/rB+iMOCnMjiVqZAP7CEk=
Received: from mail-lf1-f72.google.com (mail-lf1-f72.google.com
 [209.85.167.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-8-TZVIAvoMO0mlhAWgyCRqug-1; Tue, 21 Dec 2021 04:02:32 -0500
X-MC-Unique: TZVIAvoMO0mlhAWgyCRqug-1
Received: by mail-lf1-f72.google.com with SMTP id
 a28-20020ac2505c000000b0042524c397cfso5893385lfm.1
 for <virtualization@lists.linux-foundation.org>;
 Tue, 21 Dec 2021 01:02:32 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=qF7c5WRQK3kgT2I3qpX7xNt19cSGSHA3QxXq86S3fRE=;
 b=HRpMQXJBQ3j9oNzVdfehFN+7nWQVnQLBvhWPVtwedQeduESdp+yFq2oV1Z+Yi/0Tz/
 nXOcrdgT2n+Eh1rsdPfk0QJZwoY0+Zg1YLlv9C6pfXytOq2ylqGCXiGQXwSbAdAT+pdF
 1jbPphzN1HlRA5l+6GdWRjyKj55z2+HIw6U+WuWBAJyBxC8aGXeeGnS1z8e1es1b2XyV
 gSCvMHIB4bs2UjwPwAeIfJFYPaIUtTK5mFweigdeAcPrpoAZ9sWdwMDKI/J0iNGRIlJl
 t376R7mxayo0j4C6rRoZ6raL+6UjVuFRcPqtTa+1bYTiLJzY9feaWuuqQ3WukmT8RA1g
 fAZA==
X-Gm-Message-State: AOAM530qUhEognMovQtTqTOh8SCcllJFVm8rLi4rKqmy77wdKxv8Hg95
 9BskcoYKXqH9uIjw5j9B7hk/gp794UgrDUkiqldJdleEb1M1swndUxUWhT3tQSNhil43uX5kI3q
 uBL8H12z0k06ACclN9o+DCEeIl9JelsT9jAQ0F3Mqu/5/6L3A+MNa51l0VQ==
X-Received: by 2002:a2e:b742:: with SMTP id k2mr1843903ljo.107.1640077351048; 
 Tue, 21 Dec 2021 01:02:31 -0800 (PST)
X-Google-Smtp-Source: ABdhPJx3QunXzdzBGtTrzD8Gli6LyMoPQ1BHfh8aBm6YLjaZaGKE75OWABALCq23KGpSoqUF+ZTdK2TWWXVaR+5XR7g=
X-Received: by 2002:a2e:b742:: with SMTP id k2mr1843888ljo.107.1640077350800; 
 Tue, 21 Dec 2021 01:02:30 -0800 (PST)
MIME-Version: 1.0
References: <20211219140236.27479-1-elic@nvidia.com>
 <20211219140236.27479-4-elic@nvidia.com>
 <CACGkMEsjmOBAW9t__=o=jeKA6f8inr3D6CVidoSc3wjX9DE5Lw@mail.gmail.com>
 <20211221061646.GA165503@mtl-vdi-166.wap.labs.mlnx>
 <CACGkMEsEMT=oDTwynjj+-zZK8gvrsynz4Hre0EahD4vYG=L+DQ@mail.gmail.com>
 <20211221090040.GA170055@mtl-vdi-166.wap.labs.mlnx>
In-Reply-To: <20211221090040.GA170055@mtl-vdi-166.wap.labs.mlnx>
From: Jason Wang <jasowang@redhat.com>
Date: Tue, 21 Dec 2021 17:02:19 +0800
Message-ID: <CACGkMEsr4_jPyCrCq1ocB7EkChbHxfe_xqZZBh9Zqm_HC1yqDw@mail.gmail.com>
Subject: Re: [PATCH v3 03/10] vdpa: Read device configuration only if
 FEATURES_OKg
To: Eli Cohen <elic@nvidia.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=jasowang@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Cc: Laurent Vivier <lvivier@redhat.com>, mst <mst@redhat.com>,
 virtualization <virtualization@lists.linux-foundation.org>,
 eperezma <eperezma@redhat.com>, Si-Wei Liu <si-wei.liu@oracle.com>
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

On Tue, Dec 21, 2021 at 5:00 PM Eli Cohen <elic@nvidia.com> wrote:
>
> On Tue, Dec 21, 2021 at 03:51:47PM +0800, Jason Wang wrote:
> > On Tue, Dec 21, 2021 at 2:17 PM Eli Cohen <elic@nvidia.com> wrote:
> > >
> > > On Tue, Dec 21, 2021 at 01:51:32PM +0800, Jason Wang wrote:
> > > > On Sun, Dec 19, 2021 at 10:03 PM Eli Cohen <elic@nvidia.com> wrote:
> > > > >
> > > > > Avoid reading device configuration during feature negotiation. Read
> > > > > device status and verify that VIRTIO_CONFIG_S_FEATURES_OK is set.
> > > > > Otherwise, return -EAGAIN.
> > > > >
> > > > > Signed-off-by: Eli Cohen <elic@nvidia.com>
> > > > > ---
> > > > >  drivers/vdpa/vdpa.c | 7 +++++++
> > > > >  1 file changed, 7 insertions(+)
> > > > >
> > > > > diff --git a/drivers/vdpa/vdpa.c b/drivers/vdpa/vdpa.c
> > > > > index 42d71d60d5dc..5749cf0a1500 100644
> > > > > --- a/drivers/vdpa/vdpa.c
> > > > > +++ b/drivers/vdpa/vdpa.c
> > > > > @@ -819,8 +819,15 @@ vdpa_dev_config_fill(struct vdpa_device *vdev, struct sk_buff *msg, u32 portid,
> > > > >  {
> > > > >         u32 device_id;
> > > > >         void *hdr;
> > > > > +       u8 status;
> > > > >         int err;
> > > > >
> > > > > +       status = vdev->config->get_status(vdev);
> > > > > +       if (!(status & VIRTIO_CONFIG_S_FEATURES_OK)) {
> > > > > +               NL_SET_ERR_MSG_MOD(extack, "Features negotiation not completed");
> > > > > +               return -EAGAIN;
> > > > > +       }
> > > > > +
> > > >
> > > > I wonder how we synchronize this with set_status(), set/get_config()?
> > > >
> > >
> > > Not sure why set/get_config() is related to this.
> >
> > I think guest may trigger set_config() while we are at
> > vdpa_dev_config_fill(), this will lead to inconsistent values.
> >
> > > How about each upstream driver will take care to have a lock that
> > > serializes set_status() with get_driver_features() to guarantee that we
> > > always provide valid features?
> >
> > Yes and it looks like we've already had a per device cf_mutex, how
> > about simply use this?
>
> Maybe do it in one place. For example, for vhost, in
> drivers/vhost/vdpa.c:
>
> mutex_lock(&vdpa->cf_mutex);
> ops->set_status(vdpa, status);
> mutex_unlock(&vdpa->cf_mutex);
>
> same for drivers/virtio/virtio_vdpa.c
>
> OVerall, set_status, get_status, set_config, get_config should be
> protected.

Yes, maybe we can introduce new helpers in vdpa.c.

Thanks

>
>
> >
> > Thanks
> >
> > >
> > > > Thanks
> > > >
> > > > >         hdr = genlmsg_put(msg, portid, seq, &vdpa_nl_family, flags,
> > > > >                           VDPA_CMD_DEV_CONFIG_GET);
> > > > >         if (!hdr)
> > > > > --
> > > > > 2.34.1
> > > > >
> > > >
> > >
> >
>

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
