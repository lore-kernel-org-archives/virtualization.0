Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792905511;
	b=mob+02t3mopy89cImAtLbIyp6f5rJmChyVSmwvvwxptumWOPSb1y1OopvjmsaP5Q6Y/w
	 VhSoruqIcsKUMJ5xZvs+Wq0SWhwwyTGxs9O8yUXU8rWem0nn7+oC9d0ymTq8sNRZfXc4v
	 v6soUI8RAXDALjIGWhOYON76O+GKCQty5cB764jmIaR6G0WEzpM3RYMjIKQ1tcR1iBDCd
	 S0DZBRaHkp88hn2R2LzHTNR0bPZwi6xExde2XimeyBWmXM3t5Ls4D+QQpZByrJ6aGfWuW
	 /pjWb1DISCjTYBU52PSb2eL2cVYo8ic8+tbOlD1NITQfWuFyXVmXY16Rnt/lPSqg2Mg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792905511;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=DeTPMF70SxqArpKArZtg2SO3k4IryJUvZzKUJk8leFk=;
	b=f5ZV9VEUUeUQJXCJg5TYTlxtpUs7auKB4q1vkqkhJGhP4sXT6uc+n4xmtvqoRmUy0zux
	 EYrz54eSMwEpgKOSZa/bSQINBcdJDsW1LE0x5DZznGdJ1M9ujCC5e7ccJxP9oZNwM/U6h
	 sNWR06RJOOGfKeKMBFG90L/u4HtE3reolgcHj2jGbxZCfEUK7zAp5hcyPUQmsEQ7NOFcD
	 CgxhUh7BZ4xX7YQow2vklvfzRGBnb6QlOHLnaAZ3M9ISzdTrn0Uvcyrz4G1O8XZm8pa6o
	 FAwKtYAdW027zgNIQefzodJEjPq0A7fchWDsPMcloRJodetP/bcJIRr9P/dKp+g34YA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=BgC36ZeI;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA565606A31B
	for <virtualization@lists.linux.dev>; Sun, 25 Oct 2026 05:18:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=BgC36ZeI
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 328C31F01828;
	Sun, 25 Oct 2026 05:18:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792905510;
	bh=DeTPMF70SxqArpKArZtg2SO3k4IryJUvZzKUJk8leFk=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=BgC36ZeIqWix9zzG9jkvSzRixz0D5bmcM2unCOi+tMRqu4woNQ4LXwbJ7tELNT44I
	 JlvJFyIyRkJc+w2ar16xW/7CK5v7jTEuuVVr5CSJDdV9VUcbl4sYTw8FXChSoXgJD9
	 AaprzdZDM+E10Kkqv2aY+dY9eYG2Fl2OV6s5yVttglDuILIYJOlsV09R7ShCbHDKFL
	 HWYaxUyBMSXYQyNPKBhrikaMKimdVgetm0I3TNeTuQqyRxeIbBnSP2XIKldK1nIm4W
	 iUaCaB4SmJB790MbRau4nNKGUrCPdZcGRIrm3MMOm8TlXa5+wPY1XOTOsHH6y+lkDA
	 l83EmNKMp3VGg==
Message-ID: <sashiko-outbox-184082@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 1/2] ALSA: pcm: mark stop-threshold accesses for
 capture policy sampling
Reply-To: sashiko-reviews@lists.linux.dev
To: "Joonho Lee" <mynameisjune111@gmail.com>
Cc: virtualization@lists.linux.dev, "Michael S. Tsirkin" <mst@redhat.com>, "Eugenio
 Perez" <eperezma@redhat.com>
In-Reply-To: <20261025051301.54640-2-mynameisjune111@gmail.com>
References: <20261025051301.54640-1-mynameisjune111@gmail.com>
 <20261025051301.54640-2-mynameisjune111@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 25 Oct 2026 05:18:29 +0000
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Post: <mailto:virtualization@lists.linux.dev>
List-Help: <mailto:virtualization+help@lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
List-Owner: <mailto:virtualization+owner@lists.linux.dev>
Precedence: list

> The staged virtio-snd capture path needs to sample stop_threshold from
> completion context to distinguish free-running capture from bounded
> capture. Software parameters can update this field while capture runs.
>=20
> Mark the runtime stop-threshold assignments with WRITE_ONCE and the proc
> status read with READ_ONCE. This pairs the assignments with the driver's
> READ_ONCE policy sampling in the following patch.
>=20
> These annotations do not provide a transaction for the entire sw_params
> update. The driver serializes its cached policy and accounting with its
> own substream lock.
>=20
> Assisted-by: LLM
> Signed-off-by: Joonho Lee <mynameisjune111@gmail.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261025051301.5464=
0-1-mynameisjune111@gmail.com?part=3D1

