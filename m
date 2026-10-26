Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793008089;
	b=DMnWWdery4AlgVueCweJkpgjD/o9PcmPTSBykVS6tx8TX6qelrQ8d6Y+JpsD3x4b2cU4
	 1pHcG1akQkH28Mh3/5/k2oiL+oO44Y3yQMBBDojPauLBtT0lNqoOVd5Lje2nSl2xpqLBk
	 ujrp8Uia1Wd5KuVT01Zg6EVSXUSWC/IALtds6eCUIi69jIpNZVPxgWQqrtCM9p0AN5SXf
	 JaVgxBr1kh/wifIOYKUCZFMXISf2x8zB7wmG6DVni4b2GrNwrowpdDW/fR1kjQznO7Omo
	 D1uVmM5tk8mW2AzB0byp5MagcDhwhFlBsN8FrBIH8+Krhl8osm5P70rgYfEVPTEPhpQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793008089;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=QNjun783pTdiQfTLrK5OlpyTvS0qYP5wBlMosU8czwU=;
	b=Aih4frrwOgkTQRXjvdK2Vnkps/QeGVV93hPL6yLU3bisH+aBYqP0i0nUVvDGpb31+e1d
	 /5/2sVWpxoVrq4FTTNQj/BQDl5uApv/+M/aNs+IfwAjkWmE/ZayO3cjaZZPHHHOY94+KQ
	 DFwLJu6cem1e67hgbeIJELmrlrY2OfPPfYq4Nho4IBcBWhmsnYzbxFrD+vUEzYm5GCTEF
	 g/P4QShGDvrHs26eOVXdGQzC0zFoQ5lKTrz6rQDV7O0MZREgQ3C1DRWqlBJFFte3GCSAp
	 CuZJknZH6fC46gquLl/bJZVM2RST5DcbvL8UMgr9lpo77r3gDyw1BazQWC6LzT5cF9g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=WRAZij1+;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24756606A31A;
	Mon, 26 Oct 2026 09:48:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=WRAZij1+
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 46DE51F01825;
	Mon, 26 Oct 2026 09:48:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793008088;
	bh=QNjun783pTdiQfTLrK5OlpyTvS0qYP5wBlMosU8czwU=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=WRAZij1+fo95xgkPP6IeMvJXu04cno+M94OLhvwCJWahVV2HDahyQg+UaLuOONoDA
	 v9EzPlyA/1VGve/xAg3e5pB762wjipFXQ79Nm1+wUpgNaYsSoGXjv8AfuXuDwObv+U
	 ZnLHFR0gIL5s3batFhAHagCxSp8Z9RHPwm8NZxqsE3OaskCio0gmy9Zoy2qMVE12XY
	 9MsgGyYNG97usTLazHC3RZKeKXI6xQ7NEaumt+d4YxHJiorJURsjOlaW/+hiEqzj7D
	 /zKMpnmZu2g3Qo0HWLrj3Et+ooCE7dkQs80TkYZAFs1o9IhIQRfDajSoZ3Lz7nb2qK
	 Chumyth2YaFVw==
Message-ID: <sashiko-outbox-184837@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 02/23] drm/msm/dcp: Add HFI packet helpers
Reply-To: sashiko-reviews@lists.linux.dev
To: "Jayant Shekhar" <jayant.shekhar@oss.qualcomm.com>
Cc: virtualization@lists.linux.dev, dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org, robh@kernel.org, conor+dt@kernel.org, media-ci@linuxtv.org, "Michael
 S. Tsirkin" <mst@redhat.com>, "Eugenio Perez" <eperezma@redhat.com>
In-Reply-To: <20261026-jshekhar-dcp-hlos-v2-2-7cf014efdee1@oss.qualcomm.com>
References: <20261026-jshekhar-dcp-hlos-v2-0-7cf014efdee1@oss.qualcomm.com>
 <20261026-jshekhar-dcp-hlos-v2-2-7cf014efdee1@oss.qualcomm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 26 Oct 2026 09:48:07 +0000
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Post: <mailto:virtualization@lists.linux.dev>
List-Help: <mailto:virtualization+help@lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
List-Owner: <mailto:virtualization+owner@lists.linux.dev>
Precedence: list

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Low] drm/msm/dcp: DRM_MSM_DCP bool dependency on tristate VIRTIO allows =
DRM_MSM=3Dy with VIRTIO=3Dm
--

commit 29edd03d5dbd7916e10401025f35f2e578051ed0
Author: Jayant Shekhar <jayant.shekhar@oss.qualcomm.com>

drm/msm/dcp: Add HFI packet helpers

This commit adds the HFI packet definitions, packing and unpacking helpers,
and key-value parsing utilities for communicating with the Display
Coprocessor (DCP) firmware, along with the DRM_MSM_DCP Kconfig symbol and
Makefile rules.

> diff --git a/drivers/gpu/drm/msm/Kconfig b/drivers/gpu/drm/msm/Kconfig
> index ed1c4775d1e92..a9f049271c251 100644
> --- a/drivers/gpu/drm/msm/Kconfig
> +++ b/drivers/gpu/drm/msm/Kconfig
> @@ -114,6 +114,31 @@ config DRM_MSM_DPU
>  	  the MSM DRM driver. It is the display controller found in devices
>  	  using e.g. SDM845 and newer platforms.
> =20
> +config DRM_MSM_DCP
> +	bool "Enable DCP firmware-delegated display support in MSM DRM driver"
> +	depends on DRM_MSM
> +	depends on VIRTIO
> +	select DRM_MSM_KMS
> +	select DRM_BRIDGE_CONNECTOR
> +	select DRM_MIPI_DSI
> +	select DRM_DISPLAY_DSC_HELPER
> +	default y

[Severity: Low]
Can this Kconfig dependency allow CONFIG_DRM_MSM_DCP=3Dy when CONFIG_DRM_MS=
M=3Dy
and CONFIG_VIRTIO=3Dm?

Both DRM_MSM and VIRTIO are tristate symbols, while DRM_MSM_DCP is a bool
symbol whose objects in drivers/gpu/drm/msm/Makefile are linked directly
into msm.o via msm-display-$(CONFIG_DRM_MSM_DCP) and
msm-$(CONFIG_DRM_MSM_KMS) +=3D $(msm-display-y):

drivers/gpu/drm/msm/Makefile:
    msm-display-$(CONFIG_DRM_MSM_DCP) +=3D \
            dcp/hfi/hfi_packer.o \
            dcp/hfi/hfi_unpacker.o \
            dcp/hfi/hfi_utils.o

In Kconfig, a bool option with depends on DRM_MSM and depends on VIRTIO
evaluates its upper bound as y even when CONFIG_DRM_MSM=3Dy and
CONFIG_VIRTIO=3Dm. When the DCP VirtIO transport and driver objects are add=
ed
to msm-display-$(CONFIG_DRM_MSM_DCP) later in this series ("drm/msm/dcp: Add
HFI VirtIO transport", "drm/msm/dcp: Add Qualcomm VirtIO transport wrapper",
and "drm/msm/dcp: Add DCP VirtIO driver"), built-in msm.o calls VirtIO core
and vring symbols such as register_virtio_driver(), register_virtio_device(=
),
virtio_find_vqs(), and vring_create_virtqueue() that live in loadable
modules when CONFIG_VIRTIO=3Dm, resulting in a vmlinux link failure.

Should DRM_MSM_DCP use depends on VIRTIO=3Dy || VIRTIO=3DDRM_MSM (or DRM_MS=
M use
depends on VIRTIO || !DRM_MSM_DCP) to prevent a built-in msm driver from
linking against modular virtio?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261026-jshekhar-d=
cp-hlos-v2-0-7cf014efdee1@oss.qualcomm.com?part=3D2
