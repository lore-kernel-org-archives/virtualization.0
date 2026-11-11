Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.170
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794365872;
	b=0y97ywzYJtQ5zrCdlTa/tEcZ4n1F51Z+9Q8PVrMfpOBvbqnM2hNisYekU1I179Su0lk0
	 PWu6szcnCJOdEyPNjNOV80JR6Y0EdcKlUJ/XyRXBNqBD4w/5v0jTTLuLmS5f8GO8VyTvT
	 aO76fzlk6DxSIz/yf+8mVYB6ZIXNVFZ7NnhA9LEs6YMsQDuBEsL51HtivZDWvoo+FpTK7
	 ak1bRKwo/5DwnhPZqdfqfCtEaQQZLAoZ+6ii0cQMqFbk/+y3t/r+QazzIHpK1Q0EuHjjO
	 TIx4ygmgowJunT5Rr1Ci5iiQ2lmIFfiQwxdYGCW6/YNvdSoy49KaiJ2bW438tPNjRog==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794365872;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=Imcpwr06twHG+OjD/ubqaM6iJVR63FkGpgLCF254lbY=;
	b=aVyhqmzCB6WFR6xniqCG3B+QNY5itqOpb1QbtGTX9R2kyZvAp/qF1daHLQLOqxPeqB1q
	 StPV5g+aabN0k6WZgMhuEf0eXH68p6/gqyhXq6IzByR/A5p8wGtwbnNcPMilt6O+2JVuA
	 Vtgul7bIzHx3OqKQHjC7+JCgedqLAjTkm29ediNZsdUb+HunTS337lw+yKLODtn1ZRzxq
	 N2f8VFpqQnDygMcCQlt1W7mnnYBDTd0UjCeXYlilv/Oe8hC3aEd7frQlvxT257bT9G417
	 2VKRa3Fbvn7wWRcbejhNwMpYWiGMrRT/52v3n5We5stGE8/L8XWqm3ZaktIs6MYcEow==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=vIsmPVp3;
	arc=none smtp.remote-ip=74.125.82.170
Received: from mail-dy1-f170.google.com (mail-dy1-f170.google.com [74.125.82.170])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C36660A3830
	for <virtualization@lists.linux.dev>; Wed, 11 Nov 2026 02:57:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 8C36660A3830
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=vIsmPVp3
Received: by mail-dy1-f170.google.com with SMTP id 5a478bee46e88-3282db206d3so2267539eec.0
        for <virtualization@lists.linux.dev>; Tue, 10 Nov 2026 18:57:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794365871; x=1794970671; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Imcpwr06twHG+OjD/ubqaM6iJVR63FkGpgLCF254lbY=;
        b=vIsmPVp3/fkLMfNOtLiMOnLoGl5+jkP+idk+rFX7j3SkED35yJX5jPG/LwU6vBBjrL
         rAOPfe4jF/kAuOhGEhv9kCwMXND5jb2a3AIZtsdm8q2Tj/3MfRFW6ppLg4moDm/S89qL
         lDa+sUsJAiCte4YaVhZz4f2SL7zaCPdgfBsOpYnu0ADXMg2baOIUTUzG4keE2xbvY1pz
         Lz3Vs8+dUu7BXcvqTEQvUnNiTy9LBI3I/BZSorZ/nLKNbO4Xq8vtLXLFbflSCAOqxuZg
         qnuoFM2uhlsH8SdL0hrN7A4XhfHKt2wv133Uv0tsYXp1U8GYgDGS3UK+3tHCnonx8oPX
         2lIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794365871; x=1794970671;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=Imcpwr06twHG+OjD/ubqaM6iJVR63FkGpgLCF254lbY=;
        b=i+7KItBtXrwkMKmM/8GWUfwzIiWw5EQfZXHmv8x/k5jmj2KkWe9RkBaX2SevpZdhxb
         S4POUFDEgwAH235TzleTihmtFOiGKwpL3SifYxd5Up2Yu6/TNj2j2zcQgzDX0cvaqBbv
         Aso6MBD8493imtDpgR9e3wueoh7rshg8+IqDlc12QNa5v1mtLezMv8q44A3Wnbq6FwXi
         lTRqot+4HvbJBF3MitfhAGagtLJ3F2NV/0o/5ijpQSJEwSDBjQv/hJg8sSRFFyQbYWVd
         F5NkzAEc+1k950wcoJxxSAnkIXtWv31MU/9DYo0QdscpswKy4SgWlplthnydFrfS1B34
         nVJQ==
X-Forwarded-Encrypted: i=1; AL+hErHc5/a00VlGHRmkdDOuxXk/TGlmseucZfjzOb4ugvrskB1wjpAc1oQDnKPVy1DLQKntp9k4o7q0SVJDnipY6Q==@lists.linux.dev
X-Gm-Message-State: APuU4Z+H3wj0BPvjz9gp9CI/Tf1WoZ4KhWtbXnM2kgPCHdVk07jQ9dvk
	OKe2eXEthJ4bQJHu2mbGNpv4n6o5xv6AC2bHCLzsbzoBbU7L+RA+zomV
X-Gm-Gg: AYBFou2QqDv1ib5+yPgV0cfL/aaE8lRsh9zIJPcp3t/UtO0YXocZEFG2eU07iEOBdyj
	BQKKu3xKZV8TXKFNmtUjWI8KVlBIeFAHUBKoKjx/l4vsyN2zBk+ztprOMGFnTX6RgxphbusYNgQ
	99uqn91ls/6NRsZwVjI+0PWQi6T3QGXQPHwJIRrwd7H+d0yk+RpxFsGIeOUQdxrFS12zVp8eolz
	terOkRitEyMZg+KxOMf8WZt4sUNylBUqhIwQlNZ5kvDgcHk2vxlIJUIt5gB1Yw+RyQiObwI2cyM
	eeE4F+hSivLDzCn784o7P68CBWxBDKILzYHDdntrcJRu5jUYxf1A5ogIyewAkBGiNGWTauKHktY
	Fk5nqtoRIxKIfzerlNgEtXwij70sCrBGTz6rJ0vIdApfD+oWwGOXzSZLqm2e9W8OSvz1+6TqqKW
	Un3PCEx7/l/UVU8VDFE5nyMUKZ4g9Go+mwCDmtJLljh7onXQKeaTq/wZUqfTXwOSWpvdkAG+wXt
	2YliSSJ9jplSFFnrIAAwfYp70Z8jrWuCtjgZhh8SJCx+zRKSZRn717sJTN98/0px3UBsxQPgDfm
	8gH7O6Vk196nKwCRoLIueQwhKBLwXrX7do/l3bZuO2gD4Tg/9bjBZva7Mt5BIYCQRGLmxuJS8kd
	HZBro7dg1NWOZaaYUrZbVZ8JdgWkNmeSeLXnrZkk+f2SekoQ=
X-Received: by 2002:a05:7301:5f87:b0:377:678:2309 with SMTP id 5a478bee46e88-37706782738mr104860eec.15.1794365870693;
        Tue, 10 Nov 2026 18:57:50 -0800 (PST)
Received: from localhost.localdomain ([183.96.175.225])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-37520cfdfc6sm12390018eec.17.2026.11.10.18.57.47
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Tue, 10 Nov 2026 18:57:50 -0800 (PST)
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
Subject: [PATCH v25 14/16] docs: describe virtio-sound capture options
Date: Wed, 11 Nov 2026 11:56:53 +0900
Message-ID: <20261111025655.63951-15-mynameisjune111@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20261111025655.63951-1-mynameisjune111@gmail.com>
References: <20261111025655.63951-1-mynameisjune111@gmail.com>
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

Document request-owned capture in the ALSA configuration guide,
including MMU vmalloc page rounding, retained allocation lifetime and
the copy into the ALSA ring.

Describe the two default-off compatibility parameters in the kernel
parameter guide. Native capture pause uses STOP and START. The optional
restart path uses STOP and RELEASE at pause, then PREPARE and START on
resume.

Assisted-by: LLM
Signed-off-by: Joonho Lee <mynameisjune111@gmail.com>

---
Documentation/admin-guide/kernel-parameters.txt |   14 ++++++++++++++
 Documentation/sound/alsa-configuration.rst      |   15 +++++++++++++++
 2 files changed, 29 insertions(+)

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
@@ -2537,6 +2537,21 @@
 
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
+On MMU systems, the request buffers are vmalloc-backed and page-rounded
+individually. Allocator rounding can make total additional memory exceed the
+ALSA ring size, especially with small periods. The request buffers remain
+allocated from hw_params until hw_free.
+Captured audio is copied from each request buffer into the ALSA ring.
+
 Module snd-virtuoso
 -------------------
 
