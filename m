Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.215.181
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794464742;
	b=thWTS2FaNv6M5CpwXLMgXpJiOVkvz5A0+vHWUY/hnrMP54cYfN15E++PT1hqrY9j0P8Z
	 td6L8DqBkAmFTisrHLkpxkSUvFBqhyKtnEP+tmVtDAS5fO9UP50ezP97SR2RK9bVR2bBz
	 sBLrHqooyRla0Gmba1BNLutqm/3b2e9PYD1k5ALaktdbN10AdnN3bvOc3gJBMRB6Q1ePh
	 aUDhJo2bFeZGhpHP7m7Q6xVvIWIUoAs+4LmszA7XlV1HrrtVNSAU0rBtJTNTXOrmXEylk
	 MrShEO/k/ODhoULv1dNbXorVTFJ2WyaaQbHJkKHH6/c0XbLX4xgxI8UR2lmv9clzX5Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794464742;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=7hT/gC85F3aW3pcczI8WvAe9AkJI8Qa3b05R3EsTbPk=;
	b=i49OgxEqSwbiCHP0eIhRDX40LaFmFRUysP7thBdaiofhQEci/NWMesZzMLYsKLBzGxaf
	 gE1BV7IsPjcr7ZXE+RZ0Vel73JmP1dCgPKYlijk1BYXyA9EesMThfrKxOpPAqyppQUXy3
	 Dl66PaaLlJqbUJOMEIFjrZAFU+Y+esSXmN501rCBqIsx9HiYdi0epZ1P49BVYT8SNxh+F
	 /FvFe9yHjZp7mFoBef1NFChioJRkXD62JYH1/lEEDkbSzQTB9n153Yr7aaIOsWNlZokWB
	 ODdo4uVjlf7Mqk3hAbwvlaXNDX42L+WMjK7AO/c6AmwU4y0QULtBRWPtGn8F0t8zf1A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=khE2L1gv;
	arc=none smtp.remote-ip=209.85.215.181
Received: from mail-pg1-f181.google.com (mail-pg1-f181.google.com [209.85.215.181])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA68E60A381D
	for <virtualization@lists.linux.dev>; Thu, 12 Nov 2026 06:25:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org CA68E60A381D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=khE2L1gv
Received: by mail-pg1-f181.google.com with SMTP id 41be03b00d2f7-cdab938dc83so1569318a12.3
        for <virtualization@lists.linux.dev>; Wed, 11 Nov 2026 22:25:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794464741; x=1795069541; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=7hT/gC85F3aW3pcczI8WvAe9AkJI8Qa3b05R3EsTbPk=;
        b=khE2L1gvWVAfwb+cfrwtg1Wat+nK6S44CEDhRbY4mGjyPy5dMpqO9B5v6lFeHlpgCm
         xvoEi+YI2WR03kEBZLoe2N83LiBudwGwpTJpoefiyHGDyhNiCAyFRpwCyPvEuLbv5P3p
         pHO/05G0ov0+Sr5oGAN1mjcfJoYtfvO/fMmnDZzj9vNOrsbknKVsB45wWgloJmkhtSIG
         OUp+jQBKlJLUIR2+4kZzGYiKZSPFn71pF4ytvKaigRPa6tOvHJjRtC89VQ5a1h0C1YTC
         zPCxSqJtckClB8U2fYQkPozLFWznkHd7X42cvnAH900aggOTBmzfTNQsLr97eEmD7FKy
         knXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794464741; x=1795069541;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=7hT/gC85F3aW3pcczI8WvAe9AkJI8Qa3b05R3EsTbPk=;
        b=lNowiXEgg9NxNKQcvQSBMQi33aYZFuw3lWJnVwtyfWlK5/Mrg5UcS8w18stiqmdbrg
         lfGjiqwHby2FCJLQH3bcBmndFGGol35rb2ErSsMIhQbMQyPkBEDMRNyIiYZ7rsjeLlwM
         NXURSJOJdo7/gXC2qZDQ2gO992KyJw+2s6fadUgaocfLIxightPD5hdsEs85It7qM1id
         RWkZtC7wv7w9twLAx1rGhreIFjjitqmQVnBYzTpgN3bzT/KVWtRBspgcy9DajEN71mNE
         jXY46krN4nIUZ70d1JDBrOOn318kIeX/zMsCq16S+H2Fp//Q/G9Rd27r2jPCyeRLl+n7
         /CtQ==
X-Forwarded-Encrypted: i=1; AL+hErFlpb672j8hZbe5BsLNaAKQ4p0m2/r/K85lRrd9AjTZuzBvIxnG/hpZVJUN9dZnz8l2Umu9+FokAsdv/F6Bzg==@lists.linux.dev
X-Gm-Message-State: APuU4Z91AqXaVh4RY3hJl1QLXn8D+0+olVllVzDHnofHfM39vkhNvMpg
	uetAKeFkw2+YVj/Xen5sAIBfq6enKeCCq90Gobxbb9WN4JBo1+bM84D7
X-Gm-Gg: AYBFou0hJXBcHt2K2vXaVMD3gLHb/m9AMhSw77ndw+DNVTri7yL4fpjw72kost7YgjZ
	+jR46SrgrpKzIQcj+bqyRonCwbdEXwme/U2hWM9xYM+WmKTcrinO9ihtqw9KRDWJbbEv/ZLrMOq
	oQXq1A3bLkm8TdftC9OSpgpnS1PfHestqeNilX3e6Lke77ykMFaYdF4yHveiQLqQWPo37TWltcu
	IYeB18Nxim0FubI4ngUff3QyP4A7nzKex/O+4q+SuQeHHcCGNk7TBuEwRse0j7kFT0HhWGgL6kf
	PzB9mrb+rLv45kvp+ddjDOufO5qhf9rg/yo+Oaf0Mf9RYcpk7w2Nn9uPI8J/g6M1TvU1MP0bv0K
	Ah8E0uaDOeDHH69JC1NmD6ps3juhQCylnclb6Xm3A1ZnywYTp/os1+7kvEftD98QtyqynqaDeey
	z+S79Z4dzE0na5kLSIRz9kH9eZKvB6Mu2J7Lk4JuVdG8RqCKXkUKAv4xRA8Mob3ZGmlJbQaExbC
	CdzY7iY/X4cv99gB5Tth7d8InGEDgFh2iWcYWv64m8vKNjEeJNezoKcnywSDUAXq/f+Iu7P8uIU
	StUMXXpMzw/O2tzb5H9kKACDXKExrn4qEPN3XWx+o4TP2R4Pbtx6zMdjupt2ZiAw2NHUOZEfeTA
	6Ha1x/SaeOX0HXldfWPQ00sB9kr9WwBmwUrviDfq9a5l10KXfahqI/BrYw3CST01UjK0l
X-Received: by 2002:a17:90b:224c:b0:3a2:b16d:928b with SMTP id 98e67ed59e1d1-3b182f86a71mr4580741a91.46.1794464741228;
        Wed, 11 Nov 2026 22:25:41 -0800 (PST)
Received: from localhost.localdomain ([183.96.175.225])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2edb6a3e61bsm26979965ad.11.2026.11.11.22.25.38
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Wed, 11 Nov 2026 22:25:40 -0800 (PST)
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
Subject: [PATCH v30 13/17] ALSA: virtio: prioritize capture period work
Date: Thu, 12 Nov 2026 15:24:42 +0900
Message-ID: <20261112062446.159-14-mynameisjune111@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20261112062446.159-1-mynameisjune111@gmail.com>
References: <20261112062446.159-1-mynameisjune111@gmail.com>
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
 
