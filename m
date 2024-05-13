Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F499208BA
	for <virtualization@lists.linux.dev>; Mon, 13 May 2024 17:05:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715619910; cv=none; b=D8/DBMFwYok20uXLwmzCsYUuIFn6KH9408A4fT3jvbSu7nvXd0GPoGpXkAwkkpPokouXj6nVgffgIJoWY3tu2+nBMhoIzamhpMD9ZHBk5oivUEPGAfawaS8+CrwbBN/s/lsOF7slH5EwzgpwZnhS92jBhL9YYsPei8KItOd6QkA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715619910; c=relaxed/simple;
	bh=fKLYgNDA/digYnWNRW08cOMmokW4r4hgkCbjsWRsSAM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qqNoFMC3Jbhj/BLXKN7AavZLE3e1TIZyopPuUw8JUbP3UvkO39fyZ6265A3lKdsonArnmpUrJAwToPq8wiMu47MsWV89kMEynRCqWUpTLCJSfWgekt1o5iqnaHo2c7fPfxZL/LP6q9kAvHPWtfkofzU4NQ61BiMMEPcLt2DqVk0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=E+zm6he4; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="E+zm6he4"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 043D3C113CC
	for <virtualization@lists.linux.dev>; Mon, 13 May 2024 17:05:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715619910;
	bh=fKLYgNDA/digYnWNRW08cOMmokW4r4hgkCbjsWRsSAM=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=E+zm6he4xQXh9LDp6KAFhACNhDdFTFDmxRna7mTl604COroq92WHD07nd+3vQ6IqV
	 F3DdvOaMTNDpPFd7QiSExPopY2+UF3EMzr1JDGzJSb3Nid6z7tQPV56sDw69e+/J7b
	 a3efPdg30KewvGbz7Pm1F4QRZO4vyNG5e5LF3UXYfoLiEMBbZR3qhs67beza9jO0Xd
	 09darohG1ERfRz2rb0i3nE9QuteIOKT7EE17rqneUHwxPRN3hLGQJzg38BDhDHzE3p
	 4MfVkTMnmKTyEOaZ03tr8kAqRENtHh+AHgqZrnIMAwT2rE/qLLWQycncgtALcLP6hF
	 mgQfsHUB7vw9w==
Received: by mail-oa1-f44.google.com with SMTP id 586e51a60fabf-23ee34c33ceso3045842fac.3
        for <virtualization@lists.linux.dev>; Mon, 13 May 2024 10:05:09 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCU2mpwfsxvkru3Ua2YStEXrRu1J+XasaOntZGnd9WpZhAG5BxmCKsdrBkhNYatyGYcyLXwKdH3hIwPHEBvPLvSKVsrMdYnvY98XkneWYqo=
X-Gm-Message-State: AOJu0YxVP3zwL+9QQ5bzbgILtRWUIvSUSPB99+/l3Ah1jL+0OprVN5nS
	+bAeu4eYHoiz/vuFrvTTuN6EU5MIQlr9RA2Lo6J1MR8OLuDPRvULgLDyYSTO0cmtZS7SyR/pGNl
	AIWrID5QEEW+zeBZU7Vfl0nJAbyhcp/uBq/4ACA==
X-Google-Smtp-Source: AGHT+IFPq0L6Gz1XOu/lJcqmGeVzwTvh6ytgxzHGtXvox7Hn85LwnpXujCKfIMo+2NgPIgTuRCoEOLeS6nwc8rfpqNQ=
X-Received: by 2002:a05:6870:ac21:b0:23d:697:e8fd with SMTP id
 586e51a60fabf-24172f6b5b4mr12903657fac.40.1715619907211; Mon, 13 May 2024
 10:05:07 -0700 (PDT)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <cover.1715347488.git.jani.nikula@intel.com> <24536f4a1a12af7b43ba86e9761dfeef179b72df.1715347488.git.jani.nikula@intel.com>
In-Reply-To: <24536f4a1a12af7b43ba86e9761dfeef179b72df.1715347488.git.jani.nikula@intel.com>
From: Robert Foss <rfoss@kernel.org>
Date: Mon, 13 May 2024 19:04:56 +0200
X-Gmail-Original-Message-ID: <CAN6tsi5YZf3ZiixnfcntzJN8YfmQzXPzbYssCkneLwiWz=febA@mail.gmail.com>
Message-ID: <CAN6tsi5YZf3ZiixnfcntzJN8YfmQzXPzbYssCkneLwiWz=febA@mail.gmail.com>
Subject: Re: [RESEND 5/6] drm/bochs: switch to struct drm_edid
To: Jani Nikula <jani.nikula@intel.com>
Cc: dri-devel@lists.freedesktop.org, Gerd Hoffmann <kraxel@redhat.com>, 
	virtualization@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, May 10, 2024 at 3:27=E2=80=AFPM Jani Nikula <jani.nikula@intel.com>=
 wrote:
>
> Prefer struct drm_edid based functions over struct edid.
>
> Signed-off-by: Jani Nikula <jani.nikula@intel.com>
>
> ---
>
> Cc: Gerd Hoffmann <kraxel@redhat.com>
> Cc: virtualization@lists.linux.dev
> ---
>  drivers/gpu/drm/tiny/bochs.c | 23 ++++++++++-------------
>  1 file changed, 10 insertions(+), 13 deletions(-)
>
> diff --git a/drivers/gpu/drm/tiny/bochs.c b/drivers/gpu/drm/tiny/bochs.c
> index 2d7ad808cc0e..d12d6e0bf3df 100644
> --- a/drivers/gpu/drm/tiny/bochs.c
> +++ b/drivers/gpu/drm/tiny/bochs.c
> @@ -85,7 +85,7 @@ struct bochs_device {
>         u16 yres_virtual;
>         u32 stride;
>         u32 bpp;
> -       struct edid *edid;
> +       const struct drm_edid *drm_edid;
>
>         /* drm */
>         struct drm_device *dev;
> @@ -199,10 +199,10 @@ static int bochs_hw_load_edid(struct bochs_device *=
bochs)
>         if (drm_edid_header_is_valid(header) !=3D 8)
>                 return -1;
>
> -       kfree(bochs->edid);
> -       bochs->edid =3D drm_do_get_edid(&bochs->connector,
> -                                     bochs_get_edid_block, bochs);
> -       if (bochs->edid =3D=3D NULL)
> +       drm_edid_free(bochs->drm_edid);
> +       bochs->drm_edid =3D drm_edid_read_custom(&bochs->connector,
> +                                              bochs_get_edid_block, boch=
s);
> +       if (bochs->drm_edid =3D=3D NULL)
>                 return -1;
>
>         return 0;
> @@ -303,7 +303,7 @@ static void bochs_hw_fini(struct drm_device *dev)
>         if (bochs->fb_map)
>                 iounmap(bochs->fb_map);
>         pci_release_regions(to_pci_dev(dev->dev));
> -       kfree(bochs->edid);
> +       drm_edid_free(bochs->drm_edid);
>  }
>
>  static void bochs_hw_blank(struct bochs_device *bochs, bool blank)
> @@ -471,12 +471,9 @@ static const struct drm_simple_display_pipe_funcs bo=
chs_pipe_funcs =3D {
>
>  static int bochs_connector_get_modes(struct drm_connector *connector)
>  {
> -       struct bochs_device *bochs =3D
> -               container_of(connector, struct bochs_device, connector);
> -       int count =3D 0;
> +       int count;
>
> -       if (bochs->edid)
> -               count =3D drm_add_edid_modes(connector, bochs->edid);
> +       count =3D drm_edid_connector_add_modes(connector);
>
>         if (!count) {
>                 count =3D drm_add_modes_noedid(connector, 8192, 8192);
> @@ -507,10 +504,10 @@ static void bochs_connector_init(struct drm_device =
*dev)
>         drm_connector_helper_add(connector, &bochs_connector_connector_he=
lper_funcs);
>
>         bochs_hw_load_edid(bochs);
> -       if (bochs->edid) {
> +       if (bochs->drm_edid) {
>                 DRM_INFO("Found EDID data blob.\n");
>                 drm_connector_attach_edid_property(connector);
> -               drm_connector_update_edid_property(connector, bochs->edid=
);
> +               drm_edid_connector_update(&bochs->connector, bochs->drm_e=
did);
>         }
>  }
>
> --
> 2.39.2
>

Reviewed-by: Robert Foss <rfoss@kernel.org>
