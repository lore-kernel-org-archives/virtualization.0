Received: from mail-vk1-f172.google.com (mail-vk1-f172.google.com [209.85.221.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7A5084A2B;
	Tue, 21 Jan 2025 09:06:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737450363; cv=none; b=QI4vFoJKSFapTMXbj/HIwDTPQJqgQfanZUy3D3S9SwmQYv1V9AK3f7IjY5wZbr75vmNanf55y+1zb+5YFFWBnCNmTWWEVNVDLOkG/RqsJupY0IRaiNhYReMqjN/h0vSCKQt4xvvlouAhrH7G6tYUeexYmV4Y70kISF0eKzyaSC8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737450363; c=relaxed/simple;
	bh=379PWCV/7+kIrmP1pA3alid5iJDIvrSFYacRmagLkUc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Pb/ZizZK8N2Z855eaH7nIR/JcbZNvIsDXuxXuO2uiLGgzrxpbFbOaW6lTPjm23IcLKyKhfFJKI5mze+plW+PqPVnU7jO+lycm4y/7IxdMXyi/gy3HSjkteXRYjbd9fkknuzN+CChxjR2DcRtp6Km3rl7Lt/dPZAqB1tc7593bBQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.221.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vk1-f172.google.com with SMTP id 71dfb90a1353d-5174db4e34eso3728499e0c.0;
        Tue, 21 Jan 2025 01:06:00 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737450358; x=1738055158;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=h0F66BpcncnDZq8+yac2PqIUMY5KsLdGVzSelKc0x5s=;
        b=Er8/myQPK5LAiCleYF1WXqeeeO8v8xh+oPFY44tcZzNUjasWL2QmiKg6mFzgWiOfo/
         Qa7sRJvgCZ4AIXWLQ/O+huvHeyfuIzU5Ev+nN1hf7BjnLYXIeu0QIf0IhOyrQNUyEkGd
         lZI4cYNtTnJRLFb7jsqAp+c7rw7I91esMdst5nwsdRuAF6iG7x44FjVHP84oOb7P9YPh
         NH/Ogn7WoawjQuJ5cWptieO93cKpmbjtk/ZCuq+qiVx8zwp8BWGzYAzBmmM9RYz1lh94
         DRPhe8eQYe/4SpSQXexEG4YhiBSLONt36tNp1B7ECAdYOOnm7RzbedIiTjnKNXpqdPxV
         TYog==
X-Forwarded-Encrypted: i=1; AJvYcCU4NcnCQ6q/dJptafIEts5Q9bGk+/n3aIZiKLFh8ml4oz9evgr1q8rWlvSnWdowYnzoRPZPDsiV3p/1zBuUZIs=@lists.linux.dev, AJvYcCVQJsQHkHxbM67KoFSKNDiKYqoB89A/SUvSrwpIU6cwdpyEL7xEvOpI6q1giuTkCbpHHBQ=@lists.linux.dev, AJvYcCWcwZ4No6qif28NEwgQwAkYyM60u2XXaW1N1pY2O++utfZFyPLcowfBum2ZaqBtfC2mlJfxdZi+dMwm7Jw=@lists.linux.dev
X-Gm-Message-State: AOJu0Yzpx+ZR8HUhDvcrAyT1KtAJUT/QYwyDkyzpbiHXe6IuUHEUVKZG
	PCOkp41XLLnB25756Ci+tyW5dBPKhiMSYQ9sm+dOFsb0eKVVj/gYPQEODHBL
X-Gm-Gg: ASbGncscOu/1HokEyvL3kysuUOAUYH+AZemRl97vvc3TQi1lo76HOo/yHpW24yYN1sm
	M4HcSVUp9RfBV02P6adFJjB1LJjobaMl4CcNOpMT5E6LHGO+IjcmPIj+OCzRV5wACNo9uOST5e8
	QymTkoApzq0TZC+ko514jRVkiEp5y15Qi1RVbhfHiwuDojCMtBKmdXQdkjljU8KTdzfJfZx2qQ8
	wPqEJBi24sbczH29qwV7TlTaAo8yyrBfK25gnhgMotCQdCJ+sEFiUEWhrfkk0JrL3G1O/t+nNov
	znoiIyU+JSLupOVLE2Dde1zoVOqwOgCQPiDb
X-Google-Smtp-Source: AGHT+IFfnzb4EAnx7CL0V9eoVMvrJbnBHxXC87haB6esuuzHQ68A/+dyGpSrIgilZ+sAB7xcu/Rn5g==
X-Received: by 2002:a05:6122:4885:b0:516:1e32:f8c7 with SMTP id 71dfb90a1353d-51cd9453af7mr22136678e0c.0.1737450358425;
        Tue, 21 Jan 2025 01:05:58 -0800 (PST)
Received: from mail-vk1-f175.google.com (mail-vk1-f175.google.com. [209.85.221.175])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-51cf56ef34dsm1715847e0c.39.2025.01.21.01.05.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 21 Jan 2025 01:05:58 -0800 (PST)
Received: by mail-vk1-f175.google.com with SMTP id 71dfb90a1353d-518799f2828so2848421e0c.0;
        Tue, 21 Jan 2025 01:05:57 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCUO3bARZQJvyl4oxcTOtGYQ3DKSmjQtKBzhO0wqWPN2r1LOKs+vgYdP8Pqv8nFY0Dwbkyo=@lists.linux.dev, AJvYcCUkJgzVp/q2ZFzsqYF3Gz8XOENQgH9V3Eud78TI5alqYCGuQlDCrQb5p+2DLGb8+AVVaH7mug1LsIiN97w=@lists.linux.dev, AJvYcCVkZvuYap4rikUu/DG91jH033i/FUDPHlKzs1kyac7cPizNRM6cItxwi1dUTPpflRwyBcDQWwsobxn6thtaLbo=@lists.linux.dev
X-Received: by 2002:a05:6122:1783:b0:517:e7b7:d04b with SMTP id
 71dfb90a1353d-51cd983d39emr19246646e0c.5.1737450357663; Tue, 21 Jan 2025
 01:05:57 -0800 (PST)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20241214-drm-connector-mode-valid-const-v2-0-4f9498a4c822@linaro.org>
 <173624946815.1500596.321177900833598022.b4-ty@linaro.org>
In-Reply-To: <173624946815.1500596.321177900833598022.b4-ty@linaro.org>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Tue, 21 Jan 2025 10:05:45 +0100
X-Gmail-Original-Message-ID: <CAMuHMdVwcaY2Fgpf7GYhBrE5B+AEg=v0BH4OjMXgnp=wqjxmKg@mail.gmail.com>
X-Gm-Features: AbW1kvaysGolt62WeN4DkS2DNKlSt5oN-0lBeK1j4PwxsWLIrFBPjsQ9bnC7ZcA
Message-ID: <CAMuHMdVwcaY2Fgpf7GYhBrE5B+AEg=v0BH4OjMXgnp=wqjxmKg@mail.gmail.com>
Subject: Re: [PATCH v2 0/5] drm/connector: make mode_valid() callback accept
 const mode pointer
To: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Cc: Jani Nikula <jani.nikula@linux.intel.com>, Rodrigo Vivi <rodrigo.vivi@intel.com>, 
	Joonas Lahtinen <joonas.lahtinen@linux.intel.com>, Tvrtko Ursulin <tursulin@ursulin.net>, 
	David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>, 
	Thomas Zimmermann <tzimmermann@suse.de>, Karol Herbst <kherbst@redhat.com>, Lyude Paul <lyude@redhat.com>, 
	Danilo Krummrich <dakr@redhat.com>, Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>, 
	Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>, Alex Deucher <alexander.deucher@amd.com>, 
	=?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, 
	Xinhui Pan <Xinhui.Pan@amd.com>, Alain Volmat <alain.volmat@foss.st.com>, 
	Raphael Gallais-Pou <rgallaispou@gmail.com>, Liviu Dudau <liviu.dudau@arm.com>, 
	Andrzej Hajda <andrzej.hajda@intel.com>, Neil Armstrong <neil.armstrong@linaro.org>, 
	Robert Foss <rfoss@kernel.org>, Laurent Pinchart <Laurent.pinchart@ideasonboard.com>, 
	Jonas Karlman <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>, 
	Peter Senna Tschudin <peter.senna@gmail.com>, Ian Ray <ian.ray@ge.com>, 
	Martyn Welch <martyn.welch@collabora.co.uk>, Inki Dae <inki.dae@samsung.com>, 
	Seung-Woo Kim <sw0312.kim@samsung.com>, Kyungmin Park <kyungmin.park@samsung.com>, 
	Krzysztof Kozlowski <krzk@kernel.org>, Alim Akhtar <alim.akhtar@samsung.com>, 
	Stefan Agner <stefan@agner.ch>, Alison Wang <alison.wang@nxp.com>, 
	Patrik Jakobsson <patrik.r.jakobsson@gmail.com>, Philipp Zabel <p.zabel@pengutronix.de>, 
	Shawn Guo <shawnguo@kernel.org>, Sascha Hauer <s.hauer@pengutronix.de>, 
	Pengutronix Kernel Team <kernel@pengutronix.de>, Fabio Estevam <festevam@gmail.com>, 
	Rob Clark <robdclark@gmail.com>, Abhinav Kumar <quic_abhinavk@quicinc.com>, 
	Sean Paul <sean@poorly.run>, Marijn Suijten <marijn.suijten@somainline.org>, 
	Dave Airlie <airlied@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>, Sandy Huang <hjc@rock-chips.com>, 
	=?UTF-8?Q?Heiko_St=C3=BCbner?= <heiko@sntech.de>, 
	Andy Yan <andy.yan@rock-chips.com>, Chen-Yu Tsai <wens@csie.org>, 
	Samuel Holland <samuel@sholland.org>, Thierry Reding <thierry.reding@gmail.com>, 
	Mikko Perttunen <mperttunen@nvidia.com>, Jonathan Hunter <jonathanh@nvidia.com>, 
	Dave Stevenson <dave.stevenson@raspberrypi.com>, =?UTF-8?B?TWHDrXJhIENhbmFs?= <mcanal@igalia.com>, 
	Raspberry Pi Kernel Maintenance <kernel-list@raspberrypi.com>, Gurchetan Singh <gurchetansingh@chromium.org>, 
	Chia-I Wu <olvaffe@gmail.com>, Zack Rusin <zack.rusin@broadcom.com>, 
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>, intel-gfx@lists.freedesktop.org, 
	intel-xe@lists.freedesktop.org, dri-devel@lists.freedesktop.org, 
	linux-kernel@vger.kernel.org, nouveau@lists.freedesktop.org, 
	amd-gfx@lists.freedesktop.org, linux-arm-kernel@lists.infradead.org, 
	linux-samsung-soc@vger.kernel.org, imx@lists.linux.dev, 
	linux-arm-msm@vger.kernel.org, freedreno@lists.freedesktop.org, 
	virtualization@lists.linux.dev, spice-devel@lists.freedesktop.org, 
	linux-rockchip@lists.infradead.org, linux-sunxi@lists.linux.dev, 
	linux-tegra@vger.kernel.org, 
	Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>, 
	Jani Nikula <jani.nikula@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Dmitry,

On Tue, Jan 7, 2025 at 12:31=E2=80=AFPM Dmitry Baryshkov
<dmitry.baryshkov@linaro.org> wrote:
> On Sat, 14 Dec 2024 15:37:04 +0200, Dmitry Baryshkov wrote:
> > While working on the generic mode_valid() implementation for the HDMI
> > Connector framework I noticed that unlike other DRM objects
> > drm_connector accepts non-const pointer to struct drm_display_mode,
> > while obviously mode_valid() isn't expected to modify the argument.
> >
> > Mass-change the DRM framework code to pass const argument to that
> > callback.
> >
> > [...]
>
> Applied to drm-misc-next, thanks!
>
> [1/5] drm/encoder_slave: make mode_valid accept const struct drm_display_=
mode
>       commit: 7a5cd45fab0a2671aa4ea6d8fb80cea268387176
> [2/5] drm/amdgpu: don't change mode in amdgpu_dm_connector_mode_valid()
>       commit: b255ce4388e09f14311e7912d0ccd45a14a08d66
> [3/5] drm/sti: hda: pass const struct drm_display_mode* to hda_get_mode_i=
dx()
>       commit: 5f011b442006ccb29044263df10843de80fc0b14
> [4/5] drm/connector: make mode_valid_ctx take a const struct drm_display_=
mode
>       commit: 66df9debcb29d14802912ed79a9cf9ba721b51a4
> [5/5] drm/connector: make mode_valid take a const struct drm_display_mode
>       commit: 26d6fd81916e62d2b0568d9756e5f9c33f0f9b7a

I cannot find these in drm-misc or drm-next, but they are in drm-tip?
The last one due to commit 2bdc721917cf141f ("Merge remote-tracking
branch 'drm-misc/drm-misc-next' into drm-tip").

What am I missing?
Thanks!

P.S. Sima: noticed while resolving a merge conflict using drm-tip. Thx!

Gr{oetje,eeting}s,

                        Geert

--=20
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k=
.org

In personal conversations with technical people, I call myself a hacker. Bu=
t
when I'm talking to journalists I just say "programmer" or something like t=
hat.
                                -- Linus Torvalds
