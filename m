Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F3F03876D7
	for <virtualization@lists.linux.dev>; Thu,  7 May 2026 08:28:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.221.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778142507; cv=pass; b=YgbuXoJsBeBWOn580k3A8fsvAFm/CsdP3BuHG6vU/5qz/jsO5wcf1ULXfuOV+MH2ckub60nE53GPWyx5Lt9lV7quyyZY61eTmTaeIoRPyqOKTQfJTRjpnYo5HdwISY256TGt5+hRSKPxs4hEU8wpKIkLS/N1GQAQEUVe8Ac325M=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778142507; c=relaxed/simple;
	bh=+Rlew96MW33vEuHa2s2u6zkGjfL8lJ/5SiWMjy0D22Y=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=e0X9u8N6t8oKg4N41U2T4yL6iP2W0+HnhJiaNubK1VrLMF/Qn1GQb/A7G1TpmKJpSYP88U2RP8eft1i+A8JCflvbbovSP+oDlsTG1I/Fwkty2BohNuz5RIN94tENOM/WAq2KgMo9nPTbRsMHchrebEiYVBgifWBP50iEcGzr3jg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=CdTrWevU; arc=pass smtp.client-ip=209.85.221.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="CdTrWevU"
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-453903ee4adso82525f8f.3
        for <virtualization@lists.linux.dev>; Thu, 07 May 2026 01:28:24 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1778142502; cv=none;
        d=google.com; s=arc-20240605;
        b=OyGQqZ5IlvDIrFZdL8kxTwjLz22uxVU+BA/FGx1l7iOKGVPHvExwAlKpzCMKrMRUsV
         Y6zPIU82oFn/ybdmBOylWSf1VWIJ0l72aWevxvpWqlPjPpbKdg5DA9qN94yZryv3nB7z
         ygsZGGv1PgFhnAGPs1YlprH/e9oLN3V1LksHsywPT+mR4Lx8Uin+F0vnAM8z9VJH9Qvi
         vdoziVnoSesrH4wZOLaq4pi1LB2ptpNAWM5eoYX7Wi8GsGW5GEKCj2NrUPSvg89rJd83
         5KC9Scp0+Zk4u88p/gNX/h2VvehEuLksltC2dneF5CCmYeL9R5TV1pglfO1BVOv1TkE8
         WNYw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=OrM1357dsMNrMu+hd2Ti8ohmpi73tk3SEixYBQv37JQ=;
        fh=9/KdLpy6nqyuSibW5Kw3XdtUAbv3EBVLTfV5+v5S5kM=;
        b=dRGpjvl/N4v+n1mxe1AhAtYGc7wgySsT2E9vUj0x2t5UPVqA7Dxt3d6Y8oPLOu9cub
         8kSTGaViT+cRKSnoSZlxo+JNSMc47Lw3EpA2aCPksWioKa/fIB+8elFt/iTkuRPYPL5D
         cdhWbrKaSjr5c1HVblegLPmoaQN2E3n1k8xlXC3RnMw2mrFXby0W+OXFrfW0cKh51JMt
         1bE4rt7JCTNXXa9MFzHD0fnRj/+id6BxfDlq707PS31zuQVyZ3jtgia3he0eAAkUwMQE
         bvFOg+EJnw8+xaln5r9Ljwlodo0nIGQe7uHo8RHnXbKwWl9CasTSy/9LhuOSBQte7V6X
         vWsA==;
        darn=lists.linux.dev
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1778142502; x=1778747302; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OrM1357dsMNrMu+hd2Ti8ohmpi73tk3SEixYBQv37JQ=;
        b=CdTrWevU8QAuVcCZWqG65UIxgZp5uyPNOPFj8myU0JAllVuPuyQe/+qafLWOf/pDqL
         oCjiraxpVP2uS8Ae0ECbiSrKuARxT1CK3ADCaqqANFytSgwHst8AkPSXYxfYtAqfhR+F
         bipa25aSRu6cJFVaJdS0tWc2DUpTdlCNVidzDjVzIdHkceG9CnX/MOfCCkv8jguGAxIL
         0K/PeMC28bzqBejvA6pRu8W+WJ3Yx1m+PAUi/6QLA8wOrNMIJcFLeH5B/KQ0JlZWMAZL
         jSoA50fPbuIEDEQGDsZvOXa53BIWxjNyHiVm+y3L9o/CxRjdhc0hNZkUgEEQWN9zzWlM
         tO3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778142502; x=1778747302;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=OrM1357dsMNrMu+hd2Ti8ohmpi73tk3SEixYBQv37JQ=;
        b=IurLsChp3DJFJyo8wvuO0bPr5uGb9ZpBhWXFrJK2On0Wv0UjBSa4sF5p8VV8Vkr1uS
         pvDBcU9zJWf8B/aBGvsMc5BEtfQ0ITi6/G6eMbV7tglcSaoFgcEa7g5TrVf+moJD8rOh
         F/NKyJl6gJSEeSNiOBtk/8Mr1QcJAIpW+JzjRH2NFE8J0cWosE9wR/RqfxjgqNXvheDa
         FKpb/5WVvDf0dcM8MorSuumvgjz4JCYMNJmpB08jhBeS9Ltvu3ODQwjjeKS64Lmyaxlj
         16Atkj5UWu/MXq8yu+kuMT5AW7dmidsxEE2XsRiGyDaYWQfQesvNZkJ3z6RPNOdX38QU
         j/YQ==
X-Forwarded-Encrypted: i=1; AFNElJ8oaLv8FKCn3kQqweyEVYxOnj4EoMWHqgR1vhQY+V4J6qg2jwaPQ8uPGxp/DcoEVHtRg4echF8CeuEJjlnvlg==@lists.linux.dev
X-Gm-Message-State: AOJu0YxoLxVyQiNnAGmEXhnDaINiAY4yI68IEP5PSgwwk4qd2WuGYAIK
	8GvhBajxr3JQ7jshFTW7+DddYu8WgWncmVxHB9qxBdX/+C2n3ZJH0jyOEQSFpSBwbbTG8dKv5L3
	VeHn8lUDz3NfS0DdNQXSBekZFyKpSKiIiE2x2tXgK
X-Gm-Gg: AeBDievqKfHoqyQuHodBkHDCVhVt962ngJSBT4/RpOqdSGnbU6l4IxSLGLlppduE+GL
	LdmkuWrKLMxSXY/oluzySvDXUfKGwpySAT9r5WotTi9At9Yi0mNQ7SOrFiDYrGwXxoIXR07CsdS
	M4f9BEN5/CTxmXxmjq3B60JGo5BIL7rWRqd6sF6LYjVDo+pwzsQ079bfTas06dwQiFCk7e+xeKe
	032PZfy5sSE6maA6Fi9yfB3ravOWMhmM5PsU073GuUphMXxixgwRomrlHqOFmWf3xHO8ZMINrD3
	SSqW1LF091RFeFltM33O0gCaXZHoqdmvhe+bKRpYGTiTtfq92TH4/iKUs/HNJtbGvAq2H1L2Hiz
	MeRqABbnWtkpVLg==
X-Received: by 2002:a05:6000:1acb:b0:44a:525b:2851 with SMTP id
 ffacd0b85a97d-4515b42e07bmr11837967f8f.10.1778142501522; Thu, 07 May 2026
 01:28:21 -0700 (PDT)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20260505-rust-virtio-v1-0-9563383909e4@pitsidianak.is> <20260505-rust-virtio-v1-2-9563383909e4@pitsidianak.is>
In-Reply-To: <20260505-rust-virtio-v1-2-9563383909e4@pitsidianak.is>
From: Alice Ryhl <aliceryhl@google.com>
Date: Thu, 7 May 2026 10:28:08 +0200
X-Gm-Features: AVHnY4JXn8H5cehqowudQQF9hOA-CPXO5Vy7y8WXmH3YzNXBrAofW1cKQmAA598
Message-ID: <CAH5fLgjFLBx3DDE7yGNSHmaW9w5GyzSOi4o=avGrMni1a0yS3A@mail.gmail.com>
Subject: Re: [PATCH RFC 2/6] rust/helpers: add virtio.c
To: Manos Pitsidianakis <manos@pitsidianak.is>
Cc: Miguel Ojeda <ojeda@kernel.org>, Manos Pitsidianakis <manos.pitsidianakis@linaro.org>, 
	Peter Hilber <peter.hilber@oss.qualcomm.com>, Stefano Garzarella <sgarzare@redhat.com>, 
	Stefan Hajnoczi <stefanha@redhat.com>, Viresh Kumar <viresh.kumar@linaro.org>, 
	"Michael S. Tsirkin" <mst@redhat.com>, Boqun Feng <boqun@kernel.org>, Gary Guo <gary@garyguo.net>, 
	=?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <lossin@kernel.org>, Andreas Hindborg <a.hindborg@kernel.org>, 
	Trevor Gross <tmgross@umich.edu>, Danilo Krummrich <dakr@kernel.org>, rust-for-linux@vger.kernel.org, 
	Jason Wang <jasowang@redhat.com>, Xuan Zhuo <xuanzhuo@linux.alibaba.com>, 
	=?UTF-8?Q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>, 
	virtualization@lists.linux.dev, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, May 5, 2026 at 10:14=E2=80=AFAM Manos Pitsidianakis
<manos@pitsidianak.is> wrote:
>
> Some internal kernel virtio API functions are inline macros, so define
> their symbols in a helper file.
>
> Signed-off-by: Manos Pitsidianakis <manos@pitsidianak.is>
> ---
>  MAINTAINERS            |  6 ++++++
>  rust/helpers/helpers.c |  3 +++
>  rust/helpers/virtio.c  | 35 +++++++++++++++++++++++++++++++++++
>  3 files changed, 44 insertions(+)
>
> diff --git a/MAINTAINERS b/MAINTAINERS
> index d1cc0e12fe1f004da89b1aa339116908f642e894..48c9c666d90b5a256ab6fae1f=
42508b789a0ce50 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -27930,6 +27930,12 @@ F:     include/uapi/linux/virtio_*.h
>  F:     net/vmw_vsock/virtio*
>  F:     tools/virtio/
>
> +VIRTIO CORE API BINDINGS [RUST]
> +M:     Manos Pitsidianakis <manos@pitsidianak.is>
> +L:     virtualization@lists.linux.dev
> +S:     Maintained
> +F:     rust/helpers/virtio.c
> +
>  VIRTIO CRYPTO DRIVER
>  M:     Gonglei <arei.gonglei@huawei.com>
>  L:     virtualization@lists.linux.dev
> diff --git a/rust/helpers/helpers.c b/rust/helpers/helpers.c
> index a3c42e51f00a0990bea81ebce6e99bb397ce7533..84b54690d95be37699ef9a9c4=
d7cedec0bbae6d3 100644
> --- a/rust/helpers/helpers.c
> +++ b/rust/helpers/helpers.c
> @@ -62,6 +62,9 @@
>  #include "uaccess.c"
>  #include "usb.c"
>  #include "vmalloc.c"
> +#if defined(CONFIG_VIRTIO)
> +#include "virtio.c"
> +#endif /* defined(CONFIG_VIRTIO) */

Please move this ifdef inside the file instead, to match all other
files with similar ifdefs.

Alice
