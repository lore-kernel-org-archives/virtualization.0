Received: from mail-pj1-f97.google.com (mail-pj1-f97.google.com [209.85.216.97])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FD0C2765ED
	for <virtualization@lists.linux.dev>; Sat,  7 Mar 2026 01:06:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.97
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772845612; cv=none; b=In/Ef118HdStCT3cf4PktiZRpRlERbgbtP4x94oDGcPNU2wFz66TSSaXE3E3zJU/7bJS2y1PHj9gvcUdah3vJrGwPKyMdxnXbzELID57UK74D1ts7LQDJfqrOkWRgufJMO/DSRGoyAM6ZTuT7zyp1mfc+ULyCTSyJLytt/Nuhv4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772845612; c=relaxed/simple;
	bh=wocwMBtmqdX0JKhTFqmK3JOtLY3emCOw7nguFyk44ZQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=S+2Ca7mtfrnhIjqnlRh1RQDTUwIDXFRIzM5S0dPRgb6VAyT8F9vEUPdNohXBp2XwVcxZ4FLZ6PvTjCxJ2IhbqbYp2zfbm+X45lcYTNxp5ZVrmSDWc7DS/RmM1FkAGZAe59kfqeWPihsV9+XcLMMmkqwbEfC8RYkRVFRb8ZX4dqo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=WjfYDInQ; arc=none smtp.client-ip=209.85.216.97
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="WjfYDInQ"
Received: by mail-pj1-f97.google.com with SMTP id 98e67ed59e1d1-35982fd8910so2870006a91.1
        for <virtualization@lists.linux.dev>; Fri, 06 Mar 2026 17:06:51 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772845611; x=1773450411;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:dkim-signature:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=uKwzPlEBkrVJivPlO0kAq6WzLFvPFMNSILdYW8SSrFg=;
        b=HYI5CLKSAVPmAe8kDYDUyQofLA8LT3D0dsgO9FQWef+a1vlK7vbkfwwQM5scV3YR06
         c+/z1YaqsD8lDrCc7RyYj9JuF7oHD7iJjUidzq4OXkYie6hMAII8lkuYZaG39ZK4yJXM
         QHpxodOjxrtAUTLI8ZJXmorqa08ZHxiQx5NnF57NiKHpChSwj+giwtbWAxvzCOYs3lwi
         DadFnxi1ryfokyzTBBaqq+CCIacwh5Ti80b5Z8VGNv7qiVriIAxmMVFfSXiCrl2bizR9
         oXXsWM/A5YhpNvQ/epYhlig7zgH7gJUoq2FhXsrtSQKI3AbV7F4ECyWL6FHuspZEUOEW
         fTCw==
X-Forwarded-Encrypted: i=1; AJvYcCWjEBPu3Ls4YSjuttRKDfM5w0XtgjxT+G8HRU+JUJmj1JdcwBAvm0t1Kfer8ttaZF6ffU362NTTXMW/ROXuJA==@lists.linux.dev
X-Gm-Message-State: AOJu0Yx0HQNcHqXu5jJIqIt/ztj+ImaoMGHCeG6j/Jyy+8CR44nDeEbj
	Dzo6tiKSFpkvzdwTnAY2qUpIupBEGJgyGuaT8vGi1CKASnLyKic4BIsJjBJ0l0m/f1YevlvYZd1
	ClWim0SVlf0IZGH8GG/6pvZfmzkVJtqQwyjOsOesiAHwESqe15+OeHf6Ywt4UyYqRSuRCP8h9su
	TJWES4H3JRCN605s3ut94Nj4ly6dYf3dtPwJmBk+FvC9qPPt5IrBFRzFhYwMOC3QojFkihw3WZm
	GV/0yH83Rw2dfwbak720NjqjA==
X-Gm-Gg: ATEYQzwYDNRhedR5GzV2fyM/faCPopeD8vBYXfWZyNXRb9FgUzx8H1OcpSSyDfFCS6i
	0yR2SXXI5FZsDz9TFWP0dseu7DSxunJh23oWptrPjuKxyzO9LGmMj1poIwrWJi7AVIVse3rJvZI
	4wVqu96Slf/JUCkLycXgNl9LabmvsAAmYd6gndutcy6ulhFP5PrJuBTFE1U0TP6UGyuxq/5BBjB
	XqELe0AdBcKiaAGrIrnR73t1e9FPus4PB37XPmjvOwQFTGzpBFSh4gOFgFjuOu/egVYj/DpRZ9R
	3TTsx6xL4SRBk8s57eWAP0SUCPNu+hHo+h+m+63bYtPNagk5ntA3KQ6iKNbjDbi4WWPBHiGo/oM
	jtTpFGmzYugl55COm8agAk7pYbDxu+oE3UhElHW4/l2A8cJbuynSqZn44a1LYy0v4CIHwetgJQR
	9/StV1rUxbGLsytw2hHo+HrsmfNigch3CjDiHWFJDoQ0MjCZYIuB4tWM24SFsX
X-Received: by 2002:a17:90a:fc45:b0:359:bb5e:95ea with SMTP id 98e67ed59e1d1-359be24ec75mr3600460a91.11.1772845611023;
        Fri, 06 Mar 2026 17:06:51 -0800 (PST)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-29.dlp.protect.broadcom.com. [144.49.247.29])
        by smtp-relay.gmail.com with ESMTPS id 98e67ed59e1d1-359c0040592sm360797a91.2.2026.03.06.17.06.50
        for <virtualization@lists.linux.dev>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 06 Mar 2026 17:06:51 -0800 (PST)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-dy1-f199.google.com with SMTP id 5a478bee46e88-2bdf6fe90a9so8855969eec.1
        for <virtualization@lists.linux.dev>; Fri, 06 Mar 2026 17:06:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1772845609; x=1773450409; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=uKwzPlEBkrVJivPlO0kAq6WzLFvPFMNSILdYW8SSrFg=;
        b=WjfYDInQtgXaERMxCk+Bsp+0vRtbDlAHZtdZFFURywO2tFZsx/hD7cdUuCv8U81DdK
         ikkPWa8omUV8gTpTSVNJ67OuycbxvBvyj6IyXxRWzXHC6vSEslvpJ/XnTGxQTH5LGYp6
         B0QwbBrY28L0WdjYt3xNORutgL5erxJaaWshg=
X-Forwarded-Encrypted: i=1; AJvYcCWQcCeuq4srLtHD2Rb4OISTaib+lmtLu0KgTqeX6T0Uv/xDuZsEB1pFH+fjk1hY6YmU7KUR+C7ATzwRpJBkqw==@lists.linux.dev
X-Received: by 2002:a05:693c:3101:b0:2be:aa:9a4a with SMTP id 5a478bee46e88-2be4dd62c65mr1466898eec.0.1772845607427;
        Fri, 06 Mar 2026 17:06:47 -0800 (PST)
X-Received: by 2002:a05:693c:3101:b0:2be:aa:9a4a with SMTP id 5a478bee46e88-2be4dd62c65mr1466860eec.0.1772845605215;
        Fri, 06 Mar 2026 17:06:45 -0800 (PST)
Received: from amakhalov-build-vm.. ([192.19.161.250])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2be4f80cc1dsm2237336eec.3.2026.03.06.17.06.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Mar 2026 17:06:44 -0800 (PST)
From: Alexey Makhalov <alexey.makhalov@broadcom.com>
To: x86@kernel.org,
	virtualization@lists.linux.dev,
	bp@alien8.de,
	hpa@zytor.com,
	dave.hansen@linux.intel.com,
	mingo@redhat.com,
	tglx@linutronix.de
Cc: ajay.kaher@broadcom.com,
	brennan.lamoreaux@broadcom.com,
	bo.gan@broadcom.com,
	bcm-kernel-feedback-list@broadcom.com,
	linux-kernel@vger.kernel.org,
	kas@kernel.org,
	rick.p.edgecombe@intel.com,
	linux-coco@lists.linux.dev,
	Alexey Makhalov <alexey.makhalov@broadcom.com>
Subject: [PATCH 0/4] x86/vmware: Hypercall refactoring and improved guest support
Date: Sat,  7 Mar 2026 00:42:34 +0000
Message-ID: <20260307004238.1181299-1-alexey.makhalov@broadcom.com>
X-Mailer: git-send-email 2.43.7
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e

This series improves VMware guest support on x86 by refactoring the
hypercall infrastructure and adding better crash diagnostics, along
with encrypted guest support for the steal time clock.

The first patch introduces a common vmware_hypercall() backend selected
via static calls. It consolidates the existing hypercall mechanisms
(backdoor, VMCALL/VMMCALL, and TDX) behind a single interface and
selects the optimal implementation at boot. This reduces duplication
and simplifies future extensions.

Building on top of the new hypercall infrastructure, the next two
patches improve post-mortem debugging of VMware guests. They export
panic information to the hypervisor by dumping kernel messages to the
VM vmware.log on the host and explicitly reporting guest crash event
to the hypervisor.

The final patch adds support for encrypted guests by ensuring that the
shared memory used for the steal time clock is mapped as decrypted
before being shared with the hypervisor. This enables steal time
accounting to function correctly when guest memory encryption is
enabled.

Patch overview:

1. x86/vmware: Introduce common vmware_hypercall

   * Consolidate hypercall implementations behind a common API
   * Select backend via static_call at boot

2. x86/vmware: Log kmsg dump on panic

   * Register a kmsg dumper
   * Export panic logs to the host

3. x86/vmware: Report guest crash to the hypervisor

   * Register a panic notifier
   * Notify the hypervisor about guest crashes

4. x86/vmware: Support steal time clock for encrypted guests

   * Mark shared steal time memory as decrypted early in boot


Alexey Makhalov (4):
  x86/vmware: Introduce common vmware_hypercall()
  x86/vmware: Log kmsg dump on panic
  x86/vmware: Report guest crash to the hypervisor
  x86/vmware: Support steal time clock for encrypted guests

 arch/x86/include/asm/vmware.h | 276 ++++++++------------
 arch/x86/kernel/cpu/vmware.c  | 470 +++++++++++++++++++++++++---------
 2 files changed, 463 insertions(+), 283 deletions(-)

-- 
2.43.7

