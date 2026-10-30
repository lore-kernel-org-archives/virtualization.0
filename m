Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.215.180
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793337996;
	b=NUnQk6gLvMl1mtIO3/3bNM+WE/lyYBHZlm00yHi5iXVm2aRWxvOMw0+EhIop+4KbHD+y
	 z54T9U8QqfOxLy2WXw0tIc7+/S+48DUQGdqcvlP5t6TgHIIfqWexwqfokxm9qLtXoaH2r
	 r6I6NJ8tsrRfZT8MqXNv7m8S+OzqacHVoDJd6MseYCzM+nlvZpodMChgSDo3dfJk1kyvg
	 XTvJ7r1ZfFcBQCKYHHr4PA36pYALe8aAj7GLUs3TUckVjcNI/+3R4ZOJamZRMsiD9rmwf
	 dPbQ9mkouF1JIP6m2dRwuV1IIUOkc94gN68JOKR049gwfQM5aZRJjgjqYb94iLGsEFA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793337996;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=EYLJkULI4RCqRinApGy05xYoNrT80+MOd8wREM3Ge2s=;
	b=YjYNzCoXB7c/gQ2KZQ76j4ZJI5HPOCVV3/v4NGuS/G+ZVfOE0QkfZl9bfDYhN36nRpcq
	 kQiJmMafVP7LxkfEiKYdPLlX3k6GaCimZGUqEsfJNogSzBEh6PBdKQ31DKoE13ykskS5g
	 BXsjm5Y5YSUnKm/hwUby1+Wq+mp9fAnAApDOtxxXI7I9Ah/QHP2j6V5NpOtaF8iaxgucX
	 qa78vaMgzZVthJ4gld6bFYaqZxjsK8Vfg/k7iaM32Up9cXuY8K/cH+CmyZU74x2RGBQyM
	 eBpwL2+hUrcQV/kNG8UqX6NnmGloUDHijogV4P72r9JG1dPh+PZejeUgNaCF1175bvg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=hYG7Wwhu;
	arc=none smtp.remote-ip=209.85.215.180
Received: from mail-pg1-f180.google.com (mail-pg1-f180.google.com [209.85.215.180])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79605606A31D
	for <virtualization@lists.linux.dev>; Fri, 30 Oct 2026 05:26:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 79605606A31D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=hYG7Wwhu
Received: by mail-pg1-f180.google.com with SMTP id 41be03b00d2f7-cd5d2dafeccso140039a12.2
        for <virtualization@lists.linux.dev>; Thu, 29 Oct 2026 22:26:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793337996; x=1793942796; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=EYLJkULI4RCqRinApGy05xYoNrT80+MOd8wREM3Ge2s=;
        b=hYG7WwhuYLsHzm22b5yaAoViwqwm8NA3Oi3J+aPTKMWhYuv+m8c3cDXTE+8RhBZ61M
         xWY8+Zpi4ZTOZlQJrrZuVip+veA4wZ7xkqK3UcaZSLad+BJ+3qBN5vsBhzgv2ohTkQwv
         sZPLyvA/2NyMbKzBVD7a/v2pEYysyTAXM4CgoYa5aVKXPZcDhAfWcTLuTeZ6hKHoKDG/
         7tiJ43AgO5R+C46ZfSyotFGxga0JMpWUaC848CuW8zaZjK0w2SGVYI38R0/mczU3T/xn
         aLf7mLOs28LrwoBbxghiJec0wAR0Vk0iTqPNrOiTALvjSa1otWQeFyA7fzxyBAYeDjul
         7aIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793337996; x=1793942796;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=EYLJkULI4RCqRinApGy05xYoNrT80+MOd8wREM3Ge2s=;
        b=EfX4QmNANqy5Av34kuy9zP3FtuNpoxLRQw6XtkAAh63BzAI7O/AIeH859uy25ax/gy
         jqxeAmtR2k0IDtSpSRecET4bYdVL0FgwvQKRfl/IDoDg5TER7QdICUvoY6XJEZUhxHnx
         +6vikeV0DYHDTgxdNuHx+Hw/OcQKAvRX9KG1hr7NqTquRvXesqiX14+oqIasxPBSHxop
         VlOudjVbz5N/M+oc2k6PeWaevcJkOJEljcmdP3OL0qKHJL0Owy0f5rQYGyMbcSQ5M6AV
         3B7A6af/xN2ObeDq0dWR1g1djPbv0Ul3SStGg8bL7vMZCsCapdea1fiNu4mAkKM4o5or
         PBQQ==
X-Forwarded-Encrypted: i=1; AKwUvBzZKnd/HmHHzTnJ+YvQhgFV6/xxAC6f4BNDCVSm1T4+U5ZKMeLfVafnm/gyrSbtuOpwOQ9LEeXDHDe+eXQZ3A==@lists.linux.dev
X-Gm-Message-State: AFq9FYLAmIzDmZQPhUNNBkNQBBdyQc8ym1sL3exdEo640mxhG8VsAk8b
	wBpu5squCHlCTwH/nq9PCpyGgp3VDIwL7FVnyrpZiNw3eu5qjdXC9Bqy
X-Gm-Gg: AYBFou3UrhTtjro/0CUK5LJAb6LppmxD/B53RmetfCx9JHaGsl2wkRaaqE2Vs95hFCM
	Qwir4u2HqNMejXUZj6Am2xU6Fn23M76eeJQbOLH40/Cgspn2z3jjEFvy7xwUq9hJy55Bx4Xo9pg
	tnhSE2D3LH5xJHv4ERMLEmuxZVt3iWzf6FrUG327Aa2tjsPdCqciVWIaCbVlOhSRHy3IKbhUf7a
	SXVX6Xo26oPw/wDtBjpwOYCue6WVM/GyHMXffM3/pMVuT8RtFvX+chcjKCW7NHf4vbOx3xLRw+s
	4CAlIDFOom1faZtX+eoM7Kd6zrIo7a16+W3HjCLMvHn5rq4PgKcuo33tudXK++IFBOQKIFnH2nb
	AfnePrYaqp+SpH5QOXAky93ePs2MIZHPx+Z9XA7yghM+6niJmFfZnovq3hjLv9Yx2BjFk2xWJG7
	g0CfzIigoSpD/O0KYOyRKpKYXHwkLBq9vr0X7KoY0/rA9erJbbd0AwKSGWMbGJd/HYpmM6s0MgH
	UxpmBZNa6z3Qz92j9uvFApd/yaf+Ilp65/N/IP1MFJYbIby0zPhN4C/9LvYeQeqrGs7P45qZVXt
	VMePXfFS9uqLnXQ6lWvH8koMpa7pRaXBNsEQbkVTJwQg378bPRm0uae4gdyNSanBYu4G+M0i/BZ
	83bjqo2Q5dpHqa16X1OwoEQ2iWFxgAEp/35eHI6Awp+DdMstWlEfAyZs63K1TfxMbTi5J
X-Received: by 2002:a17:90a:ec8e:b0:3ac:9599:a689 with SMTP id 98e67ed59e1d1-3ae897d5fc0mr792195a91.34.1793337995724;
        Thu, 29 Oct 2026 22:26:35 -0700 (PDT)
Received: from localhost.localdomain ([183.96.175.225])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3ae845429e6sm2421027a91.6.2026.10.29.22.26.32
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Thu, 29 Oct 2026 22:26:34 -0700 (PDT)
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
Subject: [PATCH v10 00/14] ALSA: virtio: staged capture recovery and PCM RESET synchronization
Date: Fri, 30 Oct 2026 14:26:15 +0900
Message-ID: <20261030052629.27742-1-mynameisjune111@gmail.com>
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

This revision supersedes v9 and includes its unmerged prerequisites.
Apply patches 1-14 directly to sound.git for-next at
a4311e9447bbb219044db38897f95be112f46a8a. Targeting 7.5 or later still
works for me.

Previous revision:
https://lore.kernel.org/all/20261029085032.70689-1-mynameisjune111@gmail.com/T/

The series adds staged capture accounting for shared users such as
dsnoop, lifecycle recovery, and synchronized PCM RESET accounting. The
capture compatibility options remain opt-in and disabled by default.

Changes since v9

Sashiko raised five findings in patch 9 and four in patch 14. I folded
their fixes into those patches. The other patches retain their code;
patch 13 has refreshed hunk positions. The final postimage matches the
candidate used for the new regression tests.

Patch 9 now checks for a detached virtqueue in the PCM IRQ callback.
Period work is disabled until open succeeds and disabled synchronously at
close, including ordinary capture. hw_free cancels work after teardown
even when cleanup returns an error. These changes cover late producers
after reset, failed restore, and pause-restart error handling.

Playback and capture ACK take each runtime's buffer_mutex with a trylock
while holding the PCM lock. This excludes prepare without waiting in the
reverse lock order. Linked prepare marks buffer_accessing negative only
on the member that initiated the action, so checking that counter alone
left later members exposed to the old appl_ptr during counter
initialization.

sync_stop checks the PCM state under its stream lock after acquiring the
lifecycle mutex. This waits for trigger to finish and preserves a newer
active stream. A definitely rejected native pause also refills RX buffers
that returned while transfer was disabled. Failed recovery latches XRUN
and keeps the teardown obligation.

Patch 14 suppresses ACK refill during the common RESET pointer
observation. Paused RESET observes the latest device pointer before
rebasing indirect positions. A late refill failure retains XRUN across
capture completions, and RESET avoids scheduling new work while the
device is resetting.

A further playback check found the same prepare/ACK window: a forced ACK
consumed the old appl_ptr after the driver counters were reset, and the
first write failed with -EPIPE. The buffer_mutex trylock now protects
playback as well. Limiting the XRUN latch to capture also preserves the
earlier TX completion behavior and playback pause/resume after an event.
Both cases passed with recovery and reopen on the corrected candidate.

Patch layout

  1-6: ACK errors, START/RELEASE recovery, and request/DMA lifetime.
  7:   Core stop-threshold accesses used by capture policy sampling.
  8:   Partial-progress notification under the PCM stream lock.
  9:   Staged capture, dsnoop policy, and lifecycle recovery; uses 1-8.
  10:  Staged capture work priority; uses 9.
  11:  Capture compatibility option documentation.
  12:  Optional PCM reset operation under the stream lock.
  13:  Staged capture RESET accounting; uses 9 and 12.
  14:  Ordinary capture RESET accounting; follows 12-13.

The IRQ and work-lifetime fixes are present from patch 9, where their new
lifecycle paths appear. The ordinary RESET observation flag and error
latch are introduced with patch 14. The two ALSA core API patches remain
separate from the driver changes that use them.

RESET behavior

The callback retains the common pointer and time handling through
snd_pcm_lib_reset(). Zero permits the core to complete the member's
position and appl_ptr rebase while holding its stream lock. Drivers
without the callback keep their existing ioctl path.

A late refill failure permits that rebase and reports XRUN afterwards.
RESET can return zero before the notification worker publishes the error.
A nonblocking read can initially return -EAGAIN and later -EPIPE; paused
resume is rejected. Prepare or reopen is required for recovery. Linked
RESET and prepare stop at the first error without rollback, so earlier
members may already have completed. These policies are unchanged from v9.
The internal snd_pcm_ops addition requires module rebuilds.

Validation

Seven reported conditions were reproduced against v9 and passed with the
fixes: the NULL-queue crash, prepare/ACK interference, RX starvation
after pause rejection, stale sync_stop, nested RESET refill, stale paused
positions, and loss of the latched XRUN. Prepare/ACK tests also covered a
real linked playback/capture group with capture as a later member.

The two work-lifetime findings share the close barrier. The original UAF
itself was not reproduced. Tests exercised active freeze, RESET, failed
restore, close, late work submission after runtime release, and recovery
for ordinary and staged capture. The uncertain control-result subcase of
the pause finding was checked statically; the forced pause rejection
tests used a definite error.

Thirteen fresh ARM64 QEMU runs passed with KASAN and lockdep after these
playback corrections. For each capture mode, an uninstrumented build
recorded 70 seconds through RW and another 70 seconds through MMAP after
paused RESET, followed by reopen checks. All 14 captured segments,
14,208,000 S16 mono frames at 48 kHz, matched SHA-256 values generated
independently from QEMU's sequence metadata. The comparison accounts for
the intended RESET discard boundary and the backend's epoch change at
restart.

RW and MMAP use separate VM boots to stay within the test backend's
4,096-response limit. Test hooks are separate from the submitted code.
ARM64 W=1 Image/modules and ARM32 LLVM object builds passed. Series
application checks compare every intermediate postimage and the final
source with the validated candidate.

Three fresh intermediate stage tests passed: native and pause-restart
capture at patch 9, and paused MMAP RESET/reopen at patch 13. The three
patch-13 capture segments also matched the backend sequence. Stages 9-14
built without compiler warnings. Separate failed-START tests checked
prepare, direct reconfiguration with the same geometry, and close/reopen
recovery.

Earlier prerequisite and RESET tests remain relevant where their source
is unchanged. The new 70-second results do not measure high-load
behavior. Earlier TCG tests had reader gaps of 165-283 ms against 160 ms
buffers; those comparisons cannot establish performance equivalence or
exclude a regression. Work priority provides no real-time guarantee.

This revision still needs physical VZ/MOTU acceptance, a separate KCSAN
run, and broader format, multichannel, playback-error, and ARM32 runtime
testing. Playback event tests cover completion-policy preservation and
pause/resume, leaving broader playback error validation pending. The
partial-progress helper and linked RESET contract also need maintainer
review.

Coding assistance was used to analyze the reports, prepare the fixes and
test fixtures, and draft these explanations. The patches carry
Assisted-by: LLM.

Thanks, Joonho

base-commit: a4311e9447bbb219044db38897f95be112f46a8a
