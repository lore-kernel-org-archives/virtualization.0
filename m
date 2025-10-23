Received: from mail-pf1-f174.google.com (mail-pf1-f174.google.com [209.85.210.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6F92255F22
	for <virtualization@lists.linux.dev>; Thu, 23 Oct 2025 01:00:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761181237; cv=none; b=rVu6TcyRbzBl+pWFX7ZkrQSzl42BS8y1IxyrfSx+5fCoOSkYybN3L4WytRE+VlJ1wp7l3uWv8EfavZsqv4H0bHoELGsTtI4/ChCQ+0ORt1iph3GWS+lgYbaJf7x1yc9Br8seXLLUGkDezNzm66eelW3lmGpSqfgk6iiHC5MRYjg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761181237; c=relaxed/simple;
	bh=A7Pia+kzD9m0J27kf4ph64d7fzH2Tfv7wW9zOoywfI4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=rIpzZdkEK8AEMeigAYeCkMtf8ubKuHsdo9zFJ76zCaZGNOwnR4vNkE8LX9ZDVIWyXbvffMmOji7A2/QTJu2bislGUkrT1k18iLc2agGW8+8CIR1cBMDSy4WrZBvYlHqTbsROEoT6YTM4DPX0GIZciFhUawdWlZpCHIxJd5c3blY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZAsEzvh8; arc=none smtp.client-ip=209.85.210.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZAsEzvh8"
Received: by mail-pf1-f174.google.com with SMTP id d2e1a72fcca58-781010ff051so179579b3a.0
        for <virtualization@lists.linux.dev>; Wed, 22 Oct 2025 18:00:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761181234; x=1761786034; darn=lists.linux.dev;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=qHVaMWRrmEBE/SxfIGFnLx0j8jRM6x/KUMvxwGUNtCA=;
        b=ZAsEzvh8duyf8fzAbqlp+/gEJJ6pZwqjvx30qDiBUFMhJZZB99e/uI6WR277B4Z0be
         4TwxWQlS2XbmMRfUHUY2zNoZBgaLWwLceU6FDqOFrPSONHfWUHDQIiyJcqdrImDx2O1r
         HLHYeL5UpfB/6klRmkrbMRAg7zYA1PnANDrN8ztECxLFogUJ3wExPw3Rdm001sfSqa1r
         rjFE20CC67MOOhGVdWYbBK9KYEqJHe/zI25k3TD9ji/AzPB4UCDFuP6mQvDBRYuP1MpF
         sqc0ma/ncI+9nAounS6Eox6U/0Ib7dy47tLs2C0lcDRjTYhpYLacRYlnN7/osIWk0eGK
         5FtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761181234; x=1761786034;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qHVaMWRrmEBE/SxfIGFnLx0j8jRM6x/KUMvxwGUNtCA=;
        b=TdygZ1vIgWYlYN0DpQgBb5ISDCn0v5TqMUp3JzEqn7QQU3NlUzk0Wnkn1jTdggflQS
         uI16+DLB9ANbcMEMw35sYaghXmJzfqZQMaGjCubsIjL654CiTvYdJJl7bi3fr3vDR5gH
         VnQLHGysSDbOFBVGkIvTHGzDEbSIW3GfA5SLRLGP9DsE3xZVYaJdX+m6jsi+IKdKE6Pp
         ClaLMkBXfcCpe73+Bbn/I/5WitnY5JwNkPsikmV9YnOfMOn9qQ7eC73pi//3HBShAAaq
         9FmhXPie9mGb1ckghAWSwEcVMKMipCHeRsuYQVi3VxNaHQa3xOmxVeUiTu6iN12o08Hy
         MaVw==
X-Gm-Message-State: AOJu0YwAeAEu1IE7cH6njOome38ABUPL7QO7N0Z6AH5v+O8IP2ry1LiJ
	q8BdRA0cxVeVkaaBVPJEc8rMIYD1aMOAz6XTFFRW+RNVHdaBCbr/nekoS2EX3we4
X-Gm-Gg: ASbGnctyt5cWuOkTf8kTmb8KIPJiGvhkJRs+nfWT4Oiiauc9b2UR3BRp+6rytSVDiv2
	Kdzgo0KWf9PvHGjVJNPUAORMfsiwOpFVvUS3aSCSdMmLqRBo2yQyFQwt60H7Za5J0IHjKRlZeGU
	hL/Ns1qYAtVz6ZRL3J5IXltTb4ABvnX3jh6pBl4dX2c6a5AXvqof8nZN1GXvQZ/ZJT8G7nqetz2
	0TrLfwzb9zRXnHLWibmFlEUa4pZjQ4q4od8eYdMyWVJpb4F9MFo74iCfQIJFNoZYjpIkkP6Xryc
	LsfrXYAqPpUupyhsEfZDX8TbxIBJRlLcg1CPhchRSWbFX82M/yjDyx1TWgduV+jXCqQ9pK6rpDG
	wNzPgP0OggrKu2R8HwAGs5fK2Gzj7akuUAj1FpYrd/EKmmcqeeggxbn+N37ntA0XhITEVKtqVSi
	uV+aSJV+U=
X-Google-Smtp-Source: AGHT+IF9GCZ5yEahtQVlZaXsqCeQjg9YU+w5E/EIvNEWA8qffUUmtOI33IKw7GAAlLb31mw7tG5+pQ==
X-Received: by 2002:a05:6a20:cd92:b0:334:a916:8b4 with SMTP id adf61e73a8af0-33c5fbaab59mr766832637.8.1761181233861;
        Wed, 22 Oct 2025 18:00:33 -0700 (PDT)
Received: from localhost ([2a03:2880:2ff:9::])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b6cf4c0e4e6sm362737a12.11.2025.10.22.18.00.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Oct 2025 18:00:33 -0700 (PDT)
From: Bobby Eshleman <bobbyeshleman@gmail.com>
Date: Wed, 22 Oct 2025 18:00:13 -0700
Subject: [PATCH net-next 09/12] selftests/vsock: add BUILD=0 definition
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251022-vsock-selftests-fixes-and-improvements-v1-9-edeb179d6463@meta.com>
References: <20251022-vsock-selftests-fixes-and-improvements-v1-0-edeb179d6463@meta.com>
In-Reply-To: <20251022-vsock-selftests-fixes-and-improvements-v1-0-edeb179d6463@meta.com>
To: Stefano Garzarella <sgarzare@redhat.com>, Shuah Khan <shuah@kernel.org>, 
 Bobby Eshleman <bobbyeshleman@gmail.com>, Jakub Kicinski <kuba@kernel.org>
Cc: virtualization@lists.linux.dev, netdev@vger.kernel.org, 
 linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Bobby Eshleman <bobbyeshleman@meta.com>
X-Mailer: b4 0.13.0

From: Bobby Eshleman <bobbyeshleman@meta.com>

Add the definition for BUILD and initialize it to zero. This avoids
'bash -u vmtest.sh` from throwing 'unbound variable' when BUILD is not
set to 1 and is later checked for its value.

Fixes: a4a65c6fe08b ("selftests/vsock: add initial vmtest.sh for vsock")
Signed-off-by: Bobby Eshleman <bobbyeshleman@meta.com>
---
 tools/testing/selftests/vsock/vmtest.sh | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tools/testing/selftests/vsock/vmtest.sh b/tools/testing/selftests/vsock/vmtest.sh
index a728958c58ee..a312930cb8b7 100755
--- a/tools/testing/selftests/vsock/vmtest.sh
+++ b/tools/testing/selftests/vsock/vmtest.sh
@@ -541,6 +541,7 @@ run_shared_vm_test() {
 	return "${rc}"
 }
 
+BUILD=0
 QEMU="qemu-system-$(uname -m)"
 
 while getopts :hvsq:b o

-- 
2.47.3

