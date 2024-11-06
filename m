Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3975F18786C
	for <virtualization@lists.linux-foundation.org>; Wed,  6 Nov 2024 01:27:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730856445; cv=none; b=bLjjVag4hHJyp7faih/5toYT8OchXuzUrwItzaPBtGi4Va3oZux3TRyEu8BMtLFrgbQ+BWHmAwq9GaUeRZ2DGlk68h3Dy4qzHY067IfZPHxNlN4drLI0SLhoTHHyKupvcSCxgO2tluaBXw4nNfa+JeKjkINR+8aOqFS3ZMgASAM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730856445; c=relaxed/simple;
	bh=njdibPXQOQM2lEaEUF7Q6OeOAyl2vAILy1ic5HJUabU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=VHUsJWiWUOoFMyS0fgd5C53kjTP49kfKLLc8La6wgHxO/XAkadsXEFjR1z57Aq/t73BzN1rV8lrqFEqAHh+0xKp2s7QOhtSpen31egRRpCFTJoFqr95YQFHXY+t00deDCmIDop6QN6uqEG2hQiyEh7ytn+yOBhABDbMEkpgn3R8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jM6cVksm; arc=none smtp.client-ip=140.211.166.133
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jM6cVksm"
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id B3EC540275
	for <virtualization@lists.linux-foundation.org>; Wed,  6 Nov 2024 01:27:23 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -2.099
X-Spam-Level:
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id iXQyYEyVhXdZ for <virtualization@lists.linux-foundation.org>;
 Wed,  6 Nov 2024 01:27:23 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2607:f8b0:4864:20::12c; helo=mail-il1-x12c.google.com; envelope-from=robdclark@gmail.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp2.osuosl.org C0AE240204
Authentication-Results: smtp2.osuosl.org; dmarc=pass (p=none dis=none) header.from=gmail.com
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org C0AE240204
Authentication-Results: smtp2.osuosl.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=jM6cVksm
Received: from mail-il1-x12c.google.com (mail-il1-x12c.google.com [IPv6:2607:f8b0:4864:20::12c])
	by smtp2.osuosl.org (Postfix) with ESMTPS id C0AE240204
	for <virtualization@lists.linux-foundation.org>; Wed,  6 Nov 2024 01:27:22 +0000 (UTC)
Received: by mail-il1-x12c.google.com with SMTP id e9e14a558f8ab-3a4e5401636so21898125ab.3
        for <virtualization@lists.linux-foundation.org>; Tue, 05 Nov 2024 17:27:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730856441; x=1731461241; darn=lists.linux-foundation.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TcxC+ORh9eBt+jOnM96T6OTZbBwlinEiMNH6d9wvoUs=;
        b=jM6cVksmtPOFH7/L+3ybvc0rioCmoTKy1EeJgRaOdOmuWOXBP1GUzcR2llBhZjMcNE
         h54DurD6FgO21HZPcUsAFZniC61Z88lcj3JaIbIM5aMZ/ufz3pUGhr6wVcidYbENQq/j
         tEbRP/iWqIyFU7K72OubQZ1Qj9BXlYY5kMYOC2taF2Q94z/JAQx3rbyTY4A1w7ADvYnn
         bZh/ebpqjmMz9MC3BpboL3I994pJe3dBulC9bFj/y+gPCpMm2XGqduv/+dtYyBCNZ2rr
         3CEGkhVmzjQS0nn1YMexMQnpf6Id7vcLKwxLP1DLM7acCUDMAFy/AT+tBxZdGaToBxBy
         Z6SA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730856441; x=1731461241;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TcxC+ORh9eBt+jOnM96T6OTZbBwlinEiMNH6d9wvoUs=;
        b=LcnF93a5YA699DSacoabz6a12ni+/2RXYuGEGKKGvPEe4W/Vo6gCp/8JwFUoTspT6/
         2heS9DgFjQfpoPAHXQI6yhlmITymXgfMWznNYDgK1z4LK2253siwaUhp9rx5+XFGJ5X5
         LI9jV6NnaT9NOMSnrFOcehAICxEd1y2cvOb+4G7uN9tQfLMx6cZKeHxYO2iG55NqLZo/
         2gGOmAjYDgz1WeCtky+0tErck77D5AGwuKJsIWP4Hmo2jgP8IJZTa/KwAbPyKF1gBXei
         kHkswVAA/zl37F8dKW0MUfkVJmMa2hRwBDqaE/ZSAPigl+DWSijI23TXQFPnVeMLir6H
         NT9Q==
X-Forwarded-Encrypted: i=1; AJvYcCUtx7wsfa0J2dWK1+Z/Mk28LmcP0TC2eUWDkvYftTg+xpw2z2SZAn3/p7KeCAijZzABSXrZzrTEjDCixSQrQQ==@lists.linux-foundation.org
X-Gm-Message-State: AOJu0YzbHGdOp9HdzzQGj8q7s5CWIGnoR5pvlPIhMQnlKylRSfcCmRyq
	L03RElzEpbWTDHUBzpZv6yD72wjx9SWqLgoVle75k6ostgyf9E1f+LYqXjnKZ6QFouBlLJ6z8Ha
	CADkKQ6mqv2yk77VJBfi4iIHIAg0=
X-Google-Smtp-Source: AGHT+IHK8YfN0cWKU5EzbpIzvioDDX+4UjhafdKqkGFG/9144aWhyTmx/bwu2zbbifHRZEYV7AUaD/0tSb65EKVTtMs=
X-Received: by 2002:a05:6e02:1d11:b0:3a0:bd91:3842 with SMTP id
 e9e14a558f8ab-3a6b0393b63mr187747875ab.24.1730856441515; Tue, 05 Nov 2024
 17:27:21 -0800 (PST)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20241020230803.247419-1-dmitry.osipenko@collabora.com>
In-Reply-To: <20241020230803.247419-1-dmitry.osipenko@collabora.com>
From: Rob Clark <robdclark@gmail.com>
Date: Tue, 5 Nov 2024 17:27:09 -0800
Message-ID: <CAF6AEGv73+k4fNm-5ZXTyf5jizx=Yq=HeA5AC7K-DrDA1Edn2w@mail.gmail.com>
Subject: Re: [PATCH v3 1/2] drm/virtio: Use drm_gem_plane_helper_prepare_fb()
To: Dmitry Osipenko <dmitry.osipenko@collabora.com>
Cc: David Airlie <airlied@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>, 
	Gurchetan Singh <gurchetansingh@chromium.org>, Chia-I Wu <olvaffe@gmail.com>, 
	Pierre-Eric Pelloux-Prayer <pierre-eric.pelloux-prayer@amd.com>, Kim Dongwon <dongwon.kim@intel.com>, 
	Kasireddy Vivek <vivek.kasireddy@intel.com>, dri-devel@lists.freedesktop.org, 
	virtualization@lists.linux-foundation.org, linux-kernel@vger.kernel.org, 
	kernel@collabora.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Oct 20, 2024 at 4:08=E2=80=AFPM Dmitry Osipenko
<dmitry.osipenko@collabora.com> wrote:
>
> From: Dongwon Kim <dongwon.kim@intel.com>
>
> Use drm_gem_plane_helper_prepare_fb() helper for explicit framebuffer
> synchronization. We need to wait for explicit fences in a case of
> Venus and native contexts when guest user space uses explicit fencing.
>
> Signed-off-by: Dongwon Kim <dongwon.kim@intel.com>
> [dmitry.osipenko@collabora.com>: Edit commit message]
> Signed-off-by: Dmitry Osipenko <dmitry.osipenko@collabora.com>

Reviewed-by: Rob Clark <robdclark@gmail.com>

> ---
>  drivers/gpu/drm/virtio/virtgpu_plane.c | 4 ++++
>  1 file changed, 4 insertions(+)
>
> diff --git a/drivers/gpu/drm/virtio/virtgpu_plane.c b/drivers/gpu/drm/vir=
tio/virtgpu_plane.c
> index a72a2dbda031..ab7232921cb7 100644
> --- a/drivers/gpu/drm/virtio/virtgpu_plane.c
> +++ b/drivers/gpu/drm/virtio/virtgpu_plane.c
> @@ -26,6 +26,7 @@
>  #include <drm/drm_atomic_helper.h>
>  #include <drm/drm_damage_helper.h>
>  #include <drm/drm_fourcc.h>
> +#include <drm/drm_gem_atomic_helper.h>
>
>  #include "virtgpu_drv.h"
>
> @@ -254,6 +255,9 @@ static int virtio_gpu_plane_prepare_fb(struct drm_pla=
ne *plane,
>
>         vgfb =3D to_virtio_gpu_framebuffer(new_state->fb);
>         bo =3D gem_to_virtio_gpu_obj(vgfb->base.obj[0]);
> +
> +       drm_gem_plane_helper_prepare_fb(plane, new_state);
> +
>         if (!bo || (plane->type =3D=3D DRM_PLANE_TYPE_PRIMARY && !bo->gue=
st_blob))
>                 return 0;
>
> --
> 2.47.0
>
