Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D11015EFB1
	for <virtualization@lists.linux.dev>; Mon,  6 May 2024 21:53:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715032436; cv=none; b=AM/wzGEa5EbaU4gz8d7N1RsBUS5yIp6gE+51lt+ThKltC2M8WL/K1R/83JtelD1MvVXaF/n7aUAaNBCH88Lj+cXWXqRLO2zcmdumo7W09ba73pCUNnbnBnkNwpdp076g8ARI9/Xsl+XqCAY+nPsy1mlgFSmsbUmRjUg9e3+W3Bo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715032436; c=relaxed/simple;
	bh=BTdB/bKcsgIg8SG05ME4z6NR7Hf/yomiKs5wTQl9JKw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Sqo+8JMlMpVA9khQ64aQ16XC0EdG2GkclRrmeCuXABW7D7OwBz88Abnf9kjCXwSr5+P6Qz3GqkvTibvBEACOJK7ZVJUZd4YCGBWpZi2ch/6/Jxoi0bLNZ6hHrvrtNGDWMUJcYbKjneZ6nqJILK8qJsNR+IG+qdPdgU4htC0Eomg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=QehefuFS; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="QehefuFS"
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-1ee42b97b32so8221415ad.2
        for <virtualization@lists.linux.dev>; Mon, 06 May 2024 14:53:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1715032435; x=1715637235; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4fIJKpP9PuqIwYQVQAXhh3lvsNULoqRv8W6dHtBpvXk=;
        b=QehefuFS+aFktUpvAaEO2dfYLqlOriTfkDG5+9fvqUi1YAUJgaQLMewQU+Wnpd5rNc
         VwbMoMhsAHRL7FsNJixBJ6BKRhhLPVjft3oaJen7jUZvreH6Cvvfa9S60qIpL6FHq8h8
         YTJHjjgie5GW45XZRBnMxf6TDvimbt4jl/ud0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715032435; x=1715637235;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4fIJKpP9PuqIwYQVQAXhh3lvsNULoqRv8W6dHtBpvXk=;
        b=queWnYDTuspfoDwtnFNf7TaxKvKg0JpQWJv5dHFrLgKdpwi707NJD6iCXG0dnrz3ds
         QEc5SkaAhrptO1kevUsLGR7nmlhWAaStLvbSXQC3pOUgDfSBBn9llQY8QI1JR4vmbWpp
         +6btrK4wP9ZAMS3O0YI5YU6qIyxGoqt96R9yj33f1PEuOxEINbiZCc+iE54cVIddxG1x
         loqq/1+qh/vewjblDmFXX5aJ7G+UJGR1475oFJ7xGogRTXfEuddv1G1mh+I/3AV3DsC8
         EPAinuKyt5wUaDA/GKdwZJcmvDFYjkf8pgrX4g0nIWcKtHMJXy+MMSttzJEotrn1iT1Z
         +I2g==
X-Forwarded-Encrypted: i=1; AJvYcCXV925oBOaMeMX2DeWI2FCvGVvFkBtbcClgQaHiFfHqIDNReONkhqMAlOQ3VnfFCeVKnpYzpr/vL9opluMM9oG+DKpVrCKCGjRym6b7AUA=
X-Gm-Message-State: AOJu0Yw7mapQ4zPEYAxNQPjwcKPsuBqJGvR4FLTBty5L/gsGBsbdjcdw
	VTXyFZO/FyqYLpmZE/fzhkGJzJDqFxTDBlkhvSASgmXU3zMLgnPJNwCdwjDHRA==
X-Google-Smtp-Source: AGHT+IFyWv+jxb29t05zzSKDmxjDVEWVQ7r5yIdjW5CDcL456PzBbnI/9joeCaGDokUA59UoiPatEg==
X-Received: by 2002:a17:902:ea0b:b0:1e4:31e9:83ba with SMTP id s11-20020a170902ea0b00b001e431e983bamr13602030plg.1.1715032434870;
        Mon, 06 May 2024 14:53:54 -0700 (PDT)
Received: from amakhalov-build-vm.eng.vmware.com ([128.177.82.146])
        by smtp.gmail.com with ESMTPSA id h8-20020a170902f54800b001ed6868e257sm5664008plf.123.2024.05.06.14.53.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 May 2024 14:53:54 -0700 (PDT)
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
	timothym@vmware.com,
	akaher@vmware.com,
	dri-devel@lists.freedesktop.org,
	daniel@ffwll.ch,
	airlied@gmail.com,
	tzimmermann@suse.de,
	mripard@kernel.org,
	maarten.lankhorst@linux.intel.com,
	horms@kernel.org,
	kirill.shutemov@linux.intel.com,
	Alexey Makhalov <alexey.makhalov@broadcom.com>
Subject: [PATCH v9 7/8] x86/vmware: Undefine VMWARE_HYPERCALL
Date: Mon,  6 May 2024 14:53:04 -0700
Message-Id: <20240506215305.30756-8-alexey.makhalov@broadcom.com>
X-Mailer: git-send-email 2.39.0
In-Reply-To: <20240506215305.30756-1-alexey.makhalov@broadcom.com>
References: <20240505182829.GBZjfPzeEijTsBUth5@fat_crate.local>
 <20240506215305.30756-1-alexey.makhalov@broadcom.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

No more direct use of VMWARE_HYPERCALL macro should be allowed.

Signed-off-by: Alexey Makhalov <alexey.makhalov@broadcom.com>
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

