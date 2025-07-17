Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACBA42C18A
	for <virtualization@lists.linux.dev>; Thu, 17 Jul 2025 09:10:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752743427; cv=none; b=NziDmJqJNSkSPkXc6kh0LKxCRhfBq7joHnBVV18NuIrxk30K9g+kvumC2lGeSbRm03rq6v9Y8iqCqEGPA6EXMye8KpmieWqY/UjYDJD6YxS2yyBv+HH+T/TnKlMdkH2XbK7IUTtRpQWUCMG8YRz62Mxo37bZts8ZJoqGkT/G1NE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752743427; c=relaxed/simple;
	bh=529Qak/sfp59pYGiC/TZea5yPOltqRTolGUKXHD1UeE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=MHjT82I3Mh53OhY/JuKnA8BBvNYhpV/i/58GhxQ0SEQvkQq3nSU55O1KMvAOjxCeOTGhCfkmq8ykkynEFrxCEnyxLdi0SdNEmib7oSmcDlN/J7ztixCBfAs1nLPEQMIlM7XhnuEMZudqONDB4RLCjtsPqGGBCyz4O48XWE6MM/4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=FIePWOfr; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="FIePWOfr"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1752743424;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=+Fw27KCFfE/h9klyh3V20croFMoBwa4Sovv5KHmr7cY=;
	b=FIePWOfrJANXUw7Oeoc/k3lAW7KKP5XE2XTDconZ4p4RgURQLBKLggIKr4JHfQFxLanyT8
	smx7ayWSEq5+KQzb1Xz1XZTv0xGKb+zCdWMPjeIAWQm16nssXeLqKNPHiCsLkCvwl7FlDy
	tImndDOkAnPMlwiQY7lpaAs92bDBiMc=
Received: from mail-vk1-f197.google.com (mail-vk1-f197.google.com
 [209.85.221.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-503-URqGxbOINTmHNkp68NRAnw-1; Thu, 17 Jul 2025 05:10:22 -0400
X-MC-Unique: URqGxbOINTmHNkp68NRAnw-1
X-Mimecast-MFC-AGG-ID: URqGxbOINTmHNkp68NRAnw_1752743422
Received: by mail-vk1-f197.google.com with SMTP id 71dfb90a1353d-53473ab4992so320441e0c.2
        for <virtualization@lists.linux.dev>; Thu, 17 Jul 2025 02:10:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752743422; x=1753348222;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+Fw27KCFfE/h9klyh3V20croFMoBwa4Sovv5KHmr7cY=;
        b=gupN9o0Kwx/G6q1//dfMl90dNHTeuJPCM+L3arYIDKgEmEfrLPIR+h/i6B9QpOViJk
         7sYRR3HIwFERqIPhqXfd0XU1RaBsbave/2Y56+JStx5bLDHeL/Tl1GIfhRcWYIJcyS44
         7LVRWU6CqWWMxbVOIle48fcs6rV6CC+oIDQjTyLOgBXUIlnu+OzRYafQw3KnEt4Vvkxg
         /vLAb2Vx/R8MAewDC4eAldXlHTJZ9i2zfVXPd5/eZQ5p7FvRYcAwY8loWYffhPjW/plD
         1pZQ9TKng6ENmODQu28rKCZXIg2lXAtKwzyB7+eZ6UIp+gwwdsvKA46Ihr5dcff4wAPT
         ZOZg==
X-Forwarded-Encrypted: i=1; AJvYcCXDIaFkSPN7TYKkOMCtpponVCQqcJbvmutCw7ydtWlVD0yRtgYo+QKiDV3H4WV6la+OU3vT0uE0yxAoK2C0nQ==@lists.linux.dev
X-Gm-Message-State: AOJu0Ywbxpm1vL3am9oYi01VfWJcPWjox1KUJGp3jAggS0kEkPR8XxyN
	CmmSKN2PHAi2VuE/aKshM7mab+zoB60EkEH4DCY1/aWQr4pdubFfRYo1OaHXl2JBuwRPTiBwVvO
	j5PpjXK51dOyfAUxyCufW+EZO/M7QnmJQyZFHjSpjpSIaqrAff5UDvff1T6CmXBwOgpMZeXrius
	DmfYqI19Qe4YUw7uj8k58BabCl/VBdWWLJwgnVfTXeAwg=
X-Gm-Gg: ASbGncuYSi1oxbKiLV2ZADvdKYmhrDBJWsL/Z8eoG/EeojZsF0ZAA/sCgk8p3WdqAhg
	ONLNuAaC2uI9rtWDISKs4kBiKSfy67TJl8o0ZdJf38IBBRc6RQVKtISISxVJsU2sRXOXHr1YAOS
	/zO0Soy0f/w2se9wSv7SB9
X-Received: by 2002:a05:6102:5127:b0:4eb:2eac:aaa0 with SMTP id ada2fe7eead31-4f89996cb49mr3005693137.19.1752743422244;
        Thu, 17 Jul 2025 02:10:22 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IECuZg4tnD3dbPOqkK7QLQFXVz6s0zEI1WL38YU/sbDVqoEGpcLhizaAQH/UfHtx1VrdY5RMF+LxyJoII3bJZE=
X-Received: by 2002:a05:6102:5127:b0:4eb:2eac:aaa0 with SMTP id
 ada2fe7eead31-4f89996cb49mr3005681137.19.1752743421877; Thu, 17 Jul 2025
 02:10:21 -0700 (PDT)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20250717090116.11987-1-will@kernel.org> <20250717090116.11987-2-will@kernel.org>
In-Reply-To: <20250717090116.11987-2-will@kernel.org>
From: Jason Wang <jasowang@redhat.com>
Date: Thu, 17 Jul 2025 17:10:07 +0800
X-Gm-Features: Ac12FXwF3a40TcBiFPolR067u2ZE0YBPsrx96TsMziyQKG9t5JlhF_12qsJ9G6U
Message-ID: <CACGkMEsoBj7aNXfCU7Zn=5yWnhvA7M8xhbucmt4fuPm31dQ1+w@mail.gmail.com>
Subject: Re: [PATCH v4 1/9] vhost/vsock: Avoid allocating arbitrarily-sized SKBs
To: Will Deacon <will@kernel.org>
Cc: linux-kernel@vger.kernel.org, Keir Fraser <keirf@google.com>, 
	Steven Moreland <smoreland@google.com>, Frederick Mayle <fmayle@google.com>, 
	Stefan Hajnoczi <stefanha@redhat.com>, Stefano Garzarella <sgarzare@redhat.com>, 
	"Michael S. Tsirkin" <mst@redhat.com>, =?UTF-8?Q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>, 
	netdev@vger.kernel.org, virtualization@lists.linux.dev, 
	stable@vger.kernel.org
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: bCCvSsQMGWif-Fo4d8Mq66YdihU2ah5CsdIA7WssbUQ_1752743422
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jul 17, 2025 at 5:01=E2=80=AFPM Will Deacon <will@kernel.org> wrote=
:
>
> vhost_vsock_alloc_skb() returns NULL for packets advertising a length
> larger than VIRTIO_VSOCK_MAX_PKT_BUF_SIZE in the packet header. However,
> this is only checked once the SKB has been allocated and, if the length
> in the packet header is zero, the SKB may not be freed immediately.

Can this be triggered from the guest? (I guess yes) Did we need to
consider it as a security issue?

>
> Hoist the size check before the SKB allocation so that an iovec larger
> than VIRTIO_VSOCK_MAX_PKT_BUF_SIZE + the header size is rejected
> outright. The subsequent check on the length field in the header can
> then simply check that the allocated SKB is indeed large enough to hold
> the packet.
>
> Cc: <stable@vger.kernel.org>
> Fixes: 71dc9ec9ac7d ("virtio/vsock: replace virtio_vsock_pkt with sk_buff=
")
> Reviewed-by: Stefano Garzarella <sgarzare@redhat.com>
> Signed-off-by: Will Deacon <will@kernel.org>
> ---
>  drivers/vhost/vsock.c | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/vhost/vsock.c b/drivers/vhost/vsock.c
> index 802153e23073..66a0f060770e 100644
> --- a/drivers/vhost/vsock.c
> +++ b/drivers/vhost/vsock.c
> @@ -344,6 +344,9 @@ vhost_vsock_alloc_skb(struct vhost_virtqueue *vq,
>
>         len =3D iov_length(vq->iov, out);
>
> +       if (len > VIRTIO_VSOCK_MAX_PKT_BUF_SIZE + VIRTIO_VSOCK_SKB_HEADRO=
OM)
> +               return NULL;
> +
>         /* len contains both payload and hdr */
>         skb =3D virtio_vsock_alloc_skb(len, GFP_KERNEL);
>         if (!skb)
> @@ -367,8 +370,7 @@ vhost_vsock_alloc_skb(struct vhost_virtqueue *vq,
>                 return skb;
>
>         /* The pkt is too big or the length in the header is invalid */
> -       if (payload_len > VIRTIO_VSOCK_MAX_PKT_BUF_SIZE ||
> -           payload_len + sizeof(*hdr) > len) {
> +       if (payload_len + sizeof(*hdr) > len) {
>                 kfree_skb(skb);
>                 return NULL;
>         }
> --
> 2.50.0.727.gbf7dc18ff4-goog
>

Thanks

