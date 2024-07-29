Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E7892770E
	for <virtualization@lists.linux.dev>; Mon, 29 Jul 2024 02:06:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722218815; cv=none; b=kONb2vLpiDo1mpeVr9F4RqnR9A39E3IJBP31y96A2uCLObLVtviHUs4dZou+oykA6cgoitc07l/W+H1qKqttpgwbeM+lsam14nVyI3t5zgBfMQWdfWAQ+bIUMNuzb2ft9+RA7yC7Se6BWvOiTKwFuB3AeCq7VZtWuf6DscW6HO8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722218815; c=relaxed/simple;
	bh=gDT/ykWLjSKq64w0/H9JwZcZsOjMPi3uy4g3RxYW0+8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=RCrk+L2wF8Yy53/N7mqDSC3LVs+a9wxc7CxcP+rdhRuaZ+q31eIW33Ivbu9T6DA4fpAjBrjGpVfdx8Qh98hjpWcOGdrhAjsn2PevavOJgZt9VGIMmIsN4PFy5rjVrd7JIenPncUVOJdXzkbk0+bxXC1e86NgHdsu4w68ybUiBy4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=fFMWnRyM; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="fFMWnRyM"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1722218812;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=PrqTFdMmaMUL1Y58ZHngeWA4ABxlLjJgQebIEkenRm8=;
	b=fFMWnRyMTwFwhfu6yAhWolGKdSfc82g+Fhr9DOyRz8Xhqdr9dVx5mWSWH2DHtKI5FXvzfx
	DvB25TYlfsST557hSQjJwvKr2aoo56GAg3ERmsfEImeUG3yksGPIXm++KUNO4IqGKNyZz6
	UI2vNw/6pq65bJR/slWYWDqxTpZDLdE=
Received: from mail-pg1-f200.google.com (mail-pg1-f200.google.com
 [209.85.215.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-505-jwUArdmRNzGphoHunCi41g-1; Sun, 28 Jul 2024 22:06:45 -0400
X-MC-Unique: jwUArdmRNzGphoHunCi41g-1
Received: by mail-pg1-f200.google.com with SMTP id 41be03b00d2f7-7a2a04c79b6so2399158a12.0
        for <virtualization@lists.linux.dev>; Sun, 28 Jul 2024 19:06:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722218805; x=1722823605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PrqTFdMmaMUL1Y58ZHngeWA4ABxlLjJgQebIEkenRm8=;
        b=JOPQfgnXt7oliERtE2i+5ColtqCSWcOIFcwuNAjdw9+4+pW1sKL2Vz7pR4oemUTbV0
         39mNaBSkrtb+2NnvItwe0Y+W/6UffFtytzW5VyJ9bsA4wTt0xrbyWPWbx7tB1jaBspL7
         oCdHpMjgO0x1IYQpT6krjLnMs3RrpXJMxrhiYuYanP4zLo52M/lFdF3PnHPj37A6XVmq
         DJUy+hWnorskujQh8KbXHkBhDc+/3aCSm2UCtvKu7GiYzgazD8o2jlqVxQTR9cAbt54S
         7uT+TC3wUDhlphi2BkCc6eqI+1qMEkviVUff6WYsNnG3WwrvclO9ghtj5V3kKSFPhRNj
         q0Sg==
X-Forwarded-Encrypted: i=1; AJvYcCVFBcw/pOaptieFEssJMDksvwXKyHeuAkpTHpDI7StjpPS3pz/l7Naj65G2dYuQpGa/3/F818HxjkeB4UNyjuwhe07XhCFtVHippQqCqL4=
X-Gm-Message-State: AOJu0YxbhX+xbpJnxnPimb0KDYj8urTEOzwtIEzMCSl8ef5Ey1GIGjpd
	slwnOKb0mXZBl/vwpYMTJ3DRMCmXU5sjz/Ef+4i7uHoOHf/3A+ZKKiedyeo+IIt3qwKgHwQrKhr
	BEZuLaxj1q5mButYcY6qqwAspgxsgj5C/6tB2c6rVXnTuHCmtEgOMVUESuCfsjWT0wPapk2cusZ
	Bv4NLbZ9VsYt+ARRZVPpo7S4odc90XZ0Z5GOeTPQo=
X-Received: by 2002:a17:90a:bb84:b0:2cb:5fe6:8a1d with SMTP id 98e67ed59e1d1-2cf7ceafd79mr10695250a91.9.1722218804744;
        Sun, 28 Jul 2024 19:06:44 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHIn0QgfPyq3bBiwhtNqo7WKE1Qewu4DB9eM+QPfcaSFcDvTNudWEZgAoQTfDBaZwmnkMNTa/ldfcoWLbSVcYg=
X-Received: by 2002:a17:90a:bb84:b0:2cb:5fe6:8a1d with SMTP id
 98e67ed59e1d1-2cf7ceafd79mr10695214a91.9.1722218804249; Sun, 28 Jul 2024
 19:06:44 -0700 (PDT)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20240724033816.GD492231@quicinc.com> <CACGkMEs_FHg6xZAw2V7AKvj5XFCmaA0Xm+ei7z4OFJPNgO5Thw@mail.gmail.com>
 <20240726011340-mutt-send-email-mst@kernel.org>
In-Reply-To: <20240726011340-mutt-send-email-mst@kernel.org>
From: Jason Wang <jasowang@redhat.com>
Date: Mon, 29 Jul 2024 10:06:33 +0800
Message-ID: <CACGkMEsK=xZXouPX7MqoZJyrZ7ufOcHOQjFvR40xdg3XvStnaw@mail.gmail.com>
Subject: Re: [RFC] vduse config write support
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Srivatsa Vaddagiri <quic_svaddagi@quicinc.com>, xieyongji@bytedance.com, stefanha@redhat.com, 
	virtio-dev@lists.linux.dev, virtualization@lists.linux.dev, 
	quic_mnalajal@quicinc.com, quic_eberman@quicinc.com, quic_pheragu@quicinc.com, 
	quic_pderrin@quicinc.com, quic_cvanscha@quicinc.com, 
	quic_pkondeti@quicinc.com, quic_tsoni@quicinc.com, 
	eperezma <eperezma@redhat.com>, Stefano Garzarella <sgarzare@redhat.com>, Cindy Lu <lulu@redhat.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jul 26, 2024 at 1:15=E2=80=AFPM Michael S. Tsirkin <mst@redhat.com>=
 wrote:
>
> On Fri, Jul 26, 2024 at 10:47:59AM +0800, Jason Wang wrote:
> > On Wed, Jul 24, 2024 at 11:45=E2=80=AFAM Srivatsa Vaddagiri
> > <quic_svaddagi@quicinc.com> wrote:
> > >
> > > Currently vduse does not seem to support configuration space writes
> > > (vduse_vdpa_set_config does nothing). Is there any plan to lift that
> > > limitation? I am aware of the discussions that took place here:
> > >
> > > https://patchwork.kernel.org/project/netdevbpf/patch/20210615141331.4=
07-11-xieyongji@bytedance.com/
> > >
> > > Perhaps writes can be supported *selectively* without violating safet=
y concerns
> > > expressed in the above email discussion?
> >
> > Adding more relevant people here.
> >
> > It can probably be done case by case. The main reason for avoiding
> > config writing is
> >
> > 1) to prevent buggy/malicious userspace from hanging kernel driver for =
ever
> > 2) to prevent buggy/malicious userspace device to break the semantic
> >
> > Basically, it is the traditional trust model where the kernel doesn't
> > trust userspace.
> >
> > E.g current virtio-blk has the following codes:
> >
> > tatic ssize_t
> > cache_type_store(struct device *dev, struct device_attribute *attr,
> >          const char *buf, size_t count)
> > {
> >         struct gendisk *disk =3D dev_to_disk(dev);
> >         struct virtio_blk *vblk =3D disk->private_data;
> >         struct virtio_device *vdev =3D vblk->vdev;
> >         int i;
> >
> >         BUG_ON(!virtio_has_feature(vblk->vdev, VIRTIO_BLK_F_CONFIG_WCE)=
);
> >         i =3D sysfs_match_string(virtblk_cache_types, buf);
> >         if (i < 0)
> >         return i;
> >
> >         virtio_cwrite8(vdev, offsetof(struct virtio_blk_config, wce), i=
);
> >         virtblk_update_cache_mode(vdev);
> >         return count;
> > }
>
> To be fair, I think if you allow a block device in userspace you have alr=
eady
> allowed said userspace to crash the kernel unless you have
> also restricted the filesystems mounted on this device to FUSE.

I'm not sure I will get here, I think the kernel should be able to
survive from the buggy device no matter if it is a real one or
something emulated in the userspace?

And if we can manage to do that, we should have an extra safe layer
(e.g we've agreed that we need to use shadow cvq for VDUSE networking
devices).

THanks

>
> --
> MST
>

