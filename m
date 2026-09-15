Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B066408602;
	Tue, 15 Sep 2026 03:25:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789442764; cv=none; b=lPUgBJ4jxEUjgG19xaa0yTK+FJBFjNryMxd2k1Qf0miHu+hCXxGm1RZ3gVtOUfIuLTWIaoyMKLmRMRIddFqLW56147w60zv4v72EJlfDYuDI2K/QIirkT8pV633GXCZeLcQD3/aNXlTdzSjKPQ2lZxJsdsM3tQ1fzEGIELlYw5o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789442764; c=relaxed/simple;
	bh=w/IdaHdRHERlSC2cZfLAQ3jkrXo9BLJKbMABy9pq3j4=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=b9mBEo7+FejFwH0RL6Ia4ixhTV5I6Zp5IsJhlTrXkQ/RmmRXaA93XOz0/PxrTovRyRCX8JNbfsP24Qm6Hx0EVX2VUp7Lqs7K4Ya36tV/LXrk13X1RLhMn8DETmdNn8CflHksV5QtLRe4puHHfi/56SRECvtBGW4OCQtvxTPYiV8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lfbsVPSt; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lfbsVPSt"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 07F731F00893;
	Tue, 15 Sep 2026 03:25:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789442757;
	bh=w/IdaHdRHERlSC2cZfLAQ3jkrXo9BLJKbMABy9pq3j4=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=lfbsVPStqhjCDBealfgJ2HCLWo7feU9Cn+LcfjZfSL1Gmf+LBkQPsvW9egLCWSOsO
	 u73KKx7NGXgf5k/Mt3I2KRSo103YwEmu2Fl74G9RwWl4P3stemMuFwW0WMOtQOm1ve
	 urpBROwuaPx63PziKeDuM3lJQ9z5NkAkkUaHaYkCJiQkP7J8BsWktwm4pBTmai04DI
	 VRsZBwkFsUGFA9gpMbUIGbVchF+frX8JAhzLIOpEJsFWBdPvr7Rje2XDRrSXyvK7D9
	 uMXN7+yjCqp8IquicikWcihzifUyTDgtSEXxTs87kvwk59/unaumdFBpdqNmO4W92H
	 2Ih8dbGb7ZHPQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 11/17] workqueue: assert static storage for work
 declarations
Reply-To: sashiko-reviews@lists.linux.dev
To: "Yury Norov" <ynorov@nvidia.com>
Cc: linux-kernel@vger.kernel.org, "Michael S. Tsirkin" <mst@redhat.com>, linux-rt-devel@lists.linux.dev, virtualization@lists.linux.dev, "Eugenio
 Perez" <eperezma@redhat.com>
In-Reply-To: <20260915031334.1194975-6-ynorov@nvidia.com>
References: <20260915030336.1192299-1-ynorov@nvidia.com>
 <20260915031334.1194975-6-ynorov@nvidia.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 15 Sep 2026 03:25:56 +0000
Message-Id: <20260915032557.07F731F00893@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>

> Static work initializers use the work address as a lockdep class key and
> mark the work item static for debugobjects. Automatic objects require
> on-stack initialization instead.
>=20
> Apply ASSERT_STATIC_STORAGE() to DECLARE_WORK(), DECLARE_DELAYED_WORK()
> and DECLARE_DEFERRABLE_WORK(). Automatic objects must use the matching
> INIT_*_ONSTACK() API and destroy the on-stack debugobjects before leaving
> scope. Keep the underlying initializers available for embedded objects.
>=20
> Assisted-by: OpenAI Codex
> Signed-off-by: Yury Norov <ynorov@nvidia.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260915030336.1192=
299-1-ynorov@nvidia.com?part=3D11

