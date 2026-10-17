Received: from mail-pj1-f44.google.com (mail-pj1-f44.google.com [209.85.216.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8185379ED7
	for <virtualization@lists.linux.dev>; Sat, 17 Oct 2026 05:48:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792216118; cv=none; b=W8XYDiGNNtV3gVmaJVXTkkdov10ijOBOcCkc9Y5wwxOedQLf7Hh1/uizIXAEBj8rcpN4cHjpfeECn+EwYpJV5xcqS6mY3tQkwPfCHzXmDiB4h5ncDpI92RqiuIku6Qe9E9HylbJPit/GSBwLMZ5SfbOVjaeEfUtVhfxk87Srnag=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792216118; c=relaxed/simple;
	bh=m+qK95YsXLjQ74wCYltLIhf7b7QUBE/Owh0lXAqBWcs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=nF2KqlTJ0EgvPQy3QZkm/Q7gt4PDBQSiwUTPd9Y0L4nedPIcbHG0JZuQL4UIZqW27sXa4MdTpn0sEDfoqkx9Lw4UOjrdslvcPYHfylHj6zIqKOZuNdBzU9dODuKmOiqD5tlnIp90Muxuz2DfaR9bTLevCHbyTBD+097A7EfsIPY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KWvQD1ux; arc=none smtp.client-ip=209.85.216.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KWvQD1ux"
Received: by mail-pj1-f44.google.com with SMTP id 98e67ed59e1d1-3acb11973c3so601304a91.3
        for <virtualization@lists.linux.dev>; Fri, 16 Oct 2026 22:48:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792216116; x=1792820916; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=D7EatRdxc9GCmX3PE7WN6BAzYijlsRrXgxUIuAQGbmU=;
        b=KWvQD1uxTBEXCvXC9KNHXjn/oambNeAdsQ9xJUonw1Txj04JQc5HN8FGYwere/DQQe
         x48qZfrKLPtu8DTQ/QHuEELRY05YDU3wcgnCnXlnESv9jdJJyKXa7vTDRH8+X3wMtRaY
         DRRzKkiHrY4BR6rlnS62SpK46S5AuWq9v8vJDT3WOQCD5QOY4L9BKU08Rhpc0NgbkfK5
         anHYybsVk+Y8xY0ar8dhreTo5aRdtqQUKwXUB1u4Jn8FNsU7xYiadbi45LEpkcO4bnGM
         tKf3q/1FmDkFT2x9bxGNdwvNDQq8liYJms/AZP+nISJVIRd4ZA2ountRguLo2/CvO/fP
         5hAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792216116; x=1792820916;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=D7EatRdxc9GCmX3PE7WN6BAzYijlsRrXgxUIuAQGbmU=;
        b=Z9GvW77sVlcvXlGAy/Xseol+6eFisUgvveUKmpy1IOzJyGi/uHptJZstqBNLDBEEsW
         wHzupa0De0ZY2Xgnk0Hbq7RklYNgd0R8I2M3dvcIC8zk14I+7C0b55XDtv/DFMctdk77
         heA8v7wcf3grIO3PFdOYnbX8nva4mZFeiEwW3qUzkyjEiAeuDFZTphc+XjQSIOGVlxKv
         GfwrJKse0tqU1wU95zMHOQIvGg7JKimbUht1bMgFfhVIc206VsYaL/y82ZYFa9QCBCkY
         OiS8Udq7GkvrCjo5CeHhIcZWnIgGXmFegsL9NVRa6+1X7BdzQZV10qq3KCVuyrZYW0oe
         ffvg==
X-Forwarded-Encrypted: i=1; AKwUvBzHxnlq5TSSZdnzTv1AdX4swtIoKazQqCMF3XtK6i5HBizaIK4Zj4wN8Xr8vFA5gya2Th7mhV8RbfW8qn/LUg==@lists.linux.dev
X-Gm-Message-State: AFq9FYKP0l1ugsnahcZm/HaMCmQz3LsoPeEyIngAoHpFlJFnBizTIwnG
	EVkkvwsllapm8A/SNX0dAtnaQwCmvVewhkLB9HgHqHlze8Jj4wjKjUmX
X-Gm-Gg: AYBFou207nLyOe6ziR5+Rn89YQZdcplXxBGe9IaMKThgN4MU0HSUu8gNHIXLUF+Vr/G
	snNz44MkuXqZxWHRCDVVsbS+v/oCkVuHhRwymC+TGqP6mgC7qMCZflyUGJd0WLzSv6isxQRAQ2f
	jqQFrhoNT/EVAWOTThuOFfJJeAPD11tAPEWYrxT8fa7hdQlBzUIf389xcVI1vA5KNWeNNEYyDfT
	uCD6tBDGiMzVTZbXtOxrC5Wly9sROCEJrfAobXS2wXTrApv4/fv44R0254SVqyX7a8QetasqWgY
	jYVWf2DeiiWs9eOs4Ry4yUWDaZz6mItyZjtbPehXBXWCdlZPxJ4fHhEUX1yw1+33rYF+1JF8ZbJ
	ogTWLIRY5LAGdWV2fRM7Lu0/I2En38gDYWwH7V+wLGxMakLG1zUGwpHeG2nKTqhjQAsWKt7apAY
	rxF62GIcQDiWGoovJgXEkdcXMzsuLAJ91PgQNfaYyX+pOc8iJjXwEhsJiXDharUvSrw5nLjEaA8
	3jBKU4rRCyAG7LS0TAUnPbUL4XjtXQ+YcAP0CaXo6wHv3ULKlHBtsExSdCLbCn/h36HuSQ1c+EV
	hzRIinDz+FUuDQ==
X-Received: by 2002:a17:90b:562b:b0:3ac:9d26:551d with SMTP id 98e67ed59e1d1-3aceefc0841mr1636007a91.50.1792216116049;
        Fri, 16 Oct 2026 22:48:36 -0700 (PDT)
Received: from localhost.localdomain ([180.182.24.11])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3ac9474b52fsm13570028a91.9.2026.10.16.22.48.34
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Fri, 16 Oct 2026 22:48:35 -0700 (PDT)
From: Joonho Lee <mynameisjune111@gmail.com>
To: Anton Yakovlev <anton.yakovlev@opensynergy.com>,
	Takashi Iwai <tiwai@suse.com>
Cc: "Michael S . Tsirkin" <mst@redhat.com>,
	Jaroslav Kysela <perex@perex.cz>,
	virtualization@lists.linux.dev,
	linux-sound@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [RFC PATCH v2 0/1] ALSA: virtio: trace control message lifecycles
Date: Sat, 17 Oct 2026 14:48:31 +0900
Message-ID: <rfc-v2-virtio-snd-control-trace-0.60ead383067a41ae@gmail.com>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi,

This adds a control-message lifecycle trace event to virtio-snd. A per-send
ID connects enqueue, response, cancellation and sender wait outcomes,
including a response arriving after a timeout.

Changes in v2:
- Group internal helper event arguments in struct virtsnd_ctl_event.
- Use designated initializers and named validity flags instead of positional
  booleans. Keep TRACE_EVENT and its record format unchanged.

The event definition, error handling and request lifetime are unchanged
from v1. The patch applies directly to the base below and has no dependency
on the experimental VZ capture changes.

Validation of v2:
- ARM64 W=1 builds, including KASAN/lockdep, BPF events and tracing-disabled
  configurations, passed without warnings or errors.
- Eight QEMU boots passed malformed-response, enqueue failure, asynchronous
  completion, interrupted wait, timeout and reset/recovery checks. Trace-on
  fixture runs recorded 280 events each without loss or KASAN/lockdep reports.
- A non-debug QEMU/HVF comparison completed 90,000 lifecycle cycles and three
  10-second synthetic captures at 4,096 frames. All functional checks passed;
  captures each read 480,000 frames with no XRUNs or read errors.

On GCC 14.2.0 ARM64, the event arguments are scalarized. The control object
text shrinks by 56 bytes and the send stack frame drops from 192 to 176 bytes.
With event tracing compiled out, the old and new object text is identical.
The existing 24-byte per-request metadata cost remains unchanged.

Host-load stability checks failed during the timing comparison, so those
measurements do not establish an isolated runtime overhead percentage.
These regressions use synthetic QEMU devices; native VZ steady-capture
performance and physical microphone acceptance remain unverified.

The malformed-length fixture writes a full response and changes only the
reported used length. The sender retains its existing behavior; this patch
records diagnostic fields without changing protocol validation.

Previous version:
https://lore.kernel.org/linux-sound/rfc-virtio-snd-control-trace-0.208f05ae8ea44e77@gmail.com/T/

Thanks,
Joonho

Joonho Lee (1):
  ALSA: virtio: trace control message lifecycles

 sound/virtio/Makefile               |   2 +
 sound/virtio/virtio_ctl_msg.c       | 178 +++++++++++++++++++++++++++++++++++-
 sound/virtio/virtio_ctl_msg_trace.h | 107 ++++++++++++++++++++++
 3 files changed, 286 insertions(+), 1 deletion(-)

base-commit: 2f2f7eeef8b0a1a9b9ca998231419873ccae8d4e
