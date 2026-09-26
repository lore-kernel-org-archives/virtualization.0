Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F5CF284B37
	for <virtualization@lists.linux.dev>; Sat, 26 Sep 2026 16:39:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790440757; cv=none; b=bHBfcPbyoYjP8+3XoKqozQMKRvGL6xAHmFIR2r92Xt1FdSRUvZWdk2+EJgxfMsOzOKMDiHkyyIUzKlcAp9vxJP9IPsmjBjtdZaHjdvQ1Wnn7s6SdBAmXneET/6ul3ViJAHqRzEngcF+e8mjzPoI4fO/h6L7gV1Hxrx6SUcwMbWA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790440757; c=relaxed/simple;
	bh=NXCWwETl8AP7PG2gqMuh4RCYtkOAclSuUPrmMKZhJ4Q=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=UbXz/SyzuSA8IuTJyEw1Yt5iTRDewXicaXU0AqhhXj0TFI3HIn8Q0kJL4YNDpL34Z85bfmxVaH8lc8B0VNGL/zT0jB6IWElVaxSLP3I9uUTYSc0WM5ie+wNzy3HqkjxIDeMS+5/ZquNyY2E2H//cdqC2CFoVHpD9KcNHAOwAmug=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=U6BGKntt; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="U6BGKntt"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9E63E1F000FF;
	Sat, 26 Sep 2026 16:39:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790440756;
	bh=NXCWwETl8AP7PG2gqMuh4RCYtkOAclSuUPrmMKZhJ4Q=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=U6BGKnttwxo5UDLZFIsNXWAsoiubVc3yKP81PseEBV3bai7MLOATQNsoB8LBMzvti
	 TmdtWomwG0GbcpkGus4u+4HekiqXycy5qN4WJnOeVfXaEqdcS+4IRlItW5sP59NHhu
	 PL5Zs74VY2PhxXuJGdHeYUXFraOTbH1KlVZMkJdOCH0MMD0s+cwvy0eMBEObv5gzMn
	 vmAHQ8pbEUkJX3QxFtxft6DmHvA/LpCWB6qj2P7srOGc0PpUCj45CLBAcCEnbWwiPP
	 JD/mp+iRLGCIeg7dtUAiV+EY3mlFBIclbX1H5fGNbS2TDzZf9/QHMtAtI+fKuM7j6t
	 OuH2luTIMEnJQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 3/5] drm/qxl: clear the monitor configuration for
 disabled head zero
Reply-To: sashiko-reviews@lists.linux.dev
To: "Dillon Amburgey" <dillona@gmail.com>
Cc: "Eugenio Perez" <eperezma@redhat.com>, virtualization@lists.linux.dev, "Michael
 S. Tsirkin" <mst@redhat.com>, dri-devel@lists.freedesktop.org
In-Reply-To: <20260926163123.39217-4-dillona@gmail.com>
References: <20260926163123.39217-1-dillona@gmail.com>
 <20260926163123.39217-4-dillona@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 26 Sep 2026 16:39:15 +0000
Message-Id: <20260926163915.9E63E1F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>

> Disabling head zero leaves its previous monitor entry intact because
> the inactive-head path only clears heads with a nonzero index. With
> another head still active, QXL continues publishing the disabled head
> as a visible monitor.
>=20
> Clear head zero using the same path as the other disabled heads.
>=20
> Fixes: a6d3c4d79822 ("qxl: hook monitors_config updates into crtc, not en=
coder.")
> Assisted-by: LLM sparse
> Signed-off-by: Dillon Amburgey <dillona@gmail.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260926163123.3921=
7-1-dillona@gmail.com?part=3D3

