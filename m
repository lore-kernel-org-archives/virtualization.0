Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7329E571
	for <virtualization@lists.linux.dev>; Fri, 13 Feb 2026 01:25:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770945941; cv=none; b=mWHAR50t9NlLiegOROWoo20bL524/UFuyJ/RTLeE2aDVW2vO19FBlz8pH/fX3pflZwyfz6LJApfVutNCPMPsLP6mGFlbUe7r6YCLOGmdDC0WmSV3HcCoVPbADHRA0KS+ZgsqzOVR2SITZ3Wr0KaZx5c1aaO4X5FhMTkqHgeuRG8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770945941; c=relaxed/simple;
	bh=EFWM/dFpcIWaoaUyk33pZi1eZ1MGGBGCL6ud8An2Xjg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=KVcJCoO4tphNUGHTHpb1q/UJa4aqn8NxmMj5OTDJbJYVrINwiUV2nvsMY71SjHIB8NKgg8YOV97WEHgwUUsgNBqwGis4D8fL6Dsw5DVNtr1/KK9AuzmO2wRGpcZS3uNrFk0nFOzYXHH/NDnCoI4O+RY9bZbFeVIpXVe7LDq5JkE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Bk00g1Ij; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Bk00g1Ij"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1770945938;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=o/Onfykzz8t8jduaSYZmQxEjOiuSb0xpRozlsO9aYG8=;
	b=Bk00g1IjJ4eJRayV+2kXYkiKrjyzMnK8uG8SJO0dHc6PXQGck98CIo8fdTYB8jeweA4hDY
	Km4hTSTm6OBk1LPegXUb7CnqYfESODzSlI72XlIrCITQVxzIt4G5armNFuWkj93dCqzwuZ
	VCNgIPnfuunQdvRcrzqYcN1k86fvUWk=
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com
 [209.85.214.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-59-b3yAFWWaPquE22f43y9HxQ-1; Thu, 12 Feb 2026 20:25:37 -0500
X-MC-Unique: b3yAFWWaPquE22f43y9HxQ-1
X-Mimecast-MFC-AGG-ID: b3yAFWWaPquE22f43y9HxQ_1770945936
Received: by mail-pl1-f200.google.com with SMTP id d9443c01a7336-2a7701b6353so5720345ad.3
        for <virtualization@lists.linux.dev>; Thu, 12 Feb 2026 17:25:37 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770945936; x=1771550736;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=o/Onfykzz8t8jduaSYZmQxEjOiuSb0xpRozlsO9aYG8=;
        b=ryzEQuOAZegeNu7ecgGbuci8pUGrX5JyFC3wzJGYfS6RAARPviLQvUdWlldSRoaBr5
         nrNh07dFUOruNYlwPrVTGx3kpQz4tDIFZo2IuHOZFBorXo5g4a/609psbJ6L4uz5l9Gq
         fqkfvq8XJ+uI+3E27Y/+Wpt9cs2evIqRG+CDwsBhX1s1KUhuNdlviAVNrNne/2RHOjAx
         cHlgXMlLSuO7xwtZ78DLbiLGF5cqk+bIDdhqUpoxJMaL42wS4uBJwFsFALOlEsK4agmJ
         7ahGCVvioW1dgkd8tnlWssbXsxE2NiW9ivNRFSiXNTyXa8b8lkNOLMV9oB456Ud0iEJB
         i+KQ==
X-Forwarded-Encrypted: i=1; AJvYcCXisfCZs8b7xHGkppvPEh0ndcDWCpbiWysCbjrHNpP97r8hsXJmWHpJRE9V6W7fMuU0IvPGupDyNd8wcl1VYQ==@lists.linux.dev
X-Gm-Message-State: AOJu0Yz/gkAsyDjADsB9qL5eNJhc8lpozKZlvZpDZnrlcvYXr/9g12Qd
	PehdUTRmiV0+eZ2D4Ct3+xz013ZWzkTa2dsJPtycvkyA6zBK6eMw7KQxWvJbap0lLW8FLgtadVm
	Ys7xbHBPcC8ttMuaGaAxMsmlXBcVcUCfRvrHA5OBIfU9F3sLRutXBkPAO1V61YNseU+FKd26Ju2
	VzLyaWwCq4aAXAeabCpcJE0m1lVX/pELgQROGMFAtlAiQ=
X-Gm-Gg: AZuq6aK+mZoUvSeiLsLR9P3CR+TEYf+BtwIvGCy0LHuEw4VLEY4/c+2C9/0AzYjyV36
	ShoI+Elb+h2Nkt9WgQEz7aq5Xqaob7boiYovUjvvy8U79oH1IKCzFNvxR6PDjqty4mnd2kdTTrN
	6wCItulL00vj4GKA/n859rsoXWBzh4XjS02WfnFc7crNUqxQmDQzwaTv1JEBzpdRyAt+WyM5RuN
	LukVOQ=
X-Received: by 2002:a17:902:d591:b0:2a9:484c:ff2f with SMTP id d9443c01a7336-2ab505057e3mr2448435ad.23.1770945936408;
        Thu, 12 Feb 2026 17:25:36 -0800 (PST)
X-Received: by 2002:a17:902:d591:b0:2a9:484c:ff2f with SMTP id
 d9443c01a7336-2ab505057e3mr2448215ad.23.1770945935909; Thu, 12 Feb 2026
 17:25:35 -0800 (PST)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20260210082554.1582553-1-eperezma@redhat.com> <20260210082554.1582553-4-eperezma@redhat.com>
 <CACGkMEtmnV5xJ6crnfTr5Nk8tZe437OgqB22yTOJ+nnrb0LcPg@mail.gmail.com> <CAJaqyWdN7xdu_=mUzE3GGBtTeW5g6O0YwWnV_UmX+g2+FNDkZA@mail.gmail.com>
In-Reply-To: <CAJaqyWdN7xdu_=mUzE3GGBtTeW5g6O0YwWnV_UmX+g2+FNDkZA@mail.gmail.com>
From: Jason Wang <jasowang@redhat.com>
Date: Fri, 13 Feb 2026 09:25:24 +0800
X-Gm-Features: AZwV_Qg6VDlz7khbdH4Qir7vO7KV7wiHsmwb49abeSnLC8AVnawyH_ouiNhqtPg
Message-ID: <CACGkMEuY0f1xjxc4n6QzKfUa-LFrM-X_xtOpTwm5SWjfVvikHA@mail.gmail.com>
Subject: Re: [PATCH v2 3/5] vduse: add VDUSE_GET_FEATURES ioctl
To: Eugenio Perez Martin <eperezma@redhat.com>
Cc: "Michael S . Tsirkin" <mst@redhat.com>, Cindy Lu <lulu@redhat.com>, Laurent Vivier <lvivier@redhat.com>, 
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>, Maxime Coquelin <mcoqueli@redhat.com>, 
	linux-kernel@vger.kernel.org, Yongji Xie <xieyongji@bytedance.com>, 
	Stefano Garzarella <sgarzare@redhat.com>, virtualization@lists.linux.dev
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: C8CjSDfmD-G_qA7KbsySVSDw1YOKnevvdnrc6OiMLig_1770945936
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 12, 2026 at 4:23=E2=80=AFPM Eugenio Perez Martin
<eperezma@redhat.com> wrote:
>
> On Thu, Feb 12, 2026 at 9:07=E2=80=AFAM Jason Wang <jasowang@redhat.com> =
wrote:
> >
> > On Tue, Feb 10, 2026 at 4:26=E2=80=AFPM Eugenio P=C3=A9rez <eperezma@re=
dhat.com> wrote:
> > >
> > > Add an ioctl to allow VDUSE instances to query the available features
> > > supported by the kernel module.
> > >
> > > Signed-off-by: Eugenio P=C3=A9rez <eperezma@redhat.com>
> > > ---
> > > A simple u64 bitmap is used for feature flags. While a flexible array
> > > could support indefinite expansion, 64 bits is sufficient for the
> > > foreseeable future and simplifies the implementation.
> > >
> > > Also, dev_dbg is used for logging rather than dev_err as these can be
> > > triggered from userspace.
> > > ---
> > > v2:
> > > * return -EINVAL if ioctl called with version < 2, so userland visibl=
e
> > >   reply is kept (Jason).
> > > ---
> > >  drivers/vdpa/vdpa_user/vduse_dev.c | 28 ++++++++++++++++++++++++++++
> > >  include/uapi/linux/vduse.h         |  7 ++++++-
> > >  2 files changed, 34 insertions(+), 1 deletion(-)
> > >
> > > diff --git a/drivers/vdpa/vdpa_user/vduse_dev.c b/drivers/vdpa/vdpa_u=
ser/vduse_dev.c
> > > index d1da7c15d98b..7458cbaed4c7 100644
> > > --- a/drivers/vdpa/vdpa_user/vduse_dev.c
> > > +++ b/drivers/vdpa/vdpa_user/vduse_dev.c
> > > @@ -52,6 +52,9 @@
> > >
> > >  #define IRQ_UNBOUND -1
> > >
> > > +/* Supported VDUSE features */
> > > +static const uint64_t vduse_features;
> > > +
> > >  /*
> > >   * VDUSE instance have not asked the vduse API version, so assume 0.
> > >   *
> > > @@ -1947,6 +1950,19 @@ static bool vduse_validate_config(struct vduse=
_dev_config *config,
> > >                          sizeof(config->reserved)))
> > >                 return false;
> > >
> > > +       if (api_version < VDUSE_API_VERSION_2) {
> > > +               if (config->vduse_features) {
> > > +                       dev_dbg(vduse_ctrl_dev,
> > > +                               "config->vduse_features with version =
%llu",
> > > +                               api_version);
> > > +                       return false;
> > > +               }
> > > +       } else {
> > > +               if (config->vduse_features & ~vduse_features)
> > > +                       return false;
> > > +       }
> > > +
> > > +
> > >         if (api_version < VDUSE_API_VERSION_1 &&
> > >             (config->ngroups || config->nas))
> > >                 return false;
> > > @@ -2207,6 +2223,18 @@ static long vduse_ioctl(struct file *file, uns=
igned int cmd,
> > >                 ret =3D vduse_destroy_dev(name);
> > >                 break;
> > >         }
> > > +       case VDUSE_GET_FEATURES:
> > > +               if (control->api_version < VDUSE_API_VERSION_2) {
> > > +                       dev_dbg(vduse_ctrl_dev,
> > > +                               "VDUSE_GET_FEATURES ioctl with versio=
n %llu",
> > > +                               control->api_version);
> > > +                       ret =3D -EINVAL;
> > > +                       break;
> > > +               }
> > > +
> > > +               ret =3D put_user(vduse_features, (u64 __user *)argp);
> > > +               break;
> > > +
> > >         default:
> > >                 ret =3D -EINVAL;
> > >                 break;
> > > diff --git a/include/uapi/linux/vduse.h b/include/uapi/linux/vduse.h
> > > index 27832d46084c..8898d9daa777 100644
> > > --- a/include/uapi/linux/vduse.h
> > > +++ b/include/uapi/linux/vduse.h
> > > @@ -37,6 +37,7 @@
> > >   * @vq_align: the allocation alignment of virtqueue's metadata
> > >   * @ngroups: number of vq groups that VDUSE device declares
> > >   * @nas: number of address spaces that VDUSE device declares
> > > + * @vduse_features: VDUSE features
> > >   * @reserved: for future use, needs to be initialized to zero
> > >   * @config_size: the size of the configuration space
> > >   * @config: the buffer of the configuration space
> > > @@ -53,7 +54,8 @@ struct vduse_dev_config {
> > >         __u32 vq_align;
> > >         __u32 ngroups; /* if VDUSE_API_VERSION >=3D 1 */
> > >         __u32 nas; /* if VDUSE_API_VERSION >=3D 1 */
> > > -       __u32 reserved[11];
> > > +       __u64 vduse_features;
> >
> > Nit: Should we document " /* if VDUSE_API_VERSION >=3D 2 */
> >
> > But I have an open question, is this better to just introduce a
> > VDUSE_SET_FEATURES then we can do negotiation to avoid bumping API
> > versions?
> >
>
> How do you know if you can call VDUSE_GET_FEATURES and
> VDUSE_SET_FEATURES then? vduse_ioctl does not even return -ENOIOCMD
> but -EINVAL if you call the equivalent of VDUSE_GET_FEATURES on
> current Linux master. Or should the VDUSE instance assume that if the
> ioctl returns -EINVAL the kernel does not support them?

If we go that way, yes.

Thanks

>

