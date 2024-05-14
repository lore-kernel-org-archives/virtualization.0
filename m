Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67CDA1474B0
	for <virtualization@lists.linux-foundation.org>; Tue, 14 May 2024 14:05:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.138
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715695529; cv=none; b=lPSbcR0sQvks9Pce2Dnsokd8FDMoQ8DuLzBGFJFwtFOZjAEMJ/5dtoDqptGE5ngxmiYNSaifDSvYBR6MYno9TP9pijV+ij4uAnXqFPg8kD+TIlBe+R39kyxmQN2tvqPGGFTVbTJJljUMtgrPRLmJAnX98aXsTEfhc/HqqF26Om8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715695529; c=relaxed/simple;
	bh=KbKqzNvXWA/Za9nd3AYnat1xf+LOO0b3PgRZV0HvyKk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=PWD1t14Gw1E15JwmSfBFFPbejQ+a2CVdplrqziLSVfNRR1kQ42/tyax1Ss4nUDxl+deOiNXo8uAPQFKYUwbu9BpDxeWJ+Iry4bBHbO7GWPYc9iDE94fsk9mANRoS474NZjSfeza8dTdTZjyWrkXzLhOwQdVDdYW+Msh+s3GzjqI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AnRBLrwi; arc=none smtp.client-ip=140.211.166.138
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AnRBLrwi"
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 17AE982076
	for <virtualization@lists.linux-foundation.org>; Tue, 14 May 2024 14:05:28 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -4.401
X-Spam-Level:
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id DdmW9aWT3q1d for <virtualization@lists.linux-foundation.org>;
 Tue, 14 May 2024 14:05:27 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2604:1380:4641:c500::1; helo=dfw.source.kernel.org; envelope-from=bjorn@kernel.org; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp1.osuosl.org 6F1238206E
Authentication-Results: smtp1.osuosl.org; dmarc=pass (p=none dis=none) header.from=kernel.org
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 6F1238206E
Authentication-Results: smtp1.osuosl.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=AnRBLrwi
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 6F1238206E
	for <virtualization@lists.linux-foundation.org>; Tue, 14 May 2024 14:05:27 +0000 (UTC)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by dfw.source.kernel.org (Postfix) with ESMTP id BC7816126C;
	Tue, 14 May 2024 14:05:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D3894C32781;
	Tue, 14 May 2024 14:05:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715695526;
	bh=KbKqzNvXWA/Za9nd3AYnat1xf+LOO0b3PgRZV0HvyKk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=AnRBLrwiGydV55YKVxP1C2hTU/+iQo4dd8w0faa4jtVHR4jHZ5anUbKb5yZ5ye3XS
	 ys1kla9pYrDzdZbLunoTrtdPNqqAUbKtu1CJ//68MFbQyh5y7aZhC46YK55JtaUZA5
	 ra5G2sERmBqf/UFx2SPaMVXfoiGS2kPxfZFkZNOUlVD19QOqS/SUV5MZU/mFGOVgDv
	 IXn6OG9dtirrJO/Dh3vnNlqnjzdI4qDmljqWq0kBU+c0CiDbOdoWE/pFltLXqLokVT
	 r19LtiBw6rEEkbg+nNadg08rNjWgfdZZVOpJ69iuykQqloruiT2sEewRtB7kCuWmPz
	 qDl5PWv830HDA==
From: =?UTF-8?q?Bj=C3=B6rn=20T=C3=B6pel?= <bjorn@kernel.org>
To: Alexandre Ghiti <alexghiti@rivosinc.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	David Hildenbrand <david@redhat.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	linux-riscv@lists.infradead.org
Cc: =?UTF-8?q?Bj=C3=B6rn=20T=C3=B6pel?= <bjorn@rivosinc.com>,
	Andrew Bresticker <abrestic@rivosinc.com>,
	Chethan Seshadri <Chethan.Seshadri@catalinasystems.io>,
	Lorenzo Stoakes <lstoakes@gmail.com>,
	Oscar Salvador <osalvador@suse.de>,
	Santosh Mamila <santosh.mamila@catalinasystems.io>,
	Sivakumar Munnangi <siva.munnangi@catalinasystems.io>,
	Sunil V L <sunilvl@ventanamicro.com>,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	virtualization@lists.linux-foundation.org
Subject: [PATCH v2 5/8] riscv: mm: Take memory hotplug read-lock during kernel page table dump
Date: Tue, 14 May 2024 16:04:43 +0200
Message-Id: <20240514140446.538622-6-bjorn@kernel.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20240514140446.538622-1-bjorn@kernel.org>
References: <20240514140446.538622-1-bjorn@kernel.org>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Björn Töpel <bjorn@rivosinc.com>

During memory hot remove, the ptdump functionality can end up touching
stale data. Avoid any potential crashes (or worse), by holding the
memory hotplug read-lock while traversing the page table.

This change is analogous to arm64's commit bf2b59f60ee1 ("arm64/mm:
Hold memory hotplug lock while walking for kernel page table dump").

Signed-off-by: Björn Töpel <bjorn@rivosinc.com>
---
 arch/riscv/mm/ptdump.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/riscv/mm/ptdump.c b/arch/riscv/mm/ptdump.c
index 1289cc6d3700..9d5f657a251b 100644
--- a/arch/riscv/mm/ptdump.c
+++ b/arch/riscv/mm/ptdump.c
@@ -6,6 +6,7 @@
 #include <linux/efi.h>
 #include <linux/init.h>
 #include <linux/debugfs.h>
+#include <linux/memory_hotplug.h>
 #include <linux/seq_file.h>
 #include <linux/ptdump.h>
 
@@ -370,7 +371,9 @@ bool ptdump_check_wx(void)
 
 static int ptdump_show(struct seq_file *m, void *v)
 {
+	get_online_mems();
 	ptdump_walk(m, m->private);
+	put_online_mems();
 
 	return 0;
 }
-- 
2.40.1

