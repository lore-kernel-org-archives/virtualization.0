Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34FEE1E5B88
	for <virtualization@lists.linux.dev>; Thu, 18 Dec 2025 06:46:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766040420; cv=none; b=c8uuEnV012INXmlQueVBdLt5dC63Dv73iVbmA9Opd3EpAYbpwAfE8K2PJ+Fgj4rRZALJZpJu2adprnlmJuk6uEPnXtZxOWVMRzAwX847WQPsKI1KzVTrtBnuJtAAnAern9IQau1IDXsX2H2KDxeaIA9AHlGIklNw0GCGaQ1rmsc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766040420; c=relaxed/simple;
	bh=FbOFR3Lodak7lnK2lxvr4BMe+jL2idUq29DE+a1gksQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=dEbpWWoTs9Xe3KG2xQ3d2BU3QBWVX3JkgHKdovD7/bLsdB/C177+v2BDLsDe7ctrPvpNWPn3Oyma68BAnbNvt0EY4Wd/G+Ywbv+5pdHuBGHV9RGX7RkemUYL4tLbTAnVRtYk3z3ES+0AErCTu+fZf4EGgKOUWw9XId/1zSg5DyI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=hkA22FJF; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="hkA22FJF"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1766040418;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=xUiKRxYGxFzeLLj7GwvP7kprPOemWU4a3M4sfrsHPcA=;
	b=hkA22FJF03YuuAAbuJ3+FpaTcAZOFVr5B0HAuqQTTqXjx4Eu0B8BLOc3qQ44MTQ06QKxkP
	x7hZOQc8UqLC+rM69LJvX1jwSvLJaiOhFoCtr1Mp/f/GjuwMrZe6fDm7p7puqwS5sw9KsE
	O/CKu0rfxJSS4zpSaqcwqDcpflN/RI4=
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com
 [209.85.216.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-683-TTGj7QKnPqKmvlTp1sH9rQ-1; Thu, 18 Dec 2025 01:46:54 -0500
X-MC-Unique: TTGj7QKnPqKmvlTp1sH9rQ-1
X-Mimecast-MFC-AGG-ID: TTGj7QKnPqKmvlTp1sH9rQ_1766040414
Received: by mail-pj1-f72.google.com with SMTP id 98e67ed59e1d1-34c5d7865e4so518683a91.2
        for <virtualization@lists.linux.dev>; Wed, 17 Dec 2025 22:46:54 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766040413; x=1766645213;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=xUiKRxYGxFzeLLj7GwvP7kprPOemWU4a3M4sfrsHPcA=;
        b=YjtbNacBicQSO3RD+rjCX8SEifNPjyDP0wEkALeBQaCa5NF95IHZSlwa0D0QQ7KbBS
         blgmB0qSu149Tk9/ZUA/tZS0qbwmUlCFnt9EKeH5deyZM1fSkWUGTsUEQhFIAqLTvFcB
         kUJuM4219zEjLgi94Q1Lec6PBqKwKBppC2tzSLySsSscr7A1/C5/4pTSVHeOoxL+Wwfp
         OBOSiqGivIuqbgZvcUeE4/MsuGm1m/9RD3KRM8bvc7vzFlPxj6x8tm1Ek6e9xGhgXKbA
         HMbhn/NRdIz0JFxW/WFTMFmwyRd8QrTEMV4iVAkkpUiWWzhQVzZfvL+hhcGNLBStoZdJ
         bLLQ==
X-Forwarded-Encrypted: i=1; AJvYcCXQItXSZ7ow6C3St6QJ3isqW9QjkDG2k2XfBZXr19HB7jPZX2IqJYY4NFoIyHEQqG35PmHoh06ZHwOx3dGsWQ==@lists.linux.dev
X-Gm-Message-State: AOJu0YyVLuYI4+msyPTFdtQITaBHm/7//KEgMqNz/Si/3aXgWhVQxCJ3
	0tjfD11FLFfsrcRpjvWl6y17UZbk6cluV8FFu+PfezsrZcZiQQVYUGmbUvIwMAcAETZsSL/3njA
	SYfdJ7TzcKG28+sZO53iPxolJ0SrKGOLsbYl31s1rdYFzAQ53mfksOFRlwS4Cxhv/npEs4GAiTz
	mvR891u3iXt2H8SnH8DkS7P7dGv9+uCUp9Dh8PDNMglEI=
X-Gm-Gg: AY/fxX6oNZZjFVklp9Epd4Xx7yY+DS+ayDfeoF//6H4GbBSkoyl5toTETanCeMIBSKv
	lnCN0Stm4xmIHFh67tJ0Nh3ChyKnxLrF0/qit6D4aSBrykecYjWf+9EmnXabIVPxC0hjZIaC3au
	yNsS2o8+jHm8qTlST/fyPVIQz7nn6kqCyIHJagjUuPBD+3lE0IA3+SeKuVbbFf7npWO+g=
X-Received: by 2002:a17:90b:3910:b0:349:2154:eede with SMTP id 98e67ed59e1d1-34abd6dd274mr20107906a91.14.1766040413618;
        Wed, 17 Dec 2025 22:46:53 -0800 (PST)
X-Google-Smtp-Source: AGHT+IH4gPHTu7IBUULdZh25EfY71Zgv75+8S7LvUi0NxfIxFRu6RlIsopLkkiFBouT8HiXfQ96Xo8f5YqOeCLikRIo=
X-Received: by 2002:a17:90b:3910:b0:349:2154:eede with SMTP id
 98e67ed59e1d1-34abd6dd274mr20107891a91.14.1766040413170; Wed, 17 Dec 2025
 22:46:53 -0800 (PST)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20251217112414.2374672-1-eperezma@redhat.com> <20251217112414.2374672-3-eperezma@redhat.com>
In-Reply-To: <20251217112414.2374672-3-eperezma@redhat.com>
From: Jason Wang <jasowang@redhat.com>
Date: Thu, 18 Dec 2025 14:46:41 +0800
X-Gm-Features: AQt7F2rL8Q4rx-SgJkOI9jdWJbbEKI4jqxdDPoxNYugVAt_bPujJWd0itYjbJyQ
Message-ID: <CACGkMEuCgvKEfFCGLp1XSaa+tKM0KYvzYmpC+57ZnUuomNwV5g@mail.gmail.com>
Subject: Re: [PATCH v10 2/8] vduse: add vq group support
To: =?UTF-8?Q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>
Cc: "Michael S . Tsirkin" <mst@redhat.com>, Maxime Coquelin <mcoqueli@redhat.com>, 
	Laurent Vivier <lvivier@redhat.com>, virtualization@lists.linux.dev, 
	linux-kernel@vger.kernel.org, Stefano Garzarella <sgarzare@redhat.com>, 
	Yongji Xie <xieyongji@bytedance.com>, Xuan Zhuo <xuanzhuo@linux.alibaba.com>, 
	Cindy Lu <lulu@redhat.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: TJhPmFJuAK1vIna0uiiuwjGiCnLnq4A3A5h9VhDECso_1766040414
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Dec 17, 2025 at 7:24=E2=80=AFPM Eugenio P=C3=A9rez <eperezma@redhat=
.com> wrote:
>
> This allows separate the different virtqueues in groups that shares the
> same address space.  Asking the VDUSE device for the groups of the vq at
> the beginning as they're needed for the DMA API.
>
> Allocating 3 vq groups as net is the device that need the most groups:
> * Dataplane (guest passthrough)
> * CVQ
> * Shadowed vrings.
>
> Future versions of the series can include dynamic allocation of the
> groups array so VDUSE can declare more groups.
>
> Acked-by: Jason Wang <jasowang@redhat.com>
> Reviewed-by: Xie Yongji <xieyongji@bytedance.com>
> Signed-off-by: Eugenio P=C3=A9rez <eperezma@redhat.com>
> ---
> v6:
> * s/sepparate/separate (MST).
> * s/dev->api_version < 1/dev->api_version < VDUSE_API_VERSION_1
>
> v5:
> * Revert core vdpa changes (Jason).
> * Fix group =3D=3D ngroup case in checking VQ_SETUP argument (Jason).
>
> v4:
> * Revert the "invalid vq group" concept and assume 0 if not set (Jason).
> * Make config->ngroups =3D=3D 0 invalid (Jason).
>
> v3:
> * Make the default group an invalid group as long as VDUSE device does
>   not set it to some valid u32 value.  Modify the vdpa core to take that
>   into account (Jason).
> * Create the VDUSE_DEV_MAX_GROUPS instead of using a magic number
>
> v2:
> * Now the vq group is in vduse_vq_config struct instead of issuing one
>   VDUSE message per vq.
>
> v1:
> * Fix: Remove BIT_ULL(VIRTIO_S_*), as _S_ is already the bit (Maxime)
>
> RFC v3:
> * Increase VDUSE_MAX_VQ_GROUPS to 0xffff (Jason).  It was set to a lower
>   value to reduce memory consumption, but vqs are already limited to
>   that value and userspace VDUSE is able to allocate that many vqs.
> * Remove the descs vq group capability as it will not be used and we can
>   add it on top.
> * Do not ask for vq groups in number of vq groups < 2.
> * Move the valid vq groups range check to vduse_validate_config.
>
> RFC v2:
> * Cache group information in kernel, as we need to provide the vq map
>   tokens properly.
> * Add descs vq group to optimize SVQ forwarding and support indirect
>   descriptors out of the box.
> ---
>  drivers/vdpa/vdpa_user/vduse_dev.c | 48 ++++++++++++++++++++++++++----
>  include/uapi/linux/vduse.h         | 12 ++++++--
>  2 files changed, 52 insertions(+), 8 deletions(-)
>
> diff --git a/drivers/vdpa/vdpa_user/vduse_dev.c b/drivers/vdpa/vdpa_user/=
vduse_dev.c
> index ae357d014564..b012dc3557b9 100644
> --- a/drivers/vdpa/vdpa_user/vduse_dev.c
> +++ b/drivers/vdpa/vdpa_user/vduse_dev.c
> @@ -39,6 +39,7 @@
>  #define DRV_LICENSE  "GPL v2"
>
>  #define VDUSE_DEV_MAX (1U << MINORBITS)
> +#define VDUSE_DEV_MAX_GROUPS 0xffff
>  #define VDUSE_MAX_BOUNCE_SIZE (1024 * 1024 * 1024)
>  #define VDUSE_MIN_BOUNCE_SIZE (1024 * 1024)
>  #define VDUSE_BOUNCE_SIZE (64 * 1024 * 1024)
> @@ -58,6 +59,7 @@ struct vduse_virtqueue {
>         struct vdpa_vq_state state;
>         bool ready;
>         bool kicked;
> +       u32 vq_group;

Nit, since we are under the context of virtqueue, I'd rename this as a
simple "group".

Thanks

