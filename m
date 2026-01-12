Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94C813033C7
	for <virtualization@lists.linux.dev>; Mon, 12 Jan 2026 07:52:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768204344; cv=none; b=B/gVmGDJ8y+mE87i4ng7tWnweZFwaBlSUouS6jgu37oL7fIEpduYEH2vmMGwW/lkNknESM9nn1MVuuvrwAv65AClpI1N711QcHvBPcxnXawEjD392tU1rn299BnhLrkXBUjxs/YpaI2d4+7GgKEZP/fukv1AQIKqj4tLMylUrNI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768204344; c=relaxed/simple;
	bh=i90nEIIozGoI/x4S+6KWWvuPXpuM+3ehCHKkTfFqxZg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=EI2Qxt1aJaUZETRrnPn1O6hBYdUs71p4eayli/Td3UwqD491h6F+r98LDbjIBHrSfazkoE+w8s8rRtHT9pNR/HUQhNF/QoBKaZ7uqxblNcRMtKBZXg9ZxAKGsWcElfrRzcRdYZ2h3NY2i1fN09l1jiKTkdi3DskX+xwH8a1JpPs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=az/tOXzF; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="az/tOXzF"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1768204341;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=NgEuKhSGeGp3rHLw9KcgRGMEtdPt06IF04FuEiLm+p0=;
	b=az/tOXzFMsbRr3QH+LQrr/IqWkeBpNKjZ0aeB+K31lLrSDDS3i03Z1agyFR4NNDCcHeXjM
	ZirBKg51UfA5sVwYro5MOhhVMJcE+sBPYY1Cd2RcCczmzFVYay5z58VHobLxcup9JosJ9t
	/pTFHOPKj5xxMzRLouSijSp1kH6Yj+I=
Received: from mail-yw1-f197.google.com (mail-yw1-f197.google.com
 [209.85.128.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-346-yOXMQGjHNpetEajujBPPUQ-1; Mon, 12 Jan 2026 02:52:20 -0500
X-MC-Unique: yOXMQGjHNpetEajujBPPUQ-1
X-Mimecast-MFC-AGG-ID: yOXMQGjHNpetEajujBPPUQ_1768204340
Received: by mail-yw1-f197.google.com with SMTP id 00721157ae682-7900ab6755fso94900557b3.0
        for <virtualization@lists.linux.dev>; Sun, 11 Jan 2026 23:52:20 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768204339; x=1768809139;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=NgEuKhSGeGp3rHLw9KcgRGMEtdPt06IF04FuEiLm+p0=;
        b=PaTieRdQsK/JWeNI1JXHnDUwoQiM1a8pe+4RYDczl6CpzSz2hC3Lnlj/Srzl9HJAGh
         PgovqrZJcgDuTsci/fz6H4ZydmvQw7uGeXhnSX6Xz6Dd5lBt/3j7/N/wr/r2dHPksj3H
         +ZP44ZI2939H/0YU9W7Hd1D5IL9KYohtW+wsT3yhYiMPY4OhG+QM/wCC7GZWfEEDinua
         9TJgtmrwekQZ+1t4AxEcP+PVIPnFDwlfF/IUlV+Jj9dR5JUXQ68WI1mXnps5upfsNbXA
         DFQq6WwybWCtNDhwF2+Hn/i3bgeNE/lU9dPJcRI+yssTbWNuyHCTDiuEGavR/Qlm1CrI
         +SlQ==
X-Forwarded-Encrypted: i=1; AJvYcCUAOf4sx9V2JqX7JCfCMFng0UWe3jb84f206hzYexeWdXKF5RXjtfUoaLyK3A0JMBWHpCQKbf5ZWOW91Zs1XQ==@lists.linux.dev
X-Gm-Message-State: AOJu0YxMGjakrzx6MiEfTp1cZHR7k48W87eC4egHmc9FY3lEkzHIV74F
	z89smzd726raW7tPNyZni9L6Ec2xYJi49J3frjVX56zAiQU8ICOgMpPn2W7K0AkKAiFpuWr/BRr
	Loj2hC3mB7/4tkbYxhPKqIjUkXpnfN+hZX0wb3uFbxoTMt+aS1QPN05eM5c6901IxD8f8hg8jaG
	JW/TUb/2MaGlIHhBxekHZRvT2577qi9SVRP2Gn+nJKbrKKlNngta54TQ==
X-Gm-Gg: AY/fxX40zfo6RlLLRga7Xg+NjWSzN8cB/tJKv8T3i99GrZY1P81e15UlaLghgeJJqc0
	UVYmYakGmA106DeEFANSa33j5uvZAuIw4oRmDJQZ/PkMmUHNnsu1EAud5LiKUVTQuAgxZV91lxo
	EmNazG9UJyfONqlvf3u9cprVrhPICswDWLM/ku40iiMgZNeajkncAQJx9YSXhoG4V1Ug==
X-Received: by 2002:a05:690e:4091:b0:63c:e979:128f with SMTP id 956f58d0204a3-64716b95191mr14745896d50.28.1768204339161;
        Sun, 11 Jan 2026 23:52:19 -0800 (PST)
X-Google-Smtp-Source: AGHT+IF1CnArPBmrhZABLL87z8Wnl4ZxcWbnNZp0sdpwxvURk7q0uHc54s0I8EgEZpYMLTlAhf8UVmB382VXDVERolk=
X-Received: by 2002:a05:690e:4091:b0:63c:e979:128f with SMTP id
 956f58d0204a3-64716b95191mr14745884d50.28.1768204338854; Sun, 11 Jan 2026
 23:52:18 -0800 (PST)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20260109152430.512923-1-eperezma@redhat.com> <20260109152430.512923-8-eperezma@redhat.com>
 <20260110184915-mutt-send-email-mst@kernel.org>
In-Reply-To: <20260110184915-mutt-send-email-mst@kernel.org>
From: Eugenio Perez Martin <eperezma@redhat.com>
Date: Mon, 12 Jan 2026 08:51:42 +0100
X-Gm-Features: AZwV_QgpYSjV3i2rQ_BHRzs6D6zVTb3ppfdtiDq9nvMquF5TlrC3ujLGh3dxoAo
Message-ID: <CAJaqyWcXRwX6P10ReW6Okr-OyUd2E4vhYOG_nj98e7TxY1_fug@mail.gmail.com>
Subject: Re: [PATCH v11 07/12] vduse: refactor vdpa_dev_add for goto err handling
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: linux-kernel@vger.kernel.org, virtualization@lists.linux.dev, 
	Maxime Coquelin <mcoqueli@redhat.com>, Laurent Vivier <lvivier@redhat.com>, Cindy Lu <lulu@redhat.com>, 
	jasowang@redhat.com, Xuan Zhuo <xuanzhuo@linux.alibaba.com>, 
	Stefano Garzarella <sgarzare@redhat.com>, Yongji Xie <xieyongji@bytedance.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: twUdS_OobeWmqUuRyoWag7FZ27U6hWCopHlvccZyRh0_1768204340
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Jan 11, 2026 at 12:49=E2=80=AFAM Michael S. Tsirkin <mst@redhat.com=
> wrote:
>
> On Fri, Jan 09, 2026 at 04:24:25PM +0100, Eugenio P=C3=A9rez wrote:
> > Next patches introduce more error paths in this function.  Refactor it
> > so they can be accomodated through gotos.
>
> accommodated
>

Fixing in the next version, thanks!

> >
> > Acked-by: Jason Wang <jasowang@redhat.com>
> > Reviewed-by: Xie Yongji <xieyongji@bytedance.com>
> > Signed-off-by: Eugenio P=C3=A9rez <eperezma@redhat.com>
> > ---
> > v6: New in v6.
> > ---
> >  drivers/vdpa/vdpa_user/vduse_dev.c | 22 ++++++++++++++--------
> >  1 file changed, 14 insertions(+), 8 deletions(-)
> >
> > diff --git a/drivers/vdpa/vdpa_user/vduse_dev.c b/drivers/vdpa/vdpa_use=
r/vduse_dev.c
> > index 0386434577b5..f7a45f396cf8 100644
> > --- a/drivers/vdpa/vdpa_user/vduse_dev.c
> > +++ b/drivers/vdpa/vdpa_user/vduse_dev.c
> > @@ -2171,21 +2171,27 @@ static int vdpa_dev_add(struct vdpa_mgmt_dev *m=
dev, const char *name,
> >                                                 dev->bounce_size);
> >       mutex_unlock(&dev->domain_lock);
> >       if (!dev->domain) {
> > -             put_device(&dev->vdev->vdpa.dev);
> > -             return -ENOMEM;
> > +             ret =3D -ENOMEM;
> > +             goto domain_err;
> >       }
> >
> >       ret =3D _vdpa_register_device(&dev->vdev->vdpa, dev->vq_num);
> >       if (ret) {
> > -             put_device(&dev->vdev->vdpa.dev);
> > -             mutex_lock(&dev->domain_lock);
> > -             vduse_domain_destroy(dev->domain);
> > -             dev->domain =3D NULL;
> > -             mutex_unlock(&dev->domain_lock);
> > -             return ret;
> > +             goto register_err;
> >       }
> >
> >       return 0;
> > +
> > +register_err:
> > +     mutex_lock(&dev->domain_lock);
> > +     vduse_domain_destroy(dev->domain);
> > +     dev->domain =3D NULL;
> > +     mutex_unlock(&dev->domain_lock);
> > +
> > +domain_err:
> > +     put_device(&dev->vdev->vdpa.dev);
> > +
> > +     return ret;
> >  }
> >
> >  static void vdpa_dev_del(struct vdpa_mgmt_dev *mdev, struct vdpa_devic=
e *dev)
> > --
> > 2.52.0
>

