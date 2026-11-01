Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793571434;
	b=Zn2WMrfdR7uoDG6cdtg43Q/EwHQr3KNkAcoDEG0zfj8rLIChQmbkxcZs+Kuyi7pM3ouw
	 54qW5TkWxM2bjSr3MS4N9v/I5NkJVfzWAbPf/Jj9y/98bkOuMieuzVxmHi22KYhIjr1UN
	 GTLUAEjfbIyExKF1zxj+jjA1yzU9ALWDcn+a0kp3uogsRh29zJYZ2KxyWvM4f2JSHr2PK
	 qv0P+E/UrSz/fizrWIOfAuSoSK97zpEYWcYDCOJ25lcBx6UtHne32E7rmpKHU5rzXdTuG
	 TULyTPDl1MC0EmK8jNxL5rARM+FxUF89AnpcMSjjK4tXh7KOl+lkUdlm1zAfTKgpxUA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793571434;
	h=Received:DKIM-Signature:Received:Content-Type:MIME-Version:
	 Content-Transfer-Encoding:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc;
	bh=cjatygCmxk8XIyEbtr4pyzKJ6E60G4Tfi3euF78nVXA=;
	b=PJYFLGwy40sd5ZZg5KfKibhhzNoZ+CkH1Wt4VFtSCF3yj8Dfe+qL6Y2KQt9KeSyNQ60T
	 yT+d8ri1iDLVjVrn4FhFVv9+vH4eAzyefY4AqhMID6vIvqQoxGStPtKpFReLDOFJs8yO9
	 limKCWjRtleFq1dR79l6FGN5sizV7V8sCp3ALp+6/xtTsOOJc+uqR9gC1TQat5XxeIA0P
	 QGMPQm3KaThB9d52/hVtt+VkKr/vk6K5mvrSXclwLfIG9MQtIvLx43DfuP31tYQNzUIQS
	 x6vyBPiABzZqzoTZtfnMJD/BzhnEZAffeijNZxp1RVMfPU5XjIHIBDPcypnx3dNRs/g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=B37CRQpc;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75D13606F2CD;
	Sun,  1 Nov 2026 22:17:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=B37CRQpc
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4AF4C1F0093A;
	Sun,  1 Nov 2026 22:17:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793571434;
	bh=cjatygCmxk8XIyEbtr4pyzKJ6E60G4Tfi3euF78nVXA=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=B37CRQpcdmmwCy32vZHgPCWMyUptn49raCX3hJZVcxsEUYOsqHqKCUFeSZMmdrHar
	 P973m1II/ofRE5pnWqeiZvqWMGVRqsLIUP1n1XIX0nFBkKS0IRka2D7KopquB77g6O
	 Mp/unwfBnH0l1eqg07ua7p0Vs/LC2MTS3vGGD6h6owSUEaRNT6q1AXW/x5xBnzEQnc
	 EmKj7qUuyXmc8mBTkvUCHpgFrpk8n5Uq59fpbStEBh5xRF1iBXEyBMchINku/sQN+X
	 GTmMdu6UOejRm4ya75HKvjJSDVBqFLUssCE8lSC7D/wzZYaWR0EmUh/OpuxZjzWe5k
	 ui1FC15h7AaNQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 403AC38003B8;
	Sun,  1 Nov 2026 22:17:14 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
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
Subject: Re: [PATCH RESEND] sched: Convert paravirt_steal to new static key
 APIs
From: patchwork-bot+linux-riscv@kernel.org
Message-Id: 
 <179357143279.2624073.7781801497885838332.git-patchwork-notify@kernel.org>
Date: Sun, 01 Nov 2026 22:17:12 +0000
References: <20260819081207.12150-1-hongyan.xia@transsion.com>
In-Reply-To: <20260819081207.12150-1-hongyan.xia@transsion.com>
To: Hongyan Xia <hongyan.xia@transsion.com>
Cc: linux-riscv@lists.infradead.org, jgross@suse.com, ajay.kaher@broadcom.com,
 alexey.makhalov@broadcom.com, bcm-kernel-feedback-list@broadcom.com,
 catalin.marinas@arm.com, will@kernel.org, chenhuacai@kernel.org,
 kernel@xen0n.name, maddy@linux.ibm.com, mpe@ellerman.id.au,
 npiggin@gmail.com, chleroy@kernel.org, pjw@kernel.org, palmer@dabbelt.com,
 aou@eecs.berkeley.edu, alex@ghiti.fr, tglx@kernel.org, mingo@redhat.com,
 bp@alien8.de, dave.hansen@linux.intel.com, x86@kernel.org, hpa@zytor.com,
 pbonzini@redhat.com, vkuznets@redhat.com, sstabellini@kernel.org,
 oleksandr_tyshchenko@epam.com, peterz@infradead.org, juri.lelli@redhat.com,
 vincent.guittot@linaro.org, dietmar.eggemann@arm.com, rostedt@goodmis.org,
 bsegall@google.com, mgorman@suse.de, vschneid@redhat.com,
 kprateek.nayak@amd.com, jiazi.li@transsion.com,
 virtualization@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org, loongarch@lists.linux.dev,
 linuxppc-dev@lists.ozlabs.org, kvm@vger.kernel.org,
 xen-devel@lists.xenproject.org

Hello:

This patch was applied to riscv/linux.git (fixes)
by Peter Zijlstra <peterz@infradead.org>:

On Wed, 19 Aug 2026 08:12:09 +0000 you wrote:
> From: Hongyan Xia <hongyan.xia@transsion.com>
> 
> paravirt_steal_rq_enabled and paravirt_steal_enabled use raw static_key
> APIs which are now deprecated. Use the new API instead.
> 
> No functional change.
> 
> [...]

Here is the summary with links:
  - [RESEND] sched: Convert paravirt_steal to new static key APIs
    https://git.kernel.org/riscv/c/a5576ebce920

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


