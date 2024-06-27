Received: from mail-oi1-f178.google.com (mail-oi1-f178.google.com [209.85.167.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA1FE17588
	for <virtualization@lists.linux.dev>; Thu, 27 Jun 2024 03:37:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719459460; cv=none; b=seO8ALOVxZwy1oFS+gubLT82c9BMt5hKo3EM2t6MSTfcEPBcJbIBKZBjW8ZBdtzuPYzv9VTRNeQ986JcN7xHocHEAI/oMUvUJtdehsS7lLHjpwEfNw28l4i9KkST24zn1fvzBWPYOFU63p9j7vHftD17EI5wvkQRdgbhe420zJg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719459460; c=relaxed/simple;
	bh=wJ7aj6V02RGQPLH6KMM+51qFYpgYMN3gYv3bgJwF+FM=;
	h=Content-Type:From:Mime-Version:Subject:Date:Message-Id:References:
	 Cc:In-Reply-To:To; b=D3kOeOTKFinDVCDJdooElFGkOE2xFAjzUAnw2obnXp/7POyhuSNMQhkOye3Xk8zU+Bhd2pg5bKRdkErrZDUmv01salv+NoI9cN4Icd6cs5tOeq8tnDnAOkh/qpwIwhVf9u68f9kKOhYFnz6kRXNUkLHpkaMxISKN2x22BSOSDSw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Rwpw3p9T; arc=none smtp.client-ip=209.85.167.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Rwpw3p9T"
Received: by mail-oi1-f178.google.com with SMTP id 5614622812f47-3c9d70d93dbso4996273b6e.3
        for <virtualization@lists.linux.dev>; Wed, 26 Jun 2024 20:37:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1719459458; x=1720064258; darn=lists.linux.dev;
        h=to:in-reply-to:cc:references:message-id:date:subject:mime-version
         :from:content-transfer-encoding:from:to:cc:subject:date:message-id
         :reply-to;
        bh=btL9frXHn5bucfqfBQ8J86OleIxFKMIHqIH1Tkvc2+Y=;
        b=Rwpw3p9TAA0RHcPGfjrw2OPswmRxEz4g2ORb2e/FcMh/zpEh1eKO/zXuJpFtaeHpA/
         Nt9A8Z+q1WUBayKz2KHW8RmM27NqbsOoC58jDL7KDcTXSPXcUeSb7HDtWBXiYHMv7AoS
         U5Yf6bnj9tVEkSURRhbMwl/bTAHerPPTZEkN/BT2Sg8ILl6xhe1McfI79saxDcrN7Bfa
         J/btqMU6WHhm4Cxl/d0PESubGZHFgubjLp83NZ72GxMARF7OltPOSLKyjBWuDsl9ZE/C
         VedCj79XAGqx8DvfdrfERkfekObTtxWrxU3lQxT9NgIs81M/kgokizggxbPWt5U0PBYk
         uXrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719459458; x=1720064258;
        h=to:in-reply-to:cc:references:message-id:date:subject:mime-version
         :from:content-transfer-encoding:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=btL9frXHn5bucfqfBQ8J86OleIxFKMIHqIH1Tkvc2+Y=;
        b=vbOmBkhxl7tYbN2folmru2FbvFAEW5eLjmAaJ77o/LyaZ7iGVgr5jRxhSxpC733qYy
         QfPb69og2+MN0LDi5EZ/AaHualDZ1SyhuUOah1RbFaCKyfuuVDEF1iAbds9V0vXRCZ91
         fo0IrGwsM2gIhOzIu9paQ8kYIlhVZ5Pfi4/S9XH6FnGi+Fis3CdKylo2uimn74kbE38/
         P4qqjHvCtU1ePfojUU3A3uws/PpltHM8NgFV3mS9YZlZHEiBDDkzWqNtuGNkwFiZwdjx
         i++suNx9K5r29XCW9LaPItypo+nQnlUIoUOcY5/ijtx/NoYDdwQph41fegrh8LtaG5kC
         t3BA==
X-Forwarded-Encrypted: i=1; AJvYcCXms11hyykKC0fBdXVWMdpOvkqlGPqHAsA9bNQmYAPBRwzR7zcbIYeVZ6z/2EajutD0E4MG3VBoT3eqCWzpvtpIy8UGshikBJR0kECna9g=
X-Gm-Message-State: AOJu0YzKGUw0SPwKd0uGNh6AXnD0EsirAnu3cFM8IPoYoO01NyLozCLp
	zoMADmSJRi3Uy5ZUXxFIAbXKVOQDUVB+MJhUCxTClMlJp5daFAy+
X-Google-Smtp-Source: AGHT+IGVDdwvf48/nQa5AnQqEU/GPUM5E0o40jNlS5HJEw1xlJF7yk1hxW3f5GLk6bzUTo1BS4p2uQ==
X-Received: by 2002:a05:6808:170f:b0:3d5:1bd8:ab18 with SMTP id 5614622812f47-3d545979603mr13684952b6e.24.1719459457698;
        Wed, 26 Jun 2024 20:37:37 -0700 (PDT)
Received: from smtpclient.apple ([2001:e60:a809:eceb:bd02:cb72:6ee8:4792])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-706b4a07a30sm252681b3a.139.2024.06.26.20.37.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 26 Jun 2024 20:37:37 -0700 (PDT)
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
From: =?utf-8?B?67CV7KCV7KSA?= <aha310510@gmail.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
Mime-Version: 1.0 (1.0)
Subject: Re: [PATCH] vhost/vsock: always initialize seqpacket_allow
Date: Thu, 27 Jun 2024 12:37:24 +0900
Message-Id: <4C39A362-74E3-4762-82AD-D8B15AA38B10@gmail.com>
References: <bcc17a060d93b198d8a17a9b87b593f41337ee28.1715785488.git.mst@redhat.com>
Cc: linux-kernel@vger.kernel.org,
 syzbot+6c21aeb59d0e82eb2782@syzkaller.appspotmail.com,
 Arseny Krasnov <arseny.krasnov@kaspersky.com>,
 "David S . Miller" <davem@davemloft.net>,
 Stefan Hajnoczi <stefanha@redhat.com>,
 Stefano Garzarella <sgarzare@redhat.com>, Jason Wang <jasowang@redhat.com>,
 =?utf-8?Q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>, kvm@vger.kernel.org,
 virtualization@lists.linux.dev, netdev@vger.kernel.org
In-Reply-To: <bcc17a060d93b198d8a17a9b87b593f41337ee28.1715785488.git.mst@redhat.com>
To: "Michael S. Tsirkin" <mst@redhat.com>
X-Mailer: iPhone Mail (21F90)

nice patch

> 2024. 5. 16. =EC=98=A4=EC=A0=84 12:05, Michael S. Tsirkin <mst@redhat.com>=
 =EC=9E=91=EC=84=B1:
>=20
> =EF=BB=BFThere are two issues around seqpacket_allow:
> 1. seqpacket_allow is not initialized when socket is
>   created. Thus if features are never set, it will be
>   read uninitialized.
> 2. if VIRTIO_VSOCK_F_SEQPACKET is set and then cleared,
>   then seqpacket_allow will not be cleared appropriately
>   (existing apps I know about don't usually do this but
>    it's legal and there's no way to be sure no one relies
>    on this).
>=20
> To fix:
>    - initialize seqpacket_allow after allocation
>    - set it unconditionally in set_features
>=20
> Reported-by: syzbot+6c21aeb59d0e82eb2782@syzkaller.appspotmail.com
> Reported-by: Jeongjun Park <aha310510@gmail.com>
> Fixes: ced7b713711f ("vhost/vsock: support SEQPACKET for transport").
> Cc: Arseny Krasnov <arseny.krasnov@kaspersky.com>
> Cc: David S. Miller <davem@davemloft.net>
> Cc: Stefan Hajnoczi <stefanha@redhat.com>
> Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
> Acked-by: Arseniy Krasnov <avkrasnov@salutedevices.com>
> Tested-by: Arseniy Krasnov <avkrasnov@salutedevices.com>
>=20
> ---
>=20
>=20
> Reposting now it's been tested.
>=20
> drivers/vhost/vsock.c | 4 ++--
> 1 file changed, 2 insertions(+), 2 deletions(-)
>=20
> diff --git a/drivers/vhost/vsock.c b/drivers/vhost/vsock.c
> index ec20ecff85c7..bf664ec9341b 100644
> --- a/drivers/vhost/vsock.c
> +++ b/drivers/vhost/vsock.c
> @@ -667,6 +667,7 @@ static int vhost_vsock_dev_open(struct inode *inode, s=
truct file *file)
>    }
>=20
>    vsock->guest_cid =3D 0; /* no CID assigned yet */
> +    vsock->seqpacket_allow =3D false;
>=20
>    atomic_set(&vsock->queued_replies, 0);
>=20
> @@ -810,8 +811,7 @@ static int vhost_vsock_set_features(struct vhost_vsock=
 *vsock, u64 features)
>            goto err;
>    }
>=20
> -    if (features & (1ULL << VIRTIO_VSOCK_F_SEQPACKET))
> -        vsock->seqpacket_allow =3D true;
> +    vsock->seqpacket_allow =3D features & (1ULL << VIRTIO_VSOCK_F_SEQPACK=
ET);
>=20
>    for (i =3D 0; i < ARRAY_SIZE(vsock->vqs); i++) {
>        vq =3D &vsock->vqs[i];
> --
> MST
>=20
