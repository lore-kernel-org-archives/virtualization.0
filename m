Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D60FD27467F
	for <virtualization@lists.linux.dev>; Mon, 28 Jul 2025 13:53:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753710822; cv=none; b=oRzZh3OI5EUma0YXoycOJTVHkqMtSstGcYlG8uTa1oSuMqgXy4NLLGvADg0HiLCL5UsNX4he+AX57LlM7e2WeTXWysERYsKZdirbJcxUzYseIN8shja55hoNQQdRIxtlhEk4Fitk9G/jJoD4oxlrDGH1i4PyAfhXuOZycVdKYfw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753710822; c=relaxed/simple;
	bh=wO5MkzKnmDxME7oV7jJByiixZLh6mmGt5hOuvee11Xo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=g0kub84NjlrJP2wSWzwLvlqxm1gSY5qzQYqFoZfJtK2CfgapORVnzg0ENJuR7g0DVWLbwR03wsiAd8trdNlJ1ibAkAjEHEcD0+96TpykoHHyvuO9Qki8p6Lb3Gub5AQWPOUsXn7M2iekfwcuAkIivP4Djyi1TK2jWHdg1H5cdys=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ccujLB+1; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ccujLB+1"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1753710819;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Er477g45o8/lpdbteZ5w8I840mY3VPuqyHAAQDim4vM=;
	b=ccujLB+1K4g2iHlTvLcfmuT7vPRyIn+w2/7RA6yj4Ayyi8ulFAh190DmBSTpzmXobWEPOP
	W6W50nMICZXRIbv9KL2Rb6X/n2WeHHv4SkM5jA41Sp3xFdYUjWIHWX74DZy9SvbyXp4prc
	+q7bHfBIjG9VG8JasGXC4/6ftJS+CVk=
Received: from mail-pg1-f198.google.com (mail-pg1-f198.google.com
 [209.85.215.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-471-M9iZOyK6POulvJ5tHXDPMg-1; Mon, 28 Jul 2025 09:53:38 -0400
X-MC-Unique: M9iZOyK6POulvJ5tHXDPMg-1
X-Mimecast-MFC-AGG-ID: M9iZOyK6POulvJ5tHXDPMg_1753710817
Received: by mail-pg1-f198.google.com with SMTP id 41be03b00d2f7-b3510c0cfc7so3475886a12.2
        for <virtualization@lists.linux.dev>; Mon, 28 Jul 2025 06:53:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753710817; x=1754315617;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Er477g45o8/lpdbteZ5w8I840mY3VPuqyHAAQDim4vM=;
        b=iiu1pWgm+9OhvL8NDvGznTTurVHJeNwC/zOzFkbJmh5ilT/paOssIpVK38Nd4C8110
         BYzOEu18ENxqaSTkF2TAd/EJa2KUrYtInq5IoIdDtABOXGzG7KC5tfqkWhIqt8lSn+H8
         WaRfGF0yQq3tDyic1pcpannyVkxMjv8GST4lvRhv9AoTWmViOS6a8wi0076OzR9qwNEG
         yWuoqdAYwYBrR6OgoKIgELj5ehrrRXQxA8yEAGxLHnJTKiK7aRLu3tuBRSkDfubsTioc
         qDxBPD0aezZWR7E3EcWDmL0Dm6eIbry5D+P1pbsC2DpUo5TsBuFXkLkh1vuLNNbY6uRu
         DY3Q==
X-Forwarded-Encrypted: i=1; AJvYcCXhL5f38F16Cz/V9CJIrvaP8EPAdTtm20MDEI73sM47AwqbTYDykm8s0B9rhrq4oQXorYpPb7VQAru76xM/DA==@lists.linux.dev
X-Gm-Message-State: AOJu0Ywun1Zc71Ky+DH59KDoeK2hERUOJtDZfurHd1lXFCy8OIOkjwhC
	XhGuiJN2iLX+R1DFUqgrEYGwg9Qc8BZ+67MZibn1KAPh4Pn+wqQnmf0QQQczb1ZAk3MQycoxh0n
	qwSIzlvTv4EkIgqiL3DPVV2kdNuthrHHBmaUVnCyyUvY0ilp4O2MhmIlPdS4Qitbhjjl5hLafx6
	BhPWVrKqtR01fcvHfpMYlPoBbGjLY1iSiRk1HUplS1DXo=
X-Gm-Gg: ASbGncuixIGvPIxXR1Y9Ut6gIZGPZhfxAJSaR8e/88kaD8yJ/P44qJIgbFsU9QAS4yF
	B0pOSmgsjqWSHGSDMOjHxnas6iMAxeJsUsJshVGEm+kAUmj35ivuuILLInQeJrrhqJwJEQVeiR/
	WdzUFCTXf58ISFMo7W62Da
X-Received: by 2002:a17:90b:5488:b0:312:f88d:25f9 with SMTP id 98e67ed59e1d1-31e77a184dcmr16728348a91.7.1753710816986;
        Mon, 28 Jul 2025 06:53:36 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEzf0byYG3/nxl4kA5ny6EZ42w8g2aS9njKzkb+beV8a1D+N1+V/qviClzmz+5/GO+5F56nMYiNai0XzeOVAes=
X-Received: by 2002:a17:90b:5488:b0:312:f88d:25f9 with SMTP id
 98e67ed59e1d1-31e77a184dcmr16728328a91.7.1753710816596; Mon, 28 Jul 2025
 06:53:36 -0700 (PDT)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20250718075336.4374-1-jasowang@redhat.com>
In-Reply-To: <20250718075336.4374-1-jasowang@redhat.com>
From: Eugenio Perez Martin <eperezma@redhat.com>
Date: Mon, 28 Jul 2025 15:52:59 +0200
X-Gm-Features: Ac12FXxa4gFZfVduc5SmqPV4AiQaK6sc1oJlLlRlXQggI-tpLg5PeDxMsQV6SS0
Message-ID: <CAJaqyWefAVfQtrboc3ms3A4BH5i0mFngoeznPXMVZaF3ULxuLQ@mail.gmail.com>
Subject: Re: [PATCH] vduse: drop depedencies for HAS_DMA and ARCH_HAS_DMA_OPS
To: Jason Wang <jasowang@redhat.com>
Cc: mst@redhat.com, xuanzhuo@linux.alibaba.com, virtualization@lists.linux.dev, 
	hch@infradead.org
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: zTOzfv9MTDpgdIxdJMvkrnnkchOJORhHZCej_xyaYYs_1753710817
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jul 18, 2025 at 9:53=E2=80=AFAM Jason Wang <jasowang@redhat.com> wr=
ote:
>
> After commit c2dbb3fc2a97 ("vduse: switch to use virtio map API
> instead of DMA API"), vduse doesn't use DMA API. So we can safely drop
> the depedencies for HAS_DMA and ARCH_HAS_DMA_OPS.
>
> Signed-off-by: Jason Wang <jasowang@redhat.com>

This should be at the end of the series that makes VDUSE not depend on
DMA, isn't it? Or am I missing something?

Anyway,

Acked-by: Eugenio P=C3=A9rez <eperezma@redhat.com>

Thanks!

> ---
>  drivers/vdpa/Kconfig | 8 +-------
>  1 file changed, 1 insertion(+), 7 deletions(-)
>
> diff --git a/drivers/vdpa/Kconfig b/drivers/vdpa/Kconfig
> index 559fb9d3271f..857cf288c876 100644
> --- a/drivers/vdpa/Kconfig
> +++ b/drivers/vdpa/Kconfig
> @@ -34,13 +34,7 @@ config VDPA_SIM_BLOCK
>
>  config VDPA_USER
>         tristate "VDUSE (vDPA Device in Userspace) support"
> -       depends on EVENTFD && MMU && HAS_DMA
> -       #
> -       # This driver incorrectly tries to override the dma_ops.  It shou=
ld
> -       # never have done that, but for now keep it working on architectu=
res
> -       # that use dma ops
> -       #
> -       depends on ARCH_HAS_DMA_OPS
> +       depends on EVENTFD && MMU
>         select VHOST_IOTLB
>         select IOMMU_IOVA
>         help
> --
> 2.47.3
>

