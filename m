Received: from mail-pg1-f180.google.com (mail-pg1-f180.google.com [209.85.215.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B710142912
	for <virtualization@lists.linux.dev>; Thu,  7 Mar 2024 21:30:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709847015; cv=none; b=Hl8MIgX6ANXdRlSwCsEmRPpo7Q9gjeRVYDRY37T7r6tDG3QZUrkeGwPc6ccinCtfvDQ7T6y0F5q8ssG4zu7qYNwRPOCCdkXpo9/EXFCjC7SKIT4yMmBS29xQW3LRnBZ1EinesADx1dtsjA+zEGbPk/Gqh3wquktPqz6Xo/fGUKU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709847015; c=relaxed/simple;
	bh=qvYXdrNVu5d+kSNUXx5DBFt3PF9WPQIw0ynJtHs7eEE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=kcIEKwMVbGZ6oqM3HKbmhkR/FI3OJqEDylKxJBKjMIArP+9rEF6rDhEW2tRzDWyaKeir89uqaZkAzRLYCP4oHvgmGl7nDgSgUyCvQN0LPJyHKg1rQU+Zt/bXWR0kkxKiMpelFpdkhzqnFat57TRVWT3dV7zGw03xspYMDgT4wBM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=Tzld85k0; arc=none smtp.client-ip=209.85.215.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="Tzld85k0"
Received: by mail-pg1-f180.google.com with SMTP id 41be03b00d2f7-5d8b70b39efso106174a12.0
        for <virtualization@lists.linux.dev>; Thu, 07 Mar 2024 13:30:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1709847013; x=1710451813; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6wTvrBoMRxZCWaEX/3Staq0bbOJFHnuwbRWeayyXP6g=;
        b=Tzld85k03vAz3179qEq17VHmJg2p7lhunc4x3kkNbNEC5O8x7kQ79812OhMy1E1J9K
         1BYHTSKSHckhZNcojF9dLhPemypNgNTlGiDVBtlpKxltxIaGARKLAGcWhIAhiYBSQnE9
         oI8yYYESiXWSqN7c7MkJ3G8xMW0JNdS+w9tgQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709847013; x=1710451813;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6wTvrBoMRxZCWaEX/3Staq0bbOJFHnuwbRWeayyXP6g=;
        b=PpjSzaRJ00mIdIhD9by4+o8xuwWVnvOkK3XPPOHMtMOPkFI7l2NXtS2svJ3FjwQ1lJ
         pNAkCm3uc6K2jTn8aLww3iLq8t276SFiJCp6g5Cs7MrW2/Qo83e77A2PQB2D+goSEy3f
         Yg02+XEn+aUAQ8M/kilgKRUUOfG/pR726ALkZiOwEeIaHImlbVa3yqO9YEEWGUSeJeJT
         T0fKtKnIO8F3NN+TlNQXPCJY89DnGJD4Y/r463azYybksFnVBDvB7BIzgb4A2gsHGUyz
         P0FZc47wpUfHDna9jCHmkkMJfdl6COjn/26tcYgfvjSEYmtDutBX7BiB4T1Fu5OhLzYR
         5v1g==
X-Forwarded-Encrypted: i=1; AJvYcCXByKHlNOc92lidQse9iXpXgZpFoh4cI4BpBBbMC2mOeaAWj2Szwf47+nNwenotGUkgtRR8jxhIHDoCTgXdspbI00r5l9EwlejgLI4iOvY=
X-Gm-Message-State: AOJu0YwaSs5/kQA4t+ym/hMwJG5cs3u7Pm9JeHTBKpbAaRaUObvSfg5q
	xYsPaRLOVcshyW30NVKeFjTSPJ5OUckJPB2OYSI7EwBmn99+3/XK/CVrxi6hHA==
X-Google-Smtp-Source: AGHT+IFVrVN0tHcOVBFKPEnuhQVuezk1j0U7qfNAEn4QdWC6lbUljz3m5eFH1/rI7jdt8VRUi2xtVw==
X-Received: by 2002:a17:90a:8046:b0:29a:7efc:4720 with SMTP id e6-20020a17090a804600b0029a7efc4720mr16660957pjw.31.1709847012662;
        Thu, 07 Mar 2024 13:30:12 -0800 (PST)
Received: from amakhalov-build-vm.eng.vmware.com ([64.186.27.43])
        by smtp.gmail.com with ESMTPSA id y12-20020a17090abd0c00b00299db19a81asm1991021pjr.56.2024.03.07.13.30.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Mar 2024 13:30:12 -0800 (PST)
From: Alexey Makhalov <alexey.makhalov@broadcom.com>
To: linux-kernel@vger.kernel.org,
	virtualization@lists.linux.dev,
	bp@alien8.de,
	hpa@zytor.com,
	dave.hansen@linux.intel.com,
	mingo@redhat.com,
	tglx@linutronix.de
Cc: x86@kernel.org,
	netdev@vger.kernel.org,
	richardcochran@gmail.com,
	linux-input@vger.kernel.org,
	dmitry.torokhov@gmail.com,
	zackr@vmware.com,
	linux-graphics-maintainer@vmware.com,
	pv-drivers@vmware.com,
	namit@vmware.com,
	timothym@vmware.com,
	akaher@vmware.com,
	jsipek@vmware.com,
	dri-devel@lists.freedesktop.org,
	daniel@ffwll.ch,
	airlied@gmail.com,
	tzimmermann@suse.de,
	mripard@kernel.org,
	maarten.lankhorst@linux.intel.com,
	horms@kernel.org,
	kirill.shutemov@linux.intel.com
Subject: [PATCH v7 6/7] x86/vmware: Undefine VMWARE_HYPERCALL
Date: Thu,  7 Mar 2024 13:29:48 -0800
Message-Id: <20240307212949.4166120-7-alexey.makhalov@broadcom.com>
X-Mailer: git-send-email 2.39.0
In-Reply-To: <20240307212949.4166120-1-alexey.makhalov@broadcom.com>
References: <20240307212949.4166120-1-alexey.makhalov@broadcom.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Alexey Makhalov <amakhalov@vmware.com>

No more direct use of VMWARE_HYPERCALL macro should be allowed.

Signed-off-by: Alexey Makhalov <amakhalov@vmware.com>
---
 arch/x86/include/asm/vmware.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/x86/include/asm/vmware.h b/arch/x86/include/asm/vmware.h
index 2ac87068184a..84a31f579a30 100644
--- a/arch/x86/include/asm/vmware.h
+++ b/arch/x86/include/asm/vmware.h
@@ -273,5 +273,6 @@ unsigned long vmware_hypercall_hb_in(unsigned long cmd, unsigned long in2,
 }
 #undef VMW_BP_REG
 #undef VMW_BP_CONSTRAINT
+#undef VMWARE_HYPERCALL
 
 #endif
-- 
2.39.0

