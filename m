Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794561699;
	b=aOJyOp3EwSelQL81F4IklyyuLwIENpio6lQQnaHi1II4CY+pnOamUyBSqPaqighikJ/5
	 983DuN7jU8JJKgFStC4tU0Z5w9DRC6HW0hgzdBtzuut6v1JE1CLmZsPhZTwvEDZCYsHwD
	 0UjGbr1Abg+LBzGg4GuhBsYnfJIpzF7hRliFICwpxUJyrf+DkNJ72LyuRTxGnHKA/bgBC
	 3xZMdeMVusHIb7g5xHU0mA6XhGFdB3Ysbb2lFR8FP+iChRsfA3BN2dsrlCtAurX8hEhw6
	 vVkRZ+5r43kih4SkI/NQcB/nOiiKxOUyf6kkY7mCNRgU4l6RzAwQvuhWoC8n0VImasA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794561699;
	h=Received:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=QLrx30i7el36agCFsnnbg5QgixV8UKR0zsMUS/E77Ls=;
	b=CTzgCqYZcr7CzjSOfDJwl/4XeTKwtiXORTeE5dsHdo133HPVtwS/OpgSYH3jtdQ7+ZdW
	 oEbZvbg+JsvHNUi1W3MAlDxlZ/2CXMZs4f8E79GIYRhZbcvnQovsXOAT5givDA3XA2zTB
	 xfJGL4fJSXX+I+fbLVYLJxp75unb4RlFn6uLka2fVN6o3H3O9qbAHj+4KY9snf+SZeCDQ
	 Xlr8Y9Eq0frpk2HyJDNRS3lW8dCqTfY1LyUNZlAxz8dLyIJbE1cwCqBhS3QMWc+QTWrBq
	 DYczknKugQHDambp+nOsjUjfcwurysBpTMwOjDBqyHypcOyO/jrpWpPy2DV87zeRSAw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ahjsqUhD;
	arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B250460A3833;
	Fri, 13 Nov 2026 09:21:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ahjsqUhD
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1794561699;
	b=1du+RoulAXvDgDRKcQmAXR7ScwlUX5CXNDv7tp+F9UBaN8ivD9Q1AIQODU7rDYpn8hpH
	 LiMlsGXE/v6qZ0s7LHHFMCmrF9+/K1yRjeh24KI84I3kybtIf5RbV5fVVjfG86v8RuEb+
	 etUsGVB31Von7Munb+BjiDQBOeot4Z4IeNfthxflWc0zPdcGSawfmVjuqccq2M0doTQN3
	 VRW/rO2+cgrXRidSG8EISxvpoksejAZ4iSTEjfr+4RmdDY6D6u1dNhxGMf5iohRi8R4Wx
	 sl/M9vC91Z2VkHi1XvTkgmZHRgPD+9cTcx+XayG4ft5OfudIgF/ioSo+MOkv69SPC6A==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1794561699;
	h=DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=QLrx30i7el36agCFsnnbg5QgixV8UKR0zsMUS/E77Ls=;
	b=PUi6gHV2ObeJgbdT67oZqJ4L7KfV3VhvLAm5x2I9G0/b5YGP6yFWpt3//VZS3l28Z4+E
	 Uz4UFPHL49MXhswPUQaks1BSRf8UFb1BQ8J8nk60csYudRW5HdReQ0Nm8DvKOUgmVp6mC
	 i6KiZJqr/p+78oA1hbra7wJInrC0HZpEgtypvvFYeI26qjG6007wPIqozu05xrp+KL3nA
	 0eGgGPk6bWiZGi6MMUltj8coSS/Ps9gHn4dpJeb0P9vOtjCKndSeBthlobzO7IE24jXrl
	 Zdzrm3SKxOQN9oECP0WJkCtkzYnC40WofQI0dBUtvJdUNl0nWxks56iEu+PxSD/TYbg==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id A40ED1F000D0;
	Fri, 13 Nov 2026 09:21:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794561699;
	bh=QLrx30i7el36agCFsnnbg5QgixV8UKR0zsMUS/E77Ls=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To;
	b=ahjsqUhD37aVA0SgBuOMPlKMbnpLvZJfIo8sf7GO7oDnrk9Fr0aJqAv+OLFLZMlWj
	 HSSnV+O2n+3st0Rcr5kbXzJsPcJH9FGWf1lVH5QGJBDWHLRjBSz+CsznD1cYWvAxQ5
	 kMi6q0DehVEowx7jYzB8JqxxjKBcNSpIUes4dLZ6o1HqeNYB5kNEqCT3P60GcyOPhw
	 o2XxhfW10/gK9j2QYXuaaltRpw6OPbH7zHqEd0p0ImhFpRL9Y6rvCUBTPzaaNKwjn0
	 2IggwsNOLNEPskN5H9+Azssl9p9mVaZonEf994H3Z8VLvv/NOIb/SF8fEhl3Cluzs6
	 CC/ru1fq0e0RQ==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id 6B5B14773C;
	Fri, 13 Nov 2026 09:21:33 +0000 (UTC)
From: Joonho Lee via B4 Relay <devnull+mynameisjune111.gmail.com@kernel.org>
Date: Fri, 13 Nov 2026 18:21:38 +0900
Subject: [PATCH v33 14/18] docs: describe virtio-sound capture options
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Post: <mailto:virtualization@lists.linux.dev>
List-Help: <mailto:virtualization+help@lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
List-Owner: <mailto:virtualization+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Message-Id: <20261113-fix-virtio-snd-recovery-final-v33-14-13a934ad5ece@gmail.com>
References: <20261113-fix-virtio-snd-recovery-final-v33-0-13a934ad5ece@gmail.com>
In-Reply-To: <20261113-fix-virtio-snd-recovery-final-v33-0-13a934ad5ece@gmail.com>
To: linux-sound@vger.kernel.org, 
 Anton Yakovlev <anton.yakovlev@opensynergy.com>, 
 Matias Ezequiel Vara Larsen <mvaralar@redhat.com>
Cc: tiwai@suse.com, perex@perex.cz, mst@redhat.com, 
 virtualization@lists.linux.dev, linux-kernel@vger.kernel.org, 
 corbet@lwn.net, skhan@linuxfoundation.org, rdunlap@infradead.org, 
 linux-doc@vger.kernel.org, Takashi Iwai <tiwai@suse.de>, 
 Joonho Lee <mynameisjune111@gmail.com>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1794561688; l=3396;
 i=mynameisjune111@gmail.com; s=default; h=from:subject:message-id;
 bh=/j7ES1eIZUqADxQE96uIPwum9kdULJfrWnt027v2s60=;
 b=lZIAbbt3wKeCjvFvgpJs6RSAf3uLOUl6iy0IhW0OlWs6Q9zAJ6yoBuBEaoH09GUtGHcx0QvJc
 OU1CZJ2Ti+yBggC7bM47Gfg3/tu5sWNt3tBn/tN18xvbS2hM2ZuKAaL
X-Developer-Key: i=mynameisjune111@gmail.com; a=ed25519;
 pk=wqkZdvfcC8g8fDi6f0Y58LlaXIo+ubf6Y/9Lr9yhshc=
X-Endpoint-Received: by B4 Relay for mynameisjune111@gmail.com/default with
 auth_id=1508
X-Original-From: Joonho Lee <mynameisjune111@gmail.com>
Reply-To: mynameisjune111@gmail.com
Content-Transfer-Encoding: 7bit

From: Joonho Lee <mynameisjune111@gmail.com>

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
 Documentation/admin-guide/kernel-parameters.txt | 14 ++++++++++++++
 Documentation/sound/alsa-configuration.rst      | 25 +++++++++++++++++++++++++
 2 files changed, 39 insertions(+)

diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
index e75344f4e0cd..ca3fd768b439 100644
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -8344,6 +8344,20 @@ Kernel parameters
 
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
index 689eccf6a592..0531a3e3129c 100644
--- a/Documentation/sound/alsa-configuration.rst
+++ b/Documentation/sound/alsa-configuration.rst
@@ -2537,6 +2537,31 @@ midi_devs
 
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
 

-- 
Git-157)


