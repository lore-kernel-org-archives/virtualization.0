Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795596495;
	b=EkXFkPx6hbOQbxl13JsDb3aZdMzjTGJhyGnbWA1sAwprtf6oQXnmSFYl8Z+WqXNn6SxE
	 QYdYCRGw/DhmS9+HN5RbSdrXYOtTPvpBn9vzhCnSJ2zpJ2dJ40GQmmYAIxjfJpFlcjiFc
	 emzZOVElDyfeQLONytetCLMX4bxaQ123hM1bqK5m/iF2Mr/+VkEo1ODU+eD0GVB5XHVRZ
	 4BOHmnQgPqWM5P0oK0zsQBoFR8JizVnLaOJdCr+3S+Htu/riNsmspvHO6o5hBzOYKe1SU
	 jFO4ROaHrKpExiw7gDwqZ9iAJhtvxB6NibZ5Edu344iDF9eqff6uu2oM9bnR9z6s0Jw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795596495;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=TX9WG0g9dwAwAUYSi1S1P+kJfwb7b2Nw75I22DPb2HY=;
	b=HJ69l1ge5T6fmf5J69X+THZYQUTjcYvOpJn0g2GaEVHVR8d0VTBd7UQ1JHmxcJsvXSlT
	 qfRKw3FsZ8Ho5B5zJ3fciM8W9NNVubBCyIvwUIauymP6NESQB4FIoAMozkRSkWumO7Ga3
	 hswxICBBh4Q13eH928iOKVBzNKYNsefEBtGtp5OFNvQrOvOvJsnpNSEwz3JJ1ZbUdNYS2
	 jXy6ABbHxzV7W4HxnQ8YP66XYkN5jmZzjDM1w4+cu39bmCOMEg+kq7/H5saXxu7zbbZ8j
	 0PHESQjqA4VYJ1fJllDcuK5bU/xr3XTVtmGVkhJsgR6GP37Di5r4JNKvrTVbJDsj8jg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Gdtteylv;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5373606A332
	for <virtualization@lists.linux.dev>; Wed, 25 Nov 2026 08:48:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Gdtteylv
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DC33C1F000C0;
	Wed, 25 Nov 2026 08:48:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795596495;
	bh=TX9WG0g9dwAwAUYSi1S1P+kJfwb7b2Nw75I22DPb2HY=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=GdtteylvG6y+mn6mDiiNtZidALLO0CDYrjO1D+MOWzPy+lhQD1ZWl5A2cY6RQz2m2
	 1NmyIkkXZp+rn0LPSG9qhxVakqGZwf6T8MF+L7l5sWKT3FmBr9A5XRQHPH2E9hJ4uT
	 ADGY0doUoYc8EmTHZpYs0m2nEBursefI+K2Uba1QCD8YH9v1Zu0SkIOGJOqBPUIxrj
	 XIkwQp1KCk0LM4ZJzYEO+7ZaWUti2TFaxGzTvvLapf7uXAoZyNHQQT3wxzpRbsyoLh
	 pK36JnMH1poFmXEeYcO+LIb+FVZGp8/UP52V7aWnfy/QBx9x9KuKFQBVATXK0wpY93
	 oTVmPRmahRbpA==
Message-ID: <sashiko-outbox-232942@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 0/2] virtio_blk: add FUA write support
Reply-To: sashiko-reviews@lists.linux.dev
To: "Alberto Faria" <afaria@redhat.com>
Cc: virtualization@lists.linux.dev, "Michael S. Tsirkin" <mst@redhat.com>, "Eugenio
 Perez" <eperezma@redhat.com>
In-Reply-To: <20261125083947.263216-1-afaria@redhat.com>
References: <20261125083947.263216-1-afaria@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 25 Nov 2026 08:48:14 +0000
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Post: <mailto:virtualization@lists.linux.dev>
List-Help: <mailto:virtualization+help@lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
List-Owner: <mailto:virtualization+owner@lists.linux.dev>
Precedence: list

Sashiko has reviewed this 2-patch series and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261125083947.2632=
16-1-afaria@redhat.com
