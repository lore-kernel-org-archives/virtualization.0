Received: from mail-yx1-f50.google.com (mail-yx1-f50.google.com [74.125.224.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 050E131ED6E
	for <virtualization@lists.linux.dev>; Tue, 13 Jan 2026 03:13:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768273987; cv=none; b=F4Z2jUnjkdD1i83JdodpkivUFhLWDU8MlSOq+f+FSoV8QZiGVDgcizHbrSdJStYaAdPSL3ddByR+qxxxyMUcWtBJP+5eTtYRL2H6AB1v7uWk7tbEXgbvvj+jI/JA9TlCg44FWXYpM5sl424YAyIaNS3jF4q2Av6IZFkCLukQyIE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768273987; c=relaxed/simple;
	bh=uCgr9JbNpxUqM9gbGsf2Jmk4aJqJ6fTLHuKaFTvudAQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=cZh8Wmi13ZpbQAzr4y3Dj43seYJpfg8foNFihVrKIfNCwffTTG25NXAsBouR1KskvkwhpjK4tAWZGAJOd8DGbQk/vrXKpPPT6ot6FvYdr/UT20CkuMwVIzSS3sSWDKja6JVnxKmkq1QsiYENQFA1/btxCsm/y+RcAkyNsBJbXlk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MROCqTBA; arc=none smtp.client-ip=74.125.224.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MROCqTBA"
Received: by mail-yx1-f50.google.com with SMTP id 956f58d0204a3-646b8d2431dso6066137d50.2
        for <virtualization@lists.linux.dev>; Mon, 12 Jan 2026 19:13:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768273983; x=1768878783; darn=lists.linux.dev;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=9UqzpQf1IlJwSFAKiovBpo5/3/EPxdibd9liBmZD9wA=;
        b=MROCqTBAqBqkauTnB7s9jFLV0jz12JKFSqy2M7jTXCdsmp3GZcYXIXCU5xs3ltEMdr
         ZT2Mduk+mme2kB0AoVU9bbBAbs92Fx9BKTjIZYwCUK4SdiJKdbVGX2EMSlOt/RP7jjQu
         pCrrb+jDa8VCtvVvMCI3wZryHi9Ycgzb4y4cl3/6GFC+/KYV7nInp5e6M9Imnbaz5z+C
         80XjxYddWoyg87zO4XM7tLDAIAg+fobiZ9ugtWvb2GLSkwKk9lEzLyr3w6CTxTOMu33H
         L98/iFvXfm80hn8ikqRKg/YW6Qj/q/RrnB2WPIji9x8MG9zwEQR3QGzSjH4GP8c/+ovk
         01SA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768273983; x=1768878783;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=9UqzpQf1IlJwSFAKiovBpo5/3/EPxdibd9liBmZD9wA=;
        b=mV0d6/ln4AADPpaAO85Ydh2BRNdwg6Q6LOP7RlsEmrYk6ROJ82hWB4MhiVqEkTDrnc
         8HiYjVZvA+SH5lHVRYcDrEkVoiEg9IlAj9wUcNkLMtFhh8E/CfL/LwkYnMoUL2yKI8lu
         V12zvYNGmJoWdBLScYHDloowKMupo+U2KFrgJYVL0VN/8CD5cSkL07CZs2x9Lajv7iOR
         7e0mDsoMZ8NRT5NF57N/MvSLISOlvMIEmpLoE/H43iMaJ8N9EeRE/8Db8dveJqbIt6Wu
         1IgOnIFOEz0BggzN9ZFN1rZd7DsX3l0BIVVaC5bybfAk8cB7KxgbLO8lLyAsLEmw+2AR
         fiAA==
X-Forwarded-Encrypted: i=1; AJvYcCXlfwa0rRjCQpfqx6UJ1dMTgFQrjGfmRyN1qtNiBIcuWFJe8tmDx8lVPQPTIxIccXs5pTi+18IBN6ccEZBHFg==@lists.linux.dev
X-Gm-Message-State: AOJu0YwbMvxA4aNm0X/IlBCsBloBy9WKfYqfMGlbZmsrREDKxmyHOdN0
	DJyU+PkYUUOZxwtdHTgvyT7ljyyL9+feulEydnMZ2tt2QYKVNl8+sD0f
X-Gm-Gg: AY/fxX5AtHt8X6JO0fMuxbTnYEHYhw+e+cUVD6lTXlmxh/H6BX6fsrvqBzzC0HsSLt2
	aHntUeWlc9CRt5kfiE6/n2FPfuPGzZlUDfH61AWJ1H1+i8yax+cGlGmI8y71XkLBvLT+Icj5uim
	gv4j4DRTzctDUW5FjPH7kbZZWEMyqMm7o5Lxxmn8C2FWF82ltdx89e1tvRFMumLvK2HX9bhRO7t
	0Lfd7M6E9xREuM5ranby1m/vXKOcgTVIKLjlO5oBX/VEjnCeueDkJGnZa/F8HssqgGI6/NdHy6K
	/DIN3Jrl9VyCzjfdyzERhpjY1l5dIsC/+95ku94n1ygnimD5CDZT1SOvDbrrJu6dncf2YEOy1UM
	bkpIXwxrEeuy4va4jVNCNKHnzvhvcJaZLOjqU8C9u6h5LWc4RyMlxDKpOEjc0UUGmONgZ7hiXxY
	JjC0Dxt/2k
X-Google-Smtp-Source: AGHT+IErvHvsN34Y4EeiTfc/QvQN5Cj16XfAwMvouHBrxnnMT8gw+lZ3jiDdXraGFB4o7lMM07JE3w==
X-Received: by 2002:a05:690e:1686:b0:648:f70e:2271 with SMTP id 956f58d0204a3-648f70e3129mr1251005d50.28.1768273983606;
        Mon, 12 Jan 2026 19:13:03 -0800 (PST)
Received: from localhost ([2a03:2880:25ff:9::])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-7916d0c3f72sm49159977b3.21.2026.01.12.19.13.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Jan 2026 19:13:03 -0800 (PST)
From: Bobby Eshleman <bobbyeshleman@gmail.com>
Date: Mon, 12 Jan 2026 19:11:16 -0800
Subject: [PATCH net-next v14 07/12] selftests/vsock: add
 vm_dmesg_{warn,oops}_count() helpers
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260112-vsock-vmtest-v14-7-a5c332db3e2b@meta.com>
References: <20260112-vsock-vmtest-v14-0-a5c332db3e2b@meta.com>
In-Reply-To: <20260112-vsock-vmtest-v14-0-a5c332db3e2b@meta.com>
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

