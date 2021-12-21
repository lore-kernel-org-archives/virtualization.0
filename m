Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9CB15C433F5
	for <virtualization@archiver.kernel.org>; Tue, 21 Dec 2021 07:52:08 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 358C540232;
	Tue, 21 Dec 2021 07:52:08 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Kq_-8yL7R9Kq; Tue, 21 Dec 2021 07:52:07 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp4.osuosl.org (Postfix) with ESMTPS id AF4354021E;
	Tue, 21 Dec 2021 07:52:06 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 6AAACC002F;
	Tue, 21 Dec 2021 07:52:06 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id CE88DC0012
 for <virtualization@lists.linux-foundation.org>;
 Tue, 21 Dec 2021 07:52:04 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id A7E41404C6
 for <virtualization@lists.linux-foundation.org>;
 Tue, 21 Dec 2021 07:52:04 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp2.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id ILXkxqssNto8
 for <virtualization@lists.linux-foundation.org>;
 Tue, 21 Dec 2021 07:52:03 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 5654A4016B
 for <virtualization@lists.linux-foundation.org>;
 Tue, 21 Dec 2021 07:52:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1640073122;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=GOE7122OKYWP7z3q8ulr8Yqcz0QmYW7pTCoDg9L+iXE=;
 b=CM/SnNXs/3H7tEk9EV2hJpGbNI08htTpCLAwHOAJeK+A3FY8fLCgFm+f8yoMSvZtoHMmP5
 lzHBMmZ6Sje7P74XYRM0nj729YEmVFnSXOvlFMckLg1V5D2Bd/+MsFOJKxVR2Plx4VZUh3
 GdKF0PPYc9zOyeiZKTyFsVu5TZSfi3o=
Received: from mail-lf1-f71.google.com (mail-lf1-f71.google.com
 [209.85.167.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-601-NVbBnUNYPMq8DemeOaVWaQ-1; Tue, 21 Dec 2021 02:52:00 -0500
X-MC-Unique: NVbBnUNYPMq8DemeOaVWaQ-1
Received: by mail-lf1-f71.google.com with SMTP id
 b35-20020a0565120ba300b0042604bb4857so1882749lfv.19
 for <virtualization@lists.linux-foundation.org>;
 Mon, 20 Dec 2021 23:52:00 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=GOE7122OKYWP7z3q8ulr8Yqcz0QmYW7pTCoDg9L+iXE=;
 b=ndGksmJW5naorLerBclr/ubr5Uyz7sFjiD4fH3Tlaa5B5bAAx+VJ2B38GzCDQv5cwk
 NvKfq4ZMLn09+JYzPuNEf7iEBhednrgkJ405NMFJ84ZufhGqBMuyD0IgowVn/Ti8BzVA
 wnQvtz7hmcSiNK2gw9VSLN4Lc+YHW2tWHSPpR+jjaD/9PKylZnxWrGrIeXs0XccU7j32
 k++r/ctj6midDWAbNTZIN2AFzavj+PdxKrqy0kA4ofuh9z6TMM+RK4q08c6IlNExvdG0
 SZMj7t77KGIIHd3mxisTI+f/mYdfjuQWPaQ3SA7De2GwEfDzgY5I5AVcpGVDMLeOqwW4
 /H1g==
X-Gm-Message-State: AOAM533NyDinZH3dPrj7DIHwo0tQ/so+dAK41WzG6QqfExbMSDhtxw1O
 zfFS86uDMvoklQAojzCXgAxvJyk72ZChrvjAqMPllNYs08iWG3dulg2rIZST7axbTfa8md+vwZ4
 B/PdvIWSyGTt3DQiGAYv1ZNPIyLfVvTLMk6zRzwCiVoamxYi7a3wxZ6vgsA==
X-Received: by 2002:a2e:b169:: with SMTP id a9mr1656971ljm.369.1640073118970; 
 Mon, 20 Dec 2021 23:51:58 -0800 (PST)
X-Google-Smtp-Source: ABdhPJyMiAboiWjrstNFxMbccpAaxfp1ZdapFXJdfNFbcvubYN9Ul+xRZU07HqdMcT6zn7E86kWUGM13VA5uRTCekIQ=
X-Received: by 2002:a2e:b169:: with SMTP id a9mr1656956ljm.369.1640073118727; 
 Mon, 20 Dec 2021 23:51:58 -0800 (PST)
MIME-Version: 1.0
References: <20211219140236.27479-1-elic@nvidia.com>
 <20211219140236.27479-4-elic@nvidia.com>
 <CACGkMEsjmOBAW9t__=o=jeKA6f8inr3D6CVidoSc3wjX9DE5Lw@mail.gmail.com>
 <20211221061646.GA165503@mtl-vdi-166.wap.labs.mlnx>
In-Reply-To: <20211221061646.GA165503@mtl-vdi-166.wap.labs.mlnx>
From: Jason Wang <jasowang@redhat.com>
Date: Tue, 21 Dec 2021 15:51:47 +0800
Message-ID: <CACGkMEsEMT=oDTwynjj+-zZK8gvrsynz4Hre0EahD4vYG=L+DQ@mail.gmail.com>
Subject: Re: [PATCH v3 03/10] vdpa: Read device configuration only if
 FEATURES_OK
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

On Tue, Dec 21, 2021 at 2:17 PM Eli Cohen <elic@nvidia.com> wrote:
>
> On Tue, Dec 21, 2021 at 01:51:32PM +0800, Jason Wang wrote:
> > On Sun, Dec 19, 2021 at 10:03 PM Eli Cohen <elic@nvidia.com> wrote:
> > >
> > > Avoid reading device configuration during feature negotiation. Read
> > > device status and verify that VIRTIO_CONFIG_S_FEATURES_OK is set.
> > > Otherwise, return -EAGAIN.
> > >
> > > Signed-off-by: Eli Cohen <elic@nvidia.com>
> > > ---
> > >  drivers/vdpa/vdpa.c | 7 +++++++
> > >  1 file changed, 7 insertions(+)
> > >
> > > diff --git a/drivers/vdpa/vdpa.c b/drivers/vdpa/vdpa.c
> > > index 42d71d60d5dc..5749cf0a1500 100644
> > > --- a/drivers/vdpa/vdpa.c
> > > +++ b/drivers/vdpa/vdpa.c
> > > @@ -819,8 +819,15 @@ vdpa_dev_config_fill(struct vdpa_device *vdev, struct sk_buff *msg, u32 portid,
> > >  {
> > >         u32 device_id;
> > >         void *hdr;
> > > +       u8 status;
> > >         int err;
> > >
> > > +       status = vdev->config->get_status(vdev);
> > > +       if (!(status & VIRTIO_CONFIG_S_FEATURES_OK)) {
> > > +               NL_SET_ERR_MSG_MOD(extack, "Features negotiation not completed");
> > > +               return -EAGAIN;
> > > +       }
> > > +
> >
> > I wonder how we synchronize this with set_status(), set/get_config()?
> >
>
> Not sure why set/get_config() is related to this.

I think guest may trigger set_config() while we are at
vdpa_dev_config_fill(), this will lead to inconsistent values.

> How about each upstream driver will take care to have a lock that
> serializes set_status() with get_driver_features() to guarantee that we
> always provide valid features?

Yes and it looks like we've already had a per device cf_mutex, how
about simply use this?

Thanks

>
> > Thanks
> >
> > >         hdr = genlmsg_put(msg, portid, seq, &vdpa_nl_family, flags,
> > >                           VDPA_CMD_DEV_CONFIG_GET);
> > >         if (!hdr)
> > > --
> > > 2.34.1
> > >
> >
>

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
