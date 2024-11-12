Received: from mail-qk1-f181.google.com (mail-qk1-f181.google.com [209.85.222.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2737C1CACE2
	for <virtualization@lists.linux.dev>; Tue, 12 Nov 2024 23:50:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731455432; cv=none; b=WIGEFrH8VIx4AQy9BQA4WDX7qVF4zCAQEzDw3ctJtxyobI9RU7HYv/Yk4t/q2PORJxND7halhJHjloDQH9wofZfAGcQ/+nS36b1GgaGqG4p40cZB1A2UFDPY02BMX8Dk6Zu/BFiZkF9ZEJI2x+SbBPpcokXMLxlX2oMvPT6/NI8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731455432; c=relaxed/simple;
	bh=jGUpsTFomPWWXjw46qZdwcX2deTWeyqCjUsdBykdJDs=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=FNYUhXfCrHFL0yXgRAvnWVt/FOM71RU0FrdUG+FW1aH8zhM3/3eTkjCLtJ35GI3RaGvtl6M1fKy33n3aEoQ86Um3miI+h1MCqswiBsu7j+Jf31wl4o1CZUI83i4I0hyKSl1j//iftABdUP/eLXPFgSzzNNTVobwhqE1fhAlLAbY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=Uc332uxd; arc=none smtp.client-ip=209.85.222.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="Uc332uxd"
Received: by mail-qk1-f181.google.com with SMTP id af79cd13be357-7b15467f383so465684585a.3
        for <virtualization@lists.linux.dev>; Tue, 12 Nov 2024 15:50:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1731455429; x=1732060229; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pW4qOuulsceYOUAjEJcoBjEr83Bo1JfDsK+YY4/2dLw=;
        b=Uc332uxdHoe7gFGpSVvPzqtoxCgGqY2l5rN8EZfXZ8bIECnjkKRBn+dp8a0lIxlsYz
         4FFaxxGNn1/w+eRh4jD/3B6irHx96X3Zt/zd1jGSSz3wBLTP5T3bZ8fI/Q697IfpgMOL
         l/rC5zDMPfnpfZahNWnjqb4QgB0B6xM5jB4jQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731455429; x=1732060229;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pW4qOuulsceYOUAjEJcoBjEr83Bo1JfDsK+YY4/2dLw=;
        b=BXhJiaR/MgL/IoAG2VTR2YatHOSPKKdCA1JK5FHA7TDGQSJ1xX06pelFhDkonLyC+1
         MwIEQuZ4RYzkaZyp6gUzoWzgZBmiVCiyWRtIBA1huQN3PJ7MHG9HAVjpByxAnZROM0Rz
         1wlIXNvME1CTF7b6Te3kN+JdV0IpR2S47Ag0Yfo/Owvkp0lp+pXbkpj9u8CdYF7KLCEm
         50XI55wj+wXP4MkhCzLJ+KYmh4YZWftIc6FA5IzxFeKOBGIaLX7OoF/bpNAx7rFa1XAY
         rJyrejoG1BG+CqyLT0LKwuwjuoGGfLeMeL7eDaGjeegLg+UD1Uj0NW8FJXNNTlXOxvZf
         6cUg==
X-Forwarded-Encrypted: i=1; AJvYcCVht6fTxQQFrVAI65RjIPePq/sCIWgDeI5ddBqyUGIsghfuujw9CZp2rLixvTJXryNNt07e395qsBxgsVekjw==@lists.linux.dev
X-Gm-Message-State: AOJu0YxhOEOnf9w6M5LDKpV8lpnVm/QMCn/QMZT8p2B/ual4jcl93slB
	Fy0UfjhkpXju6V5j8t08dpKBgcj2EU0PeGyyleplKYJQg1Gy+SU26wc1sLj2LQ==
X-Google-Smtp-Source: AGHT+IHGZMFCkebkrnfaoDI+6pcdjcBsJC+I6PNu9SuimG9cg17ChQxVCcXVN8XZtd0cIcvmhI+yKw==
X-Received: by 2002:a05:620a:4482:b0:7a1:df6f:3625 with SMTP id af79cd13be357-7b3528cf50fmr98703885a.37.1731455428946;
        Tue, 12 Nov 2024 15:50:28 -0800 (PST)
Received: from amakhalov-build-vm.. ([192.19.161.250])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7b32acae4d6sm640019485a.79.2024.11.12.15.50.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Nov 2024 15:50:28 -0800 (PST)
From: Alexey Makhalov <alexey.makhalov@broadcom.com>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	virtualization@lists.linux.dev
Cc: ajay.kaher@broadcom.com,
	Alexey Makhalov <alexey.makhalov@broadcom.com>,
	Konstantin Ryabitsev <konstantin@linuxfoundation.org>
Subject: [PATCH] MAINTAINERS: update Alexey Makhalov's email address
Date: Tue, 12 Nov 2024 23:50:13 +0000
Message-Id: <20241112235013.331902-1-alexey.makhalov@broadcom.com>
X-Mailer: git-send-email 2.39.4
In-Reply-To: <20240926174337.1139107-1-alexey.makhalov@broadcom.com>
References: <20240926174337.1139107-1-alexey.makhalov@broadcom.com>
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
index 21fdaa19229a..bfc902d7925a 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -17503,7 +17503,7 @@ F:	include/uapi/linux/ppdev.h
 PARAVIRT_OPS INTERFACE
 M:	Juergen Gross <jgross@suse.com>
 R:	Ajay Kaher <ajay.kaher@broadcom.com>
-R:	Alexey Makhalov <alexey.amakhalov@broadcom.com>
+R:	Alexey Makhalov <alexey.makhalov@broadcom.com>
 R:	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>
 L:	virtualization@lists.linux.dev
 L:	x86@kernel.org
@@ -24691,7 +24691,7 @@ F:	drivers/misc/vmw_balloon.c
 
 VMWARE HYPERVISOR INTERFACE
 M:	Ajay Kaher <ajay.kaher@broadcom.com>
-M:	Alexey Makhalov <alexey.amakhalov@broadcom.com>
+M:	Alexey Makhalov <alexey.makhalov@broadcom.com>
 R:	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>
 L:	virtualization@lists.linux.dev
 L:	x86@kernel.org
@@ -24719,7 +24719,7 @@ F:	drivers/scsi/vmw_pvscsi.h
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

