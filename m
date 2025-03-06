Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B41BC212F9A
	for <virtualization@lists.linux.dev>; Thu,  6 Mar 2025 16:10:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741277454; cv=none; b=tTaLsLQJ21JbCTiq0wGIQX61gOgqdQ9txKuUSXD3v7XweZD+peTrWapBPPJmF+2+fv6iQEGH954RTJoLMrN6Hw1XB0FJaWe+8qIvaT+8nCgzffbhdkXRI37VOyg0TFdFjlM7SV2rKakLt4ZBhSZYyKJJeOlTZ/3VnLeeVQYkgrQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741277454; c=relaxed/simple;
	bh=0hhfLP3N8asA/s0wef0L8K3outHWOZC2tvRGZLxMAa8=;
	h=From:Subject:Date:Message-Id:MIME-Version:To:Cc:Content-Type; b=Bn4Q6iIsotFBqoxaRNew1+mM3XUIfZ1dUbOIwFs7UmgDxvlhlgs7A3oWVPUGtnvisDTXmNAAdtjbiDIBhUIneEdwyP9xHG4sbx249EItDwchC88+4Cu6dgIhVvgnNh+I26uea8ZR0TVNIKY1DCyMOOsnB0m6G+EBbNUvFeUbwSw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=SouHkH3u; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="SouHkH3u"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1741277451;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=h9R6KO2tPUArbtew5KJP6KvYe+R1MIMLdE3yjt20XBE=;
	b=SouHkH3uE5IO75UWH8Bu3xDoCmLfpsiAdMcCjbbB5Pb+6yVrQR2RgPtO+2LjkyJ/agzt1W
	Pkl6p2vYIEWZ0taxspRhdbkrDpzgtFw6G4qgHhg0AdrHa/3aTMbTq2XTCOZiMaV41NOsZm
	7EMNaHNOzNo/jZurT31xbKyc/V0D1cI=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-654-f-7WUyqmOpaCDUqtSNFB3g-1; Thu, 06 Mar 2025 11:10:33 -0500
X-MC-Unique: f-7WUyqmOpaCDUqtSNFB3g-1
X-Mimecast-MFC-AGG-ID: f-7WUyqmOpaCDUqtSNFB3g_1741277432
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-390f3652842so519975f8f.1
        for <virtualization@lists.linux.dev>; Thu, 06 Mar 2025 08:10:33 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741277432; x=1741882232;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=h9R6KO2tPUArbtew5KJP6KvYe+R1MIMLdE3yjt20XBE=;
        b=eJ43e6YTV5ngfDaFXStluzkZR138DJQ3gH7+MbETIsNxdjqstU/09Nskr5vGl0RdI1
         8H8gZw7oEe4lBtw/bzLFFLfMpEEqgzIcYpMs+NvxHtbRzoG2x/3DEB/cr7w0d+Jplh4x
         HgI0m91J2rKfsL+Vv0xrBaM3+fpxVaeQ0Z77LLBr/vC+m80XStJEC/lMQ3iHz8al1Zuu
         Ior2K5J+K5mE0P2dRSwNrXVjhP2iWoMEXiVG0EwLcGByXMYafatfg2jFhUNc+2xET6Ui
         YPlEyG9TDjIgfhDh5Us9lMS3Ob3eKpkGcD4FdlAuOPcCH7SCh73mlXP4KjzfztyGDyhD
         Kkhg==
X-Gm-Message-State: AOJu0YycapVgK8PYTT7eCYFl02nN6cH1adlAQ2Qixvm5x/n9YAmBwYmC
	LA4u5OYGXsho1nInq+ldKQZl4TN4cDt9YEF3HYsBwWtoTZM1XlGa1Fx+Fz3oF3oCdvpB7/gdVOU
	WiaD9jetyUmddUQeCWjRgpnuzUaVewIN6X4m3v4mL38M0j1NckXr0qDjUqIHBGmsN
X-Gm-Gg: ASbGnctWEm5PIV3GTcMTRYUvnRLDcOugXCfP4muZquvcdk5fpKi8gOLhR04TtF8trK9
	I6l4WPsFbrmkhTc1IrGOW9JqQJ49pYKjgbBf+l8KKRLEyoQk13vqHVeE1qJwuO+U4MXDUoOqrSg
	GYj7YYUMTvTdKYe3JNnlv6LSe8oWnpv/NCPdbPCkR/B1CsLDjFGLCP2FRCeRPiUnA7R7hlerfBA
	WeCVKmMjW/4eJeiVAJ/G7otfSFTAj6ADIEusCb2QyhkVTGzHp8zD2k4K6AKVZueFzxwoLSdulzs
	qplME8rRWxum9OB/WDQ74nlALTsbW2trxzgDiu7GAzG7
X-Received: by 2002:a05:6000:188d:b0:391:21e2:ec60 with SMTP id ffacd0b85a97d-39121e2f137mr6709168f8f.13.1741277431819;
        Thu, 06 Mar 2025 08:10:31 -0800 (PST)
X-Google-Smtp-Source: AGHT+IF5FYdKhrDKr9VvnLfqFE2SB8FkjwaLOL6xy8j1ciLMt8nkQQ/xfgfFd014KVDm0o+whtJTTg==
X-Received: by 2002:a05:6000:188d:b0:391:21e2:ec60 with SMTP id ffacd0b85a97d-39121e2f137mr6708970f8f.13.1741277429756;
        Thu, 06 Mar 2025 08:10:29 -0800 (PST)
Received: from lleonard-thinkpadp16vgen1.rmtit.csb ([151.29.33.62])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3912c01cd31sm2477950f8f.52.2025.03.06.08.10.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Mar 2025 08:10:29 -0800 (PST)
From: Luigi Leonardi <leonardi@redhat.com>
Subject: [PATCH net-next 0/2] vsock/test: check for null-ptr-deref when
 transport changes
Date: Thu, 06 Mar 2025 17:09:31 +0100
Message-Id: <20250306-test_vsock-v1-0-0320b5accf92@redhat.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-B4-Tracking: v=1; b=H4sIALvIyWcC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDI1MDYwMz3ZLU4pL4suL85Gxd41Rz80TLZPNEIxNTJaCGgqLUtMwKsGHRSnm
 pJbp5qRUlSrG1tQDg1LkFZgAAAA==
X-Change-ID: 20250306-test_vsock-3e77a9c7a245
To: Stefano Garzarella <sgarzare@redhat.com>, Michal Luczaj <mhal@rbox.co>
Cc: virtualization@lists.linux.dev, netdev@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Luigi Leonardi <leonardi@redhat.com>
X-Mailer: b4 0.14.2
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: vecjyC2JwtVjPHYA08jllIFj2G32QXL6_NC-1v3qR9o_1741277432
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

This series introduces a new test that checks for a null pointer 
dereference that may happen when there is a transport change[1]. This 
bug was fixed in [2]

First commit introduces a new utility function that checks whether a 
timeout has expired or not without exiting the test. This is required in 
the test because timeout expiration does not mean that the test failed.

Second commit is the test itself. Note that this test *cannot* fail, it 
hangs if it triggers a kernel oops. The intended use-case is to run it 
and then check if there is any oops in the dmesg.

This test is based on Michal's python reproducer[3].

[1]https://lore.kernel.org/netdev/Z2LvdTTQR7dBmPb5@v4bel-B760M-AORUS-ELITE-AX/
[2]https://lore.kernel.org/netdev/20250110083511.30419-1-sgarzare@redhat.com/
[3]https://lore.kernel.org/netdev/2b3062e3-bdaa-4c94-a3c0-2930595b9670@rbox.co/

Signed-off-by: Luigi Leonardi <leonardi@redhat.com>
---
Luigi Leonardi (2):
      vsock/test: Add new function to check for timeout
      vsock/test: Add test for null ptr deref when transport changes

 tools/testing/vsock/Makefile     |  1 +
 tools/testing/vsock/timeout.c    |  7 +++-
 tools/testing/vsock/timeout.h    |  3 ++
 tools/testing/vsock/vsock_test.c | 80 ++++++++++++++++++++++++++++++++++++++++
 4 files changed, 90 insertions(+), 1 deletion(-)
---
base-commit: 848e076317446f9c663771ddec142d7c2eb4cb43
change-id: 20250306-test_vsock-3e77a9c7a245

Best regards,
-- 
Luigi Leonardi <leonardi@redhat.com>

