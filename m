Received: from mail-pf1-f174.google.com (mail-pf1-f174.google.com [209.85.210.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDD2C2F28E3
	for <virtualization@lists.linux.dev>; Tue, 21 Oct 2025 23:47:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761090444; cv=none; b=GjGTYXkhZDSaRSbjnuC0jAVcu4283rmbrlIgZBCT7+f5Fj1IRUjoPAKRCZMRdFEmDY921iL4Z+J/74ARNnT0V1O875fwpLTrzZ8t7gleS0L+ke6ddzVeqIQ7mywKDRb+WHVcPpCGom4Nc9rYRwahok8lPvHe2A/XGG7TyMw8U3s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761090444; c=relaxed/simple;
	bh=8bOFcVzDZsUwxKg5ikgK5NJUIukOBjSEIefCk8ZnB5E=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=jA6wWW61QpfAhFVPC4mOen+9h3mhgyEt0m9i5F9Q+ngKqTtAQJ0x8FECgeF1wwX/Cp1PshQi22XUdia6iucfGWtq331lq123dr6n5KGSr7K7SqjSw11Pl0XSQkuVXoVOtMk5+KmdETI1xL+WnT4vq+eUIc6oHdGf3wvuEkJRdT0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PHoybhXy; arc=none smtp.client-ip=209.85.210.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PHoybhXy"
Received: by mail-pf1-f174.google.com with SMTP id d2e1a72fcca58-781db5068b8so4764443b3a.0
        for <virtualization@lists.linux.dev>; Tue, 21 Oct 2025 16:47:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761090438; x=1761695238; darn=lists.linux.dev;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=z4OFfgfpg2zuYVB97qQ4nYxxE2fA0slLU1vqJ2CVR4E=;
        b=PHoybhXy1aRe2W+8DRiP2MG2FPV06oN5yjJBoUxDbT6mFhdTbNl14XkUgkXgeSsbIL
         h0qomWnXHxIV4/a/66/9W7Ok3lt0Y6uYJ76kelXJweharjNLQNr7IzJ2YT0PkwPcF4A5
         K8kYREvFf54ny2RvMp5gGpmmgMubW6HaZjg1Y7TpYfPC7Vg3YJ1W5KUYBmWblpD1sl3M
         Ujqj/DzJfLJPMjwDvM5ckC7uKaI1BAOiC22432dcQ0Jxl2wzzYe5lAfgrPDEg8oESNXe
         s0lxAvQwJDPMSUDeAjoPJtbHBn4PHKYzVJ8+6YzgZQ4APHq1EcyqX5jxX8Y01juwnnue
         xBYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761090438; x=1761695238;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=z4OFfgfpg2zuYVB97qQ4nYxxE2fA0slLU1vqJ2CVR4E=;
        b=GqsIVQWNWoGYaOAO9cPJzizceHQp4Jv70j9soK3+erH5NmB5SWWNr9jsmLfy7WZPEx
         +kgRy5v9WMqGrHdYqrMWtddxOHcCGxy01qj8/ECEdY9F3HitpmEq3a4rQihR43nKLUnA
         Ns2Tuvw7GEMObuG4shdHYjNHNQ6UI1FEF9XiGmQQLsOzMp3PuSnwPMeXif8Kh0EbLYVC
         GjDEMbCFlQlD7RE129kwh54iVJgJyZjZPr4wZC2AN543rYzzBUAvw0EuhXjWS8202Zm4
         MqJhYhE9w+puMnUfbrEeTY25hDY6miSbd79atnsdk9sOanS+F3FV3/brjy+WPKaAHVKV
         0Ddw==
X-Gm-Message-State: AOJu0YwFXm/8PgnAdk6I9XF4rT8e2kTjzJNFZI3unJi3Yu9p30NIZEHa
	n2FooYIF6dAmMUP6L6T7J2a0XwDSz7MNeiTGpopftxoYaZICl5RehW2N
X-Gm-Gg: ASbGncuc5X5TtQnG7svAXFwhYUsOFoWmjGrRTzwtjR99kotsNC0xqMlIaV4yaudAbBu
	S2DB+tIb8A6VYy+ZZnHczxuoyKHXFpIL67mUsx3nVj20ZZcQTz+3gdZ50zjPy8QJPfhMThSb5sT
	qszJOrcd9UcMfwF1nTRirK+8olPcNifKADxLNOZnT6Pt3vVTmOveMVHD+lZiVvEdCppvvIETqGe
	u/ONoCTU8U8p3wAYk4RCEcCe60FTveqA/gPrLfu1yLUdSAVFsqsbdm7+o2j0d9NqdYNuwBcJgtK
	TOddTdGeinA3y7xWgOdzW8C9datfnSajB8kh7YfZciywq3ZhCtwFIzSy+Cq/jZGzEoIJIWbgQrr
	V6kgit9VnGxwuCMNqQ864P8Q/t++kbJwYxtTSROaA676NSiCRw0xBWy5homVHTg+fAmZKXt58pn
	guTye7MosS
X-Google-Smtp-Source: AGHT+IFkhGJRP2dLAASLtzToAAHgpD36H89TPJABTWvg0NGgrSHeo1CXKroyw7GJKTzS0N8BFk4Bbg==
X-Received: by 2002:a05:6a20:42a3:b0:334:a832:91a5 with SMTP id adf61e73a8af0-334a862939dmr20305416637.44.1761090437936;
        Tue, 21 Oct 2025 16:47:17 -0700 (PDT)
Received: from localhost ([2a03:2880:2ff:71::])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b6a76b33bf3sm11369376a12.19.2025.10.21.16.47.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Oct 2025 16:47:17 -0700 (PDT)
From: Bobby Eshleman <bobbyeshleman@gmail.com>
Date: Tue, 21 Oct 2025 16:47:03 -0700
Subject: [PATCH net-next v7 20/26] selftests/vsock: avoid false-positives
 when checking dmesg
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251021-vsock-vmtest-v7-20-0661b7b6f081@meta.com>
References: <20251021-vsock-vmtest-v7-0-0661b7b6f081@meta.com>
In-Reply-To: <20251021-vsock-vmtest-v7-0-0661b7b6f081@meta.com>
To: Stefano Garzarella <sgarzare@redhat.com>, Shuah Khan <shuah@kernel.org>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Simon Horman <horms@kernel.org>, Stefan Hajnoczi <stefanha@redhat.com>, 
 "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>, 
 Xuan Zhuo <xuanzhuo@linux.alibaba.com>, 
 =?utf-8?q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>, 
 "K. Y. Srinivasan" <kys@microsoft.com>, 
 Haiyang Zhang <haiyangz@microsoft.com>, Wei Liu <wei.liu@kernel.org>, 
 Dexuan Cui <decui@microsoft.com>, Bryan Tan <bryan-bt.tan@broadcom.com>, 
 Vishnu Dasa <vishnu.dasa@broadcom.com>, 
 Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>, 
 Bobby Eshleman <bobbyeshleman@gmail.com>
Cc: virtualization@lists.linux.dev, netdev@vger.kernel.org, 
 linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org, 
 kvm@vger.kernel.org, linux-hyperv@vger.kernel.org, berrange@redhat.com, 
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
index 9afe8177167e..b129976e27fc 100755
--- a/tools/testing/selftests/vsock/vmtest.sh
+++ b/tools/testing/selftests/vsock/vmtest.sh
@@ -591,9 +591,9 @@ run_shared_vm_test() {
 	local rc
 
 	host_oops_cnt_before=$(dmesg | grep -c -i 'Oops')
-	host_warn_cnt_before=$(dmesg --level=warn | wc -l)
+	host_warn_cnt_before=$(dmesg --level=warn | grep -c -i 'vsock')
 	vm_oops_cnt_before=$(vm_ssh "init_ns" -- dmesg | grep -c -i 'Oops')
-	vm_warn_cnt_before=$(vm_ssh "init_ns" -- dmesg --level=warn | wc -l)
+	vm_warn_cnt_before=$(vm_ssh "init_ns" -- dmesg --level=warn | grep -c -i 'vsock')
 
 	name=$(echo "${1}" | awk '{ print $1 }')
 	eval test_"${name}"
@@ -605,7 +605,7 @@ run_shared_vm_test() {
 		rc=$KSFT_FAIL
 	fi
 
-	host_warn_cnt_after=$(dmesg --level=warn | wc -l)
+	host_warn_cnt_after=$(dmesg --level=warn | grep -c -i vsock)
 	if [[ ${host_warn_cnt_after} -gt ${host_warn_cnt_before} ]]; then
 		echo "FAIL: kernel warning detected on host" | log_host
 		rc=$KSFT_FAIL
@@ -617,7 +617,7 @@ run_shared_vm_test() {
 		rc=$KSFT_FAIL
 	fi
 
-	vm_warn_cnt_after=$(vm_ssh "init_ns" -- dmesg --level=warn | wc -l)
+	vm_warn_cnt_after=$(vm_ssh "init_ns" -- dmesg --level=warn | grep -c -i vsock)
 	if [[ ${vm_warn_cnt_after} -gt ${vm_warn_cnt_before} ]]; then
 		echo "FAIL: kernel warning detected on vm" | log_host
 		rc=$KSFT_FAIL

-- 
2.47.3

