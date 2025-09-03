Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EAC2636C078
	for <virtualization@lists.linux.dev>; Wed,  3 Sep 2025 18:59:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756925985; cv=none; b=hdD284q6DVk61Nx929xoPdZYbmREYkkqi59pPylseUXbSUDpA2UPLKkDbkfDKKPK6oQCu4koZVLw76cGb21NXxq/5Lh7h2x4D8DW+0e6WmNlAnpZ7PdJa3XYmtD5wxKmBeDcl/lrlxWzJoFd7r1m4/wmDv39FkW0BfQpQ/hsIi4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756925985; c=relaxed/simple;
	bh=5/VIQ0YOJj8EBJYFM7fzqfbwO1JII3lxYWLpEwerupo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GLwlMnYfmhv3ZxXzl+HN7H6MUecEC2PxIu1TBSp5rfhw9XzSINuV4VZ1lCWflDCLHLZSMKDp0UtH8V30dmb+mYk6UA2V5OpiQEQvIwZueu1Lddy1aAUA4JOAVb/BiwOA9nGo9l6R6V5mf1gKtnp1KDUXAOPg1jTxuzITS/K+LXk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gdnhEKcb; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gdnhEKcb"
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-24456ce0b96so2501495ad.0
        for <virtualization@lists.linux.dev>; Wed, 03 Sep 2025 11:59:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756925983; x=1757530783; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VXRq4apmEamZdvq2d1xSOZY75J3qH8SSfCfS4DJoIVY=;
        b=gdnhEKcb6iBFgd7vo7uCtKfqTQLDZI4rFRUqa9qJb/8SW12Hm0LVVok9ucLc5w7tcv
         JIKQVWh1bo6naEYu9OXate0H1Wnha8orjvPFUxrAPXl/oS08AOP954f0cksNDXaqyLU3
         IfhRp+gkTDIGiSYOprKM6+c4DhWpUIwPGXIX11jNFL1rcFTx9LEYcv5OtA1uxtATRcVR
         0JkZrGDZHxMupdlbcXggoS8uPZ3/WnTmGE1SdieBr5fhLkTZ9ZWUwjQQBImzXYesDzXJ
         yn7YBjTN+uoZ7SrFc+zeLnxAbEskFbTdvg3bI4+8gbun/B2q3KlgYJFaKoW5TnH7poHN
         DTkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756925983; x=1757530783;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VXRq4apmEamZdvq2d1xSOZY75J3qH8SSfCfS4DJoIVY=;
        b=gP9vGvXyYt+Sipda4SXwbE9m6JLr0GvuWguC7WT/ElUvNJO7rFHixDq5U9NWmfRAj9
         /Wq49lcg+NJAvbHv3FfUFDoFNfd3Ta1QJh4PiWW8/GDj2OdBgDpj5vRJmF/CGbTWg/Y9
         gTjZSTZ9wVzzaLJGwIq1xi2adwsu1ty59dcaPF1M+/W6wE2rHZzXjFFzVm0mh6ugJts1
         B0PZnUJvhqDhDpxJ0LJ6fmSsO5FrL2WW+PgKBWBJlgD5T81yjjl3rvppj44vA6hoysuz
         Dag97wAE2gfET54lvWXWDKR0JDnTAa8XlveFReeDBW18//4ksIVSxozb0oCMeTsztws4
         Gc7g==
X-Forwarded-Encrypted: i=1; AJvYcCXEXWKdijqP3niT48aYli3iIRjLnZqQs4KuDKGb31Fjzpl9VdlJrES4cW/p7Dyi9kKkMD4IqH1lPP+6iJjJZQ==@lists.linux.dev
X-Gm-Message-State: AOJu0YzMX5VDUn1gwugNKu3ZfUNuNCoE//B0aKVyE/xCryN9Plgv7qMK
	J+rLdFbXMSfIzSctSjwgvfIN/RvHiXDIumulz584tuFOUvN/c8S/ulGH
X-Gm-Gg: ASbGncvP7lRPz6P5CaiiteMCzUW8US1yVl6ZyJMFGBAoSY1vNyUNU/X8QsPD2nNO1uL
	OUTNkXZ739Fd1ALeuHyM/C7FW6vmntWtyLXaqD//2UizHe7Xi4U/opH2+SGVGNhu154VqNcYXTL
	MC0bWdl1YZ/MvwT5Cf2Sw9ZTM1kiCNdXCchXg0Zw1J/4kjUuKZ7pZO19074J7zULX1j+krxaUSf
	qS2SZaTUEyE8aex1X+99zqkRnCY72bkkMs7c9rCpxTmwmvFa4FbyEpFM1SdL8vR3ZWXt5cwpR9y
	hJSVQJa5iLfsqNE10TQBETnf5w4CSmfyabcvl8z3lNvXxg8In+sQ4sxLNzQ7i/j2UJqE9+XAKMo
	BHG6WGzT3SVWY9xnn5l1yjSV5IeBB9YCRnieblO6TaqDBkJoQgf4HrspMPByrsGB2WvTZ2kUJf/
	Y=
X-Google-Smtp-Source: AGHT+IGnOdoMz4pWaL7qXoMT+R27TwnQ4+tCeRLJ9HFet8fs0efEGIfh6YbGSI9RHeToTjhpbJgt1A==
X-Received: by 2002:a17:902:f688:b0:248:aa0d:bb22 with SMTP id d9443c01a7336-249446d2aa2mr226131105ad.0.1756925983252;
        Wed, 03 Sep 2025 11:59:43 -0700 (PDT)
Received: from fedora (c-67-164-59-41.hsd1.ca.comcast.net. [67.164.59.41])
        by smtp.googlemail.com with ESMTPSA id d9443c01a7336-249065ab343sm169403475ad.126.2025.09.03.11.59.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Sep 2025 11:59:42 -0700 (PDT)
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
	Madhavan Srinivasan <maddy@linux.ibm.com>,
	Michael Ellerman <mpe@ellerman.id.au>,
	"Ritesh Harjani (IBM)" <ritesh.list@gmail.com>
Subject: [PATCH v3 5/7] powerpc: Stop calling page_address() in free_pages()
Date: Wed,  3 Sep 2025 11:59:19 -0700
Message-ID: <20250903185921.1785167-6-vishal.moola@gmail.com>
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
Reviewed-by: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
---
 arch/powerpc/mm/book3s64/radix_pgtable.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/powerpc/mm/book3s64/radix_pgtable.c b/arch/powerpc/mm/book3s64/radix_pgtable.c
index be523e5fe9c5..73977dbabcf2 100644
--- a/arch/powerpc/mm/book3s64/radix_pgtable.c
+++ b/arch/powerpc/mm/book3s64/radix_pgtable.c
@@ -780,7 +780,7 @@ static void __meminit free_vmemmap_pages(struct page *page,
 		while (nr_pages--)
 			free_reserved_page(page++);
 	} else
-		free_pages((unsigned long)page_address(page), order);
+		__free_pages(page, order);
 }
 
 static void __meminit remove_pte_table(pte_t *pte_start, unsigned long addr,
-- 
2.51.0

