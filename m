Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33F2B2C3264
	for <virtualization@lists.linux.dev>; Fri,  4 Jul 2025 09:50:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751622662; cv=none; b=TEMO6s9qow2wedYysIB1ziVHEu28rU7a3kmHmvaxEfnx2aQHWM1AjCd6EsZUNprPQQPMMHhmUiShBmb+nY+w8e3xKRLG07zCZkPbIUdm5p6Fj1SU4QKO7tmJ/2sM+zx8zanYldKSFGlJPYb+Btz4FYzJ8qdRtQvnpwnPfpCXBeQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751622662; c=relaxed/simple;
	bh=Zec5aAtgje1saqg3959mi64eaXHhk/cKgvNvFwImF30=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=FAGUTPI+o+w/fVDK9MdJtK7uUQLBx+F/Nvqy2IBvr46m8b0e4k8lPIhfg12H1IxpwPq65ACukCM/8gDBH0P3SwNkEJ7EiDv5Mhq8huTsB+FiwIwvFvaHmqbhFQr1MU8+dC22YKDxxs3wyBOMn+B/dadAt7m6N9Wu+pjaNZW9Ye4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=MteaW23Q; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="MteaW23Q"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1751622659;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=tTdyBwlWGAyaHdEmFmxeJ+/oXgj79IJdQhxBgmlSUqU=;
	b=MteaW23QLCwuvX6r1l+zVyDlSR37I73uhKa8e/I7EHlDfYoN0CUIK4hEfbYCJMn5+4Gwdm
	E6t/2g6/iT3u9DN9U8n40+kwp/JlOSrvOvPiXguMbuCeOVjum0X0tXdx6RcOkWSz7EVz36
	rxjd3qZIp/JjiGofpVQIXlZOhCasMkc=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-286-QvFI82IaOluXPfk4OcZB6w-1; Fri, 04 Jul 2025 05:50:55 -0400
X-MC-Unique: QvFI82IaOluXPfk4OcZB6w-1
X-Mimecast-MFC-AGG-ID: QvFI82IaOluXPfk4OcZB6w_1751622655
Received: by mail-ej1-f71.google.com with SMTP id a640c23a62f3a-adb33457610so73135166b.3
        for <virtualization@lists.linux.dev>; Fri, 04 Jul 2025 02:50:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751622654; x=1752227454;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tTdyBwlWGAyaHdEmFmxeJ+/oXgj79IJdQhxBgmlSUqU=;
        b=PyUbf/SWuLShvCRyIrPm/+9EFMymZym1j8EmXwjJU44DOMH+dsWX5+NfyMVMnMcxBp
         rR7PMZCzBeQAjs89Cz5fQ90U6eUYNa+3AcxXMKRQplpPX9dAzX/1qFKtS774a3JdUFYy
         mvD/27TLoP0ln56gm7CZaiaq3npkcqtz7JPUmRm4wxHw6pRw7koGZxWhIU9Gyt4FkR38
         HZwhYBwrVdHXbM+Xg1Si/KI/Fl2Uiin+eZOzp60eAH8E58Ng3tAVVkJiAL3FGGbaxbTc
         CvfmElIKFO5VKPxgRjX/Ylqb+j2Wh/i5wEsimcG9WChOQKFeEsvS/xLvfFLL1C+ngN66
         pdBw==
X-Forwarded-Encrypted: i=1; AJvYcCVQuBfBgVDrjGnkwtvfYxz5zYWgV+Hd0dHRL02/fDyv0zjjCOIMUVUJS8U2puk6t8+l9baKl4f3xXWFJvdxWQ==@lists.linux.dev
X-Gm-Message-State: AOJu0Ywu1BngGGOxEQ9/thKJ2uUsU821T7NFAkBzZtUr9KuS/Qzpg/Uh
	iWPgcpXcxGUcveT74LkQdIh9jO+ubRS2FQoRaU1CA868gBkoS6pDdL7xDjBsvqs3/WogRbYad0u
	+eFF4xblFBjnDtjMwoEstiVyocW4qPhW1SnTPz5LqrRJLGP2SBSkDwwPQdxZiLVop8vhybRy+Qv
	Uzm5EhYmdtI00bXJyzowpSxidObQhIVv7hwkb6W8iDScM=
X-Gm-Gg: ASbGncu8jM5j6X/+xQz6a0yvcVkVp1DI9Jacs+VmDhlCC4MkJcmUXjQhh/A2fHZnqS0
	105UwrWADPpf8Jw9oyvS7hSWpAHqsm6JtRsC7TH8VIut1L7sU0k2Sr081KAQsZvUJcjhddDaYK4
	bcT4An
X-Received: by 2002:a17:907:d0b:b0:ade:9b52:4da0 with SMTP id a640c23a62f3a-ae3fe791341mr118180266b.60.1751622654594;
        Fri, 04 Jul 2025 02:50:54 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEZ6rmo441u00rCw39ALIYLXhXjrSJGPTmWEcD7E0TeZdIInSkqrp6WRoYHqk0yeiuf4JW6qAtpz5TNgnRXERw=
X-Received: by 2002:a17:907:d0b:b0:ade:9b52:4da0 with SMTP id
 a640c23a62f3a-ae3fe791341mr118177466b.60.1751622654163; Fri, 04 Jul 2025
 02:50:54 -0700 (PDT)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20250701164507.14883-1-will@kernel.org>
In-Reply-To: <20250701164507.14883-1-will@kernel.org>
From: Lei Yang <leiyang@redhat.com>
Date: Fri, 4 Jul 2025 17:50:16 +0800
X-Gm-Features: Ac12FXwqxd82V3LOjpodDJwMF_q2dHh_J7JtDHMWUmQsDfy8ZtrC-XST6Mt-11Y
Message-ID: <CAPpAL=zBxWBTQ8s-DGG-NywoE2+rDJQ4=9XGGn-YZSFH3R_mZg@mail.gmail.com>
Subject: Re: [PATCH v2 0/8] vsock/virtio: SKB allocation improvements
To: Will Deacon <will@kernel.org>
Cc: linux-kernel@vger.kernel.org, Keir Fraser <keirf@google.com>, 
	Steven Moreland <smoreland@google.com>, Frederick Mayle <fmayle@google.com>, 
	Stefan Hajnoczi <stefanha@redhat.com>, Stefano Garzarella <sgarzare@redhat.com>, 
	"Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>, 
	=?UTF-8?Q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>, netdev@vger.kernel.org, 
	virtualization@lists.linux.dev
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: RjgMhwwwIS2WGV0Q5O-C38FQ6drvQ-XwMeS2tL4NQ48_1751622655
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

I tested this series of patches with virtio-net regression tests,
everything works fine.

Tested-by: Lei Yang <leiyang@redhat.com>

On Wed, Jul 2, 2025 at 12:48=E2=80=AFAM Will Deacon <will@kernel.org> wrote=
:
>
> Hello again,
>
> Here is version two of the patches I previously posted here:
>
>   https://lore.kernel.org/r/20250625131543.5155-1-will@kernel.org
>
> Changes since v1 include:
>
>   * Remove virtio_vsock_alloc_skb_with_frags() and instead push decision
>     to allocate nonlinear SKBs into virtio_vsock_alloc_skb()
>
>   * Remove VIRTIO_VSOCK_DEFAULT_RX_BUF_SIZE and inline its definition
>     along with a comment
>
>   * Validate the length advertised by the packet header on the guest
>     receive path
>
>   * Minor tweaks to the commit messages and addition of stable tags
>
> Thanks to Stefano for all the review feedback so far.
>
> Cheers,
>
> Will
>
> Cc: Keir Fraser <keirf@google.com>
> Cc: Steven Moreland <smoreland@google.com>
> Cc: Frederick Mayle <fmayle@google.com>
> Cc: Stefan Hajnoczi <stefanha@redhat.com>
> Cc: Stefano Garzarella <sgarzare@redhat.com>
> Cc: "Michael S. Tsirkin" <mst@redhat.com>
> Cc: Jason Wang <jasowang@redhat.com>
> Cc: "Eugenio P=C3=A9rez" <eperezma@redhat.com>
> Cc: linux-kernel@vger.kernel.org
> Cc: netdev@vger.kernel.org
> Cc: virtualization@lists.linux.dev
>
> --->8
>
> Will Deacon (8):
>   vhost/vsock: Avoid allocating arbitrarily-sized SKBs
>   vsock/virtio: Validate length in packet header before skb_put()
>   vsock/virtio: Move length check to callers of
>     virtio_vsock_skb_rx_put()
>   vsock/virtio: Resize receive buffers so that each SKB fits in a page
>   vsock/virtio: Add vsock helper for linear SKB allocation
>   vhost/vsock: Allocate nonlinear SKBs for handling large receive
>     buffers
>   vsock/virtio: Rename virtio_vsock_skb_rx_put() to
>     virtio_vsock_skb_put()
>   vsock/virtio: Allocate nonlinear SKBs for handling large transmit
>     buffers
>
>  drivers/vhost/vsock.c                   | 15 +++++-----
>  include/linux/virtio_vsock.h            | 37 +++++++++++++++++++------
>  net/vmw_vsock/virtio_transport.c        | 25 +++++++++++++----
>  net/vmw_vsock/virtio_transport_common.c |  3 +-
>  4 files changed, 59 insertions(+), 21 deletions(-)
>
> --
> 2.50.0.727.gbf7dc18ff4-goog
>
>

