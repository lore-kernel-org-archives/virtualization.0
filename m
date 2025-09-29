Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6540C27C150
	for <virtualization@lists.linux.dev>; Mon, 29 Sep 2025 08:53:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759136008; cv=none; b=CJeex5wNorHO5yoWOqav0yJUvnbLL/TcIjBVxmG9XyVX94dD411i3D/fl1tljCmOwq6dtO5F7yq9SwciFl6yOuIahWByLTnLQkjxsgij6Ifr/+z6YC7+UGSplwPQh08jMwPtp05rbtCperkB1PQ27dLHQhsnrD/56KXkNS2pPm4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759136008; c=relaxed/simple;
	bh=HGTbeMywhbLPU/0YJZUQd3UYalFRytSBWqDIdd4eL/c=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=F1+9KNRDFz+rp+k+9p9XyPqj0pZWk6P6+dPMsCHa9wpHfAVUnPYryRs+Vt76+rMW6VAG/pL+3/3Ho3t2O4nB/hyc4HHDpi1U0Hf+9EzVA2Lfk2/MM8yVK0+rDmROieswBXgOWziZ+v6jKMJX4OBLxxjlB2MFnYG8JLXLIdlwbXI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=P9JwBQ4j; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="P9JwBQ4j"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1759136005;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=egsBklLkwFUqVScoVF40Gy+uR3v3jO6xWI74ZIXf8ac=;
	b=P9JwBQ4jJXkn+bN/y9aofRcroWnpm0+5Z+4/L2XF54g1ORlizp0ZAcRRBLbYKVpMDb+4Uz
	13j5OcvcTmrVezs7MjqmuyMjZSC26dGIUuOdXKkPh0Qd4ofD8Sa1OIpHKlpFBvtCKToym9
	Q19xOfuJmdicJ2DYVovb/jAqN5MLjkk=
Received: from mail-yx1-f72.google.com (mail-yx1-f72.google.com
 [74.125.224.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-586-HvA86YyFMgSWqk-CZYUIqA-1; Mon, 29 Sep 2025 04:53:22 -0400
X-MC-Unique: HvA86YyFMgSWqk-CZYUIqA-1
X-Mimecast-MFC-AGG-ID: HvA86YyFMgSWqk-CZYUIqA_1759136001
Received: by mail-yx1-f72.google.com with SMTP id 956f58d0204a3-633b0b69560so5473666d50.3
        for <virtualization@lists.linux.dev>; Mon, 29 Sep 2025 01:53:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759136001; x=1759740801;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=egsBklLkwFUqVScoVF40Gy+uR3v3jO6xWI74ZIXf8ac=;
        b=RdElTLOd1tIkZTKmZ4K/hT+6Ic3OcqCLc4xjhimHD+UOB4/EiCXYxT1CLD+L9mkMyq
         ilXKeFjN4SQo8y1y4LcEjV4uvvIjOl7+mzNufqtWMUTBLYd0k3YxEu70Rtata7g1prLi
         h3TPriDSlGXyotibrgKZpWGWelRwGrHozpQmy0phDCe/sTzGV9uH6/bis60ZphNWs3nK
         ekKrczwzditxgVYCMGgvECMLtxGXPAwzI7GXjc7Whd3OyakG6i2oB0X7ExqABAb3zqtD
         fLCX4M4h+Cn+pbsX7UfLyy83fkar3Hn+tZK8QzGF6zEVgptHJ3kipmq9ngLNVwqOXL+y
         9czQ==
X-Forwarded-Encrypted: i=1; AJvYcCUuyPR2wxYmn6c/bEONAboobWcl8gGFa6cRHt8E/k46UUZTXynF2nmB2J8If4mDU3pjlzxrhI6oEDzO+JKzeQ==@lists.linux.dev
X-Gm-Message-State: AOJu0YwTHol0V5W4x/UTnkKSCFNUXMqw7/p7fuYj/OtjlKFcWk1+VY2J
	a+q75eukjEsH3j3BMc7M4k3Dkmwy4tYnWAdfYlr0/0HEHwkpFCBoMHrACse1NFMflfHFA4he0rA
	PN/f7GS6yg6G8eMP+QLsZWt1B1K42cS0Gh6arcm21Xn+vsEStOe9mFPgDhPZomjWlWJc2rB1kpM
	WvKW507L63IzIp4FETSKdq7AZCp5iVBRXyJzjRDhW3CgA=
X-Gm-Gg: ASbGncsgtbVMnpxMufH35XF0hS1EVBUQ/yngXlTq2t54WR1dWef8HjNl8vTLL3T1oUA
	IRUbT7nTKN/nH3LwQgsHzFWEgXcS+JphODBDwqlPhiofxxsb/ndqUKRFz3lGj7ZlBWrj+KuvaxT
	8wao7QjnZg1GsgcgqLa3mEt8AVnZ7WRsDn67RAwx4Wk/RLqXBRNyMn5Ax1swLlK4joDMKy9Lp6V
	Kz7ph4r
X-Received: by 2002:a05:690e:4195:b0:62c:eefb:dd79 with SMTP id 956f58d0204a3-6361a857ecdmr14524420d50.34.1759136001576;
        Mon, 29 Sep 2025 01:53:21 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IECrTqBudBkSeJ3N8SX/hVo0kjWu9UUTo1pONH+icCLFs7YdIq9GweSI0ieFvne7zbnLxqB/d/leEOjjasuYtI=
X-Received: by 2002:a05:690e:4195:b0:62c:eefb:dd79 with SMTP id
 956f58d0204a3-6361a857ecdmr14524395d50.34.1759136001255; Mon, 29 Sep 2025
 01:53:21 -0700 (PDT)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20250926101432.2251301-1-eperezma@redhat.com> <20250926101432.2251301-4-eperezma@redhat.com>
 <20250926112622-mutt-send-email-mst@kernel.org> <CAJaqyWdeA5xcozCsaYD3_bQ6riN1pdDGHLpMGjU7ejZmNZ4qig@mail.gmail.com>
 <20250929035510-mutt-send-email-mst@kernel.org>
In-Reply-To: <20250929035510-mutt-send-email-mst@kernel.org>
From: Eugenio Perez Martin <eperezma@redhat.com>
Date: Mon, 29 Sep 2025 10:52:45 +0200
X-Gm-Features: AS18NWDxfZ0r4W4VshBoL1ZD7Teu0Ou_adE4zYLCpMWTZRl0EHPUYTx5fV8Hib4
Message-ID: <CAJaqyWdQkJgUKqne0_ivLTpQ3rD9tfzcEZL26o5ZdcQsjrJL_g@mail.gmail.com>
Subject: Re: [PATCH v5 3/6] vduse: add vq group support
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Yongji Xie <xieyongji@bytedance.com>, linux-kernel@vger.kernel.org, 
	Maxime Coquelin <mcoqueli@redhat.com>, Stefano Garzarella <sgarzare@redhat.com>, 
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>, Cindy Lu <lulu@redhat.com>, 
	virtualization@lists.linux.dev, Laurent Vivier <lvivier@redhat.com>, jasowang@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: Ua_bLU5J5pIzjb-tnWBF9VYaPoJsukgmQEUoKrQhGgQ_1759136001
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 29, 2025 at 9:55=E2=80=AFAM Michael S. Tsirkin <mst@redhat.com>=
 wrote:
>
> On Mon, Sep 29, 2025 at 07:55:59AM +0200, Eugenio Perez Martin wrote:
> > On Fri, Sep 26, 2025 at 5:27=E2=80=AFPM Michael S. Tsirkin <mst@redhat.=
com> wrote:
> > >
> > > On Fri, Sep 26, 2025 at 12:14:29PM +0200, Eugenio P=C3=A9rez wrote:
> > > > @@ -1859,6 +1894,7 @@ static int vduse_create_dev(struct vduse_dev_=
config *config,
> > > >       dev->device_features =3D config->features;
> > > >       dev->device_id =3D config->device_id;
> > > >       dev->vendor_id =3D config->vendor_id;
> > > > +     dev->ngroups =3D (dev->api_version < 1) ? 1 : config->ngroups=
;
> > >
> > > Is this < 1 same as VDUSE_API_VERSION_1? If so, maybe use that?
> > >
> >
> > The macro for v0 is called VDUSE_API_VERSION, so I think it is less
> > intuitive to put:
> > dev->api_version =3D=3D VDUSE_API_VERSION
> >
> > But I'm ok with the change if you want.
>
> Confused. You mean "more intuitive"?
>

Ok think I misread your comment,

I find

(dev->api_version < 1) ? ...

more intuitive than

(dev->api_version =3D=3D VDUSE_API_VERSION) ? ...

But now I think you meant

(dev->api_version < VDUSE_API_VERSION_1) ? ...

Is that right?

