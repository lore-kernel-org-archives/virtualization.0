Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.215.178
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794355549;
	b=I38JEmrGw89wW5RE4MTbwVszHimO7FFViuyoX7L/k+eCyOgyzkvBHu225cnymDAi+6KC
	 jGjquGbYlpsKoiFzhpJCMjxjm2IfiBtMswmpqb+/yiZZmT+P5XVuj01iyh7lV5wbm3lA3
	 nm7JfVCO3+xSH+QtICGd03oYB2tyfG89foYzZx6CDwXUzAPquSxYlD1RQhC4SLzcVQ/YY
	 DJvItaTl+cuLYcfqRqCa5JIyeOU6B+wAy1t/P9qhbSV+uqXpi0TCaOkNsxs02VAnPIlSQ
	 s460/yt5u0+wpNnzQmzMkJ+Aziqi2oC0pcU900EsBdf5+7nwe7HsxvFQelhCS/a7ngw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794355549;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=zX4uQsxXhxyepa6SxEX75JVt+g8l7wUTYuvdXb188cM=;
	b=z4Gxxv0czW4jjIcsg9rnsgvR0z1xfE29mBNDPn3r54iZ+bSS+89gqToD6i134tJV5xsv
	 8kJlwrozMgzMuY95TtsNTtlE7D/qcNoleTJGz8z9qz/MQZ03el6jz/ZulUr3V8fVgGRHQ
	 KATmvpNQTS51+v7LiQbDE82SidiDksQhU7xzcrO7FZoeKZQAu+Ox/mI+7dFguKiehX1/m
	 2q3qtTQqoVjOlB4sUNLTwAVMWHzQKlqKeBc5G6WUDloc4rG/C9wEFGzUPoBsecjLBRq9M
	 yjrnursodM1y+RWCU76Tsqba54mFn9mShNPxQGmxNNRe0k1325EGBU8ZHvSL0hiTpWA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=eZpPKvr4;
	arc=none smtp.remote-ip=209.85.215.178
Received: from mail-pg1-f178.google.com (mail-pg1-f178.google.com [209.85.215.178])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D4AC606A31C
	for <virtualization@lists.linux.dev>; Wed, 11 Nov 2026 00:05:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 7D4AC606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=eZpPKvr4
Received: by mail-pg1-f178.google.com with SMTP id 41be03b00d2f7-cdb684859cbso1491202a12.1
        for <virtualization@lists.linux.dev>; Tue, 10 Nov 2026 16:05:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794355549; x=1794960349; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=zX4uQsxXhxyepa6SxEX75JVt+g8l7wUTYuvdXb188cM=;
        b=eZpPKvr4Cuc2iU38zInnBj1BVA/2NOhQL0UKPaze4cmJSANAAnJdFqKpGpRg+gkUTe
         eT1aeNjr86UqcnT2gNOxUCIj+9s9XAF7Hbq7+iTO8tV7RF4UYMY+MIfetJbw5sZyZjYA
         EvUHZ3zpAEEZDd8+zGRxoZ+/W9o0xBZzuqs23/qgYvACGmGdBIDED8fCNRygrVcvfXlP
         2oKHqIhwGMG7hEuCmPN4VDMKsj3U9a3FgVcHZNxXhrmjsMVZBuKhMRTkRe8TgNyTFy4H
         c7lSSIo7yZAC0O9dDutWBb6oACdsSFXfnxYR16Et7lv8X2b+RHum0DbwEB/qojMIzTvS
         F4eA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794355549; x=1794960349;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=zX4uQsxXhxyepa6SxEX75JVt+g8l7wUTYuvdXb188cM=;
        b=aHlZUGXm7ozpVHfAY5afvu2bBbGZaHCyNUjb0/L8/xUEbP7GBKsl6pGgnMfaIMOjr6
         7cSCxfIHYyea/egi1iiP+kpRwAvRS5b/J8uNl3ZB62stDBZHVJs3iVkvi/6dgnOFYsb+
         x6Popf2moyGOsJ5A1hTFn+dzQH3YFCqi4vc6aPjWCak4uALB0FP9C0rVs0xjXsA/hAxM
         +oVohee97YINiF/gagy/htt7gG8Y3tMSWxITB8H61K57jSlqELbBSq/tYS0SmPc7cPkP
         UOCVGOCbHxBETKewui45pPXdJqQfH9g/eaWSHDhkOpkh9ic6dbv6McFcDUx11Dec8grp
         8NeA==
X-Forwarded-Encrypted: i=1; AL+hErEcTFlYSo0AYIqClv9fJMj/O65ByEiW1xm0/rRdjt/cijW/MVp9UmwcIAFM84e5ayNNgfg39TTboRh2amWePg==@lists.linux.dev
X-Gm-Message-State: APuU4Z8zgnWCd00i2RJL8FoO6sw+ZsoyyyJHrrN5Z6SiThyKxovJbNj3
	BNp4L8RUJsi5ivs5Og+h7JSDd8i9GyIVtF2J4S4H1IWv6hj1G7MAnkFK
X-Gm-Gg: AYBFou0VAOndaJvQSpdsWdEry942XcSmcUqEn9bZUItNJFKpgpeHDTz3W/6tP22dfvR
	8W7oz8ZDSoWNfi7nSJ92op1o+Tl8QYLZ6Kz9QuAyi7dPwj3J8OWpWRZC/BE+HVxP+XxuprgMSsA
	G0StUiBc/aVpLGL/0F9emjgA/VzXsWOQtwxjvie7G0fN8Urilk7kMgL/rZ7h7sLUkQdFgImthEo
	vq5/6iWPCqXlYa+N8UvfHNntl+eAdDwLpfJjGYX+Xzg0pGv3BSgeXJBhvi1FwOyj3anoO04jiyR
	TVaO8wes2/tF2nDq9NhFpqr93xv+crtVS8MKWjyRI3usKBJnQGi5viVwHuFajkE2INP5UnP9S7F
	XMzaPpK84wwxfn2M5cIj+ZKVYiTbMUF0QUphCmO0k6+ARVkh/wviMVZjrKGJiu90TcF21GbIIc0
	pOoMNT3Qwh/XFdL3fSYsyl79OHA7j6pA273zsp7BcKaDr2TXDMDKam+mbUpcJuiB7dDUMsn+x1E
	Iye/21QPFw2vNFu5j36/R/uewjMraG5MflAJdvq/JT1P1MYlgqvE8++KY3+CzSgflp1wlZdc+zD
	cb+SNflbfI57PfGkTezS/fR37VsTNUcEspii7e+CpPjF9/e0rLhIjlNQb6I3JndIvzwccBC6wrS
	NkjQUIPbLRbgqWIKmvfn+BzUNBe3TqfKUK/UMaSKMNPzVegk=
X-Received: by 2002:a17:90b:1c11:b0:3ae:a4fe:7ad4 with SMTP id 98e67ed59e1d1-3b182def9e2mr675655a91.2.1794355548631;
        Tue, 10 Nov 2026 16:05:48 -0800 (PST)
Received: from localhost.localdomain ([183.96.175.225])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3b1838e616dsm474361a91.4.2026.11.10.16.05.45
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Tue, 10 Nov 2026 16:05:48 -0800 (PST)
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
Subject: [PATCH v24 00/16] ALSA: virtio: serialize PCM recovery and preserve capture and playback progress
Date: Wed, 11 Nov 2026 09:05:27 +0900
Message-ID: <20261111000543.28550-1-mynameisjune111@gmail.com>
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

This series updates ALSA PCM recovery and virtio-snd request ownership.
It also changes capture to request-owned RX buffers so a valid short
completion can be appended to the ALSA ring without leaving a gap.

The previous version is at:
https://lore.kernel.org/linux-sound/20261109234049.79534-1-mynameisjune111@gmail.com/T/

This replaces v23 in full. Apply all sixteen patches to the base commit
listed below; do not apply this series on top of v23.

Changes since v23:

Capture now retains frame-aligned short completions and handles empty
requests returned at STOP or PAUSE. The final tail can update capture
DRAINING. A paused RESET observes the last committed position, discards
samples through that point, and keeps subsequent data at the matching
ring offset. The earlier direct/staged capture split is removed.

The intermediate bounds patch accepts a bounded partial RX response.
Initial RX reservation, ACK validation and refill enter together with
request-owned capture. Earlier patches preserve legacy capture ACK and
completion behavior while adding bounded payload checks. This avoids a
partially converted PAUSE path between the ACK and RX conversion
patches.

Playback response validation and pause progress are separate patches. An
invalid used length or device error latches XRUN without publishing
successful progress. TX completion caches latency without dereferencing
the ALSA runtime. Resume and failed-pause recovery schedule pending
progress. Limiting the indirect queue to buffer_bytes - period_bytes
prevents an unobserved full-ring completion from looking like no
progress.

Matched pristine-base and v23 QEMU tests reproduced the capture
regression and the playback stalls. The playback missed wakeup and
modulo ambiguity also occur on the pristine base. This comparison does
not establish the first affected version within the earlier revisions of
this series.

The final candidate built with W=1 without warnings. Cumulative stages
12 through 16 were rebuilt after the DRAINING notification correction.
Unchanged stages 2 and 6 through 11 match the earlier build inputs
exactly; stages 0, 1 and 3 through 5 have no fresh build in this
preparation.

A delayed-RX comparison establishes DRAINING before returning the final
completion. The earlier local candidate left the cached pointer
unchanged for a full-period tail or a short tail crossing a period
boundary, and left an invalid response in DRAINING. These six failures
reproduce across RW and MMAP. A non-crossing partial tail succeeds in
both versions. The corrected candidate passes all eight cases, including
marker readback, XRUN delivery and reopen. Cached state is sampled with
SYNC_PTR using APPL and AVAIL_MIN flags, with HWSYNC disabled, so the
observer does not refresh the hardware pointer or invoke ACK. This
checks autonomous publication; blocked-reader wakeup timing is not
measured.

Earlier R5 tests cover partial, late, empty and overflow STOP,
PAUSE/resume, DROP, RESET and reopen, plus playback accepted/rejected
PAUSE, immediate HWSYNC, two-period queues, stop-threshold XRUN/POLLERR,
and malformed TX status/length. The R6 change is limited to capture
DRAINING dispatch; playback and running-capture notification paths are
unchanged. R6 repeats the partial STOP, PAUSE/resume and reopen checks
in RW/MMAP. Final-source RW and MMAP captures each ran for seventy
seconds with RESET/reopen checks. All seven segments, totaling 7,104,000
frames, matched the unchanged independent sample oracle. Eight
additional final-source cases with stop_threshold set to buffer_size
also pass in RW and MMAP. All completed R6 runs used ARM64 QEMU with
KASAN and lockdep without reports.

A delayed-TX test observed completion, close returning -EIO and
continued guest execution. Its buffered log does not establish
completion timing relative to close return, and its backend hook does
not read audio pages. It therefore does not establish post-close payload
DMA safety.

The default RX conversion adds request-owned memory and an IRQ-path
copy. The capture_staging, capture_allow_short and capture_allow_empty
options from v23 are removed. Existing configurations using them need
updating. Packed status and RELEASE/reprepare pause remain opt-in and
disabled by default. The new default path, removed options and cost need
maintainer review. CPU, IRQ lock-hold time and worst-case resource
overhead have not been qualified. The playback queue cap reduces
buffering tolerance, especially with two periods. This revision has no
new physical VZ or KCSAN qualification; the earlier v23 physical/KCSAN
results do not qualify this changed RX path. Uncertain control timeouts
can still require device reset or reprobe.

I would particularly appreciate feedback on using request-owned buffers
for ordinary capture and the playback queue-capacity tradeoff.
Preserving full-ring TX capacity would require a larger exact-progress
interface.

The new STOP and pause fixtures are local and have not been published.

The pause option documentation describes the STOP/START default and the
optional STOP/RELEASE followed by SET_PARAMS/PREPARE/START sequence.

base-commit: a4311e9447bbb219044db38897f95be112f46a8a
