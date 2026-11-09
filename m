Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.54
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794201385;
	b=Yyjih16CljkqcP7cRc7tTquC1XJQlS0q8OwrN0Isv/qYnYrh14dq1q7/o74O4gM0DnZH
	 mNmHPJodpqqqyUWKbnXgOd9G5gBzG3xm9tatO8sSRSt+N0HngLBljnuj3dl1sV9oBjC2n
	 sDkw0o5EsMEdrQFgEGLsN/B1g6Vmg06jrn2Ciwh+CTtNzL6FHgRtJJ2WH0kfmUcBBB736
	 U06Y4sNldnLr8kjQp3v467lxZ54t/bd+e1DUHEsC6TXi2QDeHWb1vSqH0Yxb+3mkbeVD4
	 wvqypKFSIkARJ7VI1rdtIV9m6FjqF4L/BRPPbLN0+qL7NXaHtv6rETWRsTIz5AaGD2Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794201385;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=dJKjNdPYk3m+cvdLchMSCMmDNiLwFmiH/BaL2cS3TCk=;
	b=Osm56Rho5/LeDhZPkUCEsLN0mqc2jiwJkm8MlBUxGpAyeIkuDMvNPyK2KpcjBhBVyjKx
	 hKdo2dEPJyIqsd7Dy/Cmb2gx74tajCOt6qXMFSqilspbiLkLil7cRNEXT42hZDdfSdW0t
	 szir3lz2mTb7UdJImc4ajpruON/nkSfn+J5z94QLxHrwnMG1r1D/FN6wD+U0qifernJl5
	 EeKu1lt/awWgKzF9NhmDRF8T05wgsb23vnfZZrpvo6FIfD/MmwAWrge+2O1ceEjjrBCIi
	 JR9P0V5hZjdN4Jh8kGsod4vcrlUAfMPIuQSL9Anr2KiBwfgUF1P7LcrqvXmcV4MVw9w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=WNdkeIO5;
	arc=none smtp.remote-ip=74.125.82.54
Received: from mail-dl1-f54.google.com (mail-dl1-f54.google.com [74.125.82.54])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8134606A32A
	for <virtualization@lists.linux.dev>; Mon,  9 Nov 2026 05:16:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C8134606A32A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=WNdkeIO5
Received: by mail-dl1-f54.google.com with SMTP id a92af1059eb24-1ae58d17cd9so161610c88.1
        for <virtualization@lists.linux.dev>; Sun, 08 Nov 2026 21:16:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794201384; x=1794806184; darn=lists.linux.dev;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=dJKjNdPYk3m+cvdLchMSCMmDNiLwFmiH/BaL2cS3TCk=;
        b=WNdkeIO5WYy3BY3Y3AvspLvoLtawhkKWHjAJCXnodtCuYTJx3s4MjMGlGbMn9D3Fi/
         KsothWzgmfCspJBlnrvFhIsx/shJeacxQRDI7JR1HITTKxcClyD33y/x2+B9+9vfk8fi
         kl4Tr6fTaMg/ZKq5/dcHR8fMWpky3Z6KjEkj2TtKNN9Ai0RwY+VQvzRH59RfP/rHLI7D
         ULrA58A3IMx6GmM8EhNl8MzmQynSQrkjAbXR9TXlYOL2pQNLA42v5TSRAHv5DnIZnl9E
         E0mLP0ff85Jz7Ibri2l8/NUSxASbYDgF9uECSq6V63jRYKGrdLjAqEkI1HZG6dGSe8GL
         al/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794201384; x=1794806184;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=dJKjNdPYk3m+cvdLchMSCMmDNiLwFmiH/BaL2cS3TCk=;
        b=Ws/eU/BuwYnSaClTodrAUGKQW68GKkG/pTPOmyl1Gk1M8JyAvwvMzMd+PLAu08zAI4
         aAy39bfej5vyPRgw9rtKF01YDh+K17T9RNYMquhBwkk0nejU0+pm/yzYSGMl+B8GVdQh
         qIX4kVItJxnDItW6eOWuX2q3ybEAmTe39Oiqg/Vz9fAS6x3CujKNxrlQNYNmL355wcfo
         2zAYvEGwD6rupZ1+BKtatwfT9x4B3TQIbt22FGtLFW48FxzxRCij6ATNtoEBq8/qjssZ
         sfzyFfHEHbnhwoVROKi/8nt/sKnSvSkLWlJ51DZHhfqmhDGMcTN3Wyfy/TOQr5w2W32f
         WrKw==
X-Forwarded-Encrypted: i=1; AL+hErHR727JehrFrIbbQQzAfOPVQz78s5dDg50tULX+gl8fJksJXg6dcPjL0DndOLshi6o7rP+JkqUtjTMH8IE6wg==@lists.linux.dev
X-Gm-Message-State: APuU4Z+xWucllE7YcLiLDiSS4rhD7qAg9w2HjfdbbEJ8vT9LBGkWORtV
	Zr8JI5QoAa8QUxISLiIIBtYX7JI8McA923Y6zA5AY5TuyLf4J3SlsJCr
X-Gm-Gg: AYBFou3TBeSsercQ710tIzM6WHG8/nQ4L4LT2RAL5LEhgspkglS4293MaqH3vM2UMo2
	W4GmycDTmpsprrL2AByEb6HUOL8rcs7MzGbmtu/oSy+xQD+Y52sE6Ugs/CV1KOyCl8SCAWwAzc/
	92RkzPvDViASJKFINLoNc+EeYOeiS2Pk2KShFWFjU9zT9/sQPBhO6cxTeIF9KPYhwbgZeCAa5F9
	/R2W25W1B6E+ogOS2zOqGvgSCME45TEpUF8akreOkOR8nJ1mvjcQh37/EC8XuaRkScAamQhM33J
	TltVsMn01fWzaTljouASpzbwTURvGn7xxWxim/xojfvquotW2kSC/hWbno/tV9WEoe5dq+THbTa
	YssvI/YIPelrULz3e6bQG2OymJU3CDWkFhbzT/Fmk+8Diy7iLUlxNnM27nrDhpOecRMrEHA9kgL
	1s29T9TRhkd3nummKhDc9Us8tncA+xB00mqVyR/DyPfDALaC5suhq0GeefTO0X0/1V2tFtzpjMz
	ikhiuUTWmvfnzhB5e9p/Wk1MrCumujkPHvsm5fYXrrlDEGlQcg8XCj8yoyrkGrdsznLmexJ+ip2
	DLBNCZJvtvO43VQ55uIisdndXi0dDQFykteTEiPDW6bs+jIQfND84WA40tTXZxc0lSEs/MtOkc4
	llHnWZr/Ut+n/NUv4+fZ30Zelz9Htp+aG1AapLyCPW7ic88M=
X-Received: by 2002:a05:701b:420f:10b0:1ab:6b10:461 with SMTP id a92af1059eb24-1b39ff1d2famr4693747c88.45.1794201383745;
        Sun, 08 Nov 2026 21:16:23 -0800 (PST)
Received: from localhost.localdomain ([183.96.175.225])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1b37314826asm11395635c88.3.2026.11.08.21.16.20
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Sun, 08 Nov 2026 21:16:23 -0800 (PST)
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
Subject: [PATCH v22 00/13] ALSA: virtio: validate PCM ACK and prepare completion
Date: Mon,  9 Nov 2026 14:16:05 +0900
Message-ID: <20261109051618.22506-1-mynameisjune111@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20261108235457.12688-1-mynameisjune111@gmail.com>
References: <20261108235457.12688-1-mynameisjune111@gmail.com>
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Post: <mailto:virtualization@lists.linux.dev>
List-Help: <mailto:virtualization+help@lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
List-Owner: <mailto:virtualization+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

This cumulative v22 update adds an optional linked-prepare completion
hook and validates playback ACK accounting before indirect transfer.

The core hook runs after all linked prepare actions and post-actions
succeed. If an action fails, callbacks cover only the attempted prefix;
the core moves opted-in members in that prefix to SETUP before calling
back. Pre-action failures and standalone RESET do not invoke the hook.
Drivers that leave it unset retain existing prepare-failure behavior.

Virtio uses the hook to keep ACK admission closed through the core
pointer reset. Patch 5 also returns -EBADFD for an ACK on an already
XRUN member, avoiding a second linked-group XRUN request.

Playback ACK validates normalized boundary deltas, frame-to-byte
geometry, ring indices, signed ready counters, and total queued bytes
before the indirect transfer helper mutates its cursor. An invalid
paused ACK returns -EBADFD without starting a linked XRUN.

Validation: The exact-source ARM64 W=1/KASAN/LOCKDEP build passed;
final-r4 snd-pcm and virtio_snd modules match the previous build, and
Image executable sections and System.map match. The W=1 stage 04–13
build chain passed without warnings or errors. The v22-only checkpatch
delta reported zero errors, warnings, or checks. The bounded playback
ACK helper passed 23 candidate-only cases. The prepare-completion QEMU
probe passed six lifecycle cases, including a later member's OPEN
pre-action abort. Normal playback passed in QEMU with RW and MMAP,
including prepare, fill, START, supported pause/resume, drain, drop, and
reopen. Four ordinary/staged capture paths (RW/MMAP) passed with 14
oracle captures, including post-reset capture checks.

The prepare-ordering diagnosis comes from static source inspection; no
baseline runtime test was run. KCSAN and physical-device testing remain
pending.
