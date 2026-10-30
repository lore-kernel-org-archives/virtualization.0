Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793364962;
	b=k8ZWmN1kYQzGOE0i4yfaFEVQDmr4I3y8TzfTcrMPfelCVKAuSEYFNwBru83svC1xnR5Z
	 aE1hFNCNiC/w7IWkAfHclfull1xqLNTCnoV7UhT8b1sf387IBzbTNg5i6zuS0MA5AmANQ
	 l3KVSLoOvr6UQcefZdB/zuLQoojVz+GK2xD9WeiP4UIhnkFei86/jQMAMxeYpIWozySgi
	 7TU+40teNMZlTvO9Mhq/yedhqfYTZz0MepNis4LNoBh1pItQEY+pDRB8hFQzXAnK2AvJ5
	 mNXI14OEIMYYhCCNx0RCoxnt48oQo5kgOS9VghPnhyZSpqCJ9tFiBXPknrOkOiJa1Vw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793364962;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=QEN1UqSia/bSOQapCp3EkqxCvOcE8KsRJXMohGlQcDQ=;
	b=N6xX8ZQOrj/2W3XiLEo7nuhB5+1+sbwB3eC+lfCUXq+gyiyj39EJ2wPHhsmymie/+Ts4
	 umHGOcWpIjNLc6yQSWaNZP3Q8lu6J/yqc//EUHDm6vNf+dzZ29Ew+m89cDGEA6yx62TZw
	 XXc2L/nz8O7PRNPlcNdBz7/IVVywCklU/1oJFXe9Ax2i+g9Fp9CzDBbP/NLfcxZkOVB9f
	 s+fn/3eLDGI1ibUSv2ePoLsZWp6oQwcGWUq8uNE5eY4DrsFyXoeTZMwJlRYt9rOB3PWoM
	 NflW/2CbP7pebkg2s70Uwy4xQXplxdLmV9nJYR1ABfV9WafbcAewYwux521TTz2z6sg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=DbvVbneF;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC497606A31C;
	Fri, 30 Oct 2026 12:56:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=DbvVbneF
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 840761F000C1;
	Fri, 30 Oct 2026 12:56:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793364961;
	bh=QEN1UqSia/bSOQapCp3EkqxCvOcE8KsRJXMohGlQcDQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=DbvVbneFlRcReg135ryJEYVhhtWakAOVNath1hcKIIXE0a0XxAPDDvNN6T7Uf6+oe
	 8w5jtD2yqrswAxXmfPTHEdkD7AvDqLamYaTsnJnneKspcbfXmYHU3OGl89jWEz8/U/
	 /ww4ODFnAJ7tLbMPad8NuI/UAu0PK8s28Ey4jTtat4X8zzsm4uIT7x105xj2SQfJbe
	 wzxdFTqJOrrKiP1LRPFbbaswMYtV6X09XW80Okkv+fqOYtPGsvIPYCiSGFVMsrui5k
	 MrMYZoVyeIy+hz3rgx3Z3HJJdqyKirPMRBric5eDJy0W8pHIi0gyTDHmZJorASfuP1
	 +FvfPpgyOt/TA==
From: Maxime Ripard <mripard@kernel.org>
To: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	David Airlie <airlied@gmail.com>,
	Simona Vetter <simona@ffwll.ch>,
	Maxime Ripard <mripard@kernel.org>
Cc: dri-devel@lists.freedesktop.org,
	=?UTF-8?q?Ma=C3=ADra=20Canal?= <mcanal@igalia.com>,
	Dave Stevenson <dave.stevenson@raspberrypi.com>,
	Raspberry Pi Kernel Maintenance <kernel-list@raspberrypi.com>,
	Ruben Wauters <rubenru09@aol.com>,
	Chen-Yu Tsai <wens@kernel.org>,
	Samuel Holland <samuel@sholland.org>,
	linux-sunxi@lists.linux.dev,
	=?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
	Alex Deucher <alexander.deucher@amd.com>,
	amd-gfx@lists.freedesktop.org,
	Andrew Jeffery <andrew@codeconstruct.com.au>,
	Joel Stanley <joel@jms.id.au>,
	Dave Airlie <airlied@redhat.com>,
	Jocelyn Falempe <jfalempe@redhat.com>,
	Russell King <linux@armlinux.org.uk>,
	Alim Akhtar <alim.akhtar@samsung.com>,
	Inki Dae <inki.dae@samsung.com>,
	Krzysztof Kozlowski <krzk@kernel.org>,
	Kyungmin Park <kyungmin.park@samsung.com>,
	Peter Griffin <peter.griffin@linaro.org>,
	Seung-Woo Kim <sw0312.kim@samsung.com>,
	linux-samsung-soc@vger.kernel.org,
	Alison Wang <alison.wang@nxp.com>,
	Stefan Agner <stefan@agner.ch>,
	Tian Tao <tiantao6@hisilicon.com>,
	Xinwei Kong <kong.kongxinwei@hisilicon.com>,
	Yongbang Shi <shiyongbang@huawei.com>,
	Paul Kocialkowski <paulk@sys-base.io>,
	Huacai Chen <chenhuacai@kernel.org>,
	Icenowy Zheng <zhengxingda@iscas.ac.cn>,
	Jianmin Lv <lvjianmin@loongson.cn>,
	Mingcong Bai <jeffbai@aosc.io>,
	Qianhai Wu <wuqianhai@loongson.cn>,
	Xi Ruoyao <xry111@xry111.site>,
	Gerd Hoffmann <kraxel@redhat.com>,
	spice-devel@lists.freedesktop.org,
	virtualization@lists.linux.dev,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	linux-renesas-soc@vger.kernel.org,
	Marcus Folkesson <marcus.folkesson@gmail.com>,
	Iker Pedrosa <ikerpedrosam@gmail.com>,
	Alain Volmat <alain.volmat@foss.st.com>,
	Raphael Gallais-Pou <rgallaispou@gmail.com>,
	Jonathan Hunter <jonathanh@nvidia.com>,
	Mikko Perttunen <mperttunen@nvidia.com>,
	Thierry Reding <thierry.reding@kernel.org>,
	linux-tegra@vger.kernel.org,
	Alexey Brodkin <abrodkin@synopsys.com>,
	Hans de Goede <hansg@kernel.org>,
	LiangCheng Wang <zaq14760@gmail.com>,
	Alex Lanzano <lanzano.alex@gmail.com>,
	Sean Paul <sean@poorly.run>,
	Chia-I Wu <olvaffe@gmail.com>,
	Dmitry Osipenko <dmitry.osipenko@collabora.com>,
	Gurchetan Singh <gurchetansingh@chromium.org>,
	Haneen Mohammed <hamohammed.sa@gmail.com>,
	Louis Chauvet <louis.chauvet@bootlin.com>,
	Melissa Wen <melissa.srw@gmail.com>,
	Oleksandr Andrushchenko <oleksandr_andrushchenko@epam.com>,
	Jerome Brunet <jbrunet@baylibre.com>,
	Kevin Hilman <khilman@baylibre.com>,
	Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
	linux-amlogic@lists.infradead.org,
	Harry Wentland <harry.wentland@amd.com>,
	Leo Li <sunpeng.li@amd.com>,
	Rodrigo Siqueira <siqueira@igalia.com>,
	Jani Nikula <jani.nikula@linux.intel.com>,
	Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
	Rodrigo Vivi <rodrigo.vivi@intel.com>,
	Tvrtko Ursulin <tursulin@ursulin.net>,
	intel-gfx@lists.freedesktop.org,
	intel-xe@lists.freedesktop.org,
	Danilo Krummrich <dakr@kernel.org>,
	Lyude Paul <lyude@redhat.com>,
	nouveau@lists.freedesktop.org
Subject: Re: (subset) [PATCH v2 00/59] drm/connector: Convert all drivers to atomic_create_state and remove reset
Date: Fri, 30 Oct 2026 13:55:55 +0100
Message-ID: <179336494956.280337.14142889938692228617.b4-ty@kernel.org>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261022-drm-no-more-connector-reset-v2-0-0b7e4e85b1e8@kernel.org>
References: <20261022-drm-no-more-connector-reset-v2-0-0b7e4e85b1e8@kernel.org>
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Post: <mailto:virtualization@lists.linux.dev>
List-Help: <mailto:virtualization+help@lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
List-Owner: <mailto:virtualization+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

On Thu, 22 Oct 2026 14:30:59 +0200, Maxime Ripard wrote:
> This is a follow-up to the plane and CRTC reset removal series, and
> part of a larger effort to remove the reset hook from all KMS objects.
> 
> The connector reset hook is overloaded: it is called both at probe
> time to create the initial software state and during suspend/resume to
> reset hardware and software state. These two roles have different
> requirements, and the reset hook is not fallible, making error
> handling difficult for the initial state allocation path.
> 
> [...]

Applied to misc/kernel.git (drm-misc-next)

[01/59] drm/hdmi: Change __drm_atomic_helper_connector_hdmi_state_init parameter order
        commit: e8698caa41f659739861f3c5b19070ea973f58ab
[02/59] drm/atomic-state-helper: Rename connector_tv_margins_reset to state_init
        commit: 39e8c69f41882b12ffd1cbea39b07923dc430de6
[03/59] drm/atomic-state-helper: Rename connector_tv_reset to state_init
        commit: 27411554b73b2de2e230df3fefc6821485b3d509
[04/59] drm/panel: Add atomic_create_state support
        commit: a8684a05336c1115172bd5fce9a942d830e11d13
[06/59] drm/aspeed: Switch to drm_atomic_helper_connector_create_state
        commit: f88d567860da9e5a5ba0f05424ea4c8321af0467
[07/59] drm/ast: Switch to drm_atomic_helper_connector_create_state
        commit: 42572c272e61af9c53162f307c81bb48a0977e5d
[19/59] drm/hisilicon: hibmc: Switch to drm_atomic_helper_connector_create_state
        commit: 800edc28eb000fbcb2229d6799ffa5c3831def15
[20/59] drm/logicvc: Switch to drm_atomic_helper_connector_create_state
        commit: ec2e19c6518ca8959ca009491e62913ea53be450
[22/59] drm/mgag200: Switch to drm_atomic_helper_connector_create_state
        commit: f15c3a86f606c7dd8e057dc7a3d762d634b8fa20
[24/59] drm/qxl: Switch to drm_atomic_helper_connector_create_state
        commit: e439361203a610cebd725e068dc1694d585d6ecf
[27/59] drm/sitronix: st7920: Switch to drm_atomic_helper_connector_create_state
        commit: 382b5915baae6d289cf550b70e325cd162d140c5
[33/59] drm/tiny: bochs: Switch to drm_atomic_helper_connector_create_state
        commit: 6b1c795028b1552f25bc4b707673e0d848786dcb
[34/59] drm/tiny: cirrus: Switch to drm_atomic_helper_connector_create_state
        commit: 777642458977878a2e81399adf16b1e23ab57b17
[35/59] drm/tiny: gm12u320: Switch to drm_atomic_helper_connector_create_state
        commit: 379d9ab55e5d0453ab744892981f122f8e5614fc
[36/59] drm/tiny: pixpaper: Switch to drm_atomic_helper_connector_create_state
        commit: 417ff0dc9d68de04248361c3db10c902e33b87c6
[37/59] drm/tiny: repaper: Switch to drm_atomic_helper_connector_create_state
        commit: 7fdf84a3913597bb662a1d1aa37f798576dbd2ed
[39/59] drm/udl: Switch to drm_atomic_helper_connector_create_state
        commit: 9b9731aea4920327ec8fb757bcc9fa88c7c8fa45
[40/59] drm/vboxvideo: Switch to drm_atomic_helper_connector_create_state
        commit: 8c0c25d8724aa3a0850efac1f117444485ce899c
[46/59] drm/gud: Convert to atomic_create_state
        commit: 79363b9b53e285a5f98b95d75e32f889ef3431f3
[50/59] drm/vc4: hdmi: Convert to atomic_create_state
        commit: 946c74390c2fe7cc9acedf2d333ca1f924b7eba3
[51/59] drm/vc4: vec: Convert to atomic_create_state
        commit: 76000c76a4784e8bc4ea957dcebc93449f762bd7
[54/59] drm/ast: Convert to atomic_create_state
        commit: a1e63ab695ad76850ab9787b9eb6aab695dc2965

Thanks!
Maxime
