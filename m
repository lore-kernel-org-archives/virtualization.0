Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C879C30F526
	for <virtualization@lists.linux.dev>; Tue, 14 Oct 2025 07:30:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760427055; cv=none; b=kJ2o1sizdKyTLVA/qjUJVqtKzmZLA0y7s2hfa8ubpww8auSyc6bqiDPduS1ltvFJU+d41e6p0zHvCK/tFFzY/DUvZg6x54rNfYEavzFfsXcJXq7Wd7d5NfMGnDsECqNXkFs7ddP22zNWBE81n/F/HUgjr12zAjfTYoNbmKLHxtw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760427055; c=relaxed/simple;
	bh=Wocm0VB/Jzd8XJphp1xueqg11SgR1DOsJ91gXwSvemo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=KFNTFt9npcugZk718RTbIj40G70qq+qVVBR4J50yMzfm5MKFHS9YwF/JtTn9YohR4O6RobULbswLwQgKQFUejsvue/Et1ojmV00v1zxYb02t1bsAMQCbjzQJbJFV5mQQlEVC++UhPPaX7CFwJSGUr0ByWvxhaxQ54VoiGatF01M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=IexS1wBt; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="IexS1wBt"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1760427043;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=SjPM0Dek3XJBMiI43E2t7Sst/xVZxIkoO+1LC4iV+eI=;
	b=IexS1wBt46MLGkrUD8qN0RQ91vf6r+oW22TNgn9/Auf/hdJR/DYOIQlkMbg3utzxFdLvV+
	xZV54K19fYaq1rWLGjxuFd9DuKJtxVy5TP4XSgPAoh0iaaMP1hZhtffRa91GivgiBKLUB9
	DVjtUFSUd6HbIQ3IYqXz5fZ0uABhKUE=
Received: from mail-yw1-f200.google.com (mail-yw1-f200.google.com
 [209.85.128.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-395-wG7063FmMHKIxhNuyUfyZQ-1; Tue, 14 Oct 2025 03:30:41 -0400
X-MC-Unique: wG7063FmMHKIxhNuyUfyZQ-1
X-Mimecast-MFC-AGG-ID: wG7063FmMHKIxhNuyUfyZQ_1760427041
Received: by mail-yw1-f200.google.com with SMTP id 00721157ae682-74983d5be0bso183045857b3.0
        for <virtualization@lists.linux.dev>; Tue, 14 Oct 2025 00:30:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760427041; x=1761031841;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SjPM0Dek3XJBMiI43E2t7Sst/xVZxIkoO+1LC4iV+eI=;
        b=PMEp5PG886R8n+1WMjyUCEFk9sMzcAYbF7lOlAcVz7nmzE0jaVyC+sz6MpfMy4Zcb/
         TfPflydlBlN6d3ARP8AoYuU51HI0zsZS8SOmjgBxa4pIet1UyCM8WJwHHCArYm8Sy88b
         PmHF1r5tAbtW59YwuQmrdEsvoxfYV65OzZvnR+IZrKT06CISCJhhU5nwcNEYD0atPm0b
         AA0ElKiHIipTVZknRkpuIpzzxRuLa6InYkGCGumcEUwd3gBXPFhFQ+Yzpx7+il30ckD7
         C5YfrEgeJMkv+opi8R6c/u9528J0YtlV4hLLB3U4zi29tRwwWC6yhmcLE+FkzK/UShTs
         JGjQ==
X-Forwarded-Encrypted: i=1; AJvYcCWIP9TXlrsDP+sBTm+QNwuQ+IbIVK3dt9rw2FafL91VFIBJi0PRXJ9AybdPMG8duCARf0MQuxFLbNPIkZiuGA==@lists.linux.dev
X-Gm-Message-State: AOJu0YwE5U1UKqB0iN9jEJ5I22fRhu0GNK3vRkjQBnqE9lzBzGL3euXR
	vgMypZREKBSZOm8X90d4CeGLQ+Rj4+8EYAKeCQ/qfCxavvGgGxAhrtgz5yy6C6H5RqmaX/mUExe
	BYQ4h8KpBnSKSI1H6iGd3EDRy9OuAe1EHddI1t9jHN92eJtipe7gjW2cUAZgS+RX9jJ5+CKKiHC
	jWAZ1lQ8o1aZ0Vzx4HRHZRM7OmIAGXdgExfR9Ivqb+mp0=
X-Gm-Gg: ASbGnctHFAvMDg0CkZNl9XsBnT1OOAPZqUD39TvO+EclYu1M/hoszEXrjh+BerItY2O
	qFpyhUwO1zD+2CZHXKH94VUKxnHheopnOfFsvu7SSzwxhxeqGLxNrihTFASWKQmw/U6uA6rZhhK
	Jzl9YmQNsd1MPx1NY/D5kbbXSFQmXeztPco8xakYoerhCBaC/qoAV2YpfIymuZtcsNCJ0yNda5+
	teSWkG4
X-Received: by 2002:a53:acc8:0:10b0:63c:f5a6:f30b with SMTP id 956f58d0204a3-63cf5a707a8mr8150383d50.34.1760427041192;
        Tue, 14 Oct 2025 00:30:41 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGTGjvgm+q6Xi/4Sr+8n6vmI+h9vBKa+gJNc7gSb1sSY2AxAj8OLoP2ljZtRHahMX8MdJUTrHqa5gno2mIxl8U=
X-Received: by 2002:a53:acc8:0:10b0:63c:f5a6:f30b with SMTP id
 956f58d0204a3-63cf5a707a8mr8150373d50.34.1760427040882; Tue, 14 Oct 2025
 00:30:40 -0700 (PDT)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20251007130622.144762-1-eperezma@redhat.com> <20251007130622.144762-2-eperezma@redhat.com>
 <CACGkMEvJwcTFmDTXyXvMM1dP0OginF-FKZsksFO1DamRQJP1TQ@mail.gmail.com>
In-Reply-To: <CACGkMEvJwcTFmDTXyXvMM1dP0OginF-FKZsksFO1DamRQJP1TQ@mail.gmail.com>
From: Eugenio Perez Martin <eperezma@redhat.com>
Date: Tue, 14 Oct 2025 09:30:04 +0200
X-Gm-Features: AS18NWBM7CJVO_99VdUET8T7W_kxp8s61iA763QHZRqN906DJB2ICmMi_MvpUFI
Message-ID: <CAJaqyWeuMvkj2HzCrph+h-rjYdTMQJRcAvHzryKt6iUhd4sEsQ@mail.gmail.com>
Subject: Re: [RFC 1/2] virtio_net: timeout control virtqueue commands
To: Jason Wang <jasowang@redhat.com>
Cc: mst@redhat.com, Yongji Xie <xieyongji@bytedance.com>, virtualization@lists.linux.dev, 
	linux-kernel@vger.kernel.org, Maxime Coquelin <mcoqueli@redhat.com>, 
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>, Dragos Tatulea DE <dtatulea@nvidia.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: MLUSCHQB2K10Iu_-Yu8YSy6OkBOSBR5D4Pxv69jGuTo_1760427041
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Oct 11, 2025 at 9:45=E2=80=AFAM Jason Wang <jasowang@redhat.com> wr=
ote:
>
> On Tue, Oct 7, 2025 at 9:06=E2=80=AFPM Eugenio P=C3=A9rez <eperezma@redha=
t.com> wrote:
> >
> > An userland device implemented through VDUSE could take rtnl forever if
> > the virtio-net driver is running on top of virtio_vdpa.  Let's break th=
e
> > device if it does not return the buffer in a longer-than-assumible
> > timeout.
> >
> > A less agressive path can be taken to recover the device, like only
> > resetting the control virtqueue.  However, the state of the device afte=
r
> > this action is taken races, as the vq could be reset after the device
> > writes the OK.  Leaving TODO anyway.
> >
> > Signed-off-by: Eugenio P=C3=A9rez <eperezma@redhat.com>
> > ---
> >  drivers/net/virtio_net.c | 10 ++++++++++
> >  1 file changed, 10 insertions(+)
> >
> > diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
> > index 31bd32bdecaf..ed68ad69a019 100644
> > --- a/drivers/net/virtio_net.c
> > +++ b/drivers/net/virtio_net.c
> > @@ -3576,6 +3576,7 @@ static bool virtnet_send_command_reply(struct vir=
tnet_info *vi, u8 class, u8 cmd
> >  {
> >         struct scatterlist *sgs[5], hdr, stat;
> >         u32 out_num =3D 0, tmp, in_num =3D 0;
> > +       unsigned long end_time;
> >         bool ok;
> >         int ret;
> >
> > @@ -3614,11 +3615,20 @@ static bool virtnet_send_command_reply(struct v=
irtnet_info *vi, u8 class, u8 cmd
> >
> >         /* Spin for a response, the kick causes an ioport write, trappi=
ng
> >          * into the hypervisor, so the request should be handled immedi=
ately.
> > +        *
> > +        * Long timeout so a malicious device is not able to lock rtnl =
forever.
> >          */
> > +       end_time =3D jiffies + 30 * HZ;
>
> The problem that 30 * HZ is probably long enough to trigger the
> warnings like hungtask?
>

That's right. OTOH, the same behavior from the device already triggers
the hungtask.

Maybe it is better to set it to 15*HZ?

