Received: from mail-yw1-f182.google.com (mail-yw1-f182.google.com [209.85.128.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5B4C30EF8F
	for <virtualization@lists.linux.dev>; Fri, 16 Jan 2026 21:29:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768598951; cv=none; b=BGrPDuvqpvq12O4BJSwD+o6gtD+w7StC1zNXeSYIIF6agAiKDGUXNhDeexz9tirFUMzUWgCsTpz8sfPoFEPNmAhKXAnr9BMBnFwl07bJVVI9ghmhq0T9vpdXLyGeOopt3Kat+ypk7SVznVb5h6nBKpYceeP9iHKdwWCPjbWzoLo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768598951; c=relaxed/simple;
	bh=FRcd1avd4PB9PmO5dQgmUicVEjm2xp4QOwjVLS7lcRo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=cftSK3NVAyFdBJb2MoSXm6kzd8Cqcadm8eR5GeGQPjSxc6c19IjnyRYxbxTBkOH/lJz/fyNM3mvQJc5FLMfhAhURlMrYko1zqNVvwk3/7H11+2GMMwvAV8j6upQg745ZAxpj5WWCHog+gNM2F0h1/SeqvxgFJ6aaxI0QgPhYcsM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TWnll7D6; arc=none smtp.client-ip=209.85.128.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TWnll7D6"
Received: by mail-yw1-f182.google.com with SMTP id 00721157ae682-793ae293fadso24436787b3.0
        for <virtualization@lists.linux.dev>; Fri, 16 Jan 2026 13:29:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768598947; x=1769203747; darn=lists.linux.dev;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=I07oD5ozWqHJLvu76IbvCT33HoDsgDmgjc920I58eyc=;
        b=TWnll7D6jmtCfwHgxnCtl3T03coCjQc/ug7YwAgeihYwghid9gf13Dh0usacP7m50B
         IqEY45MJ/UyfonoW7/ms99Qm51RJKhCimJusYz5HsJVcuZkA7OudtubuO8Y3MIxv91iT
         PkGyNmXP4J6HHn33zLTDFrENKzgsF2Vya7swM6a93fwyP8CrI8/HWDZAMPY0iOKA3Ikf
         2ic0W2Q7B9ai6XAV0i1nPZGUtXZheDe1ItLlKwZGI9b66YOtKYIZedLyhUfHbZkMEorp
         92r9joJG4OANnkOjKLXt4Nt7iqueZgMri3sZcR29Oq1Pw/RfKqRq1C/GGJZY7MitaFNg
         tbhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768598947; x=1769203747;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=I07oD5ozWqHJLvu76IbvCT33HoDsgDmgjc920I58eyc=;
        b=ssfk6jNlLXXHPsyw2JEQXHNm8fj1Qpc99rBGQ2fHYwZC9EGCW2zuWafdqCjDBGhCe0
         ihOKqW93dKwS68oY9DpdRF5TZVCRnJS6WeDLdifYSO23gzbFHZZIURJr5+4b2zop6Yce
         QrOGb+fDJN69culty5ausPmKt+JeNrdguPfMSeHBD63Ko7Vfo/NEmk5MlQKJ8YNDnzAa
         UqEzW1F5wXe+3QmCcQesCjlyu4VnLNIbEMWMUHVgftMx06X9/+WqItV+EzN0DYNrbttq
         CFxsA8V4IErTy+vd3HszZiIGac9Ue/zGPwV8nm0jw5l47mG8ocmkze4nuF0w5GTvE8Ex
         o/LQ==
X-Forwarded-Encrypted: i=1; AJvYcCVAlDTgoH+plBORdA78TOlKi2cGk0VAcRV8SR0ditHhwTAo2toi608b31JwVGF0ENGwfeGlPkztFI9PyftzPg==@lists.linux.dev
X-Gm-Message-State: AOJu0YxDOi2DrJuT5laZ/xEuatQ9pUpD4oqHuKNEDbYF8J0RydP1TaZF
	8Nv9Vm6C8jvhMTG7jZlnYc1yqni/Pwwl3d2i3jHYii0LysiVdL6loJMz
X-Gm-Gg: AY/fxX4j6ZnEAC9BCjAY5Y8DHgpXiyP7tGEEkSETVJfntlDv3BxNjghw7AX5JdaEJ64
	pr1RSeGujKAH/GHPGhA2paT41atjJioIhDw+VcYDmkfT2qVHg5bEQgiEmHVvzqaouTMYc0XuaKE
	qAC17trOrAdN2k5wzohUICOVOVSL/66vEQOBIeE6/IrFcIqwLEfAxzwPB83qsWGEkTjOLKSkxRD
	dRYfh5KsA4wRZYPZbCEcqNkyyDtD/+/qhFk4Z/5B5XJ6vGAzqcr5lUrPxuS6AhypPbJwg7ov0h6
	V2tx8EjwezXBgS75J0JdeR+z0FfZ4Hlw/9cdbjz7izmTRj/1smN6vZSNVjaJXw8+hya9QHE8xr5
	dyoX94Ev6tAZX6C+5d2rX/czpdTaJcRQJivFrpa6kIBK84xGfKLELKh+PYdC+yrZ8bO+/8GrPDw
	Q0uDZpnyu9iA==
X-Received: by 2002:a05:690c:b15:b0:792:6c16:110c with SMTP id 00721157ae682-793c6878c95mr28874267b3.61.1768598947252;
        Fri, 16 Jan 2026 13:29:07 -0800 (PST)
Received: from localhost ([2a03:2880:25ff:53::])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-793c66f3284sm13566387b3.17.2026.01.16.13.29.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Jan 2026 13:29:06 -0800 (PST)
From: Bobby Eshleman <bobbyeshleman@gmail.com>
Date: Fri, 16 Jan 2026 13:28:45 -0800
Subject: [PATCH net-next v15 05/12] selftests/vsock: add namespace helpers
 to vmtest.sh
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260116-vsock-vmtest-v15-5-bbfd1a668548@meta.com>
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

Add functions for initializing namespaces with the different vsock NS
modes. Callers can use add_namespaces() and del_namespaces() to create
namespaces global0, global1, local0, and local1.

The add_namespaces() function initializes global0, local0, etc... with
their respective vsock NS mode by toggling child_ns_mode before creating
the namespace.

Remove namespaces upon exiting the program in cleanup(). This is
unlikely to be needed for a healthy run, but it is useful for tests that
are manually killed mid-test.

This patch is in preparation for later namespace tests.

Reviewed-by: Stefano Garzarella <sgarzare@redhat.com>
Signed-off-by: Bobby Eshleman <bobbyeshleman@meta.com>
---
Changes in v13:
- intialize namespaces to use the child_ns_mode mechanism
- remove setting modes from init_namespaces() function (this function
  only sets up the lo device now)
- remove ns_set_mode(ns) because ns_mode is no longer mutable
---
 tools/testing/selftests/vsock/vmtest.sh | 32 ++++++++++++++++++++++++++++++++
 1 file changed, 32 insertions(+)

diff --git a/tools/testing/selftests/vsock/vmtest.sh b/tools/testing/selftests/vsock/vmtest.sh
index c7b270dd77a9..c2bdc293b94c 100755
--- a/tools/testing/selftests/vsock/vmtest.sh
+++ b/tools/testing/selftests/vsock/vmtest.sh
@@ -49,6 +49,7 @@ readonly TEST_DESCS=(
 )
 
 readonly USE_SHARED_VM=(vm_server_host_client vm_client_host_server vm_loopback)
+readonly NS_MODES=("local" "global")
 
 VERBOSE=0
 
@@ -103,6 +104,36 @@ check_result() {
 	fi
 }
 
+add_namespaces() {
+	local orig_mode
+	orig_mode=$(cat /proc/sys/net/vsock/child_ns_mode)
+
+	for mode in "${NS_MODES[@]}"; do
+		echo "${mode}" > /proc/sys/net/vsock/child_ns_mode
+		ip netns add "${mode}0" 2>/dev/null
+		ip netns add "${mode}1" 2>/dev/null
+	done
+
+	echo "${orig_mode}" > /proc/sys/net/vsock/child_ns_mode
+}
+
+init_namespaces() {
+	for mode in "${NS_MODES[@]}"; do
+		# we need lo for qemu port forwarding
+		ip netns exec "${mode}0" ip link set dev lo up
+		ip netns exec "${mode}1" ip link set dev lo up
+	done
+}
+
+del_namespaces() {
+	for mode in "${NS_MODES[@]}"; do
+		ip netns del "${mode}0" &>/dev/null
+		ip netns del "${mode}1" &>/dev/null
+		log_host "removed ns ${mode}0"
+		log_host "removed ns ${mode}1"
+	done
+}
+
 vm_ssh() {
 	ssh -q -o UserKnownHostsFile=/dev/null -p ${SSH_HOST_PORT} localhost "$@"
 	return $?
@@ -110,6 +141,7 @@ vm_ssh() {
 
 cleanup() {
 	terminate_pidfiles "${!PIDFILES[@]}"
+	del_namespaces
 }
 
 check_args() {

-- 
2.47.3

