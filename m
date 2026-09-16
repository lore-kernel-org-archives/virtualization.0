Received: from mail-pj1-f100.google.com (mail-pj1-f100.google.com [209.85.216.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3993D361965
	for <virtualization@lists.linux.dev>; Wed, 16 Sep 2026 05:05:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.100
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789535154; cv=none; b=o+jsTTIT/4VXvf7VErlcaSbjKCaWD74+vVE/qncnb0MtU7/IBkie0zsu02utLV6SX2DJnMxYM1zy2vf2uAkknIdNuRvNVoN3bggGMo4HglbMoRuuP5ObAP6MrWLNiToX44Gdee6OYH8ieOgEhLUkuI/1po10mV4u44w/sbj7OEM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789535154; c=relaxed/simple;
	bh=jUsdJh8Hh+QQW+V8f3/afoIgbxaF+ULvWELh063IS2Y=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=RmoNuYSm1TpuPSV6DCflUgBEKhw7Ib3hCy6P8r0Gd9zJZAnpb68C/6b2iUh/ugR6n8ShHIK8MppYWCjzCif1tHeAeaZSWxIHT9p65kuklpD+WmJ/0znSrZ0FOk8YT9ngPXcenXCtx4UOv0qbGtVOmZMKx1qpA+pnFooUcDQpPDo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=P9VJKulJ; arc=none smtp.client-ip=209.85.216.100
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="P9VJKulJ"
Received: by mail-pj1-f100.google.com with SMTP id 98e67ed59e1d1-395cf2535acso1920949a91.1
        for <virtualization@lists.linux.dev>; Tue, 15 Sep 2026 22:05:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789535153; x=1790139953;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:dkim-signature:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=+i3/9cwENYafIlAkV2jcoorZwd9xMxSWurzxiZS8EDE=;
        b=nEMTe/cN6fXOpt2Ab3O8PcX95tEXKGtViAwNRKtV1Tmx3Y+2+lPWd2/PbfPHGuM2gB
         SbrjwMcV66iRXCwIGS2lhPyUEtOUr3YVEWc3pa1GB+p2HXXM34KMX4S80+2UDbopkOMx
         NFyqYvISUCJTnRVvSdKv6+mB5f27riFh6Su/Q4SmhxAt6Fdq/3idGvxqVEfbTy5k+0N4
         lqbwr1jDDi82/ZTwc5rQT4YsXWvQ98sz8mFGnejy33MeIzL4TVpQ+9cihU+IMOjtM4v+
         15bEcEuYsjdvp+l3kor9E28LqG/6xc1+wqh2nwdNjOX/CkKuHwW3pS+Zvm4toDqjUtKJ
         /E/A==
X-Forwarded-Encrypted: i=1; AKwUvBwAX78C7XhgUM1OAG/BW9++PnxhLuPlw634qKDJPwrjhtiI6r5Ky+b00k43Z8gncRMtpP+N3+tyQLbz6whQlw==@lists.linux.dev
X-Gm-Message-State: AFuF++la8KsGr8VvGZWjA1bfFQHSn7yc7bB3h79v+Oit25y6BTnLle4O
	06gjry6mQka4qqNVZ3/4dKbcwPPMAQb5CeCsJ1ougAz3rsz5ORJ6edEvYwL9CzcoZ1MGTRZVcn5
	BI3FlABaNmmneDFYOUdIsysAwDYcL5NCazL6XZirAiUxmc1q3DqoauFoemiwGkW6GL89ZV9o912
	1yDHwUCaZap8jPis0bgiitV3RnyRZtgVLQWgeEGqBfZoLBgFevTXUrAkYwn7RH+w9FHmuJInUfl
	jNtuXyvzhKA6jVyBWI=
X-Gm-Gg: AYBFou0+Px1EtOFtGPz6+J40ToZNiNmMM+4cl9FNEvelfxr9q88LvLTkrsyY3aEtpiZ
	V5yOlqlXPELdzE3R1uWj063nlZcGkkXV212AQWE+XfMB3GlTcf9j0Eng2Xd/xDnw6PVBcoNydEF
	ofCb0bwnP+4feRQGkXvf6wqumASI+2wmpQa80Mcf5F0r/+krwjgOK4v5r+JjrUnpWZueMVM9XSq
	UX1d2dCaKxhtwKUxhmCS1KedLDjZqz2MVzHESrbFMwst3bpeXISbN48l1x9PGXW6nbRXzbdQaXz
	aRe7UQc8UdS7LDJ/LRVYSP8PMEz5dtaZo47JYXZGq7JubP6wzJcvlMIoD1ApvwVbN+8Uh0D6zNv
	OGGFm0t+SvR3WUjayDS6c81EYlFhggKb9OJKqpp8yeu4WIQaQysGVaUevSo1zL3iIc3tFLMuEmH
	fROl8JISNp2Y5X7Mk3Frw4nPFsIrRbKtKB
X-Received: by 2002:a17:90b:2e07:b0:39d:e1da:81e5 with SMTP id 98e67ed59e1d1-39e20132ca6mr1141915a91.11.1789535152427;
        Tue, 15 Sep 2026 22:05:52 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-98.dlp.protect.broadcom.com. [144.49.247.98])
        by smtp-relay.gmail.com with ESMTPS id 98e67ed59e1d1-39e1b3efe54sm799740a91.1.2026.09.15.22.05.51
        for <virtualization@lists.linux.dev>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 15 Sep 2026 22:05:52 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-pj1-f70.google.com with SMTP id 98e67ed59e1d1-39e18af9f48so1253015a91.1
        for <virtualization@lists.linux.dev>; Tue, 15 Sep 2026 22:05:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1789535150; x=1790139950; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=+i3/9cwENYafIlAkV2jcoorZwd9xMxSWurzxiZS8EDE=;
        b=P9VJKulJniKA8ujO0uaek7hFObY3Agf52QmV7LCJsa/30BjY50Ad67hf0XTvFriZTE
         9O0k94C7hQ8JwkQNuqqHNUXAh14HH8wyx9Ny0hmPoyb9c/RIAAEFKuo2ze8QWnloW+hB
         0kU87fhFzklme8/PSyeWj2rwIQacAOa0oh+Qg=
X-Forwarded-Encrypted: i=1; AKwUvBzOL87cO8cYlhU01ONHYcTHyG4+5L1+MSSae0gStiLR3UEVz2/HpfrYKX98LzEhZkXGXNNYh5WbuGjWw1NhgA==@lists.linux.dev
X-Received: by 2002:a17:90b:39a6:b0:398:a649:8fa3 with SMTP id 98e67ed59e1d1-39dfe1c9d0emr9817207a91.23.1789535150506;
        Tue, 15 Sep 2026 22:05:50 -0700 (PDT)
X-Received: by 2002:a17:90b:39a6:b0:398:a649:8fa3 with SMTP id 98e67ed59e1d1-39dfe1c9d0emr9817170a91.23.1789535150025;
        Tue, 15 Sep 2026 22:05:50 -0700 (PDT)
Received: from vertex.localdomain ([192.19.144.250])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-33bf5e40494sm3951386eec.15.2026.09.15.22.05.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Sep 2026 22:05:49 -0700 (PDT)
From: Zack Rusin <zack.rusin@broadcom.com>
To: Borislav Petkov <bp@alien8.de>,
	Ajay Kaher <ajay.kaher@broadcom.com>,
	Alexey Makhalov <alexey.makhalov@broadcom.com>,
	x86@kernel.org,
	Dennis Zhou <dennis@kernel.org>,
	Tejun Heo <tj@kernel.org>,
	Arnd Bergmann <arnd@arndb.de>,
	Kiryl Shutsemau <kas@kernel.org>,
	Rick Edgecombe <rick.p.edgecombe@intel.com>
Cc: Thomas Gleixner <tglx@kernel.org>,
	Ingo Molnar <mingo@redhat.com>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	"H . Peter Anvin" <hpa@zytor.com>,
	virtualization@lists.linux.dev,
	bcm-kernel-feedback-list@broadcom.com,
	linux-kernel@vger.kernel.org,
	Christoph Lameter <cl@gentwo.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Tom Lendacky <thomas.lendacky@amd.com>,
	Bo Gan <bo.gan@broadcom.com>,
	linux-mm@kvack.org,
	linux-arch@vger.kernel.org,
	linux-coco@lists.linux.dev,
	kvm@vger.kernel.org,
	Zack Rusin <zack.rusin@broadcom.com>
Subject: [PATCH v1 0/2] x86/vmware: Share steal-time storage in encrypted guests
Date: Wed, 16 Sep 2026 01:05:38 -0400
Message-ID: <cover.1789488039.git.zack.rusin@broadcom.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e

VMware registers each per-CPU steal-time GPA with the host. An encrypted
guest must first convert that storage to shared memory, but the existing
setup publishes the address without conversion.

Patch 1 makes the decrypted per-CPU section available with
CONFIG_X86_MEM_ENCRYPT, including TDX-only configurations. Patch 2 defers
encrypted-guest setup until allocator-backed page-table splitting is
available, converts every possible CPU's storage before publishing any
GPA, and attempts to roll back all conversions on failure.

TDX's conversion callback uses __pa(), so patch 2 preflights every possible
CPU and leaves steal time disabled if a TDX guest uses vmalloc-backed
per-CPU storage. This covers percpu_alloc=page and automatic allocator
fallback. AMD encrypted guests support those mappings and are not rejected.
Supporting them in TDX would require a separate conversion-API change.

Conversion need not preserve zeroes, and the host initializes only the
8-byte counter. Patch 2 therefore clears each 64-byte object after
conversion and before registration, without disturbing other decrypted
objects that can share its page.

The intended merge path is tip's x86/vmware branch, following
commit ac26963a1175 ("percpu: Introduce DEFINE_PER_CPU_DECRYPTED").
Per-CPU and asm-generic maintainer Acks are requested for patch 1.

This replaces patch 4 of Alexey's v2 posting:
https://lore.kernel.org/all/20260309235250.2611115-1-alexey.makhalov@broadcom.com/

Zack Rusin (2):
  percpu: Use X86_MEM_ENCRYPT for decrypted per-CPU data
  x86/vmware: Decrypt steal-time storage before sharing it

 arch/x86/kernel/cpu/vmware.c      | 96 ++++++++++++++++++++++++++++++-
 include/asm-generic/vmlinux.lds.h |  2 +-
 include/linux/percpu-defs.h       |  2 +-
 3 files changed, 97 insertions(+), 3 deletions(-)


base-commit: fd73f4a6659897191fa0d40695fe370925dd3780
-- 
2.53.0
