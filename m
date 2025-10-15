Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA54F13C8EA
	for <virtualization@lists.linux.dev>; Wed, 15 Oct 2025 06:12:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760508748; cv=none; b=hb0uGpUVwTfoW359aSs0YND7jejkvcLt4PeZgpo2GlnfLOjLLx96kjRHHVKcu77x/8HYEMGlkp/B4M+5lNJFQ33BrHUu2VGSlK0CE+7OxZpBxTdSbEujMTYyqpGi30QNDqaAMxV2M5fjpHuwd2qF2LK+hPzFAQLIA6rA3Fpxw08=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760508748; c=relaxed/simple;
	bh=E3ttJaoWr10hbvMORpgAmH+UGObyk6Xevsx9d1orwX0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Xx0/1jm5GTQ5r/kUgQtNuFgAHQ1Mgwj6J5fDRlOJVPWP7im2Lgyggn2swgIDOmztoLB5OUra8Is2M7D9jE4MyNJTFyG75u4GFvxBPdlUt1UYqJC1E7yHjBf60p8htLvFd17RSmiFFzXOVusTP+pImRdL/aXWG/XxaISa0U8sOxM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=G+KyaM4u; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="G+KyaM4u"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1760508745;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=6YbSeYTX/WGQrtwXjKBhc9j5Uhg7SyOk2r5UKtuFwZI=;
	b=G+KyaM4uMLZ9eWF6ulRE0s5CaHA/24OSjsWylKYxCh1Gl/Qr3/nzc9GlG7wdj7U3u4uAw3
	oJjkwZcgr8t4I298gA0u+CSPPm4WiX/In3i2yqommOEDten+yldQPAW7ulkTHxpNx25/Q4
	eUy4k1VUvJ3smVhBGu4UGS6lLauSGjA=
Received: from mail-yx1-f69.google.com (mail-yx1-f69.google.com
 [74.125.224.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-543-TBcjWSGtOSqU50FXk-WcsA-1; Wed, 15 Oct 2025 02:12:23 -0400
X-MC-Unique: TBcjWSGtOSqU50FXk-WcsA-1
X-Mimecast-MFC-AGG-ID: TBcjWSGtOSqU50FXk-WcsA_1760508743
Received: by mail-yx1-f69.google.com with SMTP id 956f58d0204a3-63917818a4cso10575201d50.1
        for <virtualization@lists.linux.dev>; Tue, 14 Oct 2025 23:12:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760508743; x=1761113543;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6YbSeYTX/WGQrtwXjKBhc9j5Uhg7SyOk2r5UKtuFwZI=;
        b=K2GLzFo1xoySHHCDo9jsFB4/NlWN3M4FGOXHaqteEIOJ1PXFgpo8JVSzJfMe7LIAzb
         Nw8Rc7C9dNJ2F7jOli1nfjfGYhrdhvNrx8O3jGwxOn79DJ4bi6VsvchVaIg/PzM1kbbR
         XGiwYg+8KYaUeAEpGT6HPWvTHERdiURvHfrLDNdGTKHfNBeLe/3JytYqKpKNDMcKRT/O
         W8bGYOvQFsl0jYOhqOxCgQrI4Cr81hBCDdcbqzcWT8ZBScSCxOU6bJZjpwmkfbKx2WYy
         MXVJxdra1h4Q4KfIKXmJ+nonTs169v01XZNiYGlcOVSBy6nRPlC3zCEjpdZy7U5RYKOh
         BcZw==
X-Forwarded-Encrypted: i=1; AJvYcCWZV3f2YoNCHY9+ciOoOKHZ746Uj2xyu0hdd6+tbdWjhEhaujro9a/F6BaLdEcaYwXnVo09ZAJ7ziRSMvaT/A==@lists.linux.dev
X-Gm-Message-State: AOJu0YxEEiXtS6NGkQ5s9/2L46YfQlgNnk7in9hkNFoVOHMJc+iLJWv2
	BsGdhUsu17klaVRaGbZ5g5mCajBNron+gSmmbBx/EhQ08rILeGiDMBtxtLzz0ExbxJZdKTTLBZ2
	vQbuGo9f2kuOe0z+Y1GW800axfRYSW+X+bFJcYISrSRA8nbeQWLb6rHRJl+sYX4rZgPMJ2Qoy7k
	tCPW/MDzSjxUMJGKnWIGp3qRG6XSDEwpfGvpjqEc9dCJg=
X-Gm-Gg: ASbGncvANwD+rSQ6nM4TfNuVLxHd89ZUkuZbl+/wUNYBrJkeknZCEHBPD951n+yvWX9
	i8uZ9kYh0BCTkHoexOorKqPnBJirkmFXGIpcYEtUMDkfFpHiujpJPXGtzLwdUrw+Fryfsm/K+YM
	20tfv9DuVagl7NciTsw5QTc2OSC1T9zZAwAzKIBqZgGAMnkfC8cPE05KZ0CpALR0pvzEb9GoBxt
	TQRdxIh
X-Received: by 2002:a05:690c:ec6:b0:781:4f52:689 with SMTP id 00721157ae682-7814f52091dmr62574747b3.28.1760508743063;
        Tue, 14 Oct 2025 23:12:23 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFRmJzZcs83Hg+QFcKcR42fvSejXtYFLhLyNplvkHa18O02cU1cY2e2GzVXE5sAQFJt254pbMbi9RkTY97W90U=
X-Received: by 2002:a05:690c:ec6:b0:781:4f52:689 with SMTP id
 00721157ae682-7814f52091dmr62574397b3.28.1760508742687; Tue, 14 Oct 2025
 23:12:22 -0700 (PDT)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20251007130622.144762-1-eperezma@redhat.com> <20251007130622.144762-3-eperezma@redhat.com>
 <2a7f72cd-4418-4a15-bf68-caa157875d64@redhat.com>
In-Reply-To: <2a7f72cd-4418-4a15-bf68-caa157875d64@redhat.com>
From: Eugenio Perez Martin <eperezma@redhat.com>
Date: Wed, 15 Oct 2025 08:11:46 +0200
X-Gm-Features: AS18NWA8oOnJQp3hdQA53RVHRuVVkPS5qu8s79-5EbVj0VD7-8ScBJDT6vuj6V8
Message-ID: <CAJaqyWedjRz80ghQzPS+T_Et6EPWub_VB4M8xG1HKY81h4PqGg@mail.gmail.com>
Subject: Re: [RFC 2/2] vduse: lift restriction about net devices with CVQ
To: Maxime Coquelin <maxime.coquelin@redhat.com>
Cc: mst@redhat.com, Yongji Xie <xieyongji@bytedance.com>, virtualization@lists.linux.dev, 
	linux-kernel@vger.kernel.org, Maxime Coquelin <mcoqueli@redhat.com>, 
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>, Dragos Tatulea DE <dtatulea@nvidia.com>, jasowang@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: Uy2YgRy5UlgmXcHwoH7geGryYdbOIQ3PemQB8l_pgBA_1760508743
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 9, 2025 at 3:15=E2=80=AFPM Maxime Coquelin
<maxime.coquelin@redhat.com> wrote:
>
>
>
> On 10/7/25 3:06 PM, Eugenio P=C3=A9rez wrote:
> > Now that the virtio_net driver is able to recover from a stall
> > virtqueue, let's lift the restriction.
> >
> > Signed-off-by: Eugenio P=C3=A9rez <eperezma@redhat.com>
> > ---
> >   drivers/vdpa/vdpa_user/vduse_dev.c | 3 ---
> >   1 file changed, 3 deletions(-)
> >
> > diff --git a/drivers/vdpa/vdpa_user/vduse_dev.c b/drivers/vdpa/vdpa_use=
r/vduse_dev.c
> > index e7bced0b5542..95d2b898171d 100644
> > --- a/drivers/vdpa/vdpa_user/vduse_dev.c
> > +++ b/drivers/vdpa/vdpa_user/vduse_dev.c
> > @@ -1726,9 +1726,6 @@ static bool features_is_valid(struct vduse_dev_co=
nfig *config)
> >       if ((config->device_id =3D=3D VIRTIO_ID_BLOCK) &&
> >                       (config->features & BIT_ULL(VIRTIO_BLK_F_CONFIG_W=
CE)))
> >               return false;
> > -     else if ((config->device_id =3D=3D VIRTIO_ID_NET) &&
> > -                     (config->features & BIT_ULL(VIRTIO_NET_F_CTRL_VQ)=
))
> > -             return false;
> >
> >       if ((config->device_id =3D=3D VIRTIO_ID_NET) &&
> >                       !(config->features & BIT_ULL(VIRTIO_F_VERSION_1))=
)
>
> I wonder whether the API version should be increased, otherwise I don't
> see how the app creating the VDUSE device knows whether it can safely
> advertises the CVQ support (except without doing trial and error).
>

Ok good point! I'll do it in the next version.

