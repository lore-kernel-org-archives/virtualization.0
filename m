Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A7A34FDA42
	for <virtualization@lists.linux.dev>; Tue, 29 Sep 2026 09:56:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790675795; cv=none; b=hVe66lLKgy2LI3Y6LgboqsV/k+BgnhiMPaYMuDm73kPCIBIi5vv4EivpszH6paWT3udWLmYwH+XpA1r4afsT3yAkJecuv6PitGqAv6VY0+68MS41WeJ2IIc08z6Ew+MAkoA6ivtooo4wc+RxcC7MTolEusszVKI2MTQJW40Q75U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790675795; c=relaxed/simple;
	bh=W7m81uvh+hMihEszUwAcMs8Qx99+nGYQ+Iqlygs+c7A=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=ZsDJJIImIwvXv8sW7yCG3r7XJGQI1OhX6dAdHZEHOtQqVZ55GwLT1nSwDxOEl3mo/0lG1kB7Nim+Z07X+jnj49Rt2t0yvr0VgBUi6IRR6wVdZ8x9aQX2joZPiotQpoGMzXiC655PgSX7G3NnSORlKQYFDJnt6GYbxMjYxLOEIfI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OP3c30fW; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OP3c30fW"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 70DDF1F00898;
	Tue, 29 Sep 2026 09:56:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790675792;
	bh=faSfHP6XTq/JaG90ay0mc9KqmrrvSS7yLQ2DiSGY0w0=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=OP3c30fWMO6ka2/xmicblSCBM2Dx1eDiY8MDLNvoqSJX6XgvLH01lDkdtSOj/rJ7G
	 +29IV1qWnmENDuBZdK7oZHlZAR4daHSzJq8yF03/ggweDDX4XeASgtXzSJCLQHtVIU
	 +eQK63ogwBNbJl7zJ6yTEM82nQ6KhYG9BPA0lqIPO29FLbxbxSNby9jL0KRxT+CvTS
	 QMLJe8cplVEVovGKpz6KKCHuHJZuheOtr1lSXIdVBM9lgCqXm1Z74zhDdzcAh0uuOZ
	 UNfbs6Ou6LbE6sADP4rINIVWZgpH7/sGR69d4r/PqOy0tF8DxNK4xaPW7u48Au02yp
	 h8EvyEp1Julyw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] fuse: propagate SB_POSIXACL to submounts
Reply-To: sashiko-reviews@lists.linux.dev
To: "Tarun Khandelwal" <tkhandelwal32@gmail.com>
Cc: "Michael S. Tsirkin" <mst@redhat.com>, virtualization@lists.linux.dev, "Eugenio
 Perez" <eperezma@redhat.com>
In-Reply-To: <20260929094812.93374-1-tkhandelwal32@gmail.com>
References: <20260929094812.93374-1-tkhandelwal32@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 29 Sep 2026 09:56:32 +0000
Message-Id: <20260929095632.70DDF1F00898@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>

> From: Tarun Khandelwal <tarun@supabase.io>
>=20
> fuse_fill_super_common() always sets SB_POSIXACL on the superblock, but
> fuse_fill_super_submount() never does. Submount superblocks are created
> from an fs_context with no sb_flags, so the superblock of an automounted
> FUSE_ATTR_SUBMOUNT directory (e.g. a virtiofs export containing another
> host mount) lacks SB_POSIXACL, even though it shares the fuse_conn, and
> thus fc->posix_acl, with its parent.
>=20
> Since IS_POSIXACL() is false on such a submount, the VFS:
>=20
>  - fails setting POSIX ACLs with -EOPNOTSUPP and hides existing ACLs,
>    without sending any request to the server;
>  - applies the umask itself on create, so default ACLs on the server are
>    not honoured for new files;
> [ ... ]
> reported by getfacl on the submount, and default ACLs and ACL-based
> access checks behave the same as on the root mount. Tested on v7.3-rc5
> in a QEMU guest.
>=20
> Signed-off-by: Tarun Khandelwal <tarun@supabase.io>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260929094812.9337=
4-1-tkhandelwal32@gmail.com?part=3D1

