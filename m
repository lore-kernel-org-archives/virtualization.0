Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793349457;
	b=HmTXNoX3fnJLMOKw1vaP0qPbRuN0QU5JI+uWFD6PFfUeFwW1LteHucXiJCkVl6llBLzV
	 wq4cmTIDVBAHCgWijaD2aV8xDdnNurS0s10zMjlSkzrWuIhSqNGUE9Hg3I1PBupTMh5TW
	 dJ5A8pgJTxcWteB747shUiR692sXa8clc/U5iYAY9rs3MEIzXPS4g6aT8vR+D3oQAVNkm
	 s0CzxGJ/HVJa/+pbxvNBEXgH6XneZA7OLJzEK3vji88go5eN3KK0rop6YZmttbnvyoMrQ
	 z10clY03dSqDFR6nH9d7Io0PYhYmRb9hBCZts4ATNJ7JiVYehOQ2zaL8yr5c272/hjw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793349457;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=GawCNvQaEVMoO9UYUSxbeePzX1+rPodyN9EsxQcNuOE=;
	b=fWcVj+hvz3RXpcB8geuAJsqylSamif0xo7nnN+kR2WUAJktfAmKVgyhJ89KEneL2QE/H
	 9LbG0LUW4ktq3muWgjVK0pJC/XHAXRD3PSt2WZIIeQjOk+qqxUzKd1UMSc2aYc1nWAy2e
	 frVBctTLHoz6VD9Ges+s5UUSgLlUmh4GOIptuhqawKMlfXvVAvh04yKXb1wU0Q2cMZOwt
	 qVV6H4oU6UlLO7hj/x9YgR0dROam5LrdXvr/T3COwLAFdhFnar4+HS/+XOSaaKaiMo7/Z
	 WmGwZ8RaZ47PRDuN9M1+bIyTxOB3Z5qGTyKBSY/zo8xouh3c26QjJuVsjz4mH9ofTew==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=fvUzDWLU;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26B75606A31C
	for <virtualization@lists.linux.dev>; Fri, 30 Oct 2026 08:37:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=fvUzDWLU
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 80DF51F0093A;
	Fri, 30 Oct 2026 08:37:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793349456;
	bh=GawCNvQaEVMoO9UYUSxbeePzX1+rPodyN9EsxQcNuOE=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=fvUzDWLUIpquMcU9Nb+O+CAPPmReiVfMB6AJH4HtQFVOA6AyymCOwnry7Vhp/7t+l
	 eLIT+/KaBzHOeXNoiZ0Ou0oBK3CEA+dnr+EG1+7J4hpkx1o8EkHvVFHlZMwyetff4U
	 hwxTdoKtZbEtUIGfXZ4/ZAZ7emcXjuHat0PlBpWlDaceTnz2KxDnK5B414YRrumwGW
	 Oa+9PmehK9+2E9nXDEwUlhlJQxlnXgRrwYQ55TkUa9YwGG2CfZASSqKoXUhGhEdXp2
	 THNzOWPZpnQT7FY13bzG0zFlCn7SYbHjTIffSMfBb8VOf4YMsc5FqvmsZZUyh3zqUP
	 2U8FWcyRCyx8A==
Message-ID: <sashiko-outbox-190701@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 2/3] virtio_balloon: add tracepoint for host ack
 latency
Reply-To: sashiko-reviews@lists.linux.dev
To: liuqiangneo@163.com
Cc: virtualization@lists.linux.dev, "Michael S. Tsirkin" <mst@redhat.com>, "Eugenio
 Perez" <eperezma@redhat.com>
In-Reply-To: <20261030083400.66005-3-liuqiangneo@163.com>
References: <20261030083400.66005-1-liuqiangneo@163.com>
 <20261030083400.66005-3-liuqiangneo@163.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 30 Oct 2026 08:37:36 +0000
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Post: <mailto:virtualization@lists.linux.dev>
List-Help: <mailto:virtualization+help@lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
List-Owner: <mailto:virtualization+owner@lists.linux.dev>
Precedence: list

> From: Qiang Liu <liuqiang@kylinos.cn>
>=20
> Balloon inflate/deflate block in tell_host() for host buffer consumption.
> Host-side stalls are easily mistaken for guest allocation issues.
>=20
> Add virtio_balloon_host_ack to record tell_host() wait time,
> virtqueue and PFN count, to split balloon latency between guest and host.
>=20
> Signed-off-by: Qiang Liu <liuqiang@kylinos.cn>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261030083400.6600=
5-1-liuqiangneo@163.com?part=3D2

