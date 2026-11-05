Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.177
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793862576;
	b=Wum8L5bZ/136b9Ed+8BE2orgpE6I8/8zZsz+OlW4zXSH8aSMlFP7CieDJ1R2lXlNBpxB
	 fVatPOYQn5kjeNVBTDlnXBNhz4chhQVq0DljR/bBuoxDWDMX8woCqwCXLlCsensiDDGCv
	 CiXL1xaZGHqGG721GqB7cr6W7t6nNaNR78jn6DiwEXSxaPfilzr24geAbacnJWaDmP1LH
	 aWco2tlx9eXGmhGaiqMH9hyOCbufJcGybqIjsXdQ2c7G4rq1IxcMc3rujzS9vDWa0vKgQ
	 z5DdK2Aj5tSl+PpXlcfuO2C4/PrUiKykggY06KfQQE/5ivjDfg01O5YjswC/dpT/Duw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793862576;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=yx9qdA7I7keZZm8UafgJgTm1z4N4QlAmh4J6h6T4bZg=;
	b=j4Fvw3I7Y06YQ4Gz4gUOhmrN4rsOIMOPUhb4GELOiU+TWKbnQG9qRJ1tkayNReZ19WHg
	 Q/RIo6g8YNAsMIeBg8P3TgNkRT270dZB7KjKMnbFWt4CGzl45Z3caAG2eAJ5TaA0AFy0l
	 +s87dPM6QfhJUhGUSqzuKKyH5ki7F0pLbIZBdlVHqGZuzcex9ajtGOjUsMwno0tIymKIU
	 Sjsayz73ZdqyqXIOwiLVeDsU6xjn4XdJxY9YKCGYQX5eKpIOig8C7gGIHd8yGwaEzjhwM
	 +/MjnVjV3Cfycvu+Y+NHaENiqcK+RyVxKPu5wxldXe4tVzylri7ScB9jU4kyg6glskg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=CskS02d8;
	arc=none smtp.remote-ip=74.125.82.177
Received: from mail-dy1-f177.google.com (mail-dy1-f177.google.com [74.125.82.177])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A174F606EE9C
	for <virtualization@lists.linux.dev>; Thu,  5 Nov 2026 07:09:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A174F606EE9C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=CskS02d8
Received: by mail-dy1-f177.google.com with SMTP id 5a478bee46e88-36eb1cb7aabso64025eec.0
        for <virtualization@lists.linux.dev>; Wed, 04 Nov 2026 23:09:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793862575; x=1794467375; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=yx9qdA7I7keZZm8UafgJgTm1z4N4QlAmh4J6h6T4bZg=;
        b=CskS02d8PhyS7P8cRahlNpOXtMD5pHXhpkZmOVJ7zuyM+MNawM2v9oB7sGXGgdy040
         av80naXchRiCkvIZW7pm68KTLhvAbFHlAzRzj86zcqxBSCm31Gf4nzwi9UOxIpxmmXIo
         Isfeu2kS58Ikh6pvPBAuHGf4fhhV8LhhyfJxEEvW+DXeKEw6NOGeW5DZSSklrm8PqS1X
         7vmCqbpgafVaTTQSlY0p2LQPZX7MYuzV+MgZTCW7YBIqHfw3ti5gGbv0Qq+To4qTX6bm
         m/camybtjrCcHzs2AzcHBPDexOsGFSwKsBbgWEb7OtHx78LcAs82F1HQ9RB8BafuQzHj
         dPHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793862575; x=1794467375;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=yx9qdA7I7keZZm8UafgJgTm1z4N4QlAmh4J6h6T4bZg=;
        b=watz42z61CLhHWIIlgR/tb3BiTtG6TvPjfUqV4thVDCJRvbeniQ2Z2X0IIT+hb3av3
         3DN1uC8M8AEpLztaUNNI6D8PnH1WPphGsh4vtaRB9VDeHd0U72e+N6WlUdwEj80LpVLE
         97ZjmMn34m7MJYGd+JFP1F5YsVRoBaW7qFGDFIsNEnzfZjaRKEuLVzfgzx1YZZyuY8L0
         yDlpMcsYTdXJ5Chs9h/4yHeLOP7xN35wLAGpXOvHBqD2efUr3x7MmyCNlu8XgWdNUSFp
         rYOy34IxNRANwYdE/qAG6G72J9wg7uG41WnL8wI3gaW4SIxpxH6uEVd7lyUeNCmp6C/g
         yLhA==
X-Forwarded-Encrypted: i=1; AKwUvBzUK7/fvf8NbLXARCOOD3Wc5c7o3ZWTB2Rz1ECHQo78VsLOlS8IIhfuRY7t90v/8+UiEvpbPKq91BAd3KPQOA==@lists.linux.dev
X-Gm-Message-State: APuU4Z//ZAfTOoGnzxZKveKIscfozpvUHBq9UpbRnlwa7k5Zj5OQr2a/
	+mkmAmSI5wT8Tj9YekUoF1mwzSu15e/OVjcdPm7xRLcLtGqb4Z3168Lp
X-Gm-Gg: AYBFou0v4u9XnZVg12t5NlVR6byc+clz96pWTB/wLKWmKC845R+cHiAeuv316oVyaMH
	NADRvByCL1Zq40BFzoInwwLOL61irUFQ3yZ14d7E/Vyvmoa/Jms/5VWHRKiXu6m0/RGzd3iGIZO
	z968KtcbCi69W5h1HL1tlvawoK4KtL+q4x0Yb7cR2nbEx3oQONE9qoZ1Z52xskDGt3zCNalbzsA
	Tdb8BcrdPNpn4Tme7cL/ZwujcMsir24bT4LroWdC41EHY7VF2JDwWcZr3Crk0USmoZCBvs3yGpi
	GJ7hREkXuhl1r7d5KXx1bvqxLQaS+t62FkBmjzhhQ8Ndm2FcaQ5ho2DAKrq8U1QuvMls6aMCWGZ
	j8uK14Wz80y4N1djZ6yICslS+pr04XRMSlHMLgPDPEv4oIzQJnQCDOOf9JxDt9XdGcqTCqIplJJ
	rioY5eAW9jQFDfTgWpy2xPTNvr56JegjqOmqJ2+BYVT5PDHnEXd0ZeuZmNEEQJfsCR9gvva7KLP
	W/ARW6QlcqBzHk0EuOSnjCIy77ZSHAU+GqF8JtG5k2oUWh3mN/SCEBmVe4c60NGaDSQMtT1IhKL
	aLSImyH17WlpB6f6+Pjl0UuE4TfIWNvY5qJNtjLb6/a63fzFIlrEkDDYQPcLqlFWQdpXoYN2Gyv
	9BBqXvMdW9m/DPABomcedO7uy0mHsq/zpmaxmVLXYeIowkh4=
X-Received: by 2002:a05:7300:d80c:b0:36b:c491:93dd with SMTP id 5a478bee46e88-36bc491a788mr11101969eec.18.1793862574798;
        Wed, 04 Nov 2026 23:09:34 -0800 (PST)
Received: from localhost.localdomain ([183.96.175.225])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-36ca3981ff0sm16812286eec.24.2026.11.04.23.09.31
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Wed, 04 Nov 2026 23:09:34 -0800 (PST)
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
Subject: [PATCH v17 12/12] docs: describe virtio-sound capture options
Date: Thu,  5 Nov 2026 16:08:45 +0900
Message-ID: <20261105070845.6449-13-mynameisjune111@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20261105070845.6449-1-mynameisjune111@gmail.com>
References: <20261105070845.6449-1-mynameisjune111@gmail.com>
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
