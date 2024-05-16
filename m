Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A67D138C
	for <virtualization@lists.linux.dev>; Thu, 16 May 2024 13:38:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715866704; cv=none; b=MIQWHJbMmHZRO3XBWaVGujrrwYdC3FRz/udO2XvDEH/33OoM521wkkpdhYlaff0anvNNY+vqPO6AcYw4xYWBUfbVPMl8kvHg7QKjXHDVZurkKXymF3WoBXA3Soprv2eIRNy2quJ6Yc0X1Rm/NrttmzQxOdJHkDfXFzGIbfXbYe4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715866704; c=relaxed/simple;
	bh=H4uJfIWjhvWKU9/lF6/ReCaGNL4KXA9cAwJNwXPUNXM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=jENUV222BgPTDkhbT35OaJSwmEHAXAPHyWYYr+1CPqnQes3Qym+KqmjlXI2bbOMf2sFyUdHraJn8KwusWkPgDDy9qpLhkjjwcCGpd0V2W0UxfQxTJPXeSxTtHaO2QJrbvnpxOMLLmtixDm2TOAq5TtFemwAtvsWUc8KB/c5AJwY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=CbQzUSOQ; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="CbQzUSOQ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1715866701;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=9MotCgp3e2fj15EogMUNC34bh/DK0Sdeid+nwujT2pQ=;
	b=CbQzUSOQyoklWKj2KBBe8p70Kcp2WX4WZQL7BApCgQwD5x5kfpvBmzU2uWTIqlH0avP14t
	83qNcPcrzBqnB+Maf+Dp4IYHf6FTf4AdrdPLz79DpGgPTFLnUMXx25ZqEfn4ZJYxxD0I+K
	KaRmDKcfDHlyoxZJwxyxlcdAKhDuo/I=
Received: from mail-yw1-f198.google.com (mail-yw1-f198.google.com
 [209.85.128.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-517-qDo_f4-pMsirX8z7M5YLgQ-1; Thu, 16 May 2024 09:38:20 -0400
X-MC-Unique: qDo_f4-pMsirX8z7M5YLgQ-1
Received: by mail-yw1-f198.google.com with SMTP id 00721157ae682-6207c483342so143613137b3.1
        for <virtualization@lists.linux.dev>; Thu, 16 May 2024 06:38:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715866699; x=1716471499;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9MotCgp3e2fj15EogMUNC34bh/DK0Sdeid+nwujT2pQ=;
        b=I/AaffDz805+fKtZXRUD37mhOrTHg7fl+adFocB7dDGXIxc3XB8rGS5YjNRzUmR8wa
         F6TPiaKDxzWoTA9RcQXjiD2jR2JFaHXTkqrOKtXsfy+s4LQDe90pjbOskh6x7RmLyLps
         AkXI+NpBgqgAQLLuw0fjVnKz39uDP+8HhT/jKuSEJLZxduGB9nfSLFy0c9rTgpLxGoSK
         bSPCsnoOnGLur7MbLIaqcPg3JPqhM0E6wNm8+A8SGkqdHCuRMcnqVwXFO6lq/GjA/VHx
         WIyQFfE8vkpT+wnTv78VAgCTDllIrsr77k2GihMdXwi/se5O4+C2wkYBs+xHpSt8pVUe
         9cVA==
X-Forwarded-Encrypted: i=1; AJvYcCXbdqGAoG2FA+cKD5Mr93EAnthLrnVxuetJ5vQdTCGay9WrfgHucQEq7BNKbBujmirg58Ykrtcrlo6oQMDajUfpEL3Q0+AyNI4Q6k0wcE0=
X-Gm-Message-State: AOJu0YxFS4ZTY/mtTDRJZYyERLeupl6yYI3TgV2GHI0HWWOglbNtz8Dd
	KcFwkwgLi9ya8LVi3qpawQSIji0ExVewDS6lnfj1gQtpkPNOBA7GSiCGgLg3qoymQTcjm45+dNc
	7tShkrCGDogyhO+xMRJL5NUnYCfTzQ+Jlb2G8kTkjG0zKxOZHEnJXKQMRM9912r2tbHYmog3kPN
	DfgtyS/XMgN9Ri+wWN26bsYtk22cDwNo5oCsT1d60=
X-Received: by 2002:a05:690c:b9d:b0:615:8c1:d7ec with SMTP id 00721157ae682-622b00218ccmr188220117b3.33.1715866699402;
        Thu, 16 May 2024 06:38:19 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE4QKAuxEG0E9OIW18GgVRzmoNCx6cWbvCv+mq9BFFlhSCQTKIOOTMs34WnZPrmXQWnkLEbeQ4BQeEoXduizoU=
X-Received: by 2002:a05:690c:b9d:b0:615:8c1:d7ec with SMTP id
 00721157ae682-622b00218ccmr188219907b3.33.1715866699113; Thu, 16 May 2024
 06:38:19 -0700 (PDT)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <bcc17a060d93b198d8a17a9b87b593f41337ee28.1715785488.git.mst@redhat.com>
In-Reply-To: <bcc17a060d93b198d8a17a9b87b593f41337ee28.1715785488.git.mst@redhat.com>
From: Eugenio Perez Martin <eperezma@redhat.com>
Date: Thu, 16 May 2024 15:37:42 +0200
Message-ID: <CAJaqyWd9-fhrxBv3gTq82bGnSVdC_vw_LXg+XVNHT3B6cD0VOg@mail.gmail.com>
Subject: Re: [PATCH] vhost/vsock: always initialize seqpacket_allow
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: linux-kernel@vger.kernel.org, 
	syzbot+6c21aeb59d0e82eb2782@syzkaller.appspotmail.com, 
	Jeongjun Park <aha310510@gmail.com>, Arseny Krasnov <arseny.krasnov@kaspersky.com>, 
	"David S . Miller" <davem@davemloft.net>, Stefan Hajnoczi <stefanha@redhat.com>, 
	Stefano Garzarella <sgarzare@redhat.com>, Jason Wang <jasowang@redhat.com>, kvm@vger.kernel.org, 
	virtualization@lists.linux.dev, netdev@vger.kernel.org
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, May 15, 2024 at 5:05=E2=80=AFPM Michael S. Tsirkin <mst@redhat.com>=
 wrote:
>
> There are two issues around seqpacket_allow:
> 1. seqpacket_allow is not initialized when socket is
>    created. Thus if features are never set, it will be
>    read uninitialized.
> 2. if VIRTIO_VSOCK_F_SEQPACKET is set and then cleared,
>    then seqpacket_allow will not be cleared appropriately
>    (existing apps I know about don't usually do this but
>     it's legal and there's no way to be sure no one relies
>     on this).
>
> To fix:
>         - initialize seqpacket_allow after allocation
>         - set it unconditionally in set_features
>
> Reported-by: syzbot+6c21aeb59d0e82eb2782@syzkaller.appspotmail.com
> Reported-by: Jeongjun Park <aha310510@gmail.com>
> Fixes: ced7b713711f ("vhost/vsock: support SEQPACKET for transport").
> Cc: Arseny Krasnov <arseny.krasnov@kaspersky.com>
> Cc: David S. Miller <davem@davemloft.net>
> Cc: Stefan Hajnoczi <stefanha@redhat.com>
> Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
> Acked-by: Arseniy Krasnov <avkrasnov@salutedevices.com>
> Tested-by: Arseniy Krasnov <avkrasnov@salutedevices.com>
>

Reviewed-by: Eugenio P=C3=A9rez <eperezma@redhat.com>

Thanks!

> ---
>
>
> Reposting now it's been tested.
>
>  drivers/vhost/vsock.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/vhost/vsock.c b/drivers/vhost/vsock.c
> index ec20ecff85c7..bf664ec9341b 100644
> --- a/drivers/vhost/vsock.c
> +++ b/drivers/vhost/vsock.c
> @@ -667,6 +667,7 @@ static int vhost_vsock_dev_open(struct inode *inode, =
struct file *file)
>         }
>
>         vsock->guest_cid =3D 0; /* no CID assigned yet */
> +       vsock->seqpacket_allow =3D false;
>
>         atomic_set(&vsock->queued_replies, 0);
>
> @@ -810,8 +811,7 @@ static int vhost_vsock_set_features(struct vhost_vsoc=
k *vsock, u64 features)
>                         goto err;
>         }
>
> -       if (features & (1ULL << VIRTIO_VSOCK_F_SEQPACKET))
> -               vsock->seqpacket_allow =3D true;
> +       vsock->seqpacket_allow =3D features & (1ULL << VIRTIO_VSOCK_F_SEQ=
PACKET);
>
>         for (i =3D 0; i < ARRAY_SIZE(vsock->vqs); i++) {
>                 vq =3D &vsock->vqs[i];
> --
> MST
>

