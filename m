Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFFCC171B2
	for <virtualization@lists.linux-foundation.org>; Sat, 20 Jan 2024 21:09:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705784999; cv=none; b=gQiddGYAhAmLpsmYCk+IiO71mj2ttnB1tETitXiQntXZwPPuB4ycq0EJFwsJVgnN+poFCO89sAIgETILw6vUL9kH5gyq9fYdQUJBqz5X6qwNnWbuv/Xp/yQ2sVKyBdOVDNcNx8ui6a2xEa4QshAXYSnuKhWtsGrcRSGvaZSjx98=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705784999; c=relaxed/simple;
	bh=g34/xJKX2jsxi0amyi4X5bqKFQE7wPjdskyTTdrZlQ8=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=kiMqtrolQ8g/us01EMkIOyw+fnpb5Tno4snnn+/dbV93qNG/jFDdZwdgQa8Gc1f7/JQyhxZDkLAy0h0aCBvF7ggO976Rj6lzhwneBbj58XzmIpz+yfs+0PpsbSMQBbkH5I6TuqKT0FroEnE5c/RHAmMSDVrP28DyHKOn6eb95l8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NTP/xeCr; arc=none smtp.client-ip=140.211.166.133
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NTP/xeCr"
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 2DD224027F
	for <virtualization@lists.linux-foundation.org>; Sat, 20 Jan 2024 21:09:58 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 2DD224027F
Authentication-Results: smtp2.osuosl.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=NTP/xeCr
X-Virus-Scanned: amavisd-new at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -7.101
X-Spam-Level:
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id d4uv5AfRrBd3
	for <virtualization@lists.linux-foundation.org>;
	Sat, 20 Jan 2024 21:09:57 +0000 (UTC)
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
	by smtp2.osuosl.org (Postfix) with ESMTPS id C86E84013F
	for <virtualization@lists.linux-foundation.org>; Sat, 20 Jan 2024 21:09:56 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org C86E84013F
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by dfw.source.kernel.org (Postfix) with ESMTP id 84F9960C28;
	Sat, 20 Jan 2024 21:09:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 4E313C433F1;
	Sat, 20 Jan 2024 21:09:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705784995;
	bh=g34/xJKX2jsxi0amyi4X5bqKFQE7wPjdskyTTdrZlQ8=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=NTP/xeCrPIQp9brjrnROcvMyiFSb/O3sc9moYMvDrgNJhInVzGjJtzc7Ugu9CGIY5
	 DJ+4wgZAxaojyAMMvDF0etxc9iyZkMI71uERD4LvcDlSNKPiw5cmlns4mE3VtqtIO3
	 MG7yQdLkbY4ZR/ZhbInuSzcmqB3p17uoecap2YjHKmTXapmdrbXVAiPfUGT+02DIrP
	 fZaYV/Sc9yVXs4DGwrmycDO8AVqsiw1keg18A43p0Q6PGRsStYh53yhGACqZBWdL5z
	 H/A/uIPA1idOGJHVyJ7xVoxWyPndle2EFHCxdSRZpB07RgVtGqduALQtsaXzAYJ72i
	 5szhiu6AEq4bw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 3D6D3D8C96C;
	Sat, 20 Jan 2024 21:09:55 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v4 00/13] RISC-V: Add steal-time support
From: patchwork-bot+linux-riscv@kernel.org
Message-Id: 
 <170578499524.24348.16462593200054070695.git-patchwork-notify@kernel.org>
Date: Sat, 20 Jan 2024 21:09:55 +0000
References: <20231220160012.40184-15-ajones@ventanamicro.com>
In-Reply-To: <20231220160012.40184-15-ajones@ventanamicro.com>
To: Andrew Jones <ajones@ventanamicro.com>
Cc: linux-riscv@lists.infradead.org, kvm-riscv@lists.infradead.org,
 virtualization@lists.linux-foundation.org, anup@brainfault.org,
 atishp@atishpatra.org, pbonzini@redhat.com, paul.walmsley@sifive.com,
 palmer@dabbelt.com, aou@eecs.berkeley.edu, jgross@suse.com,
 srivatsa@csail.mit.edu, guoren@kernel.org, conor.dooley@microchip.com

Hello:

This series was applied to riscv/linux.git (fixes)
by Anup Patel <anup@brainfault.org>:

On Wed, 20 Dec 2023 17:00:13 +0100 you wrote:
> One frequently touted benefit of virtualization is the ability to
> consolidate machines, increasing resource utilization.  It may even be
> desirable to overcommit, at the risk of one or more VCPUs having to wait.
> Hypervisors which have interfaces for guests to retrieve the amount of
> time each VCPU had to wait give observers within the guests ways to
> account for less progress than would otherwise be expected. The SBI STA
> extension[1] provides a standard interface for guest VCPUs to retrieve
> the amount of time "stolen".
> 
> [...]

Here is the summary with links:
  - [v4,01/13] RISC-V: paravirt: Add skeleton for pv-time support
    (no matching commit)
  - [v4,02/13] RISC-V: Add SBI STA extension definitions
    https://git.kernel.org/riscv/c/6cfc624576a6
  - [v4,03/13] RISC-V: paravirt: Implement steal-time support
    (no matching commit)
  - [v4,04/13] RISC-V: KVM: Add SBI STA extension skeleton
    (no matching commit)
  - [v4,05/13] RISC-V: KVM: Add steal-update vcpu request
    (no matching commit)
  - [v4,06/13] RISC-V: KVM: Add SBI STA info to vcpu_arch
    (no matching commit)
  - [v4,07/13] RISC-V: KVM: Add support for SBI extension registers
    (no matching commit)
  - [v4,08/13] RISC-V: KVM: Add support for SBI STA registers
    (no matching commit)
  - [v4,09/13] RISC-V: KVM: Implement SBI STA extension
    (no matching commit)
  - [v4,10/13] RISC-V: KVM: selftests: Move sbi_ecall to processor.c
    (no matching commit)
  - [v4,11/13] RISC-V: KVM: selftests: Add guest_sbi_probe_extension
    (no matching commit)
  - [v4,12/13] RISC-V: KVM: selftests: Add steal_time test support
    (no matching commit)
  - [v4,13/13] RISC-V: KVM: selftests: Add get-reg-list test for STA registers
    (no matching commit)

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


