Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.216.45
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794355610;
	b=0e1YaB/YNQjBNKmaV5IQYFcSI/y+P/jEzPNd+FUyiKD8XAHC9/LRlzov2pYYghHVk9K2
	 HKe+iFag3zpOkO168+Arw1ZqYYsdyPauZ1UGqOoTlyxulxWCJQ1GKCHyUpSkTCllI5fU0
	 2ESykhy2undiPGSmwX+d1K837CRMnijLVRwLBj0Kl35DDXQ1nO/2GhXGLjqw8vZUxKyHx
	 hlFWUN5ycQUBFQNNYXlmzvj8g0pRgK1WnNKMNwM2aOMks7ihEQO8/4COMzwHZwZVhw3xH
	 eLiCQEK7Brx/miSLW80e3i4ywbeK6glkI72OVY85rzrtFwg8urFWaxg3DVMJXWhmsGw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794355610;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=cedV0+mBiOhhOlmQFuEFj3GrQxb4hXlX2OGeB7wX9RQ=;
	b=CIrj8lMbFZ8AbICyt3ko7SaUKqyzo+zG3YV7UQktmKDbqQMCDYxvf23WKM0A3jhAEOPK
	 2mZcry4NUH5aQ15cZQPLQ1BZj7tak4uUZtIBUinkCM/Mym81KQeBBtADubX0ydA6AzOnN
	 Hf0cevyWxON0OxlUbWjZAClTCtpkogWYjGxfM3wpd7dMGeOfVkdFxA3rS0TC/6Jkwfjk1
	 vb57EJ0ZdKgVa/LPmLMEFbIvYPBqvB6JWI1rGCGMHw1/QqFnF3gLpocvOSUir8TFmErSk
	 jRy4OqbIBhgruz7az5kKYjScrB0Zo0e61OjpbHVQVnqwWU9uM947HTCxpdPevxPTalA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=hhBk+52x;
	arc=none smtp.remote-ip=209.85.216.45
Received: from mail-pj1-f45.google.com (mail-pj1-f45.google.com [209.85.216.45])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F5EB60A3809
	for <virtualization@lists.linux.dev>; Wed, 11 Nov 2026 00:06:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 9F5EB60A3809
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=hhBk+52x
Received: by mail-pj1-f45.google.com with SMTP id 98e67ed59e1d1-3b10ca4e3f9so1509653a91.0
        for <virtualization@lists.linux.dev>; Tue, 10 Nov 2026 16:06:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794355609; x=1794960409; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=cedV0+mBiOhhOlmQFuEFj3GrQxb4hXlX2OGeB7wX9RQ=;
        b=hhBk+52xoaAh34YTqhdrrOF/oQsEpVPFCt5v/qPP8TmNUSbJnaWVSgh4FJMs/8Zvqc
         Cx4NASV4pL2Wz7+VttWzF7ChJUbUGolBTbOEkidRtvDwFpwzoqAP6mqSYDBg9RfSgj+y
         /7IX6m5KpgWQ2kr7wWepqV7UEzikHMgDplM4O4GMk+nuXLo1v1feFRO8uKlP5KkrymdT
         v8NbA8XTv1F2ThzjzA2+CJyBlNw+dvCCgZlZ76t2/Sx7obigNdEkdfdaYU5KEZmKoyXS
         mCTYEdo/zmKNG6loSFUq7FDsOWiKhdCmBNgQK5R1phZ3eVUivDLbDT86R+53mivo8cSg
         yiWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794355609; x=1794960409;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=cedV0+mBiOhhOlmQFuEFj3GrQxb4hXlX2OGeB7wX9RQ=;
        b=fysNDur3PbJXFKp58jHDlAQzlA/6D8tSBfS12GaAoPwb5uGkQBvmm4COzKxbk3mnNz
         3KUYnbopSuHYtfbi7B+aPV7e9vi7bc1IgGX255uUg6h30GIK5KGIjXgbGVlU8+vxCCYN
         uplJI1kSWx/5JIHsVw8FztMZJllaSxNYf2ZJ+D7w1eqXSorwPeoZXAcd93N0Goc3WdnP
         wJare2/ylch5KNzDIExKjDLzgmegW7jJ/yJfMEQJ4BDxMmDfgUrlJi3/iUYgMUEbUPsd
         Dkwq8chEo+9UUTc5HxaNu3w2JuDSliEjhM92127Bon4n1YAx09V+PoZH6rDDNloX5mE5
         4H+w==
X-Forwarded-Encrypted: i=1; AL+hErHIuNqMKHGvoCL0VhAa4asYHgVvzGHAx3kGCld7Eoa/b86AgBlRDrb/83mMUler9kI88jnz3tL4dlyht5av4g==@lists.linux.dev
X-Gm-Message-State: APuU4Z+oTWlCBIapo56uEkkLbh/ZWIDGv35EAOuNwpE+OJPjk9ifsr8U
	AYyK/pq1rKrlx1/Oe0hLkOlBmTRpT2WdISIV8uC78SeC+/Z4xii/oWPp
X-Gm-Gg: AYBFou0dGGHYzJejDAxNQN+sz8fdzuVB2TpeocMSIjeemWeRMTV8darP5gbeLI5+S0n
	oYy7U3xHtFBVNkn2NxYSks0RIlFjcH5gvPBFY11nzn9G+rTnpe2bWx1Nv9ND1sOmkYzf9sOuF+b
	4CBGHCzmNFq7w+m1ilnuf2cA2ygac8e8npX3Y1aivJIFSRPPrNr44BlEuMqNb7U3GGUFQKCAiEA
	ErxHXTOZSaG+z3lCMtN6AqTYkV5wfDC7VYDRoKAO4Z+vYFFJy6r8W0YhmuzV1/WB31Zcnv598Pi
	xyR9IO6xELaKj2GeA59EjDjfE3VVsCDma4ZA15Nf3rVZNwkx0pJNJDH7EXjGmc0lpB3pZMrLZDS
	Zgm0v6B7W03D1F2JfoyX5kdhTxKtAUmib6hgn4zjhgqLWkA3EdWx7533ib1617SQcuJpZ4a5uCV
	b6yGtE2OdvVrje1huHU0POLdeVqnmmGDkc+GeFLC3xfu/FiVCGVPTfC17i4w/Fab1mgS0aN5fTd
	uVP54BKCJpW6PuUa55/6p6UdZsqrxn2nJtsK/qtTy7JnPAZZ6QVwrOcIorkoX2JIdO4L0KiMePZ
	Sff1vqyYOhVa5Z5guNwdkjYMuqViAnUTUEcPVu6jtP1Z3uDCAfHjhGN9w+P/L1JFKKDojSz2zzK
	TA0TXmSDQmjqX26MtBSKLvmf+CDmL+Q751eT/M4CYtoTQHbs=
X-Received: by 2002:a17:90b:4c4c:b0:3b0:e2a9:3466 with SMTP id 98e67ed59e1d1-3b182eebe65mr643070a91.16.1794355609114;
        Tue, 10 Nov 2026 16:06:49 -0800 (PST)
Received: from localhost.localdomain ([183.96.175.225])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3b1838e616dsm474361a91.4.2026.11.10.16.06.45
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Tue, 10 Nov 2026 16:06:48 -0800 (PST)
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
Subject: [PATCH v24 15/16] ALSA: virtio: reject invalid playback completions
Date: Wed, 11 Nov 2026 09:05:42 +0900
Message-ID: <20261111000543.28550-16-mynameisjune111@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20261111000543.28550-1-mynameisjune111@gmail.com>
References: <20261111000543.28550-1-mynameisjune111@gmail.com>
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

A TX completion currently advances the hardware position even when the
used length is malformed or the device reports an error. Validate the
fixed status response before publishing progress. Retire the request
once, latch XRUN and schedule error delivery while preparation is
active. Keep malformed or failed transfers out of successful playback
byte accounting.

Assisted-by: LLM
Signed-off-by: Joonho Lee <mynameisjune111@gmail.com>

---
sound/virtio/virtio_pcm_msg.c |   11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/sound/virtio/virtio_pcm_msg.c b/sound/virtio/virtio_pcm_msg.c
--- a/sound/virtio/virtio_pcm_msg.c
+++ b/sound/virtio/virtio_pcm_msg.c
@@ -980,6 +980,17 @@
 
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
