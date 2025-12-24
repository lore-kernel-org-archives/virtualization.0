Received: from mail-pj1-f49.google.com (mail-pj1-f49.google.com [209.85.216.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80EB52116F6
	for <virtualization@lists.linux.dev>; Wed, 24 Dec 2025 00:29:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766536148; cv=none; b=j4QDQQ2RnelbNyp9SLo8WkuQ8nYbnFah4S24JWxNj8RFCTYhH6H1SWGNhBa4jBLjra9GNQl4NqZP2gN7yfJtt4CB3d6ECv+WlXB6qlx08sXME620DTu0dcly/tAJVCyihvPsIRUUC5fwVjiTOSttkQ1yFIgmwLz4lNNxUtcgBbQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766536148; c=relaxed/simple;
	bh=uCgr9JbNpxUqM9gbGsf2Jmk4aJqJ6fTLHuKaFTvudAQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=CScwGtxM/ET0fTOvkSL1sduzyfyjACOfyZWrJWSkljUQYgplmd6HTaIM0d8y5G+yynsiK/rHpkwF7P12e95J/va+LHyeLZ63qP/JA6sbKnjD5tS5gED1VaHVJG+RiuZ8M6yuLLUZRlDXAZZwFNmXN1YGv6DSyRzpWvfRB9Dz9ss=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=D4h0jvRN; arc=none smtp.client-ip=209.85.216.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="D4h0jvRN"
Received: by mail-pj1-f49.google.com with SMTP id 98e67ed59e1d1-34c30f0f12eso3936909a91.1
        for <virtualization@lists.linux.dev>; Tue, 23 Dec 2025 16:29:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1766536144; x=1767140944; darn=lists.linux.dev;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=9UqzpQf1IlJwSFAKiovBpo5/3/EPxdibd9liBmZD9wA=;
        b=D4h0jvRNRNFk0mQqrfeMYO3bTLOuYHF/crt3H5KT+ZYEZhc0/cbmIrSwysCyKfgR7C
         Rup2xuxoPHs1FXTBjzOHdbq3jJorKleMIJrtFl68l4cg0M/774KXlNFz9PvndTradMVp
         qvvqbrY/oV/9kAHgMHpU0vRJ5ZTr4CWjsVBAaGY4WyNFaeHT/27HNHctc6UaX+W+JXS0
         vi+t/azdoodRDyg6TOu3/B1uxSYiGYrFcHkyIDSLz+CohoB1gZQE+Hr5fxFf35FmNsN4
         eDP01CJMl89Yeax2sKBdPkfsjlSr+GyL2O1k6dbH917rOlbqPwKlDtEmR009EiXcMzbE
         FNPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766536144; x=1767140944;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=9UqzpQf1IlJwSFAKiovBpo5/3/EPxdibd9liBmZD9wA=;
        b=WWGjjeFjank3DvC2EYS+Oi9HnBm/spnHdPJJTK96k4/bZH0btog/ItsvOvqfO0O2w7
         7o+7vuAGEWyKrZcQlbX5/W+tKJPwhhpzZAyjolmKj72/gsgMyhVtvHtCjdzh2fuS2Fvj
         WuDmeErg+oM0hhcpM48VXnoIUwtQR+IFDOv6x41D8MjRbfThW6hkK9dNsxbWZgWD9Aeu
         8R+WMO2oAj5Pytn/s+7pmDPgQ34CidbjEihj6QvAad/wK+fVcl8CfeDwhMFOq3gGHjC6
         Wk8y3oPoMhwMEWAeybebefTo7Sxkn+Ghlh86/FeymW61bHx+zcZrHm3ZYm+WVZj/35Sg
         9jZQ==
X-Forwarded-Encrypted: i=1; AJvYcCWUoyhQwgoWBkfB/HlY2rPiGRw71eibZ7HPrQNB+YC1So2kAAx8UdHJP6hoZmonastoKtwW1mYNdCVb5mn71A==@lists.linux.dev
X-Gm-Message-State: AOJu0Yws82VP9Q71SuoNlCd1noC7kVxRmNqGAVgX6gSvn2JfDKTg8P14
	tBDUTiTzBKHHwX7HVCJ7R9ZC4t+Jakaq+fdUT+SxS8mKuuVfqvxVxO3c
X-Gm-Gg: AY/fxX7QTzhfCYIA9dId7OiqxQUwzK39rT0yu7KOVuoBe5zTl82MbvfK9dm2DgBUAZn
	TpAHYMEVA3jRDssntWOHHjOBw++/rzqECaEFPdoH9eQTftuBcdvsBCc1diGSP+rISjHZ6ajfgdD
	MD/0n+4VH0ATdNq5xucpDMcaRmNJzR8kJm9UYWc85X+I5XoY9ZztrmqLluzhg/Qvr43sHIpWifk
	2D6KHdVFoe+mx5/YQdhvuQ3+sThhPcvkIhivnhiaCgwYaOKAG7rOa680eg2ShNgFDtYysYYGQoq
	50R9DHM2ETBHX1oilFQK8pJb3wW32f535yEZJDw6mAmwMHUJzwmo/uT/8w1pJiEJgyB4Ro2U8MI
	l5BTVf3U+MBGJA9YhBC4iImxR5AxI/3Hvm9bUAgUxTeSJcf/PAcaWVK+GfQmNMlNQ7BpM3X+shX
	WfyVNfSLFP6YnCbQ734mjos5sEJLbpmg==
X-Google-Smtp-Source: AGHT+IFTZDOw9eAnRPi6bhVcftRHoSFo8lIyLrFNox+dzS6NcG5frjB7IyWc5r2SL/GNBjuoB/j/Mg==
X-Received: by 2002:a17:90b:1f89:b0:340:6f07:fefa with SMTP id 98e67ed59e1d1-34e921af98amr14188558a91.20.1766536144065;
        Tue, 23 Dec 2025 16:29:04 -0800 (PST)
Received: from localhost ([2a03:2880:2ff:4::])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-34e769cd8bcsm9008694a91.0.2025.12.23.16.29.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Dec 2025 16:29:03 -0800 (PST)
From: Bobby Eshleman <bobbyeshleman@gmail.com>
Date: Tue, 23 Dec 2025 16:28:42 -0800
Subject: [PATCH RFC net-next v13 08/13] selftests/vsock: add
 vm_dmesg_{warn,oops}_count() helpers
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251223-vsock-vmtest-v13-8-9d6db8e7c80b@meta.com>
References: <20251223-vsock-vmtest-v13-0-9d6db8e7c80b@meta.com>
In-Reply-To: <20251223-vsock-vmtest-v13-0-9d6db8e7c80b@meta.com>
To: Stefano Garzarella <sgarzare@redhat.com>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Simon Horman <horms@kernel.org>, Stefan Hajnoczi <stefanha@redhat.com>, 
 "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>, 
 =?utf-8?q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>, 
 Xuan Zhuo <xuanzhuo@linux.alibaba.com>, 
 "K. Y. Srinivasan" <kys@microsoft.com>, 
 Haiyang Zhang <haiyangz@microsoft.com>, Wei Liu <wei.liu@kernel.org>, 
 Dexuan Cui <decui@microsoft.com>, Bryan Tan <bryan-bt.tan@broadcom.com>, 
 Vishnu Dasa <vishnu.dasa@broadcom.com>, 
 Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>, 
 Shuah Khan <shuah@kernel.org>, Long Li <longli@microsoft.com>
Cc: linux-kernel@vger.kernel.org, virtualization@lists.linux.dev, 
 netdev@vger.kernel.org, kvm@vger.kernel.org, linux-hyperv@vger.kernel.org, 
 linux-kselftest@vger.kernel.org, berrange@redhat.com, 
 Sargun Dhillon <sargun@sargun.me>, Bobby Eshleman <bobbyeshleman@gmail.com>, 
 Bobby Eshleman <bobbyeshleman@meta.com>
X-Mailer: b4 0.14.3

From: Bobby Eshleman <bobbyeshleman@meta.com>

These functions are reused by the VM tests to collect and compare dmesg
warnings and oops counts. The future VM-specific tests use them heavily.
This patches relies on vm_ssh() already supporting namespaces.

Reviewed-by: Stefano Garzarella <sgarzare@redhat.com>
Signed-off-by: Bobby Eshleman <bobbyeshleman@meta.com>
---
Changes in v11:
- break these out into an earlier patch so that they can be used
  directly in new patches (instead of causing churn by adding this
  later)
---
 tools/testing/selftests/vsock/vmtest.sh | 19 +++++++++++++++----
 1 file changed, 15 insertions(+), 4 deletions(-)

diff --git a/tools/testing/selftests/vsock/vmtest.sh b/tools/testing/selftests/vsock/vmtest.sh
index 1d03acb62347..4b5929ffc9eb 100755
--- a/tools/testing/selftests/vsock/vmtest.sh
+++ b/tools/testing/selftests/vsock/vmtest.sh
@@ -380,6 +380,17 @@ host_wait_for_listener() {
 	fi
 }
 
+vm_dmesg_oops_count() {
+	local ns=$1
+
+	vm_ssh "${ns}" -- dmesg 2>/dev/null | grep -c -i 'Oops'
+}
+
+vm_dmesg_warn_count() {
+	local ns=$1
+
+	vm_ssh "${ns}" -- dmesg --level=warn 2>/dev/null | grep -c -i 'vsock'
+}
 
 vm_vsock_test() {
 	local ns=$1
@@ -587,8 +598,8 @@ run_shared_vm_test() {
 
 	host_oops_cnt_before=$(dmesg | grep -c -i 'Oops')
 	host_warn_cnt_before=$(dmesg --level=warn | grep -c -i 'vsock')
-	vm_oops_cnt_before=$(vm_ssh -- dmesg | grep -c -i 'Oops')
-	vm_warn_cnt_before=$(vm_ssh -- dmesg --level=warn | grep -c -i 'vsock')
+	vm_oops_cnt_before=$(vm_dmesg_oops_count "init_ns")
+	vm_warn_cnt_before=$(vm_dmesg_warn_count "init_ns")
 
 	name=$(echo "${1}" | awk '{ print $1 }')
 	eval test_"${name}"
@@ -606,13 +617,13 @@ run_shared_vm_test() {
 		rc=$KSFT_FAIL
 	fi
 
-	vm_oops_cnt_after=$(vm_ssh -- dmesg | grep -i 'Oops' | wc -l)
+	vm_oops_cnt_after=$(vm_dmesg_oops_count "init_ns")
 	if [[ ${vm_oops_cnt_after} -gt ${vm_oops_cnt_before} ]]; then
 		echo "FAIL: kernel oops detected on vm" | log_host
 		rc=$KSFT_FAIL
 	fi
 
-	vm_warn_cnt_after=$(vm_ssh -- dmesg --level=warn | grep -c -i 'vsock')
+	vm_warn_cnt_after=$(vm_dmesg_warn_count "init_ns")
 	if [[ ${vm_warn_cnt_after} -gt ${vm_warn_cnt_before} ]]; then
 		echo "FAIL: kernel warning detected on vm" | log_host
 		rc=$KSFT_FAIL

-- 
2.47.3

