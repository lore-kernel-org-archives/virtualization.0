Received: from mail-io1-f54.google.com (mail-io1-f54.google.com [209.85.166.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC60784039
	for <virtualization@lists.linux.dev>; Tue,  1 Apr 2025 19:53:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743537221; cv=none; b=nuD6IbOqWO9w1srMxKrF80O2Yd1c3ZjHs+68a9hgGC0QQTdQVIqY/blaSNVLLqEWWfYkWxhsHfWrDYtgV+EkJSKHFIMLIG2UeJBheFIT9cHyYA7BzkBca/HrVoVhdlCUbn/tQtAV1CGwzBCfCzCIBLq5V5r7rIvUBW4JhyZYHgE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743537221; c=relaxed/simple;
	bh=zPfW6zElnlUyhJ3e8iC6TcgDU1kGgEtSygY6fjC98wE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=a034Atkai8ookFECwMfVJadQDTFOt7R4tk0p+w7ReKa8l/B0s0axXp9Y0Db2uie6jzp9ztAObgg+Zg/DaS3kYMwPO/hkz/HVsDJiUHvlq9GKyCHKRQuOqjJ+kMUmxaGnS3BYMGPxP0CKmN6LKaBIuscJXMCEniSMaOL6xA9ucCk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Csuqokdo; arc=none smtp.client-ip=209.85.166.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Csuqokdo"
Received: by mail-io1-f54.google.com with SMTP id ca18e2360f4ac-85e73f7ba09so486608339f.3
        for <virtualization@lists.linux.dev>; Tue, 01 Apr 2025 12:53:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1743537218; x=1744142018; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gc7B5TWF5E7dS0lIFexpVCDTxyXmK4Y/wIY/rEIEhGo=;
        b=CsuqokdoflIA9CsLpobxcW43ocbJcNalra498R2AfOyq96q5E7d9xM0jsh/WYh1f4Z
         PSb1aLloD0tduYnF06IjXzVorvIj47tSVEUAgaGLoO83iPJH3m1xTrdviEwYitjQa0Hm
         D+YqJcpDpXXG3WdmZ2HNJMmLsJ9nPYBSg9X9fCQclRotxzkTOVvTJF4+Gkm1cY+jmK6B
         auNqW/19coIiLNOeX4oZimiizTam/zJRTPvU1U2nVKievJ5nYRPWlDk+si4fVpO+WxQP
         bLqThSA87B0t18OtWc7Rkj21BBeWnj9m57EqSoOvkKSMdh6OELPeRe9K4gFRtV3L5SiT
         k1gg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743537218; x=1744142018;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gc7B5TWF5E7dS0lIFexpVCDTxyXmK4Y/wIY/rEIEhGo=;
        b=TF6m0h8yuGKmNP4NMKsKoLoAvnhjQjhd1xegwQ20WOFz7qy0AyEeFcFGtuLZHtTahZ
         J90ivCNeg93rH0K4f9AI9hEU6HZUfzTVkvNkq1HYU+0dllY0FzLS3Z3fgyd+Qet08/N6
         o7Tu4UXf43cBVRbrp+36E5sVUhlEE5GW+Ym2HpBQ+8DN3tbHQLwjVuVEx6SzlGoEv3hO
         LVnvNceSjcbBXSJ0xjcg+hKp4m3XLJtOAAC6WlUc1xsi5VQKlMOQPaUP3pHtxHHS33dO
         3yGsPYRReglI5QsSQJUbrAeAR7QGyr06lgItC0QU+uYBugugyvmgiiiPnCwvLVxdW7lB
         cS/Q==
X-Forwarded-Encrypted: i=1; AJvYcCWX73UL2Q0gHjG7EAbqswi0Ac8fjOjjJLAmd96y25NRiaj06lSrIjlb9FwrgS92PzJZdpQ/7tStlaRK2vHBbw==@lists.linux.dev
X-Gm-Message-State: AOJu0YydJwNCUcEBLpFStrJA9GAuJKoP5ZsZZo/uT2HTaMc2loeVrYJ6
	4SK4mNOQtr2zuLA+3+vLw6+lz0S2lWo9I9L+nwfXL+E93mbCX9kngQ3aQl5VedmXSGIaYRl/yTf
	ZdIsSDI6I3gz3MqFfroCiORfpfPE=
X-Gm-Gg: ASbGncueZEpOEph6rdE2JHsYnua032xywQw9xc8HlxwsTUu9Ts+iAnoRc5MypSNrTFj
	QOTU3y0lhT1Jip+y46r8i3lxR11K/qV1EXtOLFJXlYg1bnIbDRpce6zUzWsSWLaeiBeaVZq8J5W
	FvzM/MxBu1AQ2MK6QaLkq30PY2qQjHWASwJz34dEHSnfdvgy2b+Qxu7QLi
X-Google-Smtp-Source: AGHT+IH3S71OAEwFMQD4R/OEKTAMcAKSmJhwYs7vzK+zU99RQKuLFvb95AfvxDZWWU8kud8NGXbifBK7Do0dL2fI2Sw=
X-Received: by 2002:a05:6e02:4401:10b0:3d1:9999:4f62 with SMTP id
 e9e14a558f8ab-3d6ca5b1852mr42452585ab.2.1743537217735; Tue, 01 Apr 2025
 12:53:37 -0700 (PDT)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20250401123842.2232205-1-dmitry.osipenko@collabora.com>
In-Reply-To: <20250401123842.2232205-1-dmitry.osipenko@collabora.com>
From: Rob Clark <robdclark@gmail.com>
Date: Tue, 1 Apr 2025 12:53:25 -0700
X-Gm-Features: AQ5f1JoQHRRLbQWDkENOEX3GOQ6LDd-52WdH18mm3il4tRiQyy7pyqd6guv7zl8
Message-ID: <CAF6AEGu8XZktM9Y0t=KEF68uGLz7D_+9H1GnAPnZqc1YsT8iGA@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] drm/virtio: Don't attach GEM to a non-created
 context in gem_object_open()
To: Dmitry Osipenko <dmitry.osipenko@collabora.com>
Cc: David Airlie <airlied@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>, 
	Gurchetan Singh <gurchetansingh@chromium.org>, Chia-I Wu <olvaffe@gmail.com>, 
	Vivek Kasireddy <vivek.kasireddy@intel.com>, 
	Pierre-Eric Pelloux-Prayer <pierre-eric.pelloux-prayer@amd.com>, dri-devel@lists.freedesktop.org, 
	virtualization@lists.linux.dev, linux-kernel@vger.kernel.org, 
	kernel@collabora.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 1, 2025 at 5:39=E2=80=AFAM Dmitry Osipenko
<dmitry.osipenko@collabora.com> wrote:
>
> The vfpriv->ctx_id is always initialized to a non-zero value. Check wheth=
er
> context was created before attaching GEM to this context ID. This left
> unnoticed previously because host silently skips attachment if context
> doesn't exist, still we shouldn't do that for consistency.
>
> Fixes: 086b9f27f0ab ("drm/virtio: Don't create a context with default par=
am if context_init is supported")
> Cc: <stable@vger.kernel.org> # v6.14+
> Signed-off-by: Dmitry Osipenko <dmitry.osipenko@collabora.com>

Reviewed-by: Rob Clark <robdclark@gmail.com>

> ---
>  drivers/gpu/drm/virtio/virtgpu_gem.c | 11 ++++++-----
>  1 file changed, 6 insertions(+), 5 deletions(-)
>
> diff --git a/drivers/gpu/drm/virtio/virtgpu_gem.c b/drivers/gpu/drm/virti=
o/virtgpu_gem.c
> index 5aab588fc400..3d6aa26fdb53 100644
> --- a/drivers/gpu/drm/virtio/virtgpu_gem.c
> +++ b/drivers/gpu/drm/virtio/virtgpu_gem.c
> @@ -115,13 +115,14 @@ int virtio_gpu_gem_object_open(struct drm_gem_objec=
t *obj,
>         if (!vgdev->has_context_init)
>                 virtio_gpu_create_context(obj->dev, file);
>
> -       objs =3D virtio_gpu_array_alloc(1);
> -       if (!objs)
> -               return -ENOMEM;
> -       virtio_gpu_array_add_obj(objs, obj);
> +       if (vfpriv->context_created) {
> +               objs =3D virtio_gpu_array_alloc(1);
> +               if (!objs)
> +                       return -ENOMEM;
> +               virtio_gpu_array_add_obj(objs, obj);
>
> -       if (vfpriv->ctx_id)
>                 virtio_gpu_cmd_context_attach_resource(vgdev, vfpriv->ctx=
_id, objs);
> +       }
>
>  out_notify:
>         virtio_gpu_notify(vgdev);
> --
> 2.49.0
>
