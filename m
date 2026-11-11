Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.216.43
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794355600;
	b=x65g8/JG73WXLqGSYZnO0faUyVdxuNRiwUqJmJxLWKaqZPs6pA7/+QFd74bU9kOiEJzO
	 AGeKjvWhxsxt8fNKw4/5JdxW4Ot38+Fwh3CGGrn07H1zZO3F01yXUzXNPFRMuKh5V1qFR
	 QrC+kcJWcnEvdmF5h7GTX0vq1JxbW6YaVdEGdNdV2Z5TVv3oAAdu+FbVH7/LLkt5VSgPl
	 JzZlauzo0jXsmsCPOonnm8ugFxFro5z13rUS3CF5MRYpfw9LVgA/lpVWe4WckwyWovD5R
	 e5iVZnpK3KZECDF1jgLGX6PCBi+quja7i5gC23BuKGsoaNXvtGy7kOSb+JYh9lYVIcQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794355600;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=7hT/gC85F3aW3pcczI8WvAe9AkJI8Qa3b05R3EsTbPk=;
	b=YXe5GjZxH1Ifb+guZJKURZMJm/gs7UYXXw2nthklbfzZ3HAhAtFETA9dvJU7ZgGfuE/U
	 CxXoYrmsdaUcaNEq2RoDIBZFuno7XnzCgtUy3d01KOzf2Audqc/I8c1T/4nFSvuuI46Ul
	 l+/r31ULRIqDq0SojLH0z5F5FT2A2oomG3PxiDP/2TbIAIUSGaDG26rr9OYr8+ntOLkvZ
	 G4/2CLALwv+SCwHQRarGWvF7iht/Sm4FMOt+31ERbgUHyye0MXQ4k/AOIsrd1nJiPVQmf
	 1zVbzEM1jxN2CcdNd3ArAcTQOR7hnCcd/5bAhWioKTrYbWZiGGGCC2bWNd0ylrJwBIA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=ae2C2l1o;
	arc=none smtp.remote-ip=209.85.216.43
Received: from mail-pj1-f43.google.com (mail-pj1-f43.google.com [209.85.216.43])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 291F460A5BEA
	for <virtualization@lists.linux.dev>; Wed, 11 Nov 2026 00:06:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 291F460A5BEA
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=ae2C2l1o
Received: by mail-pj1-f43.google.com with SMTP id 98e67ed59e1d1-3ace1f3897cso1482550a91.0
        for <virtualization@lists.linux.dev>; Tue, 10 Nov 2026 16:06:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794355599; x=1794960399; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=7hT/gC85F3aW3pcczI8WvAe9AkJI8Qa3b05R3EsTbPk=;
        b=ae2C2l1oj9bSOy9ZXhPosUbGG0T3HUP7IssUNIbw+X/r1cgWq5UnYZcZgRkyyu9Z6s
         BazyqNy7gqKTNq/ETUt4RHQD5zfXBqA19rJLdWPQOtAp3Oj40cRhauN89Qsl0g3IxuqJ
         OK4qM8NMsrRahc0NmLsppArt5UeXB6AGKkkdScMv9+3hkKe1t9p2NG1DvHG7qblpMFjC
         aLHMZu2kbef3lT+rfYidsWgS8VkQP7FrCORaPfV57QlTuUO66OzAOy+Gu0CyAaYg3rAO
         twxpJS/S5FTUA8Zf+MIuFWDJzXCPz0pzN/cTf3KDyhWJhPKCZwnaEGkBx81obAWGiOqk
         I24A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794355599; x=1794960399;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=7hT/gC85F3aW3pcczI8WvAe9AkJI8Qa3b05R3EsTbPk=;
        b=Z3e6kgkgs8+n+fTdmcc6seAf+aRRP2cAZnusNDaR8yCulekLKre348WR7ww2iNaSYj
         wk87aFALu2XTKzkHxAnufImvQWLcPIbevLLETJFFE64MWs5DX2Bi/n2UPSmt0PsVc+NV
         ud+ricH2nWVbDhV6i9pEgHrAumkWelYVVAgH4/XSqzox8xGs/1YA2Sx8ysBgGNPHdIaL
         XkGKm3HzUAuPy4+9rwwHmV15/3WTLaCogH87GdMUD81u7FGz6GcCgneGXLkBHgJ0AKcw
         fJr8yWbFy5hYmFFyHN0mNYbdVjnBukfsE6HcYPkvcXMCf1D94M4a3WD2p7H7c9WC8HEv
         +ylw==
X-Forwarded-Encrypted: i=1; AL+hErH4pbaQHlsLL9VozIgpnNsCYoHqLF1Cz0+lMpevsE17ervzXmZ13sIW50lp2wMFbKywyCtzpxY7bLu2VXudHg==@lists.linux.dev
X-Gm-Message-State: APuU4Z/ReHoUgJgPtZIyTJ0a0z9eGNlj/VtNphduogfTgqkjoEFHuyb9
	dka0ZQL7CLrq3qHmrZV5yc3iOfdCnj5H0VVj3FtvQEreJM5ccSh8W8A4
X-Gm-Gg: AYBFou1pqFs1hmWmXB2eplRxNQvsSRqybELNOffMef/+AqOm5sDbPRzKyXcfqryJ4xH
	JZWRs5DAzMUBfEpy1dE49J7cPytU2vQjRz9gN0kSVLjJv6jUCffsCyNXxH/AiR8dAIjuVUkaIMj
	pJQx2ykn30gcSP2a2itwaNiOLFT19cvZofNNWd0L0ezeE9mK2BAQK5bfjcHv75vs4qArNKJjAF2
	MnhOZG1WEbuDKcJ/yw/eHcDiLx5uEVTiPwqyJXmhRvBvU8VEPkWJIpbTbWxpA74uxNbbGgqCwOs
	OZnBQTyJft48999OitcmI/7+CQ6xmqhxuzlokjg5NNategN3hIN99s0PcokvUnI6coUpxIZghoB
	yA1w+ryxTCzKvoWrDswbK2+hQxp33kBH2ZM1ftdUzUUcq8JBW6QnrqR0BDjv9cilqy06u9yIc6Z
	an/R0fGz6pIeuco7rvkFz31zIVNuuVEo1qhel28pa9n/3MFZJvP1N3+QODXNTpGTo0rxeyZlCEW
	R1aTLtV5CJED8QTVZxD9Ga9LT49zQukQDMFB33Bv6ceKGwvrjYo4FCCBtxPAAillNhi2+zsQ7hX
	er8QEFZhyg+SeM9p6yz9fTC8ore97bLkiw8n8LzI7X1ncf0R26z1tSKdzLhWNw0Fa1WusWmhXcx
	s/FbeJSxQdWLEuKC2X1l8Jv05oHSe8w4r3xOQ+hPBN7Y6JGvwQsbI4N2eily4xJz02Utl
X-Received: by 2002:a17:90b:2e41:b0:3a7:f4d:b23d with SMTP id 98e67ed59e1d1-3b182f9e1ebmr573001a91.52.1794355599623;
        Tue, 10 Nov 2026 16:06:39 -0800 (PST)
Received: from localhost.localdomain ([183.96.175.225])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3b1838e616dsm474361a91.4.2026.11.10.16.06.36
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Tue, 10 Nov 2026 16:06:39 -0800 (PST)
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
Subject: [PATCH v24 13/16] ALSA: virtio: prioritize capture period work
Date: Wed, 11 Nov 2026 09:05:40 +0900
Message-ID: <20261111000543.28550-14-mynameisjune111@gmail.com>
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
 
