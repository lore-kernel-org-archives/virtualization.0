Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36E612FDC42
	for <virtualization@lists.linux.dev>; Mon, 15 Sep 2025 11:00:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757934007; cv=none; b=iQOkQYuJA6LB1jmVuQ0E1Sekvr0A5nzUnWEqjn40SNhUCC8uolLlt0ShsL8j5ys9tn44b/aM4qDXazSiIKkytHZQo29GVXGqgDMsyqFyAHKcy7tJCFMM1ijDf0qIjDUWKJgEvOYuO892jXEyTvlGeYYKSwpnjsdmLKsf4kQaL1U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757934007; c=relaxed/simple;
	bh=MZ2Lk0VILdWqbc27hgBRyrK0F859ToA8uD4l4sEkcHY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=H8/VeHZX8v5E6FpgArnSY5tS1Lw0KaQk78EsQtfQydICgbmZhx9XQSZLAUSAOtA8pU0UaVxEHLuxLvpIv0GzdjkE9qEM8B7NQN+ApWzUFdUnaknP56rdjutBRLX1TdpRuqD4H7QJpnCrtYr86K20HDCeUi4hQx0KLrD6pBOaEtI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=iXmRGYED; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="iXmRGYED"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1757934004;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=8LG/krU4VzCXhXDYZfOJeBrVjlSMl4dB2Tr4WvxEGIU=;
	b=iXmRGYEDVo+R0Xbe3h0VbVvnPRQN7ADHHkVVPNEd+0zYB1HUWHAw7onxovwqaQIGU0dFvs
	4IqI6x30ZaAicQWYiY/Jo+jaYDP4rUUY2ghv75O+WEX/VjXt9VIWO2irapQKwHlboOPmpO
	ENCBF7jrbUODMa3VvFZ4hg8SanLX00U=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-627-plJ5GG19PCCeYfc4rSRt6g-1; Mon, 15 Sep 2025 07:00:02 -0400
X-MC-Unique: plJ5GG19PCCeYfc4rSRt6g-1
X-Mimecast-MFC-AGG-ID: plJ5GG19PCCeYfc4rSRt6g_1757934002
Received: by mail-ed1-f72.google.com with SMTP id 4fb4d7f45d1cf-62ef8d95301so1632148a12.1
        for <virtualization@lists.linux.dev>; Mon, 15 Sep 2025 04:00:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757934002; x=1758538802;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8LG/krU4VzCXhXDYZfOJeBrVjlSMl4dB2Tr4WvxEGIU=;
        b=BTl9dPgivfWmkCn4dCxHQrFNxHGYjTMbJLFa6WRyUX0bF6vwJN9d4OO/5qyzIeZXCT
         LaygG/vEjwVg9GxqnGLlnzk5G//xd5FAUrA2VKqOEWb6uavEpgdo6mp+huPY4YiflVT9
         ELekxWBHLzp5HzBCJKb+Qjd3GyrLH0tqHeSwSQxMlrsrEEANP0riWqBZOyx4dMfRUI62
         aWsRl8lSyzGv6hisrMd4fZmPjfLq8T4RKqToTrUQdTXoI4cJTEIWrzTDGTTJcSf7tKLk
         EllHIpNUuDnE3e490+Sw5zn2N1SznwqdkPX2mRJsO/zMuTDvLJunsF8bAMNOvMNpMVln
         URgA==
X-Forwarded-Encrypted: i=1; AJvYcCUzEOS/ioY5CBY8SwgqVwDcDK/iBS5njGt+ywssWi77Z4xeTAkmgcVz2bd7min5066vtPX6Tr9E2OSlN8UyiQ==@lists.linux.dev
X-Gm-Message-State: AOJu0Ywugab/95+pEEENz+k7lYlBajDwp7OOGb6HprX6GUa4uBE8g7xU
	bLzal8pFXfd8P0CO1WrKS1ViPIiBjiEWA0zCrLF4d/A3ycOZB4PRkbDPjM0r+mx08rdqGQ6+yaY
	i6gA6Gw4GEAhj4rC435bcaHXWvpCerdeelQy6gVlIXTnFthCRl3prbS0LShiZBYcR+LvywHoaqm
	kajGdKP9+/ZNyTn8KXbXtWnXfhz7wJryEnZMfctBioJ5Q=
X-Gm-Gg: ASbGnctMm0phvn6pZa/lliBa1XKCZNDJJ5NDbr/sC4qnFuGegUG1q4GJ6pIhb+jdb24
	AU8l+ZLsomPFan91V9auB8QAXcCJMMDgASgb+QlQZAJXj1efNn5NtnbYD+qB3eQqNP3aF/+3uu3
	5iRjIh8VPBktLZR4QFYLO/dg==
X-Received: by 2002:a05:6402:52c3:b0:61c:7090:c7de with SMTP id 4fb4d7f45d1cf-62ed827180amr11199640a12.13.1757934001649;
        Mon, 15 Sep 2025 04:00:01 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH0FWS9+V2U6bS/hOunbJ92IvHyg28KU7vhAZPMSgU3NL7FZESOiBEKSGMh/3whVebsghh7ajGMdMYOU7jOcHY=
X-Received: by 2002:a05:6402:52c3:b0:61c:7090:c7de with SMTP id
 4fb4d7f45d1cf-62ed827180amr11199617a12.13.1757934001266; Mon, 15 Sep 2025
 04:00:01 -0700 (PDT)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20250910091739.2999-1-zhangjiao2@cmss.chinamobile.com>
In-Reply-To: <20250910091739.2999-1-zhangjiao2@cmss.chinamobile.com>
From: Lei Yang <leiyang@redhat.com>
Date: Mon, 15 Sep 2025 18:59:24 +0800
X-Gm-Features: AS18NWCQ7fEFMgYdBUr25gcH_J-F5Mf8bPzgSCwAQZlFId0nTXghskAr0ksqVWA
Message-ID: <CAPpAL=wGgYsEcvR5Vy7F-FdnArbOu6VNy4Y_Syc=9qDM9P-VRQ@mail.gmail.com>
Subject: Re: [PATCH] vhost: vringh: Modify the return value check
To: zhangjiao2 <zhangjiao2@cmss.chinamobile.com>
Cc: mst@redhat.com, jasowang@redhat.com, eperezma@redhat.com, 
	kvm@vger.kernel.org, virtualization@lists.linux.dev, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: 1TBBiDND5W9fgxFIqtZxAjmT5GeQzjTnyuDG_7sbiLs_1757934002
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Tested this patch with virtio-net regression tests, everything works fine.

Tested-by: Lei Yang <leiyang@redhat.com>

On Wed, Sep 10, 2025 at 5:18=E2=80=AFPM zhangjiao2
<zhangjiao2@cmss.chinamobile.com> wrote:
>
> From: zhang jiao <zhangjiao2@cmss.chinamobile.com>
>
> The return value of copy_from_iter and copy_to_iter can't be negative,
> check whether the copied lengths are equal.
>
> Signed-off-by: zhang jiao <zhangjiao2@cmss.chinamobile.com>
> ---
>  drivers/vhost/vringh.c | 7 ++++---
>  1 file changed, 4 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/vhost/vringh.c b/drivers/vhost/vringh.c
> index 9f27c3f6091b..0c8a17cbb22e 100644
> --- a/drivers/vhost/vringh.c
> +++ b/drivers/vhost/vringh.c
> @@ -1115,6 +1115,7 @@ static inline int copy_from_iotlb(const struct vrin=
gh *vrh, void *dst,
>                 struct iov_iter iter;
>                 u64 translated;
>                 int ret;
> +               size_t size;
>
>                 ret =3D iotlb_translate(vrh, (u64)(uintptr_t)src,
>                                       len - total_translated, &translated=
,
> @@ -1132,9 +1133,9 @@ static inline int copy_from_iotlb(const struct vrin=
gh *vrh, void *dst,
>                                       translated);
>                 }
>
> -               ret =3D copy_from_iter(dst, translated, &iter);
> -               if (ret < 0)
> -                       return ret;
> +               size =3D copy_from_iter(dst, translated, &iter);
> +               if (size !=3D translated)
> +                       return -EFAULT;
>
>                 src +=3D translated;
>                 dst +=3D translated;
> --
> 2.33.0
>
>
>
>

