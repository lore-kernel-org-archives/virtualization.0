Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA87E3A9610
	for <virtualization@lists.linux.dev>; Sun, 11 Oct 2026 13:02:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791723778; cv=none; b=G++SbxkEnEAcgrhRkvcRH5IByECV9YfZKXEgn0onKLEvQVN5jt0RJJUzm5WYM8gyd7g1LS0u2QjXzjGgqf/dDmP3+t4iqSCsc1DP4C4sC7PN542KbP6rC2RMNjMEmlEiG/1Gx1+GJOg04mMskqqY2pesY5lSd3bD6prZKl9mK48=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791723778; c=relaxed/simple;
	bh=nMUNvftkwV2YCyGw2MzGrvTm0V9hsCFwchpbiX8DiFI=;
	h=Message-ID:From:Subject:To:Cc:In-Reply-To:References:Content-Type:
	 Date; b=ISVlt4DQCevonKC3FyVxYD8zCWED+ikcyU4TMeKnCHSxkPOVczWjj2UnN37qYVxwFW6680zzLyoupTbEvNOSup5sTd8m8GTUD5WrEzdmgRkfi6tZgzRNNWJbStm7UxzADVagwffoo8HSNiNIq1YE/Zv4+xRbFaJnKGpwD6FEG60=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BVgh35jB; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BVgh35jB"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 253701F0089B;
	Sun, 11 Oct 2026 13:02:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791723777;
	bh=sF+sa7WEFfEGvG1vfPdBIFu4TVbd+OIqeOnzGLvAELM=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=BVgh35jBxYtI5PaxQygqAhYMdixzEazUkiZ1ZoGEb9GJf9oIzxWY69j3XOioErUEa
	 AYZ56fj6sGI4H9fHepJ3jcnXmiKr4kAYkMK7fButRxExSJeUAJ9wktDHNba5alc2im
	 OocjwvhX+MTZFbWKW0GKz1YtQKAmMeqjJhwI04FNkZMY51qOJhCER0Q3N8+h4KXqwN
	 6PewXblqPGSCTe+t66SeseLMasjE9At82LR2AJMHI1cTScsLUW97/UkyQcij1qcLPz
	 PlvYsyggvSXs9sw0SfipLKQSkLLHvJgdXA1tCnoqmHuCPahQo+eSJyBmjDerbcPA4p
	 JU0m61SoBC0gg==
Message-ID: <sashiko-outbox-167243@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] ALSA: virtio: reset I/O message fill level on prepare
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ting-Han Hou" <ue081723@gmail.com>
Cc: virtualization@lists.linux.dev, "Eugenio Perez" <eperezma@redhat.com>, "Michael
 S. Tsirkin" <mst@redhat.com>
In-Reply-To: <20261011125426.35745-1-ue081723@gmail.com>
References: <20261011125426.35745-1-ue081723@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 11 Oct 2026 13:02:56 +0000
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>

> Since commit fe981e67568c ("ALSA: virtio: use ack callback"), an I/O
> message is only queued to the device once the application has filled
> the whole period: virtsnd_pcm_msg_send() accumulates the transferred
> bytes in msg->length and queues the message when it reaches
> period_bytes.  msg->length is reset to 0 only when the device completes
> the message.
>=20
> If the substream is stopped (e.g. snd_pcm_drop()) while a period is
> only partially filled, the corresponding message is never queued and
> keeps its partial length.  virtsnd_pcm_prepare() resets msg_count,
> hw_ptr and the indirect PCM state, but not msg->length.  After the
> next start, the stale length is added to the new data, the sum never
> equals period_bytes, and the message is never sent again.  Playback
> then stalls once hw_ptr reaches that period: writes fail with -EIO
> ("DMA or IRQ trouble") and drain fails with -EIO.  Capture is affected the
> [ ... ]
> Found by code inspection, confirmed with the reproducer above.
>=20
> Fixes: fe981e67568c ("ALSA: virtio: use ack callback")
> Assisted-by: LLM
> Signed-off-by: Ting-Han Hou <ue081723@gmail.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261011125426.3574=
5-1-ue081723@gmail.com?part=3D1

