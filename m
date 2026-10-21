Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=170.10.133.124
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792575899;
	b=vxPxH0+ZzdO/5rwYZUl67f30GCn2uu81syxgOUhMnAqsnOc8CYfBkBaMBV5b6/ZUFYRQ
	 9elcGNf2YFLxfyQ7BE4Ou2OAeXYJ192gcZ079KpTAk4rkPzR8TFQT5NuA7dyVht0DG2mx
	 jQD6WY5W/EffxmJtbl8Jz1Bsqd8EERMzhsibKtaHua80lUt4vvukf0oiHe+A4tM+qUwLz
	 5PLQRVx+9fqRDpLIBXzsxZhyNFUnm/xGM0/Ey5ocGQ3OIY45C5goMYTmp5DqkpcAF8hc8
	 Jpc/zcyk0qUCwYUda3/+sy1xi3XLyMPim3f0sjasW7trEN/6dn9WZK1Jp7EWnhDk+9w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792575899;
	h=DMARC-Filter:DKIM-Signature:Received:X-MC-Unique:
	 X-Mimecast-MFC-AGG-ID:Received:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 X-Received:MIME-Version:References:In-Reply-To:From:Date:
	 X-Gm-Features:Message-ID:Subject:To:Cc:X-Mimecast-Spam-Score:
	 X-Mimecast-MFC-PROC-ID:X-Mimecast-Originator:Content-Type:
	 Content-Transfer-Encoding;
	bh=WTnrhlz2njHci/JTrFv5X7Hjh7ZdaN63OI8KvKNXce4=;
	b=R2ier0A6klGN9dvLXHL4z/Uz/2X98Eqz+vmi3F4xnVOah6cgIP/VAVJ8G3CD+aAiPyPp
	 N7jBPSPGmuuXIaTVj3/iLiVF29HsuZRPgbUOd+fSXsVOe3pHUAZDJeETgh9iTwe/OhTCY
	 SSKoVsoWeivTQjV9cOy5x+uw8/ynnUigXR0/PlawuND95HQlWIRJFntrdsYWCJ3/tVObC
	 Ull1T1yorhdZPtVzpJ+dbBAiG0NYE3Tb4xWtJv4Bg7nmZ9YWEWEGkK7f6SXxSoJcet00F
	 gKpzBpRUvURKYRwAix+cPQgGCpA4h5iqFxu//wt6Bp6GINiS3iqSTH4afNFD10nNgvQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=redhat.com;
	spf=pass smtp.mailfrom=redhat.com;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=HY24k0Xc;
	arc=none smtp.remote-ip=170.10.133.124
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E10B5606A31E
	for <virtualization@lists.linux.dev>; Wed, 21 Oct 2026 09:44:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E10B5606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=HY24k0Xc
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1792575897;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=WTnrhlz2njHci/JTrFv5X7Hjh7ZdaN63OI8KvKNXce4=;
	b=HY24k0XcpN515UNGwDTIbHkzIJ6lk+joMEC9exHja2ROLze/730tr83eU9+oDLWEaqJunL
	OtdXhyqGhAoImcdFRXUOT1ERJEV4YPWwCThSMld6YL4cyY2wdXtFObHhexq7Gfyw68axh2
	s0WEsEdblxqsS6rDHuZ2/GtsKl4hrYk=
Received: from mail-yx1-f70.google.com (mail-yx1-f70.google.com
 [74.125.224.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-384-dzl-K-nbNZ26q8Ghznngkg-1; Wed, 21 Oct 2026 09:44:51 +0000
X-MC-Unique: dzl-K-nbNZ26q8Ghznngkg-1
X-Mimecast-MFC-AGG-ID: dzl-K-nbNZ26q8Ghznngkg_1792575890
Received: by mail-yx1-f70.google.com with SMTP id 956f58d0204a3-6798c43a3bfso823098d50.0
        for <virtualization@lists.linux.dev>; Wed, 21 Oct 2026 02:44:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792575890; x=1793180690;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=WTnrhlz2njHci/JTrFv5X7Hjh7ZdaN63OI8KvKNXce4=;
        b=XU5ha01RVYE8YIeuHyNtMz+7uuLX3wV+ZcOZE+B7hZ72aKLYs/WJrB5xlXf1zjYLPp
         3JBWXrdmBdF0sZImTCtia39sbujxiH2cktjaoTt1I5us6085EEXodAlf0Ft1RPcx5fXx
         mjHwA7U3GVrN/asOpIvr/QhGuGO08ETr7WB65lUYPS2UEkzJVEog49+tMw2Ah8DAQfGO
         xL4l3QIR/YHaoyM296ZKpngHAsh+rqUET46a2BZDjnctFJfi5PFsHHNWbDTs18kN4eHX
         9WnhkmBGX4uW+HJKy5GjWg/7KfyrODmdwJNIXA1p3bPOfmlGavha6MsE9fAa+N6qV6VC
         QNJw==
X-Forwarded-Encrypted: i=1; AKwUvBwqrriDWfC9Q0doTPOS2B1PQYzZNybVgHgfItU3HWTKjeYyH+ZghJCp+TgowuCYNmls07qPhJTi0amYc7134A==@lists.linux.dev
X-Gm-Message-State: AFq9FYIA3e8XB//3VsLDpuHM+zsjvNPPgSQ1730yZFJwTdtS+80YukRp
	BUjsc+fPqcZqaeO5GkInbgPcEmrXjz+LypB2oYV4M8HJOGrrVCT+q6EAbu9DJPJm1mO2O2Vsg+C
	xUz0W1h5wYOSgMtAgc+XyNmWlopGsxviI41xjCmeTl7rgCJq5Ri/ITxJ65cPPLY25Uo3pQgRiOE
	6tU+Qz/u6NLnu0NRAj+BGdL/u/GejOxnt5l0u4C2kndHw=
X-Gm-Gg: AYBFou2jmnS9f3BlSuIL23QUc0tpSeOnSQ4Vw9fKedx3/OnjBkmtQ0Vl3h851al/vOP
	y9iZH6LWb880MSKPF9VnLM7H6y6X/TDL9vfteLte0cF8lELVXXz0xo89BoyD55+dWkiaA56SGib
	reaxUC78aZRMgQXxCxsVs/r6bJR/xpuW2ji5zLMQBaDPDAuT+BMFd8AcQhUWHgg9PsKFsXdljIR
	IVbXTGXxtf7xW/cAqcQI9Km+UOOY5dtIVPUVXS43aQ8tGtBDjFoYQq7+ps=
X-Received: by 2002:a05:690c:962:b0:8b0:acc6:8e89 with SMTP id 00721157ae682-8b133fa1bc8mr6189397b3.11.1792575890231;
        Wed, 21 Oct 2026 02:44:50 -0700 (PDT)
X-Received: by 2002:a05:690c:962:b0:8b0:acc6:8e89 with SMTP id
 00721157ae682-8b133fa1bc8mr6189277b3.11.1792575889747; Wed, 21 Oct 2026
 02:44:49 -0700 (PDT)
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Post: <mailto:virtualization@lists.linux.dev>
List-Help: <mailto:virtualization+help@lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
List-Owner: <mailto:virtualization+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
References: <20261020032958.1930203-1-liam@infradead.org> <20261020032958.1930203-3-liam@infradead.org>
In-Reply-To: <20261020032958.1930203-3-liam@infradead.org>
From: Eugenio Perez Martin <eperezma@redhat.com>
Date: Wed, 21 Oct 2026 11:44:12 +0200
X-Gm-Features: AclHuK_jKi01q0VmVHTsa2S8ArDqG757g4K4BNVLj8KlbA8R5_nv2rY1xUcuj7A
Message-ID: <CAJaqyWcBq4gyB3KCjjeGbrCbfsUenBWKZA+xTOOLPG-cxoHYnw@mail.gmail.com>
Subject: Re: [PATCH 2/2] tools/virtio: check posix_memalign() for failure
To: liam@infradead.org
Cc: "Michael S . Tsirkin" <mst@redhat.com>, Jason Wang <jasowangio@gmail.com>, 
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>, 
	=?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= <u.kleine-koenig@baylibre.com>, 
	virtualization@lists.linux.dev, linux-kernel@vger.kernel.org
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: AUOR1AOhJ-Xvs7ynb74Oeh1LDVWYHrMAzOcI6FivcLE_1792575890
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 20, 2026 at 5:30=E2=80=AFAM Liam R. Howlett (Google)
<liam@infradead.org> wrote:
>
> posix_memalign() returns zero or a positive error number and does not set
> errno.  virtio_test and vhost_net_test assert that the return is not
> negative, which will always be true, and the userspace __get_free_page()
> ignores it, so a failed allocation continues without setting the pointer
>
> Assert a zero return in the tests, and return 0 from __get_free_page() on
> failure, as the kernel's does.
>

Acked-by: Eugenio P=C3=A9rez <eperezma@redhat.com>

Thanks!

> Signed-off-by: Liam R. Howlett (Google) <liam@infradead.org>
> ---
>  tools/virtio/linux/kernel.h   | 3 ++-
>  tools/virtio/vhost_net_test.c | 2 +-
>  tools/virtio/virtio_test.c    | 2 +-
>  3 files changed, 4 insertions(+), 3 deletions(-)
>
> diff --git a/tools/virtio/linux/kernel.h b/tools/virtio/linux/kernel.h
> index 104abf9d1aee5..3497660c690a9 100644
> --- a/tools/virtio/linux/kernel.h
> +++ b/tools/virtio/linux/kernel.h
> @@ -106,7 +106,8 @@ static inline unsigned long __get_free_page(gfp_t gfp=
)
>  {
>         void *p;
>
> -       posix_memalign(&p, PAGE_SIZE, PAGE_SIZE);
> +       if (posix_memalign(&p, PAGE_SIZE, PAGE_SIZE))
> +               return 0;
>         return (unsigned long)p;
>  }
>
> diff --git a/tools/virtio/vhost_net_test.c b/tools/virtio/vhost_net_test.=
c
> index 566e15420bb65..3122ea0970568 100644
> --- a/tools/virtio/vhost_net_test.c
> +++ b/tools/virtio/vhost_net_test.c
> @@ -197,7 +197,7 @@ static void vq_info_add(struct vdev_info *dev, int id=
x, int num, int fd)
>         info->idx =3D idx;
>         info->kick =3D eventfd(0, EFD_NONBLOCK);
>         r =3D posix_memalign(&info->ring, 4096, vring_size(num, 4096));
> -       assert(r >=3D 0);
> +       assert(!r);
>         vq_reset(info, num, &dev->vdev);
>         vhost_vq_setup(dev, info);
>
> diff --git a/tools/virtio/virtio_test.c b/tools/virtio/virtio_test.c
> index 028f54e6854a8..9d61463f6e09b 100644
> --- a/tools/virtio/virtio_test.c
> +++ b/tools/virtio/virtio_test.c
> @@ -116,7 +116,7 @@ static void vq_info_add(struct vdev_info *dev, int nu=
m)
>         info->kick =3D eventfd(0, EFD_NONBLOCK);
>         info->call =3D eventfd(0, EFD_NONBLOCK);
>         r =3D posix_memalign(&info->ring, 4096, vring_size(num, 4096));
> -       assert(r >=3D 0);
> +       assert(!r);
>         vq_reset(info, num, &dev->vdev);
>         vhost_vq_setup(dev, info);
>         dev->fds[info->idx].fd =3D info->call;
> --
> 2.47.3
>
>

