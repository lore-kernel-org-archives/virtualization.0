Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.174
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794267656;
	b=mSMRDAVzE4Poqcu1cCKD6ocTCh5PKSGKzCNk9CC1eUvuiQTxIpy24+SUqWR+FFl+DmNB
	 exCOFz5x/GXv6EUenJw/7/sF8xaqvL1HcMJyO5R/rSmtzupNRxa5cCQU/3n1Zz/iGM/wV
	 9bp9TRAmYDWY8+D35LpSapPqSDSmZDKI7AGJQs5KEu0JInd8LPaRJ141N+dn4SbhD9f7C
	 EeOpiEMLfSbAjJ7I++/tjw8TPRDPCuldHh/4oDCfpSK/bdVZ8LVt1kmWoYq2WcbihbzGR
	 i3AXSKjS5COcrqnbv0KRyzKY75/LHWIHhxlB670Of26oHWBz+qDZr7WkDSf6Ci5c5Og==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794267656;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=UYh9+NfHPKZajvTz1xi7cTDaycXDIClv3BtU5BxbMAs=;
	b=ZIIDPmVtaFgYw+Z3m1wGrFbz2KU2IicOwQaCW6OtGLEstn05jdfbdobkxqY0MFEVmeIk
	 FoFdUX/yoV5b2o8Y0iWcwoCC4/r4otUB7uth9Rz330786pAmZ5qiWRo7KuX+tymYvFLAk
	 CwnGIpiRVvhHCapoAr2P+Ok7Bz6RW2nhStipUZoqhfEbEnSi5lgrXaZ/h64+L7zfXkudx
	 UVX5+847gYVdwPYQuQ3A74wymjskn/m+w2UB0tjBqpVANjoqeaQuHflh8zzVgonZ0dYAw
	 08OK/zZZOnzxdn8ICiyxTouGZxODU5G8f3o8PoGc8BI891efHaLRwB7HZsq6Cht05hQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=r4EtHMDW;
	arc=none smtp.remote-ip=74.125.82.174
Received: from mail-dy1-f174.google.com (mail-dy1-f174.google.com [74.125.82.174])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3962E606A325
	for <virtualization@lists.linux.dev>; Mon,  9 Nov 2026 23:40:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 3962E606A325
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=r4EtHMDW
Received: by mail-dy1-f174.google.com with SMTP id 5a478bee46e88-37000e7234bso2075649eec.1
        for <virtualization@lists.linux.dev>; Mon, 09 Nov 2026 15:40:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794267655; x=1794872455; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=UYh9+NfHPKZajvTz1xi7cTDaycXDIClv3BtU5BxbMAs=;
        b=r4EtHMDWiqNKDeWtJ2c1z7QV4zcFyuBxZri9ZZbUwMy3dMM/YXIdv3GY6aINYoFYhQ
         TqsNUaKr4k+w7WeRCj+dVa4LIi+1eHkf25R5g/Grnf6nAThzP0v4KodLZKxSOCoUSSQf
         Pub/X0g1jvgPgahCWoQgxFZ2GaP1ZByaNOnedMowtj5KsjXpqNzrKQSntdibBzkmh//5
         X5RvfzpKB5lP8J6pSxtsn852NL/mKHn41QxmuOxZ5JACQlacyuqaT+DLN5v3mBdmeNPL
         MljWs9C06cDcSapWf6mWQQI4CnZm0CK/YNspyjHr/ciUkUukf6vlZl4rSlkGhMDOdaQc
         CwHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794267655; x=1794872455;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=UYh9+NfHPKZajvTz1xi7cTDaycXDIClv3BtU5BxbMAs=;
        b=Csz8AJv4KrJ+6s5SOhhjWEBDDBPJ1cWM3Vf2qMA2TKY5qNEaB5zuEQSGUiUprebRcM
         cut69/whb3kpgJt59++uYYOVdjAyRmts3VNYSsEbejGn0zxGgbOjflzAswi1NsGIppZ4
         ba5DSr/4prKpahzV754UHQf0+vEVMeQpxEZeaapdICoMhvNkG6jGNA+B+UIe/9LHHEkm
         bIZvxdPUlr/RzTcSNOgLZOKyWX9EUUHuWXc0pKvZpNWmvgV6J2q83Q7pOPC+8/PXN7xG
         nKeZNJGNN50095D9SHqD6EHRrf1lQmu5FY1LxKZeW1ZNNw7HleUG3G5AzW9uod8IXeDD
         QCTA==
X-Forwarded-Encrypted: i=1; AL+hErGFjtx7+bAbyB/RhOoQmgFCQS3X7DyWSLutVocxmE85zab0DRop70y/7sq6o8mwj8i+S7qPcNtHfjJoWpDbBA==@lists.linux.dev
X-Gm-Message-State: APuU4Z9ckFy20MMt/eY3FAIkjgoG2wsTWIUxQh5KzF7AA4/cM4G0sipW
	o1fEw0ryxPEM68hphZwMcAFxLdhi92a67rH7XAdAFXy1HxCHk/RJG259
X-Gm-Gg: AYBFou2JvQxuN8+oQX0Pt0v582FZWr71Nl9vqoBLSJIZkXQ+Kv2MBCLSlIQlj6yrQRO
	+l3pERW1HqYuBjjRxGZpx+8GJHnbwHyzsr+0FvVj1m1mjPHNBBZf41ZE8q2qJCqq3efguF9FG95
	c52iy40lj4U6J1qYmj4Zx7Mw71pQZpdiQqT78GJveolujyDSIC69Crr0IFWNBFG85+RAZotro1d
	6NEV1ZsmWjdYCXYHL4zBptPScXo23LhIlCkoelIk0rQP9JLjdSU6fidRWU2fIyMyM8Hg7YImqKK
	ZhE1hMJ/jTX/4St8LOxHeV0ibwO2z3xoL9eCWthS6fj7SW8m/NAbVDbWkgKZIOWy27MKFuK53hC
	HzyLHBa2kil/gl2pWFLwm79LLku50Q4liIOTnUZXMU3YKbAtcEAa4uQ4yJkxOCp+ciOEnmdEXBz
	NsfwjCPw/XlpEbWRVaABuXmZmmufz9eA+nLgjI+uTNaMG0Wpiu6YaY/7wiJAO8KGv44SP/hj67r
	+yEIlpDUitgiP3EJRowSITMx8Sm6UVYHN+538uEJOZMZ4yilbgrDIsrYtv771OJn5lVp+OiM9D0
	ANx5RUwVEG1HhmkdvStSVhHjQeO93gKaCpn90TWlhM9tCVKJ+61KLRFE/Nq79zZX3zA6QepjfQG
	eW14OYwjh1MXFva1GTdLYawrQ38GQBgPCHwMPNBbKw9LacGiqsSRqUpxuK1AM6u2jp94Z
X-Received: by 2002:a05:7022:f4e:b0:1a4:c892:b130 with SMTP id a92af1059eb24-1b3b5fccca8mr1420330c88.15.1794267655107;
        Mon, 09 Nov 2026 15:40:55 -0800 (PST)
Received: from localhost.localdomain ([183.96.175.225])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3751fe2ff5dsm1739049eec.5.2026.11.09.15.40.51
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Mon, 09 Nov 2026 15:40:53 -0800 (PST)
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
	linux-doc@vger.kernel.org
Subject: [PATCH v23 00/14] ALSA: virtio: serialize PCM recovery and capture accounting
Date: Tue, 10 Nov 2026 08:40:35 +0900
Message-ID: <20261109234049.79534-1-mynameisjune111@gmail.com>
X-Mailer: git-send-email 2.54.0
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

This series updates PCM error recovery, queue ownership and capture
accounting in virtio-snd. It also provides opt-in staged capture for
backends whose completion lengths need explicit compatibility handling.
The capture compatibility parameters remain disabled by default.

The previous series is at
https://lore.kernel.org/linux-sound/20261109051618.22506-1-mynameisjune111@gmail.com/T/.

The v23 changes address the v22 automated review and a separate existing
linked-buffer locking problem. Linked prepare now commits member states
and driver admission under the group and member PCM locks. Suspended or
disconnected members keep their states, and a canceled successful driver
prepare returns an error to its caller. Failed prepares notify only the
attempted prefix and do not generate a stop-timer event.

A separate core patch closes every linked member's buffer-access gate
and takes buffer mutexes in the stable group order. The caller-first
ordering and caller-only access gate are already present in the upstream
base; this patch is distinct from the prepare-completion API change.

The failed-start patch owns the direction-independent error latch. The
later recovery code keeps native pause admission closed when a linked
resume rollback fails in PAUSED. Paused ordinary capture preserves the
accounting-error XRUN path. Staged capture rejects unaligned application
pointer deltas before changing policy or counters. The DMA lifetime and
staged-capture commit messages now describe their full source changes.

The order separates the ALSA core APIs and existing linked-buffer fix,
ACK propagation and failed-start recovery, message and control lifetime,
teardown waits, opt-in capture compatibility, work priority, and option
documentation. Each patch is represented by an independently checked
cumulative source stage.

Validation used ARM64 QEMU with KASAN and lockdep. The eleven changed
cumulative stages, 04 through 14, built with W=1 without compiler
warnings or errors. Applying all fourteen patches in order reproduces
every cumulative source stage and the exact final candidate.

A test PCM driver passed fourteen core scenarios, including linked
success and partial failure, atomic and nonatomic locks, suspend and
disconnect cancellation, overlapping DROP, an active sibling buffer
access, parallel group actions, and old-generation ACK retirement.
The stop-timer change was checked by source review; this run did not
attach a timer client to count timer notifications.

The instrumented virtio-snd tests passed definite START and STOP rejection,
RUNNING pause restoration, failed linked resume rollback, deferred group
XRUN, DROP, prepare, real playback and capture I/O, and reopen in RW and
MMAP modes. Actual SYNC_PTR calls checked rejected ACK rollback and
unaligned ACK policy preservation. The alignment and invalid-accounting
inputs are synthetic test geometry. A separate stage-07 test verified
four START failure/recovery cases and failed playback drain termination.

The pure final driver passed ordinary and staged RW and MMAP recording.
Each configuration included a seventy-second capture. RW checked three
reopen cycles; MMAP checked RESET and a reopened stream. All fourteen
captured segments matched SHA256 values generated independently on the host from recorded QEMU sequence
epochs. No KASAN or lockdep diagnostics were reported by the passing runs.

Additional tests used the same candidate with strict KCSAN and lockdep.
The runtime selftest and an isolated positive-control race confirmed
instrumentation. Fourteen core cases passed at both default and higher
sampling rates. Twenty-four driver control and accounting assertions
passed. Ordinary and staged RW/MMAP captures matched all fourteen
independent signal segments, including RESET and reopen.

The KCSAN campaign did report an ARM64 saved-PSTATE race outside ALSA:
copy_thread() races with spectre_v4_enable_task_mitigation(). I built the
pristine base with the identical config and ran the same fork workload
with all sound modules unloaded. It reproduced the original pair; the
ARM64 source and compiled objects are identical between the two kernels.
The report remains recorded, so this is not a globally KCSAN-clean result.
No ARM64 change is included in this series.

Physical tests on macOS VZ used Scarlett 2i2 input 1 at 48 kHz. Direct
ALSA RW and MMAP each recorded seventy seconds, with signal statistics
checked against a simultaneous host capture. Pause/RESET, the first open
after killing a running recorder, and capture after VM restart passed.
These tests enabled all five compatibility options. They do not establish
bit-exact physical sample continuity or Docker Desktop microphone support.

Two test-tool problems were corrected before the final runs: asynchronous
ACK snapshots could evict a control-error record, and truncating an old
capture file after START stalled the test client beyond its PCM ring.
The final MMAP test prepares RAM before START and writes output after
closing PCM. Source, config and data-oracle acceptance stayed unchanged.

Synthetic alignment checks do not represent an actual sub-byte capture
device. The stop-timer change remains source-reviewed without an attached
timer client. One-shot command rejection exercises a definite error path;
uncertain control timeouts can still require device reset or reprobe.
Heavy-load TCG scheduling limits remain outside this qualification.

The staged path and its backend compatibility options need maintainer
review before they can be recommended for a production deployment.
