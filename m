Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 134498F47
	for <virtualization@lists.linux-foundation.org>; Wed, 24 Apr 2024 03:15:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.136
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713928543; cv=none; b=c/SfPx4ZpPwnf/cevtJ58SMY9VrtJRFgDiTOAtBcO6xOI+GN2vSpB7pLGgNkGWPQQbaICOYq5PFvoAKJ9Y6wmxGIDiuiTpQuqPf0U5bFb3JPxvyG2AmuSO45PNDBa+VmbKVHBTqajaMGqowoJUE42eRk8TlaMKczEZ1tbmEnnSk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713928543; c=relaxed/simple;
	bh=NGmbSMkF+xL8LH8gNNiByBDOn1Ho7TAhVQP5ngZJ200=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ktoa6WBkQpyi0eDnfnbpSPPQHgYfF6oieMDqam+RKApyL412RVBrmZzL0G2PxT6LnhO3bRvuJm2k4KUSBlJRTAQxpQKB0+XXhHPGN1IeixsWPbFoyLlisxEmdXZXT1dybAyxkbk8cTHRR4ofQGm8Fdmi7gJUBy+y9NLWL/RHq54=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=eIaghEtJ; arc=none smtp.client-ip=140.211.166.136
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="eIaghEtJ"
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 915E660A67
	for <virtualization@lists.linux-foundation.org>; Wed, 24 Apr 2024 03:15:41 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -2.099
X-Spam-Level:
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id YmCMGexc7yyc for <virtualization@lists.linux-foundation.org>;
 Wed, 24 Apr 2024 03:15:40 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=170.10.129.124; helo=us-smtp-delivery-124.mimecast.com; envelope-from=lulu@redhat.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp3.osuosl.org 8F93860A56
Authentication-Results: smtp3.osuosl.org; dmarc=pass (p=none dis=none) header.from=redhat.com
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 8F93860A56
Authentication-Results: smtp3.osuosl.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=eIaghEtJ
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 8F93860A56
	for <virtualization@lists.linux-foundation.org>; Wed, 24 Apr 2024 03:15:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1713928539;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=XJEFMAfNT/VB4mDk82qfL5Q4Ip01msm7cEvY6vFaAL0=;
	b=eIaghEtJSUnQVe8NPVF8mMTCYKl0W3sCrgo/akhfmN9Xtwj/yfyVyhCInIsiDTpcBuXkYJ
	gS7xqlCILim4ZyBPqIartz9laMK7lYWGhcajJ/FmXMlNOpqRlNkooZefqDGSWp7Vfz+bXI
	KoOuSf8nkO+q96/XSRHoN6e0E/E67gk=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-151-K4L8QsmkPTKvMGAwc8VfGg-1; Tue, 23 Apr 2024 23:15:37 -0400
X-MC-Unique: K4L8QsmkPTKvMGAwc8VfGg-1
Received: by mail-ej1-f69.google.com with SMTP id a640c23a62f3a-a46852c2239so419584466b.1
        for <virtualization@lists.linux-foundation.org>; Tue, 23 Apr 2024 20:15:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713928537; x=1714533337;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XJEFMAfNT/VB4mDk82qfL5Q4Ip01msm7cEvY6vFaAL0=;
        b=P8y2hXUmT1Mjz6ueDXxJju3LIFmBdim2Rr4PFnuSZvFtsi1oIz9F4NdYqUIaNCzMJy
         pX3ujjPkaVReCI245JitbRqtLCImfffZcG9G1dEOfP5tDuN2sM7+h8zg7wuHV4I22rcy
         bh2/+cZTX6uUlRN3nqX26dhkjL4f02jK75Y285vItZsqxyn+fdGfcVhH8wMNfq3K2ULP
         d9+cJ/iFEpjq6dzOGyrOzrW1RcO45aQ+6hyEK1Jl6LrPnDvIWJ64jvXzuUmigLmZfgyp
         6M52VUuFkEh3/JlriMpGc333g+Na7omIAWKZQSapMuFGkEvXI5M3QE9COF6ywYeZkRSa
         I4rg==
X-Forwarded-Encrypted: i=1; AJvYcCViYFBEnbHaG+noPmuSQBBWvBp2KT1tM8QCWGOCEUzgWsIsarV/9jDjmL4hAvjaG+IUQo0Ar0aDSejFjl92aOH+OnoIo0TrL2DyRHpo2ywIE+19WzFSTQW8ww==
X-Gm-Message-State: AOJu0YzvApyijHnEAodW9Z2LeeWYln/Xt0bOBzydu1c1SkuCm/PKDY54
	PbHG4ZOqVRAk7IGG3QsGvjMxEfmkkPy6MpXhNtEBxMIXInuG8kA7Dh9gwZVDSb0oO88U5u53dTg
	c7shAODhz6NFAbyW9abwXuU9rCQQZ/1tavkGZzi0IO6c90aPYE2gjoDl8EdewJDuEXaZAdjQcCo
	NkiQH+w92f0Vf/idabAomPIKF/G9rCjYuLAc4j6WLWHZnJ646nkFt7UA==
X-Received: by 2002:a17:906:7742:b0:a55:be6d:b9f8 with SMTP id o2-20020a170906774200b00a55be6db9f8mr679669ejn.10.1713928536836;
        Tue, 23 Apr 2024 20:15:36 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHCWGb5O13pyxly439eZL1uccGa42ATOngPW0NRGAwmb9r4pF1qLk8akyMToctAr5gVztjZPrVAmm9SvVGPQaU=
X-Received: by 2002:a17:906:7742:b0:a55:be6d:b9f8 with SMTP id
 o2-20020a170906774200b00a55be6db9f8mr679665ejn.10.1713928536512; Tue, 23 Apr
 2024 20:15:36 -0700 (PDT)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20240412133017.483407-1-lulu@redhat.com> <20240412133017.483407-4-lulu@redhat.com>
 <20240417052723-mutt-send-email-mst@kernel.org> <CACGkMEtv56TSaA=W337hFU3VALfbrGMcEdu25O4Ecx7guUacyQ@mail.gmail.com>
 <20240422160348-mutt-send-email-mst@kernel.org> <CACGkMEsj1aYBBO+kh5wmTk9vh=QRj50FHPFZ6QX3gs1Jh+XQdA@mail.gmail.com>
 <20240423043538-mutt-send-email-mst@kernel.org> <CACGkMEvbrH-ERbr-4DVpvK6+V_8Bh79YdYTdfWKhk5ziwcLDjg@mail.gmail.com>
In-Reply-To: <CACGkMEvbrH-ERbr-4DVpvK6+V_8Bh79YdYTdfWKhk5ziwcLDjg@mail.gmail.com>
From: Cindy Lu <lulu@redhat.com>
Date: Wed, 24 Apr 2024 11:14:59 +0800
Message-ID: <CACLfguXzMEjXrC9dnO=q7cvoVAusQT930Wh8w4cHon_KTLpOtA@mail.gmail.com>
Subject: Re: [PATCH v5 3/5] vduse: Add function to get/free the pages for reconnection
To: Jason Wang <jasowang@redhat.com>
Cc: "Michael S. Tsirkin" <mst@redhat.com>, linux-kernel@vger.kernel.org, 
	virtualization@lists.linux-foundation.org
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 24, 2024 at 8:44=E2=80=AFAM Jason Wang <jasowang@redhat.com> wr=
ote:
>
> On Tue, Apr 23, 2024 at 4:42=E2=80=AFPM Michael S. Tsirkin <mst@redhat.co=
m> wrote:
> >
> > On Tue, Apr 23, 2024 at 11:09:59AM +0800, Jason Wang wrote:
> > > On Tue, Apr 23, 2024 at 4:05=E2=80=AFAM Michael S. Tsirkin <mst@redha=
t.com> wrote:
> > > >
> > > > On Thu, Apr 18, 2024 at 08:57:51AM +0800, Jason Wang wrote:
> > > > > On Wed, Apr 17, 2024 at 5:29=E2=80=AFPM Michael S. Tsirkin <mst@r=
edhat.com> wrote:
> > > > > >
> > > > > > On Fri, Apr 12, 2024 at 09:28:23PM +0800, Cindy Lu wrote:
> > > > > > > Add the function vduse_alloc_reconnnect_info_mem
> > > > > > > and vduse_alloc_reconnnect_info_mem
> > > > > > > These functions allow vduse to allocate and free memory for r=
econnection
> > > > > > > information. The amount of memory allocated is vq_num pages.
> > > > > > > Each VQS will map its own page where the reconnection informa=
tion will be saved
> > > > > > >
> > > > > > > Signed-off-by: Cindy Lu <lulu@redhat.com>
> > > > > > > ---
> > > > > > >  drivers/vdpa/vdpa_user/vduse_dev.c | 40 ++++++++++++++++++++=
++++++++++
> > > > > > >  1 file changed, 40 insertions(+)
> > > > > > >
> > > > > > > diff --git a/drivers/vdpa/vdpa_user/vduse_dev.c b/drivers/vdp=
a/vdpa_user/vduse_dev.c
> > > > > > > index ef3c9681941e..2da659d5f4a8 100644
> > > > > > > --- a/drivers/vdpa/vdpa_user/vduse_dev.c
> > > > > > > +++ b/drivers/vdpa/vdpa_user/vduse_dev.c
> > > > > > > @@ -65,6 +65,7 @@ struct vduse_virtqueue {
> > > > > > >       int irq_effective_cpu;
> > > > > > >       struct cpumask irq_affinity;
> > > > > > >       struct kobject kobj;
> > > > > > > +     unsigned long vdpa_reconnect_vaddr;
> > > > > > >  };
> > > > > > >
> > > > > > >  struct vduse_dev;
> > > > > > > @@ -1105,6 +1106,38 @@ static void vduse_vq_update_effective_=
cpu(struct vduse_virtqueue *vq)
> > > > > > >
> > > > > > >       vq->irq_effective_cpu =3D curr_cpu;
> > > > > > >  }
> > > > > > > +static int vduse_alloc_reconnnect_info_mem(struct vduse_dev =
*dev)
> > > > > > > +{
> > > > > > > +     unsigned long vaddr =3D 0;
> > > > > > > +     struct vduse_virtqueue *vq;
> > > > > > > +
> > > > > > > +     for (int i =3D 0; i < dev->vq_num; i++) {
> > > > > > > +             /*page 0~ vq_num save the reconnect info for vq=
*/
> > > > > > > +             vq =3D dev->vqs[i];
> > > > > > > +             vaddr =3D get_zeroed_page(GFP_KERNEL);
> > > > > >
> > > > > >
> > > > > > I don't get why you insist on stealing kernel memory for someth=
ing
> > > > > > that is just used by userspace to store data for its own use.
> > > > > > Userspace does not lack ways to persist data, for example,
> > > > > > create a regular file anywhere in the filesystem.
> > > > >
> > > > > Good point. So the motivation here is to:
> > > > >
> > > > > 1) be self contained, no dependency for high speed persist data
> > > > > storage like tmpfs
> > > >
> > > > No idea what this means.
> > >
> > > I mean a regular file may slow down the datapath performance, so
> > > usually the application will try to use tmpfs and other which is a
> > > dependency for implementing the reconnection.
> >
> > Are we worried about systems without tmpfs now?
>
> Yes.
>
> >
> >
> > > >
> > > > > 2) standardize the format in uAPI which allows reconnection from
> > > > > arbitrary userspace, unfortunately, such effort was removed in ne=
w
> > > > > versions
> > > >
> > > > And I don't see why that has to live in the kernel tree either.
> > >
> > > I can't find a better place, any idea?
> > >
> > > Thanks
> >
> >
> > Well anywhere on github really. with libvhost-user maybe?
> > It's harmless enough in Documentation
> > if you like but ties you to the kernel release cycle in a way that
> > is completely unnecessary.
>
> Ok.
>
> Thanks
>
Sure, got it. Do we need to withdraw all the series? maybe we can keep
the patch for support ioctl to get status and configure?

thanks
cindy

> >
> > > >
> > > > > If the above doesn't make sense, we don't need to offer those pag=
es by VDUSE.
> > > > >
> > > > > Thanks
> > > > >
> > > > >
> > > > > >
> > > > > >
> > > > > >
> > > > > > > +             if (vaddr =3D=3D 0)
> > > > > > > +                     return -ENOMEM;
> > > > > > > +
> > > > > > > +             vq->vdpa_reconnect_vaddr =3D vaddr;
> > > > > > > +     }
> > > > > > > +
> > > > > > > +     return 0;
> > > > > > > +}
> > > > > > > +
> > > > > > > +static int vduse_free_reconnnect_info_mem(struct vduse_dev *=
dev)
> > > > > > > +{
> > > > > > > +     struct vduse_virtqueue *vq;
> > > > > > > +
> > > > > > > +     for (int i =3D 0; i < dev->vq_num; i++) {
> > > > > > > +             vq =3D dev->vqs[i];
> > > > > > > +
> > > > > > > +             if (vq->vdpa_reconnect_vaddr)
> > > > > > > +                     free_page(vq->vdpa_reconnect_vaddr);
> > > > > > > +             vq->vdpa_reconnect_vaddr =3D 0;
> > > > > > > +     }
> > > > > > > +
> > > > > > > +     return 0;
> > > > > > > +}
> > > > > > >
> > > > > > >  static long vduse_dev_ioctl(struct file *file, unsigned int =
cmd,
> > > > > > >                           unsigned long arg)
> > > > > > > @@ -1672,6 +1705,8 @@ static int vduse_destroy_dev(char *name=
)
> > > > > > >               mutex_unlock(&dev->lock);
> > > > > > >               return -EBUSY;
> > > > > > >       }
> > > > > > > +     vduse_free_reconnnect_info_mem(dev);
> > > > > > > +
> > > > > > >       dev->connected =3D true;
> > > > > > >       mutex_unlock(&dev->lock);
> > > > > > >
> > > > > > > @@ -1855,12 +1890,17 @@ static int vduse_create_dev(struct vd=
use_dev_config *config,
> > > > > > >       ret =3D vduse_dev_init_vqs(dev, config->vq_align, confi=
g->vq_num);
> > > > > > >       if (ret)
> > > > > > >               goto err_vqs;
> > > > > > > +     ret =3D vduse_alloc_reconnnect_info_mem(dev);
> > > > > > > +     if (ret < 0)
> > > > > > > +             goto err_mem;
> > > > > > >
> > > > > > >       __module_get(THIS_MODULE);
> > > > > > >
> > > > > > >       return 0;
> > > > > > >  err_vqs:
> > > > > > >       device_destroy(&vduse_class, MKDEV(MAJOR(vduse_major), =
dev->minor));
> > > > > > > +err_mem:
> > > > > > > +     vduse_free_reconnnect_info_mem(dev);
> > > > > > >  err_dev:
> > > > > > >       idr_remove(&vduse_idr, dev->minor);
> > > > > > >  err_idr:
> > > > > > > --
> > > > > > > 2.43.0
> > > > > >
> > > >
> >
>

