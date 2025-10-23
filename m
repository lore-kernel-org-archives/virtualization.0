Received: from mail-pj1-f47.google.com (mail-pj1-f47.google.com [209.85.216.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D469922FDEA
	for <virtualization@lists.linux.dev>; Thu, 23 Oct 2025 01:00:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761181235; cv=none; b=mopFJO6vfHb/55cNQ91KyK5CveQ0IP9Ga/0wzpeSkhc/Vl4n9jDN5HhnK2DCrBw9SjDADeA1JQK9iojdztVFh9CXKWJzmO/9EPpFiUdOvyfUGL8B2ZXQvjP47L7Hc7Siu0kUP5ybO2JeWHP579Rh/PibTYOa1a1GOWWPN3w8C4A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761181235; c=relaxed/simple;
	bh=2VNGM+ga5+4lCYxn8srmIsIAGhhW4pu5Ux2Lzg8IB3g=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=hhLZwiFjFjFRp6gPk3vZezMHEiq9mIKE8wOnHBAAK7MZnsdJndzRJoPsqNw4SxVAYeQ9PICX7HBR5B/bjFMdIP+zbhSf8CLthMgiUW0CycDG7AMLaUYFXGLIcoyWtDk/4O5ZMWWashX+KgXQuqC2p92oa0Rpv/jqEaNaH215T18=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PncfQZvv; arc=none smtp.client-ip=209.85.216.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PncfQZvv"
Received: by mail-pj1-f47.google.com with SMTP id 98e67ed59e1d1-33be037cf73so256091a91.2
        for <virtualization@lists.linux.dev>; Wed, 22 Oct 2025 18:00:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761181231; x=1761786031; darn=lists.linux.dev;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Vj6nuzkY1lA64LuLbEa1jW/rmfdvccJ8fRwNCahhULY=;
        b=PncfQZvvu9EHhQsPfZNhTPg8mPyCocTF3Zg5Cp9AZq1yI+THehPROXOvAOaeqaB9ZC
         2PQuuMN+sPxfUzOAGkx2Ut8BuMhs06B4XhWfSh54vyBVuhOxbimWxspdcrgA+/dVycvT
         rBPPP4zWKkIrKYZvxyfz4GHNyqw0ObFCVjE74xzk+Dni8wilxevX4Yv7oHcxiQZ37AUy
         YgUPsuzUkcYzczJXtEI02AVw4aFMOC0O6Q7DOKWv9O4M7zphLIMmQeAzBPrNxurLZBM5
         IwBPOEyRxdXJIDcpoePyAfDCcqyzhmY8/BOG82QaPTYW/8D1OXfpNg8WmyHy7MKoeoVM
         X5IA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761181231; x=1761786031;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Vj6nuzkY1lA64LuLbEa1jW/rmfdvccJ8fRwNCahhULY=;
        b=UokSRoFna0UNjSmNY62DAU3jq7ARKeiZ5hiNksX8Wr9Bnis+9iN8Oa9mfKHaa7qCs3
         TM+I6n6YBV0NsrElaa7xpDELhGGAnoGUJcrSlOJ7+NCiEweP9Y9SjcfDHKRqP83x5jDl
         cLlpbmukqc3lmzBrxjbCAE3RkIvq6kxDPyDQY8GldCtfzEYUmix0WyCCtcP3HD0Ck5+d
         LsFt33RDYGzPMnkTYoAWyFKLeaILpWYxC3KlQQP35CDblyVLd7JT1kbu5b/O9UgecOMX
         1brRQq5goTP/LUKJsLW/cTtucqiSfQlI1lI9PEzqbVZjJn4yY8KnDpAt5RYJIWKun5Z5
         cdUQ==
X-Gm-Message-State: AOJu0Yz2fS/5nuVi/cF7dtsh18qZLtvjYqovWUjjhM5OCbrfwHY8m6gH
	CzUL6P8UdSsEyh3HaBRbuZE73xR5EpCFMl5l5FL5JrKhDD40g9dnEwxOWliyqgSe
X-Gm-Gg: ASbGncuywiSQQqqfZDHczhZE3XhaZRyt+9fwWjljLaBOIy6Y01tLPDHJtA8/vAvwY44
	fkbRIyYDk5hPNV42bqGR98ScBSQRoEKSxXqTX/D35DEd1zvVrDjAKligPd4DzWsvR6vVZr+Kl7d
	Nemq5jqPUp4FAmxHEgo68GrOLWy2MtHmC8SX2BeDptwudB6Ri+gtJ/S/7wKr7K1Wh6reVsK45hW
	IvG43a4OdxwkcI8hp6Lh6fwEdbCEzpnF80ipfWaxs0je4xNkwXD9KaCG86bY3vSntyLV3kC9CGE
	yOmW+t5jWX7m7kl42UoDYCX/7hrOgxneyv8pWm5ogcBwxmCxsxRpVTpOqRCTijHhLcGMEyX95DK
	NeEJqoqnldC97QWMgHrZ7MbjvqKmKdkhXk5IRsxqlUNV9sbHFuZPNBigmfaQpjEGWue+3lNaYgF
	GRb1Tf1h58
X-Google-Smtp-Source: AGHT+IGKtTFJtpQ24tkehAeG1F60BvFty13fIYOS2AypXorCFytbWHehPyoCNC+kjaMOPOaFRHtOew==
X-Received: by 2002:a17:90b:2d8f:b0:335:2eee:19dc with SMTP id 98e67ed59e1d1-33bcf8f94b6mr28354305a91.28.1761181231262;
        Wed, 22 Oct 2025 18:00:31 -0700 (PDT)
Received: from localhost ([2a03:2880:2ff:71::])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7a274b8adc8sm552212b3a.39.2025.10.22.18.00.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Oct 2025 18:00:30 -0700 (PDT)
From: Bobby Eshleman <bobbyeshleman@gmail.com>
Date: Wed, 22 Oct 2025 18:00:11 -0700
Subject: [PATCH net-next 07/12] selftests/vsock: add check_result() for
 pass/fail counting
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251022-vsock-selftests-fixes-and-improvements-v1-7-edeb179d6463@meta.com>
References: <20251022-vsock-selftests-fixes-and-improvements-v1-0-edeb179d6463@meta.com>
In-Reply-To: <20251022-vsock-selftests-fixes-and-improvements-v1-0-edeb179d6463@meta.com>
To: Stefano Garzarella <sgarzare@redhat.com>, Shuah Khan <shuah@kernel.org>, 
 Bobby Eshleman <bobbyeshleman@gmail.com>, Jakub Kicinski <kuba@kernel.org>
Cc: virtualization@lists.linux.dev, netdev@vger.kernel.org, 
 linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Bobby Eshleman <bobbyeshleman@meta.com>
X-Mailer: b4 0.13.0

From: Bobby Eshleman <bobbyeshleman@meta.com>

Add check_result() function to reuse logic for incrementing the
pass/fail counters. This function will get used by different callers as
we add different types of tests in future patches (namely, namespace and
non-namespace tests will be called at different places, and re-use this
function).

Signed-off-by: Bobby Eshleman <bobbyeshleman@meta.com>
---
 tools/testing/selftests/vsock/vmtest.sh | 32 +++++++++++++++++++++-----------
 1 file changed, 21 insertions(+), 11 deletions(-)

diff --git a/tools/testing/selftests/vsock/vmtest.sh b/tools/testing/selftests/vsock/vmtest.sh
index 99db2e415253..0957d6a41d08 100755
--- a/tools/testing/selftests/vsock/vmtest.sh
+++ b/tools/testing/selftests/vsock/vmtest.sh
@@ -78,6 +78,26 @@ die() {
 	exit "${KSFT_FAIL}"
 }
 
+check_result() {
+	local rc num
+
+	rc=$1
+	num=$(( cnt_total + 1 ))
+
+	if [[ ${rc} -eq $KSFT_PASS ]]; then
+		cnt_pass=$(( cnt_pass + 1 ))
+		echo "ok ${num} ${arg}"
+	elif [[ ${rc} -eq $KSFT_SKIP ]]; then
+		cnt_skip=$(( cnt_skip + 1 ))
+		echo "ok ${num} ${arg} # SKIP"
+	elif [[ ${rc} -eq $KSFT_FAIL ]]; then
+		cnt_fail=$(( cnt_fail + 1 ))
+		echo "not ok ${num} ${arg} # exit=$rc"
+	fi
+
+	cnt_total=$(( cnt_total + 1 ))
+}
+
 vm_ssh() {
 	ssh -q -o UserKnownHostsFile=/dev/null -p ${SSH_HOST_PORT} localhost "$@"
 	return $?
@@ -521,17 +541,7 @@ cnt_total=0
 for arg in "${ARGS[@]}"; do
 	run_test "${arg}"
 	rc=$?
-	if [[ ${rc} -eq $KSFT_PASS ]]; then
-		cnt_pass=$(( cnt_pass + 1 ))
-		echo "ok ${cnt_total} ${arg}"
-	elif [[ ${rc} -eq $KSFT_SKIP ]]; then
-		cnt_skip=$(( cnt_skip + 1 ))
-		echo "ok ${cnt_total} ${arg} # SKIP"
-	elif [[ ${rc} -eq $KSFT_FAIL ]]; then
-		cnt_fail=$(( cnt_fail + 1 ))
-		echo "not ok ${cnt_total} ${arg} # exit=$rc"
-	fi
-	cnt_total=$(( cnt_total + 1 ))
+	check_result ${rc}
 done
 
 terminate_pidfiles "${pidfile}"

-- 
2.47.3

