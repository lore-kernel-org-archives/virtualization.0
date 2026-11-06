Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.52
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793923647;
	b=g+xFXE3Gl92SDPsWHO+K6pGU6SBRJc1HXjxZQJI7J/KzB5U48P7ahD/WZrQQkjFTDom7
	 EdgiM6Nh1ZL+/JrOdTIgCBkG3Hv9FK7ba2yR2JTyvigfjjARTD8Wy6JOcH16MHMk7tgzn
	 ItI5b/PzzSUc8Q0BIQK0J2KAO0xq2qRiAw0hUb/39WzMRQlMKjRNo+FTMPrRap/9Qf1AP
	 jAQ/+xsFAFi22I4EuFdwSiQqjcUKDpcQnJwHtK+Jg1upmTNyWeWS5e30cHfkfwtIXgznr
	 mkfcZjNL3s8vjmaq27tK/jI7tnHHcNzmDDuZeMTc+2VMvBIs0cTLGOTh1abZ8UUQz3w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793923647;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=FnXDhydnb2ccBc+HkqfRuBRFsa8PxXuzWixMqzpGlMU=;
	b=F5maJ8pxpk2/pw1L+t4IMvgZXXYRA4mPA+PfyF5TUaD2U+Vbi80mY18Q3JJLk9BCX0hc
	 GbV3Xtm4w733qFosvDTlkMu5hJ+6dwQgQtxWWRNRW229D4MeUUnN5zQdlQB5nsGYBdm8d
	 YbAF73otCJjX8TovOrLmIwOgDE6V+LNpZ0Fne69EiAWWT5d7t8rokRmRjUtL1mdKrSsqa
	 qPuEc0qsRdNU1f3ZwdACp896mpaIcVJoPxF165yNfe9gJWse4ClKSr9gEsRVY+i9rx7dK
	 xShgnNoFcbBwxOTvTQLjevirOsKsA3EOdUTwCGQYLnAVIa4uHlc79tO3MYfsxJS0aMQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b="P2nQ/Ld7";
	arc=none smtp.remote-ip=74.125.82.52
Received: from mail-dl1-f52.google.com (mail-dl1-f52.google.com [74.125.82.52])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D86CB606A326
	for <virtualization@lists.linux.dev>; Fri,  6 Nov 2026 00:07:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D86CB606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=P2nQ/Ld7
Received: by mail-dl1-f52.google.com with SMTP id a92af1059eb24-1a2af4c8d00so282233c88.0
        for <virtualization@lists.linux.dev>; Thu, 05 Nov 2026 16:07:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793923646; x=1794528446; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=FnXDhydnb2ccBc+HkqfRuBRFsa8PxXuzWixMqzpGlMU=;
        b=P2nQ/Ld7GU5K0t+5kaTGNKWuSmrtQ5r03Fln57vec4WzVTI5uNGcurgfhdL+viRp6A
         KJMtTvvKUrhXV4Au1ZpTt9Jox4zIxcH8eYqh/Rw/uW5iYBAutZGtNgZYJVngzXYhhxfC
         zqu0dArNRSa4qfKgTQOGiE/o9gSRQNHNDJCl7muhs/b8PS2Nx7IHNT1tY06sAcUxular
         yE3D0BWtWIvclPbkLZgfFi0qjThKT4glEtdM8PCiRgPV14pg8w5nqDNhXqKWpweGpYBq
         Ct8UaLZ0zEEic0oJj5O5583dW81iNlH46NMr6liwmgUvJ6OWQckQaQqB91ukFSsIsfaS
         ch6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793923646; x=1794528446;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=FnXDhydnb2ccBc+HkqfRuBRFsa8PxXuzWixMqzpGlMU=;
        b=IsqjP2Pc+jOEdfYhYxIIF5x5/Vs16m0NRrAYV/sElbxYxJSsoxMb8jg7xmRhmjdCta
         iXfwaAPZrtbfjJreobexjHfwJ1W66BdYlsGQWpdt2mcqKdIdw7xBDhKglPEm+i4uDXov
         5pwjjmhV/fS9lVS1oAYIzstHAzP9DAuMTIwyFlN085RnqKA4XXib6DFap8u1bhU09NfQ
         qO0vYVqSwoQseGucbK0O1hQFbPaz8wT7USVHJ9WPCKC50Zhgoeqvr1H0EnE/SSOfW6Pf
         OUqtcOLfuxevDWJCYgAgtGx6tUyu23oPUadx0gQbeqdHSBjuEbhn+hRlqFqOow3/Tpwp
         avfA==
X-Forwarded-Encrypted: i=1; AKwUvBxjdxAJlDjf9mtN2DQttaaQ9fQRVe+o3h74ZOQErUavH9SV/5i0Cgd9aPqz9tAfRE/N6PMo9cmR4wPsEqTAfQ==@lists.linux.dev
X-Gm-Message-State: APuU4Z84PZeabnBnpvhaNimKWFpdcKSgUlr/zadtEba2UUGgdd0qRJOs
	FgZsN/D++nsD/cgs3GOtJB3zvtMQQbgTMu4hn8vXMzEj5t6p15qW6Ghl
X-Gm-Gg: AYBFou1vZb4J/1e2RBQNcHWCBziVOvq+SfIuBojwtndf2m8+mNdqNJl4fF+hWzg3VGr
	NCdyl2UYzyvuA67jOWhUs2UTQsw9oZDqjO8h0MpNWqi7TIluMZGhsiC3ylbw3HFfk047GT/rkG8
	qho/fZhI0k7vrc7p0UpeKrO2WHNAuKEqS0A4GRAPD9QA+Y+HPq56bEwAFj6s5t7vLQtGrKWb5uW
	79p7Q9cph7Q1j+JcdxJ/AEXa6a7TZYjW/89PXuQ3ifI1oWKtpgXrJO/4SlpmBm/Kg0hE0guEx5k
	jaggAN5TMoTdNsPLcp7onI9GeU+kSAa0DGjEUZfrezUPUWHUn6zDRvJyAMYBIu6O7wlW7zOSUWG
	bkHt02t4Qbsj6yBTIqY8uLEQsL5wwGU+CjUD+jw7k1IyrsCEVp/9iBM1qK6Hw0rk4CsUgeMk1EO
	FeyieCdkvxbfaEEMjev+HLdS/EUHNfMfpFQ0Ob2jt0ZxbWA1vvUpktD1giDfmjxr0ys3vUcfV1T
	ZSeTAuTozOKljkX/0vKry0PgsDOEM+egixCQ88ZARiur6hF/mlK128Lpjyc177t20OLjvTH9ZZE
	KQrKVcy/QZYPJ/UtMjRZG6M/L0CzuqAyxBwD/C41U5r/vDpRzWrZJUWtmYzpjOnuPFfWzDWeFyo
	HSR4q5cYd3EFMjLs/awHj5KhBDRf7a+79z1hl6P5iQ9rnJxrdDYocwQr6vVad417xN5p9
X-Received: by 2002:a05:701b:2618:b0:1b1:4c25:b64e with SMTP id a92af1059eb24-1b25d334f8bmr734634c88.25.1793923645841;
        Thu, 05 Nov 2026 16:07:25 -0800 (PST)
Received: from localhost.localdomain ([183.96.175.225])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1b25e4e079esm371165c88.19.2026.11.05.16.07.23
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Thu, 05 Nov 2026 16:07:25 -0800 (PST)
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
Subject: [PATCH v18 11/12] ALSA: virtio: prioritize staged capture period work
Date: Fri,  6 Nov 2026 09:06:43 +0900
Message-ID: <20261106000644.20460-12-mynameisjune111@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20261106000644.20460-1-mynameisjune111@gmail.com>
References: <20261106000644.20460-1-mynameisjune111@gmail.com>
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
 
