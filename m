Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com [209.85.208.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64C1A3C1090
	for <virtualization@lists.linux.dev>; Fri, 11 Sep 2026 15:32:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789140749; cv=pass; b=ojFR2adLNjj320PjEtwKD/8BKXv1NxAJQHZA+g9MC5Xv5v4sdm/W/nBt391zTcvJxo6cZzypITufIDUde2N/tlv+8wxdT4TE02SjnhwAwoU/9cmnkvWBYvCzQF5aEJys0GGhZ0J2hiT6z42cbSUrAaY3NJvH4zqa3CwnlFUawJU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789140749; c=relaxed/simple;
	bh=DkIYo85Pn4ngA9GK0ES4cPklKc4uBJicpFFxWLmU/j4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=TzrO3AVbEsfKfSlJF+ql4UHNPNQvkSk+WOmqDNm3m/Lsp7oIorda6s/Y96og+BJfo7LUQvDwEkoIjdTVEIGyyfe1XoFU+QOrX510ap70Xi2tOkxaZvix7xT3GSXuSfYINCfG60Pjak0tLBVvQ+0gsUMCW1jN2uz9FXhl41H3HsY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ii0r4tOW; arc=pass smtp.client-ip=209.85.208.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ii0r4tOW"
Received: by mail-ed1-f49.google.com with SMTP id 4fb4d7f45d1cf-6a051b737d8so1199814a12.1
        for <virtualization@lists.linux.dev>; Fri, 11 Sep 2026 08:32:27 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1789140746; cv=none;
        d=google.com; s=arc-20260327;
        b=NgdR/rniF/q/5C0kR/OOxPgbqE00wQe/FDvOUnU3wAZHl+/Avw84MtALs5sWdxkTWv
         ybc5cWu+5T/B6ZR18D3XJq2hmFvIJhb+xl7ABfucKT4eFwdDxCBoiyk8h2BMY7mp/a9q
         rUHas7D6NRqb13SzKBYM281vSJQIwfejGvd0Qm7UxcDdl6Pe2qQQWOs845UwR4iaejLK
         pnGnXh3+AfOVZpR3gWGW3yVr1X7r88Iwn0aylL2d5m9CgP+qxywWzAvrATKop/kR3bhp
         YSfL0Ct2FWJw1/HDERmmLPiyj6s4r7hg3lbYMq3h+sQ8Cl/bM9sxFeaQs1s+uLaSwoYr
         qr5A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=jfN2aS/+tGG4m/Gr1t61ow0ODqlfB2pmuz3SNqMPHwA=;
        fh=sTFT1JEaiqJYby08/NTXYM4dPisCONKeibf8RTRbIag=;
        b=mEjJGi2CRq2S7NihpZkIK+SD3WBNKLzCzUKKVFv000MtOZ13HrUkjLC2RBEwxuIdVP
         HELUPw5Rh/FCQoVQIbouNgjJYoih0cLFh+OawefD8xRKTNiDRo/FZIrFAdBLHoctvj3r
         XG0wXd4iV21mMCUzglqmjurZ1cWoIAypb2T7abTjPASXr+gfI+U0D2ydmThMvgeFyVtL
         HDmUlp4Cy6B63bt3NmiwAiyLuAfGhkkJK1xOIwOfxBSdkjmFLak/5H5sgZo6cyOv7AP3
         mm+zeN8uh2P9AlgzFK7JKT8XtPEVv5X2etsTHWokimcp3WdvYeGqZd855CP5SDqc+SYS
         wD4A==;
        darn=lists.linux.dev
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789140746; x=1789745546; darn=lists.linux.dev;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=jfN2aS/+tGG4m/Gr1t61ow0ODqlfB2pmuz3SNqMPHwA=;
        b=Ii0r4tOWKKwwLjVGqpKpd1lyZd0BxwzszciD6Ee6AXreIJup+kmfQYjq9Fj0I2S7NN
         RirWRyccBTE7I6n7YVyoMhlpl8PbkLasUJ0XwTVcuUHnSRjK99xEnmSqBupbGZJyPrLP
         8z5jCwBI0asrlsFh6MrtDne3gtBJkgJIYQNqdkj1pyfRvzPD2PoWVuR8K/Kw5wbzGVx6
         2UMAeRV1+7Pal7TijLGf8E8bY0NCvGVw67GKPpcaXH5be51LbQo4Zqf+ySuvGKrDERVe
         MBCVdNgtb1FsnB5adjjBPKEMTe2TPvvrVqa5H4t9NSCs2OaT1/u0nPnrv4gSrRo4vafn
         YsGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789140746; x=1789745546;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=jfN2aS/+tGG4m/Gr1t61ow0ODqlfB2pmuz3SNqMPHwA=;
        b=qq96rXyC3lEZl9+UdJgjsBGIUr40acvEGxHJNE60NUtDu5oCWlK1IqEWrgOmhRoqbZ
         AvS5xL1bcA2cWTLbGQWpuOdBaQAiEwjRD0GVQ7+H4IMqTiPlUffsmtZpX5X8XhDa9zYQ
         A/d/tvbObP3pb2aLKsPex/bBHLiGqo5TMCXM3IEeUOhawhk8kMfwjQ1nntDxlh7n8LRK
         g/bFWxBgTCk+38sxeaRHbyaKHywLNhLZHVUem7ngS8eF2QE4JTMyDOKD2xN2aZ8byS8o
         CpZOHZk3WQuSItNi19dvRHgfGuMKJTeOJE3D2d1+0NEj4xR/IR++bHts28JNc0N5ohSt
         U6iA==
X-Forwarded-Encrypted: i=1; AKwUvBwmsLcSqHmK9GYAeLEdI4gU2IdThgFNmh4Qd7ZvZEZtASuM+34mdt93UCc43bbKC/w2gxKVnWg/D0sDIBRTmA==@lists.linux.dev
X-Gm-Message-State: AFuF++mvDi9hL6OKwx7n2r8A2M04sblesiJdDYbkAZSdfvmhmWi57f7Q
	oUlg4JXscBLhCV32/wULJI49S9ou/+I7Krs8ptIRic5PxPbI/OKIU8lc90C3fUY4J35WAKHbLok
	u2AHuOSf5MFKl3Ab7559Ef9VY5kNTYXQ=
X-Gm-Gg: AYBFou1X47vGvjQ7zR5NTtvSwCP+TxNoYU2iNiXJxXRBYU7W3Lc+aPm8LVEFTLVP7RX
	K/6CiWGHa/P6dcdsgXN7bjIis3cIu5eV5cv6xCPu9475IvIvNBrbu7AC/VOrOVHljQExxgvC+Sv
	PAZfhCfW5glvUChyAH3JA7zY4kp9Go8AS5JtBLeFBx152H6wkwn7lJAt0jXTorejVtDVCe007ES
	esernTRRhbPnjoTkQ76oarq01vsNkNMbdZAAJrJqin9k8+4hD1DcY6yT8woJSyRDm1miTwsHo8A
	Fl/sQprifbrTtp4eO81Xd4d/M6qzGZwiCIy6OhKWpM86nW6nPQr0T6PIw6sSTtZb0LiccKMgmzp
	NBn0CP/JDk49uLQ==
X-Received: by 2002:a05:6402:518c:b0:6a7:ee54:f897 with SMTP id
 4fb4d7f45d1cf-6a9b56a48c9mr2177348a12.27.1789140745444; Fri, 11 Sep 2026
 08:32:25 -0700 (PDT)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20260911144204.2089401-1-dmitry.osipenko@collabora.com>
In-Reply-To: <20260911144204.2089401-1-dmitry.osipenko@collabora.com>
From: Yiwei Zhang <zzyiwei@gmail.com>
Date: Fri, 11 Sep 2026 08:32:12 -0700
X-Gm-Features: AcwNN1V_cGfwO5j1Bxt8GNsLjTC8MCOtlSabaRFMfY5X1VvYPK3yIDdCB9APKfE
Message-ID: <CAJ+hS_j5w1sfpLS91HC_dSDgdK-=0z3PemY51hUbJVLW-wyF1g@mail.gmail.com>
Subject: Re: [PATCH v1] Revert "drm/virtio: Allow importing prime buffers when
 3D is enabled"
To: Dmitry Osipenko <dmitry.osipenko@collabora.com>
Cc: David Airlie <airlied@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>, 
	Gurchetan Singh <gurchetansingh@chromium.org>, Chia-I Wu <olvaffe@gmail.com>, 
	Val Packett <val@invisiblethingslab.com>, dri-devel@lists.freedesktop.org, 
	virtualization@lists.linux.dev, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Sep 11, 2026 at 7:42=E2=80=AFAM Dmitry Osipenko
<dmitry.osipenko@collabora.com> wrote:
>
> Guest userspace may import udmabuf to vrend. Vrend doesn't support guest
> blobs, and thus, further 3d operations with the imported blob are failing=
.
> Typical scenario of the problem shown with mouse cursor RGBA image import=
ed
> into virtio-gpu, which previously was rejected by virtio-gpu driver.
> Revert enabling guest blobs importing into vrend to fix the regression.
>
> Link: https://gitlab.freedesktop.org/virgl/virglrenderer/-/work_items/674
> Fixes: df4dc947c46b ("drm/virtio: Allow importing prime buffers when 3D i=
s enabled")
> Signed-off-by: Dmitry Osipenko <dmitry.osipenko@collabora.com>
> ---
>  drivers/gpu/drm/virtio/virtgpu_prime.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/virtio/virtgpu_prime.c b/drivers/gpu/drm/vir=
tio/virtgpu_prime.c
> index 149e6bcb5878..ebf471044d06 100644
> --- a/drivers/gpu/drm/virtio/virtgpu_prime.c
> +++ b/drivers/gpu/drm/virtio/virtgpu_prime.c
> @@ -349,7 +349,7 @@ struct drm_gem_object *virtgpu_gem_prime_import(struc=
t drm_device *dev,
>                 }
>         }
>
> -       if (!vgdev->has_resource_blob)
> +       if (!vgdev->has_resource_blob || vgdev->has_virgl_3d)
>                 return drm_gem_prime_import(dev, buf);
>
>         bo =3D kzalloc_obj(*bo);
> --
> 2.55.0
>

r-b. Thanks for the prompt revert!
