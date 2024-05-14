Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 653A3148830
	for <virtualization@lists.linux-foundation.org>; Tue, 14 May 2024 14:05:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715695538; cv=none; b=Jkv8MLDUBEEBi0j5ODSY2e+cuTJJ8tQHLgxUwIIRm5ZeEVDnSvLAbncZwlkmlFlai20FsF0xJYdW0IBtojRn4qJhzGL74ABdYU+pVA5HMe6x+/MqO7PxqEaZJ0gprTLDWqdJjv4xX7hx35iX48mfNtnidJ7/uVGqVhplnGlfGWU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715695538; c=relaxed/simple;
	bh=QKyUQtzdUFj7E7VWNazUrxKopSKCrJnxnXXoOO9I0K8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=JGdW4NXILjHnM36NaEGbejLhTu3ncHBzq/iipyo8nsgsRFS3s68AVvMyyIKC7RLmujL/Q4SOoGySO0qlj8N3H3G2KsQ9amMPwdN25/YKWzSMXmMiCsislTZL6KzSTo9f9jUw8VllV/cJN4anLlUtMvd6Brda4BZ9WVjZeZUJGKo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CLn+SxlD; arc=none smtp.client-ip=140.211.166.133
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CLn+SxlD"
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 0DF8A40476
	for <virtualization@lists.linux-foundation.org>; Tue, 14 May 2024 14:05:37 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -4.401
X-Spam-Level:
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id mUN9mYwY1Zp3 for <virtualization@lists.linux-foundation.org>;
 Tue, 14 May 2024 14:05:36 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2604:1380:4641:c500::1; helo=dfw.source.kernel.org; envelope-from=bjorn@kernel.org; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp2.osuosl.org 6C670402E8
Authentication-Results: smtp2.osuosl.org; dmarc=pass (p=none dis=none) header.from=kernel.org
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 6C670402E8
Authentication-Results: smtp2.osuosl.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=CLn+SxlD
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 6C670402E8
	for <virtualization@lists.linux-foundation.org>; Tue, 14 May 2024 14:05:36 +0000 (UTC)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by dfw.source.kernel.org (Postfix) with ESMTP id AA8446125F;
	Tue, 14 May 2024 14:05:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 83515C4AF08;
	Tue, 14 May 2024 14:05:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715695535;
	bh=QKyUQtzdUFj7E7VWNazUrxKopSKCrJnxnXXoOO9I0K8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=CLn+SxlD8a96Vi/A8lM2sysKVhH0gslhMRcG6/RFuCTRCj2QJXz/7tp2j4DwGGwTh
	 3s6+5SUO1nIjpJAF+WtJvgA5aYItK96Sb3keVQ5qAfR9fAiDhQy59AoJmhOA2XrWK0
	 ayQTEDyQFC54D6M7YKYx+IH/4KGsZRVrjgQhbTKhXcfDLpAlCxTd0vf7jvzMqhg10D
	 FNo9crb1rFcLhNsxwlSJXLQJLbLFUx+Vn0fV6a2SnBO6Ql/K2f7S+Cub2+7EHXyNVt
	 uL67hybo+QeRgGEosWl6aS/r8OQD0+M4q/Pkdwp8hNvF8RE8kn0rk6udwYclskf6Ei
	 XJ5CR8WHHNG4w==
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
Subject: [PATCH v2 7/8] virtio-mem: Enable virtio-mem for RISC-V
Date: Tue, 14 May 2024 16:04:45 +0200
Message-Id: <20240514140446.538622-8-bjorn@kernel.org>
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

Now that RISC-V has memory hotplugging support, virtio-mem can be used
on the platform.

Signed-off-by: Björn Töpel <bjorn@rivosinc.com>
---
 drivers/virtio/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/virtio/Kconfig b/drivers/virtio/Kconfig
index c17193544268..4e5cebf1b82a 100644
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
2.40.1

