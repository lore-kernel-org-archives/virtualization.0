Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DA2E41A56B
	for <virtualization@lists.linux.dev>; Tue, 22 Sep 2026 08:24:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790065493; cv=none; b=LmZNrMpPF15/OmZIESRDYOf3Os7fXsggXNSK+xsEAjrdlWftKGqX9K8DGFn2iNTs7/U1aI/jeG+VSGecCLjnw4yaFOPOwxyKPRTfW2VJZuhRDyS2eY7vIS2LnNoHnlSqpHUhRa+dGj+U4Is7eeihbtQOZDG0kY4mR+77XYfunPA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790065493; c=relaxed/simple;
	bh=7b0tVtdoX9aButo0BRLGWLhyxbT1xVvg5u7CvHobPfY=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=Zt+y7AQexbiZ90p4GC4uibW8t6Z7s/87ypH6Ym1FaiTfIVGBu5VTYryqz3It5fjfA3QIYAGSGG60gv26LRyC7ekBnpn6a8t9F12TLvX5nngJlGknUM/udijYo1QWfokYbwTthzT75OoGW7/ik9+/W4lAZa4oxNPmmGZr5JvUueU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hbCtqMaX; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hbCtqMaX"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 12F011F000FF;
	Tue, 22 Sep 2026 08:24:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790065491;
	bh=7b0tVtdoX9aButo0BRLGWLhyxbT1xVvg5u7CvHobPfY=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=hbCtqMaX5PkzSVdVzdWYYudRYF5KNL12X4X9FVWu2r1OJ7qPN9wiXpqiIdiH4cXiO
	 28grvCabCgma5s2bvIm4cKGbyCp9+8yY2WG/6zZvaOKry3EG5e6lLuYlnM82s0HzQT
	 TRONI9MV+SGvYA4A6Ui3Dmr0FRvyIxPrXyAZ1zKx5/KIRBTadw6geTGCeRkGngNKVk
	 NCQ2Lrk+JGvwNqSCIan1o8GYVOvT6GCG2QlOkNYQXRcXoc/j3VUSFENS9pCTLT1Fnw
	 cVy+CgSBWqXoE9/YciWrvsjpL0MaEaK1MHsMKCguFQ8SWFB8iLM/opw4JBCs0DQUod
	 5TTa6UerIeU5A==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] virtio_fs: read the vring size under virtio_fs_mutex in
 ->get_tree
Reply-To: sashiko-reviews@lists.linux.dev
To: "Fan Wu" <fanwu01@zju.edu.cn>
Cc: "Eugenio Perez" <eperezma@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, virtualization@lists.linux.dev
In-Reply-To: <20260922081318.321686-1-fanwu01@zju.edu.cn>
References: <20260922081318.321686-1-fanwu01@zju.edu.cn>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 22 Sep 2026 08:24:50 +0000
Message-Id: <20260922082451.12F011F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>

> The vring size was read after virtio_fs_find_instance() had dropped
> virtio_fs_mutex, so a concurrent virtio_fs_remove() could free the
> virtqueue first. The reference from the lookup keeps the virtio_fs
> alive, but not its virtqueues.
>=20
> Hold the mutex across the lookup and the read.
>=20
> This issue was found by an in-house static analysis tool.
>=20
> Fixes: a7f0d7aab0b4 ("virtiofs: split requests that exceed virtqueue size=
")
> Cc: stable@vger.kernel.org
> Assisted-by: Codex:gpt-5.6
> Co-developed-by: Song Li <songl@zju.edu.cn>
> Signed-off-by: Song Li <songl@zju.edu.cn>
> Signed-off-by: Fan Wu <fanwu01@zju.edu.cn>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260922081318.3216=
86-1-fanwu01@zju.edu.cn?part=3D1

