Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 08D2AC4332F
	for <virtualization@archiver.kernel.org>; Mon, 19 Dec 2022 06:23:57 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 85E8060B1B;
	Mon, 19 Dec 2022 06:23:57 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 85E8060B1B
Authentication-Results: smtp3.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=BN4EisM2
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id a-PMAuz8I3DG; Mon, 19 Dec 2022 06:23:56 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTPS id F025260B15;
	Mon, 19 Dec 2022 06:23:55 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org F025260B15
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 59D65C0032;
	Mon, 19 Dec 2022 06:23:55 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 2B6FAC002D
 for <virtualization@lists.linux-foundation.org>;
 Mon, 19 Dec 2022 06:23:54 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id EEA6C60B1B
 for <virtualization@lists.linux-foundation.org>;
 Mon, 19 Dec 2022 06:23:53 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org EEA6C60B1B
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id PBWt26UYJNAb
 for <virtualization@lists.linux-foundation.org>;
 Mon, 19 Dec 2022 06:23:53 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 31E1A60B15
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 31E1A60B15
 for <virtualization@lists.linux-foundation.org>;
 Mon, 19 Dec 2022 06:23:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1671431032;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Ohf8zY/aWMcSPR1xSFDFYuLDJlIH0hSLiTuHM0f70LU=;
 b=BN4EisM2EIHRNZsMQMQYVh7cwUoPpWCMFI6ToQP/bxCTBpEkUizYWxhnO7z6spodIDRmvw
 CFZSRDWpmuOEdIgJoFW6EsfT9Ytir8Gy6M9cH0DkBIC2kLPI9hCq1bgOVycjQ7RS0/f4Yx
 TwBaX1miRp9+SeGDiIf6hNKjdnyy03k=
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com
 [209.85.160.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-495-0o4Vp1TSPRGXPax09TomUA-1; Mon, 19 Dec 2022 01:23:50 -0500
X-MC-Unique: 0o4Vp1TSPRGXPax09TomUA-1
Received: by mail-qt1-f200.google.com with SMTP id
 cj6-20020a05622a258600b003a519d02f59so3600459qtb.5
 for <virtualization@lists.linux-foundation.org>;
 Sun, 18 Dec 2022 22:23:50 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Ohf8zY/aWMcSPR1xSFDFYuLDJlIH0hSLiTuHM0f70LU=;
 b=JIDYfobu3JwYRYtslTcsyCP3Qjn4WqB8OAJ5gSQ9X/Hw7tT6JlF3dhQHKztWGxzaNe
 RkZc9+hlByOVFFIvbBcmIkBP+DEX2GDjN9/W7yz99o3INutSW7bf2asjTDEuW5k1z+nw
 /AQVBNWdgYYenxdCYXiXVIXBqCUvebNYch7mwLRmlubSQ2E0XiojbvQeTBAiZ3I3fJL/
 Qze7Rskpa/hjHQI4dQa3qFBGBiiSgKA/NXi/0izgooubBap11TATZ9xKHjlB7nHBc+CZ
 1tdmArvitRkBx1eN2eMlvnvpPZsrqarpHX8ynd9dTIMYZ6bOfc3TIfnshay0QzSKBdPN
 wZ8A==
X-Gm-Message-State: ANoB5pnB5QV+sUzIDW4jmMFvfAnm7XZT/bqmHRtVlJ+e/m6dVJ0zGk8X
 wHsyPslZXzOheFP/8c+F7zKyCGgMnirQ1kCnpjH2FYXMUcyIIGbY3D0/hT/fRbPSUKfB6RmZ8vS
 BFbogg9iVMFM3HmqHYSg/iBY5TUiiLHghAC2op1QuOg==
X-Received: by 2002:a05:622a:248c:b0:3a5:2e1d:74c2 with SMTP id
 cn12-20020a05622a248c00b003a52e1d74c2mr56118189qtb.39.1671431030234; 
 Sun, 18 Dec 2022 22:23:50 -0800 (PST)
X-Google-Smtp-Source: AA0mqf7ZJW3qjSiZ4BtuejaknalDMwumFr2wJTzJxFC1VNHtxV8+pQbD/YcHQRfrW5Zz5w5UshwccQ==
X-Received: by 2002:a05:622a:248c:b0:3a5:2e1d:74c2 with SMTP id
 cn12-20020a05622a248c00b003a52e1d74c2mr56118174qtb.39.1671431029974; 
 Sun, 18 Dec 2022 22:23:49 -0800 (PST)
Received: from redhat.com ([45.144.113.29]) by smtp.gmail.com with ESMTPSA id
 a19-20020ac85b93000000b003a611cb2a95sm5762676qta.9.2022.12.18.22.23.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 18 Dec 2022 22:23:49 -0800 (PST)
Date: Mon, 19 Dec 2022 01:23:44 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Jason Wang <jasowang@redhat.com>
Subject: Re: [PATCH v5 4/4] vdpa_sim: Implement resume vdpa op
Message-ID: <20221219012313-mutt-send-email-mst@kernel.org>
References: <cover.1666796792.git.sebastien.boeuf@intel.com>
 <d8c405c150c6eb25acab58718c38e0ef4c3c0293.1666796792.git.sebastien.boeuf@intel.com>
 <CACGkMEt93LU009MVK3cDKAU1fv3ZoaDskWp4hakmeTZyBQa=fg@mail.gmail.com>
MIME-Version: 1.0
In-Reply-To: <CACGkMEt93LU009MVK3cDKAU1fv3ZoaDskWp4hakmeTZyBQa=fg@mail.gmail.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: eperezma@redhat.com, sebastien.boeuf@intel.com,
 linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org
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

On Mon, Nov 07, 2022 at 03:43:54PM +0800, Jason Wang wrote:
> On Wed, Oct 26, 2022 at 11:09 PM <sebastien.boeuf@intel.com> wrote:
> >
> > From: Sebastien Boeuf <sebastien.boeuf@intel.com>
> >
> > Implement resume operation for vdpa_sim devices, so vhost-vdpa will
> > offer that backend feature and userspace can effectively resume the
> > device.
> >
> > Signed-off-by: Sebastien Boeuf <sebastien.boeuf@intel.com>
> > ---
> >  drivers/vdpa/vdpa_sim/vdpa_sim.c | 28 ++++++++++++++++++++++++++++
> >  drivers/vdpa/vdpa_sim/vdpa_sim.h |  1 +
> >  2 files changed, 29 insertions(+)
> >
> > diff --git a/drivers/vdpa/vdpa_sim/vdpa_sim.c b/drivers/vdpa/vdpa_sim/vdpa_sim.c
> > index b071f0d842fb..84fee8bb2929 100644
> > --- a/drivers/vdpa/vdpa_sim/vdpa_sim.c
> > +++ b/drivers/vdpa/vdpa_sim/vdpa_sim.c
> > @@ -357,6 +357,11 @@ static void vdpasim_kick_vq(struct vdpa_device *vdpa, u16 idx)
> >         struct vdpasim *vdpasim = vdpa_to_sim(vdpa);
> >         struct vdpasim_virtqueue *vq = &vdpasim->vqs[idx];
> >
> > +       if (!vdpasim->running) {
> > +               vdpasim->pending_kick = true;
> > +               return;
> 
> I think we may hit here when the driver kicks vq before DRIVER_OK. Do
> we need to check device status in this case and resume?
> 
> Thanks

Sebastien did you forget to reply here?

> > +       }
> > +
> >         if (vq->ready)
> >                 schedule_work(&vdpasim->work);
> >  }
> > @@ -527,6 +532,27 @@ static int vdpasim_suspend(struct vdpa_device *vdpa)
> >         return 0;
> >  }
> >
> > +static int vdpasim_resume(struct vdpa_device *vdpa)
> > +{
> > +       struct vdpasim *vdpasim = vdpa_to_sim(vdpa);
> > +       int i;
> > +
> > +       spin_lock(&vdpasim->lock);
> > +       vdpasim->running = true;
> > +
> > +       if (vdpasim->pending_kick) {
> > +               /* Process pending descriptors */
> > +               for (i = 0; i < vdpasim->dev_attr.nvqs; ++i)
> > +                       vdpasim_kick_vq(vdpa, i);
> > +
> > +               vdpasim->pending_kick = false;
> > +       }
> > +
> > +       spin_unlock(&vdpasim->lock);
> > +
> > +       return 0;
> > +}
> > +
> >  static size_t vdpasim_get_config_size(struct vdpa_device *vdpa)
> >  {
> >         struct vdpasim *vdpasim = vdpa_to_sim(vdpa);
> > @@ -717,6 +743,7 @@ static const struct vdpa_config_ops vdpasim_config_ops = {
> >         .set_status             = vdpasim_set_status,
> >         .reset                  = vdpasim_reset,
> >         .suspend                = vdpasim_suspend,
> > +       .resume                 = vdpasim_resume,
> >         .get_config_size        = vdpasim_get_config_size,
> >         .get_config             = vdpasim_get_config,
> >         .set_config             = vdpasim_set_config,
> > @@ -750,6 +777,7 @@ static const struct vdpa_config_ops vdpasim_batch_config_ops = {
> >         .set_status             = vdpasim_set_status,
> >         .reset                  = vdpasim_reset,
> >         .suspend                = vdpasim_suspend,
> > +       .resume                 = vdpasim_resume,
> >         .get_config_size        = vdpasim_get_config_size,
> >         .get_config             = vdpasim_get_config,
> >         .set_config             = vdpasim_set_config,
> > diff --git a/drivers/vdpa/vdpa_sim/vdpa_sim.h b/drivers/vdpa/vdpa_sim/vdpa_sim.h
> > index 0e78737dcc16..a745605589e2 100644
> > --- a/drivers/vdpa/vdpa_sim/vdpa_sim.h
> > +++ b/drivers/vdpa/vdpa_sim/vdpa_sim.h
> > @@ -67,6 +67,7 @@ struct vdpasim {
> >         u64 features;
> >         u32 groups;
> >         bool running;
> > +       bool pending_kick;
> >         /* spinlock to synchronize iommu table */
> >         spinlock_t iommu_lock;
> >  };
> > --
> > 2.34.1
> >
> > ---------------------------------------------------------------------
> > Intel Corporation SAS (French simplified joint stock company)
> > Registered headquarters: "Les Montalets"- 2, rue de Paris,
> > 92196 Meudon Cedex, France
> > Registration Number:  302 456 199 R.C.S. NANTERRE
> > Capital: 5 208 026.16 Euros
> >
> > This e-mail and any attachments may contain confidential material for
> > the sole use of the intended recipient(s). Any review or distribution
> > by others is strictly prohibited. If you are not the intended
> > recipient, please contact the sender and delete all copies.
> >

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
