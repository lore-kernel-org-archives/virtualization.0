Received: from mail-pf1-f179.google.com (mail-pf1-f179.google.com [209.85.210.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3DE122FDEA
	for <virtualization@lists.linux.dev>; Thu, 23 Oct 2025 01:00:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761181238; cv=none; b=iHl6Vu/046ECzdz/CM5p1MhjJ25W1Y41MmTOrU5OV7hZ66ZrmSJ0sPARF6Z2ku2aO3ReWpwTCsyXejz/Z8f2KprsQoLerJ2kZYRWGGMzIbwkUfeV4Cvj3QpXRmFb/+eqzb+dNzyeU9sX4enKCn8N9yHaVbizwjwOlP6xlxUW0bc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761181238; c=relaxed/simple;
	bh=pCmUOoe9UEmIapGX09RMEqNq2xABcKupn8YH5c6OHyk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ErMFUxWpiRXtX0b3mh20CFC2QcZ75l4YMRxxDUmERCFPvxWjsYu1iXgaVIEhyjkktpJhP+ODrHrKSar2f/VHEHpEjkxW1n9b0xMxRc1HARmadkGwQbxL8txMh6DhvC8bo6XTarmKuC6JFtn3UhqKgFQ3C9hqRacmm99OCJfY7h8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lD33J8XQ; arc=none smtp.client-ip=209.85.210.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lD33J8XQ"
Received: by mail-pf1-f179.google.com with SMTP id d2e1a72fcca58-7a1603a098eso161978b3a.1
        for <virtualization@lists.linux.dev>; Wed, 22 Oct 2025 18:00:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761181235; x=1761786035; darn=lists.linux.dev;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=kIqQl1yXpGD0T6lxJ76Go260cGhEq3Pe6FtGbdnc7zE=;
        b=lD33J8XQdg0Y8ZYpX/FjAo9boNkvy3GQjc83krbxhD56EzZfRTyvpivbV5doL8P0zQ
         c5y0+dTsh3tTjSApYOJBM8NRZpL+vbi57pLYEnKDWLX4SVrrn/l9mONQmzJIr1hi5CDZ
         x963CSR2u3HcQsR8bN77x/FymOWM2RHR9QfvmNWVFxjUGc8R2gPlLr5xnJllMuGlj6NX
         s6XkdEUD+PojdFCSwWWoUZAdvvOM1jrp9eYzSEgjBJnogWuYvCbomaqrUiIF9eFPHv+0
         Uy3oH2ladd/VWbpJLTT0TiPig5oKDxj4Mu2MjilN7adrFPxfLrr6nuXODbVplz3PZ6Ht
         kHHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761181235; x=1761786035;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kIqQl1yXpGD0T6lxJ76Go260cGhEq3Pe6FtGbdnc7zE=;
        b=R/Ei2RHDUkh6SztgHMRDdsrF5rYM1LSo6YvEa5xD8zKagtDiP2Pl+qpXkrn/Yp/rcD
         xqAF5CdV6psMsglAXfJ1InvCk3xjaTPCmuAoaStbeuiA9+UQEqVxJni5FJUMkZGHVUFb
         GmiVQv7DF+VQtLWu4a6UJQUsAlbm4fFfrOipMJXjG8N4cvBcTJAS41HSUhpCKlpemPHz
         F+8Oh8dK/TjZReaNkJcuoP3cX8skbux+oLuAbIM2VTGR1RBXPjNd7pxZkBHMZiOi5AWP
         P/+vmlL6+E7YQfD42uGXGBJaRigoBQXdUCn62qewj1ujL9ID6whVPBuA1HpUNSomuaMs
         tAQg==
X-Gm-Message-State: AOJu0Ywa6VXFHeed3LoxYr9Ks0GcBj+HQjThHdtZgCCCXQkkZBgrTtps
	4Pe55sO/aPrfASi+wvD3Nzf5BWCSJO5aELqrAIjlacVYoJLmTsnoTGYpZyI9hxmH
X-Gm-Gg: ASbGncvlJ6YnhKIB7e5d3qEjM7eRgM9Rz0az5Spn1t1gKvFmOffZA8Qccd3Kv99Bq3D
	lUfq4P8n20Gg99jgwWYqFhLzaZYVUaGb9DuWpUt25NwGFjnQYy/WTEF+axZdb6m/630iQj4wOjq
	S1Oy13VRV8FCYDqNsCVBAcLYvBqgksVFyRc3OD65jAl/qHsPJBBUgHVGZe2JV4ofb6gyynqM0S7
	rFEBKblecb2uNATjPdAKNhHdLPlOZqpF6Rv+KayhhOL+NBs8oAYEWUJ9z8id1q2rSaXyOGX5Gm3
	U66bjMO6jQ+qLuCu0nhL2Fd04wQg21ZwRlEPZoAU1C4HXNgq1L+qvahKcs/HyjASq7DIVxgS1Wc
	bGGyV42aN40Nxy1jyrlqKBQFWDRIU7e21yplmOOLNO7nug0dJD4LWlH0VtzbXb6NDtdafTmrXo3
	eCSDD0SuiQ
X-Google-Smtp-Source: AGHT+IFah4xKWnPJdJQRrSTe40MUJQKUAPG67skaDGCDDAujY8FssP4vUeP2QuBI2KiQcE2PGKu37w==
X-Received: by 2002:a05:6a00:2301:b0:78c:99a8:b748 with SMTP id d2e1a72fcca58-7a220144d3cmr26283193b3a.0.1761181234838;
        Wed, 22 Oct 2025 18:00:34 -0700 (PDT)
Received: from localhost ([2a03:2880:2ff:70::])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7a274a9ceddsm584787b3a.24.2025.10.22.18.00.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Oct 2025 18:00:34 -0700 (PDT)
From: Bobby Eshleman <bobbyeshleman@gmail.com>
Date: Wed, 22 Oct 2025 18:00:14 -0700
Subject: [PATCH net-next 10/12] selftests/vsock: avoid false-positives when
 checking dmesg
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251022-vsock-selftests-fixes-and-improvements-v1-10-edeb179d6463@meta.com>
References: <20251022-vsock-selftests-fixes-and-improvements-v1-0-edeb179d6463@meta.com>
In-Reply-To: <20251022-vsock-selftests-fixes-and-improvements-v1-0-edeb179d6463@meta.com>
To: Stefano Garzarella <sgarzare@redhat.com>, Shuah Khan <shuah@kernel.org>, 
 Bobby Eshleman <bobbyeshleman@gmail.com>, Jakub Kicinski <kuba@kernel.org>
Cc: virtualization@lists.linux.dev, netdev@vger.kernel.org, 
 linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Bobby Eshleman <bobbyeshleman@meta.com>
X-Mailer: b4 0.13.0

From: Bobby Eshleman <bobbyeshleman@meta.com>

Sometimes VMs will have some intermittent dmesg warnings that are
unrelated to vsock. Change the dmesg parsing to filter on strings
containing 'vsock' to avoid false positive failures that are unrelated
to vsock. The downside is that it is possible for some vsock related
warnings to not contain the substring 'vsock', so those will be missed.

Fixes: a4a65c6fe08b ("selftests/vsock: add initial vmtest.sh for vsock")
Signed-off-by: Bobby Eshleman <bobbyeshleman@meta.com>
---
 tools/testing/selftests/vsock/vmtest.sh | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/tools/testing/selftests/vsock/vmtest.sh b/tools/testing/selftests/vsock/vmtest.sh
index a312930cb8b7..aa7199c94780 100755
--- a/tools/testing/selftests/vsock/vmtest.sh
+++ b/tools/testing/selftests/vsock/vmtest.sh
@@ -506,9 +506,9 @@ run_shared_vm_test() {
 	local rc
 
 	host_oops_cnt_before=$(dmesg | grep -c -i 'Oops')
-	host_warn_cnt_before=$(dmesg --level=warn | wc -l)
+	host_warn_cnt_before=$(dmesg --level=warn | grep -c -i 'vsock')
 	vm_oops_cnt_before=$(vm_ssh -- dmesg | grep -c -i 'Oops')
-	vm_warn_cnt_before=$(vm_ssh -- dmesg --level=warn | wc -l)
+	vm_warn_cnt_before=$(vm_ssh -- dmesg --level=warn | grep -c -i 'vsock')
 
 	name=$(echo "${1}" | awk '{ print $1 }')
 	eval test_"${name}"
@@ -520,7 +520,7 @@ run_shared_vm_test() {
 		rc=$KSFT_FAIL
 	fi
 
-	host_warn_cnt_after=$(dmesg --level=warn | wc -l)
+	host_warn_cnt_after=$(dmesg --level=warn | grep -c -i vsock)
 	if [[ ${host_warn_cnt_after} -gt ${host_warn_cnt_before} ]]; then
 		echo "FAIL: kernel warning detected on host" | log_host
 		rc=$KSFT_FAIL
@@ -532,7 +532,7 @@ run_shared_vm_test() {
 		rc=$KSFT_FAIL
 	fi
 
-	vm_warn_cnt_after=$(vm_ssh -- dmesg --level=warn | wc -l)
+	vm_warn_cnt_after=$(vm_ssh -- dmesg --level=warn | grep -c -i vsock)
 	if [[ ${vm_warn_cnt_after} -gt ${vm_warn_cnt_before} ]]; then
 		echo "FAIL: kernel warning detected on vm" | log_host
 		rc=$KSFT_FAIL

-- 
2.47.3

