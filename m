Received: from mail-pf1-f179.google.com (mail-pf1-f179.google.com [209.85.210.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C865B32E14A
	for <virtualization@lists.linux.dev>; Wed,  5 Nov 2025 15:59:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762358367; cv=none; b=jPQRqOmknAKWpq+GQnyBf498ZrGr8d46Bjf0LSY9akcXiEVkd5UX1Y4gbNyNaWI2Vq0qqdnU3zjtK8kgKCtx31HWK4LWorLqJBNqx0jewFNcFVXNCz7RdIJGYXYpIRtWuaJ1Q1QjYpP++CLxlkiaKZgMVdbFTp2/Je3URfuROEY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762358367; c=relaxed/simple;
	bh=pVSfoO/0UIFMSnMLr516HI0z/z9lVuUNXwJAeljB520=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=rf3RRLSbyyEUM0LJWtvY/bb1Fol3PHRIybKJj4IaL/4UhEqYQhAt2jwZm0VPFZhFPJdH67Qbol5FfHoqFFkiuHe7BFSCqMAaDCb5XjJxeNDJQYStiLGZ7dwmI08LbZ+zGokQAZa/6IiamUGiVyvI7gIL7omdNG2TumnLV2QuynE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gsK43YgQ; arc=none smtp.client-ip=209.85.210.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gsK43YgQ"
Received: by mail-pf1-f179.google.com with SMTP id d2e1a72fcca58-79af647cef2so15025b3a.3
        for <virtualization@lists.linux.dev>; Wed, 05 Nov 2025 07:59:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762358365; x=1762963165; darn=lists.linux.dev;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=TcWLW8qdCBVn4955Lh+XqTuvqquYHifTQdNcqINjy8Y=;
        b=gsK43YgQJHwyhWdxLd5v7hZz0/oJLhGgRa2nV2lxmca8i1BLjYjBuCTV63W97f64bN
         RnC5cIl2P+DL09Hjrbr6Qk/7qbg9cXMI91Tbc1+IauOn+pKUKo/lefL4Jk0zzQ5xPZgB
         MF7a41mgu/s30ceQKBUK9Iqxu8tRCnFv59IfZ5j6uKKgEyOmH2mr/0Q3VyHKpWmW1RHR
         2RNd58p0OJLYoJCGK82ehFGe3dVfWcxaV9MEbwQHWplNfdWbj2Wm16lsMEYLFxdwMcHe
         GpwAQPoDakMntFlMQzzrwWq0DUq6sWkkw2fTrwrKtpZwum1rbO9i/b65pKqv4UODPI9S
         +T4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762358365; x=1762963165;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=TcWLW8qdCBVn4955Lh+XqTuvqquYHifTQdNcqINjy8Y=;
        b=jPkXPG/9DbkcvDi8SaR1lJMEEqOQAaJCfxUmRmDtjCYvmJ170e7QNgWje4eKNyVEr5
         emfoRmA7LK31TM46/ge7YyyeaU4VhDGlj66A49fVT1RP0CQ81Bmu56seT7+09zYy+Pqs
         gp3KILLfmR5XIAimISGoGLfmQsfX7HEgdr2zIpr3cC67jEwwF/MOTMONzep6zUcdhePr
         xk1edfo/xYameS1Az6n9XUOM+cGDr3brZKwJL7FNSfDDTf/a4ndrvqcd1mecIB80rCkG
         ctIpl/CWQbixoZcxC0T1111ECAHUMf7z9knfUlkRJxpdL+HD5hFqB2QapKBLXobI+cs6
         llWg==
X-Gm-Message-State: AOJu0YwWWa1d7H1Qqxx8mN/TN8SdDfsr9V+9/MUw4DkVixMIL4QjYaiG
	506K5L1P7H5uohK8f94ZG91nZaw3ugJi8CZd0yvp7omKGOAdwCdkjXRT
X-Gm-Gg: ASbGnctnuiabrlP1p3WjU1dCKseLV7iFqq9L/tJguZhLGTFQ869elewK0W54aOu5UrU
	5hXH7OEOigxG6V54XZKlP1lriySfabs9en8jERlPZ32V7N5ILdcNpFc60bGM4QlZII8zHQgatc8
	JdwH1kUylI6NzvRnml3+FKgoGQ2yVyWIEHh+Z4iQvvLds0VEgLM1Ykq/MkndEEdj2BEHx5RIa7+
	UwzOfooz4jCC5UYiZCrXXIJUOBnHODCPPO6fWQ+2aokDVf2unpzMcz+LE1hH1jhdKxTA+L9NnCe
	13dl58wRpxWkzom7RRsvELhnASXYwUdSWdP52PUlkxKRtCXzSieBblNLRYKIGBI4zNn0VcMLXxV
	Fp1Uqns3ElSoICLc8OrkBbBcWG2Bej74oyzl5dpscm+UmTwxxqBA/1j1S1mZtuZ3AGApFE3y06A
	==
X-Google-Smtp-Source: AGHT+IEe5YQ6JeJmA49ewbcYItDVFikNimAbp/SS4l9S+v7yYwjF6WuYS8I7WYaQuTYcUp7f9KrD4A==
X-Received: by 2002:a05:6a20:958f:b0:347:5ce0:6dda with SMTP id adf61e73a8af0-34f83d106fdmr5164430637.14.1762358365064;
        Wed, 05 Nov 2025 07:59:25 -0800 (PST)
Received: from localhost ([2a03:2880:2ff:70::])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-ba1f2893bc6sm5859917a12.10.2025.11.05.07.59.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Nov 2025 07:59:24 -0800 (PST)
From: Bobby Eshleman <bobbyeshleman@gmail.com>
Date: Wed, 05 Nov 2025 07:59:19 -0800
Subject: [PATCH net v2] selftests/vsock: avoid false-positives when
 checking dmesg
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251105-vsock-vmtest-dmesg-fix-v2-1-1a042a14892c@meta.com>
X-B4-Tracking: v=1; b=H4sIAFZ0C2kC/4WNQQrDIBBFrxJm3SlqKpiueo+SRaJjIsVYHJGWk
 LtXcoEu//v893dgyoEY7t0OmWrgkLYW1KUDu07bQhhcy6CE0lKKG1ZO9oU1FuKCLhIv6MMHZ2X
 1QNINtjfQxu9MDZ/iJ2xUYGxwDVxS/p5nVZ7VP2+VKNEIa9zce+08PSKV6WpThPE4jh995KsJw
 AAAAA==
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
Changes in v2:
- use consistent quoting for vsock string
- Link to v1: https://lore.kernel.org/r/20251104-vsock-vmtest-dmesg-fix-v1-1-80c8db3f5dfe@meta.com
---
 tools/testing/selftests/vsock/vmtest.sh | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/tools/testing/selftests/vsock/vmtest.sh b/tools/testing/selftests/vsock/vmtest.sh
index edacebfc1632..8ceeb8a7894f 100755
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
+	host_warn_cnt_after=$(dmesg --level=warn | grep -c -i 'vsock')
 	if [[ ${host_warn_cnt_after} -gt ${host_warn_cnt_before} ]]; then
 		echo "FAIL: kernel warning detected on host" | log_host "${name}"
 		rc=$KSFT_FAIL
@@ -415,7 +415,7 @@ run_test() {
 		rc=$KSFT_FAIL
 	fi
 
-	vm_warn_cnt_after=$(vm_ssh -- dmesg --level=warn | wc -l)
+	vm_warn_cnt_after=$(vm_ssh -- dmesg --level=warn | grep -c -i 'vsock')
 	if [[ ${vm_warn_cnt_after} -gt ${vm_warn_cnt_before} ]]; then
 		echo "FAIL: kernel warning detected on vm" | log_host "${name}"
 		rc=$KSFT_FAIL

---
base-commit: 89aec171d9d1ab168e43fcf9754b82e4c0aef9b9
change-id: 20251104-vsock-vmtest-dmesg-fix-b2c59e1d9c38

Best regards,
-- 
Bobby Eshleman <bobbyeshleman@meta.com>

