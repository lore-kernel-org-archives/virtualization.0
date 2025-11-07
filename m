Received: from mail-pg1-f172.google.com (mail-pg1-f172.google.com [209.85.215.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39B0A2F6582
	for <virtualization@lists.linux.dev>; Fri,  7 Nov 2025 00:50:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762476602; cv=none; b=g6w26rSKdA5PFkSuuxAqOUrZqMYc66ekiYd5b7lUfBShE6hzgC8M95lz7cgkQ4f/A6JlyJ0w/luRtUUVtXtjG2y/jQxwt3j7u/m7/ttY0ECWQ8jghhy5HTPhBM94xwjKC2Lu2Kf8TQNwRYBLYX+n2TWF3JBOvLF6Rl+8T8rDwqY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762476602; c=relaxed/simple;
	bh=XXNlL9HT6OWyfD6YaISgyik17zuUQszMD6nW7MMjNu4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=RJ+vEEVggOMF7iLO38u/3pYtrXaZQNSVsTPKOt1a/9ot3ghWJdk/oWBhdywRHU/2iHBBBP0Up5p/HDCmx+1P3Ds6vCdTZI+M5adm7uBBH6PbUSavmzT0Fmq+RVFjH2nu/uxx+tlppeOwgfRie2U8jcAVYcrHY0lfQbpmqoezksU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mkRL9/QK; arc=none smtp.client-ip=209.85.215.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mkRL9/QK"
Received: by mail-pg1-f172.google.com with SMTP id 41be03b00d2f7-b550eff972eso125910a12.3
        for <virtualization@lists.linux.dev>; Thu, 06 Nov 2025 16:50:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762476599; x=1763081399; darn=lists.linux.dev;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=qm+iFGtqs2TRCo1fgFDGUjgedOio+kGkQCN5xya41c8=;
        b=mkRL9/QKJWTKz4MBx4fgBX37aNu/jFOsi7q1D7MdsZWMPZlgzY/WxsskgXO0gNxC4q
         +XWgAL/T3y4E02BtYRYun9D0RzE5YYfSJ8bqq4xAmI4nbpJ6CfkhBi0Froz7f8rhvNhn
         lwjlufbkvqoPTVommWCpGYL0JgSTAZER7Z4ttdtCWiZ4TjOKF6zUFQT+sBBtnEbWXzxc
         qTWzcrchMGCPE48kQo9y8DBZqR1kz+KUXk9bKqQ7/nBL+1h7yHGLaGxg16GzEBKaBvd6
         gWmINNJ7qAdmUJ9Ufg7vzvPTatzTs9q79Tzfm3G5ZZyPn8UEk89fuMcLl3PPBOv8PBwM
         0VvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762476599; x=1763081399;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=qm+iFGtqs2TRCo1fgFDGUjgedOio+kGkQCN5xya41c8=;
        b=IXdy1cX/8mOwQvg5EEVDwTHjze0yZ1qzgPQR63eTDA10pN0gmQv8ofZEFTi8CvhpSm
         LgP6a4RJ7AajHNAIMnZiCaJCk6Y5eFh9/dVOIP8TLD6nNS/KqbG/qcMUAIsKz+aPSLL1
         obAl7NxKH7fcps9fe167LkOYEwUfKD4sw7ADO2BbLZRKp4CBpR2E2JEr0PUoE274Y+nv
         Ztmgo4B5SUjAW+fcacwTPV/0+NSnwnsCxjAKw27o/291IDL1tVGxqFsMJOfUNAPkBhom
         CYa3y7q4VStSpo28gLV/nr6WZRWcXdugq5YRffyof6U5oX/GmT1rk0ok0a2MiDm7MFww
         3sqw==
X-Gm-Message-State: AOJu0YwXV8W/ecn+cgXOuNuTRXo3HoNEH6VbS/FSpMUCN+yxnpLlJMwD
	fqHzSo3ULr3vcePEVpmbm8BfDb7d5cGSc/tAgsRWMKo2EBOKHiKn6AmJ
X-Gm-Gg: ASbGnct2zrCujs8JnvG8p20GyfWjTmmqPCyr+Ei3tO9LZB+iHEZT6KnAxk5GIHDyWfg
	3X+C7koaDb4VyH+1A7ITqKyUKy48Fy5Id5UN9MSCawVYfqexmmEU3GAmtAM9bPXSSPddmqfgBKh
	2uzlwBNGrPL2sl4zgtmNdOhi6kwINTZjxmzxqbtAfip82axh1jVhskHiKtMpqkd1Zjwq/RCTRUF
	L4bqkdbEY4TnMkFfxv9cjRE1KXzrpqvV2JcSjknXYAbRjeYyxVWc2NLl/74qnjti/Z6jW0Jwc+e
	bOsESJQZgX0j9WkBJwRT1w2PKr3ybyHxArXe+QXI4SLLwBOXt1g1oHLHSx240qE8X2cHF95NJ0+
	pjKgp45a5FjyTIXO261OnFUzsk4zVgeXJaLw5dTaRattQPySR6KqDP7X2J8csuWlBlDU9K13hcQ
	==
X-Google-Smtp-Source: AGHT+IFOFDetHqDrq/PAxGg+NrZQJpCNEyHjtP9cSvBQ0lXmrGvIWZ7Q8EW8bgf8ugBUgQz3F280Xg==
X-Received: by 2002:a17:903:2ec7:b0:26a:ac66:ef3f with SMTP id d9443c01a7336-297c03a608cmr14724535ad.8.1762476599508;
        Thu, 06 Nov 2025 16:49:59 -0800 (PST)
Received: from localhost ([2a03:2880:2ff:74::])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29651c7c841sm41535535ad.72.2025.11.06.16.49.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Nov 2025 16:49:59 -0800 (PST)
From: Bobby Eshleman <bobbyeshleman@gmail.com>
Date: Thu, 06 Nov 2025 16:49:52 -0800
Subject: [PATCH net-next v3 08/11] selftests/vsock: add BUILD=0 definition
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251106-vsock-selftests-fixes-and-improvements-v3-8-519372e8a07b@meta.com>
References: <20251106-vsock-selftests-fixes-and-improvements-v3-0-519372e8a07b@meta.com>
In-Reply-To: <20251106-vsock-selftests-fixes-and-improvements-v3-0-519372e8a07b@meta.com>
To: Stefano Garzarella <sgarzare@redhat.com>, Shuah Khan <shuah@kernel.org>
Cc: virtualization@lists.linux.dev, netdev@vger.kernel.org, 
 linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Bobby Eshleman <bobbyeshleman@meta.com>
X-Mailer: b4 0.14.3

From: Bobby Eshleman <bobbyeshleman@meta.com>

Add the definition for BUILD and initialize it to zero. This avoids
'bash -u vmtest.sh` from throwing 'unbound variable' when BUILD is not
set to 1 and is later checked for its value.

Signed-off-by: Bobby Eshleman <bobbyeshleman@meta.com>
---
Changes in v2:
- remove fixes tag because it doesn't fix breakage of kselftest, and
  just supports otherwise invoking with bash -u
---
 tools/testing/selftests/vsock/vmtest.sh | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tools/testing/selftests/vsock/vmtest.sh b/tools/testing/selftests/vsock/vmtest.sh
index 05cf370a3db4..7962bc40d055 100755
--- a/tools/testing/selftests/vsock/vmtest.sh
+++ b/tools/testing/selftests/vsock/vmtest.sh
@@ -559,6 +559,7 @@ run_shared_vm_test() {
 	return "${rc}"
 }
 
+BUILD=0
 QEMU="qemu-system-$(uname -m)"
 
 while getopts :hvsq:b o

-- 
2.47.3

