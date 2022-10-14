Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2B1E0C4332F
	for <virtualization@archiver.kernel.org>; Fri, 14 Oct 2022 06:11:28 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id A168A4222E;
	Fri, 14 Oct 2022 06:11:27 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org A168A4222E
Authentication-Results: smtp4.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=cgkHPyhs
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id OsbfthmKbx_P; Fri, 14 Oct 2022 06:11:26 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 94C664221D;
	Fri, 14 Oct 2022 06:11:25 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 94C664221D
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 5D6C4C0032;
	Fri, 14 Oct 2022 06:11:25 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id D62B1C002D
 for <virtualization@lists.linux-foundation.org>;
 Fri, 14 Oct 2022 06:11:23 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id A9E0C83FF4
 for <virtualization@lists.linux-foundation.org>;
 Fri, 14 Oct 2022 06:11:23 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org A9E0C83FF4
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=cgkHPyhs
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id jqQtQD3-_aPw
 for <virtualization@lists.linux-foundation.org>;
 Fri, 14 Oct 2022 06:11:21 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org A37D583F4E
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp1.osuosl.org (Postfix) with ESMTPS id A37D583F4E
 for <virtualization@lists.linux-foundation.org>;
 Fri, 14 Oct 2022 06:11:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1665727880;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=EoJu4xmfSYwdD44tkVgwFBG2/aBW9GP2syfhG3571/U=;
 b=cgkHPyhs0gtdxGufv5aeQeBF9fT2U4YgZl/UuxE037ufViSXJRXbeJtDhXy3A7waXOFlDJ
 Pun3vXzlVGuN92H7OIHliuCn+kN5s61qVTj2Jr4BP6mjWVFvuecWTLmacEp3MPpL0Snu2C
 QuJSveu14E+au8nrRBBDKtEsB0ilgDM=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-474-fZdgo4zSOEi8QkP2MtLNbA-1; Fri, 14 Oct 2022 02:11:19 -0400
X-MC-Unique: fZdgo4zSOEi8QkP2MtLNbA-1
Received: by mail-wr1-f71.google.com with SMTP id
 e11-20020adfa74b000000b0022e39e5c151so1505153wrd.3
 for <virtualization@lists.linux-foundation.org>;
 Thu, 13 Oct 2022 23:11:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=EoJu4xmfSYwdD44tkVgwFBG2/aBW9GP2syfhG3571/U=;
 b=BggTl7kfNfOxzaSxWVMF5fSTaCZOc5wRtif5T38m9IIBoGdAuzHV3RHU3Zix4qxDHL
 0V1JloCpi8/2PcQRmfmcDrNMOpG8VfX0TpWx2MTGjV/WGxFYzJGL3t9CZQmY/OuakIBP
 xmz0yfesPgRjguMuzXM1VKFhgiVmV6T6fpbHio6X+iVp7lrU2a6ucvzm5GU1DvJ/9hUD
 OOqk3z0TZlR6A6SEOp6NRG2l9ADh9pSdgLwHIIYtsTjbmMw7M2wHjxA0Q2Kkc1FaybWD
 /dnPra2MxhiSjqU9TpnHKyxkoNIc9bu1g/menkoedKxL94EqzsuTfmiUaoDKJV54IEnJ
 5M/w==
X-Gm-Message-State: ACrzQf3qqrPMKG4oz9TWAL16xu8NPdhjeR1rRI2v18zAtyDwXTXf386j
 QpHeDvw4SGg7rdG8zJWJCKOqrXBMXQX3AEgysX7tMn0S/UZQNX7y2mhKHJip5G7bQLgQoFqrkK9
 bgHMbiakinF+g5MYqykKAeAKofRh7SMXjQwnGHF4DLA==
X-Received: by 2002:a05:6000:611:b0:22e:c347:2943 with SMTP id
 bn17-20020a056000061100b0022ec3472943mr2085725wrb.603.1665727877943; 
 Thu, 13 Oct 2022 23:11:17 -0700 (PDT)
X-Google-Smtp-Source: AMsMyM7X8tpvAQJrq0b66m250W8qUNeevipH/F33BWqY2KUQy26OGiaEJJMhB3hn9vjqocr82RzNrg==
X-Received: by 2002:a05:6000:611:b0:22e:c347:2943 with SMTP id
 bn17-20020a056000061100b0022ec3472943mr2085705wrb.603.1665727877674; 
 Thu, 13 Oct 2022 23:11:17 -0700 (PDT)
Received: from redhat.com ([2.54.162.123]) by smtp.gmail.com with ESMTPSA id
 h14-20020a05600c2cae00b003b47e8a5d22sm6637557wmc.23.2022.10.13.23.11.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 13 Oct 2022 23:11:17 -0700 (PDT)
Date: Fri, 14 Oct 2022 02:11:14 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Jason Wang <jasowang@redhat.com>
Subject: Re: [PATCH 2/4] vhost-vdpa: Introduce RESUME backend feature bit
Message-ID: <20221014021012-mutt-send-email-mst@kernel.org>
References: <cover.1665674878.git.sebastien.boeuf@intel.com>
 <72bdc9ae91ca4ed8a2c9ea2aab53f8e04d4512f6.1665674878.git.sebastien.boeuf@intel.com>
 <CACGkMEt7cEocQp70MgtwWjb0yNv_08qq-aKp8ZTbFbTkW6hxbw@mail.gmail.com>
 <20221014020447-mutt-send-email-mst@kernel.org>
 <CACGkMEtSAbO8U4reoAupuixv4KQw-xutCVt6ZXVSsXgM962eJw@mail.gmail.com>
MIME-Version: 1.0
In-Reply-To: <CACGkMEtSAbO8U4reoAupuixv4KQw-xutCVt6ZXVSsXgM962eJw@mail.gmail.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: eperezma@redhat.com, sebastien.boeuf@intel.com,
 virtualization@lists.linux-foundation.org
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

On Fri, Oct 14, 2022 at 02:09:02PM +0800, Jason Wang wrote:
> On Fri, Oct 14, 2022 at 2:05 PM Michael S. Tsirkin <mst@redhat.com> wrote:
> >
> > On Fri, Oct 14, 2022 at 01:58:38PM +0800, Jason Wang wrote:
> > > On Thu, Oct 13, 2022 at 11:35 PM <sebastien.boeuf@intel.com> wrote:
> > > >
> > > > From: Sebastien Boeuf <sebastien.boeuf@intel.com>
> > > >
> > > > Userspace knows if the device can be resumed or not by checking this
> > > > feature bit.
> > > >
> > > > It's only exposed if the vdpa driver backend implements the resume()
> > > > operation callback. Userspace trying to negotiate this feature when it
> > > > hasn't been exposed will result in an error.
> > > >
> > > > Signed-off-by: Sebastien Boeuf <sebastien.boeuf@intel.com>
> > > > ---
> > > >  drivers/vhost/vdpa.c             | 19 ++++++++++++++++++-
> > > >  include/uapi/linux/vhost_types.h |  2 ++
> > > >  2 files changed, 20 insertions(+), 1 deletion(-)
> > > >
> > > > diff --git a/drivers/vhost/vdpa.c b/drivers/vhost/vdpa.c
> > > > index 166044642fd5..161727e1a9a5 100644
> > > > --- a/drivers/vhost/vdpa.c
> > > > +++ b/drivers/vhost/vdpa.c
> > > > @@ -355,6 +355,14 @@ static bool vhost_vdpa_can_suspend(const struct vhost_vdpa *v)
> > > >         return ops->suspend;
> > > >  }
> > > >
> > > > +static bool vhost_vdpa_can_resume(const struct vhost_vdpa *v)
> > > > +{
> > > > +       struct vdpa_device *vdpa = v->vdpa;
> > > > +       const struct vdpa_config_ops *ops = vdpa->config;
> > > > +
> > > > +       return ops->resume;
> > > > +}
> > > > +
> > > >  static long vhost_vdpa_get_features(struct vhost_vdpa *v, u64 __user *featurep)
> > > >  {
> > > >         struct vdpa_device *vdpa = v->vdpa;
> > > > @@ -602,11 +610,18 @@ static long vhost_vdpa_unlocked_ioctl(struct file *filep,
> > > >                 if (copy_from_user(&features, featurep, sizeof(features)))
> > > >                         return -EFAULT;
> > > >                 if (features & ~(VHOST_VDPA_BACKEND_FEATURES |
> > > > -                                BIT_ULL(VHOST_BACKEND_F_SUSPEND)))
> > > > +                                BIT_ULL(VHOST_BACKEND_F_SUSPEND) |
> > > > +                                BIT_ULL(VHOST_BACKEND_F_RESUME)))
> > > >                         return -EOPNOTSUPP;
> > > >                 if ((features & BIT_ULL(VHOST_BACKEND_F_SUSPEND)) &&
> > > >                      !vhost_vdpa_can_suspend(v))
> > > >                         return -EOPNOTSUPP;
> > > > +               if ((features & BIT_ULL(VHOST_BACKEND_F_RESUME)) &&
> > > > +                    !vhost_vdpa_can_resume(v))
> > > > +                       return -EOPNOTSUPP;
> > > > +               if (!(features & BIT_ULL(VHOST_BACKEND_F_SUSPEND)) &&
> > > > +                    (features & BIT_ULL(VHOST_BACKEND_F_RESUME)))
> > > > +                       return -EINVAL;
> > >
> > > Is it better to do the check during the probe? It should be a bug that
> > > we're having a parent that can only do resume but not suspend.
> > >
> > > Thanks
> >
> > well we separated them in the spec ...
> > suspend could have other uses, I won't say it's an invalid
> > config.
> 
> For suspend only, yes. But we should fail the probe with a resume
> only, this is somehow the above code wants to check. Or anything I
> missed?
> 
> Thanks

I am not sure but I would say failing probe is a drastic measure.
if we have no use for a given combination of features let us clear the
feature bit in validation.

> >
> > > >                 vhost_set_backend_features(&v->vdev, features);
> > > >                 return 0;
> > > >         }
> > > > @@ -658,6 +673,8 @@ static long vhost_vdpa_unlocked_ioctl(struct file *filep,
> > > >                 features = VHOST_VDPA_BACKEND_FEATURES;
> > > >                 if (vhost_vdpa_can_suspend(v))
> > > >                         features |= BIT_ULL(VHOST_BACKEND_F_SUSPEND);
> > > > +               if (vhost_vdpa_can_resume(v))
> > > > +                       features |= BIT_ULL(VHOST_BACKEND_F_RESUME);
> > > >                 if (copy_to_user(featurep, &features, sizeof(features)))
> > > >                         r = -EFAULT;
> > > >                 break;
> > > > diff --git a/include/uapi/linux/vhost_types.h b/include/uapi/linux/vhost_types.h
> > > > index 53601ce2c20a..c5690a8992d8 100644
> > > > --- a/include/uapi/linux/vhost_types.h
> > > > +++ b/include/uapi/linux/vhost_types.h
> > > > @@ -163,5 +163,7 @@ struct vhost_vdpa_iova_range {
> > > >  #define VHOST_BACKEND_F_IOTLB_ASID  0x3
> > > >  /* Device can be suspended */
> > > >  #define VHOST_BACKEND_F_SUSPEND  0x4
> > > > +/* Device can be resumed */
> > > > +#define VHOST_BACKEND_F_RESUME  0x5
> > > >
> > > >  #endif
> > > > --
> > > > 2.34.1
> > > >
> > > > ---------------------------------------------------------------------
> > > > Intel Corporation SAS (French simplified joint stock company)
> > > > Registered headquarters: "Les Montalets"- 2, rue de Paris,
> > > > 92196 Meudon Cedex, France
> > > > Registration Number:  302 456 199 R.C.S. NANTERRE
> > > > Capital: 5 208 026.16 Euros
> > > >
> > > > This e-mail and any attachments may contain confidential material for
> > > > the sole use of the intended recipient(s). Any review or distribution
> > > > by others is strictly prohibited. If you are not the intended
> > > > recipient, please contact the sender and delete all copies.
> > > >
> >

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
