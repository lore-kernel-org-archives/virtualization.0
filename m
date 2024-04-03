Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97BA86E5FD
	for <virtualization@lists.linux.dev>; Wed,  3 Apr 2024 08:05:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712131518; cv=none; b=U5o4qKLiQy/kZ4Ns/ejQ/4zrwoijwp8XU9Zn6gCsG1F07TebMHrJNKr5h7gvdD+Gf7eIhEk4056LXsOjTmZKAURNBbIfP7t2Jhi3OD7klk/ZYqwx81gx5E1xX3yQVmF5LszRbaU6J4JtyTK+J65CKFE5mqpZRkoFTc/Lj/UG9cQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712131518; c=relaxed/simple;
	bh=lSkNV6iOiiqqPiO/F6auQ8ekda3aYuop52golLpc0/E=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=nzFW30pDdgyFFpo3TAFy23Rkg9W0DehzFm3qSzzsMpliqTCZNomcVzP7pz70OOxdS+E79qtmUclC32hUHIRvs0cL+jgI2PzDtTBvPkPewVLk47sKs8lvCcOqM7YjRFGrqz24x5S826sFBdZf7CEVKMdHwPKSxXTpQw5LTt2x5EU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=cwsluFBk; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="cwsluFBk"
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-1e0f3052145so57204585ad.2
        for <virtualization@lists.linux.dev>; Wed, 03 Apr 2024 01:05:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1712131516; x=1712736316; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Bc4Qbmx0AoxDu4ditj7xvL7MfGG2VDboL8zvDiTC/bw=;
        b=cwsluFBku9pOJDgb3lkEY4qojwhKBmwjiBcVL03yP5y7c9gCtRRuB+r8DqhuMZmmI8
         0SCCUniBAIAAzKLHkNsVp1CZGRJZWNKeGto3L/u9PAmp7t4AT/KrSPyrYs49eoiKZ12e
         ayXzFW+8GO+H2+KGQe+V/ElXemWngV6QDZlx6w0OP/5j5ABVQEIWQNqEKrTWXX032rvF
         uqBK/Auy/sDg/M9Z2Vnz86mHe8Ov0Ovjxkd/WGEUr/WN/kqKz3jQHfiVhNip/IU7ybuz
         /9Ie60wvo0xzai2Dk/FdvIWFrUXv3druOEgYhWlRRs4IxgF2pinJPDdWfTatjYg4gVGR
         rzgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712131516; x=1712736316;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Bc4Qbmx0AoxDu4ditj7xvL7MfGG2VDboL8zvDiTC/bw=;
        b=kJnk6v79BD+/lMlbGq2WXID5jq/mvBWPrypFw/FSWNR11rUxkKfWXDLo31FQRxzPgQ
         HvNIi/rVf0R542F9WV/CaxZ6PjDKPx2uqzIlCR/Xf5+81GPW0Z4EM+nKCyV5WQEtnYFk
         lgCAF/NUEa4vrlwQ5lQl6AVMZeygglr5xNaSsX4PjE8La9I/3L/ioJXK6nT9QygiHZO7
         yNpNFlJfXNQNIrJ+c1hR8kHjuniN/8wsCz7gZ9T/mOdbMsvlne9tfzaxZ7IxvHovW/jN
         AYnBVsYnYLVpfmq9C9vX0rHoEGwjiKvQqGqvkgkqmfuVmeKgNy0Da+nBFl5E4eEYV9do
         eDiA==
X-Forwarded-Encrypted: i=1; AJvYcCU+7d1PhVI/Zmq6z0FWbG5oH+p2hGMnYJ8wgpVb1Xv06CaN5ApNpK6Noiovz+j+ncO+tzcf0hZdJ0wva7bUV0wn5yj+PV+UQo29CGnxlrs=
X-Gm-Message-State: AOJu0YzhEwTEqFXGr3M5e4sELoGFjq60Q9zk7jpnPlB6zi3Eq2vvzIlp
	3s/iTrfY+pYDjNABUKOgpY4SuLgIdBShBkUdQpyTDqIBbMD+NJxI+/kUsUZ58wU=
X-Google-Smtp-Source: AGHT+IEN9FTCaj0hRotpYu2L3MLNBsnLZyWzCk4MgIL/9u1tPeTTuGgG3qQXqUKuRiVdVxo5cBEIJA==
X-Received: by 2002:a17:902:b089:b0:1dd:878d:9dca with SMTP id p9-20020a170902b08900b001dd878d9dcamr1981385plr.48.1712131516075;
        Wed, 03 Apr 2024 01:05:16 -0700 (PDT)
Received: from atishp.ba.rivosinc.com ([64.71.180.162])
        by smtp.gmail.com with ESMTPSA id c12-20020a170902d48c00b001e0b5d49fc7sm12557229plg.161.2024.04.03.01.05.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Apr 2024 01:05:15 -0700 (PDT)
From: Atish Patra <atishp@rivosinc.com>
To: linux-kernel@vger.kernel.org
Cc: Atish Patra <atishp@rivosinc.com>,
	=?UTF-8?q?Cl=C3=A9ment=20L=C3=A9ger?= <cleger@rivosinc.com>,
	Conor Dooley <conor.dooley@microchip.com>,
	Anup Patel <anup@brainfault.org>,
	Ajay Kaher <akaher@vmware.com>,
	Alexandre Ghiti <alexghiti@rivosinc.com>,
	Alexey Makhalov <amakhalov@vmware.com>,
	Andrew Jones <ajones@ventanamicro.com>,
	Juergen Gross <jgross@suse.com>,
	kvm-riscv@lists.infradead.org,
	kvm@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-riscv@lists.infradead.org,
	Mark Rutland <mark.rutland@arm.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Paolo Bonzini <pbonzini@redhat.com>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Shuah Khan <shuah@kernel.org>,
	virtualization@lists.linux.dev,
	VMware PV-Drivers Reviewers <pv-drivers@vmware.com>,
	Will Deacon <will@kernel.org>,
	x86@kernel.org
Subject: [PATCH v5 02/22] RISC-V: Add FIRMWARE_READ_HI definition
Date: Wed,  3 Apr 2024 01:04:31 -0700
Message-Id: <20240403080452.1007601-3-atishp@rivosinc.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240403080452.1007601-1-atishp@rivosinc.com>
References: <20240403080452.1007601-1-atishp@rivosinc.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

SBI v2.0 added another function to SBI PMU extension to read
the upper bits of a counter with width larger than XLEN.

Add the definition for that function.

Reviewed-by: Clément Léger <cleger@rivosinc.com>
Acked-by: Conor Dooley <conor.dooley@microchip.com>
Reviewed-by: Anup Patel <anup@brainfault.org>
Signed-off-by: Atish Patra <atishp@rivosinc.com>
---
 arch/riscv/include/asm/sbi.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/riscv/include/asm/sbi.h b/arch/riscv/include/asm/sbi.h
index 6e68f8dff76b..ef8311dafb91 100644
--- a/arch/riscv/include/asm/sbi.h
+++ b/arch/riscv/include/asm/sbi.h
@@ -131,6 +131,7 @@ enum sbi_ext_pmu_fid {
 	SBI_EXT_PMU_COUNTER_START,
 	SBI_EXT_PMU_COUNTER_STOP,
 	SBI_EXT_PMU_COUNTER_FW_READ,
+	SBI_EXT_PMU_COUNTER_FW_READ_HI,
 };
 
 union sbi_pmu_ctr_info {
-- 
2.34.1

