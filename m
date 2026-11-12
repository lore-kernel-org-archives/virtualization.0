Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.178
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794461748;
	b=P2HIdIMHOIEMVoizulFIGr+1LIGvmvGDStoOyP/4GfoK+m9HKY8WyI1WPOIz05BwPgPd
	 NoKH4srL8/gQzbY8Aa0ba5irc9aTdg32rY7+wD3t6a4lu6sgjThLza1ufsoucP+24vdKM
	 tgjcFQJIwX2swCWjHf1hM2x/2yKkZEY0Zy0/V9HO+zl5xTADwhNlwnhO+PFTJVXFPv2Nq
	 lj6pPjMxNy3PN1GChYgVIHIoV1cu9yH4/ZGKd8DIeHQ534/PC9KVn5RAbiza0oy9KBrye
	 4n/UI6d83le+Ax9Do/6pT/N1sTG9JNgM4l/KSQze/rtn1o+8s7z1581VZW51RqKs/aQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794461748;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=928OJa6yQ8fSO4+CgmYur7LQeG2ExiIpndY6iJl/WMw=;
	b=pvpzQ0BEE4oJnKhMwvAt1W4j/LTaiCVVB6OkUepDV5nLQDhnVJaIaB2b7eNyP+5wQ2/T
	 k6PNE+abB3KgCt2U2oWDMImPcqgFCMab4k5CaLc5dH3HwkKTjvT6YUChJle1evGbA0tEt
	 AiJtNdiAeEUXPVXUboVnuceXKESQekE4aKvSTj8qp26ReLbyDYnHDHhejZYpGIO0ELSbr
	 r4rjutjEd6gQS7j5mbKzRXSYViYy7GQtRlw1qieGpsFwlU+6jgdlDAwlHTKI80MPgB9RB
	 65+kMi9TMxGsR3KVD/TMwMHCR5E1LJei5B/E/tKy0cInw/yKj4ub58aL8A1bQoLi+hg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=vSGCHSCk;
	arc=none smtp.remote-ip=74.125.82.178
Received: from mail-dy1-f178.google.com (mail-dy1-f178.google.com [74.125.82.178])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1E2260A5BDF
	for <virtualization@lists.linux.dev>; Thu, 12 Nov 2026 05:35:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org F1E2260A5BDF
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=vSGCHSCk
Received: by mail-dy1-f178.google.com with SMTP id 5a478bee46e88-3720addb068so6969768eec.1
        for <virtualization@lists.linux.dev>; Wed, 11 Nov 2026 21:35:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794461747; x=1795066547; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=928OJa6yQ8fSO4+CgmYur7LQeG2ExiIpndY6iJl/WMw=;
        b=vSGCHSCkrPs0vnQ9+zHAOID402sjkRJ5QSML8/OJtrwTGBLgt6R2d1ZJs8jwnE9smD
         7i8jsQoASLZuDxJVrLU7HG3Pw8rfEQWoaBzFcBb2JTTV4KEUOKPyJwYJ1qAbIsEVpxvx
         sNiApszUI85stVryQubfON01q4h+mU4R6/kv71vrR9NXy0ziqodlTNJF8hamK94an4gz
         SXaq3tfcLJSl+HzRPcsplKniXaqefNgP3X/uNU5fSJq2Hkc27wbdGeRgET4LYJSdw0NW
         m/BZhTAF8xDqOGYM+iPk/apDS4sS8Jh99NiYXjKEcl4KdjGyYMirqRYVUMMmB0wXwjVj
         N8Xw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794461747; x=1795066547;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=928OJa6yQ8fSO4+CgmYur7LQeG2ExiIpndY6iJl/WMw=;
        b=az5GH37yBmdjTbLyfrFn+zTXDrph+ZtVDitZl91c+DvSeMaRR9IMWZrtKBHb5PT9Ys
         KUHdA/jyhHpk8t3zNxKWLZJfHr5/tue7Us/PTuMbe++gP8uhJrDk2MMJQ4gwTglUx6Si
         +y1LWBQhIWB2goj7nPHq/aH99rkERwZq9l8Blhu9TKXApAWrSrF/30+N+YQQbDC9LU0Y
         k+tPtK0uZchJeo7vMSJhhu9IUafIOxR6r/l8JHuNHl4DqXzz6/M5RyVqghDDbBjFHSqY
         XC/GB8y1PikVztk2RxMaJZbqRBsqglqHYZisr0PCJPsHG3Q8EDCuEPZHi77K4ReS5wi5
         Tfgw==
X-Forwarded-Encrypted: i=1; AL+hErFLBjKzwbHveI4xZqLHjVz/n6VmipH4WzMA/t2KrJaQTCGyo+Z37VbV4nZZUCgW3vQDPMSWauZFUNzE5C7a7Q==@lists.linux.dev
X-Gm-Message-State: APuU4Z8O7ZP2eBVt89uKs9tnDz0yLfUm87KC6ubfm3lWyGhVdPNEJD4r
	hL6AM74WGe07GqbXVFaE2ypSv5eQburcXlBfEsWbQbtRm749WmL9kMDR
X-Gm-Gg: AYBFou05CTBVcy32MP3yv4Uezu7dRT4reDZkXnrSdy2j59kqIsQYGn3eDlD2yNWrJqT
	ukAFSvMPHCQphJB9KBzPLH/qbyaTpaoFvGiAvY/BP3Fq64v0/1tpJOXUtanseMlVd3gAdeeVM+v
	fWpLKBASN4+1azVG2k3Fk9lNn1626qsjQjyM4apJpiwmWV1EIiYWt4JVIt/3JJcZx38FjPqOreQ
	JbnDJEM7KzS85zt/roigucX3CeTOb4QpvuapOSkLKrPsW50Edh15ZKI0drrhHX7YfnpUDuP+zWq
	YZkbzTdlRU3RvIgjz1BUIBIU4gaMWcJF9PkX09RW+bOKYMW2OHOUmZFHNO+5WmN0hWfoodpe23Y
	VrIjrYc6JyvDcgvNDYrtjPlgo9cjFN8vPl8rMVhOhVBttSOQgnOziYmnYYiUYH4P3tcAV8ISg3v
	qQsHEahm8TGJw1C2Pn5+IETKJdgKD6kGAaTLt6yEXiPA0JCiqvWEajEml1qF/GVOB9FkjE59FBm
	djRCh3zWjrRT9mg95fH5ORXlxPF87lChG3Wd38vdyOmS9ns3zwJ/9Vs5uS2xnR1qQbbzAx+eeYe
	8UdwEnKypMMZGTa7nNLvWaOrVbEUBP3MFsdLGJkFozqlYqLOHZJzSYo1aY5FyrfhgPuRhzoOV/c
	4o/JEa+fsBQ07z3s1Js5ig7Ak/PtbNKj7ZAwt6sV+blA9HT8=
X-Received: by 2002:a05:7022:7e09:b0:1ad:4ef5:ffed with SMTP id a92af1059eb24-1b3c0392172mr4615594c88.38.1794461747161;
        Wed, 11 Nov 2026 21:35:47 -0800 (PST)
Received: from localhost.localdomain ([183.96.175.225])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1b3b5890c0esm21953240c88.1.2026.11.11.21.35.43
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Wed, 11 Nov 2026 21:35:46 -0800 (PST)
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
Subject: [PATCH v29 15/17] ALSA: virtio: reject invalid playback completions
Date: Thu, 12 Nov 2026 14:34:44 +0900
Message-ID: <20261112053446.73504-16-mynameisjune111@gmail.com>
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
@@ -1011,6 +1011,17 @@
 
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
