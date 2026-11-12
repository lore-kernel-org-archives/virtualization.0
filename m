Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.214.171
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794464745;
	b=YfhtgC6yhty6+AdypDKlx61MTYhtR+b9qAo9TM1hXMgAK1jnQMIFmaqhVA13Fy+T+eKv
	 0Zwaidl9e+5VudmRiXcY+Rr4517WhI9/f0serwPXgOVb59J5ehjfqQ2Fxn8mSUJwNMInA
	 RT4iTEH2YU92lyGD9BZw7n25XsHy5pL1MkyfHF2ZtKu26Vjm0VpbNiwM9GYfOu/qWDYXd
	 yyGbJ/grSVSwAYUaFiD/CPw84emKIwGfvlOE+GpKSxQ7En2pV4/Ncbapvo3rpQG8wDzZ6
	 v6EanspwQqZbEEBM5HYnvjpsruSbR/4Rz4cksp1gzV2GrhQFJonuRazhLqT3mir33yg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794464745;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=KO6ffwCtdr8RA7k8Fc5roNJODB8/sxhF5kvv5Zygm2k=;
	b=mShdPfU6J54kRMizYdlXodEqtbHMjCZSNjNvzGeG+6rTawHzQz5R0aQHg3YTbfgRBlz9
	 TITlCSUiwHHwx2JNPwMGZBKPh6xZcwX/3DGZu5q1eYeyH3d6GCE5uAm/HhomYcxSqCrfp
	 p0lRbEFo3WSn1wUC2Md6+T3R0F2WctO7t/wA9u6oXWWsNiL0ZKVYQXGjXZ0tNhzuveBPM
	 yTOft0gRIpJJtLcmMPYM04V8yxiGi/UTi9QxYgS2cGr+ZM2YI208NKtH0EAgvA7tebWp0
	 tnw7XiW2M2vYZLspMUtrIiyeT3KaMs/DD42uGwKUFGAmM8GUYVX1k7X7gZ9+2ImBQDw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b="lFK/18Rj";
	arc=none smtp.remote-ip=209.85.214.171
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B543606A338
	for <virtualization@lists.linux.dev>; Thu, 12 Nov 2026 06:25:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 5B543606A338
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=lFK/18Rj
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-2ed2bfe3252so14750685ad.3
        for <virtualization@lists.linux.dev>; Wed, 11 Nov 2026 22:25:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794464745; x=1795069545; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=KO6ffwCtdr8RA7k8Fc5roNJODB8/sxhF5kvv5Zygm2k=;
        b=lFK/18RjNoMJd6VrotsYhFs+Nhns2lYXTqusS0tpjnnH2kLdqIkpRhJLpHs0KxcF5a
         BHWIXTJIAcZ4O7Bl03xnuxQB/WN+Jrw6V4pxStJnRnpmcNPeuGzR9nwm816QsKugAaYg
         ktQ+XGZ9t080NMzDhU1tKULqjA1qzb3FJh0VPPYDQm/qYnanln2cJnNgJKXXgrM9Q2x+
         IQmY5nVjGZNmKreFz9XsZEZR2L41t1vHuh238eWkWtPJtuxBoTgLErRLNr2MwHPZPSsU
         QO4hJknTMKMsY0CTr9XE4hnQF8tbsbIBtYcfVM22W9q9DXlA9cCtSXHT+pHqBqUPQS6C
         ac4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794464745; x=1795069545;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=KO6ffwCtdr8RA7k8Fc5roNJODB8/sxhF5kvv5Zygm2k=;
        b=biaZUqr22oY8N16r+pBR1XashGkw94Xgg2qrTNaTj0YfEQ6Exb8j2bMW4JXl3JeVBd
         luCC+990QhhUJy+ZPwFDVh5dHbzmtp92u/O34cFn19hObHRwbytTMFHGnWuFUuc7n8YY
         wlzMFbHmf5vPTaa3ZQb/JY//498KtnA1wvNFgDwsotJN6Sh4T4ntngvlnJYy8tghqXfK
         3eH2bG4WDq1lhcL5yCmoUqApZqx/wRDfS2cOriuff+Y1MKpDVPuvEvWRNr+5adfM2sCH
         yBNmQ+9IOpWgv/BKw7M6ZDHL/SrUvLhBIp1MtUHMn8tPn3GAXrNbiZOlWkIsDSr0iBbR
         ToRA==
X-Forwarded-Encrypted: i=1; AL+hErGOOrWPJeXw7dQ+RSjv9Dbrkvp71JOzCkWRQ9PXulZQt6aXR2BKOfFTHxqYXAdHfBDSjMQc9J7VMn4YwZq6Dg==@lists.linux.dev
X-Gm-Message-State: APuU4Z82ES6xR1NaT0KlWRa0J6MVP13IScdkgBinUsR+D/43I3PXqobV
	a1suDMX/CfUcMNwAVqpfdwLXHfbo2XhaWBQueiRw0abz3GtTVdpo4Ny/
X-Gm-Gg: AYBFou1TdSWWHgOLelvjnlXsoSZ3Cw9eSPSrhJyyq4S4eTl8e/hsuImqdXh7cLrX2uW
	lV+aTLtfyPvulmiBfIW+Nl0LUwkPqnzE1hOZsdgdi0RQklRkGUJacWKoik7I150jPWY6X7l0yCZ
	XvOIyYYO0lw8ZDCi3dyWpvf270wzAbJWi0yClj5Guy+ztsUg6Xp8VF1hR+tXPWgTFC0PVFZy9L6
	tPCrXfCPaK1v7Ia9C8HyYEFsC0ng3vFY8DPprzUZXr/+5gDCJpOxfYm/XKOXaAUK2ORVLjEDFtY
	GaGvSezCEBpFS0/LWfzFl6wSYcorng0mC8YwErnQ2STJakspltjQOB9BFC95gl0J07ilhmjf/ed
	+CnDopTVP9duExQ1/YswPHDUtdfA40xBp4dZ7LuHtlgih4kTSrdYSys89Elj4R8AC8yoD/Gfwsp
	aHaakptN4lF1tt6bTW8vVTDYqagy2fP+vc8vFZuHS60mHSSZD71m5hAchhptwlbho4sbjgHvgYt
	ILvr8XWqmYi1iF6L2+mb/0855I0ddV/c0m4Hi1MgJCwjGeIhpuDr5qncIMCWYFAsAM5+I2QFMYp
	pLxIDMiMuxs0KxZLJ9ne/G0VMJbiVbsT0OIerelyq9E3NfSSmBcXm8qBW0Di7Z6loX+6k4ym3BG
	503GDTJIjgKp3LhhSMDGVJeKycaEk6xOoJ5vzuA/Ut7d78rQ=
X-Received: by 2002:a17:903:acf:b0:2e9:64b9:a333 with SMTP id d9443c01a7336-2edd770a9e5mr49212615ad.19.1794464744712;
        Wed, 11 Nov 2026 22:25:44 -0800 (PST)
Received: from localhost.localdomain ([183.96.175.225])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2edb6a3e61bsm26979965ad.11.2026.11.11.22.25.41
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Wed, 11 Nov 2026 22:25:44 -0800 (PST)
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
Subject: [PATCH v30 14/17] docs: describe virtio-sound capture options
Date: Thu, 12 Nov 2026 15:24:43 +0900
Message-ID: <20261112062446.159-15-mynameisjune111@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20261112062446.159-1-mynameisjune111@gmail.com>
References: <20261112062446.159-1-mynameisjune111@gmail.com>
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

Document request-owned capture in the ALSA configuration guide. Describe
`capture_packed_status` as default-off, reading a packed trailer after
returned data while the fixed status scatterlist remains the default.
Describe default-off `capture_pause_restart`: pause uses STOP and
RELEASE, then resume uses PREPARE and START; disabled mode uses STOP and
START while retaining the prepared stream.

Note that on MMU systems request buffers are vmalloc-backed and
page-rounded individually. They remain allocated from hw_params through
hw_free, and capture data is copied into the ALSA ring.

Assisted-by: LLM
Signed-off-by: Joonho Lee <mynameisjune111@gmail.com>

---
Documentation/admin-guide/kernel-parameters.txt |   14 +++++++++++++
 Documentation/sound/alsa-configuration.rst      |   25 +++++++++++++++++++++++
 2 files changed, 39 insertions(+)

diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -8344,6 +8344,20 @@
 
 			Can be used multiple times for multiple devices.
 
+	virtio_snd.capture_packed_status= [HW,ALSA]
+			Read an explicitly enabled packed status trailer after
+			the returned capture data. The fixed status scatterlist is
+			used by default.
+			Format: <bool>
+			Default: false.
+
+	virtio_snd.capture_pause_restart= [HW,ALSA]
+			Stop and release the stream when pausing capture. On
+			resume, send PREPARE and START. If disabled, pause uses
+			STOP and START while retaining the prepared stream.
+			Format: <bool>
+			Default: false.
+
 	vga=		[BOOT,X86-32] Select a particular video mode
 			See Documentation/arch/x86/boot.rst and
 			Documentation/admin-guide/svga.rst.
diff --git a/Documentation/sound/alsa-configuration.rst b/Documentation/sound/alsa-configuration.rst
--- a/Documentation/sound/alsa-configuration.rst
+++ b/Documentation/sound/alsa-configuration.rst
@@ -2537,6 +2537,31 @@
 
 This module supports multiple cards.
 
+Module virtio-snd
+-----------------
+
+Virtio-sound capture receives data into a separate request buffer for each
+PCM period. The driver validates the responses and appends frame-aligned audio
+to the ALSA ring in request order. Valid short responses are retained. Empty
+responses are accepted only during bounded startup or for requests already in
+flight at STOP or PAUSE.
+
+capture_packed_status
+    Read an explicitly enabled packed status trailer after returned capture
+    data. The fixed status scatterlist is used by default.
+    (default = false)
+
+capture_pause_restart
+    Stop and release capture on pause. Resume with PREPARE and START. When
+    disabled, pause uses STOP and START while retaining the prepared stream.
+    (default = false)
+
+On MMU systems, the request buffers are vmalloc-backed and page-rounded
+individually. Allocator rounding can make total additional memory exceed the
+ALSA ring size, especially with small periods. The request buffers remain
+allocated from hw_params until hw_free.
+Captured audio is copied from each request buffer into the ALSA ring.
+
 Module snd-virtuoso
 -------------------
 
