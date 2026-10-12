Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6E793D5657;
	Mon, 12 Oct 2026 23:05:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791846325; cv=none; b=h4IMRrvDtZ2JoSV4jsyBW8VsqKBmsYWKzw0lH7QQGUNQXtD3mvDDS2rJlrB9T6fdCzj4jL0xKbUDXfS6ZPAmoukp3T2w1D0Vu3HhqIKG6VtXXWkmJPyPswZFPbNkPIGaxrUf9FjtnYOjOV28pFehBJ2LSceRvd4Pfv70hF/VlJ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791846325; c=relaxed/simple;
	bh=7Gs2QdBt3PR39yrrKwUpGNQyh9Iw4PftSm8kARKedas=;
	h=Message-ID:From:Subject:To:Cc:In-Reply-To:References:Content-Type:
	 Date; b=GvI5XfLTAOtxCJrW0I+s+ihQUGEgcp/pO/KiJXSyQqCDKmQ1K0QoMldEQHwLtyaUWD7jNSyQnuDBL5yfg7sHIVoLDoYbrUBkPTYGJiCYn8IbPRBzgN1abcQcCkbeBncjgYdItCh7MCWSoqr28khuByc/xTfft4L1cwlaqfdZOLo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NcYxiqRb; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NcYxiqRb"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 714CF1F008A1;
	Mon, 12 Oct 2026 23:05:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791846320;
	bh=7Gs2QdBt3PR39yrrKwUpGNQyh9Iw4PftSm8kARKedas=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=NcYxiqRbu+9nWacLMcwX2dP7cR53lGVzRHfI6CzkDGgDSkpzoiB2wdq/c51icqRJM
	 gwnapCT3+6fp9WV3MPNHcQV3f9N/jqjFDqDBVMD2+ElrV6msHK47JyCZirtYwD01AJ
	 peDDsWX8Ykks6DUcwLiJLzJ9wiUvTthcEuAdShvzMbWjjbqHenr8wcJXRntR3tfPSo
	 VZBEVvS6gMdIxDoBgwf3AbBy5QTJ3EUOY+Z+TV0accno0k09k3sWX79oSWhNQ0BvP/
	 AgSRBF6RBjSu6ojmveM7rHYq9SkgggmaZi4ophmPDObRYM8H8jyBRhjWpiWW408oET
	 hHoGrRi4g9G0A==
Message-ID: <sashiko-outbox-168695@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH net-next v3 3/7] vsock: pass the netns to
 ->has_remote_cid()
Reply-To: sashiko-reviews@lists.linux.dev
To: "Bobby Eshleman" <bobbyeshleman@meta.com>
Cc: "Eugenio Perez" <eperezma@redhat.com>, kvm@vger.kernel.org, "Michael S.
 Tsirkin" <mst@redhat.com>, virtualization@lists.linux.dev
In-Reply-To: <20261012-vsock-guest-ns-v3-3-b32447c66b23@meta.com>
References: <20261012-vsock-guest-ns-v3-0-b32447c66b23@meta.com>
 <20261012-vsock-guest-ns-v3-3-b32447c66b23@meta.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 12 Oct 2026 23:05:18 +0000
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>

> The transports only use the socket to find its network namespace. Pass
> the namespace instead, so that a later patch can ask whether a CID is
> taken in a namespace without necessarily having a socket on hand. This
> will help with avoiding CID collisions when devices move between
> namespaces.
>=20
> No functional change.
>=20
> Signed-off-by: Bobby Eshleman <bobbyeshleman@meta.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261012-vsock-gues=
t-ns-v3-0-b32447c66b23@meta.com?part=3D3

