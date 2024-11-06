Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1393D3D66
	for <virtualization@lists.linux-foundation.org>; Wed,  6 Nov 2024 01:31:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730856704; cv=none; b=cSViv5NI2MenTGVtBjyb6tx2yjEu7kwG6FNeRZpfGqb5CZ0lw+EqFYYVi7dy/1hq1sj+1L3p3Pathc/05U46qn6CF7EJm9US64DoYVAa/Q/HjYitbeufKUA3o5n721yRSInoI4pEcRIrdPPr2dCOILQ1FBQ/0GYqw8XFrpXoIMw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730856704; c=relaxed/simple;
	bh=5CmSX02hMXqC0tcwAjp+rJhnC2j0lws2C8eH6CXLVfM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=YjQCOiIuVwf8uLX3VYK6brWxK/2YvH6QggKfGgRzXIjsWdTSpxHrvNFsXWRIpDBWitO9Q/PHnDf1qrXC34UGt1AV57Bsg7/oPTpRvcmZuQLJ09ymmZlKPfvJ/H475kkqW3Rym3BEDWcfor7Z1z4phxrNQeeXDGb78DWCV4Lkc8Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UcVs49+R; arc=none smtp.client-ip=140.211.166.133
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UcVs49+R"
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id B8FFE40204
	for <virtualization@lists.linux-foundation.org>; Wed,  6 Nov 2024 01:31:42 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -2.099
X-Spam-Level:
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id X_7fKW1HSnjm for <virtualization@lists.linux-foundation.org>;
 Wed,  6 Nov 2024 01:31:42 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2607:f8b0:4864:20::130; helo=mail-il1-x130.google.com; envelope-from=robdclark@gmail.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp2.osuosl.org C9D154013F
Authentication-Results: smtp2.osuosl.org; dmarc=pass (p=none dis=none) header.from=gmail.com
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org C9D154013F
Authentication-Results: smtp2.osuosl.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=UcVs49+R
Received: from mail-il1-x130.google.com (mail-il1-x130.google.com [IPv6:2607:f8b0:4864:20::130])
	by smtp2.osuosl.org (Postfix) with ESMTPS id C9D154013F
	for <virtualization@lists.linux-foundation.org>; Wed,  6 Nov 2024 01:31:41 +0000 (UTC)
Received: by mail-il1-x130.google.com with SMTP id e9e14a558f8ab-3a3a5cd2a3bso22135435ab.3
        for <virtualization@lists.linux-foundation.org>; Tue, 05 Nov 2024 17:31:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730856701; x=1731461501; darn=lists.linux-foundation.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1ZEdQ5A4rc3P9ZMICWLA+PiCJDpmRtuPvoqRfEkgQC0=;
        b=UcVs49+RmtIXKj6WV8LJkIfwnR5rX6a/OvA7Nilp4WSgt3sn7FTnX/uPPVr6n3ftKZ
         OjvN+T/3R/xdUeLxVNbtr+1DWL3jRUIZ9mG7e06CytPukyHAYK5eO79uPC986JvLGy+N
         Ae7fZbepWk3dfil7PE1+x0cSuU9ifV6N8kRP80vN0A8kxvwBarHSnNIJXpjvUMx+R9OS
         +cndX80Zg+i+dgB6a0TeGxLr64VLWa/LeGfg3HIOJaltTpjDJYU81mYimo34T6NGiYk0
         GNu+klE4nNXYmylWBdmmxgz64Heet3o/auBnqj2lZEMkIF+VdV/slonv33Cz1lLF2KRY
         Cm3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730856701; x=1731461501;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1ZEdQ5A4rc3P9ZMICWLA+PiCJDpmRtuPvoqRfEkgQC0=;
        b=WIjmyfqny1riyAotxAP+PhnLbxWv/S1QcKPEyF+GjSrFk1x/M7JYVO7kj6NG1olu9w
         6OIPy1N4eEGACMv5n97+9b8hn6qyi8B0YtfXMZcwu+0a3k2wR1H603FvVOw00BAsugnH
         l7aGv6MsO24EZEDWyTEjCBNcjYxL9/FVfBn+8vn83bDY/z7j/R9u1pPta1Z5brOH233H
         VDPZrh8oD6dVisEnlTPLCxheBGi56GyzJSXQUiew4tVL9kX5xnfBcp7LWS864qj6aluH
         9sh/Vi/izLTAPTQufm9oZnCmgLdE8LnXkZoFYgH2cgdv/2ywR3tn2HgNUeSZ0Gb6a4Te
         FbYQ==
X-Forwarded-Encrypted: i=1; AJvYcCXIMgM/x+iNmYUVgC6c7xOZDXCeXXqZ3bTQtH7t1mZUq8t5qBxjWuB3hAg5jHb/GBzEhlZmzEpnDPrwH4k19w==@lists.linux-foundation.org
X-Gm-Message-State: AOJu0YzxeJzR6D2SZj4/2Vut/c4GeWa9xC2xjNY4KrnMTijblfLxE9Wp
	izov6eZvrHZg3OSxmNkVSk2QZ8UU3JVAI3uvs20apFP2A7yB97n50nrT0tuIEY3s0LeLdi4FAfi
	ORfdt8NijiVWGBpHYMLLvEYhgFhk=
X-Google-Smtp-Source: AGHT+IEKU8XnaFKdqE7nB8aAs1Qbr/FQljqOuyQsSN6+XX2borSTMs1XTeUygH5VgMPHRf3Wtb671mQbzY159BQ9UUU=
X-Received: by 2002:a05:6e02:148a:b0:3a6:b37c:6a12 with SMTP id
 e9e14a558f8ab-3a6b37c6cc2mr189320995ab.7.1730856700682; Tue, 05 Nov 2024
 17:31:40 -0800 (PST)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20241020224725.179937-1-dmitry.osipenko@collabora.com>
In-Reply-To: <20241020224725.179937-1-dmitry.osipenko@collabora.com>
From: Rob Clark <robdclark@gmail.com>
Date: Tue, 5 Nov 2024 17:31:28 -0800
Message-ID: <CAF6AEGs2+gPtqOw=LMwVxNkzWgYc11u0VN3DnQOyQc2MPhsJig@mail.gmail.com>
Subject: Re: [PATCH v1] drm/virtio: Don't create a context with default param
 if context_init is supported
To: Dmitry Osipenko <dmitry.osipenko@collabora.com>
Cc: David Airlie <airlied@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>, 
	Gurchetan Singh <gurchetansingh@chromium.org>, Chia-I Wu <olvaffe@gmail.com>, 
	Pierre-Eric Pelloux-Prayer <pierre-eric.pelloux-prayer@amd.com>, dri-devel@lists.freedesktop.org, 
	virtualization@lists.linux-foundation.org, linux-kernel@vger.kernel.org, 
	kernel@collabora.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Oct 20, 2024 at 3:49=E2=80=AFPM Dmitry Osipenko
<dmitry.osipenko@collabora.com> wrote:
>
> From: Pierre-Eric Pelloux-Prayer <pierre-eric.pelloux-prayer@amd.com>
>
> Xorg context creation fails for native contexts that use
> VIRTGPU_CONTEXT_INIT because context is already initialized implicitly
> when dumb buffer is created. Fix it by not creating default vrend context
> if context_init is supported.
>
> Signed-off-by: Pierre-Eric Pelloux-Prayer <pierre-eric.pelloux-prayer@amd=
.com>
> Signed-off-by: Dmitry Osipenko <dmitry.osipenko@collabora.com>

Reviewed-by: Rob Clark <robdclark@gmail.com>

> ---
>  drivers/gpu/drm/virtio/virtgpu_gem.c | 8 +++++---
>  1 file changed, 5 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/gpu/drm/virtio/virtgpu_gem.c b/drivers/gpu/drm/virti=
o/virtgpu_gem.c
> index 7db48d17ee3a..67f557e058b4 100644
> --- a/drivers/gpu/drm/virtio/virtgpu_gem.c
> +++ b/drivers/gpu/drm/virtio/virtgpu_gem.c
> @@ -127,15 +127,17 @@ int virtio_gpu_gem_object_open(struct drm_gem_objec=
t *obj,
>         /* the context might still be missing when the first ioctl is
>          * DRM_IOCTL_MODE_CREATE_DUMB or DRM_IOCTL_PRIME_FD_TO_HANDLE
>          */
> -       virtio_gpu_create_context(obj->dev, file);
> +       if (!vgdev->has_context_init)
> +               virtio_gpu_create_context(obj->dev, file);
>
>         objs =3D virtio_gpu_array_alloc(1);
>         if (!objs)
>                 return -ENOMEM;
>         virtio_gpu_array_add_obj(objs, obj);
>
> -       virtio_gpu_cmd_context_attach_resource(vgdev, vfpriv->ctx_id,
> -                                              objs);
> +       if (vfpriv->ctx_id)
> +               virtio_gpu_cmd_context_attach_resource(vgdev, vfpriv->ctx=
_id, objs);
> +
>  out_notify:
>         virtio_gpu_notify(vgdev);
>         return 0;
> --
> 2.47.0
>
