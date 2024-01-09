Received: from mail-pj1-f43.google.com (mail-pj1-f43.google.com [209.85.216.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0569329428
	for <virtualization@lists.linux.dev>; Tue,  9 Jan 2024 05:10:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="Bm2zU1Yf"
Received: by mail-pj1-f43.google.com with SMTP id 98e67ed59e1d1-28cf491b197so1235863a91.1
        for <virtualization@lists.linux.dev>; Mon, 08 Jan 2024 21:10:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1704777042; x=1705381842; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=X8/C+cZAZlDGQnbyhqyYcqig/5vzt/WyH0xZX56gmkE=;
        b=Bm2zU1Yf2e0YTI7rHLtvZm0/IEacmzDfoIVb8FkbS2UYdvdpNai3qAuCnOFaxH4OTu
         ZRFwa2ltsyG+MDxamL63e3pIO1krFORZ6T3hb0iGIcx+aYkUWJG+cHuLwt007WemO7WY
         PKb5Am+mpBL35tniXL6k37D/OiK+XPFV8NmCA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704777042; x=1705381842;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=X8/C+cZAZlDGQnbyhqyYcqig/5vzt/WyH0xZX56gmkE=;
        b=uebPSbB4o8l6Ppir75gqMVx6brwAg+MGSWLlrsarRSyYBQPBo4DLndzpIEQAJ0ysvi
         hucjruttxdMyu+rdidZgoaIVU1vGk941Iiyw1gLT3DA/H44TE0UvytBpjwWPwrWR/RIQ
         f2gaLXRv5J/AfsSOPhnr7+D02oSoDygb5AXT/J4YEZXSBDIyBnlDpE7UMzMVtnsWe5b4
         FBdzxTG/ol1CsbgjCRkFeaQy82W+GL3xmievNq5WFKu3A9J51YktzifPKnOwWplIzyC2
         cWytW+Fku70ZMYSmfeH3cgneNXM0dyjlMa6MK05z/Is25DzQwGfMaHEBwUZ4bEtpYDPl
         Sk1Q==
X-Gm-Message-State: AOJu0YwlDEFs4P4+DRN7EO6F4l1NxmaAqsS6QYyrSRVjSylRKzo0IrgU
	0V3T7HT2Nzwj3PioSBSer630keCQsdEj
X-Google-Smtp-Source: AGHT+IGyOplJoUD1xpbK3AjrXC0Jcps/zI6GoGi+HTYdTfOMuuInqEmCQyQCViE4TmBnZqyRyNzi7A==
X-Received: by 2002:a17:90a:ad04:b0:28a:fd9f:8ff0 with SMTP id r4-20020a17090aad0400b0028afd9f8ff0mr1967323pjq.8.1704777042213;
        Mon, 08 Jan 2024 21:10:42 -0800 (PST)
Received: from amakhalov-build-vm.eng.vmware.com ([128.177.82.146])
        by smtp.gmail.com with ESMTPSA id u12-20020a17090ac88c00b0028aecd6b29fsm7344115pjt.3.2024.01.08.21.10.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Jan 2024 21:10:41 -0800 (PST)
From: Alexey Makhalov <alexey.makhalov@broadcom.com>
X-Google-Original-From: Alexey Makhalov <amakhalov@vmware.com>
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
Subject: [PATCH v5 6/7] x86/vmware: Undefine VMWARE_HYPERCALL
Date: Mon,  8 Jan 2024 21:10:16 -0800
Message-Id: <20240109051017.58167-7-amakhalov@vmware.com>
X-Mailer: git-send-email 2.39.0
In-Reply-To: <20240109051017.58167-1-amakhalov@vmware.com>
References: <20240109051017.58167-1-amakhalov@vmware.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

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

