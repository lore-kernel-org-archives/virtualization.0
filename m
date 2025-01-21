Received: from mail-qv1-f44.google.com (mail-qv1-f44.google.com [209.85.219.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 204631EF0B4;
	Tue, 21 Jan 2025 12:47:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737463653; cv=none; b=d0obWjy8gTtbTAVUHqvp9+3QV10zhbftQj4zdDRx/9JmAXflGOIIfEp2kmJyj3pfHF8+DrrN2FFjAXmkdVrlSvPOOBjqHZahVKtQq8KHZdWFDi6nQQpRD2T/vqpj0DqrVUpiqG5m2ayniOC39A2EHgmULbSJssjABYBqqXMnTBI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737463653; c=relaxed/simple;
	bh=rQT8lxkiAOLFyzoZOxOlLOMYHlb9xir2NeN6od/wMWQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Schtc5pG/zumMm5s8E3TThFsFMe0imMiUaoHQ0TjinNK7i/4HFcxWpiyDFzLbOMbGi3K3av77PLMIFSmTd0euRA1OdXC20n/vSIXh6YIuH8QGL+c5pkHxPAPTOPvrws+hUX1/Q9JGl4Z01ua0v+sfbk3d+xoY46IUyWsiA0J9b4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.219.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f44.google.com with SMTP id 6a1803df08f44-6dcdf23b4edso49726356d6.0;
        Tue, 21 Jan 2025 04:47:30 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737463650; x=1738068450;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VXUdfGyq4c5FX1gamn0gc9cnARR4WPDnFMac/C/Y36A=;
        b=HTKNZYSvZSrCWjyA+mrx7FZm+7jw8pb14xGDs4mtx4glZusfQFpLqGQ1/n3+mdEVHT
         wywS3p6VliEtHBgGvQWfDuH1ODyAjE7MtDrvw4NYzOqHRdwLMMasmifSEBx/KR2AW2tw
         cdbIAqTLH+ruYa3I3UFXgSbY7O6Y6xmHHSDBRSurozDaRGaF9QzvYBwZoV5OrRJnZOmZ
         EcJcCueAzehWct0Pl9Rh1XdabGk7W8l9zSC2whxZNn1h3HRI0eD2ynC+t1N6YBH8s7WZ
         Eg691SMnn1YD8xNUKShynOvEi3vXF6elCMGiIgS9Lojy8dRzUtO8t/JQzYZMG1HcbQWa
         TOzw==
X-Forwarded-Encrypted: i=1; AJvYcCUu+fj+pDxQwbJgiQLqnVd7U3vwt454t+uhjqC+Ekoi75o/mxjojZWiTd0u5dYIy2nfJgY=@lists.linux.dev, AJvYcCWuMR2DDKh1MKCNiS49lhol35qtEluk56J810YpQuFZwDf98dwDAu7mdQ8iD1QMNVC4RBGd2yNBfZdeJWw=@lists.linux.dev, AJvYcCXS5ZGNIpv1WAVOkQ+Wq0ki3S5UoW+dByay/xKubnKsJtz+F4BYZloX7dNrl9tR0StddvXyfGv4KFn90rRv52I=@lists.linux.dev
X-Gm-Message-State: AOJu0Yzy6Re3f8Mp3YJAhzZZIEK+i5pGtn0FfbplPtEb8Ysy2twxRDQE
	BuU8b9Q5mPG/dNAt99awaukaYxPzx32gf0fKnLhLtu46xYNugDSnjIernGGS
X-Gm-Gg: ASbGncuWDHElyzj0AucCGkdGExcvxxres7LEFRP8ZluW1p/rwL5T6/UHecQJIWP+KT9
	gu5exa4pjLy81wgYW1K7t5vDCnMOr/kkrQ+6miJYFOPDklo/TIsUhO+3rwT0o6jBve/bP5xGd8i
	qwvLNPi4JKf/PFla8n92Y91j990O/dgxpu3RMqOvvvQDgByE0CIy/Fx5Fr8ByLNcNTJta+O4aKL
	uEs/2+3+oHfhcTZidu5sm94jeaqF/YaPSWWtprem19X5ZlS+OEQs+xG30Z4zxDZxGI9As80iDnl
	rSr/9dOmLtAhrQadxFF8M5EOJb4uuxzJ
X-Google-Smtp-Source: AGHT+IFjF5PkUnDWfPHwpdrOruwgLkcLoTKFhi0CXh/asiaDS2xCq1GCJsgEHWbSCVyBT/sNY7WBVA==
X-Received: by 2002:a05:6102:80a2:b0:4b2:ae3a:35d6 with SMTP id ada2fe7eead31-4b690c889b8mr13684029137.19.1737457837631;
        Tue, 21 Jan 2025 03:10:37 -0800 (PST)
Received: from mail-ua1-f49.google.com (mail-ua1-f49.google.com. [209.85.222.49])
        by smtp.gmail.com with ESMTPSA id ada2fe7eead31-4b68a1ed29dsm2162170137.3.2025.01.21.03.10.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 21 Jan 2025 03:10:37 -0800 (PST)
Received: by mail-ua1-f49.google.com with SMTP id a1e0cc1a2514c-85c4c9349b3so1294550241.3;
        Tue, 21 Jan 2025 03:10:37 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCUKUGZo1zoCFhpPwINqCVMd24Xkv5cA8U1aIAMmPjE2tglEC+POxBmT0wc5WvWL6NHWc58pm14Z68MMjUdAwY0=@lists.linux.dev, AJvYcCXC4SRFNewEKdoqK1NxiwTxOiZftbEmBp+ls5zLeD1aKIHqTW6x6GhM27WmAHMw/djzbYeheeEsuDpQyYs=@lists.linux.dev, AJvYcCXVtNN7Q2vwAMKvsgbuTXnxI6jLTis6nTrKT+loY8jBJHablsC3TO/U/LHBv6LMKvuFDJc=@lists.linux.dev
X-Received: by 2002:a05:6102:1625:b0:4b2:ad50:a99c with SMTP id
 ada2fe7eead31-4b690b86c0fmr12441756137.2.1737457837255; Tue, 21 Jan 2025
 03:10:37 -0800 (PST)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20241214-drm-connector-mode-valid-const-v2-0-4f9498a4c822@linaro.org>
 <173624946815.1500596.321177900833598022.b4-ty@linaro.org>
 <CAMuHMdVwcaY2Fgpf7GYhBrE5B+AEg=v0BH4OjMXgnp=wqjxmKg@mail.gmail.com> <CAA8EJpos0HQpr9P4XRkto0Jy+Anf1xEH2xhEU8wtCyUQd+XwMg@mail.gmail.com>
In-Reply-To: <CAA8EJpos0HQpr9P4XRkto0Jy+Anf1xEH2xhEU8wtCyUQd+XwMg@mail.gmail.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Tue, 21 Jan 2025 12:10:25 +0100
X-Gmail-Original-Message-ID: <CAMuHMdW-9F9aypY_XeU3y=dn3AAxjFrZO+H+=hbMF7nGrTLAQQ@mail.gmail.com>
X-Gm-Features: AbW1kvZBx44easXhFOatWXKdq1_QMeY-mb30d2zlnMs06wKR4MmvmnSlyypmVlE
Message-ID: <CAMuHMdW-9F9aypY_XeU3y=dn3AAxjFrZO+H+=hbMF7nGrTLAQQ@mail.gmail.com>
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
	Jani Nikula <jani.nikula@intel.com>, Stephen Rothwell <sfr@canb.auug.org.au>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Dmitry,

CC sfr

On Tue, Jan 21, 2025 at 11:44=E2=80=AFAM Dmitry Baryshkov
<dmitry.baryshkov@linaro.org> wrote:
> On Tue, 21 Jan 2025 at 11:13, Geert Uytterhoeven <geert@linux-m68k.org> w=
rote:
> > On Tue, Jan 7, 2025 at 12:31=E2=80=AFPM Dmitry Baryshkov
> > <dmitry.baryshkov@linaro.org> wrote:
> > > On Sat, 14 Dec 2024 15:37:04 +0200, Dmitry Baryshkov wrote:
> > > > While working on the generic mode_valid() implementation for the HD=
MI
> > > > Connector framework I noticed that unlike other DRM objects
> > > > drm_connector accepts non-const pointer to struct drm_display_mode,
> > > > while obviously mode_valid() isn't expected to modify the argument.
> > > >
> > > > Mass-change the DRM framework code to pass const argument to that
> > > > callback.
> > > >
> > > > [...]
> > >
> > > Applied to drm-misc-next, thanks!
> > >
> > > [1/5] drm/encoder_slave: make mode_valid accept const struct drm_disp=
lay_mode
> > >       commit: 7a5cd45fab0a2671aa4ea6d8fb80cea268387176
> > > [2/5] drm/amdgpu: don't change mode in amdgpu_dm_connector_mode_valid=
()
> > >       commit: b255ce4388e09f14311e7912d0ccd45a14a08d66
> > > [3/5] drm/sti: hda: pass const struct drm_display_mode* to hda_get_mo=
de_idx()
> > >       commit: 5f011b442006ccb29044263df10843de80fc0b14
> > > [4/5] drm/connector: make mode_valid_ctx take a const struct drm_disp=
lay_mode
> > >       commit: 66df9debcb29d14802912ed79a9cf9ba721b51a4
> > > [5/5] drm/connector: make mode_valid take a const struct drm_display_=
mode
> > >       commit: 26d6fd81916e62d2b0568d9756e5f9c33f0f9b7a
> >
> > I cannot find these in drm-misc or drm-next, but they are in drm-tip?
>
> These are in drm-misc/drm-misc-next, the commit IDs are a part of the
> Git history.
>
> > The last one due to commit 2bdc721917cf141f ("Merge remote-tracking
> > branch 'drm-misc/drm-misc-next' into drm-tip").
> >
> > What am I missing?
> > Thanks!
>
> It might be some kind of misinteraction between drm-misc-next vs
> drm-misc-next-fixes vs merge window. Let me recheck dim rebuild-tip.

I indeed see the commit in
https://gitlab.freedesktop.org/drm/misc/kernel/-/blob/drm-misc-next/include=
/drm/drm_modeset_helper_vtables.h?ref_type=3Dheads

[diving deeper]

So I missed the change from the for-linux-next to the drm-misc-next
branch.  Hence I fetched only the former, and was using a stale
version of the latter.

Apparently Stephen is also using the old branches for linux-next:

    drm-misc-fixes git
https://gitlab.freedesktop.org/drm/misc/kernel.git#for-linux-next-fixes
    drm-misc git
https://gitlab.freedesktop.org/drm/misc/kernel.git#for-linux-next

I believe the latter should be drm-misc-next.
Should the former be drm-misc-fixes or drm-misc-next-fixes? Or both?

Thanks!

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
