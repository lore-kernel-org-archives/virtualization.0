Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB2AC36C09C
	for <virtualization@lists.linux.dev>; Wed,  3 Sep 2025 18:59:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756925987; cv=none; b=M+1yN96bo/+Moatn9qj50n//qO9cwrO9eQahU3z/Da0EEXDqzRNq5tZhisxtE/AcYAIWOuYT8syuO7q3HyzpwR8MGC/aZD4mI6ko9kz9mH4oPYJ/vUWLjEMeUUOb9QND3sPhakxE28W5XAOhfpGCuqOBE8gI/40yRf/C/0sCcy0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756925987; c=relaxed/simple;
	bh=14eY//0sWN84Y1oOt0zSOd+CM/1+X56WmIombu10NEw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XkZm9WAe+zRv5issAI+2F0e/Uhfj7Oq3FpGOBcJklf3No/IY1bj8aUyjZfUlH7S89VRxuPO9Z68GJ+aFDMX1DYBtfmgYTeYOt3ipdbN+yVa8hbjlE40BtQraBjoQ/EWtqdqtd6LvR/n3vuV0I6tmxPwgJQ58YF+S7sKN8+Luj/w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UoKmMM/y; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UoKmMM/y"
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-24c8ef94e5dso1743845ad.1
        for <virtualization@lists.linux.dev>; Wed, 03 Sep 2025 11:59:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756925985; x=1757530785; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FA6weTM8vdilC/EIGooLzDUuRuJzTtRM53Ib1Pd9QnA=;
        b=UoKmMM/yE5NWSjOaqEm23tu705SfM96bFUMH95jiL5qaEcqgAv7aybyq8lbDjCiHpz
         8HvXIo9LxfXtFOAdu5GoyXvXBXXVniVT3ekwXc6QB5ZQrCwagA5dewvIDCKhW/YPHKYR
         PQH5ZeRu8pij73lnZ3U1VPl7pp4UTNL3z7oo+6T6VqVd76Q/g+KqB/bXQcmAsFfnV1Ib
         8kTmWJcy8p9HRq2h0JxJjArn+asITVvhQdYo6Oo07o+/Ws93lk4Wim3aiiaMfM7Q2FJ7
         7YipJ5Ck1gvsXL7vv4B+0bQl+kwcBo+lXLODoNoNIuma5d1tbkFafbHDXy/PQAVgxeJP
         lNFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756925985; x=1757530785;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FA6weTM8vdilC/EIGooLzDUuRuJzTtRM53Ib1Pd9QnA=;
        b=kisFTTyrVc4QHLIobY+2eVsyJChSak1edOLF3XdwP0jgLKCJAcyRVAWbr22JiZRK6A
         WWhfv6PxCFUSF4M0PTas5IRjcGUtw1oCcrUbyZUKs3e2i3f6giwU/4PNQR5oFBrnURcS
         dzTsIPC1/3y7toi734haSHI1Hb+Htup2QKPmIJQqqp/IQNFVWmQy7Za9sHQPruXiqrw+
         9l1VL6qy2X6mc5PoQJ90jfwqFX1Z5q1gp6+ZIsl3orw1WzExr39+bQ2GRu3m3/ZeniGs
         I7ESngaHRiIDSm8CAFdI3K5OKeEneqnS7y6R0GoiDAAi/zxv5+kDLtBbMhz3DSblSCEe
         klQw==
X-Forwarded-Encrypted: i=1; AJvYcCVo6MytnlNOvkhOBMnDUhjpKxxSTYHgNM9pWGYGEgXoH5FmNJ4wKZJdvRrzgSL5jzsYPRsCHKEJHt47Gz7lZQ==@lists.linux.dev
X-Gm-Message-State: AOJu0YzGGloFyYPsB+/LUWFHzCkylXe1DjB1zvA1bE69qcqGrgxFTfox
	yztWUhEx0c2BSVECgQribxO6AXVOTOadUJaeGOn8Rz6OGi02sWIf3ntu
X-Gm-Gg: ASbGncsUAZtGTgNQWuOCw27UkebgefRNxyjCTHjxENlgpSUWnnuaWER5lovKYgaKfyL
	IvJ9HXHg0KzWg94THUnyOuMJElNkfnSVcYAms12uE7CcrL4gCVg4NrsUANVEORFINdzwg19YNlM
	Mp+H0F7liHe77LIW7XzqNIwyhp7+Gu82x39WO3dcNVkPrZLqNt+1Z7vhqdDGOo2q437X6WIU4tz
	327Wt4jc7j06TjbBEGn4YmTNXL9T8k4ug7joslXh6ku58idehidBbiVhbn+p/bJPlvv1QyBozaP
	StkWOFqEbuE5p0HmNQdm4zU8tzRbVEBggCLG8bddzqcACIkFxyPAj9wARFho1uU8+PTnKARAbZa
	iz1wZmt1sGqwXb2awLTC8Vht6kSWL2akwnH6H7zRZ4ODVa/IzVyb0FpZV6ui2In1N
X-Google-Smtp-Source: AGHT+IFoYEL3/2HJDWoKxsFsnkPmdjG5vBre6hTTnok3nMNP8kBMsMcFaEho42lHd4bWFQ52X19GJA==
X-Received: by 2002:a17:902:d489:b0:240:5bf7:97ac with SMTP id d9443c01a7336-2493ef50b32mr219143675ad.16.1756925984962;
        Wed, 03 Sep 2025 11:59:44 -0700 (PDT)
Received: from fedora (c-67-164-59-41.hsd1.ca.comcast.net. [67.164.59.41])
        by smtp.googlemail.com with ESMTPSA id d9443c01a7336-249065ab343sm169403475ad.126.2025.09.03.11.59.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Sep 2025 11:59:44 -0700 (PDT)
From: "Vishal Moola (Oracle)" <vishal.moola@gmail.com>
To: linux-mm@kvack.org
Cc: linux-kernel@vger.kernel.org,
	Andrew Morton <akpm@linux-foundation.org>,
	linux-block@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linuxppc-dev@lists.ozlabs.org,
	linux-riscv@lists.infradead.org,
	linux-efi@vger.kernel.org,
	virtualization@lists.linux.dev,
	"Vishal Moola (Oracle)" <vishal.moola@gmail.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>
Subject: [PATCH v3 6/7] arm64: Stop calling page_address() in free_pages()
Date: Wed,  3 Sep 2025 11:59:20 -0700
Message-ID: <20250903185921.1785167-7-vishal.moola@gmail.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250903185921.1785167-1-vishal.moola@gmail.com>
References: <20250903185921.1785167-1-vishal.moola@gmail.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

free_pages() should be used when we only have a virtual address. We
should call __free_pages() directly on our page instead.

Signed-off-by: Vishal Moola (Oracle) <vishal.moola@gmail.com>
Acked-by: Catalin Marinas <catalin.marinas@arm.com>
---
 arch/arm64/mm/mmu.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/mm/mmu.c b/arch/arm64/mm/mmu.c
index 34e5d78af076..e14a75d0dbd3 100644
--- a/arch/arm64/mm/mmu.c
+++ b/arch/arm64/mm/mmu.c
@@ -843,7 +843,7 @@ static void free_hotplug_page_range(struct page *page, size_t size,
 		vmem_altmap_free(altmap, size >> PAGE_SHIFT);
 	} else {
 		WARN_ON(PageReserved(page));
-		free_pages((unsigned long)page_address(page), get_order(size));
+		__free_pages(page, get_order(size));
 	}
 }
 
-- 
2.51.0

