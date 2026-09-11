Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com [209.85.208.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 404053DDAF3
	for <virtualization@lists.linux.dev>; Fri, 11 Sep 2026 02:18:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789093092; cv=pass; b=H/kfcpqrLYRO8vN/pVGGNt6DqNvXaBpnqYYRDSe1jIWzxSYjJyDUnPVVKg8ezavPMj4UHLqpbuzFxzhghXe3YOmCfnJ2LPWbwAlG1OHx4nZTN0c/Kh4uM03zr0lICFT4FBIODhwkHWM1TOHVEUTUF/QJA+8fDkd5BN6fm1xOHc0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789093092; c=relaxed/simple;
	bh=fSxVRMq132kOj2ATc0wCqEK6btSyS1N+nOlxjKOO1SI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=WOCsl9a9ovKe12vU+gMUUz5Qw8VaKbVUPpU33aDXk7SZqxT8hjWx2RxeMHkJN9yG5PA0ZGZ/sbmbSs4ENIk6Dffcp7Gz1IOtZvfEJXuj+j2DyyK0/Xrk/bGUI2E6v4NbhkA5bQM2UgBI+XCF4Tpx19/rr0gE4Riw4fXbeatfSQ8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZuX1Yzo6; arc=pass smtp.client-ip=209.85.208.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZuX1Yzo6"
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-6a051b737d8so475057a12.1
        for <virtualization@lists.linux.dev>; Thu, 10 Sep 2026 19:18:06 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1789093085; cv=none;
        d=google.com; s=arc-20260327;
        b=O8efMcCjgYFCtt5iwVIuEdB+6rcsTJMjQx3p+IbyKLnhvCkhyyhdbXyZNYkkUxQVjV
         o0yrOL7B3Afb2zEMI9XJyb5xbLOLfa6/wTJo7nj2lP17HT73z1RNiGKhBaiwjgabWv3a
         dxoSVEztAWf+fNRWNkY63mT82wrtysAFNDs4gXMtiqoxnyiF9zG/iFpZGtD8ViJyVg6A
         fGLPNHbnemD1XocO1GN2tS90DFrFr/digcxZY2+HJgtD3R132x8ljnl4jbvRnvMJ5/xx
         ITzuEFdZA20eaE6g2vn9M2/ZNXi6SdSIbIieu7FVaaimqXE8n14jEgMeEIKFyax7IJ6S
         TyBg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=VOf8wCMzpNS46oThIuz/r1xf8XxutZ0hada+Stru3rY=;
        fh=DMPYVrxdtj+pFO7iTGkU8tKtf44FCUQqA2CHP9c9kDA=;
        b=rEmWcXVvMLaiEyraxJ+zlrIbFDUUvIX/hh9LWtqf43j0FKlQx45fNQqW6BjPcgmHni
         s7XuaXdnpx2yvwlmLYtIzolUByZhehbQq67Z+RP8BA08j+dnPkhJEttbJT1J0UORCLzi
         WVsB64M4Y0z2lPpJj/6hCWIWVCRMkuKn771BWUX5zgOnTE7VI2pPFkQNpTofkjFK56AB
         le1MjDEbkwJ/QaDkGmj+wCSwZXhWDUYfmW/3GxPkGFvHuYQhFD8j8QOgVoIxPWGRGr+T
         lwk+GrO5oYjdaGdpEl2V6/Od/6VD7zHcTBFJwRxm80fN/CM8qcT/dr4GXtdqZrHXTbtv
         4/2Q==;
        darn=lists.linux.dev
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789093085; x=1789697885; darn=lists.linux.dev;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=VOf8wCMzpNS46oThIuz/r1xf8XxutZ0hada+Stru3rY=;
        b=ZuX1Yzo64a9mUfvhVV/H/ozpnjfdjRy+zssc1Bf6sjuK+GsUzmVFTjGZrQC1MseXrU
         bTLpG09N5WOhA9omOlhl8A7HBTB0PCqjD7nTpzcbG3BLGBlviq3qfajWNHgESxKQxR6O
         8iUN68l4xmIGSaC+cH73yEWy5heDJjVxlDMP0gX8pEaj4L+g0SLLOGEcfsjGiD1mBTJa
         d/9cOz30OXZaw5jWIP7LNsRNOcvAhrrPvLBF96nDmWT7Me/vmTevC+GjnkNG+DYMLUqO
         /gKEmbc8jBqMQlnxtNajeZKn+iCF9oMGqctUTpci4m8HJgxgr6zSS4a3K/B4mvK3EiMe
         GFFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789093085; x=1789697885;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=VOf8wCMzpNS46oThIuz/r1xf8XxutZ0hada+Stru3rY=;
        b=buiRh6cmX/kYrr5is1No/uuRuvp1lG43bWL7KesbJqijAY3hZsHMyoP4cwG2FhqYPT
         Jze7UWSc5auwBNrHpHlWehITnZJA9r6tmgFn7GJOEZOYOyWP1ywdpRxpsVNBZ94szBy9
         um/ouDK16g5n+vrRn5+bM1UNI4jxHmB08DkpgkVJ2V1gRHiNl9LK1tgsofnVbGu5otJA
         mh6YwvZD95AuKx3kXiju5d6V+nBSjOGzWYPWgfCvfCd6R646arZW350414D+jPuNVWFW
         n4f5K7yIUOj7qKVUkJEUWxWiou4XDPmToovDZ3gyfH8z+AGvE/BuE0FkQzRE3Vg0YQdr
         5y6Q==
X-Forwarded-Encrypted: i=1; AKwUvBwffiJXohbT1BhEA94SlmUoPP7JGlvv0UOjy3WEByzsdW6IFb9zA7uGbNtvHKgVo1ELRNSCYYnBiAMAsQc7EA==@lists.linux.dev
X-Gm-Message-State: AFuF++lWJLjA1avDcICnSt0WWftCqlpP2/jV+9yluDNtX6lgU6pDjZrk
	DhYsan08VAD5kSIVNXvaJ6/tLk3gmperATV6T0U7nPHT8WQjvnhoeKM4CHBiJQswlNv7qkahjtM
	2SDu0xWtW6zPpJHs2Y2YU9VFMm6Z+AMU=
X-Gm-Gg: AYBFou39gh88G81JAkD9ZKAzlTNWY9rtP0WGYy2pQ+maRop4zT2b4zZXZvku6SCTH2b
	2TxSLJHZzZqrv2RQPQaRymODF9BDLX4bLOeZ8viiX5w21hOpwvgN1a7fHCEbGDcH+GIoX5Jrjr+
	f1Xe8LStC41/ql+R64gNjK31A53gf+Ffcqpar45zATay+XsXh3X54f2P65pN33Fb4Uo1bTNEDtO
	UR9RbNKUo02wonFw9PFlFBVnyVA4fC70TxDJgI0EULBbFSDM5sXCZ2ncQxB2xODwd6Ivgw0y8yt
	zr+eiMZdVf86U74XZGjZosZIi1sdSkgd2gq9J3ssCImDXN8yHOqmA1RyIy7IS5lnlBgVR0RVTaa
	d06QWN4UomAlirQAEpiz/4g==
X-Received: by 2002:a05:6402:434c:b0:6a7:ee54:f89b with SMTP id
 4fb4d7f45d1cf-6a9b56b92aemr845829a12.31.1789093084498; Thu, 10 Sep 2026
 19:18:04 -0700 (PDT)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20260910123903.1717-1-lirongqing@baidu.com>
In-Reply-To: <20260910123903.1717-1-lirongqing@baidu.com>
From: Jason Wang <jasowangio@gmail.com>
Date: Fri, 11 Sep 2026 10:17:52 +0800
X-Gm-Features: AcwNN1Vwyl3IOS3-AfXLFBbOtS2xium60bWgjIdD1Wj01boHjLIsh_FiFaULx-Y
Message-ID: <CAAf7B_M=tfyL33WGkxSX68FwPaRRRBcASVx92EGwPMXaFtUdzQ@mail.gmail.com>
Subject: Re: [PATCH] virtio_ring: reset IN_ORDER state in virtqueue_init()
To: lirongqing <lirongqing@baidu.com>
Cc: "Michael S . Tsirkin" <mst@redhat.com>, =?UTF-8?Q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>, 
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>, virtualization@lists.linux.dev, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 10, 2026 at 8:39=E2=80=AFPM lirongqing <lirongqing@baidu.com> w=
rote:
>
> From: Li RongQing <lirongqing@baidu.com>
>
> The IN_ORDER feature uses additional software state to track the next
> available descriptor and in-flight descriptor batches.
>
> virtqueue_init() resets the common virtqueue state, but free_head and
> batch_last.id are initialized only when the virtqueue is created. When
> an IN_ORDER virtqueue is reset, these fields can retain state from the
> previous queue instance.
>
> Reset free_head and invalidate batch_last when initializing an IN_ORDER
> virtqueue. Keep this in virtqueue_init() so the state is initialized
> consistently for both newly created and reset virtqueues.
>
> Fixes: f6a15d854986 ("virtio_ring: add in order support")

I think this is needed for -stable.

> Signed-off-by: Li RongQing <lirongqing@baidu.com>
> ---
>  drivers/virtio/virtio_ring.c | 5 +++++
>  1 file changed, 5 insertions(+)
>
> diff --git a/drivers/virtio/virtio_ring.c b/drivers/virtio/virtio_ring.c
> index db678f5..d0dc464 100644
> --- a/drivers/virtio/virtio_ring.c
> +++ b/drivers/virtio/virtio_ring.c
> @@ -559,6 +559,11 @@ static void virtqueue_init(struct vring_virtqueue *v=
q, u32 num)
>         vq->in_use =3D false;
>         vq->last_add_time_valid =3D false;
>  #endif
> +
> +       if (virtqueue_is_in_order(vq)) {
> +               vq->free_head =3D 0;
> +               vq->batch_last.id =3D UINT_MAX;
> +       }

I would try to reuse or refactor virtqueue_vring_attach_split() to
reduce code duplication.

Btw have you checked Qemu shadow virtqueue as it might suffer from the
same issue.

Thanks

>  }
>
>
> --
> 2.9.4
>
