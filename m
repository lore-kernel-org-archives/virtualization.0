Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.215.179
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793338016;
	b=X7lKE24dk8+9HP7UCT0l1GjNtxwBf1jhMWgQFNJhXVw1WsgaK0dYhigS2bF+rpZBh9Q7
	 pyJQ18DwCgtxcLr1GulxV5K/ZNHUEZgvkswe5mtBahK9EdnVOEFZiLm57ZgeHCNVfSZtj
	 1/S/2eUUDtWA5dD+rjt3UvU84BM1//9skfEayci6VzXpVTWQcqCo30ASl50Q1IZ4d8Kmx
	 FUoMb22VAKcNAc3mRExxL023GS/v6uQzxbnTJQwualANngoY99+r/pzyqbH4qXCrrjGhi
	 VwC31jDNPZE1Ps4lAIi05hpxxabRu2q9bJtLyjsD0dWEZbsoLn2kvIZ/WI29R7xBtsA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793338016;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=xyRi7XDKpXV1gU6ovNhxbTiviMkA7YCbmNrm8NAAe74=;
	b=XW1Ru43UHdOHVe06zYBhh0Mz3gdSWJacEpKKmt2oeMUM0ScoxDxoh14Xl9wl586chBSS
	 zZtStADsCSoxmSXIxMJrd2dvNX3fHuKkGQ3DVEXM5Xwb0HsSpVBgSJilbIeIP/7Y929FY
	 DFqOTZu7YNpzJhEjg0wlM6QmnwEqoFs8tu6rSHqHo399xAaknT16Uo5eanozx+Hii1j1I
	 r8H6ZNuEhvRdKKL6hXdLg9ybl0WSYIiclOEobo5SDR63BN58WFuucsfzu0FqGwmzqb/tx
	 XEt6h4uBeIsUtT3ZMONeJDk3iod4rR5Jb8TK0zTkqUduDRzoZtVY5BwZU2aDQdhqH8w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Krqyv2YQ;
	arc=none smtp.remote-ip=209.85.215.179
Received: from mail-pg1-f179.google.com (mail-pg1-f179.google.com [209.85.215.179])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 262D8606A322
	for <virtualization@lists.linux.dev>; Fri, 30 Oct 2026 05:26:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 262D8606A322
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Krqyv2YQ
Received: by mail-pg1-f179.google.com with SMTP id 41be03b00d2f7-cd69954c755so207275a12.3
        for <virtualization@lists.linux.dev>; Thu, 29 Oct 2026 22:26:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793338015; x=1793942815; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=xyRi7XDKpXV1gU6ovNhxbTiviMkA7YCbmNrm8NAAe74=;
        b=Krqyv2YQDbssdBC1oAQVOltKpE/PAjfX7OpzBq+C9/ubJTHC4772ls4a9aafblPLu/
         Opug820gMZ28Iv/pghZhfqSiwvk332pqwStmopif6Gm7pAkvXNi3/ycZ/fEw7ymWUe+H
         HCtvmwz6OVPl2B9EXVZyCsU9zO4v7br7yPxbwWggEWpVvZwXgjV9eafXPeI6K3RZA8V1
         o9/TQIK/p7FFdV1leWVsBaNNPEoMSN9LYdZG+eg4VUSJ0hhjbMFTxVMo7fpZCMvN/TYZ
         scOqOoBk6eKHDweYlLgXCyk96YFheBHWSmMk0v62kC4Iamjx3vFOPjim9zpEc6firYNP
         RqPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793338015; x=1793942815;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=xyRi7XDKpXV1gU6ovNhxbTiviMkA7YCbmNrm8NAAe74=;
        b=sp7vC9U4Ye6g1dFnuZUP21B8hKt3VCLzACgk/Mag04BN7qrMnQvQa/Vl0Kw38Sf5jV
         viBrQaF9LIvPlVR/UGSanLdvEoJxXDbAl1l0hCM0woXJOmxj3tKgSSbbiMcZ9N9b/aoT
         Od8NeYgWngCD+12XVi7O2/Wdy0IiLjvlhVvY4a3ccHKxVWn5aqlVO5wZ5UoXq5w6ylyD
         sC/E+NMQl8ucQTTTlZs7wwz2XHufiRSVelCkrBVRUchMypRZg5HyP6KoaSt4RxkJv0q8
         861VqLVOTfxiQ6pRFxVOcikeD7HFDKAVAiz4pi1Ll5Vz0mQUSi+zkDbEPDxJ7xpTF1m5
         Xhig==
X-Forwarded-Encrypted: i=1; AKwUvBz4PYQfBly9rfZkNIAU5ouzRtZDDmK8uh2xvKFB6wwbCFVy85TDJlKQWSe9HqyQ3+hvsEOykg3Qoj/hDcYbdQ==@lists.linux.dev
X-Gm-Message-State: AFq9FYIyeItna6zifa1C61JT7xoR2kov+ZlSaX7zRvchxAulGv1vgtg9
	czNYFandNJbHrrZL5TH4k+JwgUhecnBNkB0hPjQcliljZ2sbV4cv1HPX
X-Gm-Gg: AYBFou0CZ7p9DjgyLHQQXwD7rA2jAFe/rCT65mTLl1R3/E9hPy8neF8G2I8037fx2DU
	ZtNO5ngppkUEjUn7qRI1MUFadq7rFfQWb2WkAbuluYdkicS9lB+yHKBtFDpogcdJAa9riv+F73I
	sRhPbjYkTpPKDmvNJ2ERmuOC9TPNI2yCPEHcZl6YuOT6RhEXYixCHNS5uioeWvG/arFyqxRA1WS
	KDmGKOzMDIq2FXtbjB5ZGnQD1vpYnuBki82TdRInc3h7dYftXnJuug3joRrMok2sZv7tqXncR0I
	fs+YDHNMLjgTprnEnjeDW51adWJQmerYBR2d+A+npxH1ynW5jQtvdr8Nd5gVpveN1Uhu8Iq9Zz8
	vu5FsXYZIVMa/BQHuPDLQw972FrVUjzu/BIJI5iqfgb5swC+lkKBqKaB8Cjm5HtfC8c8jksVgnK
	Z5TskcQPgRwjruHL8rZceZMVrtrqFeSnf36wJGF1hVVDCZHTgbAVrD9COv+9vYdI0u/ppHgznlz
	A7NaExIbF5JJPlKoKEpxbQZQgj0+bHwZ26O0U0B0k3LN9G6aNbpsRnqHdjhv2BY6qAUwBRaqR/M
	42agsmyFFBwKAAV9KNFvYSyPg/gP4djTrRqzBjkEsRuUPuu70sjAeM5ECG6Ukwwu6ebYVH18QuE
	RFSWZZtEi+JJ2xhgXd+jTZ4qbleMpnAWnsVicZ92iG30Hrac=
X-Received: by 2002:a17:90b:57cb:b0:3ac:b2e6:317d with SMTP id 98e67ed59e1d1-3ae89776ad0mr997346a91.35.1793338015580;
        Thu, 29 Oct 2026 22:26:55 -0700 (PDT)
Received: from localhost.localdomain ([183.96.175.225])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3ae845429e6sm2421027a91.6.2026.10.29.22.26.52
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Thu, 29 Oct 2026 22:26:55 -0700 (PDT)
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
Subject: [PATCH v10 06/14] ALSA: virtio: wait through signals for PCM teardown
Date: Fri, 30 Oct 2026 14:26:21 +0900
Message-ID: <20261030052629.27742-7-mynameisjune111@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20261030052629.27742-1-mynameisjune111@gmail.com>
References: <20261030052629.27742-1-mynameisjune111@gmail.com>
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

A signal can end the interruptible wait while a STOP or RELEASE request is
still pending. A later teardown may then submit another RELEASE before the
first request completes.

Keep both waits non-interruptible and use the existing message timeout.
Other control requests remain interruptible. Device reset still cancels the
pending request and wakes the waiter.

Assisted-by: LLM
Signed-off-by: Joonho Lee <mynameisjune111@gmail.com>

---
diff --git a/sound/virtio/virtio_ctl_msg.c b/sound/virtio/virtio_ctl_msg.c
--- a/sound/virtio/virtio_ctl_msg.c
+++ b/sound/virtio/virtio_ctl_msg.c
@@ -314,7 +314,20 @@
 		 */
 		virtsnd_ctl_msg_unref(msg);
 	} else if (!nowait) {
-		rc = wait_for_completion_interruptible_timeout(&msg->notify, js);
+		/*
+		 * Teardown must observe completion even with a pending signal.
+		 * Otherwise a subsequent open can retry RELEASE while the device
+		 * is still processing the previous teardown request.
+		 */
+		switch (le32_to_cpu(request->code)) {
+		case VIRTIO_SND_R_PCM_STOP:
+		case VIRTIO_SND_R_PCM_RELEASE:
+			rc = wait_for_completion_timeout(&msg->notify, js);
+			break;
+		default:
+			rc = wait_for_completion_interruptible_timeout(&msg->notify, js);
+			break;
+		}
 		if (!rc) {
 			dev_err(&vdev->dev,
 				"control message (0x%08x) timeout\n",
diff --git a/sound/virtio/virtio_ctl_msg.h b/sound/virtio/virtio_ctl_msg.h
--- a/sound/virtio/virtio_ctl_msg.h
+++ b/sound/virtio/virtio_ctl_msg.h
@@ -47,6 +47,9 @@
  * The msg_timeout_ms module parameter defines the message completion timeout.
  * If the message is not completed within this time, the function will return an
  * error.
+ * PCM STOP and RELEASE wait through pending signals within this timeout.
+ * Other requests remain interruptible. Device reset cancels and wakes either
+ * kind of waiter.
  *
  * Context: Any context that permits to sleep.
  * Return: 0 on success, -errno on failure.
