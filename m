Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793916863;
	b=xpDEt3SowCek7JQ7el++1c+t8QOBZO8bECbANTJ9IVB0gjmumNQiE08vXix8zIOT8xY0
	 NEc77Ypr4uDDAoYnCatL9MJt6fMEYC2yWYGwToA1pyOGSse/84d5rL4WB5CJZ7UQOHETn
	 3igEmB8EMM3WXZ71vxwPR0LoIvYCDzEJswAO44STM1VTML5oK4uSxCQV5SoIBYifeeIUB
	 Q5rmdjaxf8SJAicKPycN+gM+XmHZY6mqMYcAB+1z2HMJ54c7TRAGf7I9hDgJRhivHIs0e
	 pXSsMFU7ll4Koh0QB1EbbdM3UgbfrVBbdosaGCjnF/IRiMWxpooCRB1XcpUYgq9JTWg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793916863;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=GO2ern5EiC8uHk4JIAJmsI3JtTsfoxT909UmQwYZYMY=;
	b=ebafVwfVZYT+6PXYhlWL/80Et9unHrexA2VDokCsW+nDhMqlGZq5b/EqxtsTKV/gEgMF
	 YCuhlwMYBsIa42eeciLRIYx0YGQPyPcXr03yNxytJyUbBDFn0eCBqQ+/KpEDYJSveY61G
	 ilh3ywKPQwqI1gPxaKWpZl1v7o9PSPQnmPKrHil6z23gBCGpqmL+WDWEuTVRY2rAJyu7U
	 mywkDnzhx7/8sp2FrHWVIFcg/WieuKKEUibVteq4sOXHnKni3hiudpaK5dY4LdbxLStKM
	 uTkMPRWIq9pgEzsTWI3/N465RHUNK0FDQ4tFQ3mQE4jkMapJsKEVsMKPxkY6PHpVfBA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="IF4b/dl2";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07D95606A31B
	for <virtualization@lists.linux.dev>; Thu,  5 Nov 2026 22:14:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=IF4b/dl2
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 50D1C1F0089F;
	Thu,  5 Nov 2026 22:14:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793916862;
	bh=GO2ern5EiC8uHk4JIAJmsI3JtTsfoxT909UmQwYZYMY=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=IF4b/dl2+MNl1LQpPeb24+rnmVidXx0JXjb9M3ih4QuiNlV2JwkdpJa4W2+EB6ZZF
	 qc1eac+2UQtpuofFbMXGUkuLpb91oP4O28f5mZ7S+0dDdRE9phCgP+UV06rNZffmxi
	 ls9AlycATCrjThkSOedewpWUfYLE0g8hZ9y2IzcqLVDytH1NdWEiz5dcZAs588FwgW
	 Vsk6xsA3cuwLFd41mG0u8M+1UbQl0xuktMschWgYHW+zEYdam4y7y1IL7dTZk6jjGE
	 zdi32t+dHyW0ITB9BbG+HCMyH52Vidvtg8hjuZQ32Ux+SpHaF8rmqrQUhcDyrDR2eu
	 g9S8ZrxH7vENg==
Message-ID: <sashiko-outbox-200298@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH RESEND 79/83] drm/virtio: Switch to
 drm_mode_config_create_initial_state
Reply-To: sashiko-reviews@lists.linux.dev
To: "Maxime Ripard" <mripard@kernel.org>
Cc: virtualization@lists.linux.dev, "Michael S. Tsirkin" <mst@redhat.com>, "Eugenio
 Perez" <eperezma@redhat.com>
In-Reply-To: <20261105-drm-no-more-config-reset-v1-79-1f58d1e33380@kernel.org>
References: <20261105-drm-no-more-config-reset-v1-0-1f58d1e33380@kernel.org>
 <20261105-drm-no-more-config-reset-v1-79-1f58d1e33380@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 05 Nov 2026 22:14:21 +0000
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Post: <mailto:virtualization@lists.linux.dev>
List-Help: <mailto:virtualization+help@lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
List-Owner: <mailto:virtualization+owner@lists.linux.dev>
Precedence: list

> drm_mode_config_reset() has a dual role: it creates the initial KMS
> state at probe time, and resets hardware and software state during
> suspend/resume cycles.
>=20
> Since the two roles need different behaviors (notably for objects like
> drm_private_obj that must persist across suspend/resume),
> drm_mode_config_create_initial_state() was introduced to handle only
> the initial state creation at probe time.
>=20
> Switch to drm_mode_config_create_initial_state().
>=20
> Signed-off-by: Maxime Ripard <mripard@kernel.org>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261105-drm-no-mor=
e-config-reset-v1-0-1f58d1e33380@kernel.org?part=3D79

