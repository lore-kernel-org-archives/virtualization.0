Received: from mail-pj1-f51.google.com (mail-pj1-f51.google.com [209.85.216.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 657ED34678C
	for <virtualization@lists.linux.dev>; Tue,  4 Nov 2025 21:50:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762293060; cv=none; b=KXGn+Jp0cikSVL3drhZqPV+4LYHWD6hlKDQVtJdc84D+HnMqoze60Zx1O7gYZ9gF8eVRABn2faIilyGxBQX9KWHJbZ7gkLhMpaFPC9YRbVaGDQ0izzV+fFWGe/Q+/nwe0voyFfiOFy/2eX+AQWyUoEqFRKugByqtTemalEIhjCM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762293060; c=relaxed/simple;
	bh=DXUYPNNuTgtHcCDBcDsgLmjkqRHOB4mn9bzaBjoa9ec=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=cGKKb55PBU2uS5vaqQweyKFyueH/w3oSKNLHV4tOb6dVsHzHCGuSQ5xYfVsU5nYJg9odQ6oFEbm7FMSsK2ByCeblBTEkSqXLminNEn6pNHdS7vdUr1rmUlkiNlVaicwOiaX9ttLh/+3Oy3021ty3BdfjgDlAG4gENhlluBJiIAA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FQqqUo+c; arc=none smtp.client-ip=209.85.216.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FQqqUo+c"
Received: by mail-pj1-f51.google.com with SMTP id 98e67ed59e1d1-33292adb180so6442043a91.3
        for <virtualization@lists.linux.dev>; Tue, 04 Nov 2025 13:50:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762293059; x=1762897859; darn=lists.linux.dev;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=V4qMVi7Ntt7sxkPeBtv45SX1Ju34QY/CHb+4bSpnhks=;
        b=FQqqUo+cYS5WiSj7uUFb2V2+UkXuFM7onrdKctHUu7jhCfPgjj9LnBv01IPbIUj3ZQ
         Dc/xlzHZ1Z86TjbobYl7tQ8RqK7URUxK7tXYi1XIKFf/JjxeitZ7ZrMCD+lz9MCf4lOD
         dy616+c70aqIdLRe0Q4tB8WiSiSNh0auSP/zv2WnQVGstQNaFe0yEHVFxhKeem4ePpIP
         WZ3CAkNoHnSjv1EB8bRLNH/x6izla0oarC5Z/sLVYMEwP/eGuGj4jPJ53P8fdaoBR8ID
         EiEueDDJguwmvidnytLdWU1HS3H4AzcMswj9PasPf7AqYOggl7JfkCyBX9e9TT/AA+ti
         uNNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762293059; x=1762897859;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=V4qMVi7Ntt7sxkPeBtv45SX1Ju34QY/CHb+4bSpnhks=;
        b=Y2sLCLCDg9Do3K+C+8vXTASASi0nJr2i0UNug/qQgV35Mt80Zne0h8m2XD7VduWewT
         VeslUFbogAT6xZLnt6JJnpewKpDtbfB5g9gGdPZtPW8U3BJKG0HV9n80bwy3VorCegwE
         qxuvLBLIekewumcyYTPJ6iEi96sfsOgJnMAv2aUXSt+4Rqfy7sAb+BaNH1OwMBvL6Wec
         7ufyzRXr7lpbdnZsoT/1oslWEHnxvmUzhNPcXxVXTJbS/6uXqtufz/iSfW3o7PZ4c+LT
         /5PIpc+QGm9DyJqZ4GBW+5JE1NYBeNhxcVMm1D5Sij1rzqpmVUjd4Ovm1SvZvUKvxJ16
         PTKg==
X-Gm-Message-State: AOJu0YxDwsn4W/zFy0+7nw1ID+1T29jahvheEqPoNKrayrksN8Flzm9M
	A+mmaV0Q/ipJTTcLy0QG6p44pOEor+k6TXOJPAzfHK31vTVCyJwEoPWG
X-Gm-Gg: ASbGnctzqO28uWCw/0y5hFOVY+pm23+w6+2LZ/aEo5ntv8wQnXRgQ8odMLiIVuVP0xY
	9ZS48QHrowmt2nQAe1cTdIL5YtBR4llMX2/Z2D4j6cu42r8e6KEYs35P3MN77RWecLL0E+08POs
	u27JNh3/yknnAVAhWYL2oY/tRcq1+N3mJFksiM27miimVUuYjBzfzLtJ3sLer3oRgHoeBQHsHTR
	/0M8tSBb2btcgYkxfcEcLBThmuzwIkZjl+EKl48idp2Q4x8L+2RJsfMmvyoQ4+3OJextHDRC8+b
	YRR9+FYH4N8fqf1sRMeFgjhbp8FB/QugduVBhZlyxWuvetmcT2yv9nVisgF1i2jOudgTWe+OiKb
	CWFOHMmeHS2PIGudZPcGxYrHHHtpzKBNa3VXvyB8kM1bbONIx+W8U5TSiGboVBsCrZ9v11u0J7F
	n5M4oy
X-Google-Smtp-Source: AGHT+IG4BbWYnk20z2z4/g793VR2Hfh7SdkPN9v4GeXv79P10NM1Wo+bQlbkbGGW0rbOYQrtmo+WPw==
X-Received: by 2002:a17:90a:e7cf:b0:340:c179:3657 with SMTP id 98e67ed59e1d1-341a6e0d9bfmr853384a91.33.1762293058733;
        Tue, 04 Nov 2025 13:50:58 -0800 (PST)
Received: from localhost ([2a03:2880:2ff::])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3417bccad85sm1765781a91.5.2025.11.04.13.50.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Nov 2025 13:50:58 -0800 (PST)
From: Bobby Eshleman <bobbyeshleman@gmail.com>
Date: Tue, 04 Nov 2025 13:50:50 -0800
Subject: [PATCH net] selftests/vsock: avoid false-positives when checking
 dmesg
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251104-vsock-vmtest-dmesg-fix-v1-1-80c8db3f5dfe@meta.com>
X-B4-Tracking: v=1; b=H4sIADl1CmkC/x2MwQqDMBAFf0X23AWTKmh/pfRgk6cuxViyIQjBf
 zd4nIGZQoooUHo1hSKyqOyhgnk05NYpLGDxlcm2tjem7Tjr7n6ctwRN7DfowrMc/LWuH2H86J4
 D1fgfUfU9flNAos95Xp98blVtAAAA
To: Stefano Garzarella <sgarzare@redhat.com>, Shuah Khan <shuah@kernel.org>, 
 Jakub Kicinski <kuba@kernel.org>, Bobby Eshleman <bobbyeshleman@gmail.com>
Cc: virtualization@lists.linux.dev, netdev@vger.kernel.org, 
 linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Bobby Eshleman <bobbyeshleman@meta.com>, Simon Horman <horms@kernel.org>
X-Mailer: b4 0.13.0

From: Bobby Eshleman <bobbyeshleman@meta.com>

Sometimes VMs will have some intermittent dmesg warnings that are
unrelated to vsock. Change the dmesg parsing to filter on strings
containing 'vsock' to avoid false positive failures that are unrelated
to vsock. The downside is that it is possible for some vsock related
warnings to not contain the substring 'vsock', so those will be missed.

Fixes: a4a65c6fe08b ("selftests/vsock: add initial vmtest.sh for vsock")
Reviewed-by: Simon Horman <horms@kernel.org>
Signed-off-by: Bobby Eshleman <bobbyeshleman@meta.com>
---
Previously was part of the series:
https://lore.kernel.org/all/20251022-vsock-selftests-fixes-and-improvements-v1-0-edeb179d6463@meta.com/
---
 tools/testing/selftests/vsock/vmtest.sh | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/tools/testing/selftests/vsock/vmtest.sh b/tools/testing/selftests/vsock/vmtest.sh
index edacebfc1632..e1732f236d14 100755
--- a/tools/testing/selftests/vsock/vmtest.sh
+++ b/tools/testing/selftests/vsock/vmtest.sh
@@ -389,9 +389,9 @@ run_test() {
 	local rc
 
 	host_oops_cnt_before=$(dmesg | grep -c -i 'Oops')
-	host_warn_cnt_before=$(dmesg --level=warn | wc -l)
+	host_warn_cnt_before=$(dmesg --level=warn | grep -c -i 'vsock')
 	vm_oops_cnt_before=$(vm_ssh -- dmesg | grep -c -i 'Oops')
-	vm_warn_cnt_before=$(vm_ssh -- dmesg --level=warn | wc -l)
+	vm_warn_cnt_before=$(vm_ssh -- dmesg --level=warn | grep -c -i 'vsock')
 
 	name=$(echo "${1}" | awk '{ print $1 }')
 	eval test_"${name}"
@@ -403,7 +403,7 @@ run_test() {
 		rc=$KSFT_FAIL
 	fi
 
-	host_warn_cnt_after=$(dmesg --level=warn | wc -l)
+	host_warn_cnt_after=$(dmesg --level=warn | grep -c -i vsock)
 	if [[ ${host_warn_cnt_after} -gt ${host_warn_cnt_before} ]]; then
 		echo "FAIL: kernel warning detected on host" | log_host "${name}"
 		rc=$KSFT_FAIL
@@ -415,7 +415,7 @@ run_test() {
 		rc=$KSFT_FAIL
 	fi
 
-	vm_warn_cnt_after=$(vm_ssh -- dmesg --level=warn | wc -l)
+	vm_warn_cnt_after=$(vm_ssh -- dmesg --level=warn | grep -c -i vsock)
 	if [[ ${vm_warn_cnt_after} -gt ${vm_warn_cnt_before} ]]; then
 		echo "FAIL: kernel warning detected on vm" | log_host "${name}"
 		rc=$KSFT_FAIL

---
base-commit: 255d75ef029f33f75fcf5015052b7302486f7ad2
change-id: 20251104-vsock-vmtest-dmesg-fix-b2c59e1d9c38

Best regards,
-- 
Bobby Eshleman <bobbyeshleman@meta.com>

