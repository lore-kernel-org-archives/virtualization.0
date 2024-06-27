Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A016719E7DC
	for <virtualization@lists.linux-foundation.org>; Thu, 27 Jun 2024 17:50:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.137
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719510660; cv=none; b=nZOeSXDjYfgJx29N3sxe7Oaunfvt9H4Rq+nQE3Ha4BsHEQMLGwyUws/nhHGwd7tD1dKFfdGQiYfwNQz6rPhZ9uJQj9WTkzMCeDqaofqPl8tf4BFLVnS6OSesLGGoKM42JoHgqV9ddLAQMDlfdECEoKXb8YVZvAsZ9RFkexqOxjo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719510660; c=relaxed/simple;
	bh=FhBU8A5+Q8J0OeOT+PjkesYLZH9n5p6zVNLOC80zmBw=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=txPyf+bkjlgD+BLQXnfeXs9yEgwl/eUgKVwN/zpZYfMYzB4yLBANxOMvSwR3B59e/HP3xAHiNe3IDBwQcYqHA3OU/Yq2N4qn9dTZ5Stq9y6UBIK7ifhJO/hZ74gbzRVePLmBQ91mM6vU2IyuArRp39Bc5RRb/F2IoNDOpQlWS+Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CYAi0p2Z; arc=none smtp.client-ip=140.211.166.137
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CYAi0p2Z"
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 4BED0416B5
	for <virtualization@lists.linux-foundation.org>; Thu, 27 Jun 2024 17:50:59 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -7.101
X-Spam-Level:
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id WLrVY6MPCPe7 for <virtualization@lists.linux-foundation.org>;
 Thu, 27 Jun 2024 17:50:58 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=139.178.84.217; helo=dfw.source.kernel.org; envelope-from=patchwork-bot+linux-riscv@kernel.org; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp4.osuosl.org 2A8DE416AB
Authentication-Results: smtp4.osuosl.org; dmarc=pass (p=none dis=none) header.from=kernel.org
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 2A8DE416AB
Authentication-Results: smtp4.osuosl.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=CYAi0p2Z
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 2A8DE416AB
	for <virtualization@lists.linux-foundation.org>; Thu, 27 Jun 2024 17:50:58 +0000 (UTC)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by dfw.source.kernel.org (Postfix) with ESMTP id D15C061F6D;
	Thu, 27 Jun 2024 17:50:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 6C44CC4AF07;
	Thu, 27 Jun 2024 17:50:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719510656;
	bh=FhBU8A5+Q8J0OeOT+PjkesYLZH9n5p6zVNLOC80zmBw=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=CYAi0p2ZyCgc3Y/ccqYLug+F9ztYsbxWr9w6tr695saFcQn6YidUwXIq9K0ak9EJs
	 sk1lKUr5cTZvu27kL+fNxzb5Qy9/QclYZW3qiXhDFBS3YEgSgzOrPnXlnxeBrofhP2
	 at+jqHsN682VCLNaiPv3cQvb2ugk6DRlkH/0ceAOjETSb85P5DKXJUP3cGqpMTYXir
	 +ETVxwIBD5O16Ve54x/LvN5tBB6xToPZyGosRt4nz+/Wah2fD5Fl1L8I1/ZQTEnEKe
	 HzMCD9GQzDfNOZvkt3T+TosAQEGCbpNsFvr5eTd/7xXGx2wtLrXz7Vtt//bb+Zjefh
	 CJRGBd1/xNnbw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 3DE1FC433A2;
	Thu, 27 Jun 2024 17:50:56 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v4 00/11] riscv: Memory Hot(Un)Plug support
From: patchwork-bot+linux-riscv@kernel.org
Message-Id: 
 <171951065622.6762.1200021343450740838.git-patchwork-notify@kernel.org>
Date: Thu, 27 Jun 2024 17:50:56 +0000
References: <20240605114100.315918-1-bjorn@kernel.org>
In-Reply-To: <20240605114100.315918-1-bjorn@kernel.org>
To: =?utf-8?b?QmrDtnJuIFTDtnBlbCA8Ympvcm5Aa2VybmVsLm9yZz4=?=@ci.codeaurora.org
Cc: linux-riscv@lists.infradead.org, alexghiti@rivosinc.com,
 aou@eecs.berkeley.edu, david@redhat.com, palmer@dabbelt.com,
 paul.walmsley@sifive.com, osalvador@suse.de, lstoakes@gmail.com,
 Chethan.Seshadri@catalinasystems.io, linux-kernel@vger.kernel.org,
 abrestic@rivosinc.com, bjorn@rivosinc.com, santosh.mamila@catalinasystems.io,
 linux-mm@kvack.org, siva.munnangi@catalinasystems.io,
 virtualization@lists.linux-foundation.org

Hello:

This series was applied to riscv/linux.git (for-next)
by Palmer Dabbelt <palmer@rivosinc.com>:

On Wed,  5 Jun 2024 13:40:43 +0200 you wrote:
> From: Björn Töpel <bjorn@rivosinc.com>
> 
> ================================================================
> Memory Hot(Un)Plug support (and ZONE_DEVICE) for the RISC-V port
> ================================================================
> 
> (For the restless folks: change log in the bottom!)
> 
> [...]

Here is the summary with links:
  - [v4,01/11] riscv: mm: Properly forward vmemmap_populate() altmap parameter
    https://git.kernel.org/riscv/c/e3ecf2fdc8f3
  - [v4,02/11] riscv: mm: Pre-allocate vmemmap/direct map/kasan PGD entries
    https://git.kernel.org/riscv/c/66673099f734
  - [v4,03/11] riscv: mm: Change attribute from __init to __meminit for page functions
    https://git.kernel.org/riscv/c/fe122b89da67
  - [v4,04/11] riscv: mm: Refactor create_linear_mapping_range() for memory hot add
    https://git.kernel.org/riscv/c/007480fe84a9
  - [v4,05/11] riscv: mm: Add pfn_to_kaddr() implementation
    https://git.kernel.org/riscv/c/6e6c5e21b8cb
  - [v4,06/11] riscv: mm: Add memory hotplugging support
    https://git.kernel.org/riscv/c/c75a74f4ba19
  - [v4,07/11] riscv: mm: Take memory hotplug read-lock during kernel page table dump
    https://git.kernel.org/riscv/c/37992b7f1097
  - [v4,08/11] riscv: Enable memory hotplugging for RISC-V
    https://git.kernel.org/riscv/c/f8c2a240556e
  - [v4,09/11] virtio-mem: Enable virtio-mem for RISC-V
    https://git.kernel.org/riscv/c/0546d7043e55
  - [v4,10/11] riscv: mm: Add support for ZONE_DEVICE
    https://git.kernel.org/riscv/c/216e04bf1e4d
  - [v4,11/11] riscv: Enable DAX VMEMMAP optimization
    https://git.kernel.org/riscv/c/4705c1571ad3

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


