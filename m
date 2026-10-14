Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73DD554B1A7
	for <virtualization@lists.linux.dev>; Wed, 14 Oct 2026 17:53:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792000400; cv=none; b=OFmgRNJXX+lmmDzhyxxnlSh+7ldZY+SNeiC3lpWBLXqlur6WxUb2dcRtTTJTtV7PP7Mp9eogAgCCelINyvI3wFdkI/rrr/aM++7UA7bs7Rnyy2WRan07+IbKEtmFWn0bkwERa4PjXrJy/7Uxv7ITHHUWJhAFHWGVMxnCiZWiuWo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792000400; c=relaxed/simple;
	bh=ciDGX7FgHaHIF/m5fBcPYLcvhRqlMK8NB284qcsxMKw=;
	h=Message-ID:From:Subject:To:Cc:In-Reply-To:References:Content-Type:
	 Date; b=RyHzUp7RnMSWIUzn+kLLMTa1nDEKmrI6LHLyPzbgrW1hByGe30/SoD0LKvxzG0HG8HVhgjMz9YAdUTWoO00VV0D3UjgduAHXnuZ8SAg1w+jRNIGq6YhMsD2anPRFwx8llfCkiKi0bBrRwS0vBEf65q+xcdQeNB/ZTqmOdMVhIPI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VfjeQiN+; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VfjeQiN+"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AD71C1F000C4;
	Wed, 14 Oct 2026 17:53:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792000399;
	bh=ciDGX7FgHaHIF/m5fBcPYLcvhRqlMK8NB284qcsxMKw=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=VfjeQiN+z6iTUY6ZFq7LO+VNsdoG6fMnjFFxvvtMXlmkiK/cWB9LNJtJbBoi06z1F
	 BgZl5zbbeygCqqJGzaA0Ww4tiZif3BaAwqttBvQP7MKFOUya3K+TlsDMUIO6nRPHsW
	 sKuuS5O+meRj6EBJj3+yuMuKHONZbPFXb/77k3g2/vXOTiar4cmFwCDsXkdkkSZO8B
	 8htkW2leahyOaQR0vPZKcHQmjln4Y0yiRqUSsq49p4IIna02ZA+87HS/9ilz4kDeyP
	 YM5R/tpmJAoDetcRQqWDe2mIZt6nWoz+/P8nDZsE7NMwN6v8jfUDaZh2JhoNO1N/7p
	 dDGCux1AFZbxg==
Message-ID: <sashiko-outbox-171621@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 31/75] drm/qxl: Switch to
 drm_atomic_helper_connector_create_state
Reply-To: sashiko-reviews@lists.linux.dev
To: "Maxime Ripard" <mripard@kernel.org>
Cc: virtualization@lists.linux.dev, "Michael S. Tsirkin" <mst@redhat.com>, "Eugenio
 Perez" <eperezma@redhat.com>
In-Reply-To: <20261014-drm-no-more-connector-reset-v1-31-586c9c026823@kernel.org>
References: <20261014-drm-no-more-connector-reset-v1-0-586c9c026823@kernel.org>
 <20261014-drm-no-more-connector-reset-v1-31-586c9c026823@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 14 Oct 2026 17:53:18 +0000
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>

> The qxl connector implementation uses the deprecated
> drm_atomic_helper_connector_reset() as its reset hook.
>=20
> Switch to drm_atomic_helper_connector_create_state() instead.
>=20
> Signed-off-by: Maxime Ripard <mripard@kernel.org>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261014-drm-no-mor=
e-connector-reset-v1-0-586c9c026823@kernel.org?part=3D31

