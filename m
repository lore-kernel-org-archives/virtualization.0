Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A57F4052AF;
	Wed, 16 Sep 2026 13:15:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789564560; cv=none; b=HY32uyuVoSpxCso+1NTobiJu9Io6tybi79wAMVgHelNvjMJQWHOmpHFD1ttoHPa8Ln61HlYqTpUPjfG2PrY7nFeS3MranJClwlKte8IZiXCQh953tKaOreIqOfSCWmrf7lAMBQndmEXvc4gzVmf5culLPr5JKNxHMyjo1nlLb30=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789564560; c=relaxed/simple;
	bh=4J7Z0dXuhvGWQl1zT5O+hBJdjt2L0PN1bTS+sCPLehE=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=BKR+g3Bq4WzHrXBvFjujhGo5imdqLLC/zxs3czhut0FHoCurRo1UwX0+IQ6RPR/rg9olAoJTpdV/MbyHjGj+GIjHHz0FvgCJRt3i31RLESVghZ2a1tXyQVeGwG2Nqi6wO4DS3vzjmJ2wdBQ+OTebOv74x+3GJTDANL7XtajBiTw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Szhc0VTf; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Szhc0VTf"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3D6B61F000FF;
	Wed, 16 Sep 2026 13:15:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789564558;
	bh=4J7Z0dXuhvGWQl1zT5O+hBJdjt2L0PN1bTS+sCPLehE=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Szhc0VTf9XPZgxX806OynN83QakyxXDl2ryv6XRJqr6dj1fWXYcKmo9PNrMl6CFFB
	 2+c0TWhNnS1tbVoUlyY8eac0rMybce7KFUYhZleBV9yEVd9cEl/HPsDzyE11xLnEwr
	 0O+6yAOqIjHD0Uv6QUSMEEnA+u5uX3G3y9JC+op+XgfMR9ktizO5duNNyOAU+g/nNX
	 ziYYDDORcSkK5CpssKCDAcmpVsJVwUAG85xKUtWPYRrMX+y4BelrjEIIiGkPTBlqC3
	 UPQu8DqynhBDHZOShREEvIsOY5mskSRZn6wdc2UwSTQdyuglteMbjtK01v+yc+a/3Y
	 OA8tLY68iC92w==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH net v2 1/5] vhost/vsock: Fix socket state constant
Reply-To: sashiko-reviews@lists.linux.dev
To: "Michal Luczaj" <mhal@rbox.co>
Cc: kvm@vger.kernel.org, virtualization@lists.linux.dev, "Eugenio Perez" <eperezma@redhat.com>, "Michael
 S. Tsirkin" <mst@redhat.com>
In-Reply-To: <20260915-vsock-connect-reset-closing-v2-1-a1d9abb472f7@rbox.co>
References: <20260915-vsock-connect-reset-closing-v2-0-a1d9abb472f7@rbox.co>
 <20260915-vsock-connect-reset-closing-v2-1-a1d9abb472f7@rbox.co>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 16 Sep 2026 13:15:57 +0000
Message-Id: <20260916131558.3D6B61F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>

> Refactor under Fixes missed one: SS_UNCONNECTED (1) -> TCP_CLOSE (7).
> Until now, sk->sk_state =3D 1 stood for TCP_ESTABLISHED.
>=20
> Fixes: 3b4477d2dcf2 ("VSOCK: use TCP state constants for sk_state")
> Signed-off-by: Michal Luczaj <mhal@rbox.co>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260915-vsock-conn=
ect-reset-closing-v2-0-a1d9abb472f7@rbox.co?part=3D1

