Received: from mail-yw1-f175.google.com (mail-yw1-f175.google.com [209.85.128.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 607223630B1
	for <virtualization@lists.linux.dev>; Tue, 17 Mar 2026 22:09:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773785386; cv=none; b=dwnCu4USC0eLL8Be/iclCWAk9vxvf5lAt52dD5dUDIePnanHXhYVWmtMggM8d40+Ec8ezOpWsWyEpiQcgpimTHBGGzyVhEyLqL1EgASKFnhMNDYS2vqO92XFv8RR1xKwKqCvpwjKWeAI5MrHkxVDcno4rRXDkMVPXct3V+kttXA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773785386; c=relaxed/simple;
	bh=b+CHW6D+Tes3tWuDt2z0es3oTuQs3Fq7ETrR7tgvf/U=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=AxHvqpURY5Jo7yZF+OptOlvrHp9uFtLCbt90y6MLcBJP7E27tz5zy+dm8B4wHzkA8gkPyioKaP9snetiI1u7av0ekeNLlTHgc57UZ04TOutVya2Cup5iPmFMzy/lG+VCFLKfn2MHMY1T9FpZG/s7uEuhVaVqYdYotgUHyqNemLY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eN1PxdEp; arc=none smtp.client-ip=209.85.128.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eN1PxdEp"
Received: by mail-yw1-f175.google.com with SMTP id 00721157ae682-79a3ba1653fso27837077b3.3
        for <virtualization@lists.linux.dev>; Tue, 17 Mar 2026 15:09:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773785384; x=1774390184; darn=lists.linux.dev;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=vpW8gynkMYuHb0nRn7cLLL0m7fiOcOBnsG4vYKWVvhU=;
        b=eN1PxdEpDZ0EQr90z90Cz6rq9X80+2wECC7hmZpYyQjdiwBTPT/NF+RUsDKcdy+4H6
         MMqCXR9nuN5m2WdV9as9BYTgrGfukk8hr57l+PHKzdaMCTD+TVWMTR2eyLQjkUOreDoI
         7ks3Y3lmcBC7q3lv4qHZnSekv68MdOP9qcBFsVoZ09nKu72HfzDke6Lq5b/kc0z+owkS
         0O4pSjsLa0HlbVT4Elz9JtWfRNPzXsnN3RJfQ9SOyppmSlwQZd/XWhu2/iVBVMoBA9+6
         l2AnqtTjMT+npTuVdt0+Mx94EhXb2XJuunIDw1M8SCilCiyEy63Fj1WUwxsDr/sWsipg
         CV4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773785384; x=1774390184;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=vpW8gynkMYuHb0nRn7cLLL0m7fiOcOBnsG4vYKWVvhU=;
        b=CWNXpLsRn5/MxIpChJ0yw9+SWSZiKtZILloOaJ2S+1LUSlNkQgV6KFoj4hBTpxP3Ub
         CcjeVxopfB+5ijY/R6AjBjHEECz2kKDthnHzvV4YchDecydcWOWbGru28Mlf3ngOGyKQ
         /NYc7AcuJF9thMYS7aKdyzzU1LGTq8QHPwBNIb8wPSWdDSFobhgAQxVP3jvFbO4vO3qf
         sm6+hx9G5mndkl5TulR1GgmvHUYBBIvpvbTeEC8XoKVSHQiK5AhdMBDxP2v5JM2ZrRtx
         5Fj/CRdxy9gdswflA0QYQCWR0H9zTDMzFQgMv4RjKU0HLSwzxqZp9hKYF8X7fsHw/Hoq
         6X9g==
X-Gm-Message-State: AOJu0YzoyyuTZ1+wFMK6Tgqyo9r+5ApkMQvhWMhCEcPSMFOrWc/oUiGS
	rhrWN4FswW1BJNG+PhawGdz1jUu1i2B8vYEws6ygwUcnh1ujSYThDSNB
X-Gm-Gg: ATEYQzyf72sUBVp5MYceTnoEpwou9/H3dtihJQfPrGBPnwjLVvnhevMADyUpQG+HVd4
	vit9mdMkcxqEJyHow5IxjAzOTJwUC4ycj8ONFn8HbLPI+GM/Vh0CN44wy/IY81ELM7C2rA9h33d
	JrKpugmF7tLbB8O6I6uQQCMD51KkfbwJI83G2z0N2++VHaCo5gJFYxNrm2h26HGiKtCp58e3kUr
	VSWn+8ZxJZ4Ri/3L4fG7XB8cIxiWIHt3DZOaq5JvWjqpWBlXN7GfM9+4259zs/2sPQujrsiItPo
	2vXos5NT9UO47JmShL1tLba1XloogHJ87ZsQUu/vmYGPdwQ628+S6DUMXKn51yvO8z9Is7w0UIS
	dHm4xLtsmo9ItU+veR7P6aVYw9jRO7O4CBGTeRolAvif7EjFbzmnhjXtZvPsULXVjXfMRW4+Z9B
	5W6yFYLevrwDZw/aIlA0rWEg==
X-Received: by 2002:a05:690c:c50d:b0:79a:5164:bb08 with SMTP id 00721157ae682-79a7181bd39mr11782367b3.8.1773785384400;
        Tue, 17 Mar 2026 15:09:44 -0700 (PDT)
Received: from localhost ([2a03:2880:25ff:45::])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-79a713f31b8sm6186507b3.18.2026.03.17.15.09.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Mar 2026 15:09:44 -0700 (PDT)
From: Bobby Eshleman <bobbyeshleman@gmail.com>
Date: Tue, 17 Mar 2026 15:09:35 -0700
Subject: [PATCH net-next v2 1/2] selftests/vsock: fix vmtest.sh for
 read-only nested VM runners
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260317-vsock-vmtest-nested-fixes-v2-1-0b3f53b80a0f@meta.com>
References: <20260317-vsock-vmtest-nested-fixes-v2-0-0b3f53b80a0f@meta.com>
In-Reply-To: <20260317-vsock-vmtest-nested-fixes-v2-0-0b3f53b80a0f@meta.com>
To: Stefano Garzarella <sgarzare@redhat.com>, Shuah Khan <shuah@kernel.org>
Cc: virtualization@lists.linux.dev, netdev@vger.kernel.org, 
 linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Jakub Kicinski <kuba@kernel.org>, Bobby Eshleman <bobbyeshleman@meta.com>
X-Mailer: b4 0.14.3

From: Bobby Eshleman <bobbyeshleman@meta.com>

When running vmtest.sh inside a nested VM, there occurs a problem
with stacking two sets of virtiofs/overlay layers (the first set from
the outer VM and the second set from the inner VM). The virtme init
scripts (sshd, udhcpd, etc...) fail to execute basic programs (e.g.,
/bin/cat) and load library dependencies (e.g., libpam) due to ESTALE.
This only occurs when both layers (outer and inner) use virtiofs. Work
around this by using 9p in the inner VM via --force-9p.

Additionally, when the outer VM is read-only, the inner VM's attempt at
populating SSH keys to the root filesystem fails:

virtme-ng-init: mkdir: cannot create directory '/root/.cache': Read-only file system

Work around this by creating a temporary home directory with generated
SSH keys and passing it through to the guest as /root via --rwdir.
Disable strict host key checking in vm_ssh() since the VM will be seen
as a new host each run.

The --rw arg had to be removed to prevent a vng complaint about overlay
(in combination with the other parameters). The guest doesn't really
need write access anyway, so this was probably overly permissive to
begin with.

Signed-off-by: Bobby Eshleman <bobbyeshleman@meta.com>
---
 tools/testing/selftests/vsock/vmtest.sh | 21 +++++++++++++++++++--
 1 file changed, 19 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/vsock/vmtest.sh b/tools/testing/selftests/vsock/vmtest.sh
index 86e338886b33..a4b56322ce9b 100755
--- a/tools/testing/selftests/vsock/vmtest.sh
+++ b/tools/testing/selftests/vsock/vmtest.sh
@@ -42,6 +42,8 @@ readonly KERNEL_CMDLINE="\
 	virtme.ssh virtme_ssh_channel=tcp virtme_ssh_user=$USER \
 "
 readonly LOG=$(mktemp /tmp/vsock_vmtest_XXXX.log)
+readonly TEST_HOME="$(mktemp -d /tmp/vmtest_home_XXXX)"
+readonly SSH_KEY_PATH="${TEST_HOME}"/.ssh/id_ed25519
 
 # Namespace tests must use the ns_ prefix. This is checked in check_netns() and
 # is used to determine if a test needs namespace setup before test execution.
@@ -257,7 +259,12 @@ vm_ssh() {
 
 	shift
 
-	${ns_exec} ssh -q -o UserKnownHostsFile=/dev/null -p "${SSH_HOST_PORT}" localhost "$@"
+	${ns_exec} ssh -q \
+		-i "${SSH_KEY_PATH}" \
+		-o UserKnownHostsFile=/dev/null \
+		-o StrictHostKeyChecking=no \
+		-p "${SSH_HOST_PORT}" \
+		localhost "$@"
 
 	return $?
 }
@@ -265,6 +272,7 @@ vm_ssh() {
 cleanup() {
 	terminate_pidfiles "${!PIDFILES[@]}"
 	del_namespaces
+	rm -rf "${TEST_HOME}"
 }
 
 check_args() {
@@ -382,6 +390,11 @@ handle_build() {
 	popd &>/dev/null
 }
 
+setup_home() {
+	mkdir -p "$(dirname "${SSH_KEY_PATH}")"
+	ssh-keygen -t ed25519 -f "${SSH_KEY_PATH}" -N "" -q
+}
+
 create_pidfile() {
 	local pidfile
 
@@ -451,11 +464,14 @@ vm_start() {
 		--run \
 		${kernel_opt} \
 		${verbose_opt} \
+		--rwdir=/root="${TEST_HOME}" \
+		--force-9p \
+		--cwd /root \
 		--qemu-opts="${qemu_opts}" \
 		--qemu="${qemu}" \
 		--user root \
 		--append "${KERNEL_CMDLINE}" \
-		--rw  &> ${logfile} &
+		&> ${logfile} &
 
 	timeout "${WAIT_QEMU}" \
 		bash -c 'while [[ ! -s '"${pidfile}"' ]]; do sleep 1; done; exit 0'
@@ -1532,6 +1548,7 @@ check_deps
 check_vng
 check_socat
 handle_build
+setup_home
 
 echo "1..${#ARGS[@]}"
 

-- 
2.52.0

