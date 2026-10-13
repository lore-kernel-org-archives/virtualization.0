Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0497D368D41
	for <virtualization@lists.linux.dev>; Tue, 13 Oct 2026 09:07:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791882462; cv=none; b=XXMTscbvLOe8LWqByrizfyYF18NDaywRzYkVivRIJniIJHmtBH891T2Hp6zDdlJpBWAImBNGIDS5g1ZjvrLn5JwHoLt4/nrMvWBy7NvNagY70O4q0BQ8ja08cwQTumGTO3ZKHePwK3SHI6vOT47Wgb6n6vDk6H+v8fWlURqJrE8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791882462; c=relaxed/simple;
	bh=XCMfKegB3WKCpJ3ttRnz6nkLrPcy+9KUe5vimDJi7RU=;
	h=Message-ID:From:Subject:To:Cc:In-Reply-To:References:Content-Type:
	 Date; b=WY/Pg/pW3PZw0TRurVIgIIe7iaVgQ14uXQaf6D/cAAmxo9FhZqeGfKvj4eD0UzN/Y9tVabiHk/Wpxj1DF1I+puCrcE4USZcZ4FfIc3HYrBeV8eEpnwKGcDPEe5f+2ViiXLTFqcSGymEijcmu4XaCWTff9LGNfyMZ9Y8pxxBcBn0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GlRzxKhU; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GlRzxKhU"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5513C1F000FF;
	Tue, 13 Oct 2026 09:07:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791882461;
	bh=XCMfKegB3WKCpJ3ttRnz6nkLrPcy+9KUe5vimDJi7RU=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=GlRzxKhUebidIP2+YWUEbAB6z7mngQU75FPZheazgzISldZAwZhG8tSi8dB8bkGVP
	 07fsYZ6mHmQqnnYlGcYusx205Gshqadt+1+6hjvwcySSMrMIHShBmKslnx+i1eFkFa
	 NIHEdtscs4t3SAI1Co4eMTzg7D76RofvmyZm0Q9O35dyrQYqA+6lK0zFtVbFuFdr07
	 eC41bUqfAriRQJ9bQh9rJLimJoOfriexHjhY4U2nxiw6RYs6SO2O+dWOSuWGsmCCer
	 cmpmPkrK0ZSOvAcSiQmccayrVps3nLzdMTqQ98nfK2X5hAUf07v8IUtbe4ccEg4akY
	 jjSrhjnLVVyJQ==
Message-ID: <sashiko-outbox-169315@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 1/5] ALSA: virtio: Propagate PCM send failures
 through ACK
Reply-To: sashiko-reviews@lists.linux.dev
To: "Joonho Lee" <mynameisjune111@gmail.com>
Cc: virtualization@lists.linux.dev, "Michael S. Tsirkin" <mst@redhat.com>, "Eugenio
 Perez" <eperezma@redhat.com>
In-Reply-To: <0a3846bb4f8742287f9c2024aec22faf0c35defa.1791881787.git.mynameisjune111@gmail.com>
References: <cover.1791881787.git.mynameisjune111@gmail.com>
 <0a3846bb4f8742287f9c2024aec22faf0c35defa.1791881787.git.mynameisjune111@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 13 Oct 2026 09:07:40 +0000
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>

> virtsnd_pcm_msg_send() can fail while queueing a transfer. Restore the
> failed message's length and notify the device about earlier messages
> queued by the same call, so they do not remain stranded.
>=20
> Propagate that failure through the indirect PCM transfer callback instead
> of discarding it. Commit the updated indirect state only after successful
> submission and stop further transfers when a send fails. Return an XRUN
> error to ALSA so the stream can recover.
>=20
> Keep the polling feature path unchanged.
>=20
> Fixes: fe981e67568c ("ALSA: virtio: use ack callback")
> Assisted-by: LLM
> Signed-off-by: Joonho Lee <mynameisjune111@gmail.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/cover.1791881787.gi=
t.mynameisjune111@gmail.com?part=3D1

