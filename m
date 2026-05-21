Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CD28226D18
	for <virtualization@lists.linux.dev>; Thu, 21 May 2026 09:03:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779354231; cv=none; b=eOARoC382+YYhKdINTCaACtyzok7dGcQs7iWR4CIIGW9I2o3Z6xKpDnnYKBCas6pu5uw2noQEAkAxr6cSccvXWmwCknbC4z2ohvA3B0xGVBQzfrvttZrSEX3AzvlWQeijqGDBUzFHm4U1zcSgiPpkhuMxpL7i5rgPJpntw749MM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779354231; c=relaxed/simple;
	bh=XaEn5yfQ8Xbc3VqL//EzG6rxkWGVNWaO7LiHJ9nbdYo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=jqxAll6gTTXFl2chQAIGdV4Ih+oDXi7Va0mJQ256Q2ETuQtjrZPYKiu0fpHvq3krs1fGuqt2SzIAgBFlv1MtCTXSP23QMmHPjg8Zidl860hAb+WXQg8A/mcvMi98OQOaB0dlxegXO2kAAmwgazDP2ruKm9Weq4D2LzC3IXsx+zE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=WrvKra8y; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="WrvKra8y"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1779354229;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=8cIbbH1wKqmtak6Lc0vWm8mIsjy4x1n8Lc9tt73AtKg=;
	b=WrvKra8ynp16pYoaZvc/er5LNgsjdOEXSFiZTmOyni9dC/fxAgrqBric7zZ4XQ2wZ8+644
	4xkvc3OMFO8P/eYrntlbPwZC2HfQsXye6uDWcpzHp2acvwk3kK8AqJjHkl76BTdf22NDbW
	roy+pVsdjjQf9xVeasskETUwcVOulyk=
Received: from mail-yx1-f70.google.com (mail-yx1-f70.google.com
 [74.125.224.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-418-Yan20us2NT-eTjyMQxD6hQ-1; Thu, 21 May 2026 05:03:47 -0400
X-MC-Unique: Yan20us2NT-eTjyMQxD6hQ-1
X-Mimecast-MFC-AGG-ID: Yan20us2NT-eTjyMQxD6hQ_1779354226
Received: by mail-yx1-f70.google.com with SMTP id 956f58d0204a3-651c0aae418so13077327d50.2
        for <virtualization@lists.linux.dev>; Thu, 21 May 2026 02:03:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779354226; x=1779959026;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=8cIbbH1wKqmtak6Lc0vWm8mIsjy4x1n8Lc9tt73AtKg=;
        b=VM7EOJoLL4gmeQHMFe09K+uNLvQY4PGB1KD3JIj/2Gsw1Hdwm8yKO5cjHTazPuDtvA
         M6oJfMSX/xG4C4zlnGDliwv6aHCLoDabaxwlGWxTQUh+Jp5UuDU3eQFFoh03afyj3uAm
         mzhbxRWoQRyAKlrVjjhFNimtXY63XxsRu0dAcqIjLGJ1xaMz8L6CKlpE3FpMQtxwo/II
         AWDjUmYmGesV56CWq+dR0QDLlW3setOHs439eQZNH098BI/HLwgUk2eMTxjQjjMIWm7m
         TipwDdGzfsv9BAP/tZAndr/WAlaJo3hUddbnd+9OWp1bcVAWFhPyuKUnzu08TYj/hVe2
         iavA==
X-Forwarded-Encrypted: i=1; AFNElJ/jhXxJ1MSaP4YkMuQ+RW1NyRnnyMkGQRrsPh0v3kF5HAGIo8awG0NjcLGZ4yPkIz5m2NMG1X9wNj9HkVtR7Q==@lists.linux.dev
X-Gm-Message-State: AOJu0Yy9qKyMIlaReGZURQT+yjl4Keq29ScZy/XKHOVYGrzfQBgtWCRX
	0KdDQq1Uj37EZFP/ArhOxWyN1rMnqPdOqGpG60efQBdHkFcLXZDgK2qZpKm7nwdSqMyKp26ixas
	kfcIlRgcNB3m03jjdwDQ5/pPrtlT4rkZDuBQ0N3aXgWy3KETdIlW2+/tDD01y8G5CJBIM0IL7TU
	fqa7fpE6fBZN9Pf45XF+TPoQR1OPOXiY9Qsf8mTkEgwyU=
X-Gm-Gg: Acq92OGtIV2zJiFz3jowyJSa1bzHKNrkn09yOHyiD4XGNkSwHIH2uhsOyl/zoU0kiqr
	FKmdgPsB4CivQNFcu7ZrOWnvvbYsCwsMqUpi/gbpKRljLSnBAXL+Uz15Hu2lD1Aw2W8FenKP+G8
	MbKEN1j6ht1czQw5ALJSFDpMYIym9DPH8FVp2dtGPkzw+bPpKxVGXiKCRHcMHkneqIKEsam+0Ma
	3s=
X-Received: by 2002:a05:690e:1511:b0:650:6df:681 with SMTP id 956f58d0204a3-65eae2843admr1390299d50.32.1779354226497;
        Thu, 21 May 2026 02:03:46 -0700 (PDT)
X-Received: by 2002:a05:690e:1511:b0:650:6df:681 with SMTP id
 956f58d0204a3-65eae2843admr1390262d50.32.1779354226023; Thu, 21 May 2026
 02:03:46 -0700 (PDT)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20260510-rust-virtio-v3-0-1427f14d67e1@pitsidianak.is> <20260510-rust-virtio-v3-2-1427f14d67e1@pitsidianak.is>
In-Reply-To: <20260510-rust-virtio-v3-2-1427f14d67e1@pitsidianak.is>
From: Eugenio Perez Martin <eperezma@redhat.com>
Date: Thu, 21 May 2026 11:03:09 +0200
X-Gm-Features: AVHnY4JMB9tpQYTJmPQlWQii6TKXBLjHIINo0YZp5M0aY6YvV9kXPO-so4oEhvw
Message-ID: <CAJaqyWexdTrXcVoxxZb+frrfnr+xYCm67GGtWajWY-ygdyJfKw@mail.gmail.com>
Subject: Re: [PATCH RFC v3 2/6] rust/helpers: add virtio.c
To: Manos Pitsidianakis <manos@pitsidianak.is>
Cc: Miguel Ojeda <ojeda@kernel.org>, Manos Pitsidianakis <manos.pitsidianakis@linaro.org>, 
	Peter Hilber <peter.hilber@oss.qualcomm.com>, Stefano Garzarella <sgarzare@redhat.com>, 
	Stefan Hajnoczi <stefanha@redhat.com>, Viresh Kumar <viresh.kumar@linaro.org>, 
	"Michael S. Tsirkin" <mst@redhat.com>, Boqun Feng <boqun@kernel.org>, Gary Guo <gary@garyguo.net>, 
	=?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <lossin@kernel.org>, Andreas Hindborg <a.hindborg@kernel.org>, 
	Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>, 
	Danilo Krummrich <dakr@kernel.org>, Daniel Almeida <daniel.almeida@collabora.com>, 
	rust-for-linux@vger.kernel.org, Jason Wang <jasowang@redhat.com>, 
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>, virtualization@lists.linux.dev, 
	linux-kernel@vger.kernel.org
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: oB4PoZVnZQMDB5KTOxePgXF_2ysYoJCtsOIxx0YIK8c_1779354226
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, May 10, 2026 at 3:38=E2=80=AFPM Manos Pitsidianakis
<manos@pitsidianak.is> wrote:
>
> Some internal kernel virtio API functions are inline macros, so define
> their symbols in a helper file.
>
> Signed-off-by: Manos Pitsidianakis <manos@pitsidianak.is>
> ---
>  MAINTAINERS            |  6 ++++++
>  rust/helpers/helpers.c |  1 +
>  rust/helpers/virtio.c  | 37 +++++++++++++++++++++++++++++++++++++
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
> index a3c42e51f00a0990bea81ebce6e99bb397ce7533..5dc0d2f2ee6bd2ae8e6abfe4b=
aa247c1963967f6 100644
> --- a/rust/helpers/helpers.c
> +++ b/rust/helpers/helpers.c
> @@ -61,6 +61,7 @@
>  #include "time.c"
>  #include "uaccess.c"
>  #include "usb.c"
> +#include "virtio.c"
>  #include "vmalloc.c"
>  #include "wait.c"
>  #include "workqueue.c"
> diff --git a/rust/helpers/virtio.c b/rust/helpers/virtio.c
> new file mode 100644
> index 0000000000000000000000000000000000000000..46aeeb063158823e66477777b=
3cd4bd1525df330
> --- /dev/null
> +++ b/rust/helpers/virtio.c
> @@ -0,0 +1,37 @@
> +// SPDX-License-Identifier: GPL-2.0
> +
> +#ifdef CONFIG_VIRTIO
> +#include <linux/virtio_config.h>
> +
> +__rust_helper bool
> +rust_helper_virtio_has_feature(const struct virtio_device *vdev,
> +                              unsigned int fbit)
> +{
> +       return virtio_has_feature(vdev, fbit);
> +}
> +__rust_helper void rust_helper_virtio_get_features(struct virtio_device =
*vdev,
> +                                                  u64 *features_out)
> +{
> +       return virtio_get_features(vdev, features_out);

As a suggestion, perhaps an API that allows getting feature bits > 64,
like VIRTIO_NET_F_GUEST_UDP_TUNNEL_GSO (65) or VIRTIO_NET_F_IPSEC (70)
could save the need to add more functions in the future.

> +}
> +
> +__rust_helper int rust_helper_virtio_find_vqs(struct virtio_device *vdev=
,
> +                                             unsigned int nvqs,
> +                                             struct virtqueue *vqs[],
> +                                             struct virtqueue_info vqs_i=
nfo[],
> +                                             struct irq_affinity *desc)
> +{
> +       return virtio_find_vqs(vdev, nvqs, vqs, vqs_info, desc);
> +}
> +
> +__rust_helper void rust_helper_virtio_device_ready(struct virtio_device =
*dev)
> +{
> +       return virtio_device_ready(dev);
> +}
> +
> +__rust_helper bool
> +rust_helper_virtio_is_little_endian(struct virtio_device *vdev)
> +{
> +       return virtio_is_little_endian(vdev);
> +}
> +#endif /* CONFIG_VIRTIO */
>
> --
> 2.47.3
>

