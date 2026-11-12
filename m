Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.45
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794444477;
	b=mVRDuMDBIJh+juRLQll9owZaRMoM3p+RLc/q8lBBsryoq8HDG/uVMm4jVPCuoki7nHz+
	 joxIqIQoiGpU0RPcnHeHMj7eMVIwlBVUm6NuMuVpo4CeaXJTEEUuKqEd7945WCCAmi4FD
	 HNgU2YyEmGjoFjewXBS5o8wX3ghadJDoik53uYIsjJbRsdLoeNoY4NrGIg1NYyN/mV8Ih
	 KgPFxEodQcWsyEbIOAMxk0jd4YO9hOCuEvfAHYjJ6DBJRxQ3Z8pzbH/2gGFapTokfvpP+
	 cGSpGBh3onuG+FpeEOcCOtjZn09UArGoGGItl6VPhVVeNwL4B1crodDLE/FKngxwYDw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794444477;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=7hT/gC85F3aW3pcczI8WvAe9AkJI8Qa3b05R3EsTbPk=;
	b=TTfdieXdgye0pmtMHirb++iKN12Kt/Rij9j6+q43HBvm9MCilaZTDu3wHP7+ehaXGR68
	 9yEoFZ9ce8F4yx7tWqri6SXnivJSQEJrO3U4QTaA1B9/Mvmh3c5NgLNWuSc7TVfGJm4RI
	 OWOhO7cNqykxHEvmv8wUlhh54NI84FNsU/JHH3rq+5f6UZZwi6d4jmx/YbM7FTOqNmOVt
	 R2ryvTRWUKgoI9R66hsDuZ5L8ikYLxR2c42eV+1zrliR8kHO7T7TF4VACQEmqsVkHf8FC
	 gU9nKZJxIYdxVRTKHAYucOfPsyoThrBHIgxw/z5H7IYxAmgDkencYwpZgq7RabO20uA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=C7pRXEyQ;
	arc=none smtp.remote-ip=74.125.82.45
Received: from mail-dl1-f45.google.com (mail-dl1-f45.google.com [74.125.82.45])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFC07606BB7E
	for <virtualization@lists.linux.dev>; Thu, 12 Nov 2026 00:47:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org AFC07606BB7E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=C7pRXEyQ
Received: by mail-dl1-f45.google.com with SMTP id a92af1059eb24-1b3beeaf6f9so1734714c88.0
        for <virtualization@lists.linux.dev>; Wed, 11 Nov 2026 16:47:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794444476; x=1795049276; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=7hT/gC85F3aW3pcczI8WvAe9AkJI8Qa3b05R3EsTbPk=;
        b=C7pRXEyQtnhQC7OYk7ZrUyl6N7RZ04bt2VGXoV+XmeMHPpR0KoCqg/vl5u8V0SXgUd
         UaehQ2iNq39OiOZMiuQCSF1iJ7j0aZ+6UuOd2EnJO1AhnFYC8qafk9gg09VO8xCHhuGW
         kUhHZ6auPUl/IJkzseV4HyQbeqTrTAfZfmKjzojvguDEz7fsHKXItvDnrittkGRLKTqf
         pXbqWSUbAdfqU8BD3RRF2rEauNrBhchMei/15YrTH9Pveu0dqlbMywtGwdV2yNJ/bILV
         yhmNT7aJM4b6kxwppZ50dHI5I0+dEg2pZwdZn6bHq4TjlSKfl9+53qXc79hockyc1Pjn
         eqrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794444476; x=1795049276;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=7hT/gC85F3aW3pcczI8WvAe9AkJI8Qa3b05R3EsTbPk=;
        b=okep9tM5F0VEalDIWpg0bEdUFlBJZ3p+TxP/UYR3wlwScH0v+Dp3KG1ljmm2Bcw+SX
         g8ZVidPjJY+g8HHcfiFiUsGAmDBxb+0cbspRo3B+jGstd1zI6cLsyDiaF9Q4WEHjiqE5
         +4tADWmyu/eL3PKjmPn106Pa1Zb+dm+LkVrGTVyFut6t0U0vOeuCFq/EKLGTZj9Cv79F
         pNtXfCn24Et0yKi6JSOBBeimySCCGJMXiIDEV0tXs7p32L36BLGgZPEzEHQd9ruhHidU
         mWEbhYIlAc1W6mQNB+4+6p1jkSVamYyGjVERStoCtUB8NzQmD7kYGWtldv0Ck8Vfi8HX
         q7Eg==
X-Forwarded-Encrypted: i=1; AL+hErGYTOv6Dzo04yjlpTJ85NW87dSzriq3QNNmkeuAzz7V+OIQUes7gUXnsgbg3H9xoER4pvjGIujkashBmX0k+A==@lists.linux.dev
X-Gm-Message-State: APuU4Z9AcQW7Kk1sJhxUsyJbIRTJ1cT8SkSkutMVP3qKBtbM5s118au+
	WvIg8PsW6EL698rcepdQ5VWXEin5JorRpVmcfn6qDBKA7HKhZ/XDAt9C
X-Gm-Gg: AYBFou3fTahBLL45OVqt2jxLpLCmF9a5kFdQ3RMydoy9D+eJ5Ma4X/B42pPwOPzZuG9
	YkvfE9wvf8cnuz7zofcLKiAW8wBhi0FCMsyX63hhX7itI2gAclxXJclI6TcToVsuYTbj/XXViKn
	s2gPVRgPF7zGdoDIYrlvaN0N08rWYCaVrYCQ8sP9dyTIHZVNMkriEFCRZ/9NkMRJz46x2yKOw+b
	5/+6sOlNK9qiGzqdKlLapZtbsfJv5gjz5g4uddSi7yQGvZpsl4ntHtERDI8E3UwATGjx0VQvdRb
	pWBXtiCrkd6yR1o6myCTr6LQ3NIa3DuLe2ywT25IN4jBboHrtjbQwOVMGywzSFQXcmPWiVMtAMQ
	wYAb5Qfl3e3pz03gWNxnjyE6OlrSg1CgN5mhonxrFiuWlUnbd/OF0W+i85rB+gSsAujaoatEws0
	VNc75X31/QgrCke4/Fs3ie+bP6O0qBMFOhzgnkXXuw4SyotnaKbkBSN5/EMCS+agyh4CEgA77g3
	7zdlOyFq7TplJfSB039wVvm9GK7LBuyWROvRiMMsodmkHSho5hfX4eyvbGv1AlFQSpXv6KU0gUG
	t4MKF1NcxH0Q9l7OEAEe1yWmFea7FB3ffRtRxbSc4uHF3bfnEGobFICPMsjAVmu/ejGNmjwgJGC
	N2Hx+ibMMBewWREim2QoJMi7paxTc9ty/OB2sVlr+PxXi9fo=
X-Received: by 2002:a05:701a:ca05:b0:1a2:fa1d:1de5 with SMTP id a92af1059eb24-1b3c2154fc8mr3170842c88.20.1794444475812;
        Wed, 11 Nov 2026 16:47:55 -0800 (PST)
Received: from localhost.localdomain ([183.96.175.225])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1b3b5b2eeffsm20672163c88.9.2026.11.11.16.47.52
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Wed, 11 Nov 2026 16:47:55 -0800 (PST)
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
Subject: [PATCH v27 13/17] ALSA: virtio: prioritize capture period work
Date: Thu, 12 Nov 2026 09:47:00 +0900
Message-ID: <20261112004704.49758-14-mynameisjune111@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20261112004704.49758-1-mynameisjune111@gmail.com>
References: <20261112004704.49758-1-mynameisjune111@gmail.com>
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
 
