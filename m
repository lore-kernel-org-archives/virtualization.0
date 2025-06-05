Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41F2E20299E
	for <virtualization@lists.linux-foundation.org>; Thu,  5 Jun 2025 07:35:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.136
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749108940; cv=none; b=ffeZAjgdXcXJwPaRXSifCr0xYoXo1gp2Xf763JvH3TLiGDsouEmysBUQPKXS7AsopxnJUadlwA+LudLhbX4Riaqd7yZj8vFhAcgkg/GHutPGJbkTK8FzRbY5H51G5gAqHsy7n5KO/rp8ZUEbceTz99l2BZiJNMC4b7N5MEArehQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749108940; c=relaxed/simple;
	bh=xaaO/f1X4wFcpMshO0kr/Uc/I2hIRKwMQVno0JEnam8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=imGwGgxxIUPtUWhgmum0/mJOMynmAWM6w79F//bXuHi/VRzpfxHV/wpr6yi58K14gp0+5KqoS0T2Mf6qZO9b72t9ZY/jX4t8w5cDuBKsOXmvUvaAEmkMoZNDe+HPVq6vLGpfxyi7zJbGP2cXh5HU0Nas3vSVlApxoqE+j/2T5vI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=hBV40mkL; arc=none smtp.client-ip=140.211.166.136
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="hBV40mkL"
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id D7EA760855
	for <virtualization@lists.linux-foundation.org>; Thu,  5 Jun 2025 07:35:38 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -5.79
X-Spam-Level:
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id xqlL3pSRTYzK for <virtualization@lists.linux-foundation.org>;
 Thu,  5 Jun 2025 07:35:37 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=170.10.129.124; helo=us-smtp-delivery-124.mimecast.com; envelope-from=lulu@redhat.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp3.osuosl.org 64A8360842
Authentication-Results: smtp3.osuosl.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 64A8360842
Authentication-Results: smtp3.osuosl.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=hBV40mkL
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 64A8360842
	for <virtualization@lists.linux-foundation.org>; Thu,  5 Jun 2025 07:35:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1749108935;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=haNatmsr8a/iGKFdObS4u9jtqcJpXsWFI5vt5mC8hSI=;
	b=hBV40mkLLRRxQVVs0667BbT+SypP0s5a0pJj7AMkGUgRT4F5TQQJ5mP3j3w2pO96MWCPEQ
	YJ+2/C3dcvMmI/s60ZZYWSxZdNQb9HOhr7MIujAPXUaCHKKYjeAjoPxlYecGuGn7lTucTU
	ejJ6XX0kfgL6S2NmJCroQDGWufj9aDg=
Received: from mail-ua1-f72.google.com (mail-ua1-f72.google.com
 [209.85.222.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-277-ugy_yN7fOVy6TkyX-KzerA-1; Thu, 05 Jun 2025 03:35:34 -0400
X-MC-Unique: ugy_yN7fOVy6TkyX-KzerA-1
X-Mimecast-MFC-AGG-ID: ugy_yN7fOVy6TkyX-KzerA_1749108934
Received: by mail-ua1-f72.google.com with SMTP id a1e0cc1a2514c-87e23231b5eso512519241.3
        for <virtualization@lists.linux-foundation.org>; Thu, 05 Jun 2025 00:35:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749108934; x=1749713734;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=haNatmsr8a/iGKFdObS4u9jtqcJpXsWFI5vt5mC8hSI=;
        b=UxLG3EW/DYYYBTlzjNleT1dkld9sZB0yjVzt43HOPPT8p6RyEi8kOJ4P6npQNXPsni
         LeOr9fxJtll1PaYN1eV5HeCIHWC7gWpa2IonoitN+pTrcJMfupcmWKnFiJK2PLCLmg1a
         win5mHn74xrJ9z1isbaLShWFlaK5tvdaVeOqGk30id6JGSAH14KS8wgdzuDhXfUiqp+j
         hDUUrjJ0IKgUbyJQAQ4A4iT5HeoWpFAxeyHwk/vPJvTcR0VnPs1opSiQ6lZSN25Zt5Ls
         wezegv4wykVQSeDhfub3EqFKJKb61+b8cyeavS09LYKAc9KAkbjHCS/Jw0S53xkFKt+K
         BnGg==
X-Forwarded-Encrypted: i=1; AJvYcCUFe/miF94t2JGfhiExI3APEQicN1P5xTCpU/s99B97gYj1vH54VDeU6EKlVOrxicKJNrfIRmzf+ocxzpDhZg==@lists.linux-foundation.org
X-Gm-Message-State: AOJu0YxnsdKZhr7+N0c9f9fkI5YwFhQm7PNybwkj00kZ/ds5embO22BC
	6j2I9n9KSMz6hScVui7LJJ28DoE+Gk5XwXHZTsm30RHxCSpIVOtIGltMgtiBuJmNSqXe85NBTXp
	HCw4L4hFTt6RBatt9wNx8tVHpZNf3wQQqEGRSrkbbuFuNJMTT9tZQOLD9jrLt0/4M9fmATAK+CH
	AlE/JRCfUIUcnlOZrxApjeFCcAj9/Kpr+gekJ0UjLXshRTcwpj/QW1fJefIw==
X-Gm-Gg: ASbGncsVJm/dDZ0k2Rxi5ngd0ycyWA2Kc2dr5Ws26bTNoANJ9ymOgDeGYfoHjgQD4CY
	H4EDezcZZMQJQeBoFlvFiDxcdaTRCR5lDhuak9wBO1gnkjlr2D/gSaTp0gcClyBouKyqmoQcYz3
	pi3v59
X-Received: by 2002:a05:6102:510e:b0:4c1:7be4:eb61 with SMTP id ada2fe7eead31-4e746f837a4mr4499061137.25.1749108933929;
        Thu, 05 Jun 2025 00:35:33 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEhfWXYxHfh7ndgHlr5SsuCZIS9uSBe8eCGWSE8HDvdi0nEFlAlR7YsAwWZnsQ6fylQBk9U9xd09BIVxvKtPz0=
X-Received: by 2002:a05:6102:510e:b0:4c1:7be4:eb61 with SMTP id
 ada2fe7eead31-4e746f837a4mr4499051137.25.1749108933605; Thu, 05 Jun 2025
 00:35:33 -0700 (PDT)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20250531095800.160043-1-lulu@redhat.com> <20250531095800.160043-2-lulu@redhat.com>
 <20250601064917-mutt-send-email-mst@kernel.org>
In-Reply-To: <20250601064917-mutt-send-email-mst@kernel.org>
From: Cindy Lu <lulu@redhat.com>
Date: Thu, 5 Jun 2025 15:34:56 +0800
X-Gm-Features: AX0GCFu35JguejX9e3-1qt6CZ0h8hz4k2SNC3u5-OLCeEHlCWSfhHe4JVwP6JO0
Message-ID: <CACLfguX8vAMTz=vmnZtnqWSAawNps8UOboZ1DvZ-it6Gf8+4jQ@mail.gmail.com>
Subject: Re: [PATCH RESEND v10 1/3] vhost: Add a new modparam to allow
 userspace select kthread
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: jasowang@redhat.com, michael.christie@oracle.com, sgarzare@redhat.com, 
	linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org, 
	netdev@vger.kernel.org
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: QZUefK3aBWJYRcrz5draF38I6lfbYCKNB-PQl_eDtig_1749108934
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Jun 1, 2025 at 6:51=E2=80=AFPM Michael S. Tsirkin <mst@redhat.com> =
wrote:
>
> On Sat, May 31, 2025 at 05:57:26PM +0800, Cindy Lu wrote:
> > The vhost now uses vhost_task and workers as a child of the owner threa=
d.
> > While this aligns with containerization principles, it confuses some
> > legacy userspace applications, therefore, we are reintroducing kthread
> > API support.
> >
> > Add a new module parameter to allow userspace to select behavior
> > between using kthread and task.
> >
> > By default, this parameter is set to true (task mode). This means the
> > default behavior remains unchanged by this patch.
> >
> > Signed-off-by: Cindy Lu <lulu@redhat.com>
>
> So modparam is here but does nothing.
> This should be the last patch in the series, or squashed with 3/3.
>
> why is this inherit_owner but ioctl is fork_owner? is there
> a difference? If not
> can't the name be consistent with the ioctl?  vhost_fork_owner?
>
>
sure, will fix this
Thanks
cindy
> > ---
> >  drivers/vhost/vhost.c |  5 +++++
> >  drivers/vhost/vhost.h | 10 ++++++++++
> >  2 files changed, 15 insertions(+)
> >
> > diff --git a/drivers/vhost/vhost.c b/drivers/vhost/vhost.c
> > index 3a5ebb973dba..240ba78b1e3f 100644
> > --- a/drivers/vhost/vhost.c
> > +++ b/drivers/vhost/vhost.c
> > @@ -41,6 +41,10 @@ static int max_iotlb_entries =3D 2048;
> >  module_param(max_iotlb_entries, int, 0444);
> >  MODULE_PARM_DESC(max_iotlb_entries,
> >       "Maximum number of iotlb entries. (default: 2048)");
> > +bool inherit_owner_default =3D true;
> > +module_param(inherit_owner_default, bool, 0444);
> > +MODULE_PARM_DESC(inherit_owner_default,
> > +              "Set task mode as the default(default: Y)");
> >
> >  enum {
> >       VHOST_MEMORY_F_LOG =3D 0x1,
> > @@ -552,6 +556,7 @@ void vhost_dev_init(struct vhost_dev *dev,
> >       dev->byte_weight =3D byte_weight;
> >       dev->use_worker =3D use_worker;
> >       dev->msg_handler =3D msg_handler;
> > +     dev->inherit_owner =3D inherit_owner_default;
> >       init_waitqueue_head(&dev->wait);
> >       INIT_LIST_HEAD(&dev->read_list);
> >       INIT_LIST_HEAD(&dev->pending_list);
> > diff --git a/drivers/vhost/vhost.h b/drivers/vhost/vhost.h
> > index bb75a292d50c..c1ff4a92b925 100644
> > --- a/drivers/vhost/vhost.h
> > +++ b/drivers/vhost/vhost.h
> > @@ -176,6 +176,16 @@ struct vhost_dev {
> >       int byte_weight;
> >       struct xarray worker_xa;
> >       bool use_worker;
> > +     /*
> > +      * If inherit_owner is true we use vhost_tasks to create
> > +      * the worker so all settings/limits like cgroups, NPROC,
> > +      * scheduler, etc are inherited from the owner. If false,
> > +      * we use kthreads and only attach to the same cgroups
> > +      * as the owner for compat with older kernels.
> > +      * here we use true as default value.
> > +      * The default value is set by modparam inherit_owner_default
> > +      */
> > +     bool inherit_owner;
> >       int (*msg_handler)(struct vhost_dev *dev, u32 asid,
> >                          struct vhost_iotlb_msg *msg);
> >  };
> > --
> > 2.45.0
>

