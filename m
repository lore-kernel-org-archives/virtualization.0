Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.176
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794267698;
	b=JQJoslv/iasE2ZT8CheoRvGDd8rPde4XI1O9kTWxOGNmyhK9Abe+pcIPHlqGhciA9yxC
	 DN9sI34ml+mxyW3SeeFYcUjWYarTob6mPYsCit5fMM/LrdOIo0k/h5Cfhl4sLNW/1p5oU
	 lCgrgX81XBEiZ3KKyQZnGizmFmTJPMS0GrGoKlc1WxPk9wxIkhW70SxSkDBcE2Eiw19F2
	 vRVwLFdHnhqpMxyfG+CWQd8gepMbV9hlN/nosHArNTUxab/kgPgKJEBW2K6LgZl0Ncj8i
	 OZgTqjaydilFZKNBMZBfRjy2LeAu19ZEe9T44i8nsgY7WNabpyJ190IX9wKvZ3jZa1A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794267698;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=KUS+Ir6AKhedZvMknBQeS5+2Kmx5A0on8+pAmR4lTW8=;
	b=gSpnobR5eylBYYzz/PQRZ7jV0NszAvjCaPT8A+HG0iEXa3ciqFbl31U2qVggfswmbmKu
	 q0W6Jf1p5uaeQYyhDLDeJ2CJTLmOkVfa+qRIkPmN9HG9Bb+AtPTm2Vuj39327swGmBEIA
	 ia7CrrcswioStJRKVyygZYEreTBImo7RgYEwMVWCpGuEMWMhND04KCii8BM0B+u2kG7FJ
	 /qimOKuXRgqGAgXXHswJ3CYL+CXZL7xM9CirRkE00Mbfg/TvEWxNKomAJ0/liZQS2bOHY
	 MRrJ4QkhVs3sFyF7o9RhlKp0EIDr26nfJU9WKXZO/rDX0gXr1NfsEFYTjvx3ytrFmCQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=hGXizACA;
	arc=none smtp.remote-ip=74.125.82.176
Received: from mail-dy1-f176.google.com (mail-dy1-f176.google.com [74.125.82.176])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8840D60A3827
	for <virtualization@lists.linux.dev>; Mon,  9 Nov 2026 23:41:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 8840D60A3827
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=hGXizACA
Received: by mail-dy1-f176.google.com with SMTP id 5a478bee46e88-3704d30b84fso1820502eec.1
        for <virtualization@lists.linux.dev>; Mon, 09 Nov 2026 15:41:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794267698; x=1794872498; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=KUS+Ir6AKhedZvMknBQeS5+2Kmx5A0on8+pAmR4lTW8=;
        b=hGXizACAG2lnhh8C66NMRKQp8jsdQo/KcRQ+KhRWyp3KMB91elx2yQ8A808rthUhcB
         6iHIazebn2jWcrJt0OUSvByuO3k3Q9YnWQse2D0KjkUMlReeQ6Whj1a3Ggj9OnnQ04qj
         n1XuNsBMTyRlP9zlgNBks03yMYM48j7Y2QO6CV6xUkbkxZfnu8fDTjJc/X28zQqDDdfC
         1kKiNYfL7HOqT0pLGfbyKU9qc75DSwLlKQ1MDN4JJSN4H+UTjzErSApV1Pl1+yCD10yF
         64FMzzsI6gX8J6g4Ixp0B/8b1Npg2F2E127BwYhKIY8LiacysW5RT4bDAOo9Ku7az+jQ
         vtlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794267698; x=1794872498;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=KUS+Ir6AKhedZvMknBQeS5+2Kmx5A0on8+pAmR4lTW8=;
        b=QWNdIFAbIHogQaHtSowA2detDVxLSNTfigc2CIJvKVWtWxui/M6j31Q3ib8KE75bZn
         rkrPFuR0sg+NUD8EooUEp85CHTmjq07OdYRtyVuDKFRMlxIFpdFWk0Qpy04+elVNzNDs
         peAKS/ZGZDDUJCXYvcQN8fkQN1HaY9pQgssUBZkcYwle/r4/uOB2ELgRQsldDykga2q/
         g89MhRZ+0ULZxkbGi9vniCaasEY/TeQeWvncLmkhm9vZKqivwyeEhAXdnwEQxSjIvkXs
         9/Ft8C6SFukWuTNXE6IpaF27X2ldquaiWB5M+THaP6wwX7WklU/ou1tsH8N5Knx6Yh2t
         mxNw==
X-Forwarded-Encrypted: i=1; AL+hErG/9FgzE0xkhClfsvEQwZCGLPcM86/SWtECqYh7+kfhG98SRJp1bR3oeHizeeRCE7AO2CVmbCifehMC1J+qWQ==@lists.linux.dev
X-Gm-Message-State: APuU4Z81arXO/XSkoxwIQXg5PZGBmy1L3QCX8wSTXLB+TKqgflNq1d7f
	SlPOXZoqniwODOmDuI8AAZFVaShJKcxDPB+r+BdjupDQAT1n2OZAMWBx
X-Gm-Gg: AYBFou0q6We/gNntyNYgm1PM13HfaBVQ0raQxaLrLqZu4L9PYmUX7vfMHdKcP0ATGmV
	6+GWUOAwqQ8N5f7Kj6nss0+hwhX7vVfoWWAgwaYBPPj7SHOfHjUFfXCpQHN7Mr4jPnQNwwjRId0
	y0+mlohaiV0KaTjt9COqmIatt87cWumPsxMWEaxxHOmpYEpdoBzVNjaoaaqFUoEdBz9dRkyr3DL
	o0cSjJrR9uggmPG27PmIeoOUnEJUI5Tnrf81FnklPMtio5+abNsE3GY3dkdiE5WXEqs/GfnYXbq
	NmLf5DRzp/fni7lU1iRWi680Q1LCTOIIyfzc8wAdQajmaO6hm3OkbVCQQSSj6TctjYJryH11rGe
	hx7jw1174c2PlN5NSmU5fKm6QqMcIOig3sbsm8OFkUTsKXp4/1BQCZecIRyJOJAfa1/leHBRWIe
	nGHId9kQggcFNz8BUX5aEgxoL7z3oIKlhSU2SdNduNyzgzPa1m5uXL+7747gpxo4M14DskdQCKI
	LH5v4ZWisZInxp+QxdcWfv0p3xNpspxtXNAzarIgnoXQmj8zhNRVV/r2zzgpXynCSeC5naD6LRd
	miod5oki5/RULb/7xRUfCCbkqv7Eyf2roTWinP67FMoMbOWCYyaBueQqQCzgnxuILaxtVAZ1x9f
	FYSXYacuwHDiJxH9HzBciozSfa/FMMDDIgAFmkBs+0N7RoQuU
X-Received: by 2002:a05:693c:41c2:20b0:36a:4ea9:19ad with SMTP id 5a478bee46e88-3751eb8db6amr975022eec.9.1794267697349;
        Mon, 09 Nov 2026 15:41:37 -0800 (PST)
Received: from localhost.localdomain ([183.96.175.225])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3751fe2ff5dsm1739049eec.5.2026.11.09.15.41.34
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Mon, 09 Nov 2026 15:41:36 -0800 (PST)
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
Subject: [PATCH v23 13/14] ALSA: virtio: prioritize staged capture period work
Date: Tue, 10 Nov 2026 08:40:48 +0900
Message-ID: <20261109234049.79534-14-mynameisjune111@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20261109234049.79534-1-mynameisjune111@gmail.com>
References: <20261109234049.79534-1-mynameisjune111@gmail.com>
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
@@ -168,6 +168,10 @@
 static inline bool
 virtsnd_pcm_schedule_period_elapsed(struct virtio_pcm_substream *vss)
 {
+	if (vss->direction == SNDRV_PCM_STREAM_CAPTURE &&
+	    vss->capture_staging)
+		return queue_work(system_highpri_wq, &vss->elapsed_period);
+
 	return schedule_work(&vss->elapsed_period);
 }
 
