Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B95DB18CC00
	for <virtualization@lists.linux.dev>; Thu, 29 Aug 2024 09:06:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724922386; cv=none; b=Kp/o37yljEABQyYfyQ8S2Ra8sLaXNMQq0jgwpUlZVOFvprpAuCB/huCpgy22EDDE2KnOEGpz4pg3cg8VjwrNG/0ylIDHqCntk/mGu4PBBCT1z98zx6V7CFUba2QGVb902Lz3aEBaaCKRJX8OTETDAQL7xNWpK4Ob2FnXokhNc5Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724922386; c=relaxed/simple;
	bh=dNmgvB0PNie3Ta9wWOJOICrzojenRtlbYkH0WIcuTts=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=IGzxFIRRRZfOptXSkk2skrkpcqCt07ZWw0cA50IiTp65dNCRx9lp5zpAK88dE+6x13LKJhF2T9wmvm0Pq2v8tyThuP+ki5uOUo8sFFeD1fVrp6tMBUvIwG6qHtAvYr33dUA2rHTI8Z5mEBh61ib8z2rL65iWPCgSuRykn9olT3g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=VqvY8zXD; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="VqvY8zXD"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1724922383;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=/uYBPSE4scu+k+l3zhOUlQLPU644iSREuuqaqkYhf/E=;
	b=VqvY8zXDJ+obpgci2QQ6XbhbN4hP09u4+mpElgD4aSF2aLs3zjnjgMQ5MDrhg5NA7oO0OI
	ktgYNWXR08mw1Lh3MEgAfBXN+2hFqK1fFcTbGdSZWGmiwV99Ey7275Dfr4l+v6YxtjgE4O
	Akj9ZdVC8rOP4dpgazphVzk65ND2v84=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-361-QN41FFKZPHacP80meeNTHA-1; Thu, 29 Aug 2024 05:06:17 -0400
X-MC-Unique: QN41FFKZPHacP80meeNTHA-1
Received: by mail-ed1-f70.google.com with SMTP id 4fb4d7f45d1cf-5bed91ffb7bso250859a12.3
        for <virtualization@lists.linux.dev>; Thu, 29 Aug 2024 02:06:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724922376; x=1725527176;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/uYBPSE4scu+k+l3zhOUlQLPU644iSREuuqaqkYhf/E=;
        b=o4aSb11+JXm68u75Aza5FWntTc9nUdVKhEQPm4xV7XzftPUCgJXqTHtc9NqxCaP8bM
         fEfdLScb/o1mbCsx1V5xy2HiNn5gbOLFLSgVCKy+7jxHYfUkM4UZEGEjB+yyMUI9kH4f
         9Kaf2n6w/yJNFrLf0+Gof10BRW14Q8i9Eeiwr8SfahbQZAZTd45iVvo/OmJmoXLX25Tl
         xG30VyYX4+RF4Cb9QxTug86LRvz4yWJrq37uka/iF1u9BA06wkxjwPc77iMc1yArScDE
         SOLmL9/mtl5b82TRb7d5mJdxtQD4qD+OOXBxblD1hM63EjbWMSXyByVSzxdSBWF+4Wv/
         eLYQ==
X-Forwarded-Encrypted: i=1; AJvYcCWIcxJ660dTKh0zYemqJCWtvUMcP6KaE2U9R/E067jkLgvwz4chbjk5Xz1l220HMS9OTwyBWqpNC+7wPCh0Qg==@lists.linux.dev
X-Gm-Message-State: AOJu0YxQ1Vy4mNmoKcmSco4Q7fMrTaRsTLR510RRrTQ4F586z7YgOlX9
	BGC9DSh21ybZyKuLI6i5W1s1arHDPh5xyB/5XH2pPpLx/Jw4udw9KGMU6EsfNQt7i5001PVG9DW
	/b6c7ZJx6MIwJObutPtVNfwUi+HB1xb1ZULWJg+fiMOoPd3EAtgCYmyRphkDQwCzLSntLmrMQ4w
	62P/27uUcgWsKsmUfMdrLDretgbs5DAryk4nMvrHs=
X-Received: by 2002:a05:6402:90b:b0:5be:fbe7:11ac with SMTP id 4fb4d7f45d1cf-5c21ed54d3cmr1826753a12.20.1724922375794;
        Thu, 29 Aug 2024 02:06:15 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHGLm8Hz5ioA0VaJ4JLlmepguUyiuDxm4rTg99EfDG1HDgky7aJfIl1rtVoY3YUHlEK2SJJtzOojwa/4ib/k+8=
X-Received: by 2002:a05:6402:90b:b0:5be:fbe7:11ac with SMTP id
 4fb4d7f45d1cf-5c21ed54d3cmr1826728a12.20.1724922375297; Thu, 29 Aug 2024
 02:06:15 -0700 (PDT)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20240827160256.2446626-2-dtatulea@nvidia.com> <CACGkMEuRvqu8W9-OqPBRhn1DG-+DO6TCzFdHqc7zB74GkNDkAQ@mail.gmail.com>
 <CACLfguXjiyp+Ya4mUKXu6Dmb3Wx5wW0bbNGRSFWE-Z0E5gALTA@mail.gmail.com> <8daf221f-8d87-4da1-944c-3bcd0edea604@nvidia.com>
In-Reply-To: <8daf221f-8d87-4da1-944c-3bcd0edea604@nvidia.com>
From: Cindy Lu <lulu@redhat.com>
Date: Thu, 29 Aug 2024 17:05:38 +0800
Message-ID: <CACLfguVr1bd6=bkGn6hX3W7xBr45qydaCpQ1mNpsATeWFqe2ZA@mail.gmail.com>
Subject: Re: [PATCH] vdpa/mlx5: Use random MAC address when no nic vport MAC set
To: Dragos Tatulea <dtatulea@nvidia.com>
Cc: Jason Wang <jasowang@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, 
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>, =?UTF-8?Q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>, 
	si-wei.liu@oracle.com, Jiri Pirko <jiri@nvidia.com>, virtualization@lists.linux.dev, 
	linux-kernel@vger.kernel.org
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, 28 Aug 2024 at 17:37, Dragos Tatulea <dtatulea@nvidia.com> wrote:
>
>
>
> On 28.08.24 11:00, Cindy Lu wrote:
> > On Wed, 28 Aug 2024 at 09:51, Jason Wang <jasowang@redhat.com> wrote:
> >>
> >> On Wed, Aug 28, 2024 at 12:03=E2=80=AFAM Dragos Tatulea <dtatulea@nvid=
ia.com> wrote:
> >>>
> >>> When the vdpa device is configured without a specific MAC
> >>> address, the vport MAC address is used. However, this
> >>> address can be 0 which prevents the driver from properly
> >>> configuring the MPFS and breaks steering.
> >>>
> >>> The solution is to simply generate a random MAC address
> >>> when no MAC is set on the nic vport.
> >>>
> >>> Now it's possible to create a vdpa device without a
> >>> MAC address and run qemu with this device without needing
> >>> to configure an explicit MAC address.
> >>>
> >>> Signed-off-by: Dragos Tatulea <dtatulea@nvidia.com>
> >>> Reviewed-by: Jiri Pirko <jiri@nvidia.com>
> >>
> >> Acked-by: Jason Wang <jasowang@redhat.com>
> >>
> >> (Adding Cindy for double checking if it has any side effect on Qemu si=
de)
> >>
> >> Thanks
> >>
> > But Now there is a bug in QEMU: if the hardware MAC address does not
> > match the one in the QEMU command line, it will cause traffic loss.
> >
> Why is this a new issue in qemu? qemu in it's current state won't work
> with a different mac address that the one that is set in HW anyway.
>
this is not a new bug. We are trying to fix it because it will cause
traffic lose without any warning.
in my fix , this setting (different mac in device and Qemu) will fail
to load the VM.

> > So, Just an FYI here: if your patch merged, it may cause traffic loss.
> > and now I'm working in the fix it in qemu, the link is
> > https://patchew.org/QEMU/20240716011349.821777-1-lulu@redhat.com/
> > The idea of this fix is
> > There are will only two acceptable situations for qemu:
> > 1. The hardware MAC address is the same as the MAC address specified
> > in the QEMU command line, and both MAC addresses are not 0.
> > 2. The hardware MAC address is not 0, and the MAC address in the QEMU
> > command line is 0. In this situation, the hardware MAC address will
> > overwrite the QEMU command line address.
> >
> Why would this not work with this patch? This patch simply sets a MAC
> if the vport doesn't have one set. Which allows for more scenarios to
> work.
>
I do not mean your patch will not work, I just want to make some
clarify here.Your patch + my fix may cause the VM to fail to load in
some situations, and this is as expected.
Your patch is good to merge.
Thanks
cindy

> Thanks,
> Dragos
>
> > Thanks
> > Cindy
> >
> >
> >>> ---
> >>>  drivers/vdpa/mlx5/net/mlx5_vnet.c | 3 +++
> >>>  1 file changed, 3 insertions(+)
> >>>
> >>> diff --git a/drivers/vdpa/mlx5/net/mlx5_vnet.c b/drivers/vdpa/mlx5/ne=
t/mlx5_vnet.c
> >>> index fa78e8288ebb..1c26139d02fe 100644
> >>> --- a/drivers/vdpa/mlx5/net/mlx5_vnet.c
> >>> +++ b/drivers/vdpa/mlx5/net/mlx5_vnet.c
> >>> @@ -3824,6 +3824,9 @@ static int mlx5_vdpa_dev_add(struct vdpa_mgmt_d=
ev *v_mdev, const char *name,
> >>>                 err =3D mlx5_query_nic_vport_mac_address(mdev, 0, 0, =
config->mac);
> >>>                 if (err)
> >>>                         goto err_alloc;
> >>> +
> >>> +               if (is_zero_ether_addr(config->mac))
> >>> +                       eth_random_addr(config->mac);
> >>>         }
> >>>
> >>>         if (!is_zero_ether_addr(config->mac)) {
> >>> --
> >>> 2.45.1
> >>>
> >>
> >
>

