Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794552118;
	b=3kEk6/mVy5pClY4JrGmSmXU0CwcT/B9BfnTSRdlFfSF11hOAzxXUFXqlveuWLDBnWO/m
	 WEoljmBpi9ObOYy4kOtvCUuwLGmmwvIMtTPzGrdzSJukCzWkEr0+GTXLTF963Z6LeSl9R
	 cpzQXop6cEVplly+6Va+bmMhk+H1uos+HS5CZAotQATvSdEb954tU5IPkBViqJFQLDdxz
	 qVsvq7WyYMNyO+RuoKKhEWsREVRVhpXDD7N1DZfl3XbJbBN4FX6+5PTY4pVh34Ned7d3G
	 4ByOs+WR6S4DHq3s61McczsBmIIR1FzV+1CVkpOuvHS8i4A1vhwDMSRDo8FwqWaWCEA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794552118;
	h=Received:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=fNs80IjWO2bX5IW3qnGYOU9Jg23y+CPE5qe9axhZDZ8=;
	b=YtwHOaD5fpoOqwkVg9/Qwg+5oa8mRb6sOz03Un2GFEbxEBZ1ANEbv57QLcO9G5MM9wEV
	 0XT/FLZONzWhsbA1CpGR9OVZ+ghNEDPQ8EgqmJTmeA3uHbGh+ZY+yYkiyyrdelrFrkvsv
	 JSJY5GdYEZhvwS9KSnfRbVsNRoyvvvGbFruoTjJf6RmtIDj+YQ8Sichf89X/DBPF/D8nJ
	 XvtyN6a7AGCpOCCBn4l+2ZDpTWa4Hz/GD7GI+zrP4DC0kWBiuV26p0aS3pvGlMQtVtQ25
	 bOEUGrIYoS/tiay3dc/Z2qzCgfl4DustIdiLfo6wMhcC4L0WuqXjMl2QlM22+6WX47g==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=GvhKweaG;
	arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E1D560A3818;
	Fri, 13 Nov 2026 06:41:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=GvhKweaG
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1794552118;
	b=SrNG0uJI7wECEvo50YJXewsV8UIX9Qvnip0qOZ4RGigoT3n1rbF75N6ekeAqN7xex9+s
	 PQch1BdLjkYN3ztI0LL93WNmFnU0vKxzFe9AN2jyvBgSolv/P68jwCdmcde3ASV8JBcIs
	 0JPDuY1C6b7BW1dISKwvakBG533gptfvxuvX5rZtiskJ7mYlpCx0nKKww7RE3rBS9mqyZ
	 uw4BG8LeQSASlILusJl4G9G8S6MAe1McHA0BIb7+PlBVlcB9xICQ5exJ0LAvnUpIDvgwL
	 TW9GVF6yKnd+BUO3+Oj+ineMJVfhmAFymnq0RBDu5ojylBvrW1fE+TN7bZkW0QjKYqA==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1794552118;
	h=DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=fNs80IjWO2bX5IW3qnGYOU9Jg23y+CPE5qe9axhZDZ8=;
	b=1oiQ5xvels3SGbNl2IpqDMVJby0hiK1wq36oh2CyGO6lENtOe5vwI+O75CuzgNY1sg+Y
	 emvKiUwUmqxrQb2OIx7OTTOkuhejmGdAfh5iAXXP454uvxje2ckc5enU39zYZkRegidq4
	 4XO3eftQQVob9VcM52LELJJ9C+wCoONNK4ZiIohFC8PKdBiViktRMsBuFUHWRggKazp68
	 oes+kb6yjWV5xZOSnpgYctYEwEGNKe4OCoXtX+PxVEa2rlDIcwT6MB9uMTGvAnDSNiz55
	 Iyi7k8P9FHGEdyKUchHpPyx25sf+ORNnKN5Obmlq8mNPdGA7ECzlWJ0z4kuCPQ8EAcQ==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id 26DA91F000CA;
	Fri, 13 Nov 2026 06:41:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794552118;
	bh=fNs80IjWO2bX5IW3qnGYOU9Jg23y+CPE5qe9axhZDZ8=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To;
	b=GvhKweaGUvr1OqtN3ydrCgP5KNuwHLfizMrUstw8IoY5Kv1iSpwJ3fe3CZ5iviSXb
	 vmg7u05ur7WIv2nAimxj3a/x4zf8alUkdPcxyNQHcEWaqGjYwrLA+vrHIOi6pWV9Jk
	 jtLJGlPpYvNxE3iut5QonY9wV0ddYC6p29EsJVSpCbuHDqOBHljHHz8Yoy7OrNsNBW
	 B62mlugnJ7rL971hgKhr/eoAYUh+GNJFFqVpanzn4HL0vA7RcSInBVVSJp2+iIf7sk
	 1WFw/YJ+KaGXFzx0JNntt7T/QM8Nvmpm8oN278XyLFAB4BFbJ4HhWAqTSALVh1vAXO
	 spEg290q2xQpQ==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id 1885247672;
	Fri, 13 Nov 2026 06:41:53 +0000 (UTC)
From: Joonho Lee via B4 Relay <devnull+mynameisjune111.gmail.com@kernel.org>
Date: Fri, 13 Nov 2026 15:41:59 +0900
Subject: [PATCH v32 15/20] ALSA: virtio: reject invalid playback
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
Message-Id: <20261113-fix-virtio-snd-recovery-final-v32-15-4e95979e312c@gmail.com>
References: <20261113-fix-virtio-snd-recovery-final-v32-0-4e95979e312c@gmail.com>
In-Reply-To: <20261113-fix-virtio-snd-recovery-final-v32-0-4e95979e312c@gmail.com>
To: linux-sound@vger.kernel.org
Cc: tiwai@suse.com, perex@perex.cz, mst@redhat.com, 
 virtualization@lists.linux.dev, linux-kernel@vger.kernel.org, 
 corbet@lwn.net, skhan@linuxfoundation.org, rdunlap@infradead.org, 
 linux-doc@vger.kernel.org, Joonho Lee <mynameisjune111@gmail.com>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1794552109; l=1402;
 i=mynameisjune111@gmail.com; s=default; h=from:subject:message-id;
 bh=Mi2xcgzTptRQt7yx/3bnE7wqogbVXioyVNQffxo+GWM=;
 b=r+0O/4UZbCe9sJwK7sanhJCGsdNPK3TjUbQc/eOxENXy0pZfq1kn1x3KZVnnik1NwQNnuwD4J
 6DvAVnGatWmCEGmwLy09Csb19qfiW5+B+w2gyArttpExT7+ngESiO3E
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


