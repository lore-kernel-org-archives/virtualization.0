Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DB497C6C0
	for <virtualization@lists.linux-foundation.org>; Tue, 21 May 2024 11:49:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.137
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716292163; cv=none; b=K7+tLN8Rwy+YjqG2ZkRQE+w1sy2vIeDuRemfkCgeo+CK6bnyvMD1N0AClJy9kjNdyD8IQ2GP0mnqKBjJuM2hZ3NAOP1S1cnpGryyszzCxC0KILYt5APUkyi5llXzfU/WMsyrVss0IE2jxY0hIQkVq5Jl8HJs4AGiD62mVMMAchQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716292163; c=relaxed/simple;
	bh=kYHsD4H/RUxm26ELjeG4CcFUjPg7NPg0mup/+DL8qlQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=eV+SBRgKdfFpIj1ZVB1LQVz4JZFZiSkBE8QnbIEWiFqybGNuR5IQr3QWFXPBV4jGPvURYdBv0YzDfUjUyWxeighYsJPaFsS07Mtshn9LcuqOqHKhGIs91ESIfoHFyOsFk+lmxm7TBTiW9HqvmPhi/95Zh/f0igZLdZ8CdxuZsYU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AE2HJc/Z; arc=none smtp.client-ip=140.211.166.137
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AE2HJc/Z"
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 22D9B401C5
	for <virtualization@lists.linux-foundation.org>; Tue, 21 May 2024 11:49:22 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -7.101
X-Spam-Level:
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 2SH5CuMKreUq for <virtualization@lists.linux-foundation.org>;
 Tue, 21 May 2024 11:49:21 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=139.178.84.217; helo=dfw.source.kernel.org; envelope-from=bjorn@kernel.org; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp4.osuosl.org 48850401C3
Authentication-Results: smtp4.osuosl.org; dmarc=pass (p=none dis=none) header.from=kernel.org
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 48850401C3
Authentication-Results: smtp4.osuosl.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=AE2HJc/Z
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 48850401C3
	for <virtualization@lists.linux-foundation.org>; Tue, 21 May 2024 11:49:21 +0000 (UTC)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by dfw.source.kernel.org (Postfix) with ESMTP id A3ACE621B6;
	Tue, 21 May 2024 11:49:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7D227C4AF09;
	Tue, 21 May 2024 11:49:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1716292160;
	bh=kYHsD4H/RUxm26ELjeG4CcFUjPg7NPg0mup/+DL8qlQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=AE2HJc/Zo839RiPkn077HFAru7fuQ3IdqockYIAAK4zrgbbEvq7k/6D1z1skg/3ef
	 RBh4dJwbAkn6gux0u6dNld3GBZYMx2VqFWHEMI0zvFmccCkrfEHAR2ddpZ24phAuqa
	 mI0SCQ+ctgny3cFlc2/TsvQRGX/sEZoIceuOrAT0CeIc90szt7ePzoutW/5i4kLtFF
	 qDWUDAGevJg9PqJeLprnBHn6L2mH7CMZnVN2piLag+A9h5W2rL/rpWPDEtL+u7oND2
	 9e7GTMsDYuPcl9ftqfNlKcpfbLlW30egyyPtb5iTFjfLza91IxsO77cTeetIR+UAPT
	 cyOonut+Y4MSA==
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
Subject: [PATCH v3 8/9] virtio-mem: Enable virtio-mem for RISC-V
Date: Tue, 21 May 2024 13:48:29 +0200
Message-Id: <20240521114830.841660-9-bjorn@kernel.org>
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

Now that RISC-V has memory hotplugging support, virtio-mem can be used
on the platform.

Acked-by: David Hildenbrand <david@redhat.com>
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

