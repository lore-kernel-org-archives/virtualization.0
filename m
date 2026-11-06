Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793925353;
	b=fHw911O9r74oAp2A7kAzM2y5Oq5XoqUMuI0awXjVAkg42HjE38vP95BkfKam2kOnvXNe
	 O0sKciiFUgncotBwUA59K4Wkh1sGL+8z7geyQiZKEjCIvX4w+quLcSTc1LVy91smR7tuy
	 bepu7SQOLSnurfAPRVqO3vd3lvxMLD7klV9noGQlthQxr6Yi7VSewKIQwppIbHH2AKBFQ
	 QIosB19CJi+R0IZ/yADxvAcHaRZPNQrSqsDrMgPy9fATOTapuc1ncGFH2ohYggKmJJdAv
	 SokdVhx9SqBYMsQyfpgZjIhD9noSmbLFbri8os0AkoJyECFKApmc+xUc1Ch6GgD1Vxg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793925353;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=UoDFnQ+ZwElqVb1juWa4oG65/GGLv6kFt0mMcq1sYa8=;
	b=h8JJEeExo/tU3XuFZ5NPR5VbHuZu4eDzKPYamogzo0CoiFKHJgMH5cqB122HqCwUUSuV
	 xSS847K8IloNBoeC8UJxZW+TUmN+Ie1fE3oAxkjg8ZhjXCnnvMhF7DVSZV/MFpuzf8Upl
	 60VAq6PUDngk03ehakJPRaRVoG9GCdVX6RmkOs702XisVNwYUACzBIF7KVXu1a0VsbBdJ
	 rTPQ9RNxOLZ6E8xWH0xuX02e74YlM1oFTy6TWEwvO1qtJGe95XzSBuBF+BwXfIwc2Zh4o
	 Kjckjg8N6eGcjdDXl7QMT5E4W6Y/aUEdkoYePX3iN6wUka5+ASFULo9aauFd1bdxkWg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="V/jOVGs9";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C344606A31B
	for <virtualization@lists.linux.dev>; Fri,  6 Nov 2026 00:35:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=V/jOVGs9
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B32CE1F008A1;
	Fri,  6 Nov 2026 00:35:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793925352;
	bh=UoDFnQ+ZwElqVb1juWa4oG65/GGLv6kFt0mMcq1sYa8=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=V/jOVGs9WxHCl8UdgQe5o5jF5sx7EwwQc2G1J1NAwJw1o/2wg+fV/HBjxlNXPpfAP
	 We8E5xq5W6ny1ZncYJu0k2dS2ozKhLQzjtjStIs4PTjnafmhM2LhPMfCeikCSmXe5Q
	 TBoLa0M3LE6cSftplVWz2q55uZ8EzMYdJ5z8OuTxYIMGIPkIhRqCmkql61UcZ8g4Mg
	 vhGL/zFZka/UAD0X1fvrc4KFXF0yQCmIU28vnpIUDyp88iQWn95Ng4YFThysA9KHMc
	 +gzluriBJ1v3ibDemWutPKMlqOsPRCxfZ3oU1TvHqz/ADtTEDo4vv5syGPBxTC+atR
	 NruRYxFR4t3Og==
Message-ID: <sashiko-outbox-200450@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v18 04/12] ALSA: virtio: Propagate PCM send failures
 through ACK
Reply-To: sashiko-reviews@lists.linux.dev
To: "Joonho Lee" <mynameisjune111@gmail.com>
Cc: virtualization@lists.linux.dev, "Michael S. Tsirkin" <mst@redhat.com>, "Eugenio
 Perez" <eperezma@redhat.com>
In-Reply-To: <20261106000644.20460-5-mynameisjune111@gmail.com>
References: <20261106000644.20460-1-mynameisjune111@gmail.com>
 <20261106000644.20460-5-mynameisjune111@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 06 Nov 2026 00:35:52 +0000
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Post: <mailto:virtualization@lists.linux.dev>
List-Help: <mailto:virtualization+help@lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
List-Owner: <mailto:virtualization+owner@lists.linux.dev>
Precedence: list

> virtsnd_pcm_msg_send() can fail while queueing a transfer. Restore the
> failed message's length and notify the device about earlier messages
> queued by the same call, so they do not remain stranded.
>=20
> Propagate errors through the indirect transfer callback and commit its
> private cursor only after successful submission. Genuine transfer errors
> arm stop_operating and return -EPIPE so ALSA can retire the stream.
>=20
> Close ACK admission under the PCM stream lock before sleeping teardown.
> Keep the prepared state protected by the substream lock and reject ACK
> through prepare and parameter changes. Reopen admission in the reset
> callback while the core holds the PCM lock for its pointer rebase. An
> ACK racing with teardown returns -EBADFD and preserves stop state.
>=20
> Keep the polling feature path unchanged.
>=20
> Fixes: fe981e67568c ("ALSA: virtio: use ack callback")
>=20
> Reject a stopped playback ACK before the XRUN path can rearm
> stop_operating. For capture, allow the ordinary stopped tail only during
> DRAINING and only while no transfer XRUN is latched.
>=20
> Latch a transfer failure before stopping PCM work. Once core reports the =
member XRUN, ACK returns -EBADFD to avoid another linked XRUN. ACK during p=
repare remains rejected until the core state reaches PREPARED.
> Signed-off-by: Joonho Lee <mynameisjune111@gmail.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261106000644.2046=
0-1-mynameisjune111@gmail.com?part=3D4

