Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B7284915A9
	for <virtualization@lists.linux.dev>; Sat, 17 Oct 2026 12:51:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792241484; cv=none; b=t1YQoIOSNP1Lg2ExNwszvKld+XsPdXahwuH3pZBNLGj4pO2QDhW4R5ZF3UxPfcLIU9c+D2F+F1pzAk0wGX0cIJHXRuIYIgpUY9mlP/cDrddCTme10UiAQx3fRmyaXauSZsdtXO6uPV9xZpfvBP4AZNOvTeR6JMAB0AHetgmOBQI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792241484; c=relaxed/simple;
	bh=ejhKqmQASVCjBpB6Zzm6onKZzFwjxIZTAb/mq8y168c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=TExkBwfTv5Eialh1WKryZ16Aygs/y3MOS9qgruSjPAzzEH3WDqt+mTdq+/d6lTrJTp1X9jLs66xOe9UILy4R3OTNIF4CvlfU9WkvVBVHOUdCvLRsSQHNgoBiaDKcaB6xlDyx43MTlf8LIto6L+uYXEwBaH6DcCqLJqxDEkXBOdc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kRTQg/lO; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kRTQg/lO"
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-2e940d5d2beso2473095ad.0
        for <virtualization@lists.linux.dev>; Sat, 17 Oct 2026 05:51:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792241482; x=1792846282; darn=lists.linux.dev;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=ejhKqmQASVCjBpB6Zzm6onKZzFwjxIZTAb/mq8y168c=;
        b=kRTQg/lOkNzexwH8ozv4E3bsJrUsEHDeKwSdBoHcbDq7tDGPYYOxeelCLvLMvBQpJz
         4Sh24F27E7fEL90kHlCpZsKCsYfYYLXHScH/rWaNzxjkL9tlKsG9JRKnVit3vHOaA57r
         mWCK+/Fxq02hkVT6DfGM48BTHsEtTVnk0Egu00a1GCAxJX9DFrEs/5Idyuu+LXlzSZwz
         Q7cZE/4Av5uZZHJPhZMpqiv1KobHiNRSbAPBHbrrvhPjbzRlsOPnnZue33V3csq91OF6
         orhUyyyqyvUnZboPuZAHDTE233X4sh/p9jMOJTiw/GDMyPYX79emPKXvJtyfwTBpAoqb
         0WpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792241482; x=1792846282;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ejhKqmQASVCjBpB6Zzm6onKZzFwjxIZTAb/mq8y168c=;
        b=ngmXYn7zTkT+x5qkPAXDkfIiVmH3Mqp4ZNKyry3ecBXVvxr7BdCDwyKoMpdkcp/9Ky
         IjXz+oj0IdtdWLdHaNoet4SPFVGU52+B//sz0RwQBUEymVSww2mP70ZupRUgkqdQLmi6
         emgpDSZrISVK/Be/G8yYIUL+peabTNAL0x1GwpKQjZVaek7HDF3cdRJwwvMnfP7zkdnS
         NtUv8A5upGyNTd8pA2B7N+8xNai8UU1/Yuq+LNrf3B/vMYLPQ/jpkSY2edhkPiNBnLdn
         gvmFMVcJDnmTF/NJBMgt5SC8qVgjaknVoRQ6d/COoaAZfYLnoNWUm1h+h4U9Bf4JnYHX
         Okng==
X-Forwarded-Encrypted: i=1; AKwUvBzpJQSRTd8338PURJG875VYHdeeJF+cBXl/m+c9KX20TaPYWZ+jHZMBzdb1vHA4HfeTs02Yh54qPFTQD8EDZA==@lists.linux.dev
X-Gm-Message-State: AFq9FYKYGCxhFXs+AjMwfBMTPFxmNV89jED/gSYmuDIHTIWv7Iog8oU7
	AdqcCKBCtwuAPJXD9Cxbz+3uE2B4MRXYkmqwoeSUrZVjZe/d2g62gQ5Q
X-Gm-Gg: AYBFou2zXdbi3LGVkeTYzeDC4FryLAIVht6U6zDl++7Yjc440AE/8Exr6G5KUhOWeRK
	AExrTp1oiv+P4wQrt9O/rktUCJ5x7q47t6zHGzzLNPsnUdcEko4qSYX4YI0liTdgrFXwq3NJn+v
	DBVs1I3cjXlILstOXzowlaHbZGTRtwHTtnB1ej5jOQQsqtLvLAyNOPKRzbEf14uetFAJ4JUTqjK
	HQkuuEjrWOvqVjSb+GBrMtK10GP0M4TJR5oQhmjMHmQ78w8n3b6FxvpfssniKDN9lHeIYadLAJI
	qpers0lM0MSajGTzgqogMwfyGtr/P//DmfANYY+PV+7iclt+JcHBGppJWbCTvP0Ze6L4BoQDcWZ
	Qs8oZWNPA9cJdHl3B2Jlsysmid8ABPo2bBZNNDubaefeYP7UckSYYfcG8wSUBCcBb7HWeD/DoA8
	wXumnjX5rjxmQ2H71AU+OoPjZSYjQUvn6Oal/9m2K+wk7vR1JJchCThLfZgG1S0FoyNfFuF8Djo
	9d1z3I8UptZVVYIMl3iPnW0B/vJzJpP+F3Mp3QdhRJMAyhc9Wir/MnRuVTSbL8RByTdfc/KI8iz
	lrH1tcnZgeBfXw0=
X-Received: by 2002:a17:903:acd:b0:2e9:6788:9373 with SMTP id d9443c01a7336-2e9a68d9118mr21964585ad.17.1792241482151;
        Sat, 17 Oct 2026 05:51:22 -0700 (PDT)
Received: from localhost.localdomain ([180.182.24.11])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2e97e8b98a9sm22014615ad.74.2026.10.17.05.51.18
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Sat, 17 Oct 2026 05:51:20 -0700 (PDT)
From: Joonho Lee <mynameisjune111@gmail.com>
To: Anton Yakovlev <anton.yakovlev@opensynergy.com>,
	"Michael S. Tsirkin" <mst@redhat.com>,
	Takashi Iwai <tiwai@suse.com>
Cc: Jaroslav Kysela <perex@perex.cz>,
	linux-sound@vger.kernel.org,
	virtualization@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH 0/2] ALSA: virtio: fix staged capture ACK ordering and period scheduling
Date: Sat, 17 Oct 2026 21:51:14 +0900
Message-ID: <virtio-snd-capture-reproducer.e56fe77fd0dc4571@gmail.com>
In-Reply-To: <rfc-virtio-snd-capture-followups-0.f2737c95c12e45b4@gmail.com>
References: <rfc-virtio-snd-capture-followups-0.f2737c95c12e45b4@gmail.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi,

I've prepared the reproducer and build instructions for this series:

https://github.com/whatisyourname0/virtio-snd-reproducer/tree/88913cb432c3771d179a274e3b622a22b03bb9f1/capture-followups

DEPENDENCIES.md lists the exact base and prerequisite patches. The
preparation script reconstructs the pre-ACK, ACK-only and ACK plus
scheduling trees from those patches. Each tree matches the source used
for the original tests. The two kernel patches in this series are
unchanged.

For patch 1, ack/ extracts the baseline and candidate routines and tests
ACK ordering and refill failure with two kernel threads. I rebuilt the
ACK-only kernel and fixture module with KASAN and lockdep. All four
cases passed, followed by module unload and a clean guest shutdown. The
fixture supplies test queue hooks; full virtqueue coverage is a separate
part of the test setup.

I also rebuilt QEMU and the kernel with both patches for the capture
regression checks. All 24 captures across four/eight channels and
one/two vCPUs matched the expected file length and SHA-256. A deliberate
reader stall produced XRUN, and a fresh capture after it matched the
oracle. An eight-channel, one-vCPU run completed 70 seconds under guest
CPU load and a subsequent ten-second capture without XRUN or a data
mismatch. The kernel logs were clean.

These QEMU tests use a deterministic synthetic source. They cover
capture correctness and recovery; the VZ comparison in the original
cover letter remains the evidence for patch 2's scheduling benefit. The
ACK fixture uses the ACK-only tree because patch 2 changes a shared
helper. Both build paths are documented separately.

FRESH-BUILD-VALIDATION.md records the source and artifact hashes,
results and remaining test limits. The package also includes the QEMU
fixture patch, the guest build recipe and the channel/frame oracle.

I'd appreciate guidance on which parts would be most useful to keep in
the kernel test suite and which should stay with the QEMU test backend.

Thanks,
Joonho
