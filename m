Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA7924E323F
	for <virtualization@lists.linux.dev>; Wed, 14 Oct 2026 12:15:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791980117; cv=none; b=JQCoE4YuOatjMbcnzgAIGTCHdkyu4wGafOUx3NYvdGynYS5Dw9cmwdTCXwd1NMFyCOATdPU7cJLxZ1CuXfR5lDhhzblP0mYHDqe1lLZcD53fafzsCM1gw75uZ9vkxCe/MGMBtNCAUkYFCHdv6+1M84Ds3+PT8bpjHHD1C6ULyQc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791980117; c=relaxed/simple;
	bh=S/eaWOKxi6YeW3y5VTxD84tJcyx09d/Y+jZ2V1yVWvY=;
	h=Message-ID:From:Subject:To:Cc:In-Reply-To:References:Content-Type:
	 Date; b=iOzzulwwuWL5/L6vDr8UV1N77yid9+MUxi199wpTl3HL7lSx1UQohfS9kLADjvnEdCLPKHh6lLbQiJPnkHmVlw/Ot/MQd9dy/uHaL6r069b+5aYZLkhmboqQiw8/khAadOh5OrKbsrJLUaVW86Stb6vhqmV/v+uCUlW5E/RTRPo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lze05AAp; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lze05AAp"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 767741F00893;
	Wed, 14 Oct 2026 12:15:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791980116;
	bh=S/eaWOKxi6YeW3y5VTxD84tJcyx09d/Y+jZ2V1yVWvY=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=lze05AApcYdrALSz4yI3zE/PAU/T5JRUWUjQvLJ3kB5DS8kp9PYfl7TaNyNfK/ROi
	 Y4e3l7NAiSU5BTYW5LoBsXwnAqaJGcnSdy1eRGYnodelNe4bmnKbAhUBf7hVAMNzk/
	 x87+4KYlVpb3yrEp6kfc512rPffaBT0zWB8+aUi61x0Mcqu0yXD5LUD9hXz3tcgiSg
	 THxN91R3uSJeU+dPsCyC8b7ACKw5VxsVOJ1CmZdg2QEN8zzssZFozHrtUDlHb0Y8Ut
	 EC1Rs7GFYp5Vq3deL0Th8eSIWC8UBhIzyrn2B/LCDbL4cWGFlyk5aA4Kyb49Xv6zrV
	 pGF86j9Trlpkw==
Message-ID: <sashiko-outbox-171254@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH net-next v4 4/4] vsock/virtio: defer RX notifications
 until batch unlock
Reply-To: sashiko-reviews@lists.linux.dev
To: "Jia Jia" <physicalmtea@gmail.com>
Cc: virtualization@lists.linux.dev, "Michael S. Tsirkin" <mst@redhat.com>, "Eugenio
 Perez" <eperezma@redhat.com>
In-Reply-To: <20261014115640.184286-5-physicalmtea@gmail.com>
References: <20261014115640.184286-1-physicalmtea@gmail.com>
 <20261014115640.184286-5-physicalmtea@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 14 Oct 2026 12:15:16 +0000
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>

> An RX batch can make a socket readable while the worker still holds its
> socket lock. Waking a blocking reader then only moves it to waiting for
> the same lock.
>=20
> Record the existing low-watermark condition and notify once after
> release_sock(). Move the coalesced write-space notification after the
> unlock as well, since both callbacks wake sk_sleep(sk). Deliver
> write-space before data-ready and keep the lookup reference until both
> callbacks complete.
>=20
> As with write-space, save the initial sk_data_ready callback and batch on=
ly
> while both saved callbacks remain installed. Sockets with replaced
> callbacks retain their per-packet behavior.
>=20
> The existing psock-marker check also covers a concurrent sockmap attach:
> at most the already admitted packet completes on the native path, and the
> next packet ends the batch.
>=20
> Signed-off-by: Jia Jia <physicalmtea@gmail.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261014115640.1842=
86-1-physicalmtea@gmail.com?part=3D4

