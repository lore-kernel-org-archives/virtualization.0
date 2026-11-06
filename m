Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.41
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793981965;
	b=KdejSHUzHKoxZQIoOzVaPKZnQioNYE+CXA9Up3aCC9prnzJagt6wldoqviRKk3vPNvrd
	 3Y6ZlhdhOsXGbfyeIPXMzmiZMJi43RRg6Tecje02WAYl1wliNoxAGPVxNgpOZ2rdNDLbz
	 DtdRLK3NZZYgRI40cFNiLGPcA6vfQYEsIAZ6jO0MBP4rFCE8DqOB+Zv82LbGhiZiOsJs+
	 uNDi2X0j0+v6IMS9T42sHqRnQ90N5iqAt3+a9hPJl+++FhQn5zt0YM+BNDWIlWFGxMFGV
	 uD67NIAgrKANyuNqST+sa4wyp/I1uF06g4Zu0Rj+zk1UfLUbT3S38lDvR94QXNl90zw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793981965;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=yx9qdA7I7keZZm8UafgJgTm1z4N4QlAmh4J6h6T4bZg=;
	b=kVjQuTrZdo3AWXzX0lhoE4G0594FJ/CvfCmka8iNudZFuW5tkP70sdXuKkr34OmCEJfQ
	 EqcNvaKAeKvxayzfUzv3ie6a+6FXkWattTwv4A6lGfpnJRTKLLRH6HSSSwHfx0DEBV7ry
	 V/uCjk1wOBkJ6wIYYhKvLbPRqzyqPuRkQeKAr1zDKbmEI6PJzE6WS6OznbUUNQAHICa+I
	 LdDszLPoEXGeNObLRk9XXmnvcbIyu5k2u1SGKRUAZKhaqK1O+vh3L/tsQ5yuElLrAuLPN
	 HnyMVMs9877FhfC0FBVmXCe4yAGo8arfymLyHC+4oZr8BYtyGSvvbq3c3ckkMCsWpgg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=FOFShlpR;
	arc=none smtp.remote-ip=74.125.82.41
Received: from mail-dl1-f41.google.com (mail-dl1-f41.google.com [74.125.82.41])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1EFC608363F
	for <virtualization@lists.linux.dev>; Fri,  6 Nov 2026 16:19:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B1EFC608363F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=FOFShlpR
Received: by mail-dl1-f41.google.com with SMTP id a92af1059eb24-1ae18eb9ad0so1148741c88.1
        for <virtualization@lists.linux.dev>; Fri, 06 Nov 2026 08:19:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793981964; x=1794586764; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=yx9qdA7I7keZZm8UafgJgTm1z4N4QlAmh4J6h6T4bZg=;
        b=FOFShlpRFvqnOdhc0r3xY40xV8jEAPLPFG07ibXRgq3ryfL5+IFxQFLIZE5ZNM1+iI
         Ushm4aayYa7kRQBdjkzM09YxyDxIt2HmrfTTXevhFCuA4Ta2VEvhQx2a6t0RAK4AJhlK
         xaLsVVflbXA6V/aFmHWTDHOG71coQTerHHCUGYGD/WDqNkPTwMLAgqA7MQveap0chwXS
         r7/c0cz8qXx74bI6HMEjUJtVHgm/yRo2cuG4ZCUoC8uu3SWeOHx1OXWr9ISFn9BWO1k9
         BGRxQ/PApKWJBVCxqLy7CbFFHGh5FyAL/GJjk9C1uZhmraPxkHgukrKWsQsGTszQ6+Ml
         WfFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793981964; x=1794586764;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=yx9qdA7I7keZZm8UafgJgTm1z4N4QlAmh4J6h6T4bZg=;
        b=ZN+iH/rzVej4yIXDG52m83GTQuQsOw7Ta6pmobNsZLR8JJxvXdDtdG2rQMD2J+ae7i
         VGxV4qythJk6y3m0R7FEXhdVW6Q+hXICYAHZa7T71MSGeFziwFQEkNW7nAfN9ayWCFBW
         flzBHecLPxptRQrfbVn0EHAq0JTJs+3hYKEoFQJW13X0BQYWoHlT4efCNT72FdhQNbHs
         UTlYyJXjNXrkUq7EMlMUdo9quI6x2ul4pHmb+MhQX/AL75RLRkxLvyi9S1T86taBoUUs
         +13a8g/5CrcECff0UHcRb2cyVboL3fVmk8vM43hcOiyNLf/ak+ftGdkCwG7ntt7pr8Gp
         JDLg==
X-Forwarded-Encrypted: i=1; AKwUvBytaA0y1KyjAAL68yG3rr3rLBvOnOcWrzydk2ZMHGo5BdGOaYJ12mSJ+yYrD+8iqVHl5mAdeTv56WvRR99uUQ==@lists.linux.dev
X-Gm-Message-State: APuU4Z9TulUPlpXj7MBuWoeDO1QiZMD5VH4etd/HqadsIb92by0emdpl
	RSFexRs/+WErUCSmjulsZS+myZRPz+T98y3/aCP00oVZ44fFnxd0wQ+H
X-Gm-Gg: AYBFou2qzmVtW6P+u8p+M2VEwSR9hWNnNPg52spH7xVcnpgb5Wi2gz+/frvNyuIzYEX
	LfVisLNlIk/m5ihrcfzJGLjFLeGrVLsaRJaUhQAavJez3blBzJJXNp8XEEhiMzPJcIZC7AqP8Zf
	RBrJJIi4tGWc6ntn06k6AhXBfuqOK/Ow72fVmZnSAH0SsL6dsrUyKPAq1wjegsfA39iQhZk828V
	gP5bSLJlpvYhF8dYir7szn6LduiavDo2VjFgBJl14jIZCXT3bdgJJ1BqTK2pLYPwSl6AXrHztPV
	GZVTMMzW2f4Qt+iiPSAA1RE+rUli6FFfCyK/zUOjs6x1+snvOPXdszW4Zo3Mu2ou0jJW7DKV8ZL
	3CYHs60H1DWq7qJc8sSe4asTjwDt5eO0tZ68bMXAXqyY7tsOJ8DvqnP/Fif2gvr0pCR77u5pRoa
	D7a9C3t1c3eEwkWOUaPjuZAgwNtNNcD8Sn7WldcfKAI0kM3RgqvvaM7+xmH00Mp+ky/xaNxW0Zi
	D6kOxMUoa5uh1/B3O/QAwAD/3EZtdicgmcV+AVu00svaTNuLl/2i38nm7d3PX+0esUJ6Wj1hDRL
	QPA5OwbAJh43n3V4k1gUoCOpC6XztAjLFeeAc/WsRtHjiw8rK0AP/TyIKICxfm5rJQLFYv4dbnc
	urrdcPGzMS36jGwsYNn7pa0wAhYyh+TCvIyXyEBoA2KEEqg==
X-Received: by 2002:a05:701b:4211:20b0:147:a685:9125 with SMTP id a92af1059eb24-1b25d28c296mr3676583c88.2.1793981963864;
        Fri, 06 Nov 2026 08:19:23 -0800 (PST)
Received: from localhost.localdomain ([180.182.24.11])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1b25e4840f3sm13139526c88.5.2026.11.06.08.19.20
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Fri, 06 Nov 2026 08:19:23 -0800 (PST)
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
Subject: [PATCH v19 12/12] docs: describe virtio-sound capture options
Date: Sat,  7 Nov 2026 01:18:38 +0900
Message-ID: <20261106161838.94308-13-mynameisjune111@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20261106161838.94308-1-mynameisjune111@gmail.com>
References: <20261106161838.94308-1-mynameisjune111@gmail.com>
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

Document the five opt-in virtio_snd capture module parameters. State
that capture_allow_empty, capture_allow_short, capture_packed_status and
capture_pause_restart require capture_staging, and use the ALSA kernel
parameter restriction tag for each entry.
Signed-off-by: Joonho Lee <mynameisjune111@gmail.com>

---
Documentation/admin-guide/kernel-parameters.txt |   29 +++++++++++++++++++++++
 1 file changed, 29 insertions(+)

diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -8344,6 +8344,35 @@
 
 			Can be used multiple times for multiple devices.
 
+	virtio_snd.capture_allow_empty= [HW,ALSA]
+			Retry a bounded number of empty startup capture replies
+			when virtio_snd.capture_staging=1.
+			Format: <bool>
+			Default: false. Validate with the target device.
+
+	virtio_snd.capture_allow_short= [HW,ALSA]
+			Accept non-empty, frame-aligned short capture replies
+			when virtio_snd.capture_staging=1.
+			Format: <bool>
+			Default: false. Validate with the target device.
+
+	virtio_snd.capture_packed_status= [HW,ALSA]
+			Read status immediately after the returned capture data
+			when virtio_snd.capture_staging=1.
+			Format: <bool>
+			Default: false. Validate with the target device.
+
+	virtio_snd.capture_pause_restart= [HW,ALSA]
+			Release and reprepare capture streams across pause when
+			virtio_snd.capture_staging=1.
+			Format: <bool>
+			Default: false. Validate with the target device.
+
+	virtio_snd.capture_staging= [HW,ALSA]
+			Enable staged capture using request-owned buffers.
+			Format: <bool>
+			Default: false. Validate with the target device.
+
 	vga=		[BOOT,X86-32] Select a particular video mode
 			See Documentation/arch/x86/boot.rst and
 			Documentation/admin-guide/svga.rst.
