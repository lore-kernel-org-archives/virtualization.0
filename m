Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 64735C433FE
	for <virtualization@archiver.kernel.org>; Fri, 14 Oct 2022 09:37:33 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id DC6D78137C;
	Fri, 14 Oct 2022 09:37:32 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org DC6D78137C
Authentication-Results: smtp1.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=aXdiL1ZM
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id iyj6nJuDaB1T; Fri, 14 Oct 2022 09:37:31 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 244C083FB8;
	Fri, 14 Oct 2022 09:37:31 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 244C083FB8
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id F1F7DC0033;
	Fri, 14 Oct 2022 09:37:30 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 6DE73C002D
 for <virtualization@lists.linux-foundation.org>;
 Fri, 14 Oct 2022 09:37:29 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 420CE8403D
 for <virtualization@lists.linux-foundation.org>;
 Fri, 14 Oct 2022 09:37:29 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 420CE8403D
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id in15rPE12k4E
 for <virtualization@lists.linux-foundation.org>;
 Fri, 14 Oct 2022 09:37:28 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 2D92F83FE6
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 2D92F83FE6
 for <virtualization@lists.linux-foundation.org>;
 Fri, 14 Oct 2022 09:37:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1665740247;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Zx137yiiSuOIeFgDaGOWaQA5ZxQIXXRS3IGDm8WOcEk=;
 b=aXdiL1ZM1+A6n0twRt8yKob/5kzxqNg/pRnyG63koZwjEm0AeY4nGSjet/Hy1INf0PSThV
 r9SOIKvuiKqx5roXST7SU1aeetin4taVBdkoD7cuupME/5OPC1obPx2rbw8CbKIOMd5j3B
 id+l/d34Wy9pFIDxuR8nhIbfWPXgwMI=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-591-hcmG6lKSM6WpB6rGGGBgng-1; Fri, 14 Oct 2022 05:37:23 -0400
X-MC-Unique: hcmG6lKSM6WpB6rGGGBgng-1
Received: by mail-wr1-f72.google.com with SMTP id
 g27-20020adfa49b000000b0022cd5476cc7so1732940wrb.17
 for <virtualization@lists.linux-foundation.org>;
 Fri, 14 Oct 2022 02:37:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=Zx137yiiSuOIeFgDaGOWaQA5ZxQIXXRS3IGDm8WOcEk=;
 b=oHQIJRmPktDdnzQMl2+pIIsIdiVSN/VnEVIqKV9FskVHSA7JYOVZKM3CmuSdcurBxU
 PCEz+v34CO+EP8rOKGqro47Z1apI5SxncUHKuJtmhMsH/MkRaZb4VRM6Y2VCkst5z4fw
 S9tDRwmlvsTh5HUo3xmP3hpz81QmxBYOmAzBHGiWmR5Qa3+s7SnfUk0aUPAZbQkAjBRu
 Vwg7paP2Wo24a2FmYSmQPuc5S/wmlM7MwfeS4lNdgicmB/95RF5rYFFAAJoBvrsinHkI
 gMV0XV/q2OnA6s6DePChJpDP3/M5Jlbnpr29n/A183AobtRTINP9vrqCXDaMJkNh/Ml7
 9Zww==
X-Gm-Message-State: ACrzQf3w/QlW5o8LYEUkkfnd4o5CdOc/UvYmeEyrRZcdNxccrXPJWlaC
 gWrbTscpgd2doDrSAGkyIQnf4k76URm72f2MUPj6P2I2mCUCXGoUbjrNqCzCACBnPOSUpPjjH02
 tKIhZ01R8+As+DFWvRgZCFkCfeiuxqS1WvP6TKNv/Cg==
X-Received: by 2002:a05:600c:410d:b0:3b4:9454:f894 with SMTP id
 j13-20020a05600c410d00b003b49454f894mr9305255wmi.111.1665740242353; 
 Fri, 14 Oct 2022 02:37:22 -0700 (PDT)
X-Google-Smtp-Source: AMsMyM6d6UmTJE+5N/Bhrqv6ZoSH0WwILWwwVi81eHBP92nGXBelSrH9Ndjg4p7pZf8JM/mNrEaEfQ==
X-Received: by 2002:a05:600c:410d:b0:3b4:9454:f894 with SMTP id
 j13-20020a05600c410d00b003b49454f894mr9305237wmi.111.1665740241979; 
 Fri, 14 Oct 2022 02:37:21 -0700 (PDT)
Received: from redhat.com ([2.54.162.123]) by smtp.gmail.com with ESMTPSA id
 q1-20020a056000136100b002301c026acasm1500303wrz.85.2022.10.14.02.37.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 14 Oct 2022 02:37:21 -0700 (PDT)
Date: Fri, 14 Oct 2022 05:37:18 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: "Boeuf, Sebastien" <sebastien.boeuf@intel.com>
Subject: Re: [PATCH 2/4] vhost-vdpa: Introduce RESUME backend feature bit
Message-ID: <20221014053617-mutt-send-email-mst@kernel.org>
References: <cover.1665674878.git.sebastien.boeuf@intel.com>
 <72bdc9ae91ca4ed8a2c9ea2aab53f8e04d4512f6.1665674878.git.sebastien.boeuf@intel.com>
 <CACGkMEt7cEocQp70MgtwWjb0yNv_08qq-aKp8ZTbFbTkW6hxbw@mail.gmail.com>
 <20221014020447-mutt-send-email-mst@kernel.org>
 <CACGkMEtSAbO8U4reoAupuixv4KQw-xutCVt6ZXVSsXgM962eJw@mail.gmail.com>
 <20221014021012-mutt-send-email-mst@kernel.org>
 <14fc89d250788d7bdbd6b522197efc2c19ff6db8.camel@intel.com>
MIME-Version: 1.0
In-Reply-To: <14fc89d250788d7bdbd6b522197efc2c19ff6db8.camel@intel.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: "eperezma@redhat.com" <eperezma@redhat.com>,
 "virtualization@lists.linux-foundation.org"
 <virtualization@lists.linux-foundation.org>
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
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: quoted-printable
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>

On Fri, Oct 14, 2022 at 08:07:08AM +0000, Boeuf, Sebastien wrote:
> On Fri, 2022-10-14 at 02:11 -0400, Michael S. Tsirkin wrote:
> > On Fri, Oct 14, 2022 at 02:09:02PM +0800, Jason Wang wrote:
> > > On Fri, Oct 14, 2022 at 2:05 PM Michael S. Tsirkin <mst@redhat.com>
> > > wrote:
> > > > =

> > > > On Fri, Oct 14, 2022 at 01:58:38PM +0800, Jason Wang wrote:
> > > > > On Thu, Oct 13, 2022 at 11:35 PM <sebastien.boeuf@intel.com>
> > > > > wrote:
> > > > > > =

> > > > > > From: Sebastien Boeuf <sebastien.boeuf@intel.com>
> > > > > > =

> > > > > > Userspace knows if the device can be resumed or not by
> > > > > > checking this
> > > > > > feature bit.
> > > > > > =

> > > > > > It's only exposed if the vdpa driver backend implements the
> > > > > > resume()
> > > > > > operation callback. Userspace trying to negotiate this
> > > > > > feature when it
> > > > > > hasn't been exposed will result in an error.
> > > > > > =

> > > > > > Signed-off-by: Sebastien Boeuf <sebastien.boeuf@intel.com>
> > > > > > ---
> > > > > > =A0drivers/vhost/vdpa.c=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 | 1=
9 ++++++++++++++++++-
> > > > > > =A0include/uapi/linux/vhost_types.h |=A0 2 ++
> > > > > > =A02 files changed, 20 insertions(+), 1 deletion(-)
> > > > > > =

> > > > > > diff --git a/drivers/vhost/vdpa.c b/drivers/vhost/vdpa.c
> > > > > > index 166044642fd5..161727e1a9a5 100644
> > > > > > --- a/drivers/vhost/vdpa.c
> > > > > > +++ b/drivers/vhost/vdpa.c
> > > > > > @@ -355,6 +355,14 @@ static bool vhost_vdpa_can_suspend(const
> > > > > > struct vhost_vdpa *v)
> > > > > > =A0=A0=A0=A0=A0=A0=A0 return ops->suspend;
> > > > > > =A0}
> > > > > > =

> > > > > > +static bool vhost_vdpa_can_resume(const struct vhost_vdpa
> > > > > > *v)
> > > > > > +{
> > > > > > +=A0=A0=A0=A0=A0=A0 struct vdpa_device *vdpa =3D v->vdpa;
> > > > > > +=A0=A0=A0=A0=A0=A0 const struct vdpa_config_ops *ops =3D vdpa-=
>config;
> > > > > > +
> > > > > > +=A0=A0=A0=A0=A0=A0 return ops->resume;
> > > > > > +}
> > > > > > +
> > > > > > =A0static long vhost_vdpa_get_features(struct vhost_vdpa *v,
> > > > > > u64 __user *featurep)
> > > > > > =A0{
> > > > > > =A0=A0=A0=A0=A0=A0=A0 struct vdpa_device *vdpa =3D v->vdpa;
> > > > > > @@ -602,11 +610,18 @@ static long
> > > > > > vhost_vdpa_unlocked_ioctl(struct file *filep,
> > > > > > =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 if (copy_from_use=
r(&features, featurep,
> > > > > > sizeof(features)))
> > > > > > =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0 return -EFAULT;
> > > > > > =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 if (features & ~(=
VHOST_VDPA_BACKEND_FEATURES
> > > > > > |
> > > > > > -=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0
> > > > > > BIT_ULL(VHOST_BACKEND_F_SUSPEND)))
> > > > > > +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0
> > > > > > BIT_ULL(VHOST_BACKEND_F_SUSPEND) |
> > > > > > +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0
> > > > > > BIT_ULL(VHOST_BACKEND_F_RESUME)))
> > > > > > =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0 return -EOPNOTSUPP;
> > > > > > =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 if ((features &
> > > > > > BIT_ULL(VHOST_BACKEND_F_SUSPEND)) &&
> > > > > > =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 !v=
host_vdpa_can_suspend(v))
> > > > > > =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0 return -EOPNOTSUPP;
> > > > > > +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 if ((features &
> > > > > > BIT_ULL(VHOST_BACKEND_F_RESUME)) &&
> > > > > > +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 !vho=
st_vdpa_can_resume(v))
> > > > > > +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0 return -EOPNOTSUPP;
> > > > > > +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 if (!(features &
> > > > > > BIT_ULL(VHOST_BACKEND_F_SUSPEND)) &&
> > > > > > +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 (fea=
tures &
> > > > > > BIT_ULL(VHOST_BACKEND_F_RESUME)))
> > > > > > +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0 return -EINVAL;
> > > > > =

> > > > > Is it better to do the check during the probe? It should be a
> > > > > bug that
> > > > > we're having a parent that can only do resume but not suspend.
> > > > > =

> > > > > Thanks
> > > > =

> > > > well we separated them in the spec ...
> > > > suspend could have other uses, I won't say it's an invalid
> > > > config.
> > > =

> > > For suspend only, yes. But we should fail the probe with a resume
> > > only, this is somehow the above code wants to check. Or anything I
> > > missed?
> > > =

> > > Thanks
> > =

> > I am not sure but I would say failing probe is a drastic measure.
> > if we have no use for a given combination of features let us clear
> > the
> > feature bit in validation.
> =

> The current patch only returns an error to the user who might be trying
> to set the RESUME feature bit without the SUSPEND one. But I agree if
> we go down this road, it might be better to also return an error during
> the probe of the backend driver if it provides only the resume
> operation.
> =

> The alternative is to never return the RESUME feature bit as available
> (through GET_BACKEND_FEATURES) if the device is not capable of being
> suspended. This way the vdpa framework would never advertise a RESUME
> feature bit without the SUSPEND one, and the only error that would have
> to be handled should be on the SET_BACKEND_FEATURES (which is what this
> patch does).
> =

> Please let me know which approach sounds the most appropriate.
> =

> Thanks,
> Sebastien
> =

> > =

> > > > =

> > > > > > =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 vhost_set_backend=
_features(&v->vdev,
> > > > > > features);
> > > > > > =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 return 0;
> > > > > > =A0=A0=A0=A0=A0=A0=A0 }
> > > > > > @@ -658,6 +673,8 @@ static long
> > > > > > vhost_vdpa_unlocked_ioctl(struct file *filep,
> > > > > > =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 features =3D VHOS=
T_VDPA_BACKEND_FEATURES;
> > > > > > =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 if (vhost_vdpa_ca=
n_suspend(v))
> > > > > > =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0 features |=3D
> > > > > > BIT_ULL(VHOST_BACKEND_F_SUSPEND);
> > > > > > +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 if (vhost_vdpa_can_=
resume(v))
> > > > > > +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0 features |=3D
> > > > > > BIT_ULL(VHOST_BACKEND_F_RESUME);
> > > > > > =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 if (copy_to_user(=
featurep, &features,
> > > > > > sizeof(features)))
> > > > > > =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0 r =3D -EFAULT;
> > > > > > =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 break;
> > > > > > diff --git a/include/uapi/linux/vhost_types.h
> > > > > > b/include/uapi/linux/vhost_types.h
> > > > > > index 53601ce2c20a..c5690a8992d8 100644
> > > > > > --- a/include/uapi/linux/vhost_types.h
> > > > > > +++ b/include/uapi/linux/vhost_types.h
> > > > > > @@ -163,5 +163,7 @@ struct vhost_vdpa_iova_range {
> > > > > > =A0#define VHOST_BACKEND_F_IOTLB_ASID=A0 0x3
> > > > > > =A0/* Device can be suspended */
> > > > > > =A0#define VHOST_BACKEND_F_SUSPEND=A0 0x4
> > > > > > +/* Device can be resumed */
> > > > > > +#define VHOST_BACKEND_F_RESUME=A0 0x5
> > > > > > =

> > > > > > =A0#endif
> > > > > > --
> > > > > > 2.34.1
> > > > > > =

> > > > > > -------------------------------------------------------------
> > > > > > --------
> > > > > > Intel Corporation SAS (French simplified joint stock company)
> > > > > > Registered headquarters: "Les Montalets"- 2, rue de Paris,
> > > > > > 92196 Meudon Cedex, France
> > > > > > Registration Number:=A0 302 456 199 R.C.S. NANTERRE
> > > > > > Capital: 5 208 026.16 Euros
> > > > > > =

> > > > > > This e-mail and any attachments may contain confidential
> > > > > > material for
> > > > > > the sole use of the intended recipient(s). Any review or
> > > > > > distribution
> > > > > > by others is strictly prohibited. If you are not the intended
> > > > > > recipient, please contact the sender and delete all copies.
> > > > > > =

> > > > =

> > =

> =

> ---------------------------------------------------------------------
> Intel Corporation SAS (French simplified joint stock company)
> Registered headquarters: "Les Montalets"- 2, rue de Paris, =

> 92196 Meudon Cedex, France
> Registration Number:  302 456 199 R.C.S. NANTERRE
> Capital: 5 208 026.16 Euros
> =

> This e-mail and any attachments may contain confidential material for
> the sole use of the intended recipient(s). Any review or distribution
> by others is strictly prohibited. If you are not the intended
> recipient, please contact the sender and delete all copies.


I really feel it's up to the driver.

-- =

MST

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
