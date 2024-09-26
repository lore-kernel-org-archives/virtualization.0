Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76A4015B552
	for <virtualization@lists.linux.dev>; Thu, 26 Sep 2024 17:44:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727372657; cv=none; b=Qm8tvYJa4/Nl+2GediMlYv4pRiTICweHrak1J/kxqN7uum3hdu3RYZLL2wjdzyMwi/1CvvMKx9yqsEebPF2R0IRrcmTllc9fyUxTeElFrAPe7JSCZ3UsZxxtCfL8JBGhODeszxZp+Dz0RPxivKkmubk9DDdm3IAihi5rMKT3fwE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727372657; c=relaxed/simple;
	bh=X/SBcrUhkDBQuYp5RI4cnhg6PNKuuJU1AAD6kMoNGV4=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=upiTWRjHJS9q4VBoBKzbayVZVVJmfOsLv2V8yFbHLZXxYhrAkAKr0GKAQHjoqag8R+PPu3SmOJW9wIQBJY5qDFkphqC3jiyb1mydfqF4bYF876CrQtptF1JaQeb5VVvzVcoPk2dYY1bPl5EmJPjW3HUu7Tg44wNjm0rCNYzu4R4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=LsoAn9Ki; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="LsoAn9Ki"
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-208ccde82e6so10531585ad.0
        for <virtualization@lists.linux.dev>; Thu, 26 Sep 2024 10:44:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1727372655; x=1727977455; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=qs6I4f1uojUFYR+5tPBYaQFjbQJjLMRwZ7Cac/Dqebc=;
        b=LsoAn9KiO5ZXWfmlFJRpoFVpGZN9Qii0isLMEWkeNOEM43H7UfALMIxcG1nsfnqTvp
         mKhkJILG7mhBs8CTGRPocNOrxmmPTTD6bL54b28SCjMo26AOtmBx/ev7/4H6/8pK4JW6
         L1BbYUKEiddyae5GfobQZ6zmeYI/WXIqT+MTw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727372655; x=1727977455;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=qs6I4f1uojUFYR+5tPBYaQFjbQJjLMRwZ7Cac/Dqebc=;
        b=ssjppMrxR+2saaKsv1AF/+PaGmDhylqqsnwMxXZBA9lm8zpmTXtFASywlyTIGGyzb0
         22BITjglps+ZCFjkvPN2PtbZRd22NcyRd56328xsO4rRM5cuopuR4vO5ZNEZFcBxQE3s
         ihkSiNOHRNDDJfI1DXRRaXdXHwdouJS+hXLzIAA1uAk71kVw2hhbaV6XUCREB05qWLwM
         Jh7+Sw77AvlIBgqKCPE7Sy/7hm693Y6/L6EpmYCkHIhTBQ7Vv3t+GpkMKDCMaHNdyz23
         GHOKrijgJiNC2g+3kB1CShZ0voOai7xBiNnhnpKIMsLnngya0Xm2LIvweIA+LUcp/eM4
         k21w==
X-Gm-Message-State: AOJu0Yzaty3Vf7nT+CK0hXACGuRP1pagUkNb13a2gHZed6FxLi+kptOo
	55HiQ4lIEkCH4VNXTvaq8LJA03Zk4CDyyjx7fId9SXh1sQrqfSLjUweZ2ES3Og==
X-Google-Smtp-Source: AGHT+IGMnGm70MLKXT0fiUChGM2Xw1hOYHqWy0UW4F66QVEzwBlTtQzKq2ZDP6zOx9lGK1tcCVB+GA==
X-Received: by 2002:a17:902:e884:b0:207:60f4:a393 with SMTP id d9443c01a7336-20b37391a8dmr7054895ad.27.1727372654631;
        Thu, 26 Sep 2024 10:44:14 -0700 (PDT)
Received: from amakhalov-build-vm.eng.vmware.com ([192.19.144.250])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-20b37e0d4b2sm1128855ad.155.2024.09.26.10.44.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Sep 2024 10:44:14 -0700 (PDT)
From: Alexey Makhalov <alexey.makhalov@broadcom.com>
To: linux-kernel@vger.kernel.org
Cc: virtualization@lists.linux.dev,
	konstantin@linuxfoundation.org,
	ajay.kaher@broadcom.com,
	Alexey Makhalov <alexey.makhalov@broadcom.com>
Subject: [PATCH] MAINTAINERS: update Alexey Makhalov's email address
Date: Thu, 26 Sep 2024 10:43:37 -0700
Message-Id: <20240926174337.1139107-1-alexey.makhalov@broadcom.com>
X-Mailer: git-send-email 2.39.4
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Fix a typo in an email address.

Reported-by: Konstantin Ryabitsev <konstantin@linuxfoundation.org>
Closes: https://lore.kernel.org/all/20240925-rational-succinct-vulture-cca9fb@lemur/T/
Signed-off-by: Alexey Makhalov <alexey.makhalov@broadcom.com>
---
 MAINTAINERS | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 4c37285a4747..bcea524fa997 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -17491,7 +17491,7 @@ F:	include/uapi/linux/ppdev.h
 PARAVIRT_OPS INTERFACE
 M:	Juergen Gross <jgross@suse.com>
 R:	Ajay Kaher <ajay.kaher@broadcom.com>
-R:	Alexey Makhalov <alexey.amakhalov@broadcom.com>
+R:	Alexey Makhalov <alexey.makhalov@broadcom.com>
 R:	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>
 L:	virtualization@lists.linux.dev
 L:	x86@kernel.org
@@ -24695,7 +24695,7 @@ F:	drivers/misc/vmw_balloon.c
 
 VMWARE HYPERVISOR INTERFACE
 M:	Ajay Kaher <ajay.kaher@broadcom.com>
-M:	Alexey Makhalov <alexey.amakhalov@broadcom.com>
+M:	Alexey Makhalov <alexey.makhalov@broadcom.com>
 R:	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>
 L:	virtualization@lists.linux.dev
 L:	x86@kernel.org
@@ -24723,7 +24723,7 @@ F:	drivers/scsi/vmw_pvscsi.h
 VMWARE VIRTUAL PTP CLOCK DRIVER
 M:	Nick Shi <nick.shi@broadcom.com>
 R:	Ajay Kaher <ajay.kaher@broadcom.com>
-R:	Alexey Makhalov <alexey.amakhalov@broadcom.com>
+R:	Alexey Makhalov <alexey.makhalov@broadcom.com>
 R:	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>
 L:	netdev@vger.kernel.org
 S:	Supported
-- 
2.39.4

