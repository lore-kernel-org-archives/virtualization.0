Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C08A33A9FF
	for <virtualization@lists.linux.dev>; Wed, 30 Sep 2026 08:33:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790757238; cv=none; b=dit0YlbIw1hvj2Xaq+XSLg+HBT0TvUO0ItEwJ1kgTompoBwZbvvVE42p8HityuR3cvJ7JBvg7qKGAY+mNEF2npbVXSRT3c+6bGYndZpbRpk8CJusshFjTT0b64Yj6WraPJthx4RwMUIKITKhl+gWLxCn6yZEzTzleoxWnPqy28I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790757238; c=relaxed/simple;
	bh=GaBX9vHnKCwY9osIX0K9RsWtWXvZAWquDS/wuWnwh6U=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=kAwOClMn3PYWA+susG5FeJRBmP4aKQnROPcaEUZHpzjiH7EyQDkn6LpoOhBfv+oUdJrjPxOdhPPVYh81KR/MXCbTM6riFnkbi0OuTgsnilcwzk4RMN8FBZwzuxLAvGh2eR3E62tWigwd10rQHPEStWZE9qv3ksk4kVu8lKDbPgQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=k9IvryVT; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="k9IvryVT"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E8C951F000FF;
	Wed, 30 Sep 2026 08:33:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790757225;
	bh=Chv2iC4KPM48cALOlb4uO/PUN/VBNQV2z6cw6zTXais=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=k9IvryVTC/w0nGVVOf7XEUdeLD3ufSMTYjjDfofgUgABTIOs0HMygKBlwWuS6inwL
	 NvSHCQy07LWmxqZR3/wn0qIV5bbhsM1qM6jBFBtmdWAGRMoPemeX69/IuyYmBBrEJV
	 N6hA423AycuuuzDluagBvLoVgwldu4Et1bxKJGAIMW/1QoN70XDdWwEIH+xGx36L/0
	 Dppr3vV3yprecvnZAAE27+2EqIB9MIOisTNQkBYRyit2yOC6cItm6/iG3VYO9kUWjF
	 Wm1zpbahc81eB42S8W2axPzk2bTPu9gN14nFxedL4GGYWiRJdUQdFvQonem84WpY9P
	 M+RU6vh8f68XQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 1/2] dim: clear irq_moder on init failure
Reply-To: sashiko-reviews@lists.linux.dev
To: "Jianlin Shi" <shijianlin11@foxmail.com>
Cc: virtualization@lists.linux.dev, "Michael S. Tsirkin" <mst@redhat.com>, "Eugenio
 Perez" <eperezma@redhat.com>
In-Reply-To: <8d6a637142c411f83771fda5b57bb4451651488b.1790751008.git.shijianlin11@foxmail.com>
References: <cover.1790751008.git.shijianlin11@foxmail.com>
 <8d6a637142c411f83771fda5b57bb4451651488b.1790751008.git.shijianlin11@foxmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 30 Sep 2026 08:33:44 +0000
Message-Id: <20260930083344.E8C951F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>

> net_dim_init_irq_moder() publishes the allocated object in
> dev->irq_moder before copying the moderation profiles.  If kmemdup()
> fails, the object is freed but the pointer is left dangling.
> net_dim_free_irq_moder() treats a non-NULL irq_moder as live, so a
> caller unwinding the failure path would use-after-free.
>=20
> NULL the pointer after freeing it.  On error the device is left as if
> initialization never happened.
>=20
> Fixes: f750dfe825b90 ("ethtool: provide customized dim profile management=
")
> Signed-off-by: Jianlin Shi <shijianlin11@foxmail.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/cover.1790751008.gi=
t.shijianlin11@foxmail.com?part=3D1

