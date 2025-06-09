Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 353BC17BA9
	for <virtualization@lists.linux.dev>; Mon,  9 Jun 2025 01:41:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749433285; cv=none; b=C7F5fXRZn15C6+YCtjAYKg2oU9U1jzJMfm9j6Moo8mAE8d6HI2i9pbbA9Qs0vuSHWiukTSTUmeK/9KYHmMntCNsfd5Ak211lr6fz2x3rnINLuNX1N6F4NaY2o7UWxYNQGNqvBGUCy3CbO3yJWZK7a+XYCZzemrfNpo7RxG79JVg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749433285; c=relaxed/simple;
	bh=hej6cxyFs+C7L664xb6ANQmQk5M7wHwxWDKSIemdnnk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=JpKbrLq1C+pzYnrVszoXTQJLCbnaoWQ+JbJuYQ/ykWNZX0AqF1aAui+Y39BKroPrPbV0g2uKv8W40CrJTuP1A12pSrz3aM/HQ8pCInFtloq5NQitGZJKacFoa3Yqs10TdlLkuJ/deqtKvKsrY5EMqAsd2hdKQPqOHmVQ77BaixQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=aNF/P9Ga; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="aNF/P9Ga"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1749433282;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=7lofrGKgIf3f6wW1zlnvc/h/o97h/a3X8RkvsJpwFaU=;
	b=aNF/P9GaS/MqdNFIcqx8obAykqUhrIuamewUGsKbm67EJkobmvIm8/y0vuKwH/3Bi40BbU
	8zE7VwUc7hnGsBXQY+OAT42ZCdrGbZLx2ldEvTEDnjZ/CWd7xFxJw1/qTpSIZ5dS3NkW82
	xNm77rJkc2ooDymn3oglzVX7BlIxmiE=
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com
 [209.85.214.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-558-bBdr3CWcNW6LeKpHLoaPLA-1; Sun, 08 Jun 2025 21:41:20 -0400
X-MC-Unique: bBdr3CWcNW6LeKpHLoaPLA-1
X-Mimecast-MFC-AGG-ID: bBdr3CWcNW6LeKpHLoaPLA_1749433280
Received: by mail-pl1-f199.google.com with SMTP id d9443c01a7336-235c897d378so35257785ad.1
        for <virtualization@lists.linux.dev>; Sun, 08 Jun 2025 18:41:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749433280; x=1750038080;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7lofrGKgIf3f6wW1zlnvc/h/o97h/a3X8RkvsJpwFaU=;
        b=CiBEAYZPk5sKyNzrC2tQ48lPT+2EaYJ723FZ692L8he6TRb8A6GqDuE5Fehd1S7BuH
         0RwYP6C2gWLAd1vEqqehTO+RAwC1twtThLfPD8GuLRKiYSv+9RIQhDpchJtjof4Ds9Rv
         xg4gtr4zfqMbzp8rsp+9zMoe4g17XH8Pa7ocCSIA2XpZIe95jRmzO/55wVNjbp4ixLin
         UJGgrzIG2ehnNi2VO04d+XxX669Vh1Kp6Yf4SQ6Cv8ThOjCJ6M0lvo7GQYiCdF0WHZiL
         ieqcZw8cJhYYf4YrukphXaG+lhZpARUZPt0RqunjMT0pNqtaa13LPf+6Pcp0Kx9hATxg
         mnpg==
X-Forwarded-Encrypted: i=1; AJvYcCWjPOWEa0J46mD3RNtzege7pdUJd5vbdLwmH74gwfNtNYPlt0V7Imf+I5ICAkwR7y8MIP8ucCwyJRah9GMR8Q==@lists.linux.dev
X-Gm-Message-State: AOJu0YwgHGoK0BM0z0pxMWpc+KMSgDpo8yuNmfPH3brAbI0Y9M8fAZtq
	wPdWcmsMGniQjKiGDL4rzID0Qg/3NbykJVQdlCwaasTq9PDYfkYwmy/aJvObq270fjNIp5wPNCg
	bkllT0fBvWBZ1PkQNuMdQf4kSMsyQaPWr3KEdfU0aeVxdDPGffitbEk7DzsjcV71II9btrzv53R
	3/BzD9jQrj85k9ITrzOOCvcUxqP2Y3Y3VPwjDglhjfvxg=
X-Gm-Gg: ASbGncv9M5Q6DxCgecAx18J6g+XVdn2RriqC40NZ1Tzb9wX1PXEWoZBbRzvsWZGhTi7
	i5zSzUj9ZeYszYMHK6YG2z3jPaES39hZUsbwjK4knIYQ6dYn67HaMsJS8xTN8H/IgV0DRMk31QM
	6IbVY=
X-Received: by 2002:a17:903:18f:b0:223:4d7e:e52c with SMTP id d9443c01a7336-23601e21f1dmr165873605ad.5.1749433279870;
        Sun, 08 Jun 2025 18:41:19 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFHlKs2ojAmTxWBYs9SkoDYKoNfRXREC8v8QVqcWcXoYxdrrpZxtxnkDAVGmRSIrSysdiJuHsbWlub+a5zvDOU=
X-Received: by 2002:a17:903:18f:b0:223:4d7e:e52c with SMTP id
 d9443c01a7336-23601e21f1dmr165873425ad.5.1749433279524; Sun, 08 Jun 2025
 18:41:19 -0700 (PDT)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20250606115012.1331551-1-eperezma@redhat.com> <20250606115012.1331551-2-eperezma@redhat.com>
In-Reply-To: <20250606115012.1331551-2-eperezma@redhat.com>
From: Jason Wang <jasowang@redhat.com>
Date: Mon, 9 Jun 2025 09:41:08 +0800
X-Gm-Features: AX0GCFuohxh2ELb-a6MSM6UQ7eR4Le-eCUhd0Btq7qRcTNbff4xXZwicgMFihYY
Message-ID: <CACGkMEsw2taXgW11na2CFK6W03c=x=wMn3iwNZPypgPkeSU06Q@mail.gmail.com>
Subject: Re: [RFC 1/6] vduse: add v1 API definition
To: =?UTF-8?Q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>
Cc: Yongji Xie <xieyongji@bytedance.com>, Cindy Lu <lulu@redhat.com>, 
	linux-kernel@vger.kernel.org, Stefano Garzarella <sgarzare@redhat.com>, 
	Stefan Hajnoczi <stefanha@redhat.com>, Maxime Coquelin <mcoqueli@redhat.com>, 
	"Michael S. Tsirkin" <mst@redhat.com>, virtualization@lists.linux.dev, 
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>, Laurent Vivier <lvivier@redhat.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: TYJj3cynglx0Eaqsgy6CZ4wHQXrWf69Ax4be1P7O3dA_1749433280
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jun 6, 2025 at 7:50=E2=80=AFPM Eugenio P=C3=A9rez <eperezma@redhat.=
com> wrote:
>
> This allows to define all functions checking the API version set by the
> userland device.
>
> Signed-off-by: Eugenio P=C3=A9rez <eperezma@redhat.com>

It might be worth clarifying how it works.

For example,

1) would VDUSE behave differently or if it's just some new ioctls
2) If VDUSE behave differently, do we need a ioctl to set the API
version for backward compatibility?
3) If it means a brunch of new ioctls, could userspace just probe the
new ioctls instead?

Thanks

> ---
>  include/uapi/linux/vduse.h | 4 ++++
>  1 file changed, 4 insertions(+)
>
> diff --git a/include/uapi/linux/vduse.h b/include/uapi/linux/vduse.h
> index 68a627d04afa..9a56d0416bfe 100644
> --- a/include/uapi/linux/vduse.h
> +++ b/include/uapi/linux/vduse.h
> @@ -10,6 +10,10 @@
>
>  #define VDUSE_API_VERSION      0
>
> +/* VQ groups and ASID support */
> +
> +#define VDUSE_API_VERSION_1    1
> +
>  /*
>   * Get the version of VDUSE API that kernel supported (VDUSE_API_VERSION=
).
>   * This is used for future extension.
> --
> 2.49.0
>

