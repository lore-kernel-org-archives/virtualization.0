Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.46
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794461741;
	b=0PXBMPdXPKS1CfZseHqH+d7z1hfWQRS0IoBNkwLThup79OKmGlPXHs8DQEiXz6wrdUwb
	 EMWEbEki5XuAl4x9V1qfCrv+9mQ+Ookedu/QLIlMY8qwcza5Ei8MR1s5ZJE/3bXcMbhWf
	 z4qC+bkPVuQrU7bpRMVEXNtxVtKm1WBzTE8dlAvqHtopPJfhV9fE6A/iwbPmXvcU1XGZx
	 nVlNfGoNX/2cAXVVnwMNeX/gzyNB1SmQWaniXCVkjYNBRCihJDKhupmadmcWErKyi5SV1
	 ossVCANf8x6IVxr//BNchh/XeWDwUQ72S4Re9InBa6eRdS7lq7sNzHdwW6Oqe/ly65w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794461741;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=7hT/gC85F3aW3pcczI8WvAe9AkJI8Qa3b05R3EsTbPk=;
	b=24gKk7VsHIevUUpwFJMuWLqlF+q4XKGhaxpcylndMwiuyAhhMh359hspvZcNtdWOUCt6
	 Gu3HjHc/JkG8tK9XI/3CG8Q4YGueskwOJdFhl6fad9NrOw2fd8LMZ7fhfAIgIV34Rzu43
	 43G+IEFIqzW/rzujG5hXQMb5FJcD2ZuKZd5GDLQoRHtttCoFhu275yeiYygJFXfKht2VS
	 CGkKf8xswcMnxlRZu55wJGQdQH/+lsGCoMBF4kDCNP5Hd5soWo8ixz/2gnkGRdP1vrm+Y
	 g1dnU7DpRRmQrD0dNiySHCSbKTzG0uZVRM1bW3xGyk5J8FradvM07I5mxjiKb9irn3Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b="a0fRap/J";
	arc=none smtp.remote-ip=74.125.82.46
Received: from mail-dl1-f46.google.com (mail-dl1-f46.google.com [74.125.82.46])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27A9A60A383C
	for <virtualization@lists.linux.dev>; Thu, 12 Nov 2026 05:35:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 27A9A60A383C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=a0fRap/J
Received: by mail-dl1-f46.google.com with SMTP id a92af1059eb24-1a3c08d6928so6474772c88.0
        for <virtualization@lists.linux.dev>; Wed, 11 Nov 2026 21:35:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794461740; x=1795066540; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=7hT/gC85F3aW3pcczI8WvAe9AkJI8Qa3b05R3EsTbPk=;
        b=a0fRap/JPckonCQCnN7+hRiYOy/xWBXZ7XXHajmoQpTBfYMmZwOZLngzk7ln4tQ2G+
         QjJmq7pYfnnpQyqbRvPj0lLOyzejbYovG6sRaLmabujoEbaVnAYKerXHsLQ/FrY2YAkM
         rMqMsxQJCIQUEe42iADcerlDUMXZ4eh9XlvOcJHOnGSBP8UelLWCVW1afiffMSoohKgm
         dwoUkfNJIt0uC8HAgaDKeXDH6aUCOEOwlXuOUlIERewqkBCqFTjQ41lGQ8t+C4s1IgIr
         OvlAo8qVyPiNLmgM7pTAIaJrA7EcPGQo4ubgvxKekA7qDP5ZzPDtOrEWCL44Upy96yKu
         UPaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794461740; x=1795066540;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=7hT/gC85F3aW3pcczI8WvAe9AkJI8Qa3b05R3EsTbPk=;
        b=Ytwch8+RgYbW0+xvphVKHj0YK4CxPLUQzWL2A4N66D3ClyP31uvdORQKmM+A9d2PGC
         WSDJBUaxLdFAFnKA0dBUVsCESm86xRuKajksRJKyfcWJl7IsSHzb6aPOYTN0mAEpo+WH
         wQAnq3ma09CHut97/Nmgh+TFHwHv4bu/EbpYCQPTUCilXyQ/3zRLAg3pou/6b5ptUNAJ
         gURIwxObTExPxG4FexNxbY/TJoo3UhL6/EWpRRDUJLxHLnyWkMv/5hidpGJVGeLDQ32d
         Z8cmVarIwAW1tgRuVA93XUIk0g9JdORlnbqnhsZUAcZ7d+RsvmiMb3x3qyr2mpZyAxL7
         k12g==
X-Forwarded-Encrypted: i=1; AL+hErHCWwo6jGeczdgYulEo2BrrOgYof4rzzswhiAnDN/eskXYhWysopGz8Nzamdo18RA6RT9mG7aUifxhpZonXjA==@lists.linux.dev
X-Gm-Message-State: APuU4Z9XuwzodVnbWgBowd+0JWWC6qrBDobp+kBYGYUcuZXk3sJbDXtY
	xg77TwP9bwtxnxRZhhlKLYYmBvAXP2+VTXDEan7XCDbrPtzG4/yN7LHL
X-Gm-Gg: AYBFou37QGlcqua5o+PEunt3Jx1nL4a0SDL5WbR3NfJ1d64p1KnV7oc6sg6V2FlkWws
	rfGc2tsNrRYnLDtq2tG4i2Qgvn2WEKfuggmTtOUngZ9fzppd0yUQLWHD25m1Q6ehjMhcn9yzVw5
	L4ORD13UBtetwsT/8S9NmrtsYGLrYGgbH4EbGBgj+gv5BEcoNgDSSuR8587ZAO26AAkxoTwLW6Y
	0etpzt5Bace/xB4ceI47RNWGrrSBJbstMK+HUkjuM3WJm8xtMabyiiChVJ+K2HGo1qC25GptR2j
	3mYZcjnW++ytjAEVG3GDx30+3oOt2xoTxVBKXSlCboaUIYTfAMK0o0FZ+JPQU+SJpiH+Hu/om0G
	EpGq9FO3MF0LJjZHrFpH66c0HwtomwpnZy53mXwEYQ4DLYpQtZ3YGmmUErgL2zRPe5yaVCIkZrl
	uFE6oLOqyKB5fuKovV7s3SOLIfG1Navxsuhd3tPMTEgMyvE7I+Sokp/ouhAxxFNLQqviDsFpYJI
	oyo0Kj6mE1VW9+uEjNbDpqESGf1yIkEyZ/JTrnSMN/M2RBuAkwiHcBN9tlqlcNSE2d8oMhDzGV6
	3rcInlgqZKoY7kxG1tdtVp5dY4P0nuAr+3eSTXP9ksgukh2O9EzwOOIiSaGVyMq6vyNCrPb9we2
	Fbe526E/BWkoX9HcAG78hRgwsG+eDiGnjNsvjoBQrmFTMYPc=
X-Received: by 2002:a05:7023:a4c:b0:16d:dd5c:4261 with SMTP id a92af1059eb24-1b3c03767b7mr4301004c88.46.1794461740120;
        Wed, 11 Nov 2026 21:35:40 -0800 (PST)
Received: from localhost.localdomain ([183.96.175.225])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1b3b5890c0esm21953240c88.1.2026.11.11.21.35.36
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Wed, 11 Nov 2026 21:35:39 -0800 (PST)
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
Subject: [PATCH v29 13/17] ALSA: virtio: prioritize capture period work
Date: Thu, 12 Nov 2026 14:34:42 +0900
Message-ID: <20261112053446.73504-14-mynameisjune111@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20261112053446.73504-1-mynameisjune111@gmail.com>
References: <20261112053446.73504-1-mynameisjune111@gmail.com>
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
 
