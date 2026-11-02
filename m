Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793652673;
	b=uAiAG7KUEAyH9BedYeqeXTO7TRH4DltL94Uq4ffQWGBGEMC8CZuJLs61c8sQKKybat7P
	 fbhK5BQRnEjlDjyCHBLEoe6/VABtK+nU2HsTBz7f4/mKpJnPPmGgwmpAKBK/rVHuxKO6A
	 XuX/5OjSioJRFFFwttUYq/eGnAM3AjPPxpTI6lQPcrBDuOhegERU/HDzK5zWJLu9iEWOS
	 YLmTwq/Bz3ThZfwzVHjqrc0PH5jDpD1HxnhvXNwCOtCh7XjtPwA4w531A5DkCwahi8u/6
	 8im4Oo1oKsYa3+/5TYq/MN1NSY+A2eDqp6EwPUyGJqRxqdCGpWwUvblOyG3MtYZEcKg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793652673;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=Z5HtpRXw8mXGxOFdzkRkhZ+0qJBz+8i9IFCXLTxETyk=;
	b=SGYyY8aygKfVSUuUpBDng4dJeunUGNHAuYJwqKxIteNuSt6f6ZO61GtI1H/QyC0y6wBg
	 mPWUVX1iDN7ccdEcKQqOU0Q6zK16GVEMyQYRnWPKi7K+gtC/vpJYk9jlEVhYyXmTA4zZ/
	 Op+xZC8eDqMW8+OgtC+ETT8HgMQWQiFkhBTtnc1Gs7wnhFe5Dn9uv/zIv3NkipwohZvN7
	 5IWe4nury4db/WpONpmsRC9SYxJPFymujx3I5JBcF39XJXzhd3OXIB9Gp4Q5lov3GOT6l
	 cBzWD7Gus1nZE6U7ySolWy9obXu2nrzLE8fsa0SQiYYs6pHc7/JZT4Baw6GhLcB7fnA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=dgEHXr8I;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DC8A606A324
	for <virtualization@lists.linux.dev>; Mon,  2 Nov 2026 20:51:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=dgEHXr8I
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9F8871F00A16;
	Mon,  2 Nov 2026 20:51:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793652672;
	bh=Z5HtpRXw8mXGxOFdzkRkhZ+0qJBz+8i9IFCXLTxETyk=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=dgEHXr8I+2TC44IOyY6/mtmc1gK7nHaRTA3HLPS1SIZTnZwFhvjQleiI695JD1vyj
	 tnCaa8UL8dLsgTeDZgCpNSt5WBm9u2Zs6B+8Ge7+oH+7kiOLpojusullUAeCcwOENx
	 TlVrm747xQ+VYzw21+V0XmXN4thD5RpcloRskgkb3paVdxnQ9Qd0Wx6uvOoNWiIXW/
	 +d9tVWmsnPulYdRJCT8FTE/qWmCrHcP9GDzUsQNYMeVIt9Q4QVTIp2BE0GrZ/njYAi
	 20MUl+kb9Yg2jWFO7OhHnvkS8GzZZfqG69M0WhBfqTOPt6kAVsg1MoB4ZPBpoib4SH
	 WA+71YEcdSaGg==
Message-ID: <sashiko-outbox-194152@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2] vdpa/mlx5: Don't free QP buffers if destroying the
 QP fails
Reply-To: sashiko-reviews@lists.linux.dev
To: "Yuho Choi" <oss.patchbox@gmail.com>
Cc: virtualization@lists.linux.dev, "Michael S. Tsirkin" <mst@redhat.com>, "Eugenio
 Perez" <eperezma@redhat.com>
In-Reply-To: <20261102204734.443140-2-oss.patchbox@gmail.com>
References: <20261102204734.443140-2-oss.patchbox@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 02 Nov 2026 20:51:12 +0000
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Post: <mailto:virtualization@lists.linux.dev>
List-Help: <mailto:virtualization+help@lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
List-Owner: <mailto:virtualization+owner@lists.linux.dev>
Precedence: list

> qp_destroy() frees the RQ buffer and doorbell record of a driver-owned
> QP even when DESTROY_QP fails. The QP then still exists in firmware and
> can read WQEs and the doorbell record from freed memory.
>=20
> Return without freeing them in that case, as cq_destroy() does, and
> include the QP type and the error in the warning.
>=20
> Signed-off-by: Yuho Choi <oss.patchbox@gmail.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261102204734.4431=
40-2-oss.patchbox@gmail.com?part=3D1

