Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7672193096
	for <virtualization@lists.linux-foundation.org>; Wed,  5 Jun 2024 11:41:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.136
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717587682; cv=none; b=uHh1L1yffn3RD7xGJ6+y8FfHa+HzdXDbYPrNO4XERwbm6xXNZoX1u0UO5IS6ZdiL/vYAKfpYGIL+uYQ/F0akn2ITpaCsQT5bHLodmjZRvVoaZmS0DYQ2fMpYuooKcBsOsCUEN9et0fQxzVSbyt0Kc3dIOq/7jyrtQ0Kc+i0vT1U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717587682; c=relaxed/simple;
	bh=DeWhhyy/Pd+ZMACSRHJGzJta3bvo66kmrO80PItBsh0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=WBsj1ucwMex8dAmYboasy8MgWrz5X5SR6iXrSzbVKNFjf0XaJlfSnv7p/0E/7VgFfpkKkVlxsPOp5OnCkfXX0UjQ0sSzDDtpnNO5unMfEa+xRDnEWpdEMLmPqYCmUdVqYdzkUV3GQDedZv9Z8cbrkQYfMczLJU+cG2lOg3EbAq8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=U1Ioy0ma; arc=none smtp.client-ip=140.211.166.136
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="U1Ioy0ma"
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 5E43A6107C
	for <virtualization@lists.linux-foundation.org>; Wed,  5 Jun 2024 11:41:21 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -7.101
X-Spam-Level:
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id AMJaDX1GLUPQ for <virtualization@lists.linux-foundation.org>;
 Wed,  5 Jun 2024 11:41:20 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=139.178.84.217; helo=dfw.source.kernel.org; envelope-from=bjorn@kernel.org; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp3.osuosl.org ADEB761046
Authentication-Results: smtp3.osuosl.org; dmarc=pass (p=none dis=none) header.from=kernel.org
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org ADEB761046
Authentication-Results: smtp3.osuosl.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=U1Ioy0ma
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
	by smtp3.osuosl.org (Postfix) with ESMTPS id ADEB761046
	for <virtualization@lists.linux-foundation.org>; Wed,  5 Jun 2024 11:41:20 +0000 (UTC)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by dfw.source.kernel.org (Postfix) with ESMTP id A405E617FE;
	Wed,  5 Jun 2024 11:41:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C3803C32781;
	Wed,  5 Jun 2024 11:41:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717587679;
	bh=DeWhhyy/Pd+ZMACSRHJGzJta3bvo66kmrO80PItBsh0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=U1Ioy0maA5AwRckov58PI1dPUHyyGGgTWfzppxKvOJ5vKG4OYfFjGk9LswC/lA67g
	 AiIlfX+S+u9KX+idcOdeOFgkILKcjRmMy3P2mRnigjBzo6o8YhsVcdGLtPS1U5tG25
	 tAl6eEfOl+uJ0lnDHnB9krao18oZMsRfj3bVMcQ8Hhec/AU5okt/9ANWoqlsbg/v9B
	 6XAEJYTzUpZ4AMmjN82aSGoJ09nWwo5+Iq8Uc98aESGuk1kqIDdE25dT0Ew5lBYyMI
	 tbHq6/DNAi6bsnOYdF3D68Me1apb1caKmDIAUghJSJNQu3/1DH/vbtfVidTyA9KTpx
	 4/ZFTWv4bC1MQ==
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
Subject: [PATCH v4 01/11] riscv: mm: Properly forward vmemmap_populate() altmap parameter
Date: Wed,  5 Jun 2024 13:40:44 +0200
Message-ID: <20240605114100.315918-2-bjorn@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240605114100.315918-1-bjorn@kernel.org>
References: <20240605114100.315918-1-bjorn@kernel.org>
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

Reviewed-by: Alexandre Ghiti <alexghiti@rivosinc.com>
Signed-off-by: Björn Töpel <bjorn@rivosinc.com>
---
 arch/riscv/mm/init.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/riscv/mm/init.c b/arch/riscv/mm/init.c
index e3405e4b99af..fe5072f66c8c 100644
--- a/arch/riscv/mm/init.c
+++ b/arch/riscv/mm/init.c
@@ -1439,7 +1439,7 @@ int __meminit vmemmap_populate(unsigned long start, unsigned long end, int node,
 	 * memory hotplug, we are not able to update all the page tables with
 	 * the new PMDs.
 	 */
-	return vmemmap_populate_hugepages(start, end, node, NULL);
+	return vmemmap_populate_hugepages(start, end, node, altmap);
 }
 #endif
 
-- 
2.43.0

