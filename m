Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794561700;
	b=4hKTpEtVGHlvuQJ+xbj129JJchJdiG8NzcDq/xgGDMl6HrGfwEoFiSE3gALu/pw0Lcz/
	 gMLQvcvkxpqBaarcNFIp/G8+hPoLAfcLxbH4b/23MVA8l1cDaWDpQrkR9fACNSdIuLEuC
	 F+f+dxo0jzf2nyXc3saRkGFEJPSph3MJQKFQ+QCFZ79DxNP0Xbhh0QYl6wye9BdO95z+d
	 vrCp/mTt1tHU7KDG0Tt2vTS7jO+YlO7Rz0k4PfhrCbttCJo/gk0CyjJlIjnyNhS8V1oIW
	 QCRxOzRKICMwvYPJYzE5foqGrelnZO9o8UJpBWh3Lebfr3ALu6xQ7vnGNjXX4hvooQg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794561700;
	h=Received:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=fNs80IjWO2bX5IW3qnGYOU9Jg23y+CPE5qe9axhZDZ8=;
	b=V6/dcWH6t28Hd+rsGhVdHL9lrlf9GUf4SZ9aY5CqaXzJ+9M/GaL4buyn922m+sywIZMS
	 Nm0QY17dAiEMt8L2ezyaQZXUoLXKyirF+CZjnmTJRtzbZxDM2PbE9rBBxqeMmJPxpKtrZ
	 kP2CFhfAH/guNEI6bxUANLwpE1KhOSKU6k7a9UgIvKBWKPLR78bQMHbUaw8DX+7wI8qO2
	 ih05JBWFlwG+l9rWjYabbIPWIOHSF53hJfSOG9nhaolajtr1xaabPY88C0HT5dHs5bTf4
	 l/4y0Ya6XS5mWkh95zUIYyJiKGeMVtURZwwKjA/CffnbBZU4JZKitDIspWwU3kiZ2TA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="hcPb/EJG";
	arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C29860A5BC7;
	Fri, 13 Nov 2026 09:21:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=hcPb/EJG
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1794561700;
	b=tK+z40HfFfgvGk0c3kNB9KIKqwkUMYw84yC0gYqmi5Hsu9Nfmen4OoFSJuvsvKqEVEXZ
	 LltO19vPzQ1ri/7lYIk5UHxxqhAITFKjtVqJLopiPsOGS+t163xm5UhnNN28C6pi8tLyO
	 IXxcQTI5RQv3S+BNim5wXXntdRn2tc1L3+eVBN+/7AwNe3AEBk0U+WGH8yFbMqV48mQQy
	 CdLFeKTPWMOtcO4iN+9RbQWqJjacbt52YZ7ZSsXVm61qGaPeImEcnAipS/P5xwNS3ha8L
	 iXOhWWacjDveZfS/E4RfveOQnuGU4i8g8DDgPQocOZhYxMGi758Z3MRKB4PyyNc3e5w==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1794561700;
	h=DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=fNs80IjWO2bX5IW3qnGYOU9Jg23y+CPE5qe9axhZDZ8=;
	b=qh/v27nK8j/roK0rTkXtbvSDIXVHcnu0jJ20X83UV5eyihGbN2o8o/oKL02X32uCIy8x
	 KJtgWaVivh6lTcf+0/Ffkt5Sy/cZNsxA1UiPFOWD/aLAU2nBLxiRld+RGGopS72U5LA5Y
	 8G2vQ4IpKzZR9hEfHGC6KwxfrLzMNWfAJSPYbbUpd0BHwzcMAztr3a0bxI/NxNoS/ZEYP
	 MQ0FYQtBL5kimFCc9JDFmzYEGab2knTqQo43FDe3O/pkOWDacC3AQ3zKEa0D4MZd4i32Z
	 WCrC4o9UUblKXJWE9mDTcTHbjTH68PMQpZo4xn5ukVg1dDoeMK0YjNZ9Z8+4vnfAI3g==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id 05B251F000D4;
	Fri, 13 Nov 2026 09:21:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794561699;
	bh=fNs80IjWO2bX5IW3qnGYOU9Jg23y+CPE5qe9axhZDZ8=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To;
	b=hcPb/EJGLDu28oQOKXvlpjljl1WWlsfM8RxnnzbmkMxCyrw9aJnue6WG2MuCSyiES
	 PqEG1g5L5DPrdm3IDeZwWJi9VbEiAgdkeP67sPjBzzpOrksf1xPQxqWVTOk63ffAOS
	 JhCjG1SMYkTaKd4RPpg3Hh/afIwdVE3BrLGvytgMNmmpq9vxpV5XwT+4Kc1uol+cj6
	 27B0uGF+wf1m/dEm5J+yTwvMvdHW05cKdcVpHy6zjOsFN04syIdEStJpAh8m9rS1dh
	 5mtMNUYFbKkHgzwUdO6eCH/aUFH0qBAUefyMjazg3xPBXsIwHotweu6wWrs5mu7RkO
	 oW2WX8fGePc8g==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id 7FF3247740;
	Fri, 13 Nov 2026 09:21:33 +0000 (UTC)
From: Joonho Lee via B4 Relay <devnull+mynameisjune111.gmail.com@kernel.org>
Date: Fri, 13 Nov 2026 18:21:39 +0900
Subject: [PATCH v33 15/18] ALSA: virtio: reject invalid playback
 completions
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Post: <mailto:virtualization@lists.linux.dev>
List-Help: <mailto:virtualization+help@lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
List-Owner: <mailto:virtualization+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Message-Id: <20261113-fix-virtio-snd-recovery-final-v33-15-13a934ad5ece@gmail.com>
References: <20261113-fix-virtio-snd-recovery-final-v33-0-13a934ad5ece@gmail.com>
In-Reply-To: <20261113-fix-virtio-snd-recovery-final-v33-0-13a934ad5ece@gmail.com>
To: linux-sound@vger.kernel.org, 
 Anton Yakovlev <anton.yakovlev@opensynergy.com>, 
 Matias Ezequiel Vara Larsen <mvaralar@redhat.com>
Cc: tiwai@suse.com, perex@perex.cz, mst@redhat.com, 
 virtualization@lists.linux.dev, linux-kernel@vger.kernel.org, 
 corbet@lwn.net, skhan@linuxfoundation.org, rdunlap@infradead.org, 
 linux-doc@vger.kernel.org, Takashi Iwai <tiwai@suse.de>, 
 Joonho Lee <mynameisjune111@gmail.com>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1794561688; l=1402;
 i=mynameisjune111@gmail.com; s=default; h=from:subject:message-id;
 bh=Mi2xcgzTptRQt7yx/3bnE7wqogbVXioyVNQffxo+GWM=;
 b=PAYe7t9UtUPDvHyhe9I+i47/IFtUihiTuOGG6NynCGo1djibS+xD2GtUK74FaLTq7+vlTgCvj
 X4A/IbfDejRBPdW3jSIqDwMZ1rS5qsLroPLUSVv+zZGnWGMMfERlGa1
X-Developer-Key: i=mynameisjune111@gmail.com; a=ed25519;
 pk=wqkZdvfcC8g8fDi6f0Y58LlaXIo+ubf6Y/9Lr9yhshc=
X-Endpoint-Received: by B4 Relay for mynameisjune111@gmail.com/default with
 auth_id=1508
X-Original-From: Joonho Lee <mynameisjune111@gmail.com>
Reply-To: mynameisjune111@gmail.com
Content-Transfer-Encoding: 7bit

From: Joonho Lee <mynameisjune111@gmail.com>

A TX completion currently advances the hardware position even when the
used length is malformed or the device reports an error. Validate the
fixed status response before publishing progress. Retire the request
once, latch XRUN and schedule error delivery while preparation is
active. Keep malformed or failed transfers out of successful playback
byte accounting.

Assisted-by: LLM
Signed-off-by: Joonho Lee <mynameisjune111@gmail.com>
---
 sound/virtio/virtio_pcm_msg.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/sound/virtio/virtio_pcm_msg.c b/sound/virtio/virtio_pcm_msg.c
index 3dfc45d90f08..9c67a8bf15f5 100644
--- a/sound/virtio/virtio_pcm_msg.c
+++ b/sound/virtio/virtio_pcm_msg.c
@@ -1011,6 +1011,17 @@ static void virtsnd_pcm_msg_complete(struct virtio_pcm_msg *msg,
 
 	/* Playback requests point directly at the ALSA ring. */
 	guard(spinlock)(&vss->lock);
+	if (written_bytes != sizeof(*msg->status) ||
+	    le32_to_cpu(msg->status->status) != VIRTIO_SND_S_OK) {
+		vss->xfer_xrun = true;
+		msg->length = 0;
+		vss->msg_count--;
+		if (!vss->msg_count)
+			wake_up_all(&vss->msg_empty);
+		if (vss->prepared && !vss->preparing)
+			virtsnd_pcm_schedule_period_elapsed(vss);
+		return;
+	}
 	completed_bytes = msg->length;
 	latency_bytes = le32_to_cpu(msg->status->latency_bytes);
 	vss->hw_ptr += completed_bytes;

-- 
Git-157)


