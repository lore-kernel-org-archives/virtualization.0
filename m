Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.177
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793156003;
	b=FiA85O8fIpZBL8n1/a8WDrX0CxJO6dqdmvAbpU4/7utUBOj5sFCQx2M8eRYc9RoCCnzY
	 UUafkGWUmLOQJ4+cGOrKTVSrgJ0ZHMophfdEPR3b6N0goRbmybbSdguTTPH0kNirIqRF+
	 dUEcLEu/G5vQfZEYuV9okP+sCRwxHZFw/2zIamARRu0pN4H5F/OJfWmtOLZgf9QhSO+WN
	 gQ8yuaSO5iATLnKrVOwbi+FTeDeaixvfZrqA6LALGjr5ydPajYdx61mG4U8eT3Hc96Pue
	 IOd0myjsOrSiKwkZW+SH4fUTzQIcTlO7XfokjGgE1te4464NhF+J4ujJEkrR2bMH0Qg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793156003;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=MFltAnN4KbJLJHAjYR8GHiau2832NVeS+N4nXWFF7jM=;
	b=RHNRAFgxokFQZI44s25aktC3Hc6QdKhO/advR8HPrSoJnp6RWOugPFfPcXUq78B0MWIW
	 Lnz6KQGd1s/3EDEwuhsNSt9ps3RDKXpcGjpfeIsUB1XGLsSSTeLRRjrWW6Inj/GdEr9HV
	 O9CvYnSxcmnnavOdZ5XF2AwTt3ZZ7rNFSTcfaWf5aVZ8pce+aBhZV4ttu6cqQQEvqOywT
	 vZYVefG4R61ok90CvB/NbWYBSCJMjXmKV2XJlwXssrV8h7IP7DShBLgyoyMxz5THhtfyO
	 4bKGH8fdNTNv0UHLhOQi2vWpEpVEdQINFuU1sZ9zxhrxYos5MLTk8oeqDVeQoqWP9+w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b="p4sC1/bu";
	arc=none smtp.remote-ip=74.125.82.177
Received: from mail-dy1-f177.google.com (mail-dy1-f177.google.com [74.125.82.177])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33E36606A325
	for <virtualization@lists.linux.dev>; Wed, 28 Oct 2026 02:53:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 33E36606A325
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=p4sC1/bu
Received: by mail-dy1-f177.google.com with SMTP id 5a478bee46e88-369f33df08eso974821eec.0
        for <virtualization@lists.linux.dev>; Tue, 27 Oct 2026 19:53:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793156002; x=1793760802; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=MFltAnN4KbJLJHAjYR8GHiau2832NVeS+N4nXWFF7jM=;
        b=p4sC1/buVRz+HoHnCrPm5YypAeYq7h+NHkQVB/wFjN5OxryMm4QtJydY7Ppks6kQZE
         si8s/OtxD0TqeYTGBlXkZ6hANt2/CYfyNsufjN/tiKJOpp9Wmb7wnxcfyFoOsobMKUNm
         zP/L7AEDUEgxV1Kn5ASGJQyI4DhcjnTqRSmcLJBfKq9ckGPi8TLp4STi9p9VyUIBbFYk
         tVCemN1JikHUqIYEcXpFUcOgUpkfeoihtiBVWpBVb0PB2K9n7v/PyarYIPsYk4V1FexK
         BdorGLtuTvHUw4ZjzBxgbKDd12w79fPtp4FfCI+mTVgEXQYVpZcu03ssA2P0MdSGaxIK
         UlKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793156002; x=1793760802;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=MFltAnN4KbJLJHAjYR8GHiau2832NVeS+N4nXWFF7jM=;
        b=eQJUW7fFmoLS6wdKaSC50+HdCDMdKkMMmeTmPyOwdicLxS7xD6WIxk4WIBPGUHT0Pz
         ZF9jadgq5n1XvwOLYeVfUXqVlp4akCupkneFddtfyM78W2d5+TYjrD4FQfmrHviWN1Am
         JZw76UgSb+blgM+wbT9MlEp8YpOiAsZ8K3QzGERBFYuRRdt7O64hLQady4IRWJwVKPAT
         UEVzkJoCJKHfSIfkOgwRhUd2TvjzLXq9qOjbFdhxQ0WUt9y6v7lg5/vMHed38fvASysC
         RqdAIOvGn2frYvKASdQQWtavZlm7DV987eqnCXv4Pny3BXePhbWNcLQpoaetG4/Wkd7n
         ejbQ==
X-Forwarded-Encrypted: i=1; AKwUvBxOm9dZIdtEUHCTDwNzO/yjTFamLdyt+tyFH2ZqGOxbOYfk6NwZRW5CZxMriBGAftLAog0gJP91y41iTGvxBw==@lists.linux.dev
X-Gm-Message-State: AFq9FYK9d68NhQ1vAj7h5G1P3SVSF6XzgLzXF4bMC5rrVQLN/WFuA1ca
	Wcp3E/r5cNhD9kCVdlnHBN8mI/InSVJxgCenQ3uvyZ3eMC62vgRbCqhi
X-Gm-Gg: AYBFou2XgS7nmaCjObLtYHBqHXzYK/Pas7nHUstWmZbHqhrFRd/9hVDuvKYLzIQ98a+
	YZTRByNWTrxKpQYyUznVWh3dPkAHoi/BltEaMKP47gppf1C1jK54NZRbaZ4S8mgERe0ztaMMNBU
	bW8msM5NCNwvj0GTD6x8k7Bn1wmVoUpZwwvN8cvG+i1gd54/IpgCIudyPs8ff54q0OJEF7awrTk
	mHFST2NrfkvcgHPMPfPl4X6O2DyoulBl3XTPZ7N6Ux242iqyZDIkTO8Kv3uRIzC0bqi70qftl7s
	LPzlaIhae/ZIpa4jR6+JTk7ELIZdG3/cyBqxgNywfm48X8uYbe1BrATi8qVmqLcMw2RZwfg4HLb
	iETrZMDdv1Erni4X/3dGMSM4JB1NsxDkjE/r2GfZ+Lu5xrPdDCIDkO4wzdPlJiMi306Z4k78cCU
	LS8RcZ+H9IvCo95H6dq6nksCNp5kZx2necZzm7ybWJAnD5nDtMuF18QS9CFWsyZiqqQE6qClV/s
	N7WiCMmEOCJNwPOf4kZUuHA5i0vAS0ApqyJBvWhd/S8YGaf4kEb2YfT83vaQ1tomzY2Sxw0x2Ev
	Ms/jXudllpFmDOt1OYW9m2y+CwclQPqIgJ/VaM1pkGYinRVeI29xqeQBgDI0oJmoo3IVC42xsrx
	aY9nB4yNwmnEncCPcDzrZgTmPFtX9Rk80OTNooQ78WkzGfQe6DuHQgnqXDj1n4WvvdyuL
X-Received: by 2002:a05:693c:240c:b0:369:b75e:d24f with SMTP id 5a478bee46e88-36a20108feamr1659593eec.24.1793156002025;
        Tue, 27 Oct 2026 19:53:22 -0700 (PDT)
Received: from localhost.localdomain ([183.96.175.225])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-36a239644efsm1711914eec.23.2026.10.27.19.53.19
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Tue, 27 Oct 2026 19:53:21 -0700 (PDT)
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
Subject: [PATCH v6 00/14] ALSA: virtio: staged capture and dsnoop recovery
Date: Wed, 28 Oct 2026 11:53:03 +0900
Message-ID: <20261028025317.92450-1-mynameisjune111@gmail.com>
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

This revision addresses the Sashiko review of v5 and includes a closer
look at two intermittent XRUNs seen during the follow-up tests.

The series applies to sound.git for-next at
bcb4494239f57c98a8ef576566b03f2935b3000f. All prerequisites are included.
Targeting 7.5 or later still works for me.

For this review, patches 1-11 retain the v5 code and commit messages.
Patches 12-14 carry the review corrections separately:

  12: control-transition waits, aligned control values and capture drain
  13: prepared/reset state, failed-open lifetime and pause/ACK recovery
  14: documentation for the five capture compatibility options

The earlier dependency chain is unchanged: 1-6 cover request lifetime and
error handling, 7 adds staged capture and pause restart, 8-9 cover ACK
accounting and period work, and 10-11 add policy sampling and dsnoop support.
The staged-capture and device-compatibility options remain opt-in and
false by default. The VZ compatibility assumptions still need review.

Changes since v5
----------------

Capture drain can consume its remaining tail without queueing fresh RX.
PCM state-changing commands and pending-RX teardown wait through signals
within the existing timeout. INTEGER64 values use aligned response storage.

Transfers now require a successful device PREPARE and a live queue.
Reset fences transfers before resetting the device, cleans up the queues
and period work, and makes prepare re-establish device parameters.
Failed-open cleanup cannot leave period work using a released runtime.
NOMMU capture copying also accounts for native pause.

Pause recovery distinguishes definitive command failures from uncertain
submitted commands. RELEASE_SENT retries wait for RX drain, preserving an
existing XRUN for prepare recovery. Pointer and counter reset is locked;
ACK cannot advance past the position observed by ALSA. A successful
partial read while paused also arms cleanup when it crosses the stop
threshold.

Validation
----------

The corrected ARM64 kernel was built with KASAN and lockdep. The
non-staged drain test changed from -EPIPE to a successful final-frame read.
The paused partial-read test changed from prepare=-EBADFD to successful
prepare and 48000-frame recovery in both pause modes. Queue-failure,
failed-open and virtio bus freeze/restore tests also completed.

I compared v5 and the corrected kernel using the same QEMU device,
48 kHz slave, 960-frame periods and 7680-frame buffer. Delaying a bounded
to free-running transition by 120 ms caused both kernels to reach XRUN
before the transition call. The test had already used half the 160 ms
buffer and had about 80 ms left before overflow.

The shared-client fixture also started clients before creating all reader
threads. A controlled setup delay caused client-threshold XRUNs while the
hardware slave stayed RUNNING. Starting each client from its reader thread
after configuration removed that startup gap; both kernels then passed
three repetitions with the same delay.

Delaying only the 96 kHz reader by 240 ms during capture produced a client
XRUN on both kernels in three repetitions each. The 16, 44.1 and 48 kHz
readers completed their requested frames. The hardware slave remained
RUNNING. These results give no reason to weaken the ring overflow checks.
The original intermittent failures lacked per-client timing, so this does
not establish the exact scheduling history of those earlier events.

With one vCPU and two guest CPU busy loops, both kernels passed the
13-case mode/lifecycle suite. In separate VMs, both completed 70-second
captures at 16, 44.1, 48 and 96 kHz and a subsequent five-second reopen.
Each client received its requested frame count. KASAN and lockdep stayed
quiet, and the loaded module hashes matched the intended builds.

An initial combined run exhausted the QEMU fixture's finite test signal.
Those failed runs were retained, and the long capture was repeated in a
fresh VM with enough signal. They are excluded from the passing results.

Physical VZ/MOTU, KCSAN, 32-bit and NOMMU runtime tests were not rerun for
this revision. This round checks frame counts and recovery, without a new
bit-exact sample-continuity claim. Not every signal/late-RX ordering or
RELEASE_SENT retry timing has been forced in a runtime test.

AI assistance was used to examine the Sashiko findings, prepare the
corrections and diagnostic fixtures, analyse results, and draft this
series. The affected patches retain Assisted-by attribution.

Previous v5:
https://lore.kernel.org/all/20261027234334.32551-1-mynameisjune111@gmail.com/
Sashiko review:
https://sashiko.dev/#/patchset/20261027234334.32551-1-mynameisjune111%40gmail.com

Thanks,
Joonho

---
base-commit: bcb4494239f57c98a8ef576566b03f2935b3000f
