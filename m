Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA51437E5C3
	for <virtualization@lists.linux.dev>; Wed, 14 Oct 2026 18:10:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792001410; cv=none; b=pA7ggQ8A050pakFJzz25+d8hsjUZ+Ack5LlTcfEK5LD4W/LAJ9LzZGfyHge4gJh1xpYo0d2HX5IlEU61FijYApSbkhWw0V8NZ4AcCJvnE5wqbG5EJKqKTW+B10YrkK+TN6+0uea/hudLPpl5g2nyKpax5bfKbkE4Vt5muf5fZqs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792001410; c=relaxed/simple;
	bh=77BHMLWaUbQMUUAOw5lNnr3vFTX0GA9dPCgiWEZCue8=;
	h=Message-ID:From:Subject:To:Cc:In-Reply-To:References:Content-Type:
	 Date; b=c0Wmtewamu3tqNxwiR+1yQiDD/mXHcLspW938rBQir9p/OeNMw0FpQUMIkodb4fRZG4Jahmwy95cnmcCnhVXv8E55WDtYs1eQWQSeB+algqZmP+7NGhvvvdozM2N7OgwyD8D+N9zOTuP8azGigvZi0aafc9yNpUK+XnKFtMUkwU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZOTx/qYO; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZOTx/qYO"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 76BD61F000C4;
	Wed, 14 Oct 2026 18:10:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792001409;
	bh=77BHMLWaUbQMUUAOw5lNnr3vFTX0GA9dPCgiWEZCue8=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=ZOTx/qYOx5XYdJqKrtwHyGv5bQadZaDiZFNENAzxWo1tnDZbz9fbfvpriPbIjBHLA
	 0rcq/qC1BacPxi6xXKXVss8S3yWf3Rc+qz1WUHLb2YM/Z6Fbbp4U7/CIO/ame4GRGe
	 tK2KnFjgdO9U8GvEUCmUTGDaW8/t/0QRuz9fzy7+KEMJ9JcG7ISc0i687MH0qIKy4P
	 OtZ/7bOqnt7JD9Tkj56e40ciOle+/Mct59Z3Kmo92IbURqoIttxj0MsP0VT01FZeSQ
	 MP0NGtSbEerJR1BNb3g0/D2cCUrO/1GkT9ZHjFZn2f59NXfRyvhjEmbMTWLwy+pseB
	 KWLhD7obiyScA==
Message-ID: <sashiko-outbox-171667@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 52/75] drm/virtio: Switch to
 drm_atomic_helper_connector_create_state
Reply-To: sashiko-reviews@lists.linux.dev
To: "Maxime Ripard" <mripard@kernel.org>
Cc: virtualization@lists.linux.dev, "Michael S. Tsirkin" <mst@redhat.com>, "Eugenio
 Perez" <eperezma@redhat.com>
In-Reply-To: <20261014-drm-no-more-connector-reset-v1-52-586c9c026823@kernel.org>
References: <20261014-drm-no-more-connector-reset-v1-0-586c9c026823@kernel.org>
 <20261014-drm-no-more-connector-reset-v1-52-586c9c026823@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 14 Oct 2026 18:10:09 +0000
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>

> The virtio connector implementation uses the deprecated
> drm_atomic_helper_connector_reset() as its reset hook.
>=20
> Switch to drm_atomic_helper_connector_create_state() instead.
>=20
> Signed-off-by: Maxime Ripard <mripard@kernel.org>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261014-drm-no-mor=
e-connector-reset-v1-0-586c9c026823@kernel.org?part=3D52

