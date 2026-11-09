Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.47
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794201427;
	b=FPO+7el4vStX+Q7etr5kV41+qfJ/WRxcPU3UPwoR5vbv3WZ3h4F2/ydN/SwofrTrUfC4
	 zRMmSWvi74bTJCM4f/zSgfGxV91DxVRuW3Af40WC3KDvBNkS9LM2tcjy+FIpyfOh5ICVJ
	 99/Y9u9TSWpeU8IArAoe2cGXt4qSLHaS7n+dlMC7+wdyd76iDV1nQt669co4Q+nS9bza3
	 XaBkDBBZMjjKSaXQUka2b5bj062JTAoJqlNMMkbekC218tmY7z/gRwXfqDlxTMJVYTCgN
	 ee9w1TSFADRXB13/Lr59Su9P4DZY28QxXJYp0bhKlgk+Hgh+O7vp+/9K+c3VlXaRIog==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794201427;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=GCeNfDJOwvZXuY8dgM3rlag3FgqE7583M6Aa4tPPS8I=;
	b=xGw+h3jPDPEBduO0e5MrDSQCIsUyRHDHZ1akHO2lcaGBz0RuxzEcoWau/fvM4Ek2HBdq
	 a+qX4/Xx02MZffgKBABAHprU4LGoI2IeERsU0I6R1VWS7VCyEkcVqK4ehkSqHBCC8W+J1
	 lvsYTOCIi1Ka72wj5FggNTV3wnIeFcxdpoz9ydUlhEqKZqBENKJgWa+Zy5s9+1k+TnLjA
	 NBosv3i7PKak1Eog+SPQ6pH6nmliofmFjrB0GVXnQPdIdQ8dXQq9qdoD7b0PVKJp1zlzj
	 sINtJebybZ1AGn1gyROVu7OhoyhpAfDCSZFd/gndlcLN0/AcxayYyMPDfPY0SKH4biw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=vyy4C1Pm;
	arc=none smtp.remote-ip=74.125.82.47
Received: from mail-dl1-f47.google.com (mail-dl1-f47.google.com [74.125.82.47])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02D6E606A331
	for <virtualization@lists.linux.dev>; Mon,  9 Nov 2026 05:17:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 02D6E606A331
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=vyy4C1Pm
Received: by mail-dl1-f47.google.com with SMTP id a92af1059eb24-1b3ada81853so186583c88.0
        for <virtualization@lists.linux.dev>; Sun, 08 Nov 2026 21:17:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794201426; x=1794806226; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=GCeNfDJOwvZXuY8dgM3rlag3FgqE7583M6Aa4tPPS8I=;
        b=vyy4C1PmXTYkOG8PVRosZSso/GC9a2YNsT9Cm23tiJgFn12ufI6boYvaGbFL2rG5Ai
         /VQ+EgTjo+iNj/hZzT0gZaWBh/qipnE4jx5rcCs0VK7YkUz6teYbCDHgmOVxb1+vsdVH
         6RiCamjoTg+WqIoqkMuDY84ob0+a1a832wa+oOUaoFSkL21WpowxL5QMdpymQTUOjVPh
         LVIaxMAs9RDVOoqO4eeKCPryqR/xYFaYzR8G2x4iLGuQ21kub3xj97acakbReukUdNsv
         NhjgZUeyKfEqp5kGKxsFt6z0Y1Z90FbQy/tJax4oL4TNEw/IxZQYhNGDwtCwE9aMFvoj
         sRxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794201426; x=1794806226;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=GCeNfDJOwvZXuY8dgM3rlag3FgqE7583M6Aa4tPPS8I=;
        b=QhseNMoG8zhRW5HQzc0fskQdKyrNJp3BHwk+TdsxqvN+O9CmyERQOBNnJ62hgu538F
         G+LYcrIdOJboDkBvnAigV4s3ht8x1gs4I2BmiwY6gDV5kCJ+n7Z3nZhnAC0JgTmC6RaR
         Q22n+OZyyWnwhhDdxsPPDqZwvvdY+elQ1w/FzS2krd8jqfm1nySozO/rVd6zlw7+U8Sy
         Livjc0n+z6/EbuWobf+PhONhhjGvp7Sy/THpA5uCJ0jCC61deIr8WU7AoeJqewjoiy3/
         nYihNLCeeLogLIUVEGe0/xuIbpD/bAzz23j1ao8W11Xt84zqOV0A3oh1aM+yx3gDGuTT
         +dSg==
X-Forwarded-Encrypted: i=1; AL+hErFmqJ2VaJ5gvCOVTyt4infNv0n88LTf3/edU0ikNn2WigaZVD41qY+YPFWn3yo5nye7r4wlvHyS1koFJRC/Cg==@lists.linux.dev
X-Gm-Message-State: APuU4Z+1Nprkcw/auLsgMV/BfYRPmKEhXQ6w9SdT6aOIBRMDNMioPwhl
	fceUCD0S+rgh32CBbbTXVwT4f48G4lV69gBKzREsjIriFmYDui2FNkgg
X-Gm-Gg: AYBFou24OHS+gcid3Ni9D35541Lo4eZSdoI+PEAtLhtDvk2QkNTvFEfT/B6XVE9T3h1
	WyI5pPVEcV/tVRhL/L/A8cu9BdHQlknL/HbEhlxN+B0inoCZVJsBAJunjeB5q4y2yDjtqXRrWto
	nuaZGwb7wWtb53rWBPTfaAOd0KYOJYQo8d9RWgJfIl1USFEjjT+YIiRSbs63rvYjxRN38vd1xNA
	451SllfRDXnoctFjkmj7L43OPVa6zxukogBcUOYrCaCkwZXBvmOyQbaxRb9W7aBhU3xYSWwBhhu
	eEdGysuhX02ef+XIfqAeFw7p9K5SZMM94MDW62tzvbw6NL5hfbsx8+VSM2lrMEXCd/AzPI9jFOV
	oG9nDL0DXTRSec+YV8fDDgXGCG7uVvXKuKXim5InaEmfmOYLyzE8YNOwjcOKgC48RG71AKZXqoj
	vW2ud88R40f+YBpuc4iF3R6ibPTq43ICrHZetuEoXYLMS6+JlATD3Mm+EDPb/n2d654sVy+HQLI
	OmFzULx40YB039ezgzh+nWSilCb03JnZfRMBpfczb444N81Frlyo1cCykc6Ty/or58qGJUA9AMV
	VM9ZY4hUrLCPnRzCpRD2OVdLzWrAuzCp9OlZkl2RmAi6EK+H9nxMjHXD9z9w5isgycHzjAzRWGy
	dc7dyyY0NIY+uBHmOPqvUB0mURtGR2zozU9HuiDjHuSAHqLmG
X-Received: by 2002:a05:701b:2905:b0:192:74cf:1db2 with SMTP id a92af1059eb24-1b39fe88736mr4979051c88.11.1794201426111;
        Sun, 08 Nov 2026 21:17:06 -0800 (PST)
Received: from localhost.localdomain ([183.96.175.225])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1b37314826asm11395635c88.3.2026.11.08.21.17.03
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Sun, 08 Nov 2026 21:17:05 -0800 (PST)
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
Subject: [PATCH v22 13/13] docs: describe virtio-sound capture options
Date: Mon,  9 Nov 2026 14:16:18 +0900
Message-ID: <20261109051618.22506-14-mynameisjune111@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20261109051618.22506-1-mynameisjune111@gmail.com>
References: <20261108235457.12688-1-mynameisjune111@gmail.com>
 <20261109051618.22506-1-mynameisjune111@gmail.com>
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

Assisted-by: LLM
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
