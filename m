Received: from mail-pl1-f225.google.com (mail-pl1-f225.google.com [209.85.214.225])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 115C41B86C7
	for <virtualization@lists.linux.dev>; Tue, 10 Mar 2026 00:17:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.225
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773101832; cv=none; b=XChfDhthQwfw984VL8CgNrV891ZJqUj7En/T1S9knouVIe5l8XO5mmg6LL8PBexGbkVAYkAoUIS6xNQee2gbWyxuHpsGsCAkX9DWV63TVkBkPqXjmUnIpACE21K+4ijjVfuVPjCsqpPoGWy5+FERo/s1JBakr7BBnri98RCM3t8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773101832; c=relaxed/simple;
	bh=svdA7A+dthIfmJn6H+/CYxQwZVSDdE6m1ViEhOWnzN0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=F+y4Y8ti7Yfyk4ylfcjC4PLZye1nBP2x+0uMb5e+nrBX3iCLiDAqabN8j/cNDi1CwtEznqg3hMkgrMUIUluSegTpGrcYd+TKUEl5fGiQWOMgMsRzgCTYHsNhfi0VtMH5fXobHZ+svHH/FyggHPduq8hU7oqoOWYlWYZWHkeSVRs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=c4rzaiLX; arc=none smtp.client-ip=209.85.214.225
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="c4rzaiLX"
Received: by mail-pl1-f225.google.com with SMTP id d9443c01a7336-2ab39b111b9so55159955ad.1
        for <virtualization@lists.linux.dev>; Mon, 09 Mar 2026 17:17:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773101830; x=1773706630;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:dkim-signature:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=GhB5D335RnTvmhxu2qGnXeGw/Xudg4Jft8uixUbp1M4=;
        b=DLVeZk7cP2bORnrwnv+E6YhpE1UzyKSbYGgPPmOvvpjEZGr8P+sDtUqRQCzIYbH5Mr
         XbNO9J+YremqwhzuZmoy7EDSgLGbNWBkEHTkP4jIjkD922mk7Bt2EnESKtxQHk78aDK8
         SenrXtUj/uMTAIIehSU1Cy04dAYMF0bYOIH4CNrX49bEhTFw7L9troapqk1McjcVwpQg
         ZeZ4zH7qE5D33DfCRHLMg6rW/RjytfiyhJxXg2f41cE/7UDBO/sMwfRnhKRL5aJ67q1D
         t/7Qq9Tcv50CysWUp+VxSWV3mg5NBQElQejGH2dCvHh4NSm9iR7opn4rRLavOkBnjkFP
         OGiw==
X-Forwarded-Encrypted: i=1; AJvYcCXQ5zhT0n5NGua3+hEn3rBOtNQ8tQusuMzgsOjcEbu4qUZnfnp4p0SkoS9vhC181BHO5fJcZLHiGrabclgmDA==@lists.linux.dev
X-Gm-Message-State: AOJu0YwhupH3T9RBnaMae9WLg3UdPWOAiqdaPWUaxYem8ck9UGlNeSBD
	aAx6jh0yNo4IyKsrrpBta13DTLbZEYItryXC5Dh21ymE+vmXC2eyVD1H6py7s0ZT+ndO0xyNE77
	qYEBtheHvy+b5qL6+0FbeAORhnUsU9sEc4FgsdjSTKtp2moJyw8k9T7wR0NdpgqVccSJt6khgsQ
	h3F/630G8OzUqCtQULK42EBnoXvxis65/4A0T/xCEKeai7iX5en+DSPjynxXs0ziZMWumyK0IGS
	tVqt9y/3Mm4aSqoOrX51M27Rw==
X-Gm-Gg: ATEYQzzfKQZpdVDQOGiZ35cKpoQcDttyHTpehvWLInhDYF9oLK/eol7Awq8fADxU2d1
	vdALOY9f7Bv5ekuHHoTa1sYTb9+HR/ClwGJAvmOzI7iNsvn4QAfP8zZs+fA0craip39PgXkGg+u
	CB2lvEAq6/e4tj1jIUHFuAYGViBpiE6EqxyF1JZFrMiVVRo9J4xxnQ4Int8IKr+yg8OyV41DmrM
	KNJi+hHrgossqCs5cPmGRdDD8iiwPjtxa/x/Cikgtx9irir/D1hJFuE82oNSOBhOpTLiJTRQMiR
	linkUFveGeqZ5/XX29KJ5auASfQCAxDV/9h41ROeR3gChZ/6OxmYIr06MGmd9PRvMCp6nzUUqhA
	IOvR18KBCdSUP9QRxhGbeyhHI6YypYVnmBZMvsCxKZQ3w6tNM1k8Fck62EBjOoK+6U0v0UKS2gJ
	vojM1Vtcb0u2iDWMGh9pCP09diiOsdzKRYbOfF+yOA4E1Z/sRARPB+VOsrKkZNvn4=
X-Received: by 2002:a17:903:985:b0:2ae:8293:74ee with SMTP id d9443c01a7336-2ae8293797emr131732585ad.48.1773101830392;
        Mon, 09 Mar 2026 17:17:10 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-102.dlp.protect.broadcom.com. [144.49.247.102])
        by smtp-relay.gmail.com with ESMTPS id d9443c01a7336-2ae83f3a747sm16644725ad.36.2026.03.09.17.17.10
        for <virtualization@lists.linux.dev>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 09 Mar 2026 17:17:10 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-dy1-f198.google.com with SMTP id 5a478bee46e88-2be0575e290so7289697eec.0
        for <virtualization@lists.linux.dev>; Mon, 09 Mar 2026 17:17:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1773101829; x=1773706629; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GhB5D335RnTvmhxu2qGnXeGw/Xudg4Jft8uixUbp1M4=;
        b=c4rzaiLXExn5ez5oJNwbW5gwLfdbKY8cXolAvGiybDspKguV2oGsNf/gbclyMG7Fhx
         dwBKacWDxdE7fQ81+ypQ1mVAlUuUe9P0gJaAaoSFg31yUtQZXUEzoemtIZJYS5cfOn7v
         XabKozt2LZZ6MuTAoRG1C1dkCJqOusyLbO0Cg=
X-Forwarded-Encrypted: i=1; AJvYcCW1s6ukFdBDgRG/SdqN/bqGyHqWQ4UXcG6BHefVDmgsl5mupuzcw9hyPyhsiZvMcKYDGawoSI8DBysNz/aTgw==@lists.linux.dev
X-Received: by 2002:a05:7301:418b:b0:2bd:b102:a022 with SMTP id 5a478bee46e88-2be4e08842cmr4290765eec.27.1773101828592;
        Mon, 09 Mar 2026 17:17:08 -0700 (PDT)
X-Received: by 2002:a05:7301:418b:b0:2bd:b102:a022 with SMTP id 5a478bee46e88-2be4e08842cmr4290754eec.27.1773101827964;
        Mon, 09 Mar 2026 17:17:07 -0700 (PDT)
Received: from amakhalov-build-vm.. ([192.19.161.250])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2be4f948324sm12678991eec.17.2026.03.09.17.17.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Mar 2026 17:17:07 -0700 (PDT)
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
Subject: [PATCH v2 0/4] x86/vmware: Hypercall refactoring and improved guest support
Date: Mon,  9 Mar 2026 23:52:46 +0000
Message-ID: <20260309235250.2611115-1-alexey.makhalov@broadcom.com>
X-Mailer: git-send-email 2.43.7
In-Reply-To: <20260307004238.1181299-1-alexey.makhalov@broadcom.com>
References: <20260307004238.1181299-1-alexey.makhalov@broadcom.com>
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


Changelog:

V1 -> V2
   * Fix compilation warnings in patch 2 "x86/vmware: Log kmsg dump on panic"
     reported by kernel test robot <lkp@intel.com>


Alexey Makhalov (4):
  x86/vmware: Introduce common vmware_hypercall()
  x86/vmware: Log kmsg dump on panic
  x86/vmware: Report guest crash to the hypervisor
  x86/vmware: Support steal time clock for encrypted guests

 arch/x86/include/asm/vmware.h | 276 ++++++++------------
 arch/x86/kernel/cpu/vmware.c  | 470 +++++++++++++++++++++++++---------
 2 files changed, 463 insertions(+), 283 deletions(-)


base-commit: 7d08a6ad25f85c9bb7d0382142838cb54713f1a3
-- 
2.43.7

