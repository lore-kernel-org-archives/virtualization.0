Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.175
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793693308;
	b=1gK02xzh/PRC8dQ6HZ9EE58dLhpmr7AFtKYmYN330qzOOqwxjgHNoHU7qTIkYjDSRRRF
	 /MwnHixm0ejJJZ0noCTYOceShg6AZ4iqK8MYbkintu3MTMlR1/4tohQ3KEJph9J5JhkwO
	 jiFFbGBBzK4j69RS8uE+hkwzCEZK9BeFt9IHoB5DgjHPQy6KEVpLnI9p3N/HCOrWAg7Ak
	 xj7zbET2VdamlJfXxdNxeOHtZO4NtZdacqIhzVnA8Np4Jd7KbDoiiY+kpR3tb8NUwMVNg
	 DGNmkUNIbPXRUGMTaNzW9b9OedddcDaNluMM3rnpXz2uclwIdtLmjeLnymtBdOCBseg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793693308;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=pXz+ijE9EUDzSG+3qju7ZVTn1bPYlfF6y8GttsYWRPU=;
	b=sYL7Ee0WWhUgIP20PJGatd0kJBW88E9Q14kvQ0s4wxVze17B7pCMiAOAOFDh/iizll0Y
	 DQ5xBU4l7OulEztWOe7149GBFXldhX3p9qOgBkDLoNTQQT9hLc4VtOM931K9LoIC1AveE
	 hkApN5ZFHruLaSxz/b+RoYH4iTRsQmpk3YLdzr+R6ZMQJDlW4BfpA5dPorgfbg28gCJy3
	 fXnX032g4NZq6BvSWlD9ZsdZmehi0OcUmeOr0ESXLpOljJH5pRLGO+YxBmxEGGt7rSGrL
	 /fbWAnwFnXosD6mxjDtx4SCY2io3msarZ7Z7Kza9R8SBQj7z+o8ccaD7cus4SGc4QbQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=AY361MLv;
	arc=none smtp.remote-ip=74.125.82.175
Received: from mail-dy1-f175.google.com (mail-dy1-f175.google.com [74.125.82.175])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B670606A324
	for <virtualization@lists.linux.dev>; Tue,  3 Nov 2026 08:08:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 8B670606A324
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=AY361MLv
Received: by mail-dy1-f175.google.com with SMTP id 5a478bee46e88-36c9a93a1abso114245eec.1
        for <virtualization@lists.linux.dev>; Tue, 03 Nov 2026 00:08:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793693308; x=1794298108; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=pXz+ijE9EUDzSG+3qju7ZVTn1bPYlfF6y8GttsYWRPU=;
        b=AY361MLvQfAj7Sp4GKBAQJtSLpokSGMQY50p7Hs3jkB06uA71VUompv8J9THZ1XGGc
         Y/UEuJE2opXfVm2RoryuBZfiIbWxLZJHefOd5L67I+AoW66UWhSqtTe0lMmRz75y2d2A
         DERFnZNRHkRVaiGrbB2eVRB0vJKz9Gz2z/8XSkFBg7H3IWHRa0OnExQR+AV3qWdZJNFn
         fSq3ww2i5xpNicLWZmINXkaqys28nLhJy+cZb0++Rm4JfoMxPQyXUooo+yJlsKMdhJEP
         OUvMBqUSOhDwlxkIGZZU1iA2hfW/u7WRxIEcJYEcmbCr1VP2VDQog+g0A+2XsSM8fVFQ
         UojA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793693308; x=1794298108;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=pXz+ijE9EUDzSG+3qju7ZVTn1bPYlfF6y8GttsYWRPU=;
        b=tHcZHSecWcfM8hYaB2AtXIS71pue2PsgQD3HMXXGtnuwALl+4DLgMV7jb/0afT9arS
         61QVtxUasfRSd65TVi0p1rJB40o7XCE3oPXr4DZP7TU0MrUU811TZasIUSXHxr8nJVa9
         7IbriXHB3A3c8HD/wisHQSYfk4DicDXb4h/gakdCpPFTt8j1sH1oAxAcWgYb9DdlSQBP
         qmi3qzTagflaotqJfHQzap6tPCafUNDlNHzu8wK2qUh5nhMdMeFyvavqWwG4DVlG2RfI
         m96pSeoR+KjVMo8cZyYsjMotER9LT7jBtoGDgZhx7O72BXZdGL6wn316tgYKjtwT4N4+
         IE+w==
X-Forwarded-Encrypted: i=1; AKwUvBx+zxGHGIi5geOOwyr46XCUufMwjeClGEAiALn4xhUMfvU85jlQg62GhwIgEX+p2o+XyV6po2Km+c61cu2qtw==@lists.linux.dev
X-Gm-Message-State: APuU4Z+OnlBdIBvpbt5fA7rFb7CQnWzgDfhW00TLS95amZa2vK6u/UF/
	ZvwKL424pW7xB62Ao4eE+N8xmnjSNeGtoybrHokFO38UQPa4aJGUvWbs
X-Gm-Gg: AYBFou0YoKxbPvGo0V9jxdVJLgbs/lu/WWLJEXj052bcIHkI0inwg4Yqanu2WWxN+3N
	yHJYur0T1n5Pugkd/kMc+3ZMnQMe0F9qkOe2sFWRdbLAIaanO0pgv1KYlnJonkpeUYsSXZVG2Bn
	BlCHbFt6JoEuiVn6iEgIMRFv9BKH3yvCIKKH3sZ1lqKOuqGJEs5AkwIiLmV5coV9MbClNZcLVhm
	59cZbn7LkCPr9Q0/TpxvfSSUX5t/oHGMAh9Hi09VTtouNRMh8ldBBuGYlQI+0g6ALlyBKDgRG+7
	yS+UK1NwKzarFL7IbyXGPBfMlQNhRjGz63iRwrTUcBskYFr71DF87gGsnswWm9T7eRUXyl+m7uT
	so2mVfSE+IcXIDVCvzXjynRRwHZ42Zu4G9vEBC6D4eJ9Cu39Rl9u8ZhCY5n6HpaVkLYZLcwlWsX
	izbPYbQBi/NPFYM9DTV0yz3l/h1qD3cp63Lx7S4kZOaK71NYmUXKIioo7p4O+glbgCmpQRIiX5m
	1m0EMAgg3myrkFvb4XG2cHRzLRcF5NSm3aAqFREG4EpfXOzNN/RL9Huf9qysdEJ1FcE6S66lznz
	/42uGv2KJ8EJAdEb3sYI4mayaDSKolNx/C9aABByxvkH1gAHUvcR9uql6tzW/epQD2f5qrwwPTp
	991WjiJq/D4Duzg3NQjk+ph0cFK7Jqa7k+0P0h5fDOeZkOP8=
X-Received: by 2002:a05:693c:2184:b0:36c:9a25:8073 with SMTP id 5a478bee46e88-36c9a2582e2mr543808eec.2.1793693307306;
        Tue, 03 Nov 2026 00:08:27 -0800 (PST)
Received: from localhost.localdomain ([183.96.175.225])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-36a428fa380sm41468466eec.12.2026.11.03.00.08.24
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Tue, 03 Nov 2026 00:08:26 -0800 (PST)
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
	linux-doc@vger.kernel.org
Subject: [PATCH v13 00/12] ALSA: virtio: staged capture recovery and PCM RESET synchronization
Date: Tue,  3 Nov 2026 17:08:09 +0900
Message-ID: <20261103080821.16983-1-mynameisjune111@gmail.com>
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

Hi Takashi,

This revision addresses the v12 review and Randy's formatting comments.
It replaces v12 and includes the unmerged prerequisites. Apply patches
1-12 to sound.git for-next at
a4311e9447bbb219044db38897f95be112f46a8a.
Targeting 7.5 or later still works for me.

Previous series:
https://lore.kernel.org/linux-sound/20261103000403.67106-1-mynameisjune111@gmail.com/T/
Randy's review:
https://lore.kernel.org/linux-sound/dbf3b343-0af1-4297-b78a-bed68865d59f@infradead.org/

ACK now checks the PCM state before changing transfer state. A raw
SYNC_PTR racing with DROP previously changed SETUP to XRUN and re-armed
stop_operating. The correction preserves SETUP and rejects that ACK with
-EBADFD. Event callback admission is protected by the event queue lock,
so a callback pending at disable cannot dispatch into freed ALSA objects.
Enable and pending-event draining use the same lock.

The prepare gate is cleared on failure and device reset. A successful
hw_params clears the suspend flag, avoiding a second SET_PARAMS during
prepare. Staged pointer queries reject unavailable epochs while retaining
the released paused compatibility case. Playback pointer and ACK paths
honor latched device XRUNs, and TX completion preserves the latch. The
pause compatibility START path reports a latched XRUN as -EPIPE.

Staged ACK retains an unconsumed sub-byte frame for the next complete
byte, including appl_ptr boundary wrap. Capture RESET completes the
private cursor rebase on error paths, retaining the XRUN latch and
notification. Synchronous teardown owns a balanced work disable until
the next successful prepare, preventing RX completions from requeuing
period work after cancellation. The last completion always wakes the
release waiter.

Playback RESET changes behavior when TX requests remain device-owned:
it returns -EBUSY before changing the pointers or queue accounting.
With no outstanding TX, it rebases every indirect offset and clears
partial message fills together. DROP/PREPARE retires a busy generation.
This affects playback callers with capture_staging disabled as well.
I would appreciate review of this busy-TX RESET policy.

The refined partial-period test demonstrated why the accounting matters:
a 64-frame partial write before RESET caused a later 960-frame write to
submit a 1024-frame period. The correction waits for the remaining 64
frames. Linked RESET retains first-error and partial-completion behavior;
both member orders and group prepare recovery were tested.

Full-ring capture overwrite protection remains enabled. Delaying RX
observation can overwrite the ring before drain. The candidate still
returns -EPIPE in that case and returns the correct 64-frame tail for a
normal drain. The post-cancellation worker issue is handled separately
through work lifetime management.

The suspend-flag findings share one correction. The playback state
finding overlaps the ACK/DROP correction; its remaining XRUN handling
is included here. Capture compatibility options stay opt-in and default
to false. Every patch includes a diffstat, and the virtio_snd parameter
entries follow virtio_mmio in the documentation.

The series layout remains twelve patches: request and DMA lifetime in
1-6, core stop-threshold access in 7, partial-progress notification in 8,
the optional PCM reset operation in 9, capture/lifecycle/RESET handling
in 10, work priority in 11 and parameter documentation in 12. The core
source is unchanged from v12.

Validation selected 19 ARM64 QEMU runs with KASAN/lockdep and separate
KCSAN_STRICT tests, including expected-failing original comparisons.
The correction passed native and pause-compatibility lifecycle tests,
prepare recovery, reconfiguration, XRUN delivery, repeated teardown and
both linked RESET orders. The staged 4-bit ACK and pointer/error-reset
checks call the real driver functions with isolated kernel fixtures.
They do not establish negotiated hardware IMA_ADPCM capture support.
The suspend test models the flag before real hw_params calls.

Uninstrumented ordinary and staged capture each passed 70-second RW and
MMAP recordings with RESET, pause/resume and reopen. All 14 segments,
14,208,000 mono S16 frames at 48 kHz, matched independent sequence
hashes. These results cover ARM64 QEMU TCG with two vCPUs and 512 MiB.
Physical VZ/MOTU, host sleep/resume and broader format, channel and
architecture coverage remain pending. No general high-load scheduling
improvement is claimed.

LLM assistance was used for analysis, implementation, fixtures and this
explanation. The patches carry Assisted-by: LLM.

Thanks,
Joonho

base-commit: a4311e9447bbb219044db38897f95be112f46a8a
