Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 620E525A355
	for <virtualization@lists.linux.dev>; Thu,  9 Oct 2025 05:38:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759988303; cv=none; b=sT1lUgfMqJBl+4+KLZR7Ib9VFwUCe5RTMrxJFTKVugJQTJgl3USLN/ZN/YGYb0fDx7n3hGYcw/v8ZgbLiwGZRy7+Yc1ddNp87moMDlEpadbfCw9anqg/Sn/ISlJnKWWH6siWOUG+3QoiRVSoupZgWGqGRQxUMeE/6U2jtkvO1aU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759988303; c=relaxed/simple;
	bh=xJjynxUyu/EH6gdZjZpUbNxIfveXGxgSA+7Tcn6hZNc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=SkfHRewppYsyw4kcKOWHlrwll6bnNyatVsifUI/BoORTche0eYEIgjn2gxmugzarbYKk31IVQGYTUEW19glCPpWn8ESko+g0UQPMaT7mW8JFWt4YZC36Ku/lq6lX24wR70SQrROJX+CWY/9mDO/v9avOXwE1eYj8LlWTfGfrmHg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=dkzeH1cY; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="dkzeH1cY"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1759988300;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=eWTa/TuKH4Av9RX0s6HhLEo/QEtIUV4RKh28VuFqaMs=;
	b=dkzeH1cYreKx7TbEWR7h3PwSJeskKkclpJDx7B1Obvv7mPKDOdYOI25NGjAsVYGxdqHHuR
	jebkOHbVj4YLHOu55sRkLnzJRHhia6yuVc090rIcN5+Ml1Lwv2bN9RhRmhAHIkaqlwssMK
	qF6MfWyL9MLhvUzEmW/NjeAbS9Ywd2Q=
Received: from mail-pg1-f200.google.com (mail-pg1-f200.google.com
 [209.85.215.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-622-OfHIZiqHOcOErV12AnzDmg-1; Thu, 09 Oct 2025 01:38:18 -0400
X-MC-Unique: OfHIZiqHOcOErV12AnzDmg-1
X-Mimecast-MFC-AGG-ID: OfHIZiqHOcOErV12AnzDmg_1759988298
Received: by mail-pg1-f200.google.com with SMTP id 41be03b00d2f7-b62ebb4e7c7so783235a12.3
        for <virtualization@lists.linux.dev>; Wed, 08 Oct 2025 22:38:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759988297; x=1760593097;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=eWTa/TuKH4Av9RX0s6HhLEo/QEtIUV4RKh28VuFqaMs=;
        b=aULmN8OsT3xkyUhUqKU7W+8H8Hn2pMvzl3YbuuyvX0sLA+LKuFNzxqVPDIRnlGbo45
         eAlNTtal3dnterfaCokMGBU//rwjXpfdIW5/yMCpmsiEOZxlQ4Io95ooz2g1r0mUUKSn
         5NBl3DrtQV3Cwus5Oh9XSoc4/s08cF4wRxZ72FOrmPUP34eEhU+IirMzPShFl4Zt2CqM
         aCDuvgeBJA4qvUCjKscE70qAYPP8egWjLrMlQD8jp2kd3gLLRfdwoLsbxTBzY9zzdbiy
         JVSSXtmyUzdRVkDWNrE3VCVhYTd67IOWW0YqGATxnjOMLebz3AydyBEb2FIz4r5/Ts6m
         y83Q==
X-Forwarded-Encrypted: i=1; AJvYcCUPxrbOoLG57npDKU2yEoWVdsKOaT5F1yIepWgjo1DZ+DKlNtgs/d8i0HFDdUJZ951H2H3KBHrYbn+DTXvOLA==@lists.linux.dev
X-Gm-Message-State: AOJu0Yxu4lCLt9HoXe+61ge5+5lg1QbPNsfZQHxxxz9RQ4OZCPZYTDIE
	yNnLiLLZPYOmPCmuGgOKFlchC1W/fPMpj8PFu5gVcmU8dc89ymNJrZ/asX5UVEd7XJE0jcty4cp
	JBc5BqXZmt05S6LXCgMmiY5byjrUeg51Ed6/R9gf9eAfx2tONwPSHo5Hb0Lbv3zgQI7aulFvtnE
	X0TbWT8hoWEuAgwmaPvmApiEiL1J8hzbnSY2feOBVZkqo=
X-Gm-Gg: ASbGncuhr+5oyIOXYMyz+qgbKO4DwLlqZcM7xi07eyghj/3btUi9w3Sz8SR1Twl13NN
	d/2L3JJnYkN4pABnLa8WHDoUfan++j49JV/YjFQqjnWTctFgo1g3Wk2yGXflo4g1GgHfEEcqMrC
	dYZKE1jQCvlv1uymdQ6NMqZzoWrdU=
X-Received: by 2002:a05:6a21:e081:b0:2d3:8d14:7fad with SMTP id adf61e73a8af0-32da814fd31mr7953247637.27.1759988297621;
        Wed, 08 Oct 2025 22:38:17 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF/+jT86H6pFu5z2IW0huX/mcSDC4LtmUAbOMb6joX2RFToDjfDTugADgLQsNq+Cc9wybU4k9PQ7wRVrcDmTQU=
X-Received: by 2002:a05:6a21:e081:b0:2d3:8d14:7fad with SMTP id
 adf61e73a8af0-32da814fd31mr7953208637.27.1759988297157; Wed, 08 Oct 2025
 22:38:17 -0700 (PDT)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20251005181232.3320977-1-alok.a.tiwari@oracle.com>
In-Reply-To: <20251005181232.3320977-1-alok.a.tiwari@oracle.com>
From: Jason Wang <jasowang@redhat.com>
Date: Thu, 9 Oct 2025 13:38:05 +0800
X-Gm-Features: AS18NWC3EQFtQ3ql8i-tEQy41dxRQwOdJk9C0vzba7wnIt93KviO7yYi2ydIbX0
Message-ID: <CACGkMEux7-Xe3PrGpneJ3ynowEjYnEjxB5f+OV9RWvS-aRfy0w@mail.gmail.com>
Subject: Re: [PATCH v2] virtio_vdpa: fix misleading return in void function
To: Alok Tiwari <alok.a.tiwari@oracle.com>
Cc: eperezma@redhat.com, mst@redhat.com, xuanzhuo@linux.alibaba.com, 
	virtualization@lists.linux.dev, linux-kernel@vger.kernel.org
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: 7_d-_tUKSBhilkdSeZJu6AnpxF_QsKx5fWC2sGS7KVw_1759988298
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 6, 2025 at 2:12=E2=80=AFAM Alok Tiwari <alok.a.tiwari@oracle.co=
m> wrote:
>
> virtio_vdpa_set_status() is declared as returning void, but it used
> "return vdpa_set_status()" Since vdpa_set_status() also returns
> void, the return statement is unnecessary and misleading.
> Remove it.
>
> Fixes: c043b4a8cf3b ("virtio: introduce a vDPA based transport")
> Signed-off-by: Alok Tiwari <alok.a.tiwari@oracle.com>
> ---
> v1 -> v2
> added fixes tag
> ---
>  drivers/virtio/virtio_vdpa.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/virtio/virtio_vdpa.c b/drivers/virtio/virtio_vdpa.c
> index 657b07a60788..1abecaf76465 100644
> --- a/drivers/virtio/virtio_vdpa.c
> +++ b/drivers/virtio/virtio_vdpa.c
> @@ -80,7 +80,7 @@ static void virtio_vdpa_set_status(struct virtio_device=
 *vdev, u8 status)
>  {
>         struct vdpa_device *vdpa =3D vd_get_vdpa(vdev);
>
> -       return vdpa_set_status(vdpa, status);
> +       vdpa_set_status(vdpa, status);
>  }
>
>  static void virtio_vdpa_reset(struct virtio_device *vdev)
> --
> 2.50.1
>

Acked-by: Jason Wang <jasowang@redhat.com>

Thanks

