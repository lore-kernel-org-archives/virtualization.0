Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.216.45
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793252642;
	b=SSXbcPwPcW03SEog/7BoxnxcmmkQ+0jXWYbXCb9ePVSzkLAsveQ1fEPqrdAmjKYDLJ24
	 16AJO8tYtz5SFKXJWd3xXkZRxGeuC4K65bqAb8WjTi3YTejfBPHPTWP87h6HnlbQNb6++
	 pKhOH2NQrWoPZ63WQgM7UIBqxdvAOuJjw7MoqN92DUDVxyXMuFxbCd6tq+MHCjUfSnNrC
	 l0xpsJEX67rNZ35W4V8Ax7WURzNLnWSbVSYobQ2SZ7W0YJqnbnNtZoiucWRBbXP4zjeCk
	 M7VlPCt4polZJNS4ZinVjJextq1VL5GyHhl+sqNLvP7s0rj7QgxySEAM4QtqRrBrHaw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793252642;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=Q4850yBNH8viXsP6J8r1kevxOhyy2BKszcZ9KnrtoRg=;
	b=FZ2jCwT9rxgKAHdLxXXQG1hKxH2fyUbr0YLYo+mfUIsR364xT+Nfyd/Du2y02eywc3fS
	 6FWBYlb9lurDjuHM0jKBG6+KlMDeubXwEE4gtXai9PxwIsZpMVLXyzpwg2Qfwyg4dfZS+
	 VnBbMb4tLeMtWKlBAcWKduqZJQ9/umRzq/eoHpLVLVyxvO+IuESrM8JVcSlVeOWeEt9ZS
	 ExVWAuoaKRzIdb479cikR4SYqKVA/t9p9q1jAJSpr8Iu0mj6YnyimyGmo5gEF3W5RRAx/
	 KlmVeLxwyNX8nIIEDqke0Ip1kNccDCc/sjt/BPujmpT+vXGtHUO5J7v+W/Ys7tXhobA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=0km9KvbD;
	arc=none smtp.remote-ip=209.85.216.45
Received: from mail-pj1-f45.google.com (mail-pj1-f45.google.com [209.85.216.45])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA65D606A31D
	for <virtualization@lists.linux.dev>; Thu, 29 Oct 2026 05:44:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org BA65D606A31D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=0km9KvbD
Received: by mail-pj1-f45.google.com with SMTP id 98e67ed59e1d1-3ae2b7e1e17so1054243a91.3
        for <virtualization@lists.linux.dev>; Wed, 28 Oct 2026 22:44:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793252641; x=1793857441; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=Q4850yBNH8viXsP6J8r1kevxOhyy2BKszcZ9KnrtoRg=;
        b=0km9KvbDgezQbKjx0pMz3N74WjqeqJ76zcyqsrpvnMLrrvmulE+THnoT0Alulr4Sg7
         k54J2ot0Bx1DDsr85313H1vJn7L5y0wXMq5D+VS1kFyFewJx2aB5vEL6/YhCEi1B4xOL
         ANCoT1xmx85X6gYzG6aCgZsj/Yh3iHxoUpTrLM5Kybb+KNHxd96X22BFwU/rFOL/1tgL
         wq08BxjSa4P1CfQMhHzm4sRdX+8y7ItqdMYCM5Zz8q8YmRNnxv/3JczesANit52Q/YcP
         ZSHxJFAvOhHye0dik9py5yKUj8p95dF5f+QBzqNtO4VxxjA+acnNK9AtZEOwWY0hmv6m
         eWiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793252641; x=1793857441;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Q4850yBNH8viXsP6J8r1kevxOhyy2BKszcZ9KnrtoRg=;
        b=YKXsRE3BAN47ZKbcTuTzK5VhpJvUzx6xyrjGUl0Zw4xWhgpWIqJYKfj9o/HpnIFBTZ
         52ccpiXg9VscgHp5pqdseN0Gx3oX0f0Y3r+kTbPnfH/0CeMYTcmAG6EqsYPiXFOdW2mj
         EUYxTaVgTaSXYuhrXWo1f7CzGP3wcXgJK/eI46Rp2IWS/YMY5X5kTrK+Cd+wc8Hhhcis
         VLCipb3e0kuOCtOgyvLlrK2BUM1uSGl1QBGA6GKFcY0XJgVfEYSmboEzQYfeCvS9YYnB
         OErUAcJkC5sPwm6HIkkusdVH7B5If2t3nx46OPbmW0tRtE9RN+1A1U1IKuQqyNihw/og
         rIOQ==
X-Forwarded-Encrypted: i=1; AKwUvBx7JDQKgqa6GspLUKSj0cMA29zXpXUBfnuZgj97IilwSs5C+Y0RGoJ/lZQ1Q3zXqR1LdoHS+UwsTfOjVgpmAg==@lists.linux.dev
X-Gm-Message-State: AFq9FYJpqVAhJhd5xyw9i9RQgfAuabWsUIarwVl+1DsmrD2rrI4b8s03
	mLwmNPALr53rOyVJMTlPbAi0iIWzcNIOpsRSI2XOUA2mv2uhK8Rbv4V+
X-Gm-Gg: AYBFou33sZ8SynMfJGZCAvsKszLc6u9TbrlumDdM+sJFmEQH94Lmw0O6c6OA3Ko0Ax9
	aB+ZSe21xjR4cXqH8HewFiQucgEJUETPjb6+t3FSnGRoFxYLxFD/cox7UASl2Ri30rqcR6XLncb
	0nTNvqtLFr9ETqifpbW7Ormu7coCl5xtGr5OjB2DP/ueS/zfwd8SMj1ghlEnx37bsLttm/lVQD9
	Qmry7CkOjHls7UaAXKVCz6WE4ydqWWN07WW6NQlh08vCSLBF1vbC7Z16GR5CVJcmpdsopSwY4bF
	p6qVamFfJg024KQcWZJt464MQ09k9k4iDWBtxUbmXHmigEzhypPEkisTsu1ZFiK81SMLG6PI7q1
	Pvr32fdtWh/sj9PY4JfhZjcrjIod7+AtU/dzbMluLkBpI0NWBRJ17fwqRZkUsSCW7R+2NwX8eGV
	lOo3heAfBxgQhwnKxme+h1YJBmBgdhfiuYgnqPM4lMlVCtVvWmm0pBsnauUIG14wHTbHfSNkxfw
	1MfYWP8elN8aXv7qaEs0d7yAVw3OWNbqhhwjdUINQz/Bxy0iLhk7jtUoza7h9n7Mk5n6Jgf2fIe
	8ugGSsTH+AeKj9AoB35ub83CeNpf5IzyyAm7EdQRhiFyTp3f0KFO5NQ4VvkIFz+iCeJ1DOpvXmt
	upzsDzfVC3raGvRFaAa2J2itpEpbYX70eJWQThDvJHSD5BYQ=
X-Received: by 2002:a17:90b:2d8c:b0:3ac:3e42:60a2 with SMTP id 98e67ed59e1d1-3ae58236d2cmr3350776a91.33.1793252640923;
        Wed, 28 Oct 2026 22:44:00 -0700 (PDT)
Received: from localhost.localdomain ([183.96.175.225])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3ae6e83127csm2433520a91.10.2026.10.28.22.43.57
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Wed, 28 Oct 2026 22:44:00 -0700 (PDT)
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
Subject: [PATCH v8 00/14] ALSA: virtio: staged capture recovery and PCM RESET synchronization
Date: Thu, 29 Oct 2026 14:43:40 +0900
Message-ID: <20261029054354.2931-1-mynameisjune111@gmail.com>
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

This is a local draft of the next complete revision of the staged capture
series, based on sound.git for-next at
a4311e9447bbb219044db38897f95be112f46a8a.
It supersedes the submitted v7 series and includes all of its unmerged
prerequisites. Please apply this series directly to the base, rather than
on top of v7. Targeting 7.5 or later still works for me.

I consolidated the staged capture implementation and its follow-up fixes
into patch 9. The request-lifetime and ACK changes remain separate, as do
the notification priority change and the three RESET changes at the end.
The capture compatibility options remain opt-in and disabled by default.

Series layout

  1-6: ACK errors, START recovery and request/DMA lifetime.
  7:   Mark core stop-threshold accesses used by capture policy sampling.
  8:   Send STOP and synchronize teardown when leaving PAUSED.
  9:   Staged capture, dsnoop policy and lifecycle recovery.
  10:  Staged capture period-work priority.
  11:  Capture compatibility option documentation.
  12:  Optional PCM reset operation under the stream lock.
  13:  Staged capture RESET accounting.
  14:  Ordinary indirect capture RESET accounting.

Patch 8 extends the earlier paused-stop change to invoke the driver's
STOP trigger. Marking stop_operating alone left the device paused while
subsequent teardown expected it to have stopped. This is a core behavior
change affecting drivers beyond virtio-snd.

Patch 12 retains the common pointer update, time accounting and XRUN path
in snd_pcm_lib_reset(). The optional operation runs with the PCM stream
lock held through core position and appl_ptr completion. Drivers without
it keep their existing ioctl RESET path. The same operation runs after a
successful prepare.

A successful callback member completes its reset before its lock is
released. If a later linked member fails, the first error is returned;
there is no group rollback. Earlier members can already be reset, and a
failing callback may have changed state. Mixed legacy/callback groups
retain the legacy members' existing post_action policy. Applications must
recover the group before relying on its positions after an error.

Patch 13 preserves RX completions arriving after the common pointer
observation. A refill failure finishes the core rebase and then reports
XRUN through period work. Patch 14 fixes ordinary capture accounting after
RESET, including MMAP capture. It discards the requested unread samples
while preserving the device's ring offsets. A refill failure returns an
error and stops transfers, requiring drop/prepare or reopen recovery.

Validation

The full ARM64 Image and modules were built from the new base with KASAN,
lockdep and W=1. Core and virtio-snd objects also built at every one of the
14 intermediate stages. ARM32 LLVM core/virtio-snd object builds passed;
ARM32 was not booted.

The new-base QEMU runs covered normal and staged capture, playback, policy
changes, linked RESET/prepare partial failures, delayed control replies,
failed prepare, RELEASE retry, suspend and virtqueue reset recovery.
The linked synthetic fixtures cover atomic and nonatomic streams with
all callback combinations, including errors after pointer changes and
later-member prepare failure.

MMAP_INTERLEAVED capture was checked at 48 kHz, mono S16_LE with both
RUNNING and PAUSED RESET, managed and free-running stop thresholds, XRUN
recovery and reopen. Seven VM runs produced 21 capture segments and
8,016,000 frames matching the deterministic sample oracle, including two
70-second one-vCPU recordings. Fault hooks are confined to separate test
builds.

The two earlier TCG failures were followed by 22 comparison runs using
the previous and current kernel bases. Both used two vCPUs, 512 MiB, the
same QEMU and rootfs, four dsnoop clients at 16, 44.1, 48 and 96 kHz,
and a 48 kHz mono slave with a 160 ms buffer. Kernel configurations
differed only in LOCALVERSION. The main and initialization kernel text
ranges and the executable/text-relocation sections of virtio_snd, snd-
pcm and snd were identical.

In alternating 70-second TCG runs with two CPU busy loops, the previous
base failed three of four runs and the current base failed all four.
Lowering only the busy loops to nice 19 still failed both runs on each
base. Host load varied substantially and was not controlled. These
counts alone do not establish a performance regression.

The diagnostics distinguish two paths. A client can exceed its dsnoop
stop_threshold and receive -EPIPE while the hardware keeps running. With
more severe delay, the driver rejects completion when capture progress
since the last PCM pointer observation reaches a full ring
(pointer_window). dsnoop can recover the slave before reporting the
error to a client, so a later RUNNING state does not rule out a
preceding driver XRUN.

An instrumented 70-second TCG run on the previous base hit
client_threshold at 7680 or 8640 unread frames against a 7680-frame
limit. The current base completed all four rates in the corresponding
run, totaling 14,287,000 frames. In HVF controls both bases completed 20
seconds. Delaying only the 96 kHz reader by 240 ms produced
client_threshold XRUN on both bases while the other three readers
completed their requested frames.

These results support delayed consumption and pointer observation under
CPU contention as the observed failure conditions. They provide no
evidence of an executable-code performance regression in this
configuration, but do not establish identical performance under all host
loads. The original two failures had no branch-level instrumentation;
their exact return sites cannot be established retrospectively. All
failed runs are retained. The pointer-window protection and buffer sizes
were left unchanged.

All 22 runs completed input-integrity and module-hash checks without
KASAN or lockdep diagnostics. Four runs separately recorded
pointer_window warnings. The instrumented and uninstrumented fixtures
are reported separately because instrumentation can affect timing. This
is not a lossless-capture guarantee for overloaded TCG guests.

Scope and remaining review

This revision has only been run in QEMU. VZ/MOTU acceptance is still
pending. Other MMAP layouts, sample formats, multichannel capture and
concurrent RESET between mmap_begin and mmap_commit were not covered.
The new callback's linked partial-failure contract and the general
paused-STOP behavior need ALSA core maintainer review. NOMMU and 32-bit
runtime behavior are not established by the ARM64 tests.

The public Sashiko review criteria were used for a local audit. This
revision has not been reviewed by the Sashiko service. Physical-device
acceptance and ALSA core review remain outstanding.

Thanks,
Joonho

base-commit: a4311e9447bbb219044db38897f95be112f46a8a
