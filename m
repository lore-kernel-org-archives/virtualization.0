Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FC393002AB
	for <virtualization@lists.linux.dev>; Sat, 26 Sep 2026 06:03:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790402597; cv=none; b=LXDUUx3yHJA7/xO3Z0i4UJRwa0zd2XHMz6KMvkW0i8YJ5kmVTrkTSh5QXHdAQaEE+H3uYOhnmyjspxF2TLL2VSwvSgQ25rX0jOuqbxH+abIhi8whYvdbvrZf4PdMGhcAGdg96cozYXZEko34vvyxH3CwFpTep13+xgalvRHWhqQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790402597; c=relaxed/simple;
	bh=r7Rt4vc6FlNkYH4v41wMTk3WWNQY7WfKtPbZN5d7sng=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=G+5LSCSSZIFBKSfuJz1ZOyepV7RZVWkoRF3/8b3/B1mn6KWQdwQeNrjsAt733ybMlsU0a9MJVhTdNX74bD/4KDWOSGv6aMNilY0CqMMS6XI6JqPUZGVGWyMe+nvX0Kj6B7LeI1ScN565Yj2sdxRD3TNp5lmeK5I6TiycXQpmuuM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=m/fCr6li; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="m/fCr6li"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 577511F000FF;
	Sat, 26 Sep 2026 06:03:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790402595;
	bh=r7Rt4vc6FlNkYH4v41wMTk3WWNQY7WfKtPbZN5d7sng=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=m/fCr6liMBqqVIU3b6fB/maf7PCAzf1WNkb+Re4nvDa0OrRgieqfYUD8u0vUN/ZjX
	 eLIdX7IeV7TgEhpE+8/Rqq9Fa39G8PisvwMfalYx9PKdU6Uq8b6lvrFBsz1F5cvArq
	 lciKMzpe3f+pLNN0FfgKJtIR9BRUw8bmGTsJEwmdXauXZL35Bev/DzG1SLJxNSZWz8
	 en3cLh3BBKjhjHFHyvZEhYvCgFRMYirj8VlIowFrapy7lzHAQPII7jfI153wkVfI26
	 Yszdc/1CeT02AYEN4Pdm/or1699eQ/tqGbQ5LmQZRSiDeeZdu4O60Kf1rxFo8ekrOt
	 gJhD1/UWjosYQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 1/2] hwrng: virtio - use min() in copy_data()
Reply-To: sashiko-reviews@lists.linux.dev
To: "Thorsten Blum" <blum@kernel.org>
Cc: "Eugenio Perez" <eperezma@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, virtualization@lists.linux.dev
In-Reply-To: <20260926055853.4868-3-blum@kernel.org>
References: <20260926055853.4868-3-blum@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 26 Sep 2026 06:03:14 +0000
Message-Id: <20260926060315.577511F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>

> Use the simpler min() macro since all values are unsigned and
> compatible. The subtraction avail - vi->data_idx is also guaranteed to
> be positive by the preceding check.
>=20
> Signed-off-by: Thorsten Blum <blum@kernel.org>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260926055853.4868=
-3-blum@kernel.org?part=3D1

