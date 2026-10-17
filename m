Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A3773B1022
	for <virtualization@lists.linux.dev>; Sat, 17 Oct 2026 05:15:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792214134; cv=none; b=Fnz01Kqnu3KUZT803xohtUMvMUdjiIzMGsuO2GXYXvSZNeEnWCxfncEVViMf1vTOUVWNxAnvtOPqQra7kI3v9FrHk59FrKp2zcJVF/Aeb+jKhUUFim9e/NuS4fYgP1HBi9ymf4NhOYZo7V6Y/oC4fZSVvfkXMzXPtndBbmARjlQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792214134; c=relaxed/simple;
	bh=95SdnSdg3U+zWWAokMZ2g2KRRVCLQeq73KICUEfOvb8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=q2439V7IkflMl8O/0SmTWu17qbdb4dHT8TZ8+0WzvQ51/ooIGMK4yiwkceMe/c3fIrrP6kb5ICKuIPTRDXyMR+aZYh0ZfM5H83uZyHWi4+Is8RWfg796Sqx/Ti0LLBi2NOVKs33DroZLsR0QVT5ZmQCQtEADyxE7MYwX2gCqqSs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cNtrR7Gd; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cNtrR7Gd"
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-2e987a2ba0cso4010795ad.3
        for <virtualization@lists.linux.dev>; Fri, 16 Oct 2026 22:15:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792214131; x=1792818931; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=J8NkLjAJdUFmj5MLQvoJkW4xVPLRTNUGffFYw5vC+68=;
        b=cNtrR7GdQJXUylZZBWhdwmkgog1bOxmlDlam39BN0+PEPYXSkGXh0ITH50iYtgT/lw
         4Plev+5wpx173anmZ33QomdqeRuiSojF3A/L09cyexQZZfan6OjZ1PBaZHly1YSLSiCm
         fCQwsZO62isaArCgvwve+AE4PUmC85pKe+c0ewQ7pMxh15+3PpyLz54QEec/B8GnSTJg
         V6DIo5v7f6wqrgoRBMsK2kiB5eTtmjh+KXpN/62R9PHET1Dk8Sh+44PjeXgZNMzkB7dV
         Sg8PB9Xmf2PfGHVxybZWMJaGGhZeWSbiuzM+DZQz7ms6JlINIhnzAFZR0MhALwPioMnf
         J+uw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792214131; x=1792818931;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=J8NkLjAJdUFmj5MLQvoJkW4xVPLRTNUGffFYw5vC+68=;
        b=Z3hhTJ7bPuWTHGqkthCsa5EnDedC93F2Rvi8LbbC5PV/vVsqhcZLQgB63XzNZVNPs7
         upSsSXBatNKISAdmiw1u+gwSL5HscBccXAcmqqyCelRPjlaCZVEQIAOYSH76aH4SVKr1
         qHzAER+7sxhAOzqsAOvu9hzSYE+tV7TTTxQCSJ8ooLme1dbLVK8fqT9LqGnYbKwzRtmm
         fyA1SRpQoUdLaG/4E/HNwVjN9Pf6mrm17LYCZAl1eIZ9W6tBFByW/B7pp7FuL/WJ9a7g
         OKno+c5gKEjdsGOv1ycv2ikN7GIOYDcVpAEsY8HHo4+ICi84MWyYz/kwFmhbEftjmbkb
         p4jg==
X-Forwarded-Encrypted: i=1; AKwUvBwVDd0LslbBKZHJsEK5E4wrYJYxOHvEAuux+jd2lrdGNRNlzb4eNbn8ZHd76cMETkWWvHKZnaoVPIEUvrm+Fw==@lists.linux.dev
X-Gm-Message-State: AFq9FYK9SjjLnBWWiAXu5lCuK43q3w5ri1cuFU+HOrFUHAiuPAD8mIc7
	i2fMgbjU8rhvwo3RNlDGz4ZBgBSYwW+pb2yWNTeBpsSpM5lLvKrvjEnF
X-Gm-Gg: AYBFou0DqrNp6dc7VKq5RjNVSqGQLZ0Ocnr7WDJslWcHgEU3RBoBGROBu4xxJxCoZ4n
	dzuOMOgYed+Aje+dNbEGwWJNpX2o3fsvgGOFTRH7lFy9Uwk3Xp176ZVQYJVWZ1em7tQa5ZH3e3d
	QI8pJCNOCi/rkKAi90aTguMrfdN7Q7K+1oErdiQzofwxkq0WTNdJHFkD5ZsCvHOTvcUWtLNMKrz
	/5kuho9+T7F2Fi4iCxKGQ6NEKnAAITOXRlBFBL5ISh1pupka+MeKAnmXHKBcIxEBqlDGby1HxjM
	dMM/Y7UFwX92TTwZyiIk7oGsAyvT52hsqW959bKOwjJQmmTtjAOKVGjZ5TDKGIf12CqIh6vg4Zx
	98gzpb9nWVQXLDtlMLbotmAdFInoxkseFvDCHFyKlWQyPDFX64qBeWcKGIOcZVSQaJdzYdS2o2E
	WpD2qvoZSBvgW/WZSh5dah84Woxqt43eoiwMCzKkotDzNdwFqF722b4kufQeDc9jYlEBz8IobtB
	IGd4WxB5IZMjCd37M4kCR8qU11Lo0Xkdc29CF2SP0l00/JuUfGN4MOJmJii99ub1mSBQwMvfUvz
	M1FMVZMu+0E/OabarFdkS8T5
X-Received: by 2002:a17:90b:5623:b0:3ac:9a54:e3ce with SMTP id 98e67ed59e1d1-3acef6391ecmr1619670a91.63.1792214131334;
        Fri, 16 Oct 2026 22:15:31 -0700 (PDT)
Received: from localhost.localdomain ([180.182.24.11])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3acc38b457esm7443575a91.0.2026.10.16.22.15.29
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Fri, 16 Oct 2026 22:15:30 -0700 (PDT)
From: Joonho Lee <mynameisjune111@gmail.com>
To: Anton Yakovlev <anton.yakovlev@opensynergy.com>,
	Takashi Iwai <tiwai@suse.com>
Cc: "Michael S . Tsirkin" <mst@redhat.com>,
	Jaroslav Kysela <perex@perex.cz>,
	virtualization@lists.linux.dev,
	linux-sound@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [RFC PATCH 0/1] ALSA: virtio: trace control message lifecycles
Date: Sat, 17 Oct 2026 14:15:26 +0900
Message-ID: <rfc-virtio-snd-control-trace-0.208f05ae8ea44e77@gmail.com>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi,

While investigating capture stalls, I needed to tell whether a control request had timed out, completed later, or been canceled during teardown. The existing timeout log gives the raw opcode, but repeated requests need an identifier to follow their lifetimes (or cycles).

This RFC adds one trace event to sound/virtio. Its enqueue, response, cancel and wait records share a per-send ID. Wait records describe the sender's outcome, response and cancel records describe queue completion. Therefore a timed-out wait can be followed by a response with the same identifier.

The patch applies directly to the mainline base listed below. PCM capture staging, split-ACK accounting, workqueue priority and application recovery changes are outside this RFC.

Validation of the exact source diff:
- ARM64 W=1 kernel/module builds with KASAN and lockdep; additional object builds with BPF events enabled and with event tracing disabled.
- Six QEMU cases compare baseline, trace-off and trace-on for a delayed PREPARE response and cancellation during unbind/rebind. Each checks subsequent capture and playback. No KASAN/lockdep diagnostics or trace loss were recorded. These tests use a patched synthetic QEMU backend.
- Eighteen QEMU performance trials, 9,000 timed open/start/drop/close cycles, use a 4,096-frame buffer. Enabled trials produce the expected enqueue/response/wait counts. Steady capture produces no control events.

The added message fields cost 24 bytes per request on the tested ARM64 configurations, even with tracing off. Module sections grew by 11,160 bytes in the debug build. Actual allocation depends on slab/page layout.

A further non-debug comparison used this exact candidate with QEMU 11.1.2 and HVF, sharing the same Image/config and differing only in virtio_snd.ko. Six balanced orders exercised 90,000 timed lifecycle cycles at 4,096 frames, followed by three 30-second synthetic captures. All functional checks passed, as each capture read 1,440,000 frames, with zero XRUNs or read errors. Each trace-on lifecycle trial recorded 90,000 events without loss. Steady capture recorded no control events.

Observed medians of six per-trial p95/p99 lifecycle times, in microseconds, were 201.105/349.729 for baseline, 254.146/334.416 for trace off, and 291.667/413.083 for trace on. Median process CPU time per lifecycle was 70.437, 70.532 and 77.300 microseconds, respectively. These measure the open/configure/prepare/start/drop/close sequence, rather than audio delivery latency.

Native VZ with the unpatched baseline and internal microphone completed 100 lifecycle cycles, but a 30-second capture returned EIO after 1,131,472 frames (23.57 seconds of audio). Native VZ steady-capture performance remains unverified. Earlier VZ integration results included experimental capture changes and a different port of the trace implementation, as they do not establish performance of this exact candidate.

Additional ARM64 QEMU fault injection exercises the real send and completion paths through a separate test-only caller. The backend returns status `0xdeadbeef` and used lengths 0, 3 and 37 for a 36-byte response capacity. Blocking queue consumption fills 64 entries; the 65th send returns -ENOSPC. A held asynchronous request returns before its response, while SIGUSR1 interrupts a synchronous wait with kernel -ERESTARTSYS and userspace EINTR. Both requests complete later without another sender wait. Each fault is followed by a successful query, then the suite checks an additional-SG query, capture and capture reopen at 4,096 frames, plus playback.

The length faults deliberately write a complete response within the writable buffers and alter only the reported used length. Baseline and instrumented senders still return success in those cases. The event records the raw length with status_valid=0 and status=0; this patch does not change protocol validation. An unknown status with a valid length is recorded verbatim, with the existing sender path returning -EINVAL. Here status_valid describes coverage of the response header word. The raw used length remains available for opcode-specific payload checks.

Two fresh boots each of baseline, feature trace-off and feature trace-on passed all 42 fault scenarios with identical sender results. Each trace-on run contained 280 events with no trace loss. The original, unmodified production modules also passed six repeated timeout/reset regressions. Seven deliberately corrupted evidence sets were rejected by the oracle.

The fault caller and QEMU changes are local test fixtures, excluded from this patch. The production control implementation remains byte-for-byte the candidate tested above. The fixture modules were rebuilt with W=1; KASAN and lockdep remain enabled. These synthetic tests do not exercise physical microphone input or establish additional VZ compatibility.

Thanks,
Joonho

Joonho Lee (1):
  ALSA: virtio: trace control message lifecycles

 sound/virtio/Makefile               |   2 +
 sound/virtio/virtio_ctl_msg.c       | 156 +++++++++++++++++++++++++++-
 sound/virtio/virtio_ctl_msg_trace.h | 107 +++++++++++++++++++
 3 files changed, 264 insertions(+), 1 deletion(-)
 create mode 100644 sound/virtio/virtio_ctl_msg_trace.h

 base-commit: 2f2f7eeef8b0a1a9b9ca998231419873ccae8d4e
