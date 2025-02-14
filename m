Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79B0A222599
	for <virtualization@lists.linux.dev>; Fri, 14 Feb 2025 08:28:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739521742; cv=none; b=FNZ1S45t6rR7I0Na9r+z8nk+Z8XtV/qcqjDYR5sZsSRaKSVLvZC/e3k5VVc8CVv477DKQgn2B/Qp1iX/j/Dmg+YE3z4Azs7hfJqwLFI2Xm6nGkBn9pLbR5xuKQwmrXJ/x2FF6xqpzppuQt+AVKCs67STiksS6lwc4b/2CIFX5TQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739521742; c=relaxed/simple;
	bh=hyQ5NmIfMrko1VRElwCCNAtVPuygcPt45xxVrsnv/ko=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=sThKjo6tKoiOnjlBk0tFfwhBYcQ/lMaXk9MIQe0WnamDN/IZZodE77zNgS4SjJtSQcz36aEp/11O0nAoEFbs+WPIdFLh3JSFejXRHacBQpKetqdZiYVqwOFceWGrFaHM/xhJ+RncKZ2Ri5NyZGK94aSKrT9WSxohEwIDzMfywcQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=aqHgxKSQ; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="aqHgxKSQ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1739521738;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=0WVztTJxSqWk8M5Ig8djlDAnjEtV6dMcd76ytcJcnFc=;
	b=aqHgxKSQQz2pBThYkrbYraJ+i9poOl74oBx2sHOjNaZxqEAaFJEhZCkLkUr14h5fn71aaW
	x0b7Ev8d43Ej5oRFoUSg0qEQ6heOK4wsQHNe9Iolm0XSU6959XfAhcZ1h7hboKInOMXkGp
	COe/damNiWhxSHvn7Jo9Qgq2CubEdfo=
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com
 [209.85.214.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-472-uxZZKtFyPgC9TVxXAaQcbA-1; Fri, 14 Feb 2025 03:28:56 -0500
X-MC-Unique: uxZZKtFyPgC9TVxXAaQcbA-1
X-Mimecast-MFC-AGG-ID: uxZZKtFyPgC9TVxXAaQcbA
Received: by mail-pl1-f198.google.com with SMTP id d9443c01a7336-21f6cd48c56so28390185ad.3
        for <virtualization@lists.linux.dev>; Fri, 14 Feb 2025 00:28:56 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739521736; x=1740126536;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0WVztTJxSqWk8M5Ig8djlDAnjEtV6dMcd76ytcJcnFc=;
        b=WcUp9LdhwT5sLWbotwHsK5hJ6SvSpSn/xaXttiMcu+lloOlqPnj8gcy7liNAxi6eqg
         Hrm9dKMEMrk9C7t64SzxA+aj/+5iZb3pOY3XZQbSTpPgaDuNYncpYS3yW4YmZp+DVNmz
         i5YHmZBS39uzkv3I8qNTMmFQOztnklBiU2GdD8UuXybgr8HL2FlIuGTkHCECquNH3TGH
         0cnLDdwVw/aoXGgq7V92cUmIuz0FcjcxqU7Fot+1Hhgmjf9g7vWWkpgwTfeaMfE/KgW/
         uC5RvDTP4JYCrabl0Z89yfpxnBfxj8b1DJsPtZPMN8j+tUhoDiNCBZNXornCcnwLgSih
         xC+w==
X-Gm-Message-State: AOJu0Yx06edoj9XpGeQ8AWcp2QRITbX6M+oBFi3+cMi72PZe+39eZK3i
	JN5GBBLb8wc7lcFd0oeEkUE5rUR6tLBQHrRUBbuXeEZ+7iodVBaBDg/RJ7+H68+PrfqmsM620Dg
	Jv9hEgKHuatHwOHg+fgmAWOB8V69Y40cYXJAPiK92Yal4DX0/i4Piroj82b7ZMyY4DHVuc6PXv7
	KDMoUTemzVkC2FNtS9K1NXFSejJdf+0N4MjNS9X8A=
X-Gm-Gg: ASbGncu6LE087Mo/8G2RFNr7AZo3lJ5EycE7p/TdCHg5k71wk877K1y86QBtrQBNfSm
	3LHhXywdt1o+riCQ21ouwWzKk9J5P4oll+33PtLp++3/HTUbh4xgCYeNb+lir
X-Received: by 2002:a17:902:fc8e:b0:220:cddb:590f with SMTP id d9443c01a7336-220cddb5a5emr100603725ad.50.1739521735778;
        Fri, 14 Feb 2025 00:28:55 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHuBqaubRQaEkDVwIjRrkNmtm9SRsg5dycanztHceooRQ5GB1i/BRbfjGui75fNGjxIdUjFQueIH3/42nMXjoA=
X-Received: by 2002:a17:902:fc8e:b0:220:cddb:590f with SMTP id
 d9443c01a7336-220cddb5a5emr100603455ad.50.1739521735457; Fri, 14 Feb 2025
 00:28:55 -0800 (PST)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20250213161825.139952-1-sgarzare@redhat.com>
In-Reply-To: <20250213161825.139952-1-sgarzare@redhat.com>
From: Eugenio Perez Martin <eperezma@redhat.com>
Date: Fri, 14 Feb 2025 09:28:18 +0100
X-Gm-Features: AWEUYZlR5TQa_mgtH_Q2F6DiI9ahx8UCDTCuZf-LW0E_5NbZxOqPEkv4CzX4XEQ
Message-ID: <CAJaqyWerCoW-yokJnTsnkaCeNFCuemKV+6b+9_7xn6+5H5OHPQ@mail.gmail.com>
Subject: Re: [PATCH] virtio_snd.h: clarify that `controls` depends on VIRTIO_SND_F_CTLS
To: Stefano Garzarella <sgarzare@redhat.com>
Cc: virtualization@lists.linux.dev, 
	Matias Ezequiel Vara Larsen <mvaralar@redhat.com>, linux-sound@vger.kernel.org, 
	Jason Wang <jasowang@redhat.com>, linux-kernel@vger.kernel.org, 
	Anton Yakovlev <anton.yakovlev@opensynergy.com>, Xuan Zhuo <xuanzhuo@linux.alibaba.com>, 
	"Michael S. Tsirkin" <mst@redhat.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: tVCfLIIxsa1azXwwF32FyPSzxg0OeHK8lknLgo-vd8c_1739521736
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 13, 2025 at 5:18=E2=80=AFPM Stefano Garzarella <sgarzare@redhat=
.com> wrote:
>
> As defined in the specification, the `controls` field in the configuratio=
n
> space is only valid/present if VIRTIO_SND_F_CTLS is negotiated.
>
>   From https://docs.oasis-open.org/virtio/virtio/v1.3/virtio-v1.3.html:
>
>   5.14.4 Device Configuration Layout
>     ...
>     controls
>        (driver-read-only) indicates a total number of all available contr=
ol
>        elements if VIRTIO_SND_F_CTLS has been negotiated.
>
> Let's use the same style used in virtio_blk.h to clarify this and to avoi=
d
> confusion as happened in QEMU (see link).
>
> Link: https://gitlab.com/qemu-project/qemu/-/issues/2805
> Signed-off-by: Stefano Garzarella <sgarzare@redhat.com>

Acked-by: Eugenio P=C3=A9rez <eperezma@redhat.com>

> ---
>  include/uapi/linux/virtio_snd.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/include/uapi/linux/virtio_snd.h b/include/uapi/linux/virtio_=
snd.h
> index 5f4100c2cf04..a4cfb9f6561a 100644
> --- a/include/uapi/linux/virtio_snd.h
> +++ b/include/uapi/linux/virtio_snd.h
> @@ -25,7 +25,7 @@ struct virtio_snd_config {
>         __le32 streams;
>         /* # of available channel maps */
>         __le32 chmaps;
> -       /* # of available control elements */
> +       /* # of available control elements (if VIRTIO_SND_F_CTLS) */
>         __le32 controls;
>  };
>
> --
> 2.48.1
>

