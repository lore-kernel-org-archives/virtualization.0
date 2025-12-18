Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF886332EA8
	for <virtualization@lists.linux.dev>; Thu, 18 Dec 2025 10:07:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766052445; cv=none; b=SlIAN6ez5fPklYj435WWcp4A2NEfMrx5+wKMLCbajk5qDtoouUHkspem+BRyzA0YQaFjPsg7qpujUm67uFyeDLGCfZyCnB3gERa/MDN24sAeDPVStfYWNayC5aRrdrYOwu7HZT8FbnQhppWD5s4QqaeOEh5LfvVyCViavD9M1Xg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766052445; c=relaxed/simple;
	bh=gk9r8jXXbqDGUWl1nRBPvbhY5yM7AF+Nu9FIeoX9miM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=snnnrUYO5yC/5c+XjRRRzCSUfPesEvo8OWA+swf0Grxohoir/4H86gZ0lFEhigAzFIs41yIYwQ0+CIIsO+cu+83+w3AIl/O1/Nj1qTltotV7IC36WJ/GeDALLxENnw7Eac5YasL2VVwYHuBKW/rEIkLDIM06gR0iM/QlFU67nOE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ezefOuKO; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ezefOuKO"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1766052442;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=iLBVsO05sU5sMeF6AgvnJgNMEahme0MICJ+mMFM/gug=;
	b=ezefOuKOHl1Ac/hgm9czdM0oVucE/5h/4JyH0K9qv0dHf2NoAYn9e85gYUyNGVQzcu62cR
	07Kdv3GLnFxH6qoleb0T7LoUpFunSdgo+FhpMTsVVoZkQ7rBthJuUePLeN7u2uZhu4cstS
	sFXN7xC80ZEEjFeevr/HPPUOZzrJmNM=
Received: from mail-yx1-f71.google.com (mail-yx1-f71.google.com
 [74.125.224.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-673-DwkQ7VvzMnejQVaGYBPZKg-1; Thu, 18 Dec 2025 05:07:19 -0500
X-MC-Unique: DwkQ7VvzMnejQVaGYBPZKg-1
X-Mimecast-MFC-AGG-ID: DwkQ7VvzMnejQVaGYBPZKg_1766052438
Received: by mail-yx1-f71.google.com with SMTP id 956f58d0204a3-63e2d3351abso591073d50.3
        for <virtualization@lists.linux.dev>; Thu, 18 Dec 2025 02:07:19 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766052438; x=1766657238;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=iLBVsO05sU5sMeF6AgvnJgNMEahme0MICJ+mMFM/gug=;
        b=QEdTHLlCVuMGXNQSQEFlSHtUeFy5FDEalgnlEFL3QtVDPYY5xmlsl3bDhVmZUysBmA
         HqDlcqA+rnFRzkOggWIDwWb0Xydp3BjG2OVCIZ+XKYrFlYaERYUNBwG8RjUV8Jxte3E+
         mDXibwoyHnq/a55LSHoiER49pEIgFmsFo7wCXd3gvQNPMZ2RyhDhjlSqrRvE0I4+qiVa
         QXGs0WznP+5N5ACgVWiqrNa+R5OuCh8fB2QZWc/1pDCgn2TJF7NCrvZhc0kpikx9XE5f
         gD/5MEiRn2WwPEWI8NJTcj8Y0JoPbFdAoGN6sbnd1rZOVXgxzHSz2z1yt4mrIFzVVnaZ
         CeGw==
X-Forwarded-Encrypted: i=1; AJvYcCWfRMUUwlscKGj9afsx9S/i6cUaZrHmKOmFdBBUEmsDCDPrn7sDQ6r3lkftJf40DTJBiCT5V2Kx1489SNWsvg==@lists.linux.dev
X-Gm-Message-State: AOJu0Yy5Pvo8YgoTNmIK4uWqzGU2uhoa7WDvn3nT39zzKQcYvZyNT2b1
	Q1PsnZNxmyNnmLl1dpFwAt+KgfVk/3ku7sklDmD4Bs2cjy78XdMmllaLbxmDPq/cJr6Q/OAEiWF
	yaCUlxtOcPTAIskKw/nLU3V86H2TxpcwSWBXmb3LMMOPax78nA7ya1fkKr6kIVDUxVr+19D1p3i
	aN54/XzoVAkHlrFARWftBe4LjfUnpFy91s+XIDhKo8sGg=
X-Gm-Gg: AY/fxX7RDmPEVJ8Fih85n4muUUnppmLaC+u2Q/0hyMBHJllZGkw4yva7XGphGYV0U7O
	3+Wik7KgjbXR9tDOZzVwXTByd1yyxU+rPy6O4aLtppo5ZoMBbpNpsCOUsPrS+IHGlKg0hL+mAlS
	atHNZGbogBbqU42X8CNxZ8WdQYYukeHyDgatzg4r5VuWukDL7MgIgTZM36SVOddAWAKXI=
X-Received: by 2002:a05:690c:25c8:b0:787:badd:4c with SMTP id 00721157ae682-78e66d0a00cmr343795577b3.27.1766052438463;
        Thu, 18 Dec 2025 02:07:18 -0800 (PST)
X-Google-Smtp-Source: AGHT+IE4FdM9wPRHh3bJMfsZOO4K7fw6LMkWPPuQ5HwarXv8WuEnK7aju0rAr6nrJfGF/mndIfeF0UpPuYU5bL6yGA0=
X-Received: by 2002:a05:690c:25c8:b0:787:badd:4c with SMTP id
 00721157ae682-78e66d0a00cmr343795097b3.27.1766052438082; Thu, 18 Dec 2025
 02:07:18 -0800 (PST)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20251217112414.2374672-1-eperezma@redhat.com> <20251217112414.2374672-3-eperezma@redhat.com>
 <CACGkMEuCgvKEfFCGLp1XSaa+tKM0KYvzYmpC+57ZnUuomNwV5g@mail.gmail.com>
In-Reply-To: <CACGkMEuCgvKEfFCGLp1XSaa+tKM0KYvzYmpC+57ZnUuomNwV5g@mail.gmail.com>
From: Eugenio Perez Martin <eperezma@redhat.com>
Date: Thu, 18 Dec 2025 11:06:41 +0100
X-Gm-Features: AQt7F2r5VVpGjTBicpXfKSfapf-MwZOQtGcGIvtaxrRE4xYGf0vBVyXB3ZrZ7ws
Message-ID: <CAJaqyWepbQBJZmDv8QuaE309EHW_GEzFUHTTKtbLM29JUXmKpw@mail.gmail.com>
Subject: Re: [PATCH v10 2/8] vduse: add vq group support
To: Jason Wang <jasowang@redhat.com>
Cc: "Michael S . Tsirkin" <mst@redhat.com>, Maxime Coquelin <mcoqueli@redhat.com>, 
	Laurent Vivier <lvivier@redhat.com>, virtualization@lists.linux.dev, 
	linux-kernel@vger.kernel.org, Stefano Garzarella <sgarzare@redhat.com>, 
	Yongji Xie <xieyongji@bytedance.com>, Xuan Zhuo <xuanzhuo@linux.alibaba.com>, 
	Cindy Lu <lulu@redhat.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: 1dBSki_x0-1YVna2Na5YFGytWQPMCj18yGXxrCih_nA_1766052438
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Dec 18, 2025 at 7:47=E2=80=AFAM Jason Wang <jasowang@redhat.com> wr=
ote:
>
> On Wed, Dec 17, 2025 at 7:24=E2=80=AFPM Eugenio P=C3=A9rez <eperezma@redh=
at.com> wrote:
> >
> > This allows separate the different virtqueues in groups that shares the
> > same address space.  Asking the VDUSE device for the groups of the vq a=
t
> > the beginning as they're needed for the DMA API.
> >
> > Allocating 3 vq groups as net is the device that need the most groups:
> > * Dataplane (guest passthrough)
> > * CVQ
> > * Shadowed vrings.
> >
> > Future versions of the series can include dynamic allocation of the
> > groups array so VDUSE can declare more groups.
> >
> > Acked-by: Jason Wang <jasowang@redhat.com>
> > Reviewed-by: Xie Yongji <xieyongji@bytedance.com>
> > Signed-off-by: Eugenio P=C3=A9rez <eperezma@redhat.com>
> > ---
> > v6:
> > * s/sepparate/separate (MST).
> > * s/dev->api_version < 1/dev->api_version < VDUSE_API_VERSION_1
> >
> > v5:
> > * Revert core vdpa changes (Jason).
> > * Fix group =3D=3D ngroup case in checking VQ_SETUP argument (Jason).
> >
> > v4:
> > * Revert the "invalid vq group" concept and assume 0 if not set (Jason)=
.
> > * Make config->ngroups =3D=3D 0 invalid (Jason).
> >
> > v3:
> > * Make the default group an invalid group as long as VDUSE device does
> >   not set it to some valid u32 value.  Modify the vdpa core to take tha=
t
> >   into account (Jason).
> > * Create the VDUSE_DEV_MAX_GROUPS instead of using a magic number
> >
> > v2:
> > * Now the vq group is in vduse_vq_config struct instead of issuing one
> >   VDUSE message per vq.
> >
> > v1:
> > * Fix: Remove BIT_ULL(VIRTIO_S_*), as _S_ is already the bit (Maxime)
> >
> > RFC v3:
> > * Increase VDUSE_MAX_VQ_GROUPS to 0xffff (Jason).  It was set to a lowe=
r
> >   value to reduce memory consumption, but vqs are already limited to
> >   that value and userspace VDUSE is able to allocate that many vqs.
> > * Remove the descs vq group capability as it will not be used and we ca=
n
> >   add it on top.
> > * Do not ask for vq groups in number of vq groups < 2.
> > * Move the valid vq groups range check to vduse_validate_config.
> >
> > RFC v2:
> > * Cache group information in kernel, as we need to provide the vq map
> >   tokens properly.
> > * Add descs vq group to optimize SVQ forwarding and support indirect
> >   descriptors out of the box.
> > ---
> >  drivers/vdpa/vdpa_user/vduse_dev.c | 48 ++++++++++++++++++++++++++----
> >  include/uapi/linux/vduse.h         | 12 ++++++--
> >  2 files changed, 52 insertions(+), 8 deletions(-)
> >
> > diff --git a/drivers/vdpa/vdpa_user/vduse_dev.c b/drivers/vdpa/vdpa_use=
r/vduse_dev.c
> > index ae357d014564..b012dc3557b9 100644
> > --- a/drivers/vdpa/vdpa_user/vduse_dev.c
> > +++ b/drivers/vdpa/vdpa_user/vduse_dev.c
> > @@ -39,6 +39,7 @@
> >  #define DRV_LICENSE  "GPL v2"
> >
> >  #define VDUSE_DEV_MAX (1U << MINORBITS)
> > +#define VDUSE_DEV_MAX_GROUPS 0xffff
> >  #define VDUSE_MAX_BOUNCE_SIZE (1024 * 1024 * 1024)
> >  #define VDUSE_MIN_BOUNCE_SIZE (1024 * 1024)
> >  #define VDUSE_BOUNCE_SIZE (64 * 1024 * 1024)
> > @@ -58,6 +59,7 @@ struct vduse_virtqueue {
> >         struct vdpa_vq_state state;
> >         bool ready;
> >         bool kicked;
> > +       u32 vq_group;
>
> Nit, since we are under the context of virtqueue, I'd rename this as a
> simple "group".

Sure, I'll change it in the next version.

