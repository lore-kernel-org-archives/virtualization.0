Received: from mail-pf1-f202.google.com (mail-pf1-f202.google.com [209.85.210.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FB881362
	for <virtualization@lists.linux.dev>; Tue,  3 Dec 2024 00:24:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733185454; cv=none; b=cePc3DTI5qa9pMHaE3qrNWo8r+lI3cxCjkM72gPAwTz3IoOxG9B3CB2VbJPo2jVQKH5rsQkENJqElkAZGHdu6+Zv8j4slvmW5cHeRDGWYk3am4HlPV1Iw5YYZnSitUlnP2+/v+wQa6/TAYZqpO3oKXdaKy4GF1qqV2cKssZ2edY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733185454; c=relaxed/simple;
	bh=PdsVFCQYAE/sv+UsjYSnw0UjlyMnxIcK5DXw6edeFJk=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=sV/8cjeiBprG2AkBfLS29QY0Kby9Yd6Lc8ZxYrApu8GI6CpidpNvhkRir4CLo/Ey4sVpUSNltCoa0qKGtwcBFzuIVXPkc7XvTn7CR4INyfU78olu//bcAJGAUmWq3YKfeBLP3aDuAugz84hdx1hTD6cyDba1Z46/tuoLRK7TNxY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--yuanchu.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=qEB8WXDF; arc=none smtp.client-ip=209.85.210.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--yuanchu.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="qEB8WXDF"
Received: by mail-pf1-f202.google.com with SMTP id d2e1a72fcca58-725126e7da0so4491077b3a.1
        for <virtualization@lists.linux.dev>; Mon, 02 Dec 2024 16:24:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1733185452; x=1733790252; darn=lists.linux.dev;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=+TsiFxHi1VF1XagXj5qBJT0OVJosUppxUogJhrvvgIg=;
        b=qEB8WXDFRMjqt+lPUwNkHnwlKQA8zPwZnty2x90aOuPA+kPcssX3Ct0OODSbH8OelS
         p7wymKqJ/KdFIlsgPvYOgWJ5rhMhDSM1tE96e5CJIQTEuMBXAtrym3abwi43ERuvyvI9
         r5ESXMoMa+9pqr4S3ho1eQ1PoSX+KP3bb4JIKobp/C+g5ikwht/BDHa4ZGM1jhrYdluu
         H4HLmrYzCdfuHB6AU6MTTb/fsccPBUqLAb8tpgI/mT60QyKXLuWU147AEr1WvxnW8jyN
         CUzLpY28Se4RZpTBIr1JDRcl/dvtGExyS9F5r3abjL5qnwTNj0Ll3wPYI8rlnsCZ2XPz
         Dd/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733185452; x=1733790252;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=+TsiFxHi1VF1XagXj5qBJT0OVJosUppxUogJhrvvgIg=;
        b=WyBV7k2ND9vQn0p9FYPrgKdBCl471lXu1QbVU9M6UOFxwv5jlFYrhRxgPVcbJ7eOtF
         B+w8Epbg6Nq+qU40TL2eo1ePxWunLXcG8xYd43DO3FFcTkjNbXh5WAo7R263DJ27JurD
         JTdCq4V2jlyPL5kkRSeLK/NO/JjEzNjz+VcAO5OtdLDx8FuuO0t6DSJfgN0JhtZe9TaC
         fTPmgh7XeWfXk9i2UmHQ1bS6i3XcH2xYGJgTparmkU+I2xA3wpCJsrv2gDOrJZRMQtYo
         MiUWCEQTv2QjhArbhioedNUy2ucmEREmO/OfIgV1avlaydqrpINTwsZB91K4ed/aNui3
         jW0g==
X-Forwarded-Encrypted: i=1; AJvYcCVGG1Lqbmh7a4r4xXarevrRuKhb4EaKLgAJeZ3bO6KelQLMVGJi4WkpkdIU5PB4PdE8a+Gnqu8ufYGa7bn5mQ==@lists.linux.dev
X-Gm-Message-State: AOJu0Yz5SSbMeNBt+wQcs2VNL4uw3Odd3zNahqaIAQz8pNd7H1n+St4W
	GlvRyn+Ud5fFqM9zfcOl0ru5Kd3MQ9br77v0lDb1TdRY8fv68M+gXcOX9gIvI2jfS9pMcUHWJqw
	k6fBt/Q==
X-Google-Smtp-Source: AGHT+IH1YI5TryAw2nTRBP/xW56Am59du2xa6FfKQesWVivnYYo3eiklKbzBqxct7qqAefyOGK+9SC1oss7A
X-Received: from pfbeb28.prod.google.com ([2002:a05:6a00:4c9c:b0:725:44a1:b5c2])
 (user=yuanchu job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a00:2ea8:b0:724:fac6:35f2
 with SMTP id d2e1a72fcca58-7257fa74556mr456519b3a.9.1733185452519; Mon, 02
 Dec 2024 16:24:12 -0800 (PST)
Date: Mon,  2 Dec 2024 16:23:28 -0800
In-Reply-To: <20241203002328.694071-1-yuanchu@google.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
Mime-Version: 1.0
References: <20241203002328.694071-1-yuanchu@google.com>
X-Mailer: git-send-email 2.46.0
Message-ID: <20241203002328.694071-2-yuanchu@google.com>
Subject: [PATCH v5 2/2] virt: pvmemcontrol: add Yuanchu and Pasha as maintainers
From: Yuanchu Xie <yuanchu@google.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Wei Liu <liuwe@microsoft.com>, Rob Bradford <rbradford@rivosinc.com>, 
	Pasha Tatashin <pasha.tatashin@soleen.com>, linux-kernel@vger.kernel.org, 
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
index 1e930c7a58b1..92db5dcf0212 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -18894,6 +18894,13 @@ L:	linux-wireless@vger.kernel.org
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

