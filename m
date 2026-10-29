Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.214.178
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793263867;
	b=Tq/74j/RidzheaGn9w3mW7DxQjdEgJbcq8AoK/wkZApk98n60FuNMjSiDWjdqTYXQOQa
	 qHFMOhYXBYjmuVAfoTZmqSo28JRUw9ABAuhfT6eWKKbkGzvdlAgugJNqpSh+hZrt0c1UD
	 xpE4UhpomsnoQQb7Cb+GRXxlO7xg8wkcYmpIe98vt57TxxBvkKF+4lCE9qOMr7km8NeS4
	 CeiCULYqLo9fqvM8RToBvMBqGA5kUC7Hw8gSknN9HSXf3k84Xz+ygqvp5d9BIiS4W+98C
	 +m6K71CkoLX2asNVruaL7BEEO8p9eIB4+Y74qRA5RfU1LfvzYO74ya6XkO8msRXqCqA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793263867;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=xyRi7XDKpXV1gU6ovNhxbTiviMkA7YCbmNrm8NAAe74=;
	b=bRd+m3UVP+qMnrWfdHO+oVyV6Eh2Zpszi7PsrSwgvL6huhZOTWUwpIWoZx5Dx/WRqt0Y
	 pB8Kp3o3n1S8Umih6Cx64BPoqs5Dam8JeuTCUYuR1A6A5qCrIj0LwZ6fmiWu+xYQbG/cv
	 r5bY9oB2p3h8Umu0n6PdH4qxx6SGC/QnL7BUMxNvxRKXsknyIfgOVI2oenWpXSb6phtbl
	 fpYuVbMupcwNdrxfBdKgVs2ohGDjbHyVtn85h8eSv6G1A2aQ751lrBaznn3FtjW7+awgg
	 F3YohIeL5Ie6s8V6/t38IdFmEr7mRl1VDeh0b+tVshKuSFXvqbEcVrKUeAyyxStraUQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=yuyCfK1T;
	arc=none smtp.remote-ip=209.85.214.178
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B4B3606A32E
	for <virtualization@lists.linux.dev>; Thu, 29 Oct 2026 08:51:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 9B4B3606A32E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=yuyCfK1T
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-2e9ae391a05so3608395ad.1
        for <virtualization@lists.linux.dev>; Thu, 29 Oct 2026 01:51:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793263867; x=1793868667; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=xyRi7XDKpXV1gU6ovNhxbTiviMkA7YCbmNrm8NAAe74=;
        b=yuyCfK1T9tGaZ6As8HudQ0UBOBkZjUW4Fj5U7m6Q8sg5vJCeGS+MKt2lQo2YA+N5BJ
         hfupKHWb8TbEjL4M/WM8Q0LsCa6D4uiaiKg+2+Ai7w8Fs9OuN5XW4rixKUT/UqbhBVhI
         63n+Tuk4Ogt/s5KXFAQObUpLhg/3vAsyzbm+2TlrehK/1Exc9D3X2NBGJQmvhTi+2/dW
         Fwou7spz0O+CiwZ8TvsoXgY3FnQJm+eHAGuZc9pkarELELQBYk3XUfYHotMWRo1LJWqC
         SR8jX318ZIuH24PCFZNKgji0pHo8tBacFPuMk4pusYMdu1/V6utEUyUjoyQSaF8miSCj
         UFbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793263867; x=1793868667;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=xyRi7XDKpXV1gU6ovNhxbTiviMkA7YCbmNrm8NAAe74=;
        b=HifcQoqElefw3Chyz0X3Lsf+2e536y0A75SzdG7GscxVkFbs5EWqx0uoM4zyx64aFs
         OuaXx53XHOSYYWFGUYnaD0LiuanhVIT7acU6LnSCMwTPZjEn9VfJCgix0wj09nFwsbI7
         4OBGz8Ioiljr+isSoe5/6HMnqah0RIJq8WxtpYuEnjLQS5C7VI6+o1RYx+fZw9SZ/FIE
         2+pMk366O0IkZKiEyeSGeZx4lsnXW317lBhV0G4ZkZna1aI7N13esIua1OEUKsSfj1Sw
         Yz3zV+2Y9634WJFppykuEIQD/7a2ruADNVY9H+mJgZJyE39lB62z7VFk+6PtVIICC7mg
         BVVw==
X-Forwarded-Encrypted: i=1; AKwUvBxq+4a3CA8XhKq+WC7/T9RkmEgw4LGHe0U9Bl5sGFG1OkAgrz3q995DEFZKwXZ8kcPN6EjSslQ58e1CuuG7pw==@lists.linux.dev
X-Gm-Message-State: AFq9FYJXub/oMRA4FMYJpb2UtJ4fOa5/VrUFuCz1qYJfn3C/XiVyVX6K
	tfI+fAUpGXFme9W3Fei3kFB8I09uge83u905Jjkr1zloqS/wZe/fJ7Vfh5oELQ==
X-Gm-Gg: AYBFou2FmBKV1Aqb9/gGFzY2a8/To8hVrJgzXP9WwpmeZWQWoPd5EUbJqkBGPc1FU6o
	4ua5p5ScZ2ZIOrIqRh+ioGjR92LCur8aEZJet54GoatKn2PlOdXmRmUCyxWzEIApo6w62J3f3+4
	VexaTP0q9MU737HLteI1WmrllVU68VlGyrliUt1gy0/3t9kJo+WHTEfg1A/SWp4eVIO1E18Bw9+
	4CX7J638beh8wLzZEZsinewAJm8kDz+XOdCFrTmCC8gVdWQRXfICr7ZpSp1QYwEzdERcaaBYiSJ
	qO3m/EJiNWfi9D0H2i3nzlJJnkCysVZXpgwcJloaNuRpBTLQx/gZnRQ10EgHGc0fcpJOOj/S7th
	JR8kQj8PcX2Lz1/qGaq0RvOI0mKjfiRV6xCyzprRf/QVr2iLfioo/FYKU0eafs42bjlu7e0sx5l
	o0vOR3jE4WmN13wicEfGw6oJa/VsQGInNFHIgKNusbBE0nJ0oMNdbpIgofaPFEJAF8PNiq3M1Mh
	aYwUOe4zTPSbtBIBsQZO6wX6Z8uT+Q2Cs9pxrlvFnMSn1IVmI8SYZ3jJefRQTDhjSRwsx99yE3p
	BoT9w9NPVgwwN+Mn7MLxjJs9fboHUj1oZiUv/nzf0UQrexdkGxbJ5n3LYWfVl3/DDyrJ7I0gjAk
	H6GVeyqzYxI5wmA2UaBH2Bkjs0km3oCRbk9hpkrYXhw==
X-Received: by 2002:a17:902:dac7:b0:2e8:7a31:58f3 with SMTP id d9443c01a7336-2eb1ab12bd7mr13690405ad.19.1793263866673;
        Thu, 29 Oct 2026 01:51:06 -0700 (PDT)
Received: from localhost.localdomain ([183.96.175.225])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2eae6bddae0sm29991205ad.35.2026.10.29.01.51.01
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Thu, 29 Oct 2026 01:51:06 -0700 (PDT)
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
Subject: [PATCH v9 06/14] ALSA: virtio: wait through signals for PCM teardown
Date: Thu, 29 Oct 2026 17:50:24 +0900
Message-ID: <20261029085032.70689-7-mynameisjune111@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20261029085032.70689-1-mynameisjune111@gmail.com>
References: <20261029085032.70689-1-mynameisjune111@gmail.com>
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
