Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794561989;
	b=5Vlh4wc65sjQOcBwjw0QAr+VMi+q/n1GlBwBMQr2Mqp7PixX6zHRfwVgi6nUAW83sp34
	 ASo/S9sfFc8V+wE98o5vHbSY7qIpSIBfylP9ajH0MMqB2kUwdEioAyQaTyW2s7DQyRwFa
	 /d3X1ZEmcJx8mmAjS7oE7xm1Oo/XHvEqU2YIpXeEtopG3I0SmwqV2wbcguGo5fMvr9hXW
	 pvVkf6qTq2pZmf5Y8vpYSSC+iNfKOO9wA745WWp+gqTeOmaDXsIc7Bcw5KCkuFB8i5HrA
	 tWKW1WhfFmyjggjLU24EhuD9/IEQvj9VSL9CTA+wz1e9JsD6qI5iKm1YIcqOuCs+TpQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794561989;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=D5tPSkA8Fcppy5WpSg+RzKuCunn7UKvOUldiQx58rHs=;
	b=uOAggomGJ2H0uQuCtm+KLB9159kkxEuuBt+1ZAFEE/5ySNJ2Tp1g8d6SxJlBQ0KXicmg
	 A/5TAGeWPAN6OL5xdLn4gif+bsWq+nLwd8NtmJHLX+VihCeeJJvZkOwRywDMNNDgxtLRG
	 aWT2JhQKWPUCMvzVLZbn9LHHgPj6EM8Kq2YstVWQ7CZarixCD05/ybAC7fcpJl/sth6kP
	 fOxFGG3voXMJsJR6gLpDFaNQAt+DN1PjKE2kLbTIngNvmpK1N8XbPXwGisWW6/vDxMi4A
	 emaTlRycAs3KbBGXmul/qkkXdluvv5f/1oIctSvSxd7Cer3kBYa+ZjXidEEhSgH7WgQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=kDl6l+Ve;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37699606A327
	for <virtualization@lists.linux.dev>; Fri, 13 Nov 2026 09:26:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=kDl6l+Ve
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 999EA1F000C4;
	Fri, 13 Nov 2026 09:26:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794561988;
	bh=D5tPSkA8Fcppy5WpSg+RzKuCunn7UKvOUldiQx58rHs=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=kDl6l+VeuZPDM1oqKv4K6rbVZjimHd1C/uZTVblAybpZaYKYxe9bDUEihvLpB6D2y
	 l5W7ReKVeJ3HUYBSEYo37936easqgxfzrEbrl/u5WdL/1iZZzxY+yt67ejh24DNeAX
	 zm2Ax6wy+QqnHwZ6Eq/KdmIT0WoRKwo8Di+kdxaVsaJsyeLAsj2yDupzA43jLyqJR4
	 ga0oe+t3rz/CvLK8MCf15k+D48Ihp8FqRCm5f8ABljo3abl3SqC9MSL+z49v9Op+cs
	 azvmEngSoDZ9vS587EFLH1HftwNq4LFMfykT2eRjszLHmFJXpDo3/0NVV8IsaWok9Y
	 28a7+0qjwcGHw==
Message-ID: <sashiko-outbox-212537@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v33 01/18] ALSA: pcm: mark stop-threshold accesses for
 capture policy sampling
Reply-To: sashiko-reviews@lists.linux.dev
To: "Joonho Lee" <mynameisjune111@gmail.com>
Cc: virtualization@lists.linux.dev, "Michael S. Tsirkin" <mst@redhat.com>, "Eugenio
 Perez" <eperezma@redhat.com>
In-Reply-To: <20261113-fix-virtio-snd-recovery-final-v33-1-13a934ad5ece@gmail.com>
References: <20261113-fix-virtio-snd-recovery-final-v33-0-13a934ad5ece@gmail.com>
 <20261113-fix-virtio-snd-recovery-final-v33-1-13a934ad5ece@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 13 Nov 2026 09:26:28 +0000
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Post: <mailto:virtualization@lists.linux.dev>
List-Help: <mailto:virtualization+help@lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
List-Owner: <mailto:virtualization+owner@lists.linux.dev>
Precedence: list

> From: Joonho Lee <mynameisjune111@gmail.com>
>=20
> The staged virtio-snd capture path needs to sample stop_threshold from
> completion context to distinguish free-running capture from bounded
> capture. Software parameters can update this field while capture runs.
>=20
> Mark the runtime stop-threshold assignments with WRITE_ONCE and the proc
> status read with READ_ONCE. This pairs the assignments with the driver's
> staged-capture policy sampling.
>=20
> These annotations do not provide a transaction for the entire sw_params
> update. The driver serializes its cached policy and accounting with its
> own substream lock.
>=20
> Assisted-by: LLM
> Signed-off-by: Joonho Lee <mynameisjune111@gmail.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261113-fix-virtio=
-snd-recovery-final-v33-0-13a934ad5ece@gmail.com?part=3D1

