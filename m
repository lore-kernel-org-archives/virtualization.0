Received: from mail-yx1-f45.google.com (mail-yx1-f45.google.com [74.125.224.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9846C313279
	for <virtualization@lists.linux.dev>; Fri, 16 Jan 2026 21:29:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768598954; cv=none; b=X+DvFGuC/hPnk/bRQNGRWjRNsqw+jxI1JIByvyj3SEZHxUIBaPBOa7TgVclLG8jZIoHbR3mtFvOY+gL0Dz4g9r59fO8jBqoE5+Ga60gdjj3PiV+fi4L1glet52HwepyyChTVcU/DcwxkmPlsNG+dGOfBQs/dwx5wckzSwxfsEkw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768598954; c=relaxed/simple;
	bh=uCgr9JbNpxUqM9gbGsf2Jmk4aJqJ6fTLHuKaFTvudAQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=qF5HugybZo4hYUDw7hQJkkL/s762bgc6/UTWUlQcisuU0HJdTSsnibS4xSY8vm4sNA71xjFajRwB7wJW8w2mT5rvmO3rE3ZuPnfRZkliPJzYfKlBtbTKZDxXzuom97yvX0oeWjcg2wfSzsdgrFfpkFO4K3PQVra2Qa2ESna98FQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hu7zI+We; arc=none smtp.client-ip=74.125.224.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hu7zI+We"
Received: by mail-yx1-f45.google.com with SMTP id 956f58d0204a3-6467b7c3853so1958959d50.0
        for <virtualization@lists.linux.dev>; Fri, 16 Jan 2026 13:29:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768598949; x=1769203749; darn=lists.linux.dev;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=9UqzpQf1IlJwSFAKiovBpo5/3/EPxdibd9liBmZD9wA=;
        b=hu7zI+Weh/5QUDsXHiAXB515j4goCy6CSaygegWiTU8f+huPk/mi8qkiF9K6won0Ab
         WIPmDFqJNlG5DapnK9b89uVFRjz1REZewBbohvLMwN7F5/YMzHIg7plkdfsugtff0Kps
         lE5A6VCHBEmhZdG3pAAslNWI9W9V05WFLjASGHGUhDS2nf9CL2aZxVUVOnlW2dd0hnfs
         Xua3Y4yBR3FKLaPvGmz7lA5Ic+nw++H47OiaVEKS5rE5FE9JO2MsL6D2IIh+Fha8E3tc
         pVMOD6mSTtMa9aXn9aADLlQDpI2NFPITell6ODIdRNVJuUhG+WPvnMxJCKSGxqQtryoc
         wYWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768598949; x=1769203749;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=9UqzpQf1IlJwSFAKiovBpo5/3/EPxdibd9liBmZD9wA=;
        b=CQPQWhhXzvc4IyR0bvwznvN1AnI0FFlTgTdc7uNCLUltR53WnfNfJqVETdak/cY82i
         1ExRTh0UYmX8eb3Kj8Gdpa4WkOFB+goeCJ6WQUM18SQhElnZu7n6sLN6Ak28p6UzDShW
         F1Bvl1Mrt5UgmWjuU0Z3e64AU2DOQqZTQY+VXVzCkbqF6x3qqb0u6i9Hrt3+m72dHuQ7
         Wyjyac0uamT635tWsB5SFlMV80ktDTIOgPba3Kd34t2jtt2mLgaeI/jF5LTM3VHZX92m
         JH+b0TdwnnlsAfIb2rl3ZOmPo7onQelI0L+8ycfd+8LZasiTHrDQiuqrVKeo4JFl4Ngt
         lUmQ==
X-Forwarded-Encrypted: i=1; AJvYcCU7qwqm52ZpNcwHsjYtk4BBPS6JyfNgSzjwEaBnYLcc2skCjwcxRUl6TXQW0EogqibzIR9um1MFE5ZECPalwA==@lists.linux.dev
X-Gm-Message-State: AOJu0YyPgX52s8y6Y7C0j+lVWzdU9ORTCIjwlIsDQA7SKLNijl3Hpw9s
	+JOHWIJSsYvtjOFD7DxPyBQ7oJDON8AM1tgtE4fKJq5dNTglRlnWOcak
X-Gm-Gg: AY/fxX7DABFBOUKny1wreT1J12rlmHz43GFl65fiWhct362mtNoIYi5IfVs+36oHRpD
	3TRILJq54rY0NVG5HGWkXcMEuBuIpDwlDdbB/QT/i4FZ15rFWDQWygdzQ62DQAVCK5F48OUyYaS
	JzOh5tO2ZxcT6bbxPv1TqEjwAhzG5IrWzYvpdkr6yF955vDC8DmFOojclzF4rZjbVuWY1orWvAz
	J6wo3UEYtLnFFSxMdgQIrY04jCKyXQd9mGV9Z3JVA4/kGH29uU4WMeDn+zSTlhGaClvyE+p3ZVP
	HNhktnK2KWGvrS5yriO8qVbyDNhHS0ntZEkyXdDm+BmyfPlmH4n/lgmJ9GbtQY043wiirjeR9ih
	DOiORABdqpqWMjXAd/uht7pF8kiXXMIn9zAv2O36/v6UDvwCWl74m4Axej4FUjjf55N8Gz+zi50
	croNFaUE+e
X-Received: by 2002:a05:690e:d8d:b0:644:60d9:8667 with SMTP id 956f58d0204a3-64917773d86mr2650287d50.88.1768598948802;
        Fri, 16 Jan 2026 13:29:08 -0800 (PST)
Received: from localhost ([2a03:2880:25ff:8::])
        by smtp.gmail.com with ESMTPSA id 956f58d0204a3-649170d2f04sm1663457d50.22.2026.01.16.13.29.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Jan 2026 13:29:08 -0800 (PST)
From: Bobby Eshleman <bobbyeshleman@gmail.com>
Date: Fri, 16 Jan 2026 13:28:47 -0800
Subject: [PATCH net-next v15 07/12] selftests/vsock: add
 vm_dmesg_{warn,oops}_count() helpers
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260116-vsock-vmtest-v15-7-bbfd1a668548@meta.com>
References: <20260116-vsock-vmtest-v15-0-bbfd1a668548@meta.com>
In-Reply-To: <20260116-vsock-vmtest-v15-0-bbfd1a668548@meta.com>
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
 Shuah Khan <shuah@kernel.org>, Long Li <longli@microsoft.com>, 
 Jonathan Corbet <corbet@lwn.net>
Cc: linux-kernel@vger.kernel.org, virtualization@lists.linux.dev, 
 netdev@vger.kernel.org, kvm@vger.kernel.org, linux-hyperv@vger.kernel.org, 
 linux-kselftest@vger.kernel.org, berrange@redhat.com, 
 Sargun Dhillon <sargun@sargun.me>, linux-doc@vger.kernel.org, 
 Bobby Eshleman <bobbyeshleman@gmail.com>, 
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

