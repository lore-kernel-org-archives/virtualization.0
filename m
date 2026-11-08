Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.214.182
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794182171;
	b=UqltR0aPVU+Fg1ScctMeq1scRVQLyA+85kBmTTsZFfDkub88KGuXzUGDL4Qs+JGTRstw
	 7gizra8Ag06Y5LhzLgxaenA31IUavSDW9acVtgfezu2oOSb+pUH4+MFjxcGYXpx1X3P2a
	 Dye9VNBtt6t6217O4+YE9lizdi2qcvw4E2PbNDDgQeZYypN64yJvWai9HJStch4rC3FSt
	 mywBSaVhAR5cpZux6Vp6ibhG9wj/jYgVa/SbdPhBc6i6cqZJ4aClnZb7DhRvWmWfQwUWs
	 /ThckanP5g4YNt374EIDkvFFAxltmG2+7RtHslUfrnQmae77vZ1e4Hgx97b6ms/DXeg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794182171;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=yx9qdA7I7keZZm8UafgJgTm1z4N4QlAmh4J6h6T4bZg=;
	b=okNbOUpjhkUo6+MaxRRGmJrfCOAE8B6DUDPlyAw47p0XGTER/AGks3mG2HsFAtSoLvvH
	 aXFLLD5UsluN378X8rjIXeNL7Yy+te1aYN00shFDj9oqQTI88Fd1PxKjHR3WGLu5ig4Do
	 F3YGhnq3hCsslS7jenYe8oqhEJZvoNDmiTA/rhIcckHDH1WrrPdWFTefR7KYT0NkjK2wq
	 Pxmljhst5Wh1aI9/5kosj9TRuTIFBwY/HRJv6cbqFrhajzlJdDn4dK1t/L/O3r16Zo9BF
	 GcCVTnQKudCb9BC2arJicgt3k4yy+KCwaMRJP6vlPwdzx+FAHhvEKM3cAcGXQr+JUhg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=xbax8NtS;
	arc=none smtp.remote-ip=209.85.214.182
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9B12606A330
	for <virtualization@lists.linux.dev>; Sun,  8 Nov 2026 23:56:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E9B12606A330
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=xbax8NtS
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-2e985106c0cso2346425ad.2
        for <virtualization@lists.linux.dev>; Sun, 08 Nov 2026 15:56:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794182170; x=1794786970; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=yx9qdA7I7keZZm8UafgJgTm1z4N4QlAmh4J6h6T4bZg=;
        b=xbax8NtSH3RCypljtToQTGkaT0J9bPYaItbMd6Iz5g3MLuRxBWhZAEpeGWphKKW0fi
         GtDyLe1LAg8cfWcXzN9j3xGgSMgrZ5g1Nk8Ds9BDrxWToM3bcUCrN4uC31mxS6sMFtG0
         yxafS1dRlSuXGRQrMXeOAUqDCNuF/Re0vu7wykJh79NiCiSyR9D0qLdh8ytM7JLwOUx+
         uFqQQa5l30V/RlY1V0x2xVICONvTFStv8FSbX4TdjrOMJoEHuFyIj4Nj78ufIS2N7cXv
         kz9mFDyq5FtGQ2HKwXQTBICmZC0qMMCtyhMRc0hxYzpM/YkjQ1tEnRtTk3uOpInL1Gr1
         yKlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794182170; x=1794786970;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=yx9qdA7I7keZZm8UafgJgTm1z4N4QlAmh4J6h6T4bZg=;
        b=tVhDZ2sOQizyhJ30tsZKQ3lip/00jQSVs29YVj3/QJLZBejwtz5fsANGs9xwepB6Pc
         TIXU3yUSHfOygArrFIZRVX/VJuLtrFkiMZsbuyaQpNLeT1BKc1MRwZOSJJ24RXx1pI6B
         u7FTCdJ+PUXpUKEsnUZ77llQ7nlMZit1FLDuSJtqDib6B8zVa13Ot+l11WIIwMpZA8dz
         vvhxweKqbWOV55/EfquNcaIv2LHJmzIkAuHhUyCuZdY+kJNDspttmV1wgaUrX0pLUlc1
         qRazy4L6kpopSDtPWAPv21fpn3NG6WcTnzsPGaejbUUM+2Mea877elEk8wM/XkAabonL
         Oorg==
X-Forwarded-Encrypted: i=1; AL+hErEGYw8h/ho68B5sZCh3vfEaW2fKPds7UKLHl9Dltv2w2jVo+oLIqMDXgTtRJtejxbb2uvBy01RxjB/jaZfDtA==@lists.linux.dev
X-Gm-Message-State: APuU4Z9VoGJW8l6mnm9oGX8jHJ2RVlEdF8bNzgZQVhpRNI1Sug29aZsS
	3VxeqLHDkycF4RrHcW/MOS8QL2oRKaKmGjolyXDVcZCqLpvey96seYan
X-Gm-Gg: AYBFou16nhAIMhfrM0GbqN2bnEQ54HuLijLKowid6MDlfwHqKei39Vzo/B89/lRT6Rx
	9//kH+9DjGMJVqO3bwlYxPocHNSNVkEuBAmn8pxE7UTGR+wKIae8EulnO9SSHaAa4nIekzilJ2R
	oMflihxCzA1J+YXhjHV7OGXep11IwCIa5gDFi2y31oJQ3b/FzkIRGg3a5ltcWTq6V3T+7qUwRl5
	5gsGBoJax/ywtlTDNEYAnkP6CdU95zd0vhQ/kgJJtweDWQ6t/LGfRWbYYka6HWIsTltySTK0uLs
	EIm6410BDsSR4fcrDNNklBxfE2MfNneNpeRxpD/PsBw9xc0QDUJAOQz7iaeXyuv/W9hsvw+RhBF
	jj49EGsQJz6c7uvw9+WouPs9IF1oRNcxQkRPaJk4rFXhItCCiJqAqRXxiA7T2DLLYq3Ug2gKc1j
	NHFJFJkZ7zoRNaQarIfzxTAUDLw6EOOY6xPZUpIStMECQ5BiER8f9t2B4YqtMGU54sqqqNBDFOV
	Y/bfJAYfscaZMpBsQ6laovsl/AkgUp5Dat+W3aGB2mUQcA+d+ZvVzzmhT4vfoUqFfleOpYQYe3k
	bunGEPKnQCLcsGKqb9eff96w0NC24CMHwUzDFeWqNSLFznUOrZvTe6w+vJ9DSj0fDLVppoydZ8Q
	iyCSKRyF1g7YAAGYZOAHFyYEUEyaz4Ejc5UQq91xccpRH2O5E
X-Received: by 2002:a17:903:3810:b0:2ed:123b:97e4 with SMTP id d9443c01a7336-2ed8375be01mr25102705ad.15.1794182170303;
        Sun, 08 Nov 2026 15:56:10 -0800 (PST)
Received: from localhost.localdomain ([183.96.175.225])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2ed81722edesm6095215ad.55.2026.11.08.15.56.05
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Sun, 08 Nov 2026 15:56:08 -0800 (PST)
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
Subject: [PATCH v21 12/12] docs: describe virtio-sound capture options
Date: Mon,  9 Nov 2026 08:54:57 +0900
Message-ID: <20261108235457.12688-13-mynameisjune111@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20261108235457.12688-1-mynameisjune111@gmail.com>
References: <20261108235457.12688-1-mynameisjune111@gmail.com>
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
