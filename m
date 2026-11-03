Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.215.227
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793690444;
	b=0xEGfP/JVTvcgWmwlmlKspfJyUjdrDHlpE4aeWlbqBfGdjzu+tGnwgtVN1Ay0oFrraY4
	 gAZ1IPx3RxqZLmVFOBBleXNYx7Q/qwQVgoglQK8EQls6t72UGsNt5LWk21kwcjhWsQ8zJ
	 SsBI63bt+8QLSTpCJx8GQ8TuKjpT4D8QI7+UPBl0rh0PTFSL8kTDAh3CYjdblFeN076rF
	 E3uq0zZ4PRWwy3MDWoGacGokCg68s+rJHvBcFTbyklcsIpsQjgUWoVxuOKjpnFmSWg+mH
	 1rbFzSP7mK5qVl6BX0RbQZQ0nxxvXoZHnLI0pLI5STvFWnwyultPsBdnKTtvEvrtdrg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793690444;
	h=DMARC-Filter:Received:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:X-Relaying-Domain:
	 X-CFilter-Loop:Received:DKIM-Signature:X-Forwarded-Encrypted:
	 X-Received:X-Received:Received:From:To:Cc:Subject:Date:Message-ID:
	 X-Mailer:MIME-Version:Content-Transfer-Encoding:
	 X-DetectorID-Processed;
	bh=nQGxanT95z7gj11pozst1Dv+dzrh+mNFxgMJ/FgtyKo=;
	b=XTzQFoWi6/eHFy+CZDXn55slIqA8t4LHa6MtAkoFQK0sKzK6f7Q1bg9EpV6oVSEWYZpz
	 iJlRH0y8FKlgfC90J4exGtvopdQwtJZBU8zwXDYdEExYY1a6IaepOMZdKc+Y5EA6ZCnI3
	 BBGm1fS32rAHh0TjAVHVVpxDXZWzy4a/1HXP0SoqGn+6yUe1gbMuI6RNu6Sz47vEdELjV
	 vA1z1PIBjm4GGz8lubsY8Khj8jlHFA1zBe9zfdUqKHxIfMtUwD91XzUhfT65hD60RyxIU
	 +jXShgr+jtewZjEEGaNm7z61YO2i6OHrqTYz+d7g+JG/p50AadPRQLgHcgVmyXD+IqA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=broadcom.com;
	spf=fail smtp.mailfrom=broadcom.com;
	dkim=pass header.d=broadcom.com header.i=@broadcom.com header.a=rsa-sha256 header.s=google header.b=R1wkrrFV;
	arc=none smtp.remote-ip=209.85.215.227
Received: from mail-pg1-f227.google.com (mail-pg1-f227.google.com [209.85.215.227])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86CA6606A324
	for <virtualization@lists.linux.dev>; Tue,  3 Nov 2026 07:20:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 86CA6606A324
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=broadcom.com header.i=@broadcom.com header.a=rsa-sha256 header.s=google header.b=R1wkrrFV
Received: by mail-pg1-f227.google.com with SMTP id 41be03b00d2f7-cdaefe02d5dso2057882a12.1
        for <virtualization@lists.linux.dev>; Mon, 02 Nov 2026 23:20:44 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793690444; x=1794295244;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:dkim-signature:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=nQGxanT95z7gj11pozst1Dv+dzrh+mNFxgMJ/FgtyKo=;
        b=27nXgLxhLzVcW+3vHZep2CLsRagAH5aAMOdB/ydD5SmTuNWz81Dqx8NU6WAwPxk1ps
         Lhb5o7t9O+J25V307JRc2heqGBwdq+pK3hS5ei7EhHzpGWAN2LxxhQJ51RubZtKKGydQ
         hfmG6MkCQihbvNJBCHWCy94z7zxy/wUPf4b7LHSW+Po8LhqwYUKFnI90V0LULx59gj/n
         SaO76/7vDRe5RO7aICA74hZy1vgrMAOWiBIeoVOK+gJRmO6DQWQJZC1/9SdeMc8u+ZZm
         zhlWtCxslMOisnTA56Ft2m4jiq0mxggNEthLluUlhed5R4z8e/DJHiC7MHu0xPZLn8j/
         peWA==
X-Forwarded-Encrypted: i=1; AKwUvBwxBt9CKBp+XdiCh2qTasgHMSfiBpsr+xke73dwHKBxpHjKkVNfSuYo7RMCIBObXz4+c3kb8mD2oHR5czk9ug==@lists.linux.dev
X-Gm-Message-State: APuU4Z94rCN/bkfq/rvfsrBLUrkQ5evSKkrsuuDsVcaoyHrVdwB560G7
	6PyZINszyTMnEHJBRmt126YejXIrGaZtF8lFVpo069mx/B1cLSISsr+4vVgayYYywDY5jYbLWTM
	V8CiSJJbuOmbzTVDLarLwwvWDa0DzChlFIR/OtHGr6Yp7xTqA2ziDbN+X1GuF3984mO6urdcQfW
	ulaefvgCFL7kbmplcijpaUdv/RCqtngBSUk8YjI2z8ysr+9yoOLj0Gg0o25HgQdZs+VDMYxw6+D
	OhmpFz8CzA1ocShZmo=
X-Gm-Gg: AYBFou1TIM/xHEXyxFaaSu6X/HNOmYw8GOKEKJc0cq7ucrYG3ni3BrMfjbDmV+oQ2NQ
	B/3FghZHaLgGBJ3YtdDwPmcrF0M8dDLO3VTDoAxJhEeSRJoNACqbcPBysX7aamL0eCTwHP7Bukk
	iBEBopYa53DB61CpiPOiVxxumJ0Un08gsJGDGgG1TfJ9f3zaa3lx+PWH7gmrZBeWBFMIfvv+o7U
	YIKgNOB3ocwgHdT44eTqkzdgePLlqe78FBXK6oO/oAmu8sYwCLP9cj/ydg8zHHdlh3aw1DwBSTu
	lRt4+vdtGh1fgSaFROJGehQrIqU72vEsPI+dv1FTp2AHeude7O9YpfTk8AdEMWQ8iywrdWVPDJ1
	tR9pN5Dy154o8JrriBWN2IK7tv0coatYzbeolUPzpfEPOHbcROp9lFII57/+AqoJxcBejMWfGF2
	mNIxdZofxSJJLljhJ+IzHIvsDY+YjT6uxE
X-Received: by 2002:a17:90b:448c:b0:3ac:a7ee:6766 with SMTP id 98e67ed59e1d1-3ae8980ed36mr10175337a91.36.1793690443763;
        Mon, 02 Nov 2026 23:20:43 -0800 (PST)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-13.dlp.protect.broadcom.com. [144.49.247.13])
        by smtp-relay.gmail.com with ESMTPS id 98e67ed59e1d1-3ae881b1b69sm3205927a91.4.2026.11.02.23.20.43
        for <virtualization@lists.linux.dev>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 02 Nov 2026 23:20:43 -0800 (PST)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-qt1-f197.google.com with SMTP id d75a77b69052e-542fc619afaso43787711cf.2
        for <virtualization@lists.linux.dev>; Mon, 02 Nov 2026 23:20:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1793690442; x=1794295242; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=nQGxanT95z7gj11pozst1Dv+dzrh+mNFxgMJ/FgtyKo=;
        b=R1wkrrFVEidRGzr0n+7hgFrvB0JxmXrcwMkILF9EkcflxhfqxnaflZMnZyW1qLsruc
         zcrv9dsyeuc/ZMIXBYyMzmCyuNhpB3Yu9h39epIbDA229bY/LYervTeiiMwsk9cuZ+2I
         KhQLj2f67Od7QpoBizG5QX4doGZgmxzpHTdJo=
X-Forwarded-Encrypted: i=1; AKwUvBwL8ABEKsWAeQrNEHXucCIOP9A5K2gj0JttPEObuf0CE5drxbxK7k5v2wz6w993/vEyH2t81IFwaCpfPGMIAA==@lists.linux.dev
X-Received: by 2002:ac8:5a86:0:b0:535:a5fa:edff with SMTP id d75a77b69052e-542b7c08be6mr197741081cf.63.1793690442089;
        Mon, 02 Nov 2026 23:20:42 -0800 (PST)
X-Received: by 2002:ac8:5a86:0:b0:535:a5fa:edff with SMTP id d75a77b69052e-542b7c08be6mr197740811cf.63.1793690441651;
        Mon, 02 Nov 2026 23:20:41 -0800 (PST)
Received: from vertex.localdomain ([192.19.218.250])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-5498c379989sm18885491cf.19.2026.11.02.23.20.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Nov 2026 23:20:40 -0800 (PST)
From: Zack Rusin <zack.rusin@broadcom.com>
To: Borislav Petkov <bp@alien8.de>,
	x86@kernel.org,
	Ajay Kaher <ajay.kaher@broadcom.com>,
	Alexey Makhalov <alexey.makhalov@broadcom.com>
Cc: Kiryl Shutsemau <kas@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Thomas Gleixner <tglx@kernel.org>,
	Ingo Molnar <mingo@redhat.com>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	"H. Peter Anvin" <hpa@zytor.com>,
	Tom Lendacky <thomas.lendacky@amd.com>,
	Rick Edgecombe <rick.p.edgecombe@intel.com>,
	Bo Gan <bo.gan@broadcom.com>,
	Paolo Bonzini <pbonzini@redhat.com>,
	Vitaly Kuznetsov <vkuznets@redhat.com>,
	virtualization@lists.linux.dev,
	linux-coco@lists.linux.dev,
	bcm-kernel-feedback-list@broadcom.com,
	linux-kernel@vger.kernel.org
Subject: [PATCH v3 0/1] x86/vmware: Share steal-time counters in encrypted guests
Date: Tue,  3 Nov 2026 02:20:33 -0500
Message-ID: <cover.1792471114.git.zack.rusin@broadcom.com>
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

Steal time is the time a virtual CPU was ready to run but waited for the
host to schedule it. For example, in a 100 ms interval a vCPU might run
for 70 ms and wait 30 ms for a physical CPU. Reporting those 30 ms lets
Linux:
- account CPU usage accurately, without charging applications for time
  their vCPU wasn't running;
- base scheduling decisions on the CPU time tasks actually received;
- show host contention in the "st" column of top and vmstat and in
  /proc/stat.

VMware writes a running total into a small per-CPU buffer in guest
memory, and Linux reads it. In a confidential guest (AMD SEV-SNP, Intel
TDX) memory is private by default and the host cannot write it, so the
guest has to share the buffer first. Linux currently registers the
buffer without sharing it, and ESXi then powers off the VM. This only
affects VMs with the steal clock enabled, which ESXi enables by default
only for Photon guests.

Following the v2 discussion, this version uses one packed allocation for
all possible CPUs' counters and shares it before registering any address.
Setup moves to an early initcall so it can use the normal memory-conversion
API. This avoids converting a page in every CPU's per-CPU area and
concentrates sharing in one allocation.

Changes since v2:
- Replace the six infrastructure patches with one VMware-only fix.
- Leave the per-CPU allocator, linker, KVM and early conversion code alone.
- Move ordinary-guest setup to the same initcall.
- Rebase onto v7.3.

Tested on ordinary VMware x86-64 SMP/UP guests, ESXi SEV-SNP and TDX
guests (SMP, UP, 66 vCPUs and percpu_alloc=page), and QEMU/KVM x86-64
guests.

v2: https://lore.kernel.org/r/20260929040256.543767-1-zack.rusin@broadcom.com

Zack Rusin (1):
  x86/vmware: Allocate shared storage for steal-time counters

 arch/x86/kernel/cpu/vmware.c | 130 +++++++++++++++++++++++------------
 1 file changed, 86 insertions(+), 44 deletions(-)


base-commit: c03c1a14507dfaf8b856c2608f9ac216021fc222
