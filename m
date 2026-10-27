Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.215.181
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793144622;
	b=jAe9JzY2BVYu6oD0eonbTk82oAamNKYArEdcwWLrabRmYWQGzSNBaZgmqymTFEiErcUV
	 ygiigq7Nj8/Shw2AW9OgJj/P6X0RR5+rf7q+APZakDT/wZGKJAgVPHQyFl17B8HRAbdhx
	 8noQwyVkhy5MVr5DcOyDDmjcW9ZcCBISw/WsirgxsRYEAx5nyTHt8RecWqv86GwhD1f7i
	 Crpeo1gPT3K0XSo9Gc7xJOajZKDkaTxZvXZgExBCNCXTnKU+EsjKCTrkZWAn8A6OTLCxH
	 C9l5VWf4Ho0RZkpeSPriyJ0s0GG7rTSQk+nucIynciFg8UyjWuYfj7Bu4nV02PktZLg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793144622;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=B4qnDx0k2bpcfJWg33p4lPdO3IoU2oz8ozCUQhYAFVc=;
	b=JAIj8FhqS64tdYLthimSZjTaD1p5GWc3axiMxalmXIxmldV5IoDZTkzAPdz+r3EKSkHi
	 JGYbpxwZ4uFIxKfHmVrDi2/FDY7b2WjF44xb/3Nae1yyHepEid/NjsxIUP3vQI5WKqL1V
	 3CSjCRslVhU/6I1+KG5z9Fi91iGyMsVRLjJUoRN1T82hyyRSfq9lnIwrVTohUrGs2JnH/
	 13/dH+HfYp0l19opCJrUqPBziTdGnNoGJDT0V2CY6bSD7QOvVIUih08nqZ83T1xkYsXDm
	 CfX/wm94xC2dEJC273IBMV8ybe8zyDq2d3c2o5DSUO8jKEEu80ES03y4OMWwbbAcFyg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=grLjHo8y;
	arc=none smtp.remote-ip=209.85.215.181
Received: from mail-pg1-f181.google.com (mail-pg1-f181.google.com [209.85.215.181])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CD97606A31D
	for <virtualization@lists.linux.dev>; Tue, 27 Oct 2026 23:43:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 7CD97606A31D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=grLjHo8y
Received: by mail-pg1-f181.google.com with SMTP id 41be03b00d2f7-cd62c570b5dso278259a12.2
        for <virtualization@lists.linux.dev>; Tue, 27 Oct 2026 16:43:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793144622; x=1793749422; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=B4qnDx0k2bpcfJWg33p4lPdO3IoU2oz8ozCUQhYAFVc=;
        b=grLjHo8yE6p+cOnThJzbh7LieF548xgW5JThklPi273TShsWSruZ7RDz0Q9vQlZ95M
         F519eiEd4/DaCmaYr4kfu0Erme/bjLPeCbUJOWW+y80VSWBsL0Hq6fZVeXRIVG9+OgSa
         3uE4YZUnr+Y7hhIX4Bc+F9mHDC/6eepk4Y+sFljMz+P2IDLIL9Tre1J4ewy8hTPEn/Ip
         TMaZL/uHcfj7wi6jWvkkCp/FgmB2mR0dTkkGSg9bMLP/yxELLcdMNUbqx0Pqg6yzAHJl
         eVLbzf+hbiT6yHdJjVnaKfJaZl92FtGfz5SBLECFwE/5GA2iggACG26C0hwJY+AWDxJS
         5Nwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793144622; x=1793749422;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=B4qnDx0k2bpcfJWg33p4lPdO3IoU2oz8ozCUQhYAFVc=;
        b=D37DdsA0WgyclzJP/yAdLYKVEqdJCEPUh78o7AZq2p+Nhozb4pVf+8nVBsTw2lMjHS
         v490c7N/JOcWAoQfX0A4mWr6DfJd1Fc+kCAXPVRjGqc8kasv4FhxupLD7P7oJ/Gsqa8p
         5XfYkZRJEKPT/w9YRak+qsX81si85QM0LceiZ1dBRI9UHKOmjQ0OfaMUmT1YZuu67kpL
         oJ6EN2Z/h/o9DF0ixpZuG9hyVRj6uC1wMkSgBq4I2fyIKtXuqYss7zqi0+QLRKdi8+GZ
         qAs1rKTP4SUzOLVmvIlA2o83lu+P+ii+s8r62MBD7BOUrHvYbRi2UlEqgHlC7XxF7Rch
         xY0g==
X-Forwarded-Encrypted: i=1; AKwUvBxGEABiCyesCbNqN/9SaPT0QCeUecBDlDDYeriU+IeDyhIqWb1nBttR31V2vyAQBTAJvn36KIk0lxF3cyA3UQ==@lists.linux.dev
X-Gm-Message-State: AFq9FYLSgjcM/DuIuL2xzzCKDZL1fB4RBl69CcveIHeC32V7jFZ2F2rR
	L2TiVzlS/3hm04g/FouARzoOWnlSbATMVFv3/PDj4Ne+EyJ5CG1lTioW
X-Gm-Gg: AYBFou3gD/SAWxoUqYNYCRGaIa4aIGeVJBeVeu0BR8KEa3Mad2tzfb55wZgogOymNse
	3WwN/qUu56gENo4+eNd1/E2NWINLNuKVeEYC8zuKlEfvOVWLIMNrv0ZdD3p/UQQuNWgiDPxktAQ
	b6HBXoHqhwZAUU7ApoqbfGJY0PN33WT2gYnWxFZA7Bg/UZmUsr36Un9OOUtsyjBhvyLw55OaP6L
	EjNUBqYyjxHHFe/l/mkFwC8sTYhQ5Xf+n9/jk4iva6rLFU9WTeCVakmYGExaMPHEyEt4DCvS+Cr
	9VegKPBunp6olVulyjBeSaJCPBTEWcBwV35ClqCRY19inJ//VoYqnPS9C5ysAD0eqeZIRpETg3z
	hE9llQP5wjZ/4WULFSeLya1dUbzOCuMpbnBANy4OEqmmeiXac8lc9rpxUw5+OZNIPvGMyb5HHUk
	4tz3P+tz4+IjFHPnSFXtL78ge9WUVt02Ae+t6ktJmZ9CkU5+PRzQAod/4delsjngfvDpoMTJt2l
	bpfRSilowLiUFgPTSGTOUH1+vqq75nz8/FE8w4eWaGnhwepQfQ/gcU+6FVSs+S5KnXN0wPSWdNG
	iMxAhVns1uW63EmcCyIv8Be0xy/Q8K8zGgc3tXyUhJy8be1twJQu7ZSFPOCfcCr7VHDgLuZtuEp
	V7ug6LF/KxUkifudy2uHde8ewSHDbzoAd0AXGgS99ICzBFis=
X-Received: by 2002:a05:6300:8003:b0:3e0:b937:883d with SMTP id adf61e73a8af0-3e90234d178mr489806637.25.1793144621759;
        Tue, 27 Oct 2026 16:43:41 -0700 (PDT)
Received: from localhost.localdomain ([183.96.175.225])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-8a6a662b9f5sm542507b3a.21.2026.10.27.16.43.37
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Tue, 27 Oct 2026 16:43:40 -0700 (PDT)
From: Joonho Lee <mynameisjune111@gmail.com>
To: linux-sound@vger.kernel.org
Cc: tiwai@suse.de,
	perex@perex.cz,
	anton.yakovlev@opensynergy.com,
	mst@redhat.com,
	virtualization@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [PATCH v5 00/11] ALSA: virtio: staged capture and dsnoop recovery
Date: Wed, 28 Oct 2026 08:43:23 +0900
Message-ID: <20261027234334.32551-1-mynameisjune111@gmail.com>
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

Thanks for checking v4. I reproduced the application problem against
sound.git for-next. The two dsnoop patches depended on nine patches from
my earlier submissions that are still absent from that tree.

This version includes those dependencies in application order and applies
directly to for-next at bcb4494239f57c98a8ef576566b03f2935b3000f.
It needs no separately fetched prerequisite patches. Targeting 7.5 or later
works for me; I have no deployment deadline for this work.

There are no code changes from the previously submitted patches. Stable
patch IDs match all nine prerequisites and both patches from v4. Patches
1-5 cover request lifetime and error recovery, 6 covers teardown waits,
7 adds opt-in staged capture and pause restart, 8-9 cover ACK accounting
and period work, and 10-11 add the stop-policy annotations and dsnoop fix.

The staging and pause-restart changes were previously posted as RFCs.
Including them here makes the dependency chain directly applicable; I
would still welcome review of their device-compatibility assumptions.
Capture staging and the VZ compatibility options remain opt-in. This
series does not add host audio support to Docker Desktop or enable any
host microphone permission.

The dsnoop fix recognizes stop_threshold == boundary as free-running
capture while preserving bounded-reader overflow checks. Returning to
bounded mode with a full unread ring reports an XRUN. Paused ACK and
period-work errors arm synchronous cleanup so the first prepare can
release queued RX requests and recover. This fixes behavior introduced by
the staged-capture patches in this series.

Previous v4:
https://lore.kernel.org/all/20261025064038.81674-1-mynameisjune111@gmail.com/
Your rebase request:
https://lore.kernel.org/all/87cxsv33oq.wl-tiwai@suse.de/

Earlier submissions, now included rather than external prerequisites:
https://lore.kernel.org/all/cover.1791881787.git.mynameisjune111@gmail.com/
https://lore.kernel.org/all/rfc-v2-generic-control-wait-0.2eddd58a796e497f@gmail.com/
https://lore.kernel.org/all/rfc-v2-vz-capture-compat-0.b9ab4c1540dc4691@gmail.com/
https://lore.kernel.org/all/rfc-virtio-snd-capture-followups-0.f2737c95c12e45b4@gmail.com/

I built a fresh ARM64 kernel and modules from this base with KASAN and
lockdep enabled. All eleven patches passed sequential git apply and
git am checks, and checkpatch reported no errors or warnings.

On that kernel, all 16 paused-ACK recovery combinations passed across
native pause and pause restart with one and two vCPUs. The first prepare
recovered without a preceding drop. The native pause-release regression
and all 13 mode/lifecycle cases also passed, including shared dsnoop
readers, client drop, mode transitions and reopen. All six QEMU runs
confirmed the expected module hashes and produced no KASAN or lockdep
diagnostics.

Earlier v4 validation covered 16 paused-ACK recovery combinations and the
13-case mode suite under ARM64 QEMU with KASAN and lockdep. Earlier MOTU/VZ
and KCSAN results used the previous base; they are not new results for
this revision. Physical microphone testing, 32-bit builds and forced
RX/pause interleaving have not been rerun on this base.

Thanks,
Joonho

---
base-commit: bcb4494239f57c98a8ef576566b03f2935b3000f
