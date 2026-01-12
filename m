Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5450B2652B0
	for <virtualization@lists.linux.dev>; Mon, 12 Jan 2026 07:36:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768203378; cv=none; b=HG8PP6/v0nk1MasmmxUYC6IJl3dhESwzY81geNwryP/BdDkGofAXVAQrSR6xYV4SWGHp2EepBVcyDCMYhVYDzlRJE01PianKlNs0bk2k7IfbF/np5QYHdQKMU3KHSrcZoC9nbfRRkhrfGpEl26tg0c0Zwog0s1LWF9JbYZe1nOQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768203378; c=relaxed/simple;
	bh=P3fhl3duUTlwoUuBW5BKJ4N2ychOrHp4pEeew2brkok=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=FkVWpCWir4a2x8SEsynu8Xi6L9oGmW82dPYAXhXIyTynjReXJriFtxLRkmrlaFftt4TGecZC6hDsFifeS5l2GbSftegKZpX8a9WW6TStDiVbxgmRfWOAyirgDWdTnRDjxey1KgLnsYvajVcFxzzDMyDIaUrCt6l/YavjEhNZyeg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=JEhSmme7; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="JEhSmme7"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1768203376;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Tfrx1JLYd90UDgArQKMHcVYylhgv7dsuCqBLEe1O5b4=;
	b=JEhSmme7iRbMKdQUa79kj15ZgpBr1+yl0Y0n09x/k48uDiYY+T/rmCqvSqNuIkLbYKTJcZ
	vwC39ObjUn3Sxh3bthOiM98lZkEV/+GsGiyCW3OQrfowSH11oFolenekquEtIQ1HL2lg0j
	lUckKZ+k6Q2kkLowaHvU1Xp5hdgQFBw=
Received: from mail-yw1-f200.google.com (mail-yw1-f200.google.com
 [209.85.128.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-619-3OP1b1f-PaCQnP7TNHc8sA-1; Mon, 12 Jan 2026 02:36:14 -0500
X-MC-Unique: 3OP1b1f-PaCQnP7TNHc8sA-1
X-Mimecast-MFC-AGG-ID: 3OP1b1f-PaCQnP7TNHc8sA_1768203374
Received: by mail-yw1-f200.google.com with SMTP id 00721157ae682-79043e14dfdso79707357b3.0
        for <virtualization@lists.linux.dev>; Sun, 11 Jan 2026 23:36:14 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768203374; x=1768808174;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Tfrx1JLYd90UDgArQKMHcVYylhgv7dsuCqBLEe1O5b4=;
        b=VpFtszYwPkx7TCABatpYvwh1JL00ZUPd1XLXxVi3fHH6WyuZgCb1eflwNxeN7HFUzK
         cH0iQBvKSq0SKe14DM82s7iz8RBLQlqmgQlJJWmr0+tAr2er5sgbndJJ3Tgfp6QEZtP5
         07crg9905LlTzwGj2MQDwbzNbrGHAf5ST52LP10iWKcPM6Bpa/QRlEAiDcfvGYEH1A2D
         G4nqF0BVRwAqufy0cVL2n3dBO/NN4M8f2bexyVvfpUA0GiEZHWzo/VEHeb5GQv3pDknU
         mmgG4C+HCg4yznRMkmo0U/Bz/o/GzkTUt271GWY1kZkW4d30kW48bW8qaL91aD/MJb/J
         veLA==
X-Forwarded-Encrypted: i=1; AJvYcCXSGJkcm1eCrlwDr/ckxHTBv0yQrrnqYK3u3xXpqAj522MZ71lz6qsaREU+5Vv8UEVR0YAxKACjiBCrjCovGg==@lists.linux.dev
X-Gm-Message-State: AOJu0YzqiRwFIlw5wwwd48fVlP45Y/B0Ztf0HcpW+9yLaA38vDFt3f8g
	IDz4CApDX1h8n8Rr1UGwbQd/9kPJW+Jtp1lwTLiuWUYAuUjigjIRvuc1uk2RDlv0Z8Np9eC+G+S
	EwqzYJ8Wp4ta6AB5bDs4h4C47RnKwtGmNUwFJxRs2wGdhwQDSG5L/irwGRW3qgXZ+HgBUo3D0YO
	immBdgI1ArPXI11wnC6IEXsTjn67TfCcF5J5KH1h/4hDM=
X-Gm-Gg: AY/fxX5gdO6001RzR/EvBTSs85JTKus0x+9E7xr82cCIhaeUs60NPfSoWL89rL0/5bG
	OP6qyqkMnWL7dKcP5sksW5Hwie7tcMoBfjDaMpTX00kg2MZ/CPOVk3btXJX1KWMKKSnXbCMwYZ+
	AVvdjYAiYBy7rY4v/mwxpTt0RcPRalODkechK4eO7YCmW8S3WtfyqrNVdUXuWegwkaww==
X-Received: by 2002:a05:690e:14c3:b0:644:7a72:a506 with SMTP id 956f58d0204a3-64716c5119fmr11614114d50.94.1768203374288;
        Sun, 11 Jan 2026 23:36:14 -0800 (PST)
X-Google-Smtp-Source: AGHT+IESZ0iYFITSzOEoTEA/B/WGky4/Uv/pjUTtSkwpbS/XsvelDZluc/DmI9/byNPSj5nYUXxU7An03g8ATHTfm5o=
X-Received: by 2002:a05:690e:14c3:b0:644:7a72:a506 with SMTP id
 956f58d0204a3-64716c5119fmr11614105d50.94.1768203374007; Sun, 11 Jan 2026
 23:36:14 -0800 (PST)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20260109152430.512923-1-eperezma@redhat.com> <20260109152430.512923-3-eperezma@redhat.com>
 <20260110183910-mutt-send-email-mst@kernel.org>
In-Reply-To: <20260110183910-mutt-send-email-mst@kernel.org>
From: Eugenio Perez Martin <eperezma@redhat.com>
Date: Mon, 12 Jan 2026 08:35:37 +0100
X-Gm-Features: AZwV_QhZIGedfgT7_Q18ENLPff3N2bp7xGQPUCBvS4IkuDXoOB-Yyo5k0gO7MgI
Message-ID: <CAJaqyWd4VZaqA3E0NCeCH6ur1q7stu1HgHTKEv5hjRQ=eLn+uA@mail.gmail.com>
Subject: Re: [PATCH v11 02/12] vduse: add vq group support
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: linux-kernel@vger.kernel.org, virtualization@lists.linux.dev, 
	Maxime Coquelin <mcoqueli@redhat.com>, Laurent Vivier <lvivier@redhat.com>, Cindy Lu <lulu@redhat.com>, 
	jasowang@redhat.com, Xuan Zhuo <xuanzhuo@linux.alibaba.com>, 
	Stefano Garzarella <sgarzare@redhat.com>, Yongji Xie <xieyongji@bytedance.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: 7tw5OWjsJ12jbceot8Da_KfQ9MnAJgC26-B-ZuCFN1A_1768203374
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Jan 11, 2026 at 12:44=E2=80=AFAM Michael S. Tsirkin <mst@redhat.com=
> wrote:
>
> On Fri, Jan 09, 2026 at 04:24:20PM +0100, Eugenio P=C3=A9rez wrote:
> > @@ -1252,12 +1266,24 @@ static long vduse_dev_ioctl(struct file *file, =
unsigned int cmd,
> >               if (config.index >=3D dev->vq_num)
> >                       break;
> >
> > -             if (!is_mem_zero((const char *)config.reserved,
> > -                              sizeof(config.reserved)))
> > +             if (dev->api_version < VDUSE_API_VERSION_1 && config.grou=
p)
> > +                     break;

(Bookmarking the piece of code above as [1] to reference later)

> > +
> > +             if (dev->api_version >=3D VDUSE_API_VERSION_1) {
> > +                     if (config.group >=3D dev->ngroups)
> > +                             break;
> > +                     if (dev->status & VIRTIO_CONFIG_S_DRIVER_OK)
> > +                             break;
> > +             }
> > +
> > +             if (config.reserved1 ||
> > +                 !is_mem_zero((const char *)config.reserved2,
> > +                              sizeof(config.reserved2)))
>
> Hmm but if api version is 0 then group should be 0 no?
> We should validate.
>

The check (dev->api_version < VDUSE_API_VERSION_1 && config.group) is
above this check in this set of changes [1], am I missing something?
Would you prefer it to be reordered here or written differently?

