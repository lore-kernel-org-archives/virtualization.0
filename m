Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EAAFB3D5C2C;
	Mon, 12 Oct 2026 23:05:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791846319; cv=none; b=t5wBdvJv/wI/zpIbVlN51uspST7VsyWc4xwUliqvwWPp7l/zSilNDE+E/e57QCmgUnbt9VL/EQ6BcoWxv1cgJN57fGuOZ5vS6EgKJBYhvJLVuAZdAmSQQTJadpJV5+jITtKtKl6cbZwpbQI0rITTot47QNiCxGy7vwmVNmRcVUA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791846319; c=relaxed/simple;
	bh=x0lYv4rfTlSeRJA0LVaf08RmrJwQQi83K1ND/6IMxgA=;
	h=Message-ID:From:Subject:To:Cc:In-Reply-To:References:Content-Type:
	 Date; b=bFim62q5ws1em3AOLwE6TH4Rfmhf845W3bTWvhwq7MoKS+6Cb2/RBfxh0v0jrbM4V5kBRDEqrYrew+4ImuQxm5pRzNsL9UkppICbjS49ZzYc92aSLpbFmp9LkC/a48lR/LPkR0TwMjn4OZyVmOVdJKE/tWB3H7WKmQmj3Hhlxg4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kysKZhJw; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kysKZhJw"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 891821F0089B;
	Mon, 12 Oct 2026 23:05:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791846318;
	bh=x0lYv4rfTlSeRJA0LVaf08RmrJwQQi83K1ND/6IMxgA=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=kysKZhJw+83TPPwSBzuIdAUpq2uwLAguxvEw9iNfnlKsXRvyybnEgVTAWchDmBhn8
	 XxxyS8e74pzLskDf4lkYllCH+3CFmjF7+Mnw7ZpRKG8o774YwIDuZeasvJ8vPIdzGg
	 qVde8YSrWFexhmE9mMJ/objqPZvOV+DLqci5ac8b/IifISCm3tyxrdLUEZKhFLjoEd
	 8Dfk8NleKwAmccf8aV1s5Bwso0JE9YLWaDY8kOS7CB0lBacZ0Jv5gW0sxmhe/5x7d3
	 m9ynQUQUuGASrzAvrgn/vH0ScKNqC9ZID9tvZ4KEEwgUItS+/pGNSAha8vUdL5ESXM
	 7T/SM5ixaeDNw==
Message-ID: <sashiko-outbox-168694@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH net-next v3 7/7] selftests/vsock: test the netns assign
 privilege checks
Reply-To: sashiko-reviews@lists.linux.dev
To: "Bobby Eshleman" <bobbyeshleman@meta.com>
Cc: virtualization@lists.linux.dev, "Eugenio Perez" <eperezma@redhat.com>, "Michael
 S. Tsirkin" <mst@redhat.com>, kvm@vger.kernel.org
In-Reply-To: <20261012-vsock-guest-ns-v3-7-b32447c66b23@meta.com>
References: <20261012-vsock-guest-ns-v3-0-b32447c66b23@meta.com>
 <20261012-vsock-guest-ns-v3-7-b32447c66b23@meta.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 12 Oct 2026 23:05:18 +0000
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>

> VSOCK_CMD_DEV_NETNS_SET refuses callers without CAP_NET_ADMIN in the
> init user namespace.
>=20
> Add two tests: one confirms that CAP_NET_ADMIN is required even by a
> privileged user and the other confirms that CAP_NET_ADMIN in an
> unprivileged user ns alone is insufficient.
>=20
> CONFIG_USER_NS is needed to test the CAP_NET_ADMIN + unprivileged user
> ns case.
>=20
> Signed-off-by: Bobby Eshleman <bobbyeshleman@meta.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261012-vsock-gues=
t-ns-v3-0-b32447c66b23@meta.com?part=3D7

