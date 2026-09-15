Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 101943A0E80
	for <virtualization@lists.linux.dev>; Tue, 15 Sep 2026 11:21:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789471300; cv=none; b=DWQlPnkO1JK49I/44CxqyZfYVuMLD+ESfnXbCtlSiFSsFmT2hQag/Ia6KXJ8SCxP9umvL9n+hZ3dXZ0d3BTsV/b4vt34fWjqfaXqCUHogjoNqj3MQIn8lKNC4yXp72WWaKlndR26fEQmYWFX3NhPhZgUpl21xNWUWAO1MTMBrrw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789471300; c=relaxed/simple;
	bh=/XvDA0L/aq8KVsKsNMzrpy2+0mrtPEiCqpSmk5ZbTyE=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=e1UV2rVCyBNL/CNSfB+IES92/eoJDpGFTGuGoK/pWd5Vr22xJ60hkMgcAaHQmK1bmlqO5QsAu7PeAe/Q099O7dw01pOIWfOtwSqxtZQk3Plp1u+rNZagYIFs81M0ulBGBdgaMFM/eonQ12l6kli0VtXTejZi9qwZ/lcdzh3R7H0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=N5+6IV7x; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="N5+6IV7x"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 626701F000FF;
	Tue, 15 Sep 2026 11:21:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789471298;
	bh=/XvDA0L/aq8KVsKsNMzrpy2+0mrtPEiCqpSmk5ZbTyE=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=N5+6IV7xhuQUhCrXnPY7M6x6Z2d1++zV2/ZlYsLOYAqsyK6Bef4BwxJsa84o7h+fw
	 ZRgynLuLAilA9mrjH6qm+TOvHLYE89D7EihNMGnGZpjcRxgwwqfMjwFJgikozdWG+a
	 DQ7ZywIqfWDQkly7uC8WyrCgVSoK1kvFjAcuWwz0ortZWkXO1Nx5XdLSZQf8VFgN6s
	 DqzD2M4XOak46aLER9iUJk5MX1h2P9oqxFSy4TMtjbxIXe4IObVxSwFLaAFY98W/DE
	 cPOP4uyu7aT8HJwGQJIV6EQA6CYWfK3KXwyvswGz3ZTGu/h4uQ8FTHO1fYG1y8OeaY
	 My7JdO5RWtwXQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] vsock: preserve child namespace mode on an empty write
Reply-To: sashiko-reviews@lists.linux.dev
To: "Aldo Ariel Panzardo" <qwe.aldo@gmail.com>
Cc: "Eugenio Perez" <eperezma@redhat.com>, virtualization@lists.linux.dev, "Michael
 S. Tsirkin" <mst@redhat.com>
In-Reply-To: <20260915111417.2726515-1-qwe.aldo@gmail.com>
References: <20260915111417.2726515-1-qwe.aldo@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 15 Sep 2026 11:21:37 +0000
Message-Id: <20260915112138.626701F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>

> __vsock_net_mode_string() returns success without updating new_mode when
> the write length is zero. Its caller then reads the uninitialized enum and
> may permanently store a stack-derived value in the write-once child mode.
>=20
> Initialize new_mode from the current child mode so that an empty write is
> a no-op.
>=20
> Fixes: eafb64f40ca4 ("vsock: add netns to vsock core")
> Cc: stable@vger.kernel.org
> Signed-off-by: Aldo Ariel Panzardo <qwe.aldo@gmail.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260915111417.2726=
515-1-qwe.aldo@gmail.com?part=3D1

