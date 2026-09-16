Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC6374F55AB;
	Wed, 16 Sep 2026 13:16:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789564562; cv=none; b=BHSndqYVEe5riUzFHDYVXCJ7QyrMUMeSDpX/5M8ns4IIeqMG6gsXbnyb8l9o9N3LHZQkImSFKtYvLDHp4Ob5DU/m/PWyxO27GIfiffU1QaGn9TvA2/DYHXLsijjZCxlemk0YwbYaLO79UrmJkTEula1vW1pq0XTPpKisa2j3Oho=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789564562; c=relaxed/simple;
	bh=I+W7KWDGeiY5rJRLYOaEidu8WezkQgAqZFUL9nNJmKQ=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=kbcVyz+f3Z21A7+Nqv6wSccE3P8V6R4Ezuxt+C6milRBtut9+99F3qu9c51TcF5rsrYMv/soW+xmDY0AE5UGV1qqd+yR3mEGa39ybs5g+w9I73IPtdfkMEzUw3lnrTK7Z//WuvkXak8NhKe61LaGQMtTatF2+lfSkI9IajxX1nU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dy+/Nwcw; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dy+/Nwcw"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 000DA1F00893;
	Wed, 16 Sep 2026 13:15:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789564560;
	bh=I+W7KWDGeiY5rJRLYOaEidu8WezkQgAqZFUL9nNJmKQ=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=dy+/NwcwJJhfy44eeSB9sNsjBj4wzhCiy/pTcx9cIIqt2syPYSFPoxh9gvpX/5gXu
	 e+YvNUgybj3awVl4KpaNttoO4R/iVKJC/7M1IDsLxFzNgux/420JWBNd5K08hSG7GL
	 bcafNBTZDOAowpekM8woWXXfzqev+TxCEKz3XeWCPSTm5X2a2v3GtD01W2EZ5fIT/V
	 bnvi67UsUOqBO32E+Pu/ZpPbiguAMDYu3lXGcvOaIz+0yBbYfIkDMbw+QOva5t1LW2
	 0xndsnb9ZFZpZQmZzyJaO89zSniHRY3AZ3G+SU35X6JPcLgF8UIyEvpZoarkBJ6Ve7
	 da0wG3KjaCbKA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH net v2 3/5] vsock: Enforce no-transport invariant for
 TCP_LISTEN sockets
Reply-To: sashiko-reviews@lists.linux.dev
To: "Michal Luczaj" <mhal@rbox.co>
Cc: "Eugenio Perez" <eperezma@redhat.com>, virtualization@lists.linux.dev, kvm@vger.kernel.org, "Michael
 S. Tsirkin" <mst@redhat.com>
In-Reply-To: <20260915-vsock-connect-reset-closing-v2-3-a1d9abb472f7@rbox.co>
References: <20260915-vsock-connect-reset-closing-v2-0-a1d9abb472f7@rbox.co>
 <20260915-vsock-connect-reset-closing-v2-3-a1d9abb472f7@rbox.co>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 16 Sep 2026 13:15:59 +0000
Message-Id: <20260916131600.000DA1F00893@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>

> A non-blocking connect() running in parallel with a blocking connect(),
> combined with a racy listen() that hits right after a connect timeout:
> TCP_SYN_SENT -> TCP_CLOSE -> TCP_LISTEN, while the connect() loop is still
> in progress.
>=20
> Enforce the invariant. Prevent a socket from becoming a listener after
> acquiring a transport.
>=20
> Fixes: c0cfa2d8a788 ("vsock: add multi-transports support")
> Signed-off-by: Michal Luczaj <mhal@rbox.co>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260915-vsock-conn=
ect-reset-closing-v2-0-a1d9abb472f7@rbox.co?part=3D3

