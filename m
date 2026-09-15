Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F604388881
	for <virtualization@lists.linux.dev>; Tue, 15 Sep 2026 14:22:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789482135; cv=none; b=TgdfuOiZ2zladaC1y6+i0kNLAOrOOU1nQRC4wipd9EA9iXfiiHZTumpnndQzR+7GJz2WSuCBnkRSK8swbTDELPhXQj2ioVhGTWl8mAKXn6snV7SY7xdhRUicrZV1SB+0CFsqokbV9u+ZJOGlpBPWwo8mg1RxAYGA6wngs1wcjF8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789482135; c=relaxed/simple;
	bh=dvG9vrjCa4ZPkWlOmi3sL+571pAf7FI722NLWwgNamU=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=VVgr/a/g80nD7rdzAWbVxiciBlPRsW4PL7xcNRERFfA7AnguiKOF4ynXkpyMMzIso2B9V/HfL1Xwab9HyngHrnIRyC2Uj83XQ3/MpOgDJK+yyB0biYVykkvhuLEKAMwoe3LbE8i+0bbzVxbUEi1vIhXkMwZGjb3g6EA1Zp24g7s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fKEJHa5P; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fKEJHa5P"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 57A431F000FF;
	Tue, 15 Sep 2026 14:22:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789482133;
	bh=dvG9vrjCa4ZPkWlOmi3sL+571pAf7FI722NLWwgNamU=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=fKEJHa5PDjYpRhujVzajBXWhiYkx92JwIDVkvPdjsnKyceVcFwDT5L2ONzRJhkzEO
	 yr9fzpFkXgZX/SJov/TqrN1ffzIM88akQniik1Hi9IWtJ4YPFge3Po99gz4tJyOxjx
	 ngofxUQSvQGnmBY5a1+QvebnWpKeSbQ5MoZ8hIqT96k8pvPO2Y5ob5ED19V/Fq9fg1
	 MRpZNoBIF7cwrvWCu+AnEqKEirpLtR2/Qwu5XesXJx0l5OdfGNzZSA9kNrMEEMLghJ
	 PncRyy5MYgtFU1NWrHP8ZvU1EKanRqdbQ3E73s9bXojPMHkdRuP7ioIAAUE+DNC/iI
	 /Ng1nIKlqjLKQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2] vsock: ignore empty child namespace mode writes
Reply-To: sashiko-reviews@lists.linux.dev
To: "Aldo Ariel Panzardo" <qwe.aldo@gmail.com>
Cc: virtualization@lists.linux.dev, "Michael S. Tsirkin" <mst@redhat.com>, "Eugenio
 Perez" <eperezma@redhat.com>
In-Reply-To: <20260915141547.3010692-1-qwe.aldo@gmail.com>
References: <20260915111417.2726515-1-qwe.aldo@gmail.com>
 <20260915141547.3010692-1-qwe.aldo@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 15 Sep 2026 14:22:12 +0000
Message-Id: <20260915142213.57A431F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>

> __vsock_net_mode_string() returns success without updating new_mode when
> the transfer length is zero. Its caller then reads the uninitialized enum
> and may permanently store a stack-derived value in the write-once child
> mode.
>=20
> Return before inspecting or storing new_mode when no bytes were
> transferred. This also prevents an empty write from locking the current
> mode.
>=20
> Fixes: eafb64f40ca4 ("vsock: add netns to vsock core")
> Cc: stable@vger.kernel.org
> Signed-off-by: Aldo Ariel Panzardo <qwe.aldo@gmail.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260915141547.3010=
692-1-qwe.aldo@gmail.com?part=3D1

