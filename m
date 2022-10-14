Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 146ACC4332F
	for <virtualization@archiver.kernel.org>; Fri, 14 Oct 2022 06:09:20 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 95DF440FD1;
	Fri, 14 Oct 2022 06:09:19 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 95DF440FD1
Authentication-Results: smtp2.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=aU7k5gjW
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id kKZWJYSVYN8y; Fri, 14 Oct 2022 06:09:18 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 14EF7400F1;
	Fri, 14 Oct 2022 06:09:18 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 14EF7400F1
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id CBD71C0033;
	Fri, 14 Oct 2022 06:09:17 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 56109C002D
 for <virtualization@lists.linux-foundation.org>;
 Fri, 14 Oct 2022 06:09:17 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 1D66C60D50
 for <virtualization@lists.linux-foundation.org>;
 Fri, 14 Oct 2022 06:09:17 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 1D66C60D50
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=aU7k5gjW
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id yflKfVhVwHRt
 for <virtualization@lists.linux-foundation.org>;
 Fri, 14 Oct 2022 06:09:16 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 5D77F60C17
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 5D77F60C17
 for <virtualization@lists.linux-foundation.org>;
 Fri, 14 Oct 2022 06:09:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1665727755;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=M7UUGPH9h5s7ZOCe1Ciiecq+EMzBWPMU/PsmUP091xI=;
 b=aU7k5gjWVaeRy7FmdNn2A7y01O1A6KZKd+V3BONhZYYMLPHoANbMkf2DHe313FBQEX/cH3
 FjAEIt4zTCzPCtDUtfKfMIo/a9seDqIaACm0FV0P2VLgBmYSzh14CoA+fMocis2stOupWa
 BFHR3lGtAvVbTf3yTyP+34rJVa6NT3c=
Received: from mail-oo1-f71.google.com (mail-oo1-f71.google.com
 [209.85.161.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-398-FJ7OqZhaNpKzNkzNw7ej3A-1; Fri, 14 Oct 2022 02:09:13 -0400
X-MC-Unique: FJ7OqZhaNpKzNkzNw7ej3A-1
Received: by mail-oo1-f71.google.com with SMTP id
 t10-20020a4a760a000000b004809c721ac0so1685136ooc.4
 for <virtualization@lists.linux-foundation.org>;
 Thu, 13 Oct 2022 23:09:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=M7UUGPH9h5s7ZOCe1Ciiecq+EMzBWPMU/PsmUP091xI=;
 b=jxLPV69strZVuVwKoR3Heq0NC1gIzQFSg3oWd9WJOMEGpZUOyoNV1U2kHOLCXP48Lb
 f2XnTcB8zWf05x+8g5GaWXC/9VUq4MisG+kGX07dYZLdZv+Hju75qOQhULA0wRack89V
 7Op+1ZL+zm4kjGsD1myXLRpO1qzk+jZWDDeUSTcJqW+XrM3zuobRs2D1xD4g54LtLjO/
 nVHzAhA9peORTDKuKpS+/UWZl2MNrfLysvo+GO9GtN9cNaEqsHJ/iCKdySaw5g6+OMHj
 yjsElYjmOidy3bHf1ZbyXCzjoV+En1ix1HDPFtzUvzDCtdUjpaSaS5WAwIRiAzHgHTVY
 dCRg==
X-Gm-Message-State: ACrzQf1UeFGDLd8V4iRjIiS9GRJk4YGCOgXgJ2aKMw+kYoa32mA7538o
 mP6gm9X2EO9QIAShnaXNyCLCgd3cuUqBK9mrwdrsWM6iAGrJftYtsOhE+0EMEMuHQwtf+674lKI
 4Gv+Mhhk0lzSf6U2+HODZkgNUHzHd2oaBMmFqy3SgN59sIdtOSf5kJ/4hlg==
X-Received: by 2002:a9d:7dcf:0:b0:661:dc25:ba0 with SMTP id
 k15-20020a9d7dcf000000b00661dc250ba0mr1088241otn.201.1665727753027; 
 Thu, 13 Oct 2022 23:09:13 -0700 (PDT)
X-Google-Smtp-Source: AMsMyM5868onnCq6n1ekU0s/8q5mahwlZ0b71YHwgxwZtHzeSui/VuxdvazEaXADPuvxdNcxTYLENFx5GBQNI47PYvo=
X-Received: by 2002:a9d:7dcf:0:b0:661:dc25:ba0 with SMTP id
 k15-20020a9d7dcf000000b00661dc250ba0mr1088238otn.201.1665727752805; Thu, 13
 Oct 2022 23:09:12 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1665674878.git.sebastien.boeuf@intel.com>
 <72bdc9ae91ca4ed8a2c9ea2aab53f8e04d4512f6.1665674878.git.sebastien.boeuf@intel.com>
 <CACGkMEt7cEocQp70MgtwWjb0yNv_08qq-aKp8ZTbFbTkW6hxbw@mail.gmail.com>
 <20221014020447-mutt-send-email-mst@kernel.org>
In-Reply-To: <20221014020447-mutt-send-email-mst@kernel.org>
From: Jason Wang <jasowang@redhat.com>
Date: Fri, 14 Oct 2022 14:09:02 +0800
Message-ID: <CACGkMEtSAbO8U4reoAupuixv4KQw-xutCVt6ZXVSsXgM962eJw@mail.gmail.com>
Subject: Re: [PATCH 2/4] vhost-vdpa: Introduce RESUME backend feature bit
To: "Michael S. Tsirkin" <mst@redhat.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
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

On Fri, Oct 14, 2022 at 2:05 PM Michael S. Tsirkin <mst@redhat.com> wrote:
>
> On Fri, Oct 14, 2022 at 01:58:38PM +0800, Jason Wang wrote:
> > On Thu, Oct 13, 2022 at 11:35 PM <sebastien.boeuf@intel.com> wrote:
> > >
> > > From: Sebastien Boeuf <sebastien.boeuf@intel.com>
> > >
> > > Userspace knows if the device can be resumed or not by checking this
> > > feature bit.
> > >
> > > It's only exposed if the vdpa driver backend implements the resume()
> > > operation callback. Userspace trying to negotiate this feature when it
> > > hasn't been exposed will result in an error.
> > >
> > > Signed-off-by: Sebastien Boeuf <sebastien.boeuf@intel.com>
> > > ---
> > >  drivers/vhost/vdpa.c             | 19 ++++++++++++++++++-
> > >  include/uapi/linux/vhost_types.h |  2 ++
> > >  2 files changed, 20 insertions(+), 1 deletion(-)
> > >
> > > diff --git a/drivers/vhost/vdpa.c b/drivers/vhost/vdpa.c
> > > index 166044642fd5..161727e1a9a5 100644
> > > --- a/drivers/vhost/vdpa.c
> > > +++ b/drivers/vhost/vdpa.c
> > > @@ -355,6 +355,14 @@ static bool vhost_vdpa_can_suspend(const struct vhost_vdpa *v)
> > >         return ops->suspend;
> > >  }
> > >
> > > +static bool vhost_vdpa_can_resume(const struct vhost_vdpa *v)
> > > +{
> > > +       struct vdpa_device *vdpa = v->vdpa;
> > > +       const struct vdpa_config_ops *ops = vdpa->config;
> > > +
> > > +       return ops->resume;
> > > +}
> > > +
> > >  static long vhost_vdpa_get_features(struct vhost_vdpa *v, u64 __user *featurep)
> > >  {
> > >         struct vdpa_device *vdpa = v->vdpa;
> > > @@ -602,11 +610,18 @@ static long vhost_vdpa_unlocked_ioctl(struct file *filep,
> > >                 if (copy_from_user(&features, featurep, sizeof(features)))
> > >                         return -EFAULT;
> > >                 if (features & ~(VHOST_VDPA_BACKEND_FEATURES |
> > > -                                BIT_ULL(VHOST_BACKEND_F_SUSPEND)))
> > > +                                BIT_ULL(VHOST_BACKEND_F_SUSPEND) |
> > > +                                BIT_ULL(VHOST_BACKEND_F_RESUME)))
> > >                         return -EOPNOTSUPP;
> > >                 if ((features & BIT_ULL(VHOST_BACKEND_F_SUSPEND)) &&
> > >                      !vhost_vdpa_can_suspend(v))
> > >                         return -EOPNOTSUPP;
> > > +               if ((features & BIT_ULL(VHOST_BACKEND_F_RESUME)) &&
> > > +                    !vhost_vdpa_can_resume(v))
> > > +                       return -EOPNOTSUPP;
> > > +               if (!(features & BIT_ULL(VHOST_BACKEND_F_SUSPEND)) &&
> > > +                    (features & BIT_ULL(VHOST_BACKEND_F_RESUME)))
> > > +                       return -EINVAL;
> >
> > Is it better to do the check during the probe? It should be a bug that
> > we're having a parent that can only do resume but not suspend.
> >
> > Thanks
>
> well we separated them in the spec ...
> suspend could have other uses, I won't say it's an invalid
> config.

For suspend only, yes. But we should fail the probe with a resume
only, this is somehow the above code wants to check. Or anything I
missed?

Thanks

>
> > >                 vhost_set_backend_features(&v->vdev, features);
> > >                 return 0;
> > >         }
> > > @@ -658,6 +673,8 @@ static long vhost_vdpa_unlocked_ioctl(struct file *filep,
> > >                 features = VHOST_VDPA_BACKEND_FEATURES;
> > >                 if (vhost_vdpa_can_suspend(v))
> > >                         features |= BIT_ULL(VHOST_BACKEND_F_SUSPEND);
> > > +               if (vhost_vdpa_can_resume(v))
> > > +                       features |= BIT_ULL(VHOST_BACKEND_F_RESUME);
> > >                 if (copy_to_user(featurep, &features, sizeof(features)))
> > >                         r = -EFAULT;
> > >                 break;
> > > diff --git a/include/uapi/linux/vhost_types.h b/include/uapi/linux/vhost_types.h
> > > index 53601ce2c20a..c5690a8992d8 100644
> > > --- a/include/uapi/linux/vhost_types.h
> > > +++ b/include/uapi/linux/vhost_types.h
> > > @@ -163,5 +163,7 @@ struct vhost_vdpa_iova_range {
> > >  #define VHOST_BACKEND_F_IOTLB_ASID  0x3
> > >  /* Device can be suspended */
> > >  #define VHOST_BACKEND_F_SUSPEND  0x4
> > > +/* Device can be resumed */
> > > +#define VHOST_BACKEND_F_RESUME  0x5
> > >
> > >  #endif
> > > --
> > > 2.34.1
> > >
> > > ---------------------------------------------------------------------
> > > Intel Corporation SAS (French simplified joint stock company)
> > > Registered headquarters: "Les Montalets"- 2, rue de Paris,
> > > 92196 Meudon Cedex, France
> > > Registration Number:  302 456 199 R.C.S. NANTERRE
> > > Capital: 5 208 026.16 Euros
> > >
> > > This e-mail and any attachments may contain confidential material for
> > > the sole use of the intended recipient(s). Any review or distribution
> > > by others is strictly prohibited. If you are not the intended
> > > recipient, please contact the sender and delete all copies.
> > >
>

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
