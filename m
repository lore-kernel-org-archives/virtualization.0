Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.216.49
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794458168;
	b=5KcNrFnQwu6Jx1b6eU9OJj6oopR1rKhe6If5qRNvffeRU+pN627YyuT9I+SDKwY6kgjI
	 BU6YyXqlVSjrPHyKbpbEaoS1AlNl/LHqQutVpGBBEm81XIm/16OtDR4ac5KzHbHSrVdu7
	 iLHv8M8Zanouj6baVTWI0pIWZBzb/YCCf5W47L4kkRztX/bL8ID3IAHeTqYT1OflRsiQF
	 d5sFG6CcPf4YEuPtreszm0Tw+0nd7BMtaEcEwWHiKknT9BK9n2qh0fA1I4ckaOke3S9Kx
	 Ni8cAmSRKCGEba0Vx5V7snEfu1NmN6bKhVwaHX+FL++w73FZQOybt3fr0M4NyB/HI0A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794458168;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=7hT/gC85F3aW3pcczI8WvAe9AkJI8Qa3b05R3EsTbPk=;
	b=J8NMFLbiF49x5w1MpmGDAZIHBxrPV+EK5dScGI87eGXWOBjAFpHd6Y+pdMexnhU5D8/I
	 RHvCoR4ynY49e86u9J1/ZaXfFNxSbMpc75RxuMYZWNvsvKOO60cRRp1/aZ4RTw+Blhzyk
	 2CLOQodTG4/PsNiQNY7OIw4HdSkuhSY7DH+VWX2RVxWbEioedCrWXI5AesgvOBqRwFwuP
	 zeb4sE2Oou132PfSMCWxx3BJoXa3aaakDa+YbaoTz+c3b+4KqeUaTFzUJ+jp9aApLqtOo
	 Eulqphx+FKmpKe2rS6f1A5FM81xai374oaZjcP2GlF/gPS9GYwj9vMXeXGHH/3sTrCw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=auxtqbWc;
	arc=none smtp.remote-ip=209.85.216.49
Received: from mail-pj1-f49.google.com (mail-pj1-f49.google.com [209.85.216.49])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A875F60A5BFC
	for <virtualization@lists.linux.dev>; Thu, 12 Nov 2026 04:36:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A875F60A5BFC
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=auxtqbWc
Received: by mail-pj1-f49.google.com with SMTP id 98e67ed59e1d1-3b0d09df973so3017086a91.0
        for <virtualization@lists.linux.dev>; Wed, 11 Nov 2026 20:36:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794458167; x=1795062967; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=7hT/gC85F3aW3pcczI8WvAe9AkJI8Qa3b05R3EsTbPk=;
        b=auxtqbWcG/Ot88uET+aGjMemijLkimE9mdPKecZscqP797CpoPkR59KVX44VbxeyKs
         DmTd8l1A0E9906pNFNC1IrKCgn+2yKLlw1XgODdZA37RmK6xPeF8u+MkscM6G20SUatP
         AKLxTgVb3Pxc5IpKKQjLb006tosrkRpqAUqwB9gMQqP0X0DaxFnILtgdQL5L/OZWs/Zl
         Q5XQBi/v2Pmt+iBH1vFs1Ep/ET3tlre0U6ScIF752ZjoXwTrqmZz2PTs7amB2x4KM2Au
         GsyJQY/Y9RhOUD6FjaSa9XBbZQFPq7IkqG210ijdLOK2kP/U+o56Hv8mden/6xUbT6t6
         otkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794458167; x=1795062967;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=7hT/gC85F3aW3pcczI8WvAe9AkJI8Qa3b05R3EsTbPk=;
        b=iJSZD1jLCeb85Bxr7v0qERXfsg+G7M85bJ4cqc2olNGeRRUTCK/T1ToCcXnV1yBe1V
         pRtZVDJrDq7doFIurQZVWkBz/wASCOnABtpwFpyrkEkq/Anp0pUYlfZBcC2d8QzgH5i/
         YBbQdQFSBFxkTun7IOiC1PVEEUaO3At2yQFABOveCMRS+d0SpYMIde/X7C5JgRU5QRCA
         a0riuvHV2hTmZjOj6pWDLiXuZ0s704saxVdclJOos5ktlioPZpjfPVJ+jWhPRW4oHHJ9
         4oCwqs6dKj1JkPlK6HsDAmODti4c5PsykLPiVe9y+KqEjXcpvjDxG+ZpqEBVh4GOBbZy
         DJXQ==
X-Forwarded-Encrypted: i=1; AL+hErHDTFvj1G010iXmIXryaluh1W/6UYUptGicrIC5wZUiiZYHIECNzXCInG8sNNiMHiI5JXLMa9j8zTUJZE9Abw==@lists.linux.dev
X-Gm-Message-State: APuU4Z923wPVuLesmKDA4lo5uZtbdWsD4/JHZlYV5gZsrthHYXnwSETQ
	mau7qKI9UoTum8YEZpfvasCbFMo8MPsgm6Ljjw3YcgFLnneeTQUf9Bon
X-Gm-Gg: AYBFou0zb4113UZBKVxconowIikwuB/PAAqB04Qr5bxQFNk+Mki/2Rt3UzZnq7NmxRL
	QZ8qazkZvk4sZpB42kwKCEtQWbZrqN7J4Q0pX8W11vP52YKu9AwtaHinfa9NacqvtGjyltyasnl
	NZyrE8Zece6MCyjqStftM4ChGrFgV0maMOOlC8jQLv1WnAaQhekIjn/sn1Ewmya6WwM3E7AaQ4O
	ZeKh9VkjZHsl03OpUlU54RslFyhTq5yS7+Rc7CDi1S/jPv0BT92ad4WvJnRjJjs+At0WqbCoBCt
	HZxPti2VmXBfkGM1ZDvnF8fPrLuRRhu+dkyUrTspJdTcMtsixBWov3NZVVEGgifkSJTJCJM7sJY
	D4VwawhbAx8VnsGbHz0kei/raPg9xrGu4ZnEJETj2ELsCExFtz61C5pUdzi0wdMLNfpeC1d9hOO
	E+Yf7hFMtGLTX2dJDuQHf5HWh569Ukef89u46pm1qUFp91ecLMaylvydjusZflKR5E/NFMuuzgC
	QoyqmSojt6q6hp/LYlBTGYshJZSaW7mNNcfmeUxTIPj8fiiBcr4iwwaLEzvpoGw49/gAjWNyJvj
	qgjDLqPVIGCnwdubWJCJRGnknhsDwiI4NkQIjRGT1fVB81dLxUJ0eGYOXfQdLoA/YfnRehp2W/8
	knwZ0y0p1MNDXfWzMerUNPFRbH6Y2zOkvbg4djxT1Nba+bWY=
X-Received: by 2002:a17:90b:3b8c:b0:3b0:9a0d:b825 with SMTP id 98e67ed59e1d1-3b182ee6991mr4517896a91.45.1794458167001;
        Wed, 11 Nov 2026 20:36:07 -0800 (PST)
Received: from localhost.localdomain ([183.96.175.225])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3b197c8b287sm2470466a91.15.2026.11.11.20.36.03
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Wed, 11 Nov 2026 20:36:06 -0800 (PST)
From: Joonho Lee <mynameisjune111@gmail.com>
To: linux-sound@vger.kernel.org
Cc: tiwai@suse.com,
	perex@perex.cz,
	anton.yakovlev@opensynergy.com,
	mst@redhat.com,
	virtualization@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	corbet@lwn.net,
	skhan@linuxfoundation.org,
	rdunlap@infradead.org,
	linux-doc@vger.kernel.org,
	Joonho Lee <mynameisjune111@gmail.com>
Subject: [PATCH v28 13/17] ALSA: virtio: prioritize capture period work
Date: Thu, 12 Nov 2026 13:35:12 +0900
Message-ID: <20261112043516.37010-14-mynameisjune111@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20261112043516.37010-1-mynameisjune111@gmail.com>
References: <20261112043516.37010-1-mynameisjune111@gmail.com>
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Post: <mailto:virtualization@lists.linux.dev>
List-Help: <mailto:virtualization+help@lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
List-Owner: <mailto:virtualization+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Use system_highpri_wq for capture progress notifications. Capture now
always uses request-owned storage. Playback keeps the ordinary
workqueue. This preserves the priority proposal separately from recovery
and accounting. It provides no hard real-time guarantee and cannot
prevent reader overruns.

Assisted-by: LLM
Signed-off-by: Joonho Lee <mynameisjune111@gmail.com>

---
sound/virtio/virtio_pcm.h |    3 +++
 1 file changed, 3 insertions(+)

diff --git a/sound/virtio/virtio_pcm.h b/sound/virtio/virtio_pcm.h
--- a/sound/virtio/virtio_pcm.h
+++ b/sound/virtio/virtio_pcm.h
@@ -173,6 +173,9 @@
 static inline bool
 virtsnd_pcm_schedule_period_elapsed(struct virtio_pcm_substream *vss)
 {
+	if (vss->direction == SNDRV_PCM_STREAM_CAPTURE)
+		return queue_work(system_highpri_wq, &vss->elapsed_period);
+
 	return schedule_work(&vss->elapsed_period);
 }
 
