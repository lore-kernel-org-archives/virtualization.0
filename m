Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9036023EABC
	for <virtualization@lists.linux.dev>; Sat,  8 Nov 2025 16:01:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762617720; cv=none; b=S7dlafVetl4js3JagT0pRtIDmp04+MRVS03xdOHamLXJBLwZj6TPQxrfBIfkJ8Om+iFcwOwwsPAEJERz1iFSfWCmD3AJylWZYFDMGaVEbEnK2F1xwD9uf1w0qwhjVOPtXF2HmIGARtqtGL5NNBLQJeJ5vJlOP9bH0skKctzVe/Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762617720; c=relaxed/simple;
	bh=kXti4VlF9If/Jhp5cw6M/i3Lzb+2XXWTFOdTl0a0yx0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ouPF5491tgB0sHy3dHNqAap2O50+/IP2vrWwyVkikK8j5aoOzjjvrLe1ujCYPW9vzTlOucbv6AACEvS70RwtGEp975Jz8KMrD/BK9t9VDh6g6mOJN7/FNU9tXfQpHISm5CQ9w4zokl2M/5Xu1PC2Ls3MbvN9aVWsjrrYzOxhp1s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CYkqFZfS; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CYkqFZfS"
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-292fd52d527so14688895ad.2
        for <virtualization@lists.linux.dev>; Sat, 08 Nov 2025 08:01:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762617718; x=1763222518; darn=lists.linux.dev;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=lu3g3vSYUjY7/DxTl1+mYZ9eGfURyr+RcPBMpaSL4zc=;
        b=CYkqFZfS8CTMs4/n+y1YV3LyH/RdxX1Ds89NadDcN8s6Zz4NNq4jb0enu3ntfaoX4a
         yZ884twbCW0d1WC9Q8MsTrx6dY2tKB+AdiogahSwhZWLnJ4KtlOJiIevcZXwWTVKnnA3
         QDsHun9d7Jp9LMTFWNj6pJgjUVZTvhx0d2gpB+JBaOur1j7EyKuCVBd1j6Iu+/Uuyl1r
         Hr7oss2MKUY5rAE6KbZMGxYdRUmWitzGzpusTOZNZncAwk6qIk6uT28eogmJMCZWvXxk
         hiVgYcoM+oinzND83tu74ReKYqmq42jnf1giysQwsbGS16FI6wBfz1N9u85BSqItrgSb
         h+KQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762617718; x=1763222518;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=lu3g3vSYUjY7/DxTl1+mYZ9eGfURyr+RcPBMpaSL4zc=;
        b=lx8xDUSr9knTIvY3K7ggpLMh6l34LxYKtrRTmNM4hGIGgKDTsJKSkiaOtOM7QQxjGc
         WIbvIdqiVN2PfEglIeGOEWbYzIgagSupldeuneHrZxrj1dx2KlooqAfue9vTNtEQZRyP
         9iMu8t4gTcnIvIo4y5+Fv1C6KYIGLyjxKMXFapFXCAJvVaqDaQyjcaz0nELaPMpmO1F2
         Eau6JJI4LG6VBWFGr3ED5v/HVAZzT7JfhqW1QknFQrERL07bUNidFE/mOu7+yrKG05Du
         GdK3rwrm/qoq81iCLclwa3ddBm9Lgc0r/0r+X+SUpzGBwAM6C4WHGb9jEaipBvOARbFC
         69ng==
X-Gm-Message-State: AOJu0Yz964WgTSCOMZEGzZP1wez/uVCRLCRgsYb4hsmaC/mAnOCpVTu2
	z0kbbirGD5GY0rrsOJwfuipp1oNCleSDn7iCk1L1jmrKkyItlig9cqff
X-Gm-Gg: ASbGncsKjPJsIIhURXTR5KJtDwYlQvUG644nAkvorzswpMCpD6rJg+Mi/TzYA1X+vKC
	WXWPWayHChf9uzrDhQRBsIqEWdfPNLmAhOJ2Ikf/wrbqhFgjnLVAhSPl/GQsbuLWkhHJjyWm23t
	5l1vTnZ8Nk7sA+T1Wb2T+tHQcLeIDGXD3DJ62rO66zJanVpjNUetU9s0kJPCRSpB8v28m/qhQ6n
	GgspAHXpLkeDSJvINEYY+LiVM317Uu8WWdAd/vh0fQ/XF+c87g/bAQcinYK6mkA3//+T4dWGqTj
	onI7qpLgEu6hG0v8Zkwrjo8lRa0Kk0vnFXSLSAd6Wc8f2aAMn4ZcVIEnQYReGV6bl6THGYb/RKf
	et3Ol1Fc0H3PwyVBc3o6EMDtIWvqgeTeWMVOqQr8jOhnEnM6enKIBmpZGyBaicQvpWi9XyMMDVk
	huYEN8uoa4+R0SVck1X6Q=
X-Google-Smtp-Source: AGHT+IHDIYzATzCHfhG57FblbDFeYnwOL/4oaPCyboie4iuVOegKtbCQgew0dvzNH4sWmPXvWF1Gyw==
X-Received: by 2002:a17:903:238e:b0:267:f7bc:673c with SMTP id d9443c01a7336-297e56d0401mr33795955ad.44.1762617717613;
        Sat, 08 Nov 2025 08:01:57 -0800 (PST)
Received: from localhost ([2a03:2880:2ff:73::])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29651042c24sm93002675ad.50.2025.11.08.08.01.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 08 Nov 2025 08:01:57 -0800 (PST)
From: Bobby Eshleman <bobbyeshleman@gmail.com>
Date: Sat, 08 Nov 2025 08:00:58 -0800
Subject: [PATCH net-next v4 07/12] selftests/vsock: add check_result() for
 pass/fail counting
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251108-vsock-selftests-fixes-and-improvements-v4-7-d5e8d6c87289@meta.com>
References: <20251108-vsock-selftests-fixes-and-improvements-v4-0-d5e8d6c87289@meta.com>
In-Reply-To: <20251108-vsock-selftests-fixes-and-improvements-v4-0-d5e8d6c87289@meta.com>
To: Stefano Garzarella <sgarzare@redhat.com>, Shuah Khan <shuah@kernel.org>
Cc: virtualization@lists.linux.dev, netdev@vger.kernel.org, 
 linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Simon Horman <horms@kernel.org>, Bobby Eshleman <bobbyeshleman@meta.com>
X-Mailer: b4 0.14.3

From: Bobby Eshleman <bobbyeshleman@meta.com>

Add check_result() function to reuse logic for incrementing the
pass/fail counters. This function will get used by different callers as
we add different types of tests in future patches (namely, namespace and
non-namespace tests will be called at different places, and re-use this
function).

Reviewed-by: Simon Horman <horms@kernel.org>
Signed-off-by: Bobby Eshleman <bobbyeshleman@meta.com>
---
Changes in v4:
- fix botched rebase
- use more consistent ${VAR} style

Changes in v3:
- increment cnt_total directly (no intermediary var) (Stefano)
- pass arg to check_result() from caller, dont incidentally rely on
  global (Stefano)
- use new create_pidfile() introduce in v3 of earlier patch
- continue with more disciplined variable quoting style
---
 tools/testing/selftests/vsock/vmtest.sh | 32 +++++++++++++++++++++-----------
 1 file changed, 21 insertions(+), 11 deletions(-)

diff --git a/tools/testing/selftests/vsock/vmtest.sh b/tools/testing/selftests/vsock/vmtest.sh
index bd231467c66b..2dd9bbb8c4a9 100755
--- a/tools/testing/selftests/vsock/vmtest.sh
+++ b/tools/testing/selftests/vsock/vmtest.sh
@@ -79,6 +79,26 @@ die() {
 	exit "${KSFT_FAIL}"
 }
 
+check_result() {
+	local rc arg
+
+	rc=$1
+	arg=$2
+
+	cnt_total=$(( cnt_total + 1 ))
+
+	if [[ ${rc} -eq ${KSFT_PASS} ]]; then
+		cnt_pass=$(( cnt_pass + 1 ))
+		echo "ok ${cnt_total} ${arg}"
+	elif [[ ${rc} -eq ${KSFT_SKIP} ]]; then
+		cnt_skip=$(( cnt_skip + 1 ))
+		echo "ok ${cnt_total} ${arg} # SKIP"
+	elif [[ ${rc} -eq ${KSFT_FAIL} ]]; then
+		cnt_fail=$(( cnt_fail + 1 ))
+		echo "not ok ${cnt_total} ${arg} # exit=${rc}"
+	fi
+}
+
 vm_ssh() {
 	ssh -q -o UserKnownHostsFile=/dev/null -p ${SSH_HOST_PORT} localhost "$@"
 	return $?
@@ -530,17 +550,7 @@ cnt_total=0
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
+	check_result "${rc}" "${arg}"
 done
 
 terminate_pidfiles "${pidfile}"

-- 
2.47.3

