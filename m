Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.216.100
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793690151;
	b=vGvmGBVpdqA+8BOpRP4hu0zXDaOxssK0qeo1BEV73oFFFUNGEuQQxyWQ/oq5IXHNanh8
	 mPe82tzUqvsG1rHwLQYADC/YN9kpHIJxQJvsV+zrC1IFwXIT08FyVI6ct+Tk0h5G9Hp/X
	 UY5qG2EeV/xIr1M1ae+BEp40ArjP+xJR6N4hwFvO8wAG/VG0xAkg8giwpGB/zh104ZQ4w
	 haiIF5o/Q3AqJWY6WxShdCo2eSlDWCUhE7ZWKUmyBRp7RfKeldYST0EpNU6H21e16M70x
	 gJuAw8mF5gV6XDUKhpuUb/9YA7zOMWvYSZkIFzN0r4/K35XpxZp4+reGm3cmPWHIVzw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793690151;
	h=DMARC-Filter:Received:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:X-Relaying-Domain:
	 X-CFilter-Loop:Received:DKIM-Signature:X-Forwarded-Encrypted:
	 X-Received:X-Received:Received:From:To:Cc:Subject:Date:Message-ID:
	 X-Mailer:MIME-Version:Content-Transfer-Encoding:
	 X-DetectorID-Processed;
	bh=j/Bcqh1Ir2ox5ZHSRD7plS8yIHsdPIl+LjTttxcCQ1U=;
	b=3EBiBDcWoEJpFtUIvba/KqnYy71rL37sd1INPCXQwdBcUnMJVPr/+hxm6sWOxKAHDxio
	 mcHBCEDduFSbQCdjCBLd6f9MhNHaYvJenHDUUPn6envxYuLIx9WMng59GN1bOunreSE6q
	 J44bN5qT49XzF5+L4WImnhvz54fL7r46kfQzB1rafXFDuNaXlUbrOUQwVm7/GP3T0ehJL
	 d5JOUHdlxDpKm5H7S2tWTJzxVRGUQ4tH8OOWXDZQcsW0ieWHa/I7mvw+vns1CZ848PA3p
	 dMvUIfcsVs4X54FomdIQFZduBb6lJqr/r3OEX+PxYo+egsyTn+uHkxGLQUY3yn2YqhQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=broadcom.com;
	spf=fail smtp.mailfrom=broadcom.com;
	dkim=pass header.d=broadcom.com header.i=@broadcom.com header.a=rsa-sha256 header.s=google header.b=JFJhmgzw;
	arc=none smtp.remote-ip=209.85.216.100
Received: from mail-pj1-f100.google.com (mail-pj1-f100.google.com [209.85.216.100])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE88D606A324
	for <virtualization@lists.linux.dev>; Tue,  3 Nov 2026 07:15:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org EE88D606A324
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=broadcom.com header.i=@broadcom.com header.a=rsa-sha256 header.s=google header.b=JFJhmgzw
Received: by mail-pj1-f100.google.com with SMTP id 98e67ed59e1d1-3ab2cb8d577so2766388a91.1
        for <virtualization@lists.linux.dev>; Mon, 02 Nov 2026 23:15:50 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793690150; x=1794294950;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:dkim-signature:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=j/Bcqh1Ir2ox5ZHSRD7plS8yIHsdPIl+LjTttxcCQ1U=;
        b=vexBSiqInq0YBkoPk+VDI4/v6fHy4LnbkBDLDM6ffpSSxcb1ff7rT5QW6/2P9ypXHS
         8npeqfEuyC3Cmp8Ynt6dxxuIWAnJfkEHSOkenNNx4rpq78fVDuc/1U89M2m2vyiAHn17
         teZrY90vOyGWrdIOsXbl67mihD46fD1seihoz/72WSxsbbcyCxkiaD6MfMzlJsW2/R38
         dc8QX3J1w/aDU2Xi3Pddd7tBplhw7ock0mkx5aVgRQ4EzluoZaK35Zh6Lk0pO85cE143
         xQf2+5uXSNjqq8L9gtUsHbYv3APTQnL06PzE/lOG0vjEh8fvzQ2dEq882CA+MyU/npdf
         7cIQ==
X-Forwarded-Encrypted: i=1; AKwUvBznANKm6HPiFJiRXV/tiNgQui3Ng7pMt88ioc6L7PRBIvvsV8lWV76nvjmen2f+M8vZIjlHwKqAElKS8msPdA==@lists.linux.dev
X-Gm-Message-State: APuU4Z+HAicJ+01qye4otIKdy2QHC99lY0zxSScAZkNi/80PropGafAa
	w9c5JdsYTdd/VgKL5xqwIoqJ7GB4Es9svgbNgOOwzTey6T5w6+FXP6+hncuI111z0UJa/GLZ/Oz
	JddyYmRFhbeKb7g4UhbwBTIoVUeR0pcrmW42tnihp0qckkIt6lCJBzbmjAOecnuvMdUY3mzFOJN
	MUdKtYq5z8bL7bk4WZm6rHRv1UtRTHKP8hl9YWzTf0UUzGgZEqL/iT3OIzMxBmQSij7eNPtN23y
	x4GmMkaVuwKDULA5kw=
X-Gm-Gg: AYBFou0QnEongbDf7kl6UwrgRE6ixQ/KZtZGryyG5R1kedky2seJFr+F0hDptIdKu7e
	9jtsjgqgD31aGy53vJWjV9ScafGZJbBF9FCndLw5fI4ZcBHJCQqdcr+Hvq6gTVYnh6lqAH3eTZ2
	tyXBCWi6ibS6D6Qb5/OQi1YceQwDvtujLcVrNqplvLXijH1nh3mMeJpaouWZrZg1Cpu2OeqlHZG
	gfNJZK/7/NqqGicxgIrZowlT8Qr1e0myyKpYL/7QtwMKTmroi7wprMcWK7dNeeikasDGaP8zNsh
	/f/7MSlMCpYt4Kh56L68TxUHvIGMtWIyfXk8FdhuDvj82bzbOVJLsPIMOVvQjoV+wWOOIA57gGR
	Apaw0Ho3K1eq64xKILOabYNPGcIF4MDzUS96hxaErJ/BnpkNhjE8NJlgDYsv5uBRhLN3Y1Mrb5D
	Msc8rXvpy9CM+sJe8kaSgVxIOUZkB3YmGh
X-Received: by 2002:a17:90b:3142:b0:3ab:4f1:4f7e with SMTP id 98e67ed59e1d1-3ae897f3919mr10424847a91.28.1793690150119;
        Mon, 02 Nov 2026 23:15:50 -0800 (PST)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-13.dlp.protect.broadcom.com. [144.49.247.13])
        by smtp-relay.gmail.com with ESMTPS id 98e67ed59e1d1-3b07c9263d2sm1307059a91.7.2026.11.02.23.15.44
        for <virtualization@lists.linux.dev>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 02 Nov 2026 23:15:50 -0800 (PST)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-qk1-f199.google.com with SMTP id af79cd13be357-943e8ff02d0so341328385a.2
        for <virtualization@lists.linux.dev>; Mon, 02 Nov 2026 23:15:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1793690144; x=1794294944; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=j/Bcqh1Ir2ox5ZHSRD7plS8yIHsdPIl+LjTttxcCQ1U=;
        b=JFJhmgzw88BS0em4SvJjG60IPbCSu4vd9cKLf1LsE44d32YRIDml6E1N135r1jEGrI
         i8jfkqdp8Mhg+QDPTmH45Bs0EEQ7dj5d90vNJn8s4E8+O8i17bMWOrGSg4GbvyGCyNy8
         MRhzY3FKIyfDjl0yc14Aa4ZX2Jh00i80jQFfg=
X-Forwarded-Encrypted: i=1; AKwUvByX1IpSq3f/1QFy9FkkeQKgkPDFSonNmv2lRtofyWkfB3FxwX37vMghCyj87D19hqY0/VGEMs0ZcYfgrvhcnA==@lists.linux.dev
X-Received: by 2002:a05:620a:4044:b0:93f:3163:3e37 with SMTP id af79cd13be357-944216b1af2mr2136143685a.28.1793690144072;
        Mon, 02 Nov 2026 23:15:44 -0800 (PST)
X-Received: by 2002:a05:620a:4044:b0:93f:3163:3e37 with SMTP id af79cd13be357-944216b1af2mr2136140385a.28.1793690143503;
        Mon, 02 Nov 2026 23:15:43 -0800 (PST)
Received: from vertex.localdomain (pool-173-49-113-140.phlapa.fios.verizon.net. [173.49.113.140])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-9442581b2d2sm1018334585a.15.2026.11.02.23.15.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Nov 2026 23:15:41 -0800 (PST)
From: Zack Rusin <zack.rusin@broadcom.com>
To: Borislav Petkov <bp@alien8.de>,
	Ajay Kaher <ajay.kaher@broadcom.com>,
	Alexey Makhalov <alexey.makhalov@broadcom.com>,
	x86@kernel.org
Cc: Thomas Gleixner <tglx@kernel.org>,
	Ingo Molnar <mingo@redhat.com>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	"H. Peter Anvin" <hpa@zytor.com>,
	virtualization@lists.linux.dev,
	bcm-kernel-feedback-list@broadcom.com,
	linux-kernel@vger.kernel.org,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Josh Poimboeuf <jpoimboe@kernel.org>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	David Airlie <airlied@gmail.com>,
	Simona Vetter <simona@ffwll.ch>,
	Kiryl Shutsemau <kas@kernel.org>,
	Rick Edgecombe <rick.p.edgecombe@intel.com>,
	linux-coco@lists.linux.dev,
	kvm@vger.kernel.org,
	dri-devel@lists.freedesktop.org,
	Zack Rusin <zack.rusin@broadcom.com>
Subject: [PATCH v3 0/3] x86/vmware: Clean up the hypercall code
Date: Tue,  3 Nov 2026 02:14:55 -0500
Message-ID: <cover.1793685318.git.zack.rusin@broadcom.com>
X-Mailer: git-send-email 2.53.0
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
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e

Move VMware hypercall assembly out of vmware.h and select the
low-bandwidth backend with a static call, following Linus's request:
https://lore.kernel.org/all/CAHk-=wivx7pi+h+hGmvNFAJm6StQLiQ-b8DdsE5J=LMOWae8Ng@mail.gmail.com/

Patch 1 moves the high-bandwidth helpers out of line and removes the
redundant vmwgfx caller annotations. Patch 2 uses input and result
structures for the four low-bandwidth backends, selects the backend
during VMware platform setup, and removes the early dispatcher. Patch 3
retires the unused VMware feature bits.

The caller API is unchanged. The I/O-port backdoor remains the initial
target for early DMI probing. Modules use the exported high-bandwidth
helpers and static-call trampoline; the static-call key stays private.

This v3 replaces patch 1 of Alexey's v2:
https://lore.kernel.org/all/20260309235250.2611115-1-alexey.makhalov@broadcom.com/
Its panic logging patches and steal-time fix were reposted separately:
https://lore.kernel.org/r/cover.1790014793.git.zack.rusin@broadcom.com
https://lore.kernel.org/r/20260929040256.543767-1-zack.rusin@broadcom.com

It is based on tip's x86/urgent branch, which has the i386
high-bandwidth fix this series builds on: e0e022004bbe ("x86/vmware:
Fix i386 high-bandwidth hypercall arguments").

Please route this through tip. As the vmwgfx maintainer, I agree that
its small annotation removal should go through tip with the assembly
move. DRM maintainers and dri-devel are copied. I'll make sure there are
no conflicts in that code while the trees merge.

And yes, this code is a bit like me, meaning it gets on everyone's nerves
and likely looks awkward in shorts, so we're just trying to make the best
out of what a politician would call a less-than-ideal situation.

Changes since v2:
- Replace the ten-argument backend interface with input/result structures.
- Move the high-bandwidth assembly out of the header as well.
- Preserve all low-bandwidth outputs and the backend-specific %dx flags.
- Export the callable trampoline without exporting its key.
- Correct the ABI documentation and retire unused feature bits.
- Keep the backportable i386 fix in its separate posting.

Alexey Makhalov (1):
  x86/vmware: Route low-bandwidth hypercalls through a static call

Zack Rusin (2):
  x86/vmware: Move high-bandwidth hypercalls out of line
  x86/cpufeatures: Remove unused VMware hypercall feature bits

 arch/x86/include/asm/cpufeatures.h  |   4 +-
 arch/x86/include/asm/vmware.h       | 371 +++++++++++-----------------
 arch/x86/kernel/cpu/vmware.c        | 299 +++++++++++++++-------
 drivers/gpu/drm/vmwgfx/vmwgfx_msg.c |   3 -
 4 files changed, 351 insertions(+), 326 deletions(-)


base-commit: e0e022004bbedc7caf1c18770980eb5372019189
