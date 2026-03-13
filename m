Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 890E631F9A2
	for <virtualization@lists.linux.dev>; Fri, 13 Mar 2026 05:57:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773381449; cv=none; b=bT5gh+7e/V4NBE3j9ubd0giLrRt4fU8ZLHOBt5dM6Mjd75Etx+PPIu/2SlVtxHuOA+Jmidntg6dCmkwZOtUFOp6R7OKxsohc0ZUzIzW5T6laKlXV5ly9KKRBHj1TeZ9D3qIdFw7ZKttS6ioivOfiAtXDZtgHN/cvnsJBcXDtpsY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773381449; c=relaxed/simple;
	bh=6LU9RC3LvuTZgr4/fipDxTJKnBMmXnq3B/zZ644VQDY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=gFuYYodqP4TjteGTFInLJqrbrZrmI5GoSqBHySJB+46mMFC9MwBeTEi/Z9o3NDlX4FzGb/nJ5G0aeLgnpWgdr/yVi6k40sHzgxQHIvYXP+evXxtTcsMmotTPSCOovoQQizwi/PFTPJVl/MCCalWBmCL1ADj4E+aUG6nWN1e/Ing=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=YVon/Jux; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="YVon/Jux"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1773381446;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=13r0N04/gYatkNkiZEVH1gY5Yc7A6cC9mgkSdzYJ7+0=;
	b=YVon/Jux+IY/PGE3QKiRg9F+bv80G0sBKTwHi+9dRO3z166VPrbjsxbtUHFGdEy/odswrW
	1xipscC7IPlyNLxWewDiKYV3ClIS47uHzz/rG1GTBZybYEQs4RDYVcjgv8/DCPCcf0bgO7
	aSOMJUuVsTkURyPxiHxQNJ55bE1wi9Y=
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com
 [209.85.214.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-504-Tc2feqGXOQWnejEDC176qw-1; Fri, 13 Mar 2026 01:57:25 -0400
X-MC-Unique: Tc2feqGXOQWnejEDC176qw-1
X-Mimecast-MFC-AGG-ID: Tc2feqGXOQWnejEDC176qw_1773381444
Received: by mail-pl1-f200.google.com with SMTP id d9443c01a7336-2ae6961bff0so145386605ad.2
        for <virtualization@lists.linux.dev>; Thu, 12 Mar 2026 22:57:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773381444; x=1773986244;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=13r0N04/gYatkNkiZEVH1gY5Yc7A6cC9mgkSdzYJ7+0=;
        b=CSitibK175Ufq/hHgebg711O8dwsHfKVGBiOh5UFOS10NJcfWD5AuAHVwnU86Yo2Ms
         1wAKhyPdQTVjA3qs/bv1yeLeXXzUBnoG++UUC1Afj8RAyM9RRbReCMAi10fcTZzl7ZsD
         NHi4u6+63xHThzwgAjtEV09YgIe7EsYr4vLNqBTPDbCcJdyDMTYM4zIsMD0hNZCH2SSI
         NraNf27kJjrn1kOp9P0nFcCJ0bMvdvAXHW3t3mZH8hBPhDfl/bWRgZTM2KVsR7DIqxOU
         1H4m2x5qIKUsW9AumDjPSWDbCRULqGKveuzaLSx1aRHBSTPz82yqgDQnr1/bbr7eWqDm
         sXtg==
X-Forwarded-Encrypted: i=1; AJvYcCX2DgWAFARDW3VvTzaUPKTr4vJ2cWbUiHh3yzckpL/R1YXmcNQcV3DcJyPgG1yeRDxZmwN4hl4++oA/LX3o/w==@lists.linux.dev
X-Gm-Message-State: AOJu0YxoOyS8KAaWRkTsfoTBtzY6FyzYRDERrcT7rmD+vYiBL0dwb1Xe
	4g4LwnTXyrjpSVPcHMEiZ2ChTeiMvB8aC2tKyX9/HHtMPZ9r+7HlB3lVx7f0M/9p1ti9tLVvmk4
	LsmJ6hKKN73e/bW74R5DcOWCcBgK5+URFV1fhYRwyKEg9RNVgc/OeB6Z06RfGriHGNcdMTJyx/d
	yCHBEShPuc+ccLiM4+z3IlU1DkBPDL2DhAKzo6N71pYXM=
X-Gm-Gg: ATEYQzwiWTQ4dToyLsNprllbWu0Bb8Cm9VCqsGV33DP/9EqmwreHSqya3nSlY8/e4EE
	v+RbgcggC2Lf1PGyXYHoPysWLPFV9jglqo55v48IwvsVqkxbCCE/aDkisEQStD1J4dozSWDu3Nc
	/i82LYi3TycA3FqSspD00tNjlkTJwfaU0tfHvRQTgOaqVqYpDxwtEGQr5xbI4knJsZv4HwDziYa
	ZE=
X-Received: by 2002:a17:903:ac7:b0:2ae:414c:d0a8 with SMTP id d9443c01a7336-2aecac8782bmr18188015ad.48.1773381444012;
        Thu, 12 Mar 2026 22:57:24 -0700 (PDT)
X-Received: by 2002:a17:903:ac7:b0:2ae:414c:d0a8 with SMTP id
 d9443c01a7336-2aecac8782bmr18187845ad.48.1773381443585; Thu, 12 Mar 2026
 22:57:23 -0700 (PDT)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20260310191019.1099757-1-eperezma@redhat.com> <CACGkMEtAQ1HM_4P0aM2AARy7LVtjFmtzbPGOkYn4jD5KMJ+cBQ@mail.gmail.com>
 <CAJaqyWcdBxgnCppxpF=YNptFAOXtee3tUqn7kXRiM+XO1fy+UA@mail.gmail.com>
In-Reply-To: <CAJaqyWcdBxgnCppxpF=YNptFAOXtee3tUqn7kXRiM+XO1fy+UA@mail.gmail.com>
From: Jason Wang <jasowang@redhat.com>
Date: Fri, 13 Mar 2026 13:57:12 +0800
X-Gm-Features: AaiRm52Yxs_JR0bAi_1VaP6fwMY0VrmcHof6x6cLB5Ie6DyEQjPcQhP2tKbRSkU
Message-ID: <CACGkMEs2D5NKNxq5ZQ_c5xWmfPfHLyeqSbqjMzKUiwdF0XemEA@mail.gmail.com>
Subject: Re: [PATCH v2] vduse: Add suspend
To: Eugenio Perez Martin <eperezma@redhat.com>
Cc: "Michael S . Tsirkin" <mst@redhat.com>, Xuan Zhuo <xuanzhuo@linux.alibaba.com>, 
	Yongji Xie <xieyongji@bytedance.com>, Cindy Lu <lulu@redhat.com>, 
	Maxime Coquelin <mcoqueli@redhat.com>, Stefano Garzarella <sgarzare@redhat.com>, linux-kernel@vger.kernel.org, 
	virtualization@lists.linux.dev, Laurent Vivier <lvivier@redhat.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: 2L0PCiKXptyIyCrA7ykN6RQSU1W_nL5S7ZI8GO2jKRs_1773381444
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Mar 12, 2026 at 2:28=E2=80=AFPM Eugenio Perez Martin
<eperezma@redhat.com> wrote:
>
> On Thu, Mar 12, 2026 at 5:03=E2=80=AFAM Jason Wang <jasowang@redhat.com> =
wrote:
> >
> > On Wed, Mar 11, 2026 at 3:10=E2=80=AFAM Eugenio P=C3=A9rez <eperezma@re=
dhat.com> wrote:
> > >
> > > Implement suspend operation for vduse devices, so vhost-vdpa will off=
er
> > > that backend feature and userspace can effectively suspend the device=
.
> > >
> > > This is a must before get virtqueue indexes (base) for live migration=
,
> > > since the device could modify them after userland gets them.
> >
> > As discussed in the pervious version, let's explain why and the plan
> > to support resume.
> >
>
> Is it ok to explain it just in the patch message or do you prefer
> something like a /* TODO: resume op */ before the suspend callback?

Maybe, but I wonder why lacking resume can make thing like migration
work (e.g when migration fails, we should resume the device, or it's
workaround by reset + DRIVER_OK?).

>
> > >
> > > Signed-off-by: Eugenio P=C3=A9rez <eperezma@redhat.com>
> > > ---
> > > This patch depends on
> > > https://lore.kernel.org/lkml/20260310190759.1097506-1-eperezma@redhat=
.com
> > >
> > > v2:
> > > * Take the rwsem only before the actual kick, not in vduse_vdpa_kick_=
vq.
> > >   This assures that we're not in a critical section.
> > > ---
> > >  drivers/vdpa/vdpa_user/vduse_dev.c | 86 ++++++++++++++++++++++++++++=
+-
> > >  include/uapi/linux/vduse.h         |  4 ++
> > >  2 files changed, 88 insertions(+), 2 deletions(-)
> > >
> > > diff --git a/drivers/vdpa/vdpa_user/vduse_dev.c b/drivers/vdpa/vdpa_u=
ser/vduse_dev.c
> > > index 4f642b95a7cb..f56b1e3eb82d 100644
> > > --- a/drivers/vdpa/vdpa_user/vduse_dev.c
> > > +++ b/drivers/vdpa/vdpa_user/vduse_dev.c
> > > @@ -54,7 +54,8 @@
> > >  #define IRQ_UNBOUND -1
> > >
> > >  /* Supported VDUSE features */
> > > -static const uint64_t vduse_features =3D BIT_U64(VDUSE_F_QUEUE_READY=
);
> > > +static const uint64_t vduse_features =3D BIT_U64(VDUSE_F_QUEUE_READY=
) |
> > > +                                      BIT_U64(VDUSE_F_SUSPEND);
> > >
> > >  /*
> > >   * VDUSE instance have not asked the vduse API version, so assume 0.
> > > @@ -85,6 +86,7 @@ struct vduse_virtqueue {
> > >         int irq_effective_cpu;
> > >         struct cpumask irq_affinity;
> > >         struct kobject kobj;
> > > +       struct vduse_dev *dev;
> > >  };
> > >
> > >  struct vduse_dev;
> > > @@ -134,6 +136,7 @@ struct vduse_dev {
> > >         int minor;
> > >         bool broken;
> > >         bool connected;
> > > +       bool suspended;
> > >         u64 api_version;
> > >         u64 device_features;
> > >         u64 driver_features;
> > > @@ -480,6 +483,7 @@ static void vduse_dev_reset(struct vduse_dev *dev=
)
> > >
> > >         down_write(&dev->rwsem);
> > >
> > > +       dev->suspended =3D false;
> > >         dev->status =3D 0;
> > >         dev->driver_features =3D 0;
> > >         dev->generation++;
> > > @@ -538,6 +542,10 @@ static void vduse_vq_kick(struct vduse_virtqueue=
 *vq)
> > >         if (!vq->ready)
> > >                 goto unlock;
> > >
> > > +       guard(rwsem_read)(&vq->dev->rwsem);
> > > +       if (vq->dev->suspended)
> > > +               return;
> >
> > Any reason for this? E.g We don't do this for other transports.
> >
>
> It's just a hardening but I'm happy to remove it.

Either should be fine.

>
> > Everything else looks good.
> >
> > Thanks
> >
>

Thanks

