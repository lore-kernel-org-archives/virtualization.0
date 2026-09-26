Received: from mail-qk2-f40.google.com (mail-qk2-f40.google.com [74.125.230.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FED836EAA4
	for <virtualization@lists.linux.dev>; Sat, 26 Sep 2026 16:31:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.230.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790440293; cv=none; b=E6WQFjrUEK5Wr2rksf2EMlIdxh8sP4e0t3OE/ruEw9CcihItlnZFYE5p1XNXjS/97uxFNDVElJzvgh7c/jXKqN48m1fQSK7NIaTbzjK/wMOS+sAlWhTo5JLIeEqzVGA7LgUrny8R3XUL+Wt0B+B8YTRDEDsn1xFleWs5meMUYXM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790440293; c=relaxed/simple;
	bh=QQLHPEkZmbpj70DVPITpOLcJJxjVmK33AzoQr5/JFAg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=MMeIkyDpjlBpd4KmL49vZEPnRF4NaO+5ALqcNx/N5krdfnEOp5ONxE3R2p3kjEp/dBGolmHFGLkkNRMSXMtHwjA4QEwQRN7Eil8esem8xo6OpEJXaIhSU5L4PCREmYrqtG7jav2EB0mFIbPsQ/XZubCtz33muCdS4IjhjGoqEdw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=pUWv2OIB; arc=none smtp.client-ip=74.125.230.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pUWv2OIB"
Received: by mail-qk2-f40.google.com with SMTP id af79cd13be357-93c5b166b8fso46753685a.0
        for <virtualization@lists.linux.dev>; Sat, 26 Sep 2026 09:31:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790440289; x=1791045089; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=T+XTa7v9YGLEx2g2NOBefUwMoQWTvFtXhbpvBGy7RY4=;
        b=pUWv2OIBRNMa3zYVm3WmcOkRVSM5lFZInZfPzmreBa8/WIhpNtGjbiVtoE9AzzEfH+
         bIDF0ZbUx5bJDucGlXJDPyKwvILrkxGh5DlJkor5G/ir6aDF6aGtufJWtOCnrpCmz0rl
         Pu67sYI4AR/B2ygBJhVAP98wBZrtb5rplZ9xtZ1bEJrphR3N1c3oeGpD4ft8duIcAdQI
         HNRsfOHRn3lFXDJUgcIQfHRA3xzPjZZ37MOvXzXYchOVfMiST8qVvryLUY+4gJpR8qfR
         QAXkSJO1r2KGDcoOsl9wkbIJeShKE44NPX8P5S7j7YaG0q0CeY7cGWZhd1JGuUnfYHse
         kbrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790440289; x=1791045089;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=T+XTa7v9YGLEx2g2NOBefUwMoQWTvFtXhbpvBGy7RY4=;
        b=frJqTFgy6EDFLz/D8LHm5RDfsXiAUwbNs5lXkoxrmYfVd5Sd93Ai8Qah4gK7nK6yTK
         g3G9SYop/m8BOuqXuxm5PpZCYA9uB5R9TyLm+rKxkLPQ7imp4z9tZ//o5q3LIcMGCerI
         8ziG9VGfeGyPF645TTK6F/G9maYj14WPvmIEiiJkZUcppPm9vdn4cIR/FzHo5+//VQEG
         49C81sB81jIaWRgOYRi2oe7SGtSFlnUKBpM3nuD4z6aQRyxMG2SbdyZZ41w818CNyt7e
         sJSDqXoZJJrMV63q7jZLXmVJGb7gUWhdexMFSNcMqS1DBQ3HdpDbc8wd58Z+/4yGZUpO
         VaMg==
X-Forwarded-Encrypted: i=1; AKwUvBxBjfwzlQNu3urq7n5aC4uJgmTVGpre7dptHzWMUKEnLmCVysVYcj3s1EuYRhiVGCbbwsVyHMWYD2I15CI6yA==@lists.linux.dev
X-Gm-Message-State: AFuF++ljFZz1oSv4CPwg2emLJMLR+44RuPtsrGQLxR6UmjPHj4hdGlg4
	kf7L10PPFYdy8qll9PYFTL1yX58cJCixRFQ1buu75I1zK6WvmGMFPPkO
X-Gm-Gg: AYBFou3xqTWIkO7suNks6CPv2eTnQ2xKohWtEe89wCm5uDxvMu4nYYc2vRbAgI4Zd+T
	9P95ZBSs4A/imdBd2baKTqAwVaMpwH4gm3xtHE6pYq8gs4AAk+ocf99XFYVe8Ox+WBAOMCyQvFB
	CjxRZiOHidPIy2s7rPXBnvNwbbUZo70LjUtVPMQZA5m+IQ2/IfWQHfYED99xEoHI62kulOuofpl
	bl+NDQWoTClQHCsNoyzOs37dIdSAr1nFCWPeyFHGnCl6IgzQmKss8ybLq875Ltkpx5dbHn0uedX
	oDn812HWvmtT+0yh/mQCuHa5MqN/HebMMfmCYlL/ogfv2AxOjAflRUM5WYyn1nwP1NvQJbm9PCH
	nYpT5Pd6iU06E5wn73ihm91qakEdgeaZWqy/rlpGNo4ZdxX3wDmSzSRUSYU4ZxM5Q9THZuKh/BM
	luc98jlNgPxc9yUz0oWFEH0qzAcoqfimpX4jE4mLASYHrh2QuybOM1R8Wr0hJN4Ohu/YUfLpxTQ
	gz7uRKwfNfIoOqkRkW9aM1pjksP3iTZ2rTLWYPuWR0qQlnVickb406SNSo6iq7yDAQ=
X-Received: by 2002:a05:620a:400d:b0:93b:d7a2:dd29 with SMTP id af79cd13be357-93c43d2d070mr1066129985a.57.1790440288703;
        Sat, 26 Sep 2026 09:31:28 -0700 (PDT)
Received: from localhost.localdomain ([2600:4040:29f7:9600:f571:6178:b590:34a4])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-93c4fe09037sm341332385a.27.2026.09.26.09.31.26
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Sat, 26 Sep 2026 09:31:27 -0700 (PDT)
From: Dillon Amburgey <dillona@gmail.com>
To: Dave Airlie <airlied@redhat.com>,
	Gerd Hoffmann <kraxel@redhat.com>
Cc: Dillon Amburgey <dillona@gmail.com>,
	dri-devel@lists.freedesktop.org,
	virtualization@lists.linux.dev,
	spice-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org,
	maarten.lankhorst@linux.intel.com,
	mripard@kernel.org,
	tzimmermann@suse.de,
	airlied@gmail.com,
	simona@ffwll.ch,
	christian.koenig@amd.com,
	krisman@collabora.co.uk,
	noralf@tronnes.org
Subject: [PATCH v3 0/5] drm/qxl: fix shared-primary lifetime and source packing
Date: Sat, 26 Sep 2026 12:31:18 -0400
Message-ID: <20260926163123.39217-1-dillona@gmail.com>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

QXL packs dumb framebuffers into a shared primary surface. Failed
preparation and multihead updates can leave shadow bindings inconsistent;
packing whole allocations instead of visible sources also produces
oversized surfaces and incorrect coordinates. Patch 4 establishes atomic
ownership of the shared shadow before patch 5 changes its geometry.

This series supersedes the single-patch v2 posted on September 24:
https://lore.kernel.org/r/20260925033011.12560-1-dillona@gmail.com

Changes since v2:
- Split out fixes for framebuffer pin unwinding, DirtyFB commit ordering
  and error propagation, and stale disabled-head-zero monitor metadata.
- Replace BO-global shadow mutation and the shared redraw flag with
  prepared atomic plane-state ownership. Include every primary plane and
  CRTC in commit dependencies, replacing the lockless redraw of other
  heads. This addresses the state-lifetime and redraw-flag races raised
  by Sashiko AI:
  https://lore.kernel.org/r/20260925034208.6B9F61F000FF@smtp.kernel.org
- Separate shadow lifetime from source-sized packing, retaining source
  X/Y translation, packed monitor origins and clipped DirtyFB updates.
- Rebase onto mainline 6812ce4e4379 and expand regression coverage.

The series also applies and builds on drm-misc-fixes 94cf5971b1d0.
For drm-misc-next 98c7fc4219b9, patch 4 needs adaptation to the new
atomic_create_state API.

Validation:
- Each commit builds on x86 with W=1 and no new sparse diagnostics.
  The final QXL driver is also compile-tested on ARM and ARM64.
- QEMU/KVM tests cover error unwinding, commit/DirtyFB ordering, shared
  framebuffers, source offsets, clipped damage and concurrent modesets.
  Error-path and ordering tests used test-only hooks, absent from the
  series and final kernel.
- End-to-end Xorg/SPICE tests verify multihead resizing and DPMS resume
  without an application repaint.

OpenAI Codex assisted development and review of the patches and regression
fixtures.

Dillon Amburgey (5):
  drm/qxl: unpin the framebuffer when plane preparation fails
  drm/qxl: wait for pending commits before applying DirtyFB
  drm/qxl: clear the monitor configuration for disabled head zero
  drm/qxl: own packed primary shadows in atomic plane state
  drm/qxl: pack dumb heads from their plane source rectangles

 drivers/gpu/drm/qxl/qxl_display.c | 370 ++++++++++++++++++------------
 drivers/gpu/drm/qxl/qxl_draw.c    |   6 +-
 drivers/gpu/drm/qxl/qxl_drv.h     |   5 +-
 3 files changed, 229 insertions(+), 152 deletions(-)


base-commit: 6812ce4e4379ffc99c52401ec28f0d7ffbc36206
-- 
2.43.0
