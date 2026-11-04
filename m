Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.216.51
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793758712;
	b=CHMF8kYH/LPropmZ3v1ictXTateMeiey7KHcSBACds5WAuzFE8nRzrD9NrWC1zQDWOFR
	 rnKVvWPbZZ/Li5Ruqby2RHnPj0aFPwIHI3z1eAROFlL58W62utjAD49DSm44hRuHqRzaQ
	 ajVXlw37wZHhWnOa3Fy0+0TWxj9oBDZAT+1xuTwp84iaCwfgcYoUBe7W6Xp/RXfUCACWm
	 QXbNjFcBojemdXaj5jElUok4SeCjca5Yb7mTHEW64z8lLAv3IFrrM0TlT0VDR5rcgwre/
	 fxIf8XK802YnnUloJnlyhgijK71NchDcYVVBBPfMUNnTVutTtPeIDIq/cHg/zKbk7cA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793758712;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=ND/K4UdIV95I9PJFcgncTwO/Ff+v0DFt7H1UGo6AynY=;
	b=U+JczghIXGcxnVaETXWJr3ZwGyM0+EsNjvQUNWsxBQLM4LazOe9IKHP2gwvP8keJEXCo
	 gaf4pXBL+4dH9xxaXy/kHmhtE3IlBGAUbRUAs+0GJ6lV3FiYaSnC6tiGH8Dzx/jOhu4jE
	 0Z3hbnq2EuWb8RzkF0R5slzeFRoDG1FSxLu4B8F1Qa0xO8KGgiyGwRB1XOy79jLiXpTcY
	 SYjDxKTRgUNFFzNw8/SpwmmThZfwxE228Y456G8n+Hp2jI3zB/UaIRP6Au2Nbp4yniu5f
	 9DOs6F/yFTEKJTCVAJ6iBapcuXWwvkF+fOmD87l85XJdkHa9i4RnuiYeVL8ghN7YZpw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=0w1tuqfQ;
	arc=none smtp.remote-ip=209.85.216.51
Received: from mail-pj1-f51.google.com (mail-pj1-f51.google.com [209.85.216.51])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C0DE606A33B
	for <virtualization@lists.linux.dev>; Wed,  4 Nov 2026 02:18:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 3C0DE606A33B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=0w1tuqfQ
Received: by mail-pj1-f51.google.com with SMTP id 98e67ed59e1d1-3ac9f49b984so82660a91.1
        for <virtualization@lists.linux.dev>; Tue, 03 Nov 2026 18:18:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793758711; x=1794363511; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=ND/K4UdIV95I9PJFcgncTwO/Ff+v0DFt7H1UGo6AynY=;
        b=0w1tuqfQwtgfcEoAWnjxavHHRLwLW4JWnP8h2fIxEiuVzJbXXEcFkUNCpZpwTwzto/
         QgNnPuJwF8KyhJ3D0uJDE3dyAPNEdQbkK28FQYsIxq1DfL0RN4dhXnus5AexyxqRf3pB
         JTswsohhvqUugHHUDpPq81N+I/0dd+h6wc9GkWwTUjLP5ZS6clO8xNIF11yfK80AOppt
         wp8BguV6HBSN8tPzMWYW5+qxzqN+roYiRy6ySp3DA6ZScUd1DicOn0IrbgtnaKPtGlAb
         6H4MdZ8p56xYH/Eza/88gan48j6aUPG5UvaIU8gu29yt514lzGKbZeEJa15dg1xVyf5g
         au+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793758711; x=1794363511;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=ND/K4UdIV95I9PJFcgncTwO/Ff+v0DFt7H1UGo6AynY=;
        b=zmC0F1KPHUs8aVflvjw8HMoAQvMmAJfdW4LfKUh9+fAW0zCntFkJKqsYmNyeD6/wMY
         eIayVzkllmBadivQXa8GpAlTeC3lNGXanJm0aGX6KtVt4xiUYvfMzVxVsLmyKCd1Siy0
         TsvGz+/EDpPUVttBHOYj3jeJqGvtnaISmmImE7HbnpJnVZ9DMTZrTgWKLm2EQekyoY71
         uwl8rAQD5MQrDCn8arx7MuXfybtHiq16b5Rq5VqD3uzJ8ZXzbL7n2qDLkGDyQUhgZIf+
         xpt1VCH6LLf8oscBljOtI+PRMKsK0w9xF6GO8fAYl/FLIs3Dpb1qKlHpEMy4xu1K3N6W
         65ww==
X-Forwarded-Encrypted: i=1; AKwUvBxHMt0RevRAbJ0havzk8FdkOn8hjU2W4hMzfZQxS2un3Hcc4Mrey1zoqc3e4mEMbAaTpn+klMg1hafwddb/zw==@lists.linux.dev
X-Gm-Message-State: APuU4Z+9lhrzCDyAgII8mX/xLk2jzP5sfQDFxIFDaNUHVElf8yqCjdmO
	1Wa7PSNj0NOOBE9TweSbgm0nLW+eXLPvi3Yg0nhX30z8dFrlGSK5Fp1y
X-Gm-Gg: AYBFou0mZttO7BAA9RvgYoo2gG8QiBK3LwHLU1VmffkEkaZCdsR/Ou8TPYXAJ68Avz5
	T3lKaeWqWHHUO380ghZ5S6XdUAf16rTpZoNeNrU79QZNWGLpaOu21azuMT9PcjDHo4lQ4SEAgTR
	Z7gf+uQBY06EFskFHdKq8uqmvE3bk04h5OxHZ2szsITB6QapUxNehkclXw4BF0cjLZcJRZiCTzL
	x0+9zcn6WT+Ekb3zJSiW2GJzDdhu/RqrKMJyB+vjjP1OEEbdRa4LwYTIHXaxSLl/vPQkzOEtj/c
	M/2eIRXIAIBT/q4eg10fgpugGZvbXDxuDJVQpYGgDmLg/D2URRunqTEo44F3QgBZBRbYVUfuzR5
	IFzYUXCaVPrkLIizFB4m1T0a4VByZ4iT3BHcLKgSt/Sf7obtJjMJ/s57Fkbc/IB4vZ5wnyD2BkV
	YHuqojJmZEGI2EUXxwnEb9NeT+Cjd2AQNVe8XrCkG+MZitEE0KL3hgxx8j61ANylUQyaIM3s1zB
	fvI6tKNekd1xt2fw3JwqMugv5GJxxwA2AECJlKB/wRM6XWDYLNas5LtrPs3KxNr91+0UrbcT9v/
	n6wkQxv4muCbZc+lS8GVo7AaHiMwBgbi55sVeZvYS46H0uRTSNyaDctSwY823e30KLuP8I+hnDy
	iYlDVSKZK90BENUqQYFV7+dUpFKyz6jaEArvFyszKjD1dG6Y=
X-Received: by 2002:a17:90b:2692:b0:3ac:92bb:cabf with SMTP id 98e67ed59e1d1-3ae6efb54ecmr11165443a91.18.1793758711475;
        Tue, 03 Nov 2026 18:18:31 -0800 (PST)
Received: from localhost.localdomain ([183.96.175.225])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-cdb46326f8bsm346131a12.0.2026.11.03.18.18.28
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Tue, 03 Nov 2026 18:18:31 -0800 (PST)
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
Subject: [PATCH v14 11/12] ALSA: virtio: prioritize staged capture period work
Date: Wed,  4 Nov 2026 11:17:44 +0900
Message-ID: <20261104021745.57733-12-mynameisjune111@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20261104021745.57733-1-mynameisjune111@gmail.com>
References: <20261104021745.57733-1-mynameisjune111@gmail.com>
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

Queue staged capture period notifications on system_highpri_wq through
the common scheduling helper. This allows capture notifications to make
progress when ordinary workqueue workers are delayed by CPU contention.
Playback and ordinary capture keep schedule_work().

This preserves the existing priority proposal without mixing RESET or
lifecycle changes into it. It provides no hard real-time deadline and
cannot prevent a userspace reader from overrunning its buffer.

Assisted-by: LLM
Signed-off-by: Joonho Lee <mynameisjune111@gmail.com>

---
sound/virtio/virtio_pcm.h |    4 ++++
 1 file changed, 4 insertions(+)

diff --git a/sound/virtio/virtio_pcm.h b/sound/virtio/virtio_pcm.h
--- a/sound/virtio/virtio_pcm.h
+++ b/sound/virtio/virtio_pcm.h
@@ -169,6 +169,10 @@
 static inline bool
 virtsnd_pcm_schedule_period_elapsed(struct virtio_pcm_substream *vss)
 {
+	if (vss->direction == SNDRV_PCM_STREAM_CAPTURE &&
+	    vss->capture_staging)
+		return queue_work(system_highpri_wq, &vss->elapsed_period);
+
 	return schedule_work(&vss->elapsed_period);
 }
 
