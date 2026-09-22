Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0ABF54EED9;
	Tue, 22 Sep 2026 13:43:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790084627; cv=none; b=uaqaGmacvq6vC2mAtHnchpPnjpf+qWvgd/ruaPPUEg7HPPRZvOndwGqPOb+JMPuMgHqGBpRc+gC9cvOpIMCIKkdXPIEw7F53S339N6wGYsYNelq4lLS9nurkfOuQ7RIJC2atMnKXrMxJJ1R/3IKJKBZFJIjAOfdDAPRgXdgs6NQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790084627; c=relaxed/simple;
	bh=zXxTN2COZDF0hNRazomQHJnwyQKnxIytwKHa2jswJWg=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=SkZRIvFdxlsVEJn4xKrmtULefnZ7PiqBLXQWPuCh+971rVItflnvtA9B8GMytMEWVnSt3snM5T2UijND30Y5lFDy1CLuDw+SgLQQMwVACdpisNTKRhREVe88j194jHbGrAwMPFM+P3tSU5qpeQtABeNGMXVR6iVjQ4aFmMoUq9c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RNxuR7LX; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RNxuR7LX"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 985D01F000FF;
	Tue, 22 Sep 2026 13:43:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790084625;
	bh=iyGUeR4PuWxPj1LvLir6624/jBNbFhNYxc5+uyukjRA=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=RNxuR7LXGxuNdmq0WJLvKgF202HHtHtL9lCxJ+Hjm5BrMra1rDBTZHAOy0/UepBxY
	 cXc4vskbuXTpZ7uaHBKpCs0+f5tsiS2sr1+x/6ceKY1vOglwAlHT0AVU+MFu94QeAh
	 xz6JXAZcbSE9FMHqBaFJKn1gzNSwIgC3gMPyCsBN26t14ArNwqmiJhiO+pjoIGYUlT
	 Vg+v2ndUpkxBUJpl1WeK3y2JTLonXbe/RtG/kHbmhslvyfG20wbXiwm96XvETwqj7k
	 d6a90S0fnW7xUDAhyp78SWv4AK3teDLU3y38fH/pFJALd29UQrRQsLmTt3YMvi3ENR
	 m6YCRQxlqpVBQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH net v3 7/8] vsock: handle listen() racing connect()
Reply-To: sashiko-reviews@lists.linux.dev
To: "Michal Luczaj" <mhal@rbox.co>
Cc: kvm@vger.kernel.org, "Michael S. Tsirkin" <mst@redhat.com>, "Eugenio
 Perez" <eperezma@redhat.com>, virtualization@lists.linux.dev
In-Reply-To: <20260922-vsock-connect-reset-closing-v3-7-78907b8200d4@rbox.co>
References: <20260922-vsock-connect-reset-closing-v3-0-78907b8200d4@rbox.co>
 <20260922-vsock-connect-reset-closing-v3-7-78907b8200d4@rbox.co>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 22 Sep 2026 13:43:44 +0000
Message-Id: <20260922134345.985D01F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>

> Socket can flip to TCP_LISTEN when connect() schedules out. Respect
> listen() winning the race: let connect() time out, but don't reset the
> socket.
>=20
> sk is CLOSE UNCONNECTED
> non-blocking connect():
>   sk :=3D SYN_SENT CONNECTING
>   enqueue vsock_connect_timeout()
>                                    blocking connect():
>                                      release_sock()
>                                      schedule_timeout()
> vsock_connect_timeout():
>   sk :=3D CLOSE UNCONNECTED
> listen():
>   sk :=3D LISTEN UNCONNECTED
>                                      lock_sock()
>                                      sk is TCP_LISTEN UNCONNECTED
>=20
> Signed-off-by: Michal Luczaj <mhal@rbox.co>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260922-vsock-conn=
ect-reset-closing-v3-0-78907b8200d4@rbox.co?part=3D7

