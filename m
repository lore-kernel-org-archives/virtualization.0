Received: from mail-pj1-f99.google.com (mail-pj1-f99.google.com [209.85.216.99])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B512559C96D
	for <virtualization@lists.linux.dev>; Tue,  8 Sep 2026 18:07:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.99
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788890859; cv=none; b=UFrzEPxF8327aFE9QEqxpM8pOhNc5tteRIKkvHOPl0mDERADX0EZG1fcaBPwAlIZfbxhGoJIAK4uG0EDZNlDhjUvqXMSfp7Hg+hpyVV4g+X+6Efabqv8iVyfHGddz9D0MB8mCr5KUm6pSmqC51oqFinyrd+vDCLq4OlN4ISPcus=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788890859; c=relaxed/simple;
	bh=aVct0QQQt2YqktuHDZgb/IGehlIFoCNOWmk87ahbsdY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=nLZUs76UW9dZkqNJXmBIq7lZvX1Us2zJjShnBvn2rPUi7HPmn0nNpRlCMfknWMm37qLqXF1CPhQge6Ngt1z+Ytt9NpkxVPvhAG1PJLV3Camlbd2JbWYnawjLov/fYD4s5HF9IqSuESFPEzIb+x1s4kKVuAgyVhf61HzKR367NnU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=PDKRb2JZ; arc=none smtp.client-ip=209.85.216.99
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="PDKRb2JZ"
Received: by mail-pj1-f99.google.com with SMTP id 98e67ed59e1d1-39682983a0fso5337448a91.3
        for <virtualization@lists.linux.dev>; Tue, 08 Sep 2026 11:07:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788890849; x=1789495649;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:dkim-signature:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=r+VLJNR2ClH5aaw8GL8jeSbQjtC7qAwKNhxP9YK5biY=;
        b=gHT+9ctJZHFmZoY7dfln8E6EzM6WU049nf7BmTgTgZIZxdxwFQTNZ94uq4uqfw1cS4
         117jbLkeIS4pz1NMkD8hRhvVuVnGgfXk1nWZ3JB6Xq9P/yXFnzuKRsFf2B4nAry26eRf
         etf4i2GshnAvgEJ6Nkahu528E1zIPLRst+9jf8jtlMGeUs6FHGJkQ4sdjB26naplMFqn
         WcufVPa1adxHjM1lle/e1KLpwnIFCGycoS3WumZC61pHu3oVJU4NyvuI7bzFUmzFURTn
         x0ZoTY/cHspxXxfQduFcV4Ly9+5XcnlrxwIWfGHloB2TNUHb5i/d+hoNy23EhCny495d
         7ecg==
X-Forwarded-Encrypted: i=1; AKwUvBx8JvYObjpbXHkfF3zugd7Qrk4AT63B7VY4l9SDjW6TlXpsRQvafySKtVjRvZP3/ctXtANaacr73MJ8dwImdg==@lists.linux.dev
X-Gm-Message-State: AFuF++krMMjFJZXm0EO6B+7SbL1uHxbq/EhCsotLm/SoTJx1rdb8f6Oa
	T5DyBNbWHM8RpTVjW2mj5eCA8rq4DSMYbqxWvSPIxnflo1+HTFWfGZgvM8pyGw3iMxrF4ZpyhMd
	FdbiwYcsthUBSMVfcZu0unnxrKVYcu1JkNtV8izX+MSM7gRStpi421uDr1dsWmKuSQCHkSr41we
	Uw7/81S9ScsUEnG48W5JyIoVk3PLIW68SZcu1BXAvjqVekphy5gxfhBOdVpwfRBP7sqw8lT/jrN
	6UlW9VeElS1A2NUeto=
X-Gm-Gg: AYBFou0yTGn4ycv0czKgwrhRpEW4gRn1aEvBjWDPX0/LAn0zzvNGWR2zU9xrwC+pPPr
	8qyLm7vJLbBUMD0i/otbz3fCGSjrYEhUUBOW1vgmX1ZbF9OPGF8/LBWu9Af+b3X7Ls/2BvFEscT
	GRMbCI7qTzp1o2hExyow/xG9eJg8tAOJdhqggeJ3sWQPYt+1sST+p91ZWCpjxurgQceitvIwXIe
	TyY4lV1A32adCLVVTdBdkcl8R+NTWi5GdeLresd+tthNrZKxDekxxmbap/zc+Cj/teGOOQ68vW8
	To1qEws0QG6xlbISPQIpZEcrflXXmDzJ9yG3TU9AJEDD8+118Aslsj/bCVut9ZcQMnRrnI32+A5
	qzMZcSK3ZQ0p69lJDXfTQJ4b7Dz9/obP8oB5n/uGJVhsMJ+xXkznEnVH/KBISWckSoAj50EQ6RH
	ey1Bj65S5q0W2qkP85irS4aSQFPd44UTjVCNQ=
X-Received: by 2002:a17:90b:528e:b0:38e:ad9d:1161 with SMTP id 98e67ed59e1d1-39b25ee67f0mr46233835a91.0.1788890848989;
        Tue, 08 Sep 2026 11:07:28 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-125.dlp.protect.broadcom.com. [144.49.247.125])
        by smtp-relay.gmail.com with ESMTPS id 98e67ed59e1d1-39b1600a403sm10364106a91.4.2026.09.08.11.07.28
        for <virtualization@lists.linux.dev>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 08 Sep 2026 11:07:28 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-yx1-f70.google.com with SMTP id 956f58d0204a3-66c73057f18so3394754d50.3
        for <virtualization@lists.linux.dev>; Tue, 08 Sep 2026 11:07:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1788890847; x=1789495647; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=r+VLJNR2ClH5aaw8GL8jeSbQjtC7qAwKNhxP9YK5biY=;
        b=PDKRb2JZp+mBCwJP5hG9VoA51FrI2QKEQlDDaZNC12cIjrOfD0z3R0zXBQHW90PkqK
         HUBosZ2JL07jsXTkXw4xV5GzVu+aZh7XsOdbU7shZvuHjBQjPWbIxsYmhhcTdL75FY79
         odSxvLO5yamFJLP/jRU00YxbOuzUEh9uvJd+Y=
X-Forwarded-Encrypted: i=1; AKwUvBy3Q7DdZYsaPcaYSV2ZbkUMTI2RZfoVunSPdcxtDrxvCu5j3o7FFKMcq/6y2X5PQ5ruf5h44LYKsUlOGxmfFQ==@lists.linux.dev
X-Received: by 2002:a53:e8c5:0:b0:66f:c1be:84d8 with SMTP id 956f58d0204a3-66fc1be866cmr7220597d50.70.1788890847325;
        Tue, 08 Sep 2026 11:07:27 -0700 (PDT)
X-Received: by 2002:a53:e8c5:0:b0:66f:c1be:84d8 with SMTP id 956f58d0204a3-66fc1be866cmr7220569d50.70.1788890846854;
        Tue, 08 Sep 2026 11:07:26 -0700 (PDT)
Received: from vertex.localdomain (pool-173-49-113-140.phlapa.fios.verizon.net. [173.49.113.140])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-9106412e038sm27114866d6.20.2026.09.08.11.07.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Sep 2026 11:07:25 -0700 (PDT)
From: Zack Rusin <zack.rusin@broadcom.com>
To: Borislav Petkov <bp@alien8.de>,
	Ajay Kaher <ajay.kaher@broadcom.com>,
	Alexey Makhalov <alexey.makhalov@broadcom.com>,
	x86@kernel.org,
	Petr Mladek <pmladek@suse.com>,
	Joel Granados <joel.granados@kernel.org>,
	Baoquan He <baoquan.he@linux.dev>
Cc: Thomas Gleixner <tglx@kernel.org>,
	Ingo Molnar <mingo@redhat.com>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	"H . Peter Anvin" <hpa@zytor.com>,
	virtualization@lists.linux.dev,
	bcm-kernel-feedback-list@broadcom.com,
	linux-kernel@vger.kernel.org,
	John Ogness <john.ogness@linutronix.de>,
	Steven Rostedt <rostedt@goodmis.org>,
	Sergey Senozhatsky <senozhatsky@chromium.org>,
	Kees Cook <kees@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Mike Rapoport <rppt@kernel.org>,
	Pasha Tatashin <pasha.tatashin@soleen.com>,
	Pratyush Yadav <pratyush@kernel.org>,
	Dave Young <ruirui.yang@linux.dev>,
	Jonathan Corbet <corbet@lwn.net>,
	Bo Gan <bo.gan@broadcom.com>,
	Brennan Lamoreaux <brennan.lamoreaux@broadcom.com>,
	kexec@lists.infradead.org,
	linux-doc@vger.kernel.org,
	Zack Rusin <zack.rusin@broadcom.com>
Subject: [PATCH v1 0/4] x86/vmware: Preserve panic diagnostics in vmware.log
Date: Tue,  8 Sep 2026 14:07:12 -0400
Message-ID: <cover.1788414671.git.zack.rusin@broadcom.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e

A virtual machine may have neither guest-local persistent storage nor
working userspace after a panic. The host's vmware.log remains available
after the VM terminates, and a production encrypted guest is the only
component able to export readable panic text. Hyper-V already provides
this class of host-persistent panic reporting.

Add a panic-only VMware logger that copies the newest 4 KiB of the kernel
log and sends it with bounded low-bandwidth RPC work. Ordinary guests
enable text transfer by default; encrypted guests require an administrator
to opt in through kernel.vmware_record_panic_msg. A separate late dumper
reports the structured crash event after built-in dumpers and suppresses
the event while a crash kernel is loaded, because a configured VMware host
may terminate the VM before the reporting hypercall returns.

Patch 4 makes panic diagnostics run before kdump by default on VMware
guests. This follows existing platform uses of
crash_kexec_post_notifiers, with Hyper-V as the closest guest-reporting
precedent. Unlike Hyper-V, VMware exposes no capability bit for this
behavior. An explicit crash_kexec_post_notifiers=0 still wins, and patch 4
can be dropped without affecting patches 1 through 3.

This replaces patches 2 and 3 of Alexey's v2 posting:
https://lore.kernel.org/all/20260309235250.2611115-1-alexey.makhalov@broadcom.com/

The intended merge path is tip's x86/vmware branch. Boris please review the
VMware transport and policy. Petr and John, please review the panic-only
dumper use and registration ordering. Joel and Kees, please review the
sysctl. Baoquan and the KEXEC/KDUMP team, please review the 
loaded-crash-kernel guard and the default in patch 4.

Zack Rusin (4):
  x86/vmware: Add a bounded panic log sender
  x86/vmware: Add the vmware_record_panic_msg sysctl
  x86/vmware: Report guest crashes after kmsg dumpers
  x86/vmware: Run panic diagnostics before kdump by default

 Documentation/admin-guide/sysctl/kernel.rst |  14 ++
 arch/x86/include/asm/vmware.h               |   2 +
 arch/x86/kernel/cpu/vmware.c                | 245 ++++++++++++++++++++
 3 files changed, 261 insertions(+)


base-commit: cee9395acd8043be0644b25c34bfa86623f2b935
-- 
2.53.0

