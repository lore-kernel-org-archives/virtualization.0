Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98893204C26
	for <virtualization@lists.linux-foundation.org>; Wed, 11 Dec 2024 22:32:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.138
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733956369; cv=none; b=gJLX2QpkV8OOW/3Xx0nUyRkpK1yZvdX6Kg2ym9s12bQlC+sK4/akRHYCwmYhaQJQeC6Gf6bFr/CsgoRTShUBKMJD6QcXStDpz+H41q5UFa8vseimGVc+xNnQIslOkyqBPgmLpJQAigaq9HESwrNkFnuVmhaVb8u+rJlcZrVjj7U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733956369; c=relaxed/simple;
	bh=iRwxC1s0tO/FMsHuvL9jXdyPxujIqKEggAX45W0Slqk=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=eenfn75wUCqfiJ/m4jvpbMmB1oDh4a937ZozhKnEo99HAE9+2YBkKGzHTTbnpgZ7zgbv8+kA+qX49wMqhUkxR+pQIzG4BPrAK4Fcld0ymkNEYXdvtC0+ksLCDtNRRu5GbUGDP0varkDum5r/zEiSrCL9k/RIfiTcq1bZ606ddoE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gXv2yfYI; arc=none smtp.client-ip=140.211.166.138
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gXv2yfYI"
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 3D14B81321
	for <virtualization@lists.linux-foundation.org>; Wed, 11 Dec 2024 22:32:47 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -4.401
X-Spam-Level:
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id o_pAsCbvlSsM for <virtualization@lists.linux-foundation.org>;
 Wed, 11 Dec 2024 22:32:46 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2604:1380:4641:c500::1; helo=dfw.source.kernel.org; envelope-from=patchwork-bot+linux-riscv@kernel.org; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp1.osuosl.org 4E57781328
Authentication-Results: smtp1.osuosl.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 4E57781328
Authentication-Results: smtp1.osuosl.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=gXv2yfYI
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 4E57781328
	for <virtualization@lists.linux-foundation.org>; Wed, 11 Dec 2024 22:32:46 +0000 (UTC)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by dfw.source.kernel.org (Postfix) with ESMTP id 86A155C67F5;
	Wed, 11 Dec 2024 22:32:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A5D83C4CED3;
	Wed, 11 Dec 2024 22:32:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733956364;
	bh=iRwxC1s0tO/FMsHuvL9jXdyPxujIqKEggAX45W0Slqk=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=gXv2yfYI3u6DpqV1QgWdlFHngfCsoqTqn8qFlW9vmxnxqkmi2e0lXapKqCP1xq6Sq
	 m27jAoArETLE59h3MnbPfeV3Du7pXd51diP7+E1kuOCkhI7BhHN3DecsGyqg69HYCz
	 4dtnfhgmCNmsRYRIPBaEYy8l1+tEE1pvCJwTuJ6jZQE2vL5C5Y4TlG7IFgF7jCU0ML
	 EPY3X047UtqYUWAN70PGlmC02VnScPkoy5P16UdK6QQNkRg9BsWNI2Pw7GnLtv9JBW
	 l0EMIp8cQD51ifM8V58DpUd37Lm02CBpfUmo+wcLANw+3geztRTyBkXlx98+9U2bsW
	 EaiC7JsiZtyNQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EBAA4380A965;
	Wed, 11 Dec 2024 22:33:01 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH fixes] riscv: mm: Do not call pmd dtor on vmemmap page table
 teardown
From: patchwork-bot+linux-riscv@kernel.org
Message-Id: 
 <173395638049.1729195.5190256802330820237.git-patchwork-notify@kernel.org>
Date: Wed, 11 Dec 2024 22:33:00 +0000
References: <20241120131203.1859787-1-bjorn@kernel.org>
In-Reply-To: <20241120131203.1859787-1-bjorn@kernel.org>
To: =?utf-8?b?QmrDtnJuIFTDtnBlbCA8Ympvcm5Aa2VybmVsLm9yZz4=?=@aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org
Cc: linux-riscv@lists.infradead.org, alexghiti@rivosinc.com,
 aou@eecs.berkeley.edu, david@redhat.com, palmer@dabbelt.com,
 paul.walmsley@sifive.com, osalvador@suse.de, bjorn@rivosinc.com,
 abrestic@rivosinc.com, linux-kernel@vger.kernel.org, linux-mm@kvack.org,
 virtualization@lists.linux-foundation.org

Hello:

This patch was applied to riscv/linux.git (fixes)
by Palmer Dabbelt <palmer@rivosinc.com>:

On Wed, 20 Nov 2024 14:12:02 +0100 you wrote:
> From: Björn Töpel <bjorn@rivosinc.com>
> 
> The vmemmap's, which is used for RV64 with SPARSEMEM_VMEMMAP, page
> tables are populated using pmd (page middle directory) hugetables.
> However, the pmd allocation is not using the generic mechanism used by
> the VMA code (e.g. pmd_alloc()), or the RISC-V specific
> create_pgd_mapping()/alloc_pmd_late(). Instead, the vmemmap page table
> code allocates a page, and calls vmemmap_set_pmd(). This results in
> that the pmd ctor is *not* called, nor would it make sense to do so.
> 
> [...]

Here is the summary with links:
  - [fixes] riscv: mm: Do not call pmd dtor on vmemmap page table teardown
    https://git.kernel.org/riscv/c/21f1b85c8912

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


