Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.53
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794461744;
	b=jk9mgo6l2ACC0eIhjKJDc/B1ScydE9j/oDwwvQhGSGtAgcgO4qLPwedmlJgGtE+PKFqX
	 YAcC4uDm0kU2OyIuU7CWZDYzx2dQ1fRlyQQeU0fr+2JRoOo8eqgd/R/81Yv2ItGuLSa7O
	 4MR4AQyZBQ9e4x+HEnlBWuKcqYTBQehCqw2JjYGx8XJadlre4kNS5dgphCPrXUvrNOltD
	 ELjXsHkiuTDu9VoMTBcY7ZZFxm3v7RD6425INXWZZBw+/iU9MrRr7PK3hX3avpk5ey+ca
	 vAqQ6zcwls8nvDeGenok9BPWnU8w0eOPtVVt1xMhISOgqUHQ6MnjuxxrJu8osGJyFcg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794461744;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=KO6ffwCtdr8RA7k8Fc5roNJODB8/sxhF5kvv5Zygm2k=;
	b=Nkjq/AxtIgWnP/Qq9mx7icpSa+Bc9MvORqZgk509vfaSySbQVqtJiOpL7vuDIkhd8fCP
	 IofeJqTr469x+cJI5R3PWjGiLYrgIJ5JkOfT4epTEujwfMi8JZ5L3SC6+JgduwWU8MEEO
	 0sGqo6Hn9sxjMXusy+obV61ydfkATgbtU8bxpiUz//MIoWeq2fkVq0xN0WLkYa3MMaUbA
	 +EE6QjjtMLphx7+ogDdJpzwCa8gF2RJpP8ChzgZ1rugi1io3OJt3ckt1t3b9r0rEHnA1B
	 GS9K7+VOreiCqOJtk/RVv8iIL77e+lhhoLQJXw8+qEfaMjlgUQqHIAtyeSA0fqVDbCw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b="BHGLQm/S";
	arc=none smtp.remote-ip=74.125.82.53
Received: from mail-dl1-f53.google.com (mail-dl1-f53.google.com [74.125.82.53])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7098B60A383B
	for <virtualization@lists.linux.dev>; Thu, 12 Nov 2026 05:35:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 7098B60A383B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=BHGLQm/S
Received: by mail-dl1-f53.google.com with SMTP id a92af1059eb24-1aefd1bf74aso424934c88.1
        for <virtualization@lists.linux.dev>; Wed, 11 Nov 2026 21:35:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794461744; x=1795066544; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=KO6ffwCtdr8RA7k8Fc5roNJODB8/sxhF5kvv5Zygm2k=;
        b=BHGLQm/SKLTjRIp2NM9PF5m2ge/QMWT9ODXrJblHInKdRsxd4Zm8lPlAeI5NozLb60
         B0g3pM8zTi+CrfaG9PNcvFkG/502LEfgkqLNTKgjZly3uaXfXV6aGvVSjLU8++VskU/h
         gCZ64hZPPuukLTLpeYZLZXQ/qV+YveGGFUENo6xiNW8CmmfySy16+9k23knO0+m+d5TY
         nBbYJ3a77gnJuKdfpEpFbfWNaKejSEb3n6lFtWLPBBEWhMfrp+oleSLWmCcmgKu/UQF9
         rYCV+Kg9uDllTFs8YjBw6xkujduSEKbfteTxLgyfuK6k+0U8SywfveZS3Xjy18PkEkT0
         HRtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794461744; x=1795066544;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=KO6ffwCtdr8RA7k8Fc5roNJODB8/sxhF5kvv5Zygm2k=;
        b=aSdXvR9Fl+MrzmcwOWUPt6qszj6bRAtiomB+92wEvyC6jMfVvu63woIgi3bd7c00Kj
         4goP04swFcCTw/NbL2AUSOdYdDfNC0/yP7yTm/vssDLDKFjseSvkor2vEm7Od01P7ql7
         5cLkGvq8N15FMpnrZJ+xpjFLQ/xw7gsEUuQXdtPK17/BMyNiNyy7NtUFxP7Y5spT631c
         7bCcGB1Tbe4rQneyy4a+2wUKgoCF6DucaB1DbuM3Q4wDUJbnCYjNWszu2ryj/m++eBD6
         IZ9WBgghUY533kZMSHDsug377JhLmRGZXWHwmU5ddSRnvAwFaNJVclKepD10RxdXrhJ2
         6Ksw==
X-Forwarded-Encrypted: i=1; AL+hErGBWcCKuKhNUe6sZDECePaCimFAch9SmD2BOfcNnT6Hmh87FU1FSxQRibhBcGoMVuLE3RBJUNnm61JR1RlR4g==@lists.linux.dev
X-Gm-Message-State: APuU4Z9GVQOWT7YrDstMMx/kc7uNMHqJRO9jSbAEE68uEVXAMMUzpWin
	GzWJAbOOXkrqrcowSlKlZgqodZNmV7UdZQVAzh5WWfpN6mwAc0RVi8DA
X-Gm-Gg: AYBFou2RRmKV36NP5dnZChcdD2FWCLZgxPbglK/P8kVFQKGomU5FxhcuUbyPqZDqwSp
	S7fIs7QKtY6QAC1rXxM7J0gDEvFktYZi5hHcP/THQAeUpo8dMe4zJpIHNZGBpgok2BjWT4M+sYL
	kk0EEZhFFGWif0b7oNIx7W/jTnjHDzbKfn/3LUZ7v1O+GOHbNt4BVS9iIBERN6GHoWlg+Kii9oR
	FmIq3OyrXhZrYodm/nGZhkHM1vGdSU//UKpj9GpmQmQ7UQ8xUo3iWFGIA+Y6z6UKAoViQ2kCwRu
	RG5FHRJd+2Mj4AOUNStZl2TFhjvlkHm5SlfGpI3zdbJrLsgsuHB4vHIIcX9mz+BceBPvGjUMqI7
	LYCoa5hn68L8DKRt8VNoh1HNsJ1lZKmv/g5keQdy3vu0gG7KKUr7e8ollM88WRMhdOb3aoU0GMx
	Ti2LHn8dgr7qinE01/KhcOoVNmwGHdU5U7Lm6GYnPNmFQVMs/icFswz7lsix6gQvxYSI7xGg6oj
	C8mCF8Ar3Sd/7YwrgQ1wJM0AcnSnhooH8YYfTS+ZLnkOrDCBL+0hg7V7j7KI62Le2SWnie5/0/7
	CCqytWKcwaAAF7InVPuTAB1OSeTWTp0h2K+vGmgK2n8Ibq0EW6dYxPckUBrIQGBSPv9Nigpm7iZ
	UJmcI3cI8rHCd7BureY2vCxEG/iHsC5hnOltK2hKlFYBDqqNK
X-Received: by 2002:a05:701b:4594:10b0:1ab:cbd0:1c96 with SMTP id a92af1059eb24-1b4f5f1f344mr1354843c88.4.1794461743623;
        Wed, 11 Nov 2026 21:35:43 -0800 (PST)
Received: from localhost.localdomain ([183.96.175.225])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1b3b5890c0esm21953240c88.1.2026.11.11.21.35.40
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Wed, 11 Nov 2026 21:35:43 -0800 (PST)
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
Subject: [PATCH v29 14/17] docs: describe virtio-sound capture options
Date: Thu, 12 Nov 2026 14:34:43 +0900
Message-ID: <20261112053446.73504-15-mynameisjune111@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20261112053446.73504-1-mynameisjune111@gmail.com>
References: <20261112053446.73504-1-mynameisjune111@gmail.com>
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
 
