Received: from mail-pf1-f173.google.com (mail-pf1-f173.google.com [209.85.210.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E88C1D7E5C
	for <virtualization@lists.linux.dev>; Thu, 23 Oct 2025 01:00:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761181229; cv=none; b=MIs2Cf/BHZ99w9av29n+RaWbfxBmUv9W5xA1l6pNSgZqiQExMxifd01LRb90WvxeGyv8A79V7ZVOwFB8Cw6t+6mBbK9+7NbV2mwDvdjnLFexR1cGwRJ7asHJxuA2PrtNTPsQbNEF+v35QRi8YZe39icZjDEH/oco3BL8OtGPLv8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761181229; c=relaxed/simple;
	bh=WLRIEtshDzL84rzcliCGLW0ha/QAvCdjX7baGObipwo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=A26rMo+Hj5ScJUTNr6pujEnQzrCnUI+x9PW/6L1qULPP7i4Y1cSu5NNzFaxSXbu5P6O8mx6ZsSYbJpnAxh9vKHI4SWsKBsYi0cRQrYa7oUQ26bZKxBGjCG18fs6AEPHPosYkALMF/4vhdE5/UraIi//LX1miudeJc1GOV3yp2uM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WzOU9aUP; arc=none smtp.client-ip=209.85.210.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WzOU9aUP"
Received: by mail-pf1-f173.google.com with SMTP id d2e1a72fcca58-76e2ea933b7so222915b3a.1
        for <virtualization@lists.linux.dev>; Wed, 22 Oct 2025 18:00:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761181226; x=1761786026; darn=lists.linux.dev;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=qRr57c0ypvpAqUCBQClyFAT6EHQRTScPRNGmNmK0UxI=;
        b=WzOU9aUP5hdVgeMD6tCiNJhi2Elz4yBUFuJA/fCJeHKG4LhYZr5g2GeUF5zy/5rgHl
         yYWY/TmpsfSHTdaTm/AcEYqim4i0JTn78HAd/PFQzFCrhtvXm752TDO2GeTMcVC4WX22
         8fwoevkYFQ2ktxCPhovwu8WxZbjrTrICNv75Z+9SxQiGTPK2mzGPbOgss7XltKy5tS6y
         tyYyV/8wobP5uSC+22+vtxcIy7yefbXnc6jp7KG/+WIMVD3oMMRrESPgJRdqA+v7V3Y9
         xTvM4gaav/sppKIsh7sD5VOT6JuOfGLq2mA7EmBjaneFebjLktFESfe5BvPugMrkkafC
         ma1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761181226; x=1761786026;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qRr57c0ypvpAqUCBQClyFAT6EHQRTScPRNGmNmK0UxI=;
        b=kQrPjfkq8NHOp4e66BRh3tfXaHroS1iQqFy3oECWEdDTEwxfjDJehXvEOfNU3vyWcV
         5MtjeHporTHBbZL3GgLR8cvI8XkJFZyUQ3SJtLFGGh/7Yw5dAqEP2KRArq068w/UjOvo
         LeRZ4FnN83bOEXn9rvn8CXF71n1tfQWme+klsQhoKC3rc2PN3Rq0m8WzVIEAvo2cmtDj
         x1teP2FM+6p9/xEhRV3Vc/PXgrs+sJ6lPay7IW1P3/fojMVk4p5jQGvZ+kVmjKigPo69
         Bj1qLfYsBQ7z2rvaeShEq9x5P/ScILbIkGvu440077WHSoFPOurjHCEs1C1S5dkojkNr
         8Kqw==
X-Gm-Message-State: AOJu0YwT/LeNL/od+nGUHJf45Wrxcn4YSsPOYHcjbJof6n86CbQP2Lk0
	ZSJICxkT/6/ZpWFBPqQEa6dEXNApuR0se4WYF9IHbiYws3yvmEmkJNFRq7sNucTF
X-Gm-Gg: ASbGncur5oVTMeHnBi+2uvVqKLx/86Nin66NfTTRyLYpXbTGTkj75IZv0jOzqWOPwQv
	2NTwNOX3sH3MohMxgjRZOTDk2kCw9nNukFbn/KWku5CMXy6zVps1VTQENac3+ArIpW+1LBVRsRc
	Ca05GzHxn9gkzqeR2lN3n1K7Of/xY0HofsUBsAVP1qkd0QxGhK7jEm90R0v5JWryZ12owO09B8l
	kZh672ZmGIMDlfjVeVtzrhmklZdaUVx/RtYWUr6KOPsyxIqNA02+HTjcOwZ8QmbKZLjFx8LdOZ8
	4DETNTzIBrTpaZP05PxOGlg8OmFhTOo+Vxu7F2ZxVB0o2OJAFzDp+OjrpnEXLRyMw9+vMO6pK6X
	sxZC2v5KTsiez/NkKG9egvSG+uL0s9+FuCdPe0WtwBg8BTgX2Dl1SRIhPtiWBEgl6dbf4Wd/0
X-Google-Smtp-Source: AGHT+IHg3+CWJSd/e6BOgzi+f6DN5y9Cs7OSFyBJFrkPqO6Uo3OZWXDmlV8rzUOGTzBmE/tvar48Sw==
X-Received: by 2002:a05:6a00:859d:b0:77d:c625:f5d3 with SMTP id d2e1a72fcca58-7a26b3137a2mr3513332b3a.1.1761181226239;
        Wed, 22 Oct 2025 18:00:26 -0700 (PDT)
Received: from localhost ([2a03:2880:2ff:5::])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7a274a9ce15sm576231b3a.23.2025.10.22.18.00.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Oct 2025 18:00:25 -0700 (PDT)
From: Bobby Eshleman <bobbyeshleman@gmail.com>
Date: Wed, 22 Oct 2025 18:00:06 -0700
Subject: [PATCH net-next 02/12] selftests/vsock: make wait_for_listener()
 work even if pipefail is on
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251022-vsock-selftests-fixes-and-improvements-v1-2-edeb179d6463@meta.com>
References: <20251022-vsock-selftests-fixes-and-improvements-v1-0-edeb179d6463@meta.com>
In-Reply-To: <20251022-vsock-selftests-fixes-and-improvements-v1-0-edeb179d6463@meta.com>
To: Stefano Garzarella <sgarzare@redhat.com>, Shuah Khan <shuah@kernel.org>, 
 Bobby Eshleman <bobbyeshleman@gmail.com>, Jakub Kicinski <kuba@kernel.org>
Cc: virtualization@lists.linux.dev, netdev@vger.kernel.org, 
 linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Bobby Eshleman <bobbyeshleman@meta.com>
X-Mailer: b4 0.13.0

From: Bobby Eshleman <bobbyeshleman@meta.com>

Save/restore pipefail to not mistakenly trip the if-condition
in wait_for_listener().

awk doesn't gracefully handle SIGPIPE with a non-zero exit code, so grep
exiting upon finding a match causes false-positives when the pipefail
option is used. This will enable pipefail usage, so that we can losing
failures when piping test output into log() functions.

Fixes: a4a65c6fe08b ("selftests/vsock: add initial vmtest.sh for vsock")
Signed-off-by: Bobby Eshleman <bobbyeshleman@meta.com>
---
 tools/testing/selftests/vsock/vmtest.sh | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/tools/testing/selftests/vsock/vmtest.sh b/tools/testing/selftests/vsock/vmtest.sh
index 561600814bef..ec3ff443f49a 100755
--- a/tools/testing/selftests/vsock/vmtest.sh
+++ b/tools/testing/selftests/vsock/vmtest.sh
@@ -243,6 +243,7 @@ wait_for_listener()
 	local port=$1
 	local interval=$2
 	local max_intervals=$3
+	local old_pipefail
 	local protocol=tcp
 	local pattern
 	local i
@@ -251,6 +252,13 @@ wait_for_listener()
 
 	# for tcp protocol additionally check the socket state
 	[ "${protocol}" = "tcp" ] && pattern="${pattern}0A"
+
+	# 'grep -q' exits on match, sending SIGPIPE to 'awk', which exits with
+	# an error, causing the if-condition to fail when pipefail is set.
+	# Instead, temporarily disable pipefail and restore it later.
+	old_pipefail=$(set -o | awk '/^pipefail[[:space:]]+(on|off)$/{print $2}')
+	set +o pipefail
+
 	for i in $(seq "${max_intervals}"); do
 		if awk '{print $2" "$4}' /proc/net/"${protocol}"* | \
 		   grep -q "${pattern}"; then
@@ -258,6 +266,10 @@ wait_for_listener()
 		fi
 		sleep "${interval}"
 	done
+
+	if [[ "${old_pipefail}" == on ]]; then
+		set -o pipefail
+	fi
 }
 
 vm_wait_for_listener() {

-- 
2.47.3

