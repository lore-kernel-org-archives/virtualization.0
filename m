Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794712871;
	b=neclYv19W9+ct7j58JsjqfAa3tKRfH3L7kqrhjCrWmiWp+M3cchBi0fGd4vR1RYdGBAD
	 G1uimAgc1teiNtAjzCGazoiYJz2UnKMpHgRzIS6qqTdVzBoei7xYdZ3Cb3wpZY0f8d51n
	 Os4dzkoSZnSVO3l74SRtjolHR40AfOOd7Qsuo5h11X2lDDIlMn+Z2/U5vopUYSoio8rFd
	 Cnwo8EqA25RYRy7BfveHee8X253XuUy97I9ShUd52KZdYzmNpjEQvt65/T0QO1PhNphbt
	 am38MWgm5V655BbyRwND8+LneN7MqXQaQOHYJbxdITVFnAwIcExqBm/l+D19UKtrkjw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794712871;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=RDhohtNIiijyispFZN8Os5vlnFWAJ0h804WoocO7psM=;
	b=lcWZ+uI3k8UUQESBGGJxUMs2bSKgQ4Fki0vs4cWXCpiDQ9NUG6GMzRu0MfSC/5nj17q5
	 wmeFyTsWHUiEuT2UuSh9YP/6KxSiTQ/bKHWpZQoyvVeiAn8+d+0XZByydapmahVByq4hO
	 QgrL1aHROS16oSctQEKXckm5ZhIAtY8x0ySCsYIHFLN2LgFl7YSqBBnNUEDx2VWG3W0a1
	 DB6TxBAmepNU/sB/NAhl9dUGcHfjvjRtxg9PatzxIK5ZdK6lWz3ztKifYZdBC+AU+ipgq
	 kb6yCz2LdN8PQz+++ep09IdDBTg+giZ0pee05YF2x/qNRjP8nRiVr8Oy+0JkfmtO2jw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=d9CH9WCg;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6F58606A881
	for <virtualization@lists.linux.dev>; Sun, 15 Nov 2026 03:21:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=d9CH9WCg
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 677881F000C7;
	Sun, 15 Nov 2026 03:21:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794712871;
	bh=RDhohtNIiijyispFZN8Os5vlnFWAJ0h804WoocO7psM=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=d9CH9WCgz2Yy+NOPvkKTuipyExQCANNlxt1V5E7plR3xc3TFwrxoZnhKJUjtg448w
	 FMZuX+yzzWV4SNKXhyQgUGINr5uJ4a4WQahZHuCPvOdBQeRDHwHNsgqOo6D/H3sjpd
	 5AZHUr+bguD16dwTBbz0miWlviuwS7xcOG4Q8dVWoDmL9Bw42n7BKKaUCISSAZvm5g
	 jb3a6UojwENnayjNe0EAuSHY+JSm4cgNy7vIXXrbxNWZI0Bpg78B/SsrrzHvbtDmfh
	 O+KPYw1/Zg+A7hzSdO0hPIm0SHctv7to+tSzD/EF6Q4VvJTUVtCZYpEOXPuI5O0Ds/
	 0mZOHCtH6+Fwg==
Message-ID: <sashiko-outbox-215195@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH net-next v6 2/8] vsock: constify the transport in
 vsock_for_each_connected_socket()
Reply-To: sashiko-reviews@lists.linux.dev
To: "Bobby Eshleman" <bobbyeshleman@meta.com>
Cc: virtualization@lists.linux.dev, "Michael S. Tsirkin" <mst@redhat.com>, "Eugenio
 Perez" <eperezma@redhat.com>
In-Reply-To: <20261113-vsock-guest-ns-v6-2-3737ce4673c0@meta.com>
References: <20261113-vsock-guest-ns-v6-0-3737ce4673c0@meta.com>
 <20261113-vsock-guest-ns-v6-2-3737ce4673c0@meta.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 15 Nov 2026 03:21:11 +0000
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Post: <mailto:virtualization@lists.linux.dev>
List-Help: <mailto:virtualization+help@lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
List-Owner: <mailto:virtualization+owner@lists.linux.dev>
Precedence: list

> Allow const transports to be passed too. The function only compares the
> pointer against vsk->transport, which is itself const, and never writes
> through it.
>=20
> No functional change.
>=20
> Reviewed-by: Stefano Garzarella <sgarzare@redhat.com>
> Signed-off-by: Bobby Eshleman <bobbyeshleman@meta.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261113-vsock-gues=
t-ns-v6-0-3737ce4673c0@meta.com?part=3D2

