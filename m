Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B37C235044
	for <virtualization@lists.linux.dev>; Mon, 29 Sep 2025 05:56:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759125401; cv=none; b=tN84qwN7l0xUpTZuGgHUhVFPemk+yNcvb4w/o/ZOIzzJYYpxXMGLhdpGLEjhWxtnS/9BrJiuXWAtucWBKEt6n5f1IuyJQ8SKQg/8Egw9dTEfIb86jG26fP3hnUloz9QORfs6IJ48OJpPwrd1u/yraDIQss9O1H6lglOyLvexiQg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759125401; c=relaxed/simple;
	bh=zpocdXavVfR+aMzlsPOUcuVPsuuREVmAQpjJgXChKkM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=NU6Cmh0gAxJwCtzVnqXdwgQP6Xhr82WFBEJ+pQTI+j8z5V0qhRKl8Brfvf3l16zZd/GJbQpf5kjEJM52y06jw7j1jUjrvLGALWZFEdnagMuwPJ4O6yv4tdnlfjgPGWWl5Sma+h7GDkuepgQvTUwGW8Jpgsyx5n/gmOLoz/dXO3s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=K8TR5bER; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="K8TR5bER"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1759125399;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ANzcVudJsRJsJHYIVg57mz9xwpvI9IEJG4CYfjHF1lE=;
	b=K8TR5bERqtSm3caqbTexg/RM3aO1+57fT0h8+lGVGJIXZFalTUBz5WGVQdT/yNG5ESElVB
	lhjVvM6J8zAIDPwmgHtQaZ+s4URAnGyZy2kMA+Xah7ldXwO6r3z2TC+UaqDAxMt1koPlwd
	t2vQ7QjDIRfCkqsOWPrORIFKdXbWP84=
Received: from mail-yx1-f71.google.com (mail-yx1-f71.google.com
 [74.125.224.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-265-kaIhNC1fOlysn8JH2IMHjQ-1; Mon, 29 Sep 2025 01:56:36 -0400
X-MC-Unique: kaIhNC1fOlysn8JH2IMHjQ-1
X-Mimecast-MFC-AGG-ID: kaIhNC1fOlysn8JH2IMHjQ_1759125395
Received: by mail-yx1-f71.google.com with SMTP id 956f58d0204a3-633afc46d21so4090475d50.2
        for <virtualization@lists.linux.dev>; Sun, 28 Sep 2025 22:56:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759125395; x=1759730195;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ANzcVudJsRJsJHYIVg57mz9xwpvI9IEJG4CYfjHF1lE=;
        b=HfQ4Y88IdmjP2NAfJqKCdSMRD3Bu1iZa8S3aPMGYgOG5DpFg2F9YmHWqcT4HWqvN2/
         jA83ajTv96sAnmLZE0uvKPaqTh9vP5K3m9dIjsScAWUzPj3xNnZVtaSbnF/9esbcbctr
         X3Vw8jdiFwJenJ96qK5lT+cx/nEsv7zEmpNkVl6DNXCphq9KLIngbF9FJoLLLMpUrt2u
         r/KG3AZJvEiiF9xFQdYQlrumsgEsmDfnQL1rlRIYm53rwrtUSdDFGhwHnq3QFLK5LUBi
         4Wgd+WkA8gIK9/ytVY1agiHym54BOZiBSiRJy3qvgMc2ln8r50OBlT35v5NxMIL5oQO5
         Fj2Q==
X-Forwarded-Encrypted: i=1; AJvYcCXq930zEFp6h459pzc5+aJyC2NWXETuxo5xwrYyM2L9mnfoPiwzEegYi3DIEUAqqLETFO7QvYG8NccRjkAPSQ==@lists.linux.dev
X-Gm-Message-State: AOJu0YzWYQr1alvIeCktuOG08GAKZ2Uec2XeWOaNkdp1PNRmVVMjZoOb
	TBYE+zj697Z1svg+qw3e8JY6bmSHmRhSvHKcS+gCloPaZpYKs2oZLHuUdkld181dV5/Yeg4jF2S
	P7nSLzXcPmu8zahxQktKIk4cAxZ/hQPn/hJBGiu9n83Opyd3Pen2dxbc3gsl2LqoFJ1f62WPovf
	TPbk1tRBXKCTenEtuPuXH1LKOaC6YDgQD2k+pCBe1Y9vI=
X-Gm-Gg: ASbGnctvrhETtttOd8Z14WM8e4ttx7L6dqvgMepow2DcrUzjPPsylDpK51gAH1j6DoV
	t2EGWeYe7Vz8GaNPz0uZWPt5rfXS/6Fe6y1HxSCs2TCnwdPK61pgIumaQRI2dd9ZWbNFJbW/c1l
	afEWzf1n3gBBA4OuXJH+QMWbVGwfP92XxzP0OvAXTol88SRPr/HITMUUYzRoH1VNX9oe+ILnCIg
	IqStq3T
X-Received: by 2002:a53:b683:0:b0:636:20ad:c5ee with SMTP id 956f58d0204a3-63620adcb54mr11682904d50.45.1759125395438;
        Sun, 28 Sep 2025 22:56:35 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHN50MljOY+KYOVQXd2mn24itIiwLNxRriRok/MZeIPwApNSNZ81ZniT/NhybA0+aNlDiqYSHm3ZIQzo5ZhBxk=
X-Received: by 2002:a53:b683:0:b0:636:20ad:c5ee with SMTP id
 956f58d0204a3-63620adcb54mr11682895d50.45.1759125395168; Sun, 28 Sep 2025
 22:56:35 -0700 (PDT)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20250926101432.2251301-1-eperezma@redhat.com> <20250926101432.2251301-4-eperezma@redhat.com>
 <20250926112622-mutt-send-email-mst@kernel.org>
In-Reply-To: <20250926112622-mutt-send-email-mst@kernel.org>
From: Eugenio Perez Martin <eperezma@redhat.com>
Date: Mon, 29 Sep 2025 07:55:59 +0200
X-Gm-Features: AS18NWAY5gSDO5oKUGoKwaX6DGDqLTOLChD4mCWZ1AlPb7n0MS7kxnl-SzjZYmU
Message-ID: <CAJaqyWdeA5xcozCsaYD3_bQ6riN1pdDGHLpMGjU7ejZmNZ4qig@mail.gmail.com>
Subject: Re: [PATCH v5 3/6] vduse: add vq group support
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Yongji Xie <xieyongji@bytedance.com>, linux-kernel@vger.kernel.org, 
	Maxime Coquelin <mcoqueli@redhat.com>, Stefano Garzarella <sgarzare@redhat.com>, 
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>, Cindy Lu <lulu@redhat.com>, 
	virtualization@lists.linux.dev, Laurent Vivier <lvivier@redhat.com>, jasowang@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: MPkaMtoujbiz3iMofpqcenkQxSq_12LmPfMw9s0CKBE_1759125395
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Sep 26, 2025 at 5:27=E2=80=AFPM Michael S. Tsirkin <mst@redhat.com>=
 wrote:
>
> On Fri, Sep 26, 2025 at 12:14:29PM +0200, Eugenio P=C3=A9rez wrote:
> > @@ -1859,6 +1894,7 @@ static int vduse_create_dev(struct vduse_dev_conf=
ig *config,
> >       dev->device_features =3D config->features;
> >       dev->device_id =3D config->device_id;
> >       dev->vendor_id =3D config->vendor_id;
> > +     dev->ngroups =3D (dev->api_version < 1) ? 1 : config->ngroups;
>
> Is this < 1 same as VDUSE_API_VERSION_1? If so, maybe use that?
>

The macro for v0 is called VDUSE_API_VERSION, so I think it is less
intuitive to put:
dev->api_version =3D=3D VDUSE_API_VERSION

But I'm ok with the change if you want.

