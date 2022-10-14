Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 842C7C4332F
	for <virtualization@archiver.kernel.org>; Fri, 14 Oct 2022 09:43:06 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 1F34C405E7;
	Fri, 14 Oct 2022 09:43:06 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 1F34C405E7
Authentication-Results: smtp2.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=SsBWTarw
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id i7-9yI-KSKTT; Fri, 14 Oct 2022 09:43:05 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 4358840606;
	Fri, 14 Oct 2022 09:43:04 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 4358840606
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 11E59C0033;
	Fri, 14 Oct 2022 09:43:04 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id C6DC6C002D
 for <virtualization@lists.linux-foundation.org>;
 Fri, 14 Oct 2022 09:43:02 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 93BE540606
 for <virtualization@lists.linux-foundation.org>;
 Fri, 14 Oct 2022 09:43:02 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 93BE540606
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id zSXhr6ZIw3Xr
 for <virtualization@lists.linux-foundation.org>;
 Fri, 14 Oct 2022 09:43:01 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 95EC3405E7
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 95EC3405E7
 for <virtualization@lists.linux-foundation.org>;
 Fri, 14 Oct 2022 09:43:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1665740580;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=BQXWPNxYrvC18JXrqHnhf0SUKE92dzn/XXVg2PCNb4M=;
 b=SsBWTarwz2uboPVnCSw1k/zpJHo4tRYFJDO81BtevDi/i09cXbTXNGPpq2pOvQtw8+Wi0a
 ZEzwheYBxOsI+bDwjGj2jXNS85653cp8lBoEF1DLAG7Ulg0A/GYup0vUYyzd2K4p6LqbVp
 HqiB/WyS1R7rZk7WkgTaY0RMy2vxhnM=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-335-LHPWRnXAMcS5e0W7iuG7Ng-1; Fri, 14 Oct 2022 05:42:59 -0400
X-MC-Unique: LHPWRnXAMcS5e0W7iuG7Ng-1
Received: by mail-wm1-f72.google.com with SMTP id
 l15-20020a05600c4f0f00b003b4bec80edbso2651082wmq.9
 for <virtualization@lists.linux-foundation.org>;
 Fri, 14 Oct 2022 02:42:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=BQXWPNxYrvC18JXrqHnhf0SUKE92dzn/XXVg2PCNb4M=;
 b=ugBrWpdyGGDYg5kQxF3/C3G8iQAzViDQcI/IEqMzvk+awpDsn3PyxMGm49stGmPbia
 5v4yshy7KgYX/e7S1S7LbeWpPpAoR/q5GbbYNfNFRwx+QuGlpoiYYv0VCpBiL3HFVf5n
 L6OZitlmZnILJbRmBmttluU4RGXbmGVa9pzBVaAYjyCiT2dvnLRTbk+tcQXlhNbSewFc
 dba/Yjs54WSmAnCka/HOHF4BuVOElyIVETEuE6VXfaQss8Tx1eNw1aHWkhJr5vCoMC1i
 TcPYGe1oRkPRXfQCXrEde2HXhxyrAvjx3apTpyfd8tXrjKX94fn6tpuHVGFsqCayWPk4
 5OWQ==
X-Gm-Message-State: ACrzQf30gJy29F5nXqDfFqtpXXIfqTOl9h4v6CRkvbNtaVumk+xPQnuO
 u4KXQydlGNgs0AILVvuF/AXk6gcclkoeKgdhq0QLfW6Pq8oo+kMegaAXf+ZBfCJnF9IivSkJcbu
 dnu1WR+Zu94aHcSldcLZOTqY0z6Es+gBu5vQ2VQhrcA==
X-Received: by 2002:a05:600c:418b:b0:3c6:c1e6:b01c with SMTP id
 p11-20020a05600c418b00b003c6c1e6b01cmr2917925wmh.118.1665740577649; 
 Fri, 14 Oct 2022 02:42:57 -0700 (PDT)
X-Google-Smtp-Source: AMsMyM6w0m32OFMa17lZvhwkb7aRLVhkaC2p9Qdxfi3nrDJz7h6BMPr8bCd4RiMju0JYX/ehcgTppw==
X-Received: by 2002:a05:600c:418b:b0:3c6:c1e6:b01c with SMTP id
 p11-20020a05600c418b00b003c6c1e6b01cmr2917903wmh.118.1665740577261; 
 Fri, 14 Oct 2022 02:42:57 -0700 (PDT)
Received: from redhat.com ([2.54.162.123]) by smtp.gmail.com with ESMTPSA id
 q65-20020a1c4344000000b003a8434530bbsm6679220wma.13.2022.10.14.02.42.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 14 Oct 2022 02:42:56 -0700 (PDT)
Date: Fri, 14 Oct 2022 05:42:53 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: "Boeuf, Sebastien" <sebastien.boeuf@intel.com>
Subject: Re: [PATCH 2/4] vhost-vdpa: Introduce RESUME backend feature bit
Message-ID: <20221014054201-mutt-send-email-mst@kernel.org>
References: <cover.1665674878.git.sebastien.boeuf@intel.com>
 <72bdc9ae91ca4ed8a2c9ea2aab53f8e04d4512f6.1665674878.git.sebastien.boeuf@intel.com>
 <CACGkMEt7cEocQp70MgtwWjb0yNv_08qq-aKp8ZTbFbTkW6hxbw@mail.gmail.com>
 <20221014020447-mutt-send-email-mst@kernel.org>
 <CACGkMEtSAbO8U4reoAupuixv4KQw-xutCVt6ZXVSsXgM962eJw@mail.gmail.com>
 <20221014021012-mutt-send-email-mst@kernel.org>
 <14fc89d250788d7bdbd6b522197efc2c19ff6db8.camel@intel.com>
 <20221014053617-mutt-send-email-mst@kernel.org>
 <fb0d70a095a26a8f8adf4d7659787596d2763ef6.camel@intel.com>
MIME-Version: 1.0
In-Reply-To: <fb0d70a095a26a8f8adf4d7659787596d2763ef6.camel@intel.com>
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

On Fri, Oct 14, 2022 at 09:40:46AM +0000, Boeuf, Sebastien wrote:
> On Fri, 2022-10-14 at 05:37 -0400, Michael S. Tsirkin wrote:
> > On Fri, Oct 14, 2022 at 08:07:08AM +0000, Boeuf, Sebastien wrote:
> > > On Fri, 2022-10-14 at 02:11 -0400, Michael S. Tsirkin wrote:
> > > > On Fri, Oct 14, 2022 at 02:09:02PM +0800, Jason Wang wrote:
> > > > > On Fri, Oct 14, 2022 at 2:05 PM Michael S. Tsirkin
> > > > > <mst@redhat.com>
> > > > > wrote:
> > > > > > =

> > > > > > On Fri, Oct 14, 2022 at 01:58:38PM +0800, Jason Wang wrote:
> > > > > > > On Thu, Oct 13, 2022 at 11:35 PM
> > > > > > > <sebastien.boeuf@intel.com>
> > > > > > > wrote:
> > > > > > > > =

> > > > > > > > From: Sebastien Boeuf <sebastien.boeuf@intel.com>
> > > > > > > > =

> > > > > > > > Userspace knows if the device can be resumed or not by
> > > > > > > > checking this
> > > > > > > > feature bit.
> > > > > > > > =

> > > > > > > > It's only exposed if the vdpa driver backend implements
> > > > > > > > the
> > > > > > > > resume()
> > > > > > > > operation callback. Userspace trying to negotiate this
> > > > > > > > feature when it
> > > > > > > > hasn't been exposed will result in an error.
> > > > > > > > =

> > > > > > > > Signed-off-by: Sebastien Boeuf
> > > > > > > > <sebastien.boeuf@intel.com>
> > > > > > > > ---
> > > > > > > > =A0drivers/vhost/vdpa.c=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
 | 19
> > > > > > > > ++++++++++++++++++-
> > > > > > > > =A0include/uapi/linux/vhost_types.h |=A0 2 ++
> > > > > > > > =A02 files changed, 20 insertions(+), 1 deletion(-)
> > > > > > > > =

> > > > > > > > diff --git a/drivers/vhost/vdpa.c b/drivers/vhost/vdpa.c
> > > > > > > > index 166044642fd5..161727e1a9a5 100644
> > > > > > > > --- a/drivers/vhost/vdpa.c
> > > > > > > > +++ b/drivers/vhost/vdpa.c
> > > > > > > > @@ -355,6 +355,14 @@ static bool
> > > > > > > > vhost_vdpa_can_suspend(const
> > > > > > > > struct vhost_vdpa *v)
> > > > > > > > =A0=A0=A0=A0=A0=A0=A0 return ops->suspend;
> > > > > > > > =A0}
> > > > > > > > =

> > > > > > > > +static bool vhost_vdpa_can_resume(const struct
> > > > > > > > vhost_vdpa
> > > > > > > > *v)
> > > > > > > > +{
> > > > > > > > +=A0=A0=A0=A0=A0=A0 struct vdpa_device *vdpa =3D v->vdpa;
> > > > > > > > +=A0=A0=A0=A0=A0=A0 const struct vdpa_config_ops *ops =3D v=
dpa->config;
> > > > > > > > +
> > > > > > > > +=A0=A0=A0=A0=A0=A0 return ops->resume;
> > > > > > > > +}
> > > > > > > > +
> > > > > > > > =A0static long vhost_vdpa_get_features(struct vhost_vdpa
> > > > > > > > *v,
> > > > > > > > u64 __user *featurep)
> > > > > > > > =A0{
> > > > > > > > =A0=A0=A0=A0=A0=A0=A0 struct vdpa_device *vdpa =3D v->vdpa;
> > > > > > > > @@ -602,11 +610,18 @@ static long
> > > > > > > > vhost_vdpa_unlocked_ioctl(struct file *filep,
> > > > > > > > =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 if (copy_from=
_user(&features, featurep,
> > > > > > > > sizeof(features)))
> > > > > > > > =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0 return -EFAULT;
> > > > > > > > =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 if (features &
> > > > > > > > ~(VHOST_VDPA_BACKEND_FEATURES
> > > > > > > > > =

> > > > > > > > -=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0
> > > > > > > > BIT_ULL(VHOST_BACKEND_F_SUSPEND)))
> > > > > > > > +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0
> > > > > > > > BIT_ULL(VHOST_BACKEND_F_SUSPEND) |
> > > > > > > > +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0
> > > > > > > > BIT_ULL(VHOST_BACKEND_F_RESUME)))
> > > > > > > > =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0 return -EOPNOTSUPP;
> > > > > > > > =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 if ((features=
 &
> > > > > > > > BIT_ULL(VHOST_BACKEND_F_SUSPEND)) &&
> > > > > > > > =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0 !vhost_vdpa_can_suspend(v))
> > > > > > > > =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0 return -EOPNOTSUPP;
> > > > > > > > +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 if ((features &
> > > > > > > > BIT_ULL(VHOST_BACKEND_F_RESUME)) &&
> > > > > > > > +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 =
!vhost_vdpa_can_resume(v))
> > > > > > > > +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0 return -EOPNOTSUPP;
> > > > > > > > +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 if (!(features &
> > > > > > > > BIT_ULL(VHOST_BACKEND_F_SUSPEND)) &&
> > > > > > > > +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 =
(features &
> > > > > > > > BIT_ULL(VHOST_BACKEND_F_RESUME)))
> > > > > > > > +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0 return -EINVAL;
> > > > > > > =

> > > > > > > Is it better to do the check during the probe? It should be
> > > > > > > a
> > > > > > > bug that
> > > > > > > we're having a parent that can only do resume but not
> > > > > > > suspend.
> > > > > > > =

> > > > > > > Thanks
> > > > > > =

> > > > > > well we separated them in the spec ...
> > > > > > suspend could have other uses, I won't say it's an invalid
> > > > > > config.
> > > > > =

> > > > > For suspend only, yes. But we should fail the probe with a
> > > > > resume
> > > > > only, this is somehow the above code wants to check. Or
> > > > > anything I
> > > > > missed?
> > > > > =

> > > > > Thanks
> > > > =

> > > > I am not sure but I would say failing probe is a drastic measure.
> > > > if we have no use for a given combination of features let us
> > > > clear
> > > > the
> > > > feature bit in validation.
> > > =

> > > The current patch only returns an error to the user who might be
> > > trying
> > > to set the RESUME feature bit without the SUSPEND one. But I agree
> > > if
> > > we go down this road, it might be better to also return an error
> > > during
> > > the probe of the backend driver if it provides only the resume
> > > operation.
> > > =

> > > The alternative is to never return the RESUME feature bit as
> > > available
> > > (through GET_BACKEND_FEATURES) if the device is not capable of
> > > being
> > > suspended. This way the vdpa framework would never advertise a
> > > RESUME
> > > feature bit without the SUSPEND one, and the only error that would
> > > have
> > > to be handled should be on the SET_BACKEND_FEATURES (which is what
> > > this
> > > patch does).
> > > =

> > > Please let me know which approach sounds the most appropriate.
> > > =

> > > Thanks,
> > > Sebastien
> > > =

> > > > =

> > > > > > =

> > > > > > > > =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 vhost_set_bac=
kend_features(&v->vdev,
> > > > > > > > features);
> > > > > > > > =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 return 0;
> > > > > > > > =A0=A0=A0=A0=A0=A0=A0 }
> > > > > > > > @@ -658,6 +673,8 @@ static long
> > > > > > > > vhost_vdpa_unlocked_ioctl(struct file *filep,
> > > > > > > > =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 features =3D =
VHOST_VDPA_BACKEND_FEATURES;
> > > > > > > > =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 if (vhost_vdp=
a_can_suspend(v))
> > > > > > > > =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0 features |=3D
> > > > > > > > BIT_ULL(VHOST_BACKEND_F_SUSPEND);
> > > > > > > > +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 if (vhost_vdpa_=
can_resume(v))
> > > > > > > > +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0 features |=3D
> > > > > > > > BIT_ULL(VHOST_BACKEND_F_RESUME);
> > > > > > > > =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 if (copy_to_u=
ser(featurep, &features,
> > > > > > > > sizeof(features)))
> > > > > > > > =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0 r =3D -EFAULT;
> > > > > > > > =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 break;
> > > > > > > > diff --git a/include/uapi/linux/vhost_types.h
> > > > > > > > b/include/uapi/linux/vhost_types.h
> > > > > > > > index 53601ce2c20a..c5690a8992d8 100644
> > > > > > > > --- a/include/uapi/linux/vhost_types.h
> > > > > > > > +++ b/include/uapi/linux/vhost_types.h
> > > > > > > > @@ -163,5 +163,7 @@ struct vhost_vdpa_iova_range {
> > > > > > > > =A0#define VHOST_BACKEND_F_IOTLB_ASID=A0 0x3
> > > > > > > > =A0/* Device can be suspended */
> > > > > > > > =A0#define VHOST_BACKEND_F_SUSPEND=A0 0x4
> > > > > > > > +/* Device can be resumed */
> > > > > > > > +#define VHOST_BACKEND_F_RESUME=A0 0x5
> > > > > > > > =

> > > > > > > > =A0#endif
> > > > > > > > --
> > > > > > > > 2.34.1
> > > > > > > > =

> > > > > > > > ---------------------------------------------------------
> > > > > > > > ----
> > > > > > > > --------
> > > > > > > > Intel Corporation SAS (French simplified joint stock
> > > > > > > > company)
> > > > > > > > Registered headquarters: "Les Montalets"- 2, rue de
> > > > > > > > Paris,
> > > > > > > > 92196 Meudon Cedex, France
> > > > > > > > Registration Number:=A0 302 456 199 R.C.S. NANTERRE
> > > > > > > > Capital: 5 208 026.16 Euros
> > > > > > > > =

> > > > > > > > This e-mail and any attachments may contain confidential
> > > > > > > > material for
> > > > > > > > the sole use of the intended recipient(s). Any review or
> > > > > > > > distribution
> > > > > > > > by others is strictly prohibited. If you are not the
> > > > > > > > intended
> > > > > > > > recipient, please contact the sender and delete all
> > > > > > > > copies.
> > > > > > > > =

> > > > > > =

> > > > =

> > > =

> > > -------------------------------------------------------------------
> > > --
> > > Intel Corporation SAS (French simplified joint stock company)
> > > Registered headquarters: "Les Montalets"- 2, rue de Paris, =

> > > 92196 Meudon Cedex, France
> > > Registration Number:=A0 302 456 199 R.C.S. NANTERRE
> > > Capital: 5 208 026.16 Euros
> > > =

> > > This e-mail and any attachments may contain confidential material
> > > for
> > > the sole use of the intended recipient(s). Any review or
> > > distribution
> > > by others is strictly prohibited. If you are not the intended
> > > recipient, please contact the sender and delete all copies.
> > =

> > =

> > I really feel it's up to the driver.
> =

> So solution number 2? I keep this code and add some logic to the
> GET_BACKEND_FEATURES ioctl so that it wouldn't return the RESUME bit if
> the backend isn't capable of being suspended?

No, what I mean is that caller of SET_BACKEND_FEATURES should not
set RESUME if SUSPEND is not set, and if it does I see no reason to
intervene.


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

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
