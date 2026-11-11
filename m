Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.182
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794365876;
	b=MU/YySKh7iN5LDmd0wuiQFcmZCb6KGEWNK0b98+iMWhukmMA0fx4quqZ3bbOubaS/Uv/
	 DM1/tCrouLr7gStFkBv3Ty3bH3qT5/ik9Wn9qPmnIbePkOyNlLAv8iB5por+LiCDDzt9a
	 Rq8vJaJq1c+WzwTDP9XkgyVYC6Y7oovAOTNrmw0WSqog0tZ3ivJT3GhOiL+GtRD//Wb6A
	 NUsoFZvs9Ut5P482gww7HCvUlly2Kq0h2I8h7Li3fe//tUoGjq5jsss6SYF7xoyk/RHUs
	 mmVJZmr+omcaKHPXj62qsHBJQ8TXlcYpvW2JtssQyzJ1l2ZsxV5Do9Becw8eit74LcA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794365876;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=cedV0+mBiOhhOlmQFuEFj3GrQxb4hXlX2OGeB7wX9RQ=;
	b=Zg0ycFZQXu+uouxS19l7EVDqEd3Sz6PWlXbwUkWeaSqxV6lC5z0zZOwUqbqoFaTYNcKU
	 8iHJb1QcsCqMTCp3PVEr4CztgeIZ0C0r57SKXeOQu3HzJ3dEml5PhbAE8Jq5sdO9k16Eu
	 9PRSGtoUYgIzOV7Go8be73WF/Rtiq/QpfzgGRss+YbIyZ7QgPOgjdif4F8AGW/Lipg6uT
	 ypgxahSgj1XO/URTKs3lWGV77ckl1biI9mZHLqR6YF8mAzmF+flhwMbPFW1QhMKbQa8bz
	 suGUy3Klm6i+Zc27KEdU3sj/8HL0LMAIYMt/Yx9E+GpYKh8cm4aRqENFpmsnXoFqfOA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=nI9d9JOq;
	arc=none smtp.remote-ip=74.125.82.182
Received: from mail-dy1-f182.google.com (mail-dy1-f182.google.com [74.125.82.182])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41E8660A382D
	for <virtualization@lists.linux.dev>; Wed, 11 Nov 2026 02:57:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 41E8660A382D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=nI9d9JOq
Received: by mail-dy1-f182.google.com with SMTP id 5a478bee46e88-36e99cf7bb3so4248085eec.0
        for <virtualization@lists.linux.dev>; Tue, 10 Nov 2026 18:57:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794365874; x=1794970674; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=cedV0+mBiOhhOlmQFuEFj3GrQxb4hXlX2OGeB7wX9RQ=;
        b=nI9d9JOq/Xqr+RyPKbRTKO2QffhQj0yL67Y/I95c80U+9VbfQlGIPEQfAiXC33MMGJ
         xHFBshAVTY0Yrsgfn2K3g0nyXYt5WVEaFAtZdTaZlvpR2uluFRHWWQLS0SkEGwBGHyaG
         VYHxS5WOXAwj4voclrpXv0aJCDBTIQLGAF1J6XuviHecOSxESYBGkoVcFOYaOrT4zuzN
         sbjeLmN5oBK6QOOEc3JdlM9nHTNLWM+Xwb+r1yscPVJr5MaySQLDqYH5O6Cs8j+zQ6Kp
         BwVCuDXx9iS00BcosOFMAQ+Op+XfC+omzcUSNbBCUJ2k6ouJqYjUqzkmN/dxT/SYvmMB
         m8SA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794365874; x=1794970674;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=cedV0+mBiOhhOlmQFuEFj3GrQxb4hXlX2OGeB7wX9RQ=;
        b=p7A+SCCAx5oPXqW0URSGNBNgTFDUks2AeqoM5oUqgTG/ftEh3cmh4asrVwfj3+Heio
         88nyjJeGLUSv7Y6BXOZijhgpiSmWyvzaZYN5v8kQFZyL4DCj8Vncb2+zFs6a8CadUv1m
         1NPcZVHpMmGFijA7JfUiRXquyLLzsJ5YMsxXPqWU0dy4oXet2HtSg8elnWqyeFeSLo5J
         ZFbPk47Gz2+0T9umIxWQEQ+Sek7mP9N86Xwwc5Njzs8E8hwfMA/qMEwpeWAeMdWNDTro
         KzJDRL2d7xQO4lWOXM4jC6m311iLG0PtgqHFrxueoljUnNp07t+KpSAyEIda39yhpPre
         gr+w==
X-Forwarded-Encrypted: i=1; AL+hErFwIIHpNyYpkuSzLG6JpjBUkW4qAkx++oGjU5MGAARMYP6i/Lj9/5f4756byPfAFYxn1TfK0qlt1m85iOylMQ==@lists.linux.dev
X-Gm-Message-State: APuU4Z/OCD1RKpGKCXYuxabZfUJWchBYOkuvAHx//5J5rAsAElTdQBso
	TdGTr+WLWYnp7QcIBq134j1hROAWJus6f/s7yl3bkAgh3t5ABx2apSb6
X-Gm-Gg: AYBFou15fHOQbFaZyvgnbnDwqCVhjaiQGPqku/SQI6qpVm7fWHyaP4rFckY5y4X2nfI
	LQ+YkFUuZBru5Di1eJBASCMvHma9zLcwXwR9v6TD4jPAP3UJocGB85RS9TSXW6GvJnvjZCtvkth
	WgyNJN1pWiE7HV7iToJyTKWpmlH59sozKzLcfObkx/khwjrreaCEKqh6yG/R3bpzZpvhVb1Q6bH
	ZPcDLerKN5aSOq5znCOxpUMnzcuyE3i5nBdH5R5vl1P2E9KSZ77u7PV252W/tWX4zn/ZDU9I7R2
	UX2wdWKSw8bpxu/fhdBY21atMUrxhgYziGjD4s48aGiifgxcNYg+E8Tt6B90PkNeYth5xbeQI+m
	W1rajrQW0uIVtkscUDNYTUzPGrhADohx1BzHs0XwE214xveTnulCTIWX2+m1VmVANEqDms0DLCh
	4GeVUOmkkvePfW/ROCGuF1Xcy5JAV7Q4Tzjg0I3zWxdzxjwGxVL8JSz7uB3MrFg2tE623hUCv3Y
	2QaSTyxu86vVG0Nzh83OJ0L7Q9Eqm8DKyp4Z00JIOHPS/rlSmrrrUMWT1HO3uBNPEQZXyp7vTmB
	Mmn+EIBbDvd2yYeK2R8i8sTPl9mY4YbsNq8TUjUpfBVEEvksefA89Bf0ejU5maiPVaJhUbwIN3A
	gkqDSX4zo5s+O9n1GxnL2Udyc6upbzVMRlClR5zUaD1WL1II=
X-Received: by 2002:a05:7301:dd98:b0:369:d486:457f with SMTP id 5a478bee46e88-37683861625mr1886638eec.2.1794365874080;
        Tue, 10 Nov 2026 18:57:54 -0800 (PST)
Received: from localhost.localdomain ([183.96.175.225])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-37520cfdfc6sm12390018eec.17.2026.11.10.18.57.50
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Tue, 10 Nov 2026 18:57:53 -0800 (PST)
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
Subject: [PATCH v25 15/16] ALSA: virtio: reject invalid playback completions
Date: Wed, 11 Nov 2026 11:56:54 +0900
Message-ID: <20261111025655.63951-16-mynameisjune111@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20261111025655.63951-1-mynameisjune111@gmail.com>
References: <20261111025655.63951-1-mynameisjune111@gmail.com>
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
