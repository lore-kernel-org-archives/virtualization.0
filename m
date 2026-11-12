Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.45
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794444432;
	b=R48Lrl3vIMpmSJBFE//dG8h3arwwEqaFXlJM4oaKg6ucImJfUcYnC3vMRhTQBPJIsnY0
	 +jfrnNebplSF0U8D3eOq9HBw2DohE1TGLlMqj8wCgxcm7oAKc7ooIdqP0nIcQQeIY5Is2
	 EnsO+tW8m8KUC/dFy7n+N1t5fnCcKHb0klVyCHhKsis6TpBxCGaqNARo10q9p7r3pvbjM
	 GIJbsNESdJMn9VwFH9Dc43cgE4S26/GxJlcRLibofCgk7Pjmw4IyOEtjs4OfMHp3Dd9Ys
	 7IBZL4zkAIHgvwMu6x2bYqVch3KRwSaMW47F0pUSEjzbAAex+p5Bk9ecXGgPXubEQfg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794444432;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=fAFxYRrida1pHK+o2wBbcMW3d1AOWkL58P23yqKUQ1c=;
	b=4FBDG2FGpG2Mp4mp0T3yM0bmaFk0fPpLW3OGt6vEOHKeVub5HsCmsr4OBTErStQKvK7g
	 zoKhewQQ8fw5TO3FrwOrGScnzWpOA4gqAVksIt75j2i3UoRhg45/HDX+PqiAR8RLv7J/R
	 /ixCUxgjOR+eYQ45MaLjfsXnWZYkKeSBRmEM0BGRCfn3IzCQ7Iqu75v4e76AwJLg2Tj5x
	 3KuRLtjw9dKLJX+dmcMwcNv7kwmjyoR0mpOHZApYGGoYBfOTqQi7IDIAdO2xVVPHrIzHC
	 34kJSZ8YPMrkcl1yR1vR3aoXDRuOjn6PGiwZlz5smusZW573TixLvkn6qLaBIvofPsw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=KZAG7nwI;
	arc=none smtp.remote-ip=74.125.82.45
Received: from mail-dl1-f45.google.com (mail-dl1-f45.google.com [74.125.82.45])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6556606A324
	for <virtualization@lists.linux.dev>; Thu, 12 Nov 2026 00:47:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C6556606A324
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=KZAG7nwI
Received: by mail-dl1-f45.google.com with SMTP id a92af1059eb24-15ea896ddc8so5703891c88.0
        for <virtualization@lists.linux.dev>; Wed, 11 Nov 2026 16:47:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794444431; x=1795049231; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=fAFxYRrida1pHK+o2wBbcMW3d1AOWkL58P23yqKUQ1c=;
        b=KZAG7nwIxi6NvqBMhuJsMUXOf+O1Ko97wNpq8FEkgu64DK5H86F3vVVsVVTqrvZMXc
         4n/pnSUjRGWbSxQPoFjZqFkQRglXRxDnJyKlLf27vc2ZrIScLd0RQb2cn2XD+GHZF1F9
         jfUeQsjhIHbjkPafcYsaE5b6semFmFoXy0yeDmV9tPpOiqpGZslD8ko68eTt+xTiijEw
         H3tN64FI53Bg10qUNXmMYAc+8MWRhaJON9zLTdUrzMZGUtbxL8QMeWVdirmp+6hyWZXh
         3ZeMRQgWH3p4o/Do3KgZLP7auIWbok7DMKrKwsFKWevtuFZtQwYCJnWb2ZxcTPKRtSJr
         TJgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794444431; x=1795049231;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=fAFxYRrida1pHK+o2wBbcMW3d1AOWkL58P23yqKUQ1c=;
        b=BVEJq+Vxf8FXd2eDfn7wV3uaEF+4BQFo4srzpIkhEsfnJDcYNz9GeBc6NpNf21UBO8
         jQBg643FPJMXeyJM4FVmKwTFSiOE3DWDgMlH0Iu+SVxbhgw5U+K0+89g5iDRlGBdylaL
         qcCF9s1xyzjbNNBNpdDbjjWtgWgC7FbeiFk9xy2N1FWP8feKWCPnlq+ua1kGqn1Z7kGc
         t/eO5Eu1+ZVlhO7MCBXk++KCiro79787ygF0Are9Ocin6r0FbjgWTOyE+Eg9seiX/XdC
         hTA27Yx0sjkF2ZK58boLPr8rhZ70fuT+ADHwkc8lFKlIL1mhuhs0xKjbXwjQYBcFkXTI
         dtug==
X-Forwarded-Encrypted: i=1; AL+hErHnz9cJHgafD/lNU/U8a+BhpKedR/xVNuk2+h/9FixYFnsAjTx0EYt6gCGhNM81PyQwEZAM88kqoSfZFmKkRA==@lists.linux.dev
X-Gm-Message-State: APuU4Z9LTYU0Fc1s+SE+mRvbi9oF9ZFi1BXdxYkJyXGgPerqIkEM0RXw
	XUs67EYTKJUJL48NsFh3jqxVu64LNuDox32g8wn3sp7fatMgX9Kg8fm5
X-Gm-Gg: AYBFou2Hk8ChfEwSyraU8UzafiamxDucErUvS4HH4E0Xpj/81oEQS0g9Ry/1OgOfsAO
	10F9uD5fxL9d+AIthLsbqfyaJwg9nGk338VhqQUQctjIVhNp69zJTkBVfw2esVKpBk/8a2FRzEi
	RdhOfB474e2ckiyXP3hbKT9Ev5PZAlz//ankCDauAz+leOW7grUSVaDBBe0hPJzYaSuk7AIuzrE
	A+J6tJHrqeOe2vsqs1xTIrrzrT6WwtLIybk0HOrCIfSQQiDPVs8kB+eUu8XGFyZEqUqGu+p9Wn+
	zviyxxlBhvD7yzOQwx+4xBZKYOlB6FcyYgT9AjiMRq3grhrwiZBVjm/uCwmDqRTFDlY1m4SEZh3
	Vw1P7vr1kRGQKjW3db9fMn0g3KyhwKBclFFhMrxdyVUeFx69zyuJ+fkYszG+8JF3KKC4Vx9gIRm
	P2WnenRirJVoZnol8bFFhUchett8gQMgzv44wOn8my+38a1ASrkCg19nIxUjm1N1/2opeONPvoq
	ojzlkIfG3eHV5fXCPvqPl0Cc/ZKXFxKXmFKxPeQgwXJ1u5G5qnHDC/mIj/O0CwsJZJE7FRhVKP2
	p/88vy3dc9wf79n0/wAsD3fiTfcn6rfmMg7g19tJm7Q714c6QDI9FcZGqJBOmEf9wD3p+RqQhSc
	oZhMYkTEMO/tHf5+EgtubgOcBqDKqJV7kXuW8sQKlTBEG26mG
X-Received: by 2002:a05:701b:4583:10b0:1a6:4679:6cf4 with SMTP id a92af1059eb24-1b3c034aac5mr3255515c88.36.1794444430392;
        Wed, 11 Nov 2026 16:47:10 -0800 (PST)
Received: from localhost.localdomain ([183.96.175.225])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1b3b5b2eeffsm20672163c88.9.2026.11.11.16.47.07
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Wed, 11 Nov 2026 16:47:09 -0800 (PST)
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
Subject: [PATCH v27 00/17] ALSA: virtio: preserve PCM progress
Date: Thu, 12 Nov 2026 09:46:47 +0900
Message-ID: <20261112004704.49758-1-mynameisjune111@gmail.com>
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

This replaces v25 in full. Apply all seventeen patches directly to the
pinned base commit below. The previous public version is at:

https://lore.kernel.org/linux-sound/20261111025655.63951-1-mynameisjune111@gmail.com/T/

Changes since v25:

Patch 4 handles linked prepare revoked by a concurrent disconnect or
suspend. It invalidates affected opted-in members to SETUP while
preserving terminal DISCONNECTED and SUSPENDED states.

Patch 9 adds the missing Fixes tag for the original virtio-snd control
and I/O message handling. Patch 14 documents both default-off capture
compatibility parameters and their behavior in the ALSA configuration
guide.

The capture path receives into request-owned buffers, appends valid
short completions contiguously, preserves a valid STOP tail, and reports
overflow through XRUN. PCM lifecycle, request ownership, and recovery
are serialized across prepare, reset, stop, and teardown.

Patch 16 adds an explicit application-pointer form of the ALSA indirect
playback transfer helper while retaining the existing wrapper. Patch 17
preserves playback progress across pause and lets the pointer callback
refill already committed data while buffer-access admission is closed.
The playback queue remains bounded below one physical ring; this reduces
queued buffering by one period. A missing ALSA control page follows the
common playback validation and XRUN error path.

The final candidate was tested on ARM64 QEMU with KASAN and lockdep. RW
and MMAP passed boundary PAUSE/RELEASE, HWSYNC/poll, DROP, and reopen
with two-period and eight-period rings. RW and MMAP also passed accepted
RESET from PREPARED followed by DRAIN and reopen, and accepted RESET
while RUNNING after ALSA reported the full 2,048-frame buffer available.

A separate paired gate fixture compared baseline and candidate in RW and
MMAP. The generic ALSA indirect helper invokes ACK for each pointer
callback, but masks its internal `-EBADFD`; once `hw_ptr == hw_io` with
no completion outstanding, virtio period-work progress suppresses
further callbacks, leaving no ACK to retry the refill. Baseline stopped
after 3,072 completed bytes with 1,024 bytes in `sw_ready`. The
candidate drained `sw_ready` and completed 4,096 bytes without any
further client ACK. A hostile test-only hook changed `appl_ptr` to 2,560
while only 2,048 frames were committed; the candidate refilled only
committed data. ARM64 control-page mmap is unsupported, so this
injection used a test-only kernel hook absent from production source.

A separate strict KCSAN build of the final source passed eight QEMU
workloads covering RW/MMAP playback pause, pointer queries, DROP/reopen,
PREPARED and RUNNING RESET, and capture. Default and enhanced sampling
were used for playback; enhanced sampling was used for RESET and
capture. No KCSAN or lockdep report appeared in the qualified workloads.
An isolated deliberate reader/writer race confirmed that KCSAN reports
worked. RW/MMAP capture, paused RESET and reopen data matched the
backend sequence oracle across 7,104,000 frames.

On macOS VZ, Scarlett 2i2 capture passed two VM boots, 24 captures and
20 reopens with capture_packed_status=1. This included a five-minute RW
capture and 70-second RW/MMAP captures. Repeating the same matrix with
the recorder stopped and Scarlett used only by the test VM also passed.
Each matrix captured 27,360,000 frames over 570 seconds without recovery
or KASAN/lockdep reports. No physical PCM recordings were retained.

Physical tests checked signal and delivery rather than a known sample
sequence. VZ exposed capture only, and the guests used poweroff -f;
orderly SIGTERM shutdown was not qualified. The default-off
compatibility setting was not requalified. KCSAN is sampled, and these
finite workloads do not establish full-series qualification. The tree
through patch 15 was inspected but was not run as a separate control.

base-commit: a4311e9447bbb219044db38897f95be112f46a8a
