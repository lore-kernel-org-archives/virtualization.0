Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.222.227
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794984335;
	b=SRnYzyHYdPA2CTDRKpZf0HSH23d2ny1gcXAC903cp+8zxe5oPrkduMXlQxKrb8JapLee
	 rkWQxwLkwcM1T3mrWvph2e9Mfp9IbPR+P6XgXECfrIYVz9BdXl+WAtODVzHf9ItuDUcEI
	 NzGAlCZXS/gmDDlS6wgn/rtoEPUaaVG/u9oB9Kps5C2rqfUOiHqy63vKUB5yEow4JX6VP
	 O83RvJJlNg4acqiN7UdGLc1EiWSsE7OobF8FJeN0/F9goCu7kcrdEIw7dmedGJdLsaG53
	 Zxxgdxixu9c1PBgFEXU2UIWTzIn4E1v+pUMOcFpDF7P5ymnt4Bkqb12CHWFHkyuoHLQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794984335;
	h=DMARC-Filter:Received:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:X-Relaying-Domain:
	 X-CFilter-Loop:Received:DKIM-Signature:X-Forwarded-Encrypted:
	 X-Received:X-Received:Received:From:To:Cc:Subject:Date:Message-ID:
	 X-Mailer:MIME-Version:Content-Transfer-Encoding:
	 X-DetectorID-Processed;
	bh=BN2eMBIZKP4IgFzjpmqX87SaP1ERJDhlfNIPjHVFBk4=;
	b=Av/nduaYiDGNAtMDiK/T1JjMr6UE9BseNxiXKT6eSXwRYFDbLpLbexcxm76VjOHnTwHo
	 NyrZcxhtpSDnZZ+Y+sC2D+RB/Gg5S9qN8b+HcDFQ0/KBVj1XnbGmdPevBs26B8CXyyWoK
	 ruaixsFlQAJxr2JyYxw837UvBpfDtjshtBwrrJcY5XXTHduBaGY86bqlFfRM9eXAx3Avh
	 xcKZyRAzG479t+FA9kmjzMLthDEgGG8XRmXMN7G3ZPnmfeFNLN/5G8SitSeTqcaseMinv
	 gJXA7XT/SeZi4KnWA8CWybcNn9S5dqbB+QrRblu32IZyvk2LrVU1ZmpU7+hXlB9JgaQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=broadcom.com;
	spf=fail smtp.mailfrom=broadcom.com;
	dkim=pass header.d=broadcom.com header.i=@broadcom.com header.a=rsa-sha256 header.s=google header.b=JVfK1YXW;
	arc=none smtp.remote-ip=209.85.222.227
Received: from mail-qk1-f227.google.com (mail-qk1-f227.google.com [209.85.222.227])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2958F606A31C
	for <virtualization@lists.linux.dev>; Wed, 18 Nov 2026 06:45:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 2958F606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.a=rsa-sha256 header.s=google header.b=JVfK1YXW
Received: by mail-qk1-f227.google.com with SMTP id af79cd13be357-93f3c616c84so58006385a.1
        for <virtualization@lists.linux.dev>; Tue, 17 Nov 2026 22:45:34 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794984334; x=1795589134;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:dkim-signature:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=BN2eMBIZKP4IgFzjpmqX87SaP1ERJDhlfNIPjHVFBk4=;
        b=04TCLdcCk9BUbSoj6rD34Fe93UjDRFO4uypgxPizss8N6vvTdASeT8JoG6M99Fh2o5
         itVZ1HZ7GsYD9XU9kkg6KN0Fl9JKGohNYHRX02KqlSIAQhjuVKyYLI2n+ZsTr7sw5ZWi
         36u+NaZHTKOgQxknL4VZO41bHMxNjtQHQmtvkczaelnUixB3zrTTshDC3KGTAGnTf+Mn
         +eXuMcGtXLehqHTRvTtLJiE9m2y6uhPppjkWSIKpv2zuaaDIYTAbjciOaGdIpC1ofvVD
         3Loew88t1rZtuVaMkOV2600BuAPwZC7eEWzyRC0aOkPMjIr1DPKIgJTmViv1NxABFQy2
         QDGA==
X-Forwarded-Encrypted: i=1; AL+hErHhzmT5ZwvGvdCnN3NEec0lLge+q/ykk0HjFj32l5IO6EDDDUVEuKmz4/6pKWC+R7L9fQGoZ6F5KI0/5k5iVw==@lists.linux.dev
X-Gm-Message-State: APuU4Z9FZDph6Sc8MtQmmzBkrtTQM4lcKRTXWAkuw97CbBBLZMBG6+oG
	3LRWGydhQaex6twUNlpVjvOVpFLah95+Fy8XAZAGh/X8xy8aT6fuxAXFXgT3DRVNTnVTTuQ7IfQ
	JOJg/aZfQrrYzSigxib6cxUJtmV/DuqaYrfkGODtroQLdoqVZu60+pBIJkBYhyhzBYZh61QNd6O
	NXfmkQjchrTTjspb7WtR3G/nSwTKC/Wa3IG1tRYRxb80lkaKYlyM6QlF1lbNkmKUv93SyZQXn46
	xenWpLSaYsMtHY/Zxk=
X-Gm-Gg: AYBFou3RDfDGpWBJX5Up10TC1Wwc9cNSzlYFk/icrHzvCim7txo41+HSeWnHnj7PrOS
	AbYuHtl5cI52BxbDpsDMwuVfOeMvUOPoN581UHv/OCPH1ngY3yQxJfzKkcIl/LHaEOOFa9Kv7GA
	sYbf8D8zWc7eppZugSCBEx9gkdDgwtMjZZmgtqkaAROBRV8KOAw2LghkxaD81mFhaoR+6vK/Cbk
	v3EEJDD63CmbP3XtvNsxDDG3sWheIjiDIFwX5PQPYEms4Y3E/hZFSDHDgi0wdKg2RKl/XNcOhEl
	W4ZCdlkT1QcJr9SuDevlkTFZLtCuOTV6tbS3dqHoe1CdAJhwG33xHgsOkTsIj8EZ4LqPEmWeYOf
	8qXypAH27kRbsYlk6cQQ+QDlRifZiYTPrpGBxnglQGqPmzGPWZNqNWUbOfxbaW4CutrT2SEE4XW
	K3WOfIgPFcKimyiKXH0ZEGGzKiFpJmeKx5Tc0=
X-Received: by 2002:a05:620a:8388:b0:944:12d5:fd45 with SMTP id af79cd13be357-949996075d7mr301833485a.70.1794984333788;
        Tue, 17 Nov 2026 22:45:33 -0800 (PST)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-123.dlp.protect.broadcom.com. [144.49.247.123])
        by smtp-relay.gmail.com with ESMTPS id af79cd13be357-9499b3d39c9sm10802085a.2.2026.11.17.22.45.33
        for <virtualization@lists.linux.dev>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 17 Nov 2026 22:45:33 -0800 (PST)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-qv1-f69.google.com with SMTP id 6a1803df08f44-91f2b449480so10635856d6.3
        for <virtualization@lists.linux.dev>; Tue, 17 Nov 2026 22:45:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1794984332; x=1795589132; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=BN2eMBIZKP4IgFzjpmqX87SaP1ERJDhlfNIPjHVFBk4=;
        b=JVfK1YXWWdsqQ4MkWGBRj/NgdYQNpJRLS/vaUf+PkkVjBWhAWHm3QVrJ6+mkpJaw8B
         N5fxMkq32mAuUpC94toMSLwrWgvjz+zMOLrzi0V67y35Tv8E0dG5Ni6QXInKZCjC8Iro
         pc43LuA3/od1SfApvlSO+cEi5hjMQDfWBCuj4=
X-Forwarded-Encrypted: i=1; AL+hErHYuiTtlyxBZ1Os0FnrzJ224/XapMhfPBUrDYlPIu1tsOrXw4H43a7i+dfbW9Dtx/sy8wmN2ON8JqMybNXisQ==@lists.linux.dev
X-Received: by 2002:a05:622a:346:b0:536:7b67:95f7 with SMTP id d75a77b69052e-55d5a7af113mr24847251cf.77.1794984017828;
        Tue, 17 Nov 2026 22:40:17 -0800 (PST)
X-Received: by 2002:a05:622a:346:b0:536:7b67:95f7 with SMTP id d75a77b69052e-55d5a7af113mr24847041cf.77.1794984017277;
        Tue, 17 Nov 2026 22:40:17 -0800 (PST)
Received: from vertex.localdomain (pool-173-49-113-140.phlapa.fios.verizon.net. [173.49.113.140])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-55d61cf3b56sm2078141cf.13.2026.11.17.22.40.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Nov 2026 22:40:16 -0800 (PST)
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
Subject: [PATCH v4 0/3] x86/vmware: Clean up the hypercall code
Date: Wed, 18 Nov 2026 01:40:10 -0500
Message-ID: <cover.1794206170.git.zack.rusin@broadcom.com>
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

This series replaces patch 1 of Alexey's v2:
https://lore.kernel.org/all/20260309235250.2611115-1-alexey.makhalov@broadcom.com/
Its panic logging patches and steal-time fix were reposted separately:
https://lore.kernel.org/r/cover.1794201807.git.zack.rusin@broadcom.com
https://lore.kernel.org/r/cover.1792471114.git.zack.rusin@broadcom.com

It is based on v7.4-rc2, which includes the i386 high-bandwidth fix
this series builds on: e0e022004bbe ("x86/vmware: Fix i386
high-bandwidth hypercall arguments").

Please route this through tip. As the vmwgfx maintainer, I agree that
its small annotation removal should go through tip with the assembly
move. DRM maintainers and dri-devel are copied. I'll make sure there are
no conflicts in that code while the trees merge.

And yes, this code is a bit like me, meaning it gets on everyone's nerves
and likely looks awkward in shorts, so we're just trying to make the best
out of what a politician would call a less-than-ideal situation.

Changes since v3:
- Forward TDX guests from the backdoor backend to the TDX backend,
  restoring the pre-series ULONG_MAX return on other hypervisors such
  as KVM instead of attempting port I/O (reported by Sashiko).
- Correct patch 2's description of the duplicated assembly.
- Rebase onto v7.4-rc2.

Changes since v2:
- Replace the ten-argument backend interface with input/result structures.
- Move the high-bandwidth assembly out of the header as well.
- Preserve all low-bandwidth outputs and the backend-specific %dx flags.
- Export the callable trampoline without exporting its key.
- Correct the ABI documentation and retire unused feature bits.
- Keep the backportable i386 fix in its separate posting.

v3:
https://lore.kernel.org/r/cover.1793685318.git.zack.rusin@broadcom.com

Alexey Makhalov (1):
  x86/vmware: Route low-bandwidth hypercalls through a static call

Zack Rusin (2):
  x86/vmware: Move high-bandwidth hypercalls out of line
  x86/cpufeatures: Remove unused VMware hypercall feature bits

 arch/x86/include/asm/cpufeatures.h  |   4 +-
 arch/x86/include/asm/vmware.h       | 371 +++++++++++-----------------
 arch/x86/kernel/cpu/vmware.c        | 307 ++++++++++++++++-------
 drivers/gpu/drm/vmwgfx/vmwgfx_msg.c |   3 -
 4 files changed, 359 insertions(+), 326 deletions(-)


base-commit: 7475ea8b58616b33c04afb976cf0fbaad9dd63fb
