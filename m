Received: from mail-yw1-f177.google.com (mail-yw1-f177.google.com [209.85.128.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E3DE22FE11
	for <virtualization@lists.linux.dev>; Tue, 17 Mar 2026 00:56:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773708995; cv=none; b=RCfx4JiitGAnLS3sEF2XhSVI7DV5bRPGwslmhjIcaBmhZ9q6L1hFluiTqxKkVTJwjdGQj3cqjLaRGSR34kTlV6/+C10XsrMPfcIFBgoAVeRh2XcfJFELNQscpWlhfDU289Kl/kEdsBz28wYLVioC4PnoQnzOEQKb6gobbcD8u6g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773708995; c=relaxed/simple;
	bh=E+Hkdk1Kp8RLA9oT2ob9i9NCZmTcydZQUzHPrJghpSk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=BppvJkk8nVqLknUC63FCZ36+Yd6ID+SQEFNxkajIUpqTKlgTTRYW1C50xpN94TOAS2vCLzNYX2oerKXHpe9isGy7VgU31rnF3WxewIPpB+e8XkIPKodIi6A8N1dOcD1GyhY3BqvyqT/REcbUc5yX7ClPTHoqFUrW46Ii+Sqn+K4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RSO1wP9i; arc=none smtp.client-ip=209.85.128.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RSO1wP9i"
Received: by mail-yw1-f177.google.com with SMTP id 00721157ae682-79a50948018so16254437b3.3
        for <virtualization@lists.linux.dev>; Mon, 16 Mar 2026 17:56:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773708992; x=1774313792; darn=lists.linux.dev;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=gH1hPDl0XJ4BmlVqeBDzahDvtQK5lSZzA+ixw3hKdOo=;
        b=RSO1wP9ihFv6bCwTHgZHlFwYZ6sxOgK7P5evxubIzZRP2eqnMKX/xMQMceGXz2L6pV
         i0YwVomL+u7Q09AWRXwfv3o/ulGu8d4ZtnU2AlUn0KgLwAw4p84GsRQE3fZkZkOk52SA
         fmYlir3LYOxgOJAmxfrGaYBe/+vOJ8mY8MIzUXiaILdmRtQS9kNQWHE37V/cCk0LOVGh
         MchtnZzPkBvULRJ5OatVmHBiD1HyGNW7slcQ3R3SZOyuYN9bJNqQFFGestNQsYzxPNxJ
         kqNjn56eNJNAjZY0Z04DdaM39sT7Gd1wMnSZmgyFr7+Tg0zX7EJavY/oMQYNdJMXemjN
         R0RQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773708992; x=1774313792;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gH1hPDl0XJ4BmlVqeBDzahDvtQK5lSZzA+ixw3hKdOo=;
        b=HC7egHpgGuN5KBh33PUsaut52mzc5Ls1ADWK2r7jVAQpjkyxuFyisRyzfC48Guo1rt
         dZRY3rirUlT9p9si93vtJ2sWRQvmM8Slgvssc39z6STm/3qh0Zn39QnDvJy1o5uGBP2M
         X2CxcEWaZEPSBuFzAB8FcYR71xasRglLKGXsu+C5U0kTd2KCPKggIbkzgq5Akhjzb7tQ
         RKFYZUONa2WBh9jwV2ZHIbnzo/CuPcmVsapWRebJJxsL0SSHExcGk8AGZ1ksarQxR2j/
         0vXsvsZJC6ftLKurlf4dDVOhJhgsB+7Mrg1LB7hGwmBMVcdhCQ3RZfeI3fJJ7jc6ZEQ2
         6UQw==
X-Gm-Message-State: AOJu0YwrtapSxO7OaanvuPk/6AGIQ90bnS5D2lxrBWkPK6prw6v2Bs52
	4Tz+TJM9UESv7joThGPvNQaHzhViYifD9DMbojjDKk98BkXuhkmqRAPm
X-Gm-Gg: ATEYQzylLg8Zew+07znwkMDEKHZ0wKAP1b373iyvue5QkhRcqsNkv5QEOsEfDGvV0iC
	fp7rk+DloW7PAPiHlBS+Bf5dOBAPIB79g6UFmh4yDWOFarZsLrjjLA2YWKp+D2pvRS1qpHHC5rB
	Gnqso/8vYQtVRMhXFu94MY4oqufX7zbP5BglOtOZh/lGu4c/ea6Nv5ftrxxxYQiQh0YHxV+Gmxi
	fGi7+NKqXXDA2qdN4Bu3b/KgEe4FpKUuNmT2BbX6Na6/0RDvN/nA0FR1AbDyH1em3IXg9anNdZZ
	pP+zAPGfh3URAfQnOtQdbgFf5/lg/FKgsqE49TwM/915kIPCL+36tkAM1wWoICfbort3o79ezvV
	S5v29iDPMw+FDOCbPZuGlstpuYEqCPhnvuG/AFKMBpoxtpXrr0WBmSk0MfrnS7XME8gRC40wqxJ
	ju43cx19+Z+Ih+rZNjPojOVw==
X-Received: by 2002:a05:690c:6d83:b0:799:1f23:6e46 with SMTP id 00721157ae682-79a1c1888efmr154062187b3.33.1773708992420;
        Mon, 16 Mar 2026 17:56:32 -0700 (PDT)
Received: from localhost ([2a03:2880:25ff:50::])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-79917deb69asm94638557b3.10.2026.03.16.17.56.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Mar 2026 17:56:31 -0700 (PDT)
From: Bobby Eshleman <bobbyeshleman@gmail.com>
Date: Mon, 16 Mar 2026 17:56:15 -0700
Subject: [PATCH net-next v2] selftests/vsock: auto-detect kernel for guest
 VMs
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260316-vsock-vmtest-autodetect-kernel-v2-1-5eec7b4831f8@meta.com>
X-B4-Tracking: v=1; b=H4sIAK+muGkC/43NSwqDMBAA0KuEWTslH1TqqvcoLtJkrMGalGQaL
 OLdC56g67d4OxTKgQoMYodMNZSQIgxCNwLcbOOTMHgYBGipO2mUwVqSW7CuTIXRfjh5YnKMC+V
 IL/S+u7bkje2VhEbAO9MUtjO4QyTGSBvD2AiYQ+GUv+dc1en/JlWhwl62zrQP7/qJbiuxvbi0w
 ngcxw9OGLB41QAAAA==
X-Change-ID: 20260313-vsock-vmtest-autodetect-kernel-dd695ed3a710
To: Stefano Garzarella <sgarzare@redhat.com>, Shuah Khan <shuah@kernel.org>
Cc: virtualization@lists.linux.dev, netdev@vger.kernel.org, 
 linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Jakub Kicinski <kuba@kernel.org>, Bobby Eshleman <bobbyeshleman@meta.com>
X-Mailer: b4 0.14.3

From: Bobby Eshleman <bobbyeshleman@meta.com>

When running vmtest.sh inside a nested VM the running kernel may not be
installed on the filesystem at the standard /boot/ or /usr/lib/modules/
paths.

Previously, this would cause vng to fail with "does not exist" since it
could not find the kernel image. Instead, this patch uses --dry-run to
detect if the kernel is available. If not, then we fall back to the
kernel in the kernel source tree. If that fails, then we die.

This way runners, like NIPA, can use vng --run arch/x86/boot/bzImage to
setup an outer VM, and vmtest.sh will still do the right thing setting
up the inner VM.

Due to job control issues in vng, a workaround is used to prevent 'make
kselftest TARGETS=vsock' from hanging until test timeout. A PR has been
placed upstream to solve the issue in vng:

https://github.com/arighi/virtme-ng/pull/453

Signed-off-by: Bobby Eshleman <bobbyeshleman@meta.com>
---
Changes in v2:
- add setsid workaround for make kselftest TARGETS=vsock
- Link to v1: https://lore.kernel.org/r/20260313-vsock-vmtest-autodetect-kernel-v1-1-705c35bdc7fe@meta.com
---
 tools/testing/selftests/vsock/vmtest.sh | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/tools/testing/selftests/vsock/vmtest.sh b/tools/testing/selftests/vsock/vmtest.sh
index 86e338886b33..9eacb753238a 100755
--- a/tools/testing/selftests/vsock/vmtest.sh
+++ b/tools/testing/selftests/vsock/vmtest.sh
@@ -415,6 +415,19 @@ terminate_pids() {
 	done
 }
 
+vng_dry_run() {
+	# WORKAROUND: use setsid to work around a virtme-ng bug where vng hangs
+	# when called from a background process group (e.g., under make
+	# kselftest). vng save/restores terminal settings using tcsetattr(),
+	# which is not allowed for background process groups because the
+	# controlling terminal is owned by the foreground process group. vng is
+	# stopped with SIGTTOU and hangs until kselftest's timer expires.
+	# setsid works around this by launching vng in a new session that has
+	# no controlling terminal, so tcsetattr() succeeds.
+
+	setsid -w vng --run "$@" --dry-run &>/dev/null
+}
+
 vm_start() {
 	local pidfile=$1
 	local ns=$2
@@ -441,6 +454,12 @@ vm_start() {
 
 	if [[ "${BUILD}" -eq 1 ]]; then
 		kernel_opt="${KERNEL_CHECKOUT}"
+	elif vng_dry_run; then
+		kernel_opt=""
+	elif vng_dry_run "${KERNEL_CHECKOUT}"; then
+		kernel_opt="${KERNEL_CHECKOUT}"
+	else
+		die "No suitable kernel found"
 	fi
 
 	if [[ "${ns}" != "init_ns" ]]; then

---
base-commit: 8f921f61005450589c0bc1a941a5ddde21d9aed9
change-id: 20260313-vsock-vmtest-autodetect-kernel-dd695ed3a710

Best regards,
-- 
Bobby Eshleman <bobbyeshleman@meta.com>

