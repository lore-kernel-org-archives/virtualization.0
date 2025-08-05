Received: from mail-lj1-f196.google.com (mail-lj1-f196.google.com [209.85.208.196])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DEDE2192F5
	for <virtualization@lists.linux.dev>; Tue,  5 Aug 2025 08:53:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.196
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754383998; cv=none; b=jecDzymHBFnn+n9diPqeKR+19tYHz8Mj5CDG9P4SGo9bL8PGMLHcSYSKkyWLDKZqcXAQNBhs32FOh4eDhnIxQoldaLWqlYXidsrwIinYXF1UxHH9zm1vvbpACjb9VZ2p2oQkimNYFyOSRwNgXWVXJh0x7a6xCNFFyruBvyI5Sjw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754383998; c=relaxed/simple;
	bh=bmc3fqkz5l4aFYJYtB/WgxFSjibZd7amLkHxt3HSOPY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=KD45cNW4rz5ihR4Urxrc2E2kxGkpVy73R5W7GxW1Rnno9QadHdN0gXYRT4Y1c+aj9VyQ9u+1kaPfjgKIAhVpWAEm5RiZBU50LcudsQmqIk1c3DUxEljQT8h+RVMqR0+2S8KeCyPEQWNLZy+MpI5z9/pxhgtNLQV+lkt2v7pRYr0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Gf4vLtto; arc=none smtp.client-ip=209.85.208.196
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Gf4vLtto"
Received: by mail-lj1-f196.google.com with SMTP id 38308e7fff4ca-3322bb2ac6eso41518151fa.0
        for <virtualization@lists.linux.dev>; Tue, 05 Aug 2025 01:53:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1754383995; x=1754988795; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ibHjp0RKgyKqNDDPGolCzlUBv8FDlz7MwKF0ZylR1+w=;
        b=Gf4vLttohFHvnzw9W3ELLPS8EeBP27AlQF5E3Df8mVbzgvaH0f7+PoDiStEEdtIfqJ
         7Hl94GZXeMGs2Lyj948uZRHP7H+CFNl7OG3FPsXCkr7Wc2iyDSQ/hyrxEaXwLJkdDY0M
         YGV/SdvIGbNAPgJFwkSQq9IV92z9YnUIbokI4ST3kD6mz4WPpycbd2jmBLkfSPQSYbpT
         ZM+ajWOzK0ulyjQx7/swsoD0bI9leXKNnaJqNW1ohbz1+HpAdwrll+yHn+ykB5AHTjWQ
         rDyyXZUZo3RdO8t4R3gvhsFVZjkfBZ4EL6j7myyv6s+WFsRhRCY0PWI92A003vMKHNT6
         KuJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754383995; x=1754988795;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ibHjp0RKgyKqNDDPGolCzlUBv8FDlz7MwKF0ZylR1+w=;
        b=sCYBpr7AoUHLoZUA6XObuRAmLF9fDBnPPwBW14bGuQf+F8jfcghf82L0Ve8KGcYpRQ
         RkWBnZCun5okmK42wMDPVAwevZhu05ISsFIY72FZj48NkQ3KQauzSE/TWF+TdgE4IEOd
         GxSzkd+FEgGfmROYihZGspLBD07xFgP130cufVKdtrmUaYIcMi8PgR2Q/j7ywaeVKJPT
         uyrqFNp2N2xrsPOqNhLov8F5lHh+ef6iUlL0YRDKKlU6Xk0mnMAVczHMzQ3GytD9SCDN
         BO1Bbj0BmK3nmqZKZ98xeq1W19CaNFJ+YIZC5BKpIME/DTyBNEpJxl7nbHCLA70XU64g
         fqPA==
X-Forwarded-Encrypted: i=1; AJvYcCUhDShT/27Y36dUm8fLLOPXku80JwDOaI3+gDXuAcIUTbYU2gxiIPcLbi9wBlZvxeea7YvxIq+hD3LB/W/Q2Q==@lists.linux.dev
X-Gm-Message-State: AOJu0YyFUe+ETviYqCfWMHGRbOewRfQDCeLGs1OXc4xUWj+m9VsF7Igs
	IoVJCIUV7d9fJCyTZMNB3XIw2Tj6VLjKWU4ftetWVK9U8BYafM0w408b1h/O2wW0ZqGw7jF/j7n
	9Mj94J+VHjHYtkuLmV8ThZlN6Gwv0Gzk=
X-Gm-Gg: ASbGncv/18oi9g8MoNDSHrXgACOMt32iidb5CNirIKgjaMssIEm1S+3/aeHCjVnU45I
	ZY9YgGLmmfSGzTPZUXEepxB2i75045ANthe2kLHpua5o8xUKvJTi22cltFi5tvPDz1N6nQmYzrv
	7LPPAqiGb8GKvO3rra92c5yHWL/retP8R5uy7A99oX5OCLHn2EbzcCLI6Cojy1JHeWGGm1NDaGx
	pX/URQ=
X-Google-Smtp-Source: AGHT+IFD5XNw8cP384FaLMCLrTz2I87FHqRB6f/qwltp9qO9etEP6nue9QDshjhDWfCXFPjNxtkFMqihQ3uLrVpxQEI=
X-Received: by 2002:a2e:a54f:0:b0:332:45b5:d665 with SMTP id
 38308e7fff4ca-33256709372mr32288541fa.11.1754383994891; Tue, 05 Aug 2025
 01:53:14 -0700 (PDT)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20250805051009.1766587-1-tcs_kernel@tencent.com> <4sbamls46k3dxlqgreifhhhd66iaosbeoxgbpyvwaipwlnwiba@dep4mseknust>
In-Reply-To: <4sbamls46k3dxlqgreifhhhd66iaosbeoxgbpyvwaipwlnwiba@dep4mseknust>
From: henry martin <bsdhenrymartin@gmail.com>
Date: Tue, 5 Aug 2025 16:53:03 +0800
X-Gm-Features: Ac12FXzozgbryRFZfZ8Jbwl1TrTa0Ad2T4Xt810HLdQs9hEAdhKtjpUCUff4i9Y
Message-ID: <CAEnQdOr+Gnk7MW3di-=EDD92BR1C1m0P5pK=Fz6ov5iUH+=u2w@mail.gmail.com>
Subject: Re: [PATCH v1] VSOCK: fix Information Leak in virtio_transport_shutdown()
To: Stefano Garzarella <sgarzare@redhat.com>
Cc: huntazhang@tencent.com, jitxie@tencent.com, landonsun@tencent.com, 
	stefanha@redhat.com, mst@redhat.com, jasowang@redhat.com, 
	xuanzhuo@linux.alibaba.com, eperezma@redhat.com, davem@davemloft.net, 
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org, 
	kvm@vger.kernel.org, virtualization@lists.linux.dev, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Henry Martin <bsdhenryma@tencent.com>, 
	TCS Robot <tcs_robot@tencent.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Thanks for the quick review. You're right=E2=80=94this patch is a false
positive. Modern compilers zero out the remaining fields, so the fix
isn't needed.

I'll be withdrawing all the patches and will ensure we more carefully
evaluate our robot's findings before submitting in the future.

Thanks for your help!

Stefano Garzarella <sgarzare@redhat.com> =E4=BA=8E2025=E5=B9=B48=E6=9C=885=
=E6=97=A5=E5=91=A8=E4=BA=8C 15:01=E5=86=99=E9=81=93=EF=BC=9A
>
> On Tue, Aug 05, 2025 at 01:10:09PM +0800, bsdhenrymartin@gmail.com wrote:
> >From: Henry Martin <bsdhenryma@tencent.com>
> >
> >The `struct virtio_vsock_pkt_info` is declared on the stack but only
> >partially initialized (only `op`, `flags`, and `vsk` are set)
> >
> >The uninitialized fields (including `pkt_len`, `remote_cid`,
> >`remote_port`, etc.) contain residual kernel stack data. This structure
> >is passed to `virtio_transport_send_pkt_info()`, which uses the
> >uninitialized fields.
> >
> >Fixes: 06a8fc78367d ("VSOCK: Introduce virtio_vsock_common.ko")
> >Reported-by: TCS Robot <tcs_robot@tencent.com>
> >Signed-off-by: Henry Martin <bsdhenryma@tencent.com>
> >---
> > net/vmw_vsock/virtio_transport_common.c | 15 +++++++--------
> > 1 file changed, 7 insertions(+), 8 deletions(-)
> >
> >diff --git a/net/vmw_vsock/virtio_transport_common.c b/net/vmw_vsock/vir=
tio_transport_common.c
> >index fe92e5fa95b4..cb391a98d025 100644
> >--- a/net/vmw_vsock/virtio_transport_common.c
> >+++ b/net/vmw_vsock/virtio_transport_common.c
> >@@ -1073,14 +1073,14 @@ EXPORT_SYMBOL_GPL(virtio_transport_connect);
> >
> > int virtio_transport_shutdown(struct vsock_sock *vsk, int mode)
> > {
> >-      struct virtio_vsock_pkt_info info =3D {
> >-              .op =3D VIRTIO_VSOCK_OP_SHUTDOWN,
> >-              .flags =3D (mode & RCV_SHUTDOWN ?
> >-                        VIRTIO_VSOCK_SHUTDOWN_RCV : 0) |
> >-                       (mode & SEND_SHUTDOWN ?
> >-                        VIRTIO_VSOCK_SHUTDOWN_SEND : 0),
> >-              .vsk =3D vsk,
> >-      };
>
> The compiler sets all other fields to 0, so I don't understand what this
> patch solves.
> Can you give an example of the problem you found?
>
> Furthermore, even if this fix were valid, why do it for just one
> function?
>
> Stefano
>
> >+      struct virtio_vsock_pkt_info info =3D {0};
> >+
> >+      info.op =3D VIRTIO_VSOCK_OP_SHUTDOWN;
> >+      info.flags =3D (mode & RCV_SHUTDOWN ?
> >+                      VIRTIO_VSOCK_SHUTDOWN_RCV : 0) |
> >+                      (mode & SEND_SHUTDOWN ?
> >+                      VIRTIO_VSOCK_SHUTDOWN_SEND : 0);
> >+      info.vsk =3D vsk;
> >
> >       return virtio_transport_send_pkt_info(vsk, &info);
> > }
> >--
> >2.41.3
> >
>
