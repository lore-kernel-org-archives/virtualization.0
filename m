Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3FF839185C
	for <virtualization@lists.linux.dev>; Wed, 14 Oct 2026 17:57:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792000677; cv=none; b=E0dPKm9pJA7RXzynEKjEfmYsl4vE8iZ3XhIRPkJUanHIdDWjygbTLpvcUEvdULL9lLXQZak+HfqSMjzYnmqWtnDxL/C2VJMWKyoGQa6aJB7eUMEszFQ/3W2ESZmWSkKJKySqxSr8/bTMy5mR60cya6eiBu/cfWV5A2ZhFyp+1xs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792000677; c=relaxed/simple;
	bh=VysRVzFfb3fG2h6gHx9IbMDVGMBCT+YHhXUfW1qomS4=;
	h=Message-ID:From:Subject:To:Cc:In-Reply-To:References:Content-Type:
	 Date; b=H29E/iRoRecVUcHCmHDVFdyiAXwMV5vtmDHYNAEk92fMgJZWUlSF09ELIAyYTQucGxyZXKQoJpHHV/lKFidDkOrWVwWS8oWL/aQGYMcPszw9dD8f+1suBtV9QuauMlXgcbNRr/19M3ZfQVXHYJtMMvnL0m6LbyTmhYpLmwA4HfM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=llDSp45o; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="llDSp45o"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F3BFB1F000C4;
	Wed, 14 Oct 2026 17:57:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792000676;
	bh=VysRVzFfb3fG2h6gHx9IbMDVGMBCT+YHhXUfW1qomS4=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=llDSp45ot0jO7zm9RFZJyHQje27hSCv4r0rIWEehgQyv8NBHROJr5QJLZftJHZA76
	 kdmPkeLwMnHaPkfHt6HwFLp+myppR3DlzRLLAR/9v24QV5aFOY0ybRUex7ZTGDuKtQ
	 3PQI0KBpzmvaU5aZw2bSA8LIb+DncZNkCescUqGhJfP3Yda9DXKBs5fU4rVB8Tb04N
	 lt9854zvu7/P7Ie0AwRH52iVDVMjJac5e7Y0ow6TVdeoe6dWJ6XsvjwykPYWymSNRa
	 nYV2FvDPmJRXDF/9SCofjN8C340H0ibG6Q5I10/M1utPPXqACYYSBWvHeyA0iBd5ib
	 kVPxMjwkSoFQg==
Message-ID: <sashiko-outbox-171635@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 44/75] drm/tiny: cirrus: Switch to
 drm_atomic_helper_connector_create_state
Reply-To: sashiko-reviews@lists.linux.dev
To: "Maxime Ripard" <mripard@kernel.org>
Cc: virtualization@lists.linux.dev, "Michael S. Tsirkin" <mst@redhat.com>, "Eugenio
 Perez" <eperezma@redhat.com>
In-Reply-To: <20261014-drm-no-more-connector-reset-v1-44-586c9c026823@kernel.org>
References: <20261014-drm-no-more-connector-reset-v1-0-586c9c026823@kernel.org>
 <20261014-drm-no-more-connector-reset-v1-44-586c9c026823@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 14 Oct 2026 17:57:55 +0000
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>

> The tiny: cirrus connector implementation uses the deprecated
> drm_atomic_helper_connector_reset() as its reset hook.
>=20
> Switch to drm_atomic_helper_connector_create_state() instead.
>=20
> Signed-off-by: Maxime Ripard <mripard@kernel.org>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261014-drm-no-mor=
e-connector-reset-v1-0-586c9c026823@kernel.org?part=3D44

