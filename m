Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5235753CA9B;
	Tue, 22 Sep 2026 12:39:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790080742; cv=none; b=KQycaQ62qpsNQJ2pFhRle1kJg/qBdr80sdDKni2DPlviMbe6DMspyJDuqMAEaHmauaN8Wgbi0H4H5Loz7TYvG1HYZi/cVyHp2qSoWRsCV5sjOZgQbm+Krh3GBcmRC0GPyN3HFyCy1BX2muucJyvpWn5wrb6GEpzPmi8iuzT4lEw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790080742; c=relaxed/simple;
	bh=cVQtIX71pbbZKbRtS0UEbLgJdLAnPCAdw3iLkP/BAGk=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=pImTY/7HdXxgRyxDIzPGvjUxNpFlKJ3MLXOlvEQ5Au3Rpdvahk95T1wzzW1GEJu0MDb8SnII/qVuoPqa9De2WBF5RpxTq93kra0kkZzP3KMk3bjRpY1aO+iGcv1d2Y/siSt1hynNn6plyKnRySLQdQEnBiywZhzeaUqY9DRNci0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NAbPoLdf; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NAbPoLdf"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9F8AD1F000FF;
	Tue, 22 Sep 2026 12:39:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790080740;
	bh=cVQtIX71pbbZKbRtS0UEbLgJdLAnPCAdw3iLkP/BAGk=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=NAbPoLdfWmowx++lXeTQcjGgEZbvTmYlw7NmZKs1j9UyGWKDrB3V9LTIgUtdpkQGp
	 OyFD+KvRjP3rhKbEQ2mRojwllDHizIyAtNeFm3Q8CJzQC1lVcniJxapLoU9snx/XJa
	 6Eafx7nwrNd+dRhfA86fRw/0m7LPeRvPytK+1gBBGtzfBeV4e923kMOll/+Dtxm5gk
	 By1aVWV622fhrNCmOeGNISHTjIdjogsBopOSjNyqVshSTY8rrC0nbhTJq6XfnSnWdV
	 3BN184xwyscjkusLmbasea3YHEIwCUas0+KgdYaYPmtu72YCn1jbfc6r4lYd2M55qC
	 WBFkPLCNUvgsw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 1/2] vringh: bound top-level re-entry into indirect
 tables
Reply-To: sashiko-reviews@lists.linux.dev
To: "Fang Xieyan" <fangxy@xiaopeng.com>
Cc: kvm@vger.kernel.org, virtualization@lists.linux.dev, "Eugenio Perez" <eperezma@redhat.com>, "Michael
 S. Tsirkin" <mst@redhat.com>
In-Reply-To: <20260922122955.69433-2-fangxy@xiaopeng.com>
References: <20260922122955.69433-1-fangxy@xiaopeng.com>
 <20260922122955.69433-2-fangxy@xiaopeng.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 22 Sep 2026 12:39:00 +0000
Message-Id: <20260922123900.9F8AD1F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>

> In __vringh_iov(), the F_INDIRECT branch descends into the indirect
> table and continues before the descriptor accounting runs. A top-level
> indirect descriptor is therefore never charged to count. If such a
> descriptor sets NEXT to point back at itself, returning from the
> indirect table resumes at the same top-level descriptor, which is again
> not counted, so the walk never makes forward progress.
>=20
> Because count stays flat and indirect_count is reset to 0 on every
> return to the top-level table, neither bound in the loop check trips.
> A guest can spin the vringh worker at 100% CPU inside __vringh_iov(),
> an uninterruptible host DoS.
>=20
> Move the descriptor accounting above the indirect switch so that a
> top-level indirect descriptor is charged one top-level traversal step
> before the walk descends into its table, bringing this re-entry under
> the existing vrh->vring.num bound. Each top-level descriptor is still
> charged at most one step and indirect_count still bounds a single
> table, so legitimate chains (including the multiple-indirect case in
> tools/virtio/vringh_test.c) stay within vring.num, while a cyclic
> indirect descriptor is now rejected with -ELOOP.
>=20
> Fixes: dbd29e075228 ("vringh: Fix loop descriptors check in the indirect =
cases")
> Cc: Xie Yongji <xieyongji@bytedance.com>
> Cc: stable@vger.kernel.org
> Assisted-by: Hawkeye:GLM-5.3-flash
> Assisted-by: Qoder:Qwen3.8-Max
> Signed-off-by: Fang Xieyan <fangxy@xiaopeng.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260922122955.6943=
3-1-fangxy@xiaopeng.com?part=3D1

