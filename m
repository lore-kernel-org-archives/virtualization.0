Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D31F7770EE
	for <virtualization@lists.linux-foundation.org>; Tue, 21 May 2024 11:48:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.137
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716292133; cv=none; b=KshLmRqGYqkD/l2f7r3ZMbhpJESv6dd4xaN0s5msEN9tK2S1UGgJSPJs+dJMeqDxRT5PTN0h+CBngkSK8rZqLH9MCdb+/0rXqw0KQselWuSbK2Flare7SUF2NSDDp06ZVZ23+jIGDehwpZZkckFqkyUWd/8ooD26jVPeGxJKMi8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716292133; c=relaxed/simple;
	bh=dNsU9/EzgA72vQ2DBRKYul88CUOKLAUu9MwoObC6yL8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=DC9qhtqtGQBdfvNCgqtc9Xsi5y4J2/FrjakMSMilgNEkxYrwMvnBuTq/6tkE9TvCIy/kQaihzMSwn/NqAcsGcL/pffeiWS12/RXW2LCzwB3iY/ChMAJnEeVrFLzBS+qsTf4NBsLj7bXno0UfYdrJxadtm8iVNn9SuHthnkMnRTk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GXrl8c02; arc=none smtp.client-ip=140.211.166.137
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GXrl8c02"
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 5D3634015E
	for <virtualization@lists.linux-foundation.org>; Tue, 21 May 2024 11:48:52 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -7.101
X-Spam-Level:
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id N4wSMv_KxKXW for <virtualization@lists.linux-foundation.org>;
 Tue, 21 May 2024 11:48:51 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=139.178.84.217; helo=dfw.source.kernel.org; envelope-from=bjorn@kernel.org; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp4.osuosl.org 868D24013C
Authentication-Results: smtp4.osuosl.org; dmarc=pass (p=none dis=none) header.from=kernel.org
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 868D24013C
Authentication-Results: smtp4.osuosl.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=GXrl8c02
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 868D24013C
	for <virtualization@lists.linux-foundation.org>; Tue, 21 May 2024 11:48:51 +0000 (UTC)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by dfw.source.kernel.org (Postfix) with ESMTP id 58655621C6;
	Tue, 21 May 2024 11:48:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 30B5DC32786;
	Tue, 21 May 2024 11:48:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1716292130;
	bh=dNsU9/EzgA72vQ2DBRKYul88CUOKLAUu9MwoObC6yL8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=GXrl8c02sxRhi+iEOVG7cmPLve4hs9PdvC3ifTK/0ZJ2fpiI1XBIM4f+Tw1XUK7oJ
	 E4gTG3lnIzNy0NnH7nrt/MisLxPNbNSdRPNHDns409n2DL9j/qql7OXIVmG+wbtrld
	 Kjm+nN8ILu0EkFtcEGiGNyfxoJyIGgCdRUFHFljWi+6cXzT8JsNglHSC1kyO0Gjzvq
	 TKOX/eyVGq0AbdiNIWzUz0oGDOjhKt/Mvsj09wXl9JKM00gjNZsK/YEwrBgqQ6GusU
	 /dOVij7LrrF21Q72kX1xKptNkdTTAiN8fiiWs98gKQJ3bmwiqITGgPQJChzVFnhp2N
	 k6bc9FLkN9NgQ==
From: =?UTF-8?q?Bj=C3=B6rn=20T=C3=B6pel?= <bjorn@kernel.org>
To: Alexandre Ghiti <alexghiti@rivosinc.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	David Hildenbrand <david@redhat.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	linux-riscv@lists.infradead.org,
	Oscar Salvador <osalvador@suse.de>
Cc: =?UTF-8?q?Bj=C3=B6rn=20T=C3=B6pel?= <bjorn@rivosinc.com>,
	Andrew Bresticker <abrestic@rivosinc.com>,
	Chethan Seshadri <Chethan.Seshadri@catalinasystems.io>,
	Lorenzo Stoakes <lstoakes@gmail.com>,
	Santosh Mamila <santosh.mamila@catalinasystems.io>,
	Sivakumar Munnangi <siva.munnangi@catalinasystems.io>,
	Sunil V L <sunilvl@ventanamicro.com>,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	virtualization@lists.linux-foundation.org
Subject: [PATCH v3 1/9] riscv: mm: Properly forward vmemmap_populate() altmap parameter
Date: Tue, 21 May 2024 13:48:22 +0200
Message-Id: <20240521114830.841660-2-bjorn@kernel.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20240521114830.841660-1-bjorn@kernel.org>
References: <20240521114830.841660-1-bjorn@kernel.org>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Björn Töpel <bjorn@rivosinc.com>

Make sure that the altmap parameter is properly passed on to
vmemmap_populate_hugepages().

Signed-off-by: Björn Töpel <bjorn@rivosinc.com>
---
 arch/riscv/mm/init.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/riscv/mm/init.c b/arch/riscv/mm/init.c
index 2574f6a3b0e7..b66f846e7634 100644
--- a/arch/riscv/mm/init.c
+++ b/arch/riscv/mm/init.c
@@ -1434,7 +1434,7 @@ int __meminit vmemmap_populate(unsigned long start, unsigned long end, int node,
 	 * memory hotplug, we are not able to update all the page tables with
 	 * the new PMDs.
 	 */
-	return vmemmap_populate_hugepages(start, end, node, NULL);
+	return vmemmap_populate_hugepages(start, end, node, altmap);
 }
 #endif
 
-- 
2.40.1

