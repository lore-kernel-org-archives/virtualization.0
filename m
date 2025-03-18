Received: from mail-oo1-f54.google.com (mail-oo1-f54.google.com [209.85.161.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77156D528
	for <virtualization@lists.linux.dev>; Tue, 18 Mar 2025 00:40:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742258438; cv=none; b=fn4pW0oUQ6OyHWfsif888qwQ9C7dEQypcOQEEWeWIMTOoUVyV5yzC4jY9CoctVusx9ETNcDJ1eeUqgt+/rfHbetqnWWbfOsc9gEtcLyBJyLlNgwKyPkvM4GAIVrUiUpfttYVtlKlslIgdKuC6Z9VLjcQddJGl2ngvNiJyxd8krQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742258438; c=relaxed/simple;
	bh=aF1eAkjgcCapdV4LaVeUeqIvJD+3wVpYt9I5HsPkM5o=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=WgO7AO71mt3d3bkNayDdyvOSNW6xsnY2V6iy/YEf6bR3lBOpAY2d6Ok+GsP/XRsb/EApWoy7FiNSc7OHuD3GLfs3QrUl0YYU1nu11UuCxFc5b1BPd8xbiLTC+EN0fUwigv/tp3npU2fwPY8n0qj+ro6WCTbTjc0su0Zw7Q6Fct0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=gLoT46HU; arc=none smtp.client-ip=209.85.161.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="gLoT46HU"
Received: by mail-oo1-f54.google.com with SMTP id 006d021491bc7-5f89aa7a101so1975082eaf.2
        for <virtualization@lists.linux.dev>; Mon, 17 Mar 2025 17:40:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1742258435; x=1742863235; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=9vQclP5cvHTI1P3oWqFAri9BqwPEN+gIHprekZKw4CY=;
        b=gLoT46HUXbSdqBcSz5iwtZC0CGF/5UQSddAvGK4CtmFJJVna+dvlN7sVKUijGDA41z
         MmfQt2Qx0N7k8NUf0A/X65wiYfFU5mFvAzUNAmhYVa1wS2LNsUST1/vG2sxEeQmzu2ei
         bVhfVHpXQGm/xbCnG/ebknkdK1xqmWifR+THw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742258435; x=1742863235;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=9vQclP5cvHTI1P3oWqFAri9BqwPEN+gIHprekZKw4CY=;
        b=Kgpu59T06LWXVC0XkR0YqWfQgZumdfgyVNDuC+rPOvr9lMYeBWeOSh9Pb5JVoFinjd
         f8RdhS2k+WSt5G8G9XUOxE3R/khdhYV4SKVbCPqQe3uTolD1SEm6xDH7STrD/hbwFyD9
         69THNhZNqthW6wl72wGIvBm19Ncy7+STztXP2P5sSFwFnUW/1WaaYVtvdYhGFhBTsCB1
         uaqJT2srEmQcdlRWnG2eam8M7mfM8/4BrY63iniOyYIYITYqsykOsgw60kztGWJqNEUB
         sg2nGYb1Hqw1VwwTpHgacJ7qoOIPp5qH9RGAF5Hl7tfADi6fyTmnr45+EOmbgAkBqtGj
         7zhw==
X-Forwarded-Encrypted: i=1; AJvYcCV5HojVWBiUBQRr8oP7UOstR2nDmLGJm5KjFkeRBwuVLbtIlfu7XUQ/euRAvt2+qdBJqbFRNE8BbZozP7MSDA==@lists.linux.dev
X-Gm-Message-State: AOJu0Yy/Vi2Ob59rp6X7NONZabJXxZsWooITRNDRBROsSTEmECxpkOP2
	hIrLMpy9btFmreoIXFLr+kg9RlBGuFnn9wRSTIJ+DehD7vUZg5jAX5ebb1n8WW+IYrEv/UvJmt0
	=
X-Gm-Gg: ASbGncuN0O4WTkTz7muoZTAnsX29NoChgYLtBcZLJGZONq3NfNGQehVHHMDu2I8/uFD
	Rk8BllRerkADuW+vxuJpVHHTei6hZwhFegre7++H2B7pRS3i8fp+qlGGWTSw6Wlg9EH6OvUksZn
	UI+cemK8/A2G2bCBteNEIB15amK1Srs0d6z5af0kDGjpkIb3bxNv7XI2A35HuYd2Xp+WREmFcDK
	tWLXRjoSSf/IZMolnPBnbCoKMMQXuD54LFZ5pFusqynrnZphkd4CJwVuvnS63Dw7KALZd9P4C+s
	Ve4Sg50yAyfpLgojnGhsZ4Uh/NoEF1ebhnHaRPNpEscQto6iX/jYzkcMkA3XYD6rU7RHnI5ZtJv
	iO13rFOJ4/jmrcO5qValrDfddAw==
X-Google-Smtp-Source: AGHT+IHIaAa69q2Z8ANXe30r/tizHQHT896S2VWLzIZ4VMEnQe4ojb43pU2xocXU645TgXl4SoKLuw==
X-Received: by 2002:a05:6808:38cf:b0:3f8:cf10:f113 with SMTP id 5614622812f47-3fdee36f68fmr8838131b6e.5.1742258435416;
        Mon, 17 Mar 2025 17:40:35 -0700 (PDT)
Received: from amakhalov-build-vm.. ([192.19.161.250])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-3fcd5c0007esm1999044b6e.37.2025.03.17.17.40.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Mar 2025 17:40:34 -0700 (PDT)
From: Alexey Makhalov <alexey.makhalov@broadcom.com>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	virtualization@lists.linux.dev
Cc: gregkh@linuxfoundation.org,
	bp@alien8.de,
	ajay.kaher@broadcom.com,
	Alexey Makhalov <alexey.makhalov@broadcom.com>,
	Konstantin Ryabitsev <konstantin@linuxfoundation.org>
Subject: [PATCH] MAINTAINERS: update Alexey Makhalov's email address
Date: Tue, 18 Mar 2025 00:40:31 +0000
Message-Id: <20250318004031.2703923-1-alexey.makhalov@broadcom.com>
X-Mailer: git-send-email 2.39.4
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Fix a typo in an email address.

Cc: stable@vger.kernel.org
Reported-by: Konstantin Ryabitsev <konstantin@linuxfoundation.org>
Closes: https://lore.kernel.org/all/20240925-rational-succinct-vulture-cca9fb@lemur/T/
Signed-off-by: Alexey Makhalov <alexey.makhalov@broadcom.com>
---
 MAINTAINERS | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index c9763412a508..c2eb78c1ab75 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -17945,7 +17945,7 @@ F:	include/uapi/linux/ppdev.h
 PARAVIRT_OPS INTERFACE
 M:	Juergen Gross <jgross@suse.com>
 R:	Ajay Kaher <ajay.kaher@broadcom.com>
-R:	Alexey Makhalov <alexey.amakhalov@broadcom.com>
+R:	Alexey Makhalov <alexey.makhalov@broadcom.com>
 R:	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>
 L:	virtualization@lists.linux.dev
 L:	x86@kernel.org
@@ -25341,7 +25341,7 @@ F:	drivers/misc/vmw_balloon.c
 
 VMWARE HYPERVISOR INTERFACE
 M:	Ajay Kaher <ajay.kaher@broadcom.com>
-M:	Alexey Makhalov <alexey.amakhalov@broadcom.com>
+M:	Alexey Makhalov <alexey.makhalov@broadcom.com>
 R:	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>
 L:	virtualization@lists.linux.dev
 L:	x86@kernel.org
@@ -25369,7 +25369,7 @@ F:	drivers/scsi/vmw_pvscsi.h
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

