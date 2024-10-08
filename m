Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C913182C5
	for <virtualization@lists.linux-foundation.org>; Tue,  8 Oct 2024 02:15:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.138
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728353719; cv=none; b=k9nJksVpcbxms/Ks7ThodTRM/D40WoAKCuIcsSFnOyiiaJpj5VmgXxysJSdqFVCdhFYZ+yaSAQh8MmfdMCbQrW2DAD1QDIKF1/rPdAozrMiIJzLbX4ncoj2UUyjzq1Zs439gPYsgBrPBKm6iaj7tqst/YuViZxxs7F+jZBwbMyg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728353719; c=relaxed/simple;
	bh=vsZQK+8MtGo/bpXC5EnzfEllcfJ1/Dm6odiVEfnznGM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=f67WQlGpCilpy+ACoQoF0aREFT+1LYDwW5Xr75zYjA3vxB7qyYO9JVdp+JNye2dphfMR8Syo5ArBAbTrZF4gpI7IaXO35WxBwDaIgmPopHtpbHJyyjbzgvT3UymGiIH8dyPwpHKooBpIzxj/oemZAOvAYC4/ObwA4B3WOznFwVE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=h0oadvcq; arc=none smtp.client-ip=140.211.166.138
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="h0oadvcq"
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id DDF1C80D93
	for <virtualization@lists.linux-foundation.org>; Tue,  8 Oct 2024 02:15:16 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -2.101
X-Spam-Level:
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id kMnV3dOROM6K for <virtualization@lists.linux-foundation.org>;
 Tue,  8 Oct 2024 02:15:16 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2a00:1450:4864:20::52c; helo=mail-ed1-x52c.google.com; envelope-from=dverkamp@chromium.org; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp1.osuosl.org 9F5CF80D91
Authentication-Results: smtp1.osuosl.org; dmarc=pass (p=none dis=none) header.from=chromium.org
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 9F5CF80D91
Authentication-Results: smtp1.osuosl.org;
	dkim=pass (1024-bit key, unprotected) header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256 header.s=google header.b=h0oadvcq
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com [IPv6:2a00:1450:4864:20::52c])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 9F5CF80D91
	for <virtualization@lists.linux-foundation.org>; Tue,  8 Oct 2024 02:15:15 +0000 (UTC)
Received: by mail-ed1-x52c.google.com with SMTP id 4fb4d7f45d1cf-5c885108582so783860a12.3
        for <virtualization@lists.linux-foundation.org>; Mon, 07 Oct 2024 19:15:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1728353713; x=1728958513; darn=lists.linux-foundation.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RekqTme8wdJ4AVUTH9HdSV0fpbAq2HmemVWIdGYXdHc=;
        b=h0oadvcqr4lj5H6tT4oXQOwBaFnrG1rT9hghN+aLlILv6ZJfOjD3MJ2g96Qj9MYW3B
         PLRrM13b8CVW0V8BR9B5G3RiExprThkrUMgkvVl/mDr6k+jFFMuoGp291EeEXYI+bUaZ
         8C01mk7sjg0C66+7qyOOW33UOoYCxg0wxyMFU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728353713; x=1728958513;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RekqTme8wdJ4AVUTH9HdSV0fpbAq2HmemVWIdGYXdHc=;
        b=GnBKaTCCe4RzGYpO71QrIIgsZVMlwI5ZpNt8h1lnj3N6Y7cJSK1b4kT0P5kSkNmnrW
         rofhOAX9e9WB49pdohEuzk+yaKL5AN4QsXdviXD8GpQnpN4B7xpCHB6eniL+j7HiLFNb
         2CyqrgsLQq1AkFHpac9akhmjVVPzkk3CDMioMKPeG+cAojKte1oXYhWx9PsVOPvMT27A
         0KNMinqPTd166ZMKYxJwTzT67QYm8UA2GlkD6RR8tpvwhN5XazpuqhjfAmslp1aJ7CC+
         FTaowpoQWhlB9egZXmTz6zXoi9ITBR73AvOy82yfid7xX30U5R1v8vTy5+kdbNrOhhyO
         hZiA==
X-Forwarded-Encrypted: i=1; AJvYcCWuZWcV444SCODcPwLSXrZt1hhaUNpw87uy6DYURqdlKt9CmGbhPNTfufyq8eaS3+cXgRXZsMZ9uizj0Fk6TA==@lists.linux-foundation.org
X-Gm-Message-State: AOJu0YywVGTn+Dgi0OwWFJSbnI8OLgPokQVPcTBvGV9N7Hfr68ovxliA
	q5uXcMcYJopG+MSMcKP6hZ0m0fKDSEQFbagR7zKsGDPVs1bZnjlyJBzqWFcUKM9WFrNYNyaKO3U
	=
X-Google-Smtp-Source: AGHT+IFVBQKr8FXqS0ItErUjGD9fDQMQVfa9YYK88nBXBEv+MiJ4xV4m2fjhQMF18mv0e8Z8THHiJQ==
X-Received: by 2002:a17:907:787:b0:a80:ed7e:8468 with SMTP id a640c23a62f3a-a991ba97711mr629238266b.0.1728353713231;
        Mon, 07 Oct 2024 19:15:13 -0700 (PDT)
Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com. [209.85.218.41])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a994062660csm364090766b.21.2024.10.07.19.15.11
        for <virtualization@lists.linux-foundation.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 07 Oct 2024 19:15:11 -0700 (PDT)
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-a9944c4d5d4so275368366b.0
        for <virtualization@lists.linux-foundation.org>; Mon, 07 Oct 2024 19:15:11 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCVxajnjVfbopsIm+HjUWrS2jwtcSoeqKhCtU0yVLsoFNh0dl02ulL/uCA+d86l12+OvtIajnh8PQlmy8PRYyg==@lists.linux-foundation.org
X-Received: by 2002:a17:907:7fa6:b0:a99:61d1:34a2 with SMTP id
 a640c23a62f3a-a9961d14dbcmr257684466b.37.1728353710341; Mon, 07 Oct 2024
 19:15:10 -0700 (PDT)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20241006165609.34953-1-mgurtovoy@nvidia.com>
In-Reply-To: <20241006165609.34953-1-mgurtovoy@nvidia.com>
From: Daniel Verkamp <dverkamp@chromium.org>
Date: Mon, 7 Oct 2024 19:14:44 -0700
X-Gmail-Original-Message-ID: <CABVzXAkVOV-nYno+oi_KJhaD1cCZMNo6FtoPdHPfUauvnaAw7w@mail.gmail.com>
Message-ID: <CABVzXAkVOV-nYno+oi_KJhaD1cCZMNo6FtoPdHPfUauvnaAw7w@mail.gmail.com>
Subject: Re: [PATCH v2 1/1] virtio-blk: Add description for blk_size field
To: Max Gurtovoy <mgurtovoy@nvidia.com>
Cc: mst@redhat.com, virtualization@lists.linux-foundation.org, 
	stefanha@redhat.com, virtio-dev@lists.linux.dev, oren@nvidia.com, 
	parav@nvidia.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Oct 6, 2024 at 9:56=E2=80=AFAM Max Gurtovoy <mgurtovoy@nvidia.com> =
wrote:
>
> This field is only valid when the VIRTIO_BLK_F_BLK_SIZE feature bit is
> offered by the device.
>
> The blk_size field actually represents the logical block size of the
> device. It is always a power of two and typically ranges from 512 bytes
> to larger values such as 4 KB.
>
> Add description for this field to provide clarity on its constraints.
>
> Signed-off-by: Max Gurtovoy <mgurtovoy@nvidia.com>
> ---
>
> changes from V1:
>  - Addressed Stefan's and Daniel's comments:
>        1. use SHOULD instead of MUST
>        2. Add a note that devices may return IOERR upon misaligned IO
>  - Add a note that devices may return IOERR if IO size is not following
>    the block size granularity.
> ---
>  device-types/blk/description.tex | 34 ++++++++++++++++++++++++++++++++
>  1 file changed, 34 insertions(+)
>
> diff --git a/device-types/blk/description.tex b/device-types/blk/descript=
ion.tex
> index 2712ada..77eed80 100644
> --- a/device-types/blk/description.tex
> +++ b/device-types/blk/description.tex
> @@ -135,6 +135,9 @@ \subsection{Device configuration layout}\label{sec:De=
vice Types / Block Device /
>  present. The availability of the others all depend on various feature
>  bits as indicated above.
>
> +The field \field{blk_size} exists only if VIRTIO_BLK_F_BLK_SIZE is offer=
ed by the device.
> +This field reports the block size of the device, expressed in bytes.
> +
>  The field \field{num_queues} only exists if VIRTIO_BLK_F_MQ is set. This=
 field specifies
>  the number of queues.
>
> @@ -282,6 +285,13 @@ \subsection{Device Initialization}\label{sec:Device =
Types / Block Device / Devic
>
>  \drivernormative{\subsubsection}{Device Initialization}{Device Types / B=
lock Device / Device Initialization}
>
> +Drivers SHOULD negotiate VIRTIO_BLK_F_BLK_SIZE if the feature is offered=
 by the
> +device. When negotiated, drivers SHOULD interpret the \field{blk_size} a=
s the
> +logical block size.
> +
> +If the VIRTIO_BLK_F_BLK_SIZE feature is not offered by the device, then =
drivers
> +MAY assume that the logical block size is 512 bytes.
> +
>  Drivers SHOULD NOT negotiate VIRTIO_BLK_F_FLUSH if they are incapable of
>  sending VIRTIO_BLK_T_FLUSH commands.
>
> @@ -319,6 +329,10 @@ \subsection{Device Initialization}\label{sec:Device =
Types / Block Device / Devic
>
>  \devicenormative{\subsubsection}{Device Initialization}{Device Types / B=
lock Device / Device Initialization}
>
> +Devices SHOULD always offer VIRTIO_BLK_F_BLK_SIZE feature. When this fea=
ture is
> +offered, devices MUST initialize \field{blk_size} to a power of two grea=
ter
> +than or equal to 512.
> +
>  Devices SHOULD always offer VIRTIO_BLK_F_FLUSH, and MUST offer it
>  if they offer VIRTIO_BLK_F_CONFIG_WCE.
>
> @@ -879,6 +893,14 @@ \subsection{Device Operation}\label{sec:Device Types=
 / Block Device / Device Ope
>  The length of \field{data} MUST be a multiple of 512 bytes for VIRTIO_BL=
K_T_IN
>  and VIRTIO_BLK_T_OUT requests.
>
> +The length of \field{data} SHOULD be a multiple of \field{blk_size} for =
VIRTIO_BLK_T_IN
> +and VIRTIO_BLK_T_OUT requests, when the VIRTIO_BLK_F_BLK_SIZE feature ha=
s been
> +offered by the device.
> +
> +The value of \field{sector} (multiplied by 512) SHOULD be aligned with
> +\field{blk_size} for VIRTIO_BLK_T_IN and VIRTIO_BLK_T_OUT requests, when=
 the
> +VIRTIO_BLK_F_BLK_SIZE feature has been offered by the device.

Instead of "aligned", perhaps "SHOULD be a multiple of
\field{blk_size}" to be consistent with existing spec wording like
"MUST be a multiple of 512 bytes".

>  The length of \field{data} MUST be a multiple of the size of struct
>  virtio_blk_discard_write_zeroes for VIRTIO_BLK_T_DISCARD,
>  VIRTIO_BLK_T_SECURE_ERASE and VIRTIO_BLK_T_WRITE_ZEROES requests.
> @@ -966,6 +988,18 @@ \subsection{Device Operation}\label{sec:Device Types=
 / Block Device / Device Ope
>  for a write request if the VIRTIO_BLK_F_RO feature if offered, and MUST =
NOT
>  write any data.
>
> +A device MAY set the \field{status} to VIRTIO_BLK_S_IOERR for
> +VIRTIO_BLK_T_IN or VIRTIO_BLK_T_OUT requests if the requested
> +\field{sector} (multiplied by 512) is not aligned with the device's
> +\field{blk_size}, when the VIRTIO_BLK_F_BLK_SIZE feature has been offere=
d by
> +the device.
> +
> +A device MAY set the \field{status} to VIRTIO_BLK_S_IOERR for
> +VIRTIO_BLK_T_IN or VIRTIO_BLK_T_OUT requests if the length of the
> +requested \field{data} is not an integer multiple of the device's
> +\field{blk_size}, when the VIRTIO_BLK_F_BLK_SIZE feature has been offere=
d by
> +the device.
> +
>  The device MUST set the \field{status} byte to VIRTIO_BLK_S_UNSUPP for
>  discard, secure erase and write zeroes commands if any unknown flag is s=
et.
>  Furthermore, the device MUST set the \field{status} byte to
> --
> 2.18.1
>

This all looks reasonable to me, so Reviewed-by: Daniel Verkamp
<dverkamp@chromium.org> if you'd like.

One other thought: if a device truly can't handle misaligned I/O
requests, it could also choose to fail at feature negotiation time if
it offers VIRTIO_BLK_F_BLK_SIZE and the driver does not accept it. I
am not sure this is in the spirit of the existing general section
"Device Requirements: Feature Bits" (it says "any valid subset of
features", but maybe your device would consider not negotiating
VIRTIO_BLK_F_BLK_SIZE to be an invalid subset of features?)

Thanks,
-- Daniel
