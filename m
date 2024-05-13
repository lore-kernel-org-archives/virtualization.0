Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A4C621342
	for <virtualization@lists.linux.dev>; Mon, 13 May 2024 17:03:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715619796; cv=none; b=mzXqlq1yTYbsEaGwTdwXnxnnXalty1AisMthqY5xxJpUBw6+PEAPpKQegCrxK7bD+MtNwMxH4Pduxe+e/suozV2ayXHs+IYs4C0O037fbQeHXyf7/AbU9II8ml2Qr0u1JuO710o/NYOoaWLHtvLYjP0yTd2+4oRvaBb+T6NyX58=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715619796; c=relaxed/simple;
	bh=9vUzL4aRQDSJvjmGs14ZhMr5Z7rTfmg3VliK6XYVZ9s=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=rJeRGXIdr2/Byr8S5JtV1mupc1iXEWy7QpMLPeS4BaSZPysIDRW+PltaltY4OPz9x/NogFSilEmWHesu5EXYjFxOZH9IvmfnLbAH1BnIYWAOyBciaGU36YJWuXW+hQSth6rKJG5y3oan6FCtiuHeNzFxvGxHD4ruQOVOu3DKblY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rkM25nN+; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rkM25nN+"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9CC71C32786
	for <virtualization@lists.linux.dev>; Mon, 13 May 2024 17:03:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715619795;
	bh=9vUzL4aRQDSJvjmGs14ZhMr5Z7rTfmg3VliK6XYVZ9s=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=rkM25nN+x1rrZQ2zjfNnGc9nnrLYDKt9wDPGEc3+nU5s8iZst4wdcBOruUoXPBfeJ
	 PumTH691+y2kVwc/R30fl5AVMo+90RuE8SkogdUzSd4RAA7SdK9hjKlLORiLwfhI5Y
	 yAB+QTEdUMnlbqCvgEV8cpL+Kf816I9X0RSEVxNLzbf8L7NPuZqeXzi2S7WVnmkyf7
	 SC3KFquugOvpyBXPC1AueRCX82ckowB+agIFUYeJQ9O+eSuCpkn1kVCEWwHZ9VSw/d
	 yTbbYAw5d24n0NvoN3sSM1PTB0Px6NANHUVWCMSpSOOrQ+BpWkTzlideJaA82ZdcgK
	 YNR0VurjauGAw==
Received: by mail-oa1-f46.google.com with SMTP id 586e51a60fabf-23d39e4c0d9so2815282fac.0
        for <virtualization@lists.linux.dev>; Mon, 13 May 2024 10:03:15 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCXBes6W3+LFEXHWMdB1BCgFooAUqujEeB+m63YpA20Yn5TFJlii+i3GWlafSA2IA7KgfszzZAa9i51xIh6nkcPq3jxmMdsOEnWuBagPK9w=
X-Gm-Message-State: AOJu0YwGPyNNi6JG5xGpt5O9noe4aaAcBgZbSv/ZwPJSVF4VY9jT/XbX
	gIg2yRbG0g65eJ8IM//s8+puZglkIGu03FFm0PxE/qD+X0atYEMUXSX0KprbG4aXxGIvsMEY5Pi
	0gP9tcBGWhl/0J0Sj7+Hq4ARPOKMpRtygO7SsYQ==
X-Google-Smtp-Source: AGHT+IGS2MoNmPLyPm+QOcC4ixYh+5bDguxHlXpY+BCwrhwRLFuYlZt/IAbujeKcBkn/N94hDhzLmdIXYA+iRXjOFFY=
X-Received: by 2002:a05:6870:fe94:b0:23c:3afd:8770 with SMTP id
 586e51a60fabf-24172870491mr12533748fac.19.1715619795040; Mon, 13 May 2024
 10:03:15 -0700 (PDT)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <cover.1715347488.git.jani.nikula@intel.com> <ed6e76a9e94816789ca9caf8775d6a6156877496.1715347488.git.jani.nikula@intel.com>
In-Reply-To: <ed6e76a9e94816789ca9caf8775d6a6156877496.1715347488.git.jani.nikula@intel.com>
From: Robert Foss <rfoss@kernel.org>
Date: Mon, 13 May 2024 19:03:03 +0200
X-Gmail-Original-Message-ID: <CAN6tsi6qrZHQ4ohkBj=syUivociKH-c_kfjgSkHC8qp0J6riTw@mail.gmail.com>
Message-ID: <CAN6tsi6qrZHQ4ohkBj=syUivociKH-c_kfjgSkHC8qp0J6riTw@mail.gmail.com>
Subject: Re: [RESEND 6/6] drm/virtio: switch to struct drm_edid
To: Jani Nikula <jani.nikula@intel.com>
Cc: dri-devel@lists.freedesktop.org, David Airlie <airlied@redhat.com>, 
	Gerd Hoffmann <kraxel@redhat.com>, Gurchetan Singh <gurchetansingh@chromium.org>, 
	Chia-I Wu <olvaffe@gmail.com>, virtualization@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, May 10, 2024 at 3:34=E2=80=AFPM Jani Nikula <jani.nikula@intel.com>=
 wrote:
>
> Prefer struct drm_edid based functions over struct edid.
>
> Signed-off-by: Jani Nikula <jani.nikula@intel.com>
>
> ---
>
> Cc: David Airlie <airlied@redhat.com>
> Cc: Gerd Hoffmann <kraxel@redhat.com>
> Cc: Gurchetan Singh <gurchetansingh@chromium.org>
> Cc: Chia-I Wu <olvaffe@gmail.com>
> Cc: virtualization@lists.linux.dev
> ---
>  drivers/gpu/drm/virtio/virtgpu_display.c | 10 ++++------
>  drivers/gpu/drm/virtio/virtgpu_drv.h     |  2 +-
>  drivers/gpu/drm/virtio/virtgpu_vq.c      | 12 ++++++------
>  3 files changed, 11 insertions(+), 13 deletions(-)
>
> diff --git a/drivers/gpu/drm/virtio/virtgpu_display.c b/drivers/gpu/drm/v=
irtio/virtgpu_display.c
> index ad924a8502e9..64baf2f22d9f 100644
> --- a/drivers/gpu/drm/virtio/virtgpu_display.c
> +++ b/drivers/gpu/drm/virtio/virtgpu_display.c
> @@ -164,11 +164,9 @@ static int virtio_gpu_conn_get_modes(struct drm_conn=
ector *connector)
>         struct drm_display_mode *mode =3D NULL;
>         int count, width, height;
>
> -       if (output->edid) {
> -               count =3D drm_add_edid_modes(connector, output->edid);
> -               if (count)
> -                       return count;
> -       }
> +       count =3D drm_edid_connector_add_modes(connector);
> +       if (count)
> +               return count;
>
>         width  =3D le32_to_cpu(output->info.r.width);
>         height =3D le32_to_cpu(output->info.r.height);
> @@ -369,5 +367,5 @@ void virtio_gpu_modeset_fini(struct virtio_gpu_device=
 *vgdev)
>                 return;
>
>         for (i =3D 0 ; i < vgdev->num_scanouts; ++i)
> -               kfree(vgdev->outputs[i].edid);
> +               drm_edid_free(vgdev->outputs[i].drm_edid);
>  }
> diff --git a/drivers/gpu/drm/virtio/virtgpu_drv.h b/drivers/gpu/drm/virti=
o/virtgpu_drv.h
> index bb7d86a0c6a1..64c236169db8 100644
> --- a/drivers/gpu/drm/virtio/virtgpu_drv.h
> +++ b/drivers/gpu/drm/virtio/virtgpu_drv.h
> @@ -179,7 +179,7 @@ struct virtio_gpu_output {
>         struct drm_encoder enc;
>         struct virtio_gpu_display_one info;
>         struct virtio_gpu_update_cursor cursor;
> -       struct edid *edid;
> +       const struct drm_edid *drm_edid;
>         int cur_x;
>         int cur_y;
>         bool needs_modeset;
> diff --git a/drivers/gpu/drm/virtio/virtgpu_vq.c b/drivers/gpu/drm/virtio=
/virtgpu_vq.c
> index b1a00c0c25a7..0d3d0d09f39b 100644
> --- a/drivers/gpu/drm/virtio/virtgpu_vq.c
> +++ b/drivers/gpu/drm/virtio/virtgpu_vq.c
> @@ -741,21 +741,21 @@ static void virtio_gpu_cmd_get_edid_cb(struct virti=
o_gpu_device *vgdev,
>                 (struct virtio_gpu_resp_edid *)vbuf->resp_buf;
>         uint32_t scanout =3D le32_to_cpu(cmd->scanout);
>         struct virtio_gpu_output *output;
> -       struct edid *new_edid, *old_edid;
> +       const struct drm_edid *new_edid, *old_edid;
>
>         if (scanout >=3D vgdev->num_scanouts)
>                 return;
>         output =3D vgdev->outputs + scanout;
>
> -       new_edid =3D drm_do_get_edid(&output->conn, virtio_get_edid_block=
, resp);
> -       drm_connector_update_edid_property(&output->conn, new_edid);
> +       new_edid =3D drm_edid_read_custom(&output->conn, virtio_get_edid_=
block, resp);
> +       drm_edid_connector_update(&output->conn, new_edid);
>
>         spin_lock(&vgdev->display_info_lock);
> -       old_edid =3D output->edid;
> -       output->edid =3D new_edid;
> +       old_edid =3D output->drm_edid;
> +       output->drm_edid =3D new_edid;
>         spin_unlock(&vgdev->display_info_lock);
>
> -       kfree(old_edid);
> +       drm_edid_free(old_edid);
>         wake_up(&vgdev->resp_wq);
>  }
>
> --
> 2.39.2
>

Reviewed-by: Robert Foss <rfoss@kernel.org>
