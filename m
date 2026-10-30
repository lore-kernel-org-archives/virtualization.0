Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.215.171
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793338034;
	b=E8lgXHvY2eBUOEJFnMNAsQm9rB3B/Tno9LuYNrGUUqer5nXANhtL/PhEaYbOw6pmikW+
	 ra62uNUte49QDhUjHfmHtCNuf5NjsDps9blt4JpjrWFQPX5/1doX7nWZEdSYxiq9I5ZvH
	 +gtvq2TwP5scxNE3Gu0Xvdq9C/O9NbRpaeLCaZ9dBhTOzSDXS4vScNeAkw+9TpMgjW8Bm
	 AO8K7tnIwxaIumoRW5wYisGTwjSgueLy75ZrymsZS8WkXBmfXwHcYqTOaODIayU75it4j
	 xGu4Rv1ueUgstMRotj34XmlvtQYcCVN6SuPNC7NKMgwDZXpY/HrEop3l/mLCRXpA3WQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793338034;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=BRslTI0ynJSL8rFIMfwDZ46YUeqzoiUybS2SxS5DQ24=;
	b=Rtvox/G96JcEOYpt0/F7tNjhOFBzw1bDdyAwR+QepBL6s6QgRKSgJCh0RwpEkZKq+0rK
	 mk3/q/u9qY80lbhvXdDKbwiRLDCiOiEBLPWvYGV2nYAqwRas3D9O4vBuP8rrs1LrNavrn
	 J1maTEFe8hEpspZ/9stl9dR+CyBeMkBZUQVZt1imP/oCvQWL6Z6cOSfhQTpMl3rwNuqY8
	 N7U7lNQ3aa2BxxgeLDyCosheoOFZ0VgLpGGYgz4M/EhYrhmkzseaL87stthMYb8Jhg4Y3
	 yQ3QPSvWudiaYJh96hivHFFTQQm1lxOLXvnF1BA8y96fuWsgwHasKfmv7h9V8X+0GRA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b="H/VySdNV";
	arc=none smtp.remote-ip=209.85.215.171
Received: from mail-pg1-f171.google.com (mail-pg1-f171.google.com [209.85.215.171])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C81FD606A31C
	for <virtualization@lists.linux.dev>; Fri, 30 Oct 2026 05:27:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C81FD606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=H/VySdNV
Received: by mail-pg1-f171.google.com with SMTP id 41be03b00d2f7-cd8ba7c2694so83169a12.1
        for <virtualization@lists.linux.dev>; Thu, 29 Oct 2026 22:27:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793338033; x=1793942833; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=BRslTI0ynJSL8rFIMfwDZ46YUeqzoiUybS2SxS5DQ24=;
        b=H/VySdNVWZsVKQD+hLKxOKPGPzuHJl0VM4rRBc1CaCM1ee3kn0bffkt0XhQHsMaUOE
         haoEisiHJpnWdLQBvWrj9IjXLbwFFJlPBTVs12zEaZg1w1hqZ38EjEniK1egk8e2fFRE
         aE172iVts8dK7BFhsLIza9gpUFNLIeXh0GB6fGHaesWDPNWzT+PWER4Jh0AdRBE4gaqi
         arLNjL8BBg3D+t2i85ca8ikHTnW6kslIU6ZGBp90tzEHD7tfhGMmDwA/5LqRQQNXubSu
         rk6/wY+4PZprfwD1PbJMuAGK3lFIN1pAQ7AbaVMv14q3R82vdpyOuxIq+XbUW08WkrYT
         QEyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793338033; x=1793942833;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=BRslTI0ynJSL8rFIMfwDZ46YUeqzoiUybS2SxS5DQ24=;
        b=yR5Kp1jKb8uij1uHpRw2VEeHZnBClyAG0m4M5MWP0prGzRWnG3yCdR9OMTb9kyUg66
         D86pKTh7FR/V8jBdTotih/ezOHOTjKocgysSW0HWLOWe9JTFobqvcbU2wYM723+snLev
         1BfuaiBusWIJ57uQm4TqHat7Vo2rB8S8ULPefpjXYMUFDGfhCm2n1qJtMLlueUS+CZwG
         mcGmPiOMeaNQ4jdeVa3a8MYCr4F78Pw8tRe47T0V3SIv+rDMVSQp9Rkiol1SLvcaKvzi
         mtv8fokKqUUa4pbOZtbHY85B6S+LF8xW5zQICI4VCpz11Js1yGM2bnDOm0JacNzg439q
         sy1A==
X-Forwarded-Encrypted: i=1; AKwUvBx/h1+ukdFy4QaRVrcJYYH53c9Bh6ukptBOJUWjwX60JogB9DysRpTHWqE28MLDZLeWtZrulTZLP6aCEYQi+w==@lists.linux.dev
X-Gm-Message-State: AFq9FYIegNSwjokWh+x+NxX4GB2WVzw0Xt4ZocytFKM1QAJ2Tsocm11L
	XOcbsRk7rVD5AeEwubXFBtzcl7BfdXa+lTHT57nURcPfSrht4op5vqU7
X-Gm-Gg: AYBFou07b2XNd0QuZ8j8FHKVQwe/h4AfRY8QcpvmAUzkqc7uCs1LA3CG7zJtP3lHyoq
	YSPXSZpOhVPqUV2+zTVPYlZzqnYarLoVaP4w3FJFZ12L204ysTvpD5zQJZWfbgkra33M9WI2yZ+
	frZURWgvKLpq9Kklk7R2Ek/td+9+YDeQS6DrSZLIwwbywtCs5OhYmVVwYze34tu71J6DLv9utDn
	8LPP7Yk3tkbQqm76DubtacdImAyRC74E+H9gvEuhK9bHItEtEbEQAGKe2czsSZ3oS6+4Mkv9xKg
	kCEnh6CRM8WwMY2ufOBbb/XiftYV2V5Yo/BqRRRt6tesjDmS5cnmXleMeEJwrpSxz8N24iTmLYc
	4BWMWYx/gDu2m+ljMuZomgNDlF5f+2tUKPksKaPtG5ogHRa1NyF/C4rFWajLj/l35u/4N9+6qdt
	VeinyQ7YRN9WlGG7g2/AVrdvHcvCo258VOxxXkCapawEP769irfKjav+NJEC+85XkSV0HOO4nYe
	++E5tRUqUSSv9XWmLpEnuPRcvxpzwIwyt9Ag5hWCsqlAVyn90r9JjKlJQMohRI/1Sk6IO3eDPZN
	1oISPcC7aokQlFvs+sfy/KU8YP4IUiifIsIdvk56QwIr4C6Ir1cfw1wWO6eyIKK1h+dv//FpvfG
	T2C7V3TADfdPeFk3bxmo8jxy/51Hr0Ywn7CZfoG7/7zjKnbo=
X-Received: by 2002:a17:90b:3b4f:b0:3a8:6a04:80ef with SMTP id 98e67ed59e1d1-3ae8957a24dmr981624a91.6.1793338032263;
        Thu, 29 Oct 2026 22:27:12 -0700 (PDT)
Received: from localhost.localdomain ([183.96.175.225])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3ae845429e6sm2421027a91.6.2026.10.29.22.27.09
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Thu, 29 Oct 2026 22:27:11 -0700 (PDT)
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
Subject: [PATCH v10 11/14] docs: describe virtio-sound capture options
Date: Fri, 30 Oct 2026 14:26:26 +0900
Message-ID: <20261030052629.27742-12-mynameisjune111@gmail.com>
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

Document the five opt-in capture module parameters introduced by this
series. All default to false. Describe the startup-empty, short-payload,
packed-status and pause-restart compatibility behavior alongside staging,
and require validation with the target device.

Assisted-by: LLM
Signed-off-by: Joonho Lee <mynameisjune111@gmail.com>

---
diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -8328,6 +8328,36 @@
 			brightness level.
 			default: 1
 
+	virtio_snd.capture_allow_empty= [HW,SOUND]
+			Retry a bounded number of empty startup capture replies.
+			Format: <bool>
+			Default: false. Compatibility option for devices that
+			require staged capture; validate with the target device.
+
+	virtio_snd.capture_allow_short= [HW,SOUND]
+			Accept non-empty, frame-aligned short capture replies.
+			Format: <bool>
+			Default: false. Compatibility option for devices that
+			require staged capture; validate with the target device.
+
+	virtio_snd.capture_packed_status= [HW,SOUND]
+			Read status immediately after the returned capture data.
+			Format: <bool>
+			Default: false. Compatibility option for devices that
+			require staged capture; validate with the target device.
+
+	virtio_snd.capture_pause_restart= [HW,SOUND]
+			Release and reprepare capture streams across pause.
+			Format: <bool>
+			Default: false. Compatibility option for devices that
+			require staged capture; validate with the target device.
+
+	virtio_snd.capture_staging= [HW,SOUND]
+			Use request-owned buffers for capture data.
+			Format: <bool>
+			Default: false. Compatibility option for devices that
+			require staged capture; validate with the target device.
+
 	virtio_mmio.device=
 			[VMMIO] Memory mapped virtio (platform) device.
 
