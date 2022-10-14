Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2901EC4332F
	for <virtualization@archiver.kernel.org>; Fri, 14 Oct 2022 06:05:41 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 8E9B441E54;
	Fri, 14 Oct 2022 06:05:40 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 8E9B441E54
Authentication-Results: smtp4.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=AbROFedn
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Sz17a26Q9Fbq; Fri, 14 Oct 2022 06:05:39 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 7BA8541D2B;
	Fri, 14 Oct 2022 06:05:38 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 7BA8541D2B
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 3F858C0033;
	Fri, 14 Oct 2022 06:05:38 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 3E271C002D
 for <virtualization@lists.linux-foundation.org>;
 Fri, 14 Oct 2022 06:05:36 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 00A4A401A0
 for <virtualization@lists.linux-foundation.org>;
 Fri, 14 Oct 2022 06:05:36 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 00A4A401A0
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=AbROFedn
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 2GUuOBSN9S8D
 for <virtualization@lists.linux-foundation.org>;
 Fri, 14 Oct 2022 06:05:35 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 2B68C400F1
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 2B68C400F1
 for <virtualization@lists.linux-foundation.org>;
 Fri, 14 Oct 2022 06:05:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1665727533;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=cCZJoXr1DC/HMAiVL11gx2vTN2Y12AiaJPs06JtAc9E=;
 b=AbROFednrf4PGUeUanhqsBOo13yD0BYJmaCG/dtOJV2Xrg8ATI62JmsVOg6wuBl8RxMAsS
 4CyHIIfx2Y0S3+aCcyB689WUR3TPvZAGWZdtE85Jf4Rt9FVEzh2P961g+Owr90KlDJ/27U
 MtNIPJXIeFFSQ+/w8Yl2207DFQq0fj4=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-149-64qvAA-YMM2gzZM2r7Y9rQ-1; Fri, 14 Oct 2022 02:05:32 -0400
X-MC-Unique: 64qvAA-YMM2gzZM2r7Y9rQ-1
Received: by mail-wm1-f70.google.com with SMTP id
 q14-20020a7bce8e000000b003c6b7debf22so1683038wmj.0
 for <virtualization@lists.linux-foundation.org>;
 Thu, 13 Oct 2022 23:05:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=cCZJoXr1DC/HMAiVL11gx2vTN2Y12AiaJPs06JtAc9E=;
 b=IpZa8lSQuwkCuwKIMs2zgx39GSmOOdQrR41ers01phV0XEeiO2xeuztORCt4O8GZRl
 0BcWRV4Ko8c3tpZP07IQCqwAali9sqQiJEA8SfZB+Ij9zebIeNy844Mtbz42uifkK+sv
 FLA+v0+bmxw1EaKzMjL59AEWvG/ILd/QKDxtl5nVfp6Bqyz+AURGMFHUhmJLQGcTjdZB
 4bE34H9uUpfLKCRlOEaXeJCBfPFaOtLeSJhTwzs7twbkRNmEMQZQq906ix/Y33tXYt3s
 wVnEJh/hCJZBtF/WawryTFH0v8DN6umz69Aq1xNz3ZvBqM9x2rWpHgoTVt22blVrM/+v
 HvOw==
X-Gm-Message-State: ACrzQf2k+fBwctPFWmLripxQwm7MTH5l9tNvIFBmlBipfmj3LWWRKUlg
 XYn0TqhExaDUOHkZf8BxKuuSP22LDE+fHmhzE+f9zfRcdBFkmf68yEELvz4Rv2SblEsvoUmwH3I
 ohKvf4M7JcCpyVygJotVwivTeR0mKNSartTcJ/mZtYw==
X-Received: by 2002:a05:6000:2a6:b0:22e:ddd1:d9ff with SMTP id
 l6-20020a05600002a600b0022eddd1d9ffmr1999776wry.447.1665727531546; 
 Thu, 13 Oct 2022 23:05:31 -0700 (PDT)
X-Google-Smtp-Source: AMsMyM4elAne8DicXniYi00wZ9BByYGC5qyFeknQdzYxuHV+bW0SUpvJPv/ntwOiGDL7QhNGgZQdvg==
X-Received: by 2002:a05:6000:2a6:b0:22e:ddd1:d9ff with SMTP id
 l6-20020a05600002a600b0022eddd1d9ffmr1999760wry.447.1665727531293; 
 Thu, 13 Oct 2022 23:05:31 -0700 (PDT)
Received: from redhat.com ([2.54.162.123]) by smtp.gmail.com with ESMTPSA id
 f7-20020a1cc907000000b003b31c560a0csm1223961wmb.12.2022.10.13.23.05.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 13 Oct 2022 23:05:30 -0700 (PDT)
Date: Fri, 14 Oct 2022 02:05:27 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Jason Wang <jasowang@redhat.com>
Subject: Re: [PATCH 2/4] vhost-vdpa: Introduce RESUME backend feature bit
Message-ID: <20221014020447-mutt-send-email-mst@kernel.org>
References: <cover.1665674878.git.sebastien.boeuf@intel.com>
 <72bdc9ae91ca4ed8a2c9ea2aab53f8e04d4512f6.1665674878.git.sebastien.boeuf@intel.com>
 <CACGkMEt7cEocQp70MgtwWjb0yNv_08qq-aKp8ZTbFbTkW6hxbw@mail.gmail.com>
MIME-Version: 1.0
In-Reply-To: <CACGkMEt7cEocQp70MgtwWjb0yNv_08qq-aKp8ZTbFbTkW6hxbw@mail.gmail.com>
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

On Fri, Oct 14, 2022 at 01:58:38PM +0800, Jason Wang wrote:
> On Thu, Oct 13, 2022 at 11:35 PM <sebastien.boeuf@intel.com> wrote:
> >
> > From: Sebastien Boeuf <sebastien.boeuf@intel.com>
> >
> > Userspace knows if the device can be resumed or not by checking this
> > feature bit.
> >
> > It's only exposed if the vdpa driver backend implements the resume()
> > operation callback. Userspace trying to negotiate this feature when it
> > hasn't been exposed will result in an error.
> >
> > Signed-off-by: Sebastien Boeuf <sebastien.boeuf@intel.com>
> > ---
> >  drivers/vhost/vdpa.c             | 19 ++++++++++++++++++-
> >  include/uapi/linux/vhost_types.h |  2 ++
> >  2 files changed, 20 insertions(+), 1 deletion(-)
> >
> > diff --git a/drivers/vhost/vdpa.c b/drivers/vhost/vdpa.c
> > index 166044642fd5..161727e1a9a5 100644
> > --- a/drivers/vhost/vdpa.c
> > +++ b/drivers/vhost/vdpa.c
> > @@ -355,6 +355,14 @@ static bool vhost_vdpa_can_suspend(const struct vhost_vdpa *v)
> >         return ops->suspend;
> >  }
> >
> > +static bool vhost_vdpa_can_resume(const struct vhost_vdpa *v)
> > +{
> > +       struct vdpa_device *vdpa = v->vdpa;
> > +       const struct vdpa_config_ops *ops = vdpa->config;
> > +
> > +       return ops->resume;
> > +}
> > +
> >  static long vhost_vdpa_get_features(struct vhost_vdpa *v, u64 __user *featurep)
> >  {
> >         struct vdpa_device *vdpa = v->vdpa;
> > @@ -602,11 +610,18 @@ static long vhost_vdpa_unlocked_ioctl(struct file *filep,
> >                 if (copy_from_user(&features, featurep, sizeof(features)))
> >                         return -EFAULT;
> >                 if (features & ~(VHOST_VDPA_BACKEND_FEATURES |
> > -                                BIT_ULL(VHOST_BACKEND_F_SUSPEND)))
> > +                                BIT_ULL(VHOST_BACKEND_F_SUSPEND) |
> > +                                BIT_ULL(VHOST_BACKEND_F_RESUME)))
> >                         return -EOPNOTSUPP;
> >                 if ((features & BIT_ULL(VHOST_BACKEND_F_SUSPEND)) &&
> >                      !vhost_vdpa_can_suspend(v))
> >                         return -EOPNOTSUPP;
> > +               if ((features & BIT_ULL(VHOST_BACKEND_F_RESUME)) &&
> > +                    !vhost_vdpa_can_resume(v))
> > +                       return -EOPNOTSUPP;
> > +               if (!(features & BIT_ULL(VHOST_BACKEND_F_SUSPEND)) &&
> > +                    (features & BIT_ULL(VHOST_BACKEND_F_RESUME)))
> > +                       return -EINVAL;
> 
> Is it better to do the check during the probe? It should be a bug that
> we're having a parent that can only do resume but not suspend.
> 
> Thanks

well we separated them in the spec ...
suspend could have other uses, I won't say it's an invalid
config.

> >                 vhost_set_backend_features(&v->vdev, features);
> >                 return 0;
> >         }
> > @@ -658,6 +673,8 @@ static long vhost_vdpa_unlocked_ioctl(struct file *filep,
> >                 features = VHOST_VDPA_BACKEND_FEATURES;
> >                 if (vhost_vdpa_can_suspend(v))
> >                         features |= BIT_ULL(VHOST_BACKEND_F_SUSPEND);
> > +               if (vhost_vdpa_can_resume(v))
> > +                       features |= BIT_ULL(VHOST_BACKEND_F_RESUME);
> >                 if (copy_to_user(featurep, &features, sizeof(features)))
> >                         r = -EFAULT;
> >                 break;
> > diff --git a/include/uapi/linux/vhost_types.h b/include/uapi/linux/vhost_types.h
> > index 53601ce2c20a..c5690a8992d8 100644
> > --- a/include/uapi/linux/vhost_types.h
> > +++ b/include/uapi/linux/vhost_types.h
> > @@ -163,5 +163,7 @@ struct vhost_vdpa_iova_range {
> >  #define VHOST_BACKEND_F_IOTLB_ASID  0x3
> >  /* Device can be suspended */
> >  #define VHOST_BACKEND_F_SUSPEND  0x4
> > +/* Device can be resumed */
> > +#define VHOST_BACKEND_F_RESUME  0x5
> >
> >  #endif
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
