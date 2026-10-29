Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.215.181
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793252672;
	b=x1XTHlw8mGFnlcAxorH4n1QoaW4Um7R7Tm9u2a65W4VAy4sqt+moIN5a0jT/63vnwZ0P
	 +RyC8PMa/5a5aRbs81bRf2W5SFRi+1q/gLmpyvJHQPiv6sWvtj2EFR+odaF0Lhvmmw/C0
	 mfx5MEEmyoCogTCGPeCsF3Fwen6UowBne5KxaWDKWjMC6pFlSmtzfcYHJ4UQwx9Ek/7wf
	 Ek3V3fk7X/V9C5gyCF3BS58xUN5VUooT2BGiu8n4u+FOtHz/fq9qEsdhbnYt03KxwbiDA
	 lUXa8KyipiP8xwIjcCk+NLbv11w5dbPYGU/qx+VEsoQBVevnqBXDxeE+yyBES1N6jjw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793252672;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=1CqVlBSvwYPpTYL33mCW1+ANjaMpjIs5jzRD0wJXE90=;
	b=Ne8fhrwayhjX7/xE4utdVb/YV7pFXHJQa0sLoXxPz8lZ0uSPZd8wXJoJMhBU2+6K43ED
	 0RhuTqBpCXRwAHVLElbWEYQMSp8QQidrhYpZRO74GUlnCDrtcw7HrSRNqiq3lw+VSm4KI
	 1gyi3aYIkH4OxgnO5tkJd8FfcNTeZF2GNhtkJp/WFQUfsAmA+Xfh/AXjyJGEF3CZ5W7j3
	 5Cd6ws4WvYmWrTSJXEem4jau5HvlLxT4teeHSk+WfI44Yl6OlAlhR6c0CB4SO3HQJwnc9
	 FfddONxB3W1rpntZBwAAsKv05IvW+49KNCWdAHq/0VarwKmRgM1+3yDDfgOIUSRCB4Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=cGJtAjKQ;
	arc=none smtp.remote-ip=209.85.215.181
Received: from mail-pg1-f181.google.com (mail-pg1-f181.google.com [209.85.215.181])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D166606A324
	for <virtualization@lists.linux.dev>; Thu, 29 Oct 2026 05:44:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 7D166606A324
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=cGJtAjKQ
Received: by mail-pg1-f181.google.com with SMTP id 41be03b00d2f7-cc4aa18f9afso825906a12.3
        for <virtualization@lists.linux.dev>; Wed, 28 Oct 2026 22:44:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793252672; x=1793857472; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=1CqVlBSvwYPpTYL33mCW1+ANjaMpjIs5jzRD0wJXE90=;
        b=cGJtAjKQhDFyfLA9RSkLwDMS+Bin9blyXX3Kyi993CrJiPaTboRG88gF45zMXNyZ/5
         foOqryqHHIQtdmm6MpXeO3JIVexr1tejUjRDFB4hs1AszqyXGKxZYbMkdi0e0ZynI6cN
         89dHFMA8BBMxTe3/VZ3SFcD5vMBczNyyi1ufP9htfbeXe+rbQ/+rUIkMgyPtLSEDYorU
         5Za+RkSRgSGfH71sQ2zHGk0WVup6fR+4dgt0Q2eoBbY5CouID6Va1nQeKZGdnrTQAQ3O
         9ZRZNIXH/L3SlyDhET6/YLXKyb+m5NfkZxzs2omVPboRgljlJ4FMRXSv+JXTXlvZsc0v
         5/jQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793252672; x=1793857472;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=1CqVlBSvwYPpTYL33mCW1+ANjaMpjIs5jzRD0wJXE90=;
        b=tFW1Blz1b65fhYW3mG2Yh3qDFVlE1aF5b4sslR0kiDatyvMmwHHdHsrYsm7p3zR3ux
         +GNcKqd/gvgqDho/o4tn7cBzzX7eNINexgAtI0whCz9mjI9Xq7zfS2Wlnv+akMSQaFgq
         qRAVHIdYjStZI5k3gphtyYeDnBuC2cKd+9SRPfvfmPTCJXcT6TldoWmaUQcdlZFZAsjF
         /3P+/PeaOiTc7eGFd+k7PG1PBqxHqvb9o4Xi3xUfy0yKSbTLRwl4wPCbKvmUQ1fK02gT
         LcRtGZOQ1T9Fj0CSdN0QOB3pwsS/l34+WSxLW4APhkTjmNZ/EemnF7vfpBQYGkpNRwwL
         n7vg==
X-Forwarded-Encrypted: i=1; AKwUvBw5PfeMtf/+k5p6H6QIKYNag2Hc84dKm+BDgz5MaQ1JItnQAYfYtPcYW65ArB+3LJGGawvdjeRO/pa0BQfW9g==@lists.linux.dev
X-Gm-Message-State: AFq9FYLzKDbjDn60NYiDFBOSvAQaWXJE+Tt1EM1cTy9bYmFutAixQlZd
	ryKYtimVxugTZ3gaQi2b081G00LEROf7uxCPfZYwULhhiHfBCH2ksw42
X-Gm-Gg: AYBFou313iSbTqPLcGem9iZnsc8155pLdp1+CE4kstk3ux8lQtSur+VFTgo1406jibr
	za4gWBsbNXbmL0e0YPgL4n8huhc7dMVShtX1Wb0rotQ/LNbtfza8FWcUvihYPIKW9xkdpbxdsaJ
	KmeOxu1iLY2dqJisHo5zGBAN75u6JXhs3FlL+EEKYkGyaV32Tet3hEoEEntK4veIsE0RbhBvohL
	4KO4yYgyYFpqykFKFL8YGabRuqNDY6jac6gr7+E26V+tSKt8EAMqhpnThTZfsy2fe/6vfOPV9cb
	in90FnHkT/aTQnP5PE+xSYOszaSAkSvVoQinp6wEdDAMd5wPoUScCSg2VN0OSlgIbFH+3YcOVr4
	4NkVI8sqG1pyqD8CqOM+2q4cto41xG3gKSiSuqVXcZideuKHhlJ6BVbQnxhDNRZ9ZVzVzNn/6se
	rcHn9vN4QO8VqVPsvLGsCZ5WpJZT3s8CQ3HYqhx0q9g8KGVCYnFFbyAdK6jECfPZXOmVPwp6n6o
	fot3uq7C5EUsLloSjX85Ll0nVkWK2h+YjWLy8/CZMwHtL4wAXMQenkM4+1E4LgAxnSQJttb3TdP
	i3miNCwhObx/njnVBPFBO/iFO2StT42/GDKTKI+Te8Nj+W7KVV7LHmiFOPxlapA69T+/6ahDfwt
	mh7lFWAHQFfWrkbeqH1n8Hr5PYxtZ4wI1iVoU1xzy9K8NB6I=
X-Received: by 2002:a17:90b:4c81:b0:3ac:9a03:20bb with SMTP id 98e67ed59e1d1-3ae57f9b35emr3665083a91.18.1793252671816;
        Wed, 28 Oct 2026 22:44:31 -0700 (PDT)
Received: from localhost.localdomain ([183.96.175.225])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3ae6e83127csm2433520a91.10.2026.10.28.22.44.28
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Wed, 28 Oct 2026 22:44:31 -0700 (PDT)
From: Joonho Lee <mynameisjune111@gmail.com>
To: linux-sound@vger.kernel.org
Cc: tiwai@suse.de,
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
Subject: [PATCH v8 08/14] ALSA: pcm: stop paused streams before synchronizing teardown
Date: Thu, 29 Oct 2026 14:43:48 +0900
Message-ID: <20261029054354.2931-9-mynameisjune111@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20261029054354.2931-1-mynameisjune111@gmail.com>
References: <20261029054354.2931-1-mynameisjune111@gmail.com>
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

A paused stream can retain outstanding driver requests. Moving it out of
PAUSED without the STOP trigger leaves device state paused, and skipping
stop_operating prevents the following sync_stop from cleaning it up.

Run the existing STOP and stop_operating path for PAUSED as well as
running streams. This replaces the earlier v7 proposal which only marked
stop_operating. Drivers now receive STOP when a paused stream is dropped
or stopped by an error. The change affects all PCM drivers.

Playback pause/drop/prepare/write and capture lifecycle tests exercise the
change. Physical drivers beyond virtio-snd still need review and testing.

Assisted-by: LLM
Signed-off-by: Joonho Lee <mynameisjune111@gmail.com>

---
diff --git a/sound/core/pcm_native.c b/sound/core/pcm_native.c
--- a/sound/core/pcm_native.c
+++ b/sound/core/pcm_native.c
@@ -1607,7 +1607,8 @@
 			   snd_pcm_state_t state)
 {
 	if (substream->runtime->trigger_master == substream &&
-	    snd_pcm_running(substream)) {
+	    (snd_pcm_running(substream) ||
+	     substream->runtime->state == SNDRV_PCM_STATE_PAUSED)) {
 		substream->ops->trigger(substream, SNDRV_PCM_TRIGGER_STOP);
 		substream->runtime->stop_operating = true;
 	}
