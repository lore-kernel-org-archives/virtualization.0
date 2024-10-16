Received: from mail-yw1-f202.google.com (mail-yw1-f202.google.com [209.85.128.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADC982144D3
	for <virtualization@lists.linux.dev>; Wed, 16 Oct 2024 19:40:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729107610; cv=none; b=ZZNTKZBlj9W0rLvW90Ayip4zvOtwoxkAohu9lZXkYjtsDIyF5wQXGy1NT32QA6odK2zkm0MHJITkqTaRLgPPjZsRE7FDxnXHMG31V3q6oa5YpLE1Z38dsq8IXfvMHFAzkI3OqCi7BVaaKp45Pz679NzwpP4i9v3MvmiaPrLrKv0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729107610; c=relaxed/simple;
	bh=brdpjYmJXn7ThpNb9Jl/rpudqX5V0z7rIkZzPSG5KKY=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=fv6N4dSJoJVe3VDTfkFGNFLd4pylloETCe7q9Fgg+5Qbmf5l0YB9Qy6Z+/KlZf7O04StfgLG510+2oBJXAH7zSYYr1SwCbDokzJInk8fIo6OW47qpq/A3VoPFxv+PJPlO6YjgIdGGQ58zKiMvSDPEYEjAtFGHYd72DaJgx2fWKs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--yuanchu.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=PdF8+aR6; arc=none smtp.client-ip=209.85.128.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--yuanchu.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="PdF8+aR6"
Received: by mail-yw1-f202.google.com with SMTP id 00721157ae682-6e389169f92so5683187b3.0
        for <virtualization@lists.linux.dev>; Wed, 16 Oct 2024 12:40:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1729107607; x=1729712407; darn=lists.linux.dev;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=bynrZn787vSIAU/ezJKfwwCMHmL7B1s8v41NnSYH3Dc=;
        b=PdF8+aR6SmRlmiKPLDtRR4jed7oriRdwKacYLV9vhRyU1t02E91HzW53Nrszb3R14s
         hvjadiB34YfOckpGMZ4heB5glDgj4Cvlw+0wWNljyXFi5P+xDTvfnE2FoswucP+G/dlY
         GtypshUwbcyYQMKTiwackSL3ulvMcgSbr5TFCt4NRs/ToiN+EIu6NZdmueN6BQ01NgKL
         A5FcjMr0PMYrjmgeyBx2G/CPMMRoTqLbddZdIk1wsYzmc1c8uDIpgrRBXxTwjbP7YJkO
         JrGqbZvi8UGVQw+zLt0axR7HSYjbQrSKyJhmo5WtH/lRNqKkha2nbLxJ8rVEO8hjWvYf
         edLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729107607; x=1729712407;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=bynrZn787vSIAU/ezJKfwwCMHmL7B1s8v41NnSYH3Dc=;
        b=OFSdxBpmcNyr40EzjGJ4EM5gHCeRROc9yaEfIYoS3jnHC3F1yDLizfv3SRbmYfXlYW
         4CS9xmE2vdiLt2Egk2prweexlA/aKvzJS/ILI+TNmYvTM8XhdMs0E7dRYEUH66Z9MDpt
         4jclwUTPXLN5i7aU/1bF3F+yOzdh84woG5yX3eSSPwpQlZE1Q8zzdhlfocGoXwEYLHIE
         sbj1eP3hnd7jdPFD//VDfJ2sBoLVBoJ7ErHiPba0wbuQ0Lh3IneRl/u8YQR4KPWn6sru
         drYRXeSBHVDfGhQfo6RxAoj8SnWGGZ8TADcnVOUkOzlnUzzTjfDtM/fKTLlAgH4Wh/JW
         tOjw==
X-Forwarded-Encrypted: i=1; AJvYcCVVFkiB39PDEhhJI5M5Gw0KCAHQGmp1rKK3+lYYk5DXU0xIdfZX9laJmqXvyDxyYvyzznE3ivGzf27VDfvdxQ==@lists.linux.dev
X-Gm-Message-State: AOJu0Yw2l6WWfbq+umaU85l3+5qms/KhlwrOI4MqgZLcRT6EeA6Wwyvh
	ADPb76hJQ5CVPFxonQ8/6xpcecAp0oiLsJYvIVWOWivkzr2s3Nmuv6SINGszoPPXV6O8R0qP62F
	rXTsp/A==
X-Google-Smtp-Source: AGHT+IEH6Dg9sYSxl39ijcngJbLw6yN9e0XfWHt8FeRQb2Rg19LkaJCzumI4mMLitFRShT3qz+ALDt4YegFs
X-Received: from yuanchu.svl.corp.google.com ([2620:15c:2c5:11:2793:a280:1184:4a14])
 (user=yuanchu job=sendgmr) by 2002:a05:690c:2fc9:b0:66a:764f:e57f with SMTP
 id 00721157ae682-6e3d41fb686mr66667b3.7.1729107606955; Wed, 16 Oct 2024
 12:40:06 -0700 (PDT)
Date: Wed, 16 Oct 2024 12:39:47 -0700
In-Reply-To: <20241016193947.48534-1-yuanchu@google.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
Mime-Version: 1.0
References: <20241016193947.48534-1-yuanchu@google.com>
X-Mailer: git-send-email 2.46.0
Message-ID: <20241016193947.48534-2-yuanchu@google.com>
Subject: [PATCH v3 2/2] virt: pvmemcontrol: add Yuanchu and Pasha as maintainers
From: Yuanchu Xie <yuanchu@google.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Wei Liu <liuwe@microsoft.com>, Rob Bradford <rbradford@rivosinc.com>, 
	"Theodore Ts'o" <tytso@mit.edu>, Pasha Tatashin <pasha.tatashin@soleen.com>, linux-kernel@vger.kernel.org, 
	linux-mm@kvack.org, virtualization@lists.linux.dev, 
	dev@lists.cloudhypervisor.org, Yuanchu Xie <yuanchu@google.com>
Content-Type: text/plain; charset="UTF-8"

The pvmemcontrol driver lives under drivers/virt/pvmemcontrol. We
specify maintainers for the driver.

Signed-off-by: Yuanchu Xie <yuanchu@google.com>
---
 MAINTAINERS | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index aacccb376c28..5e661f39e07d 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -18125,6 +18125,13 @@ L:	linux-wireless@vger.kernel.org
 S:	Supported
 F:	drivers/net/wireless/purelifi/plfxlc/
 
+PVMEMCONTROL GUEST DRIVER
+M:	Yuanchu Xie <yuanchu@google.com>
+M:	Pasha Tatashin <pasha.tatashin@soleen.com>
+L:	linux-kernel@vger.kernel.org
+S:	Supported
+F:	drivers/virt/pvmemcontrol/
+
 PVRUSB2 VIDEO4LINUX DRIVER
 M:	Mike Isely <isely@pobox.com>
 L:	pvrusb2@isely.net	(subscribers-only)
-- 
2.46.0

