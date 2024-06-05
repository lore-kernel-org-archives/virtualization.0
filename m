Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9026114D435
	for <virtualization@lists.linux-foundation.org>; Wed,  5 Jun 2024 11:42:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.136
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717587735; cv=none; b=G8/+zMeZZug6OQEuEgaBqbXL8Osxjj7aDbxSETRP2eGff0pNwOXCY/0vg61/0NSXmbPQRQ5aqfRZsf2eQnnouqV09B+3rZBQVXx3oPepysmkJUBpvvioHCTyBCfRRmGaX3Ki5mG1PfqKpWKL6lMIbFl8jRa0T5sQczITWwtSjYs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717587735; c=relaxed/simple;
	bh=cXaL8X5xkqjru4qZvhtnJBNQd1jrCsGud/RraJezK+0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=goy3BHFPLmJqawWnTZbxI+0QRdB4yB0fk2dbOF5Y1Zc4C/e6RdB/+6sBuOrJM3tmzaTMQF7OWURW0UfNWsmqKmeg+B3+Fg4RIgmDraoonabBHqmOa6G9XxqbRgtG3eVZWTcZOWH1q8wBeljq7ifR6BW1WQ0D+7flCbN5u7Cmhbw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=P49tYTr8; arc=none smtp.client-ip=140.211.166.136
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="P49tYTr8"
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 37B9D61072
	for <virtualization@lists.linux-foundation.org>; Wed,  5 Jun 2024 11:42:14 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -4.401
X-Spam-Level:
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id LYgZ4gHegZny for <virtualization@lists.linux-foundation.org>;
 Wed,  5 Jun 2024 11:42:12 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=145.40.73.55; helo=sin.source.kernel.org; envelope-from=bjorn@kernel.org; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp3.osuosl.org 8FD9061046
Authentication-Results: smtp3.osuosl.org; dmarc=pass (p=none dis=none) header.from=kernel.org
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 8FD9061046
Authentication-Results: smtp3.osuosl.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=P49tYTr8
Received: from sin.source.kernel.org (sin.source.kernel.org [145.40.73.55])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 8FD9061046
	for <virtualization@lists.linux-foundation.org>; Wed,  5 Jun 2024 11:42:11 +0000 (UTC)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sin.source.kernel.org (Postfix) with ESMTP id 1E518CE0EB2;
	Wed,  5 Jun 2024 11:42:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0C49EC3277B;
	Wed,  5 Jun 2024 11:42:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717587727;
	bh=cXaL8X5xkqjru4qZvhtnJBNQd1jrCsGud/RraJezK+0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=P49tYTr8ENggo5fZvyKqZ4PxM1peSbHLq3cEfJefvxO26qq3VgrbD44w7SPHT1HkT
	 yLZk4KJTmkXb4xi7nmVa9vtoQcspd+KSp86VRVE/N0ToZjrv8UmR3sqged4GllPn5h
	 5GvPvVSfGAeMGH24F5yZwuJ5PcsphzNqUIcASKCOtwEetL+b7w0teYBp/8DvVDy4KI
	 evrzh5rO0PqNeq9Kf+oHWL+Lp3xUwlwdEzkfvR/QO6nuFAWCLeW2D2MUCFok7kI/s0
	 /y+gLAedifYQI5N+imnHHGNoDFCQrHDR/jrIIAKKecSFW6RBDuu4j+4/Tyl4w1ABwV
	 fsHibJ697J1KA==
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
Subject: [PATCH v4 11/11] riscv: Enable DAX VMEMMAP optimization
Date: Wed,  5 Jun 2024 13:40:54 +0200
Message-ID: <20240605114100.315918-12-bjorn@kernel.org>
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

Now that DAX is usable, enable the DAX VMEMMAP optimization as well.

Signed-off-by: Björn Töpel <bjorn@rivosinc.com>
---
 arch/riscv/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/riscv/Kconfig b/arch/riscv/Kconfig
index 8a49b5f4c017..1631bf568158 100644
--- a/arch/riscv/Kconfig
+++ b/arch/riscv/Kconfig
@@ -73,6 +73,7 @@ config RISCV
 	select ARCH_WANT_GENERAL_HUGETLB if !RISCV_ISA_SVNAPOT
 	select ARCH_WANT_HUGE_PMD_SHARE if 64BIT
 	select ARCH_WANT_LD_ORPHAN_WARN if !XIP_KERNEL
+	select ARCH_WANT_OPTIMIZE_DAX_VMEMMAP
 	select ARCH_WANT_OPTIMIZE_HUGETLB_VMEMMAP
 	select ARCH_WANTS_NO_INSTR
 	select ARCH_WANTS_THP_SWAP if HAVE_ARCH_TRANSPARENT_HUGEPAGE
-- 
2.43.0

