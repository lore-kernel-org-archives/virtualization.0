Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E96D8199249
	for <virtualization@lists.linux-foundation.org>; Wed,  5 Jun 2024 11:42:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.137
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717587722; cv=none; b=b9/7+ooBvMWsSOrCCAcDjB39EYZySxK9LquU9bnLWMO2ghJ9qxGH7Sc8OFuYNUe5SROiDMeVUmXi6qVd97+4gr7OzjaOBpTlAT3xWkeNxL7jOp55urvJtaLYX8h7xmj2zypTWpQ+yUf6HEwQ4xzvbg58/ChHMgzxqAVBAfj1QjQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717587722; c=relaxed/simple;
	bh=cNH/faxi7/uMHF3i5ru1TGKN5bBuB3CG9oyUregFlwY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=YDZxXcCC4HOuwCwvBNiz1ug71aov+D9dlDyLyjiq101RspoBdtUf+ONBQ3iZgC45+oFSUr2+4got4ag8ojrrOn1Jui2qGEniM09XCPyGeSD2INb82Jvdwcevhe0NwLNmOxXLZVg8FfNndsoZ1dYaRzyLYqTJdM3RvSuY1k8yQL4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fe2kjdHr; arc=none smtp.client-ip=140.211.166.137
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fe2kjdHr"
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id BB217413B5
	for <virtualization@lists.linux-foundation.org>; Wed,  5 Jun 2024 11:42:01 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -4.401
X-Spam-Level:
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 9kWTa3zjKQea for <virtualization@lists.linux-foundation.org>;
 Wed,  5 Jun 2024 11:42:01 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=145.40.73.55; helo=sin.source.kernel.org; envelope-from=bjorn@kernel.org; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp4.osuosl.org D083A40323
Authentication-Results: smtp4.osuosl.org; dmarc=pass (p=none dis=none) header.from=kernel.org
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org D083A40323
Authentication-Results: smtp4.osuosl.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=fe2kjdHr
Received: from sin.source.kernel.org (sin.source.kernel.org [145.40.73.55])
	by smtp4.osuosl.org (Postfix) with ESMTPS id D083A40323
	for <virtualization@lists.linux-foundation.org>; Wed,  5 Jun 2024 11:42:00 +0000 (UTC)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sin.source.kernel.org (Postfix) with ESMTP id A53F5CE176A;
	Wed,  5 Jun 2024 11:41:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7C9B6C3277B;
	Wed,  5 Jun 2024 11:41:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717587718;
	bh=cNH/faxi7/uMHF3i5ru1TGKN5bBuB3CG9oyUregFlwY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=fe2kjdHr8ojoEyfXhgZTloB0ifMmIHOiG5DKKusQ7Sy/pLVBqY69c3MDTz/IU9Zgo
	 MOhwVt+ahqsvED2Vp8J9R+Q8ubBgqynFng83NWmTihwz/P2ChTKelcdKT2bUChXFK9
	 XPcoo8c3N4IbEGXTynF+kAx7m1dH5G/PPGoikssoDmop+tc7FNpWuiccwDm0/0jsfe
	 H4f2dL3LvdfbCWfFtqsONnn/c9csqEX1jG6HQnp4UkSH/eCSeScKzEtuXeHHntRU0w
	 WP5qZvrd9lyHDBzgPM4+Zt64wDTLbmT3TRs6NhwxTl4SmXf6mkzAM5N7uV58/eSTTK
	 ItWw6ywddPduA==
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
Subject: [PATCH v4 09/11] virtio-mem: Enable virtio-mem for RISC-V
Date: Wed,  5 Jun 2024 13:40:52 +0200
Message-ID: <20240605114100.315918-10-bjorn@kernel.org>
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

Now that RISC-V has memory hotplugging support, virtio-mem can be used
on the platform.

Acked-by: David Hildenbrand <david@redhat.com>
Signed-off-by: Björn Töpel <bjorn@rivosinc.com>
---
 drivers/virtio/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/virtio/Kconfig b/drivers/virtio/Kconfig
index 6284538a8184..42a48ac763ee 100644
--- a/drivers/virtio/Kconfig
+++ b/drivers/virtio/Kconfig
@@ -122,7 +122,7 @@ config VIRTIO_BALLOON
 
 config VIRTIO_MEM
 	tristate "Virtio mem driver"
-	depends on X86_64 || ARM64
+	depends on X86_64 || ARM64 || RISCV
 	depends on VIRTIO
 	depends on MEMORY_HOTPLUG
 	depends on MEMORY_HOTREMOVE
-- 
2.43.0

