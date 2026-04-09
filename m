Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F8DD3E1CF4
	for <virtualization@lists.linux.dev>; Thu,  9 Apr 2026 16:53:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775753638; cv=none; b=AS6UvT9WVgjrE239OYGwMs4kQnbfHlDQSqo4W9CBz1HBD4c05jHTeaxN1PujiOJazntstthOdvPxoiiqjvzodVvjlvOacj7ucMUf9ag29N0Tc3BTzQp8VuM4F6LQ2cBYZdjqVC3Z23qTDbJIQ6q1yqKABj9lmYx4TU3DxQAa0Jo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775753638; c=relaxed/simple;
	bh=U8E10q+Ey8nt3yWvTgzBVIBTGW45V3Z0mUVuJjH4YwQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Z+yPAaDGtGKYC/bctbuIEx++0v9n0LjQC6QsyjAQtGgrD41JLlsvEnoxrCRzMaOUHXIUEz/Ke+Adu7W820AEsfwSul6wueqG73s8ZKb3VlMOzUvccOanuKAisbFVCBX5iPNNovxpeOxeNxEiAwXPfnP8fOgvZedmKgkphU97rho=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=bnnEwpCH; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="bnnEwpCH"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1775753636;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=x787QkDVb/cLqOOpafxZbY7NHAGjCM7sQxc05FIRucg=;
	b=bnnEwpCHZa4+vZCHuLLSiPo3e47+GoGb2uET8ocSe0W1wt3P170BHz5zDEnJLBQN6t/2LP
	JJCWYPfNw35bfobut7dnrYRNjMh4FtdMCCRZ9ADLIBRzv3kEAhWZGO2zJ/humjfU418uXK
	/1CVUJMGcyiK9EuwuMJRs1uN0J/8a1Y=
Received: from mail-yx1-f72.google.com (mail-yx1-f72.google.com
 [74.125.224.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-125-oOia3tcQNyGkdxVpUJeRtw-1; Thu, 09 Apr 2026 12:53:55 -0400
X-MC-Unique: oOia3tcQNyGkdxVpUJeRtw-1
X-Mimecast-MFC-AGG-ID: oOia3tcQNyGkdxVpUJeRtw_1775753634
Received: by mail-yx1-f72.google.com with SMTP id 956f58d0204a3-64eaa6294d9so2057327d50.1
        for <virtualization@lists.linux.dev>; Thu, 09 Apr 2026 09:53:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775753634; x=1776358434;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=x787QkDVb/cLqOOpafxZbY7NHAGjCM7sQxc05FIRucg=;
        b=hSR7vWTh6evdWNYxOVF1M2Efhnm6MdeJdVKrUR0Z043I9N9AsUQ2Qe8WF7g50JV2xG
         0LteeiE+JkZum7tmvNUmA9nHd8+NtjYWdsd7keMSc7tEyquD7CNvSparby/Cmi9/47bo
         ZE0WR9tHHGnIdbNU6ZamyJwYOzNCsGb+hKdZ73s7Se+pN//F+g8Uwc+j1gn9z+UunEq2
         AYSSQTTs3r41Z0P+VlIpz9nOvqf5imFOkskZs1/V/kxKzeUqu0m+/PvhcXUWBooTGdzR
         cKDvV4ogENIa3ZUc8iVntzAzj+ScdARs4/tqsaUl1W89A8teGfQJlChAnoyoFmQc3iQQ
         vQAg==
X-Gm-Message-State: AOJu0YzRn1iPhLEZMG7E7l3HjJnBrgatwZ533WG/DjbRKS5FtuO3YOeV
	NBnbWOe712HFXkiGuOY0fZu1E1x+HT4io5sJLKQPlVxMptzaV78SOYKhKdG7W1Y8OzaXNz1wWea
	C3o8kCFG2tUd8qKpIlwhd9PjDrqUTITbVerR7tSSYP5a7YGf+3/A2R8uZEhrtieDtbmUBhGwPgo
	hgVVoNvNdYaZhM415Y6AtOfuWrjITYm4qjr4e8VAPM+og=
X-Gm-Gg: AeBDievgLKqx8Eh+QNnDCWJeLLlM9FMsgBSxqVJrh/pifkv1DN4CubQ/CVvGLL8z2aM
	iMw/daBcTZIQN+aCZGxosOL4WrRjSIV/jzRDc2QNIS0iVimn1oVPQOXQmr+GuuDImMCWXtKbFWp
	RoxC4bhvI45ecp97OxfsTHEAA57hbzgUB1kyqsjJ7VfiQI6tZ42Xpb5JA0SCcDkT5UMwmsm722i
	lqD6w==
X-Received: by 2002:a53:ac88:0:b0:650:323c:8304 with SMTP id 956f58d0204a3-65048754f2amr23156962d50.28.1775753634376;
        Thu, 09 Apr 2026 09:53:54 -0700 (PDT)
X-Received: by 2002:a53:ac88:0:b0:650:323c:8304 with SMTP id
 956f58d0204a3-65048754f2amr23156944d50.28.1775753633945; Thu, 09 Apr 2026
 09:53:53 -0700 (PDT)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20260310-virtio-media-id-v1-1-be211bcf682b@redhat.com>
In-Reply-To: <20260310-virtio-media-id-v1-1-be211bcf682b@redhat.com>
From: Albert Esteve <aesteve@redhat.com>
Date: Thu, 9 Apr 2026 18:53:41 +0200
X-Gm-Features: AQROBzDaFJaZiFxmZiHsfQn41Ahklm_jm6vStQdJB-dsw3IWC6_Nu3_OKyiOr14
Message-ID: <CADSE00+VyDf6hMAB79wP2koSQ3FznO_OJuGCZ6zN8zuCrwtZMg@mail.gmail.com>
Subject: Re: [PATCH] virtio: Add ID for virtio media
To: "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>, 
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>, =?UTF-8?Q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>
Cc: virtualization@lists.linux.dev, linux-kernel@vger.kernel.org, 
	gnurou@gmail.com
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: yrhoP1KuBt7NQgp-wEGIezOJH_nEVFla2VgTxMgAq2g_1775753634
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,


On Tue, Mar 10, 2026 at 9:41=E2=80=AFAM Albert Esteve <aesteve@redhat.com> =
wrote:
>
> Add VIRTIO_ID_MEDIA definition for virtio-media.
>
> Signed-off-by: Albert Esteve <aesteve@redhat.com>

Are there any thoughts on this patch, or any actions I need to take?

Thanks,
Albert

> ---
> While the Linux driver for virtio media is currently under active
> development and review [1], the VirtIO v1.4 specification has
> already been published and oficially defines the media device type [2].
>
> Adding the device ID now allows other components and tools to reference i=
t
> before the driver lands, and ensures the kernel headers stay aligned
> with the specification.
>
> [1] https://lore.kernel.org/linux-media/20250412-virtio-media-v3-1-97dc94=
c18398@gmail.com/
> [2] https://docs.oasis-open.org/virtio/virtio/v1.4/virtio-v1.4.html#x1-82=
200022
> ---
>  include/uapi/linux/virtio_ids.h | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/include/uapi/linux/virtio_ids.h b/include/uapi/linux/virtio_=
ids.h
> index 6c12db16faa3a..f9056af0c6223 100644
> --- a/include/uapi/linux/virtio_ids.h
> +++ b/include/uapi/linux/virtio_ids.h
> @@ -69,6 +69,7 @@
>  #define VIRTIO_ID_BT                   40 /* virtio bluetooth */
>  #define VIRTIO_ID_GPIO                 41 /* virtio gpio */
>  #define VIRTIO_ID_SPI                  45 /* virtio spi */
> +#define VIRTIO_ID_MEDIA                        48 /* virtio media */
>
>  /*
>   * Virtio Transitional IDs
>
> ---
> base-commit: 6de23f81a5e08be8fbf5e8d7e9febc72a5b5f27f
> change-id: 20260310-virtio-media-id-b31179fcdc44
>
> Best regards,
> --
> Albert Esteve <aesteve@redhat.com>
>

