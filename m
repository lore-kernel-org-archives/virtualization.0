Received: from mail-yw1-f176.google.com (mail-yw1-f176.google.com [209.85.128.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32B0412D1F1
	for <virtualization@lists.linux.dev>; Sat, 14 Mar 2026 00:00:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773446453; cv=none; b=WTPMFtYb4LcH+ZbDecWqw6jrfiqRJlZ6t+7VrCGzw6L6mdZ9qpMnPDv2ggFn85m589LfprgCQCgjBlDCEmqrmo+vn5s/sm6lhPbrbegdx8uTRL0CGuP79FJBvblU0tSRtXOLy2Vehcy+oQz9cTkvJSUGRpwsujFTb5HyASMrleA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773446453; c=relaxed/simple;
	bh=3QJbJv8nDTe9UFWDuhjUpYU/uYCzaMl40LclqolWBe4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=D9olOyyUqAvWZLGdLilkVfae/yW+9rUkmTREkg290M9CqFVvNPdSD2vsx4cG5vvPGY180VlHHisU+YlThXpshNdbRsHheYquXCmfv0kcAWwMUWokakuSxP6pk7LJ3U4aiaviWfu5ZjqJSteDAF6fgJAWCrgiVcOfbMSbMECfxCc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AaAUqaV3; arc=none smtp.client-ip=209.85.128.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AaAUqaV3"
Received: by mail-yw1-f176.google.com with SMTP id 00721157ae682-799001d73bdso21527747b3.0
        for <virtualization@lists.linux.dev>; Fri, 13 Mar 2026 17:00:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773446450; x=1774051250; darn=lists.linux.dev;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=7Z7785Nihx26mdg32kyA0yD1bLg4oGypoWx8npW/Glg=;
        b=AaAUqaV3HeFi1prpCxh28IbUhnrTdTC+LZKbzak/cpI/ApGvM/L4j//49+z9ze+MAL
         5Pv4hZw+P9GmGyZ60oc2ga1NW6+bVbW4M4J5woFFS/HwugtG4JFoP1QZz4IRIO/T/P/g
         qN1esJjrP8mLmpcx5cv0N5GpSLQ1SyAzF+CMPJCMF4FcGCIIcVIs2Exj2mtYGThlf1ID
         jYloFGsBfeepFBjHfhZKgM80W0jX9P+kNa9L7wfnkr0e/LO6GFspAGfOLN5O7RBBLUO0
         vvGK6ywMIYJx1/r1o6ZyeX7mQUkzTLeGetp0CgB4lLSsgoHICSuTqocXc3MonydKvQ7x
         l1Og==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773446450; x=1774051250;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=7Z7785Nihx26mdg32kyA0yD1bLg4oGypoWx8npW/Glg=;
        b=MX1gmINcsipdwIUP3+EgDbuTft+S9vpP4xALNe0mL83U+azrcAqablD5ongadBXryq
         YGb3NQpqNFO9P1li4z6bSj/5iUY3cimnq/x/0iLGiNQu2sQ+KtnZ38QtIZD/sL0MR2Mx
         WedQcEF1jsJH9dJFgKw3p9Ac9l/HOpwzi/vA4Xwg2eqoxWtVIPDs8RgaKYEmO68nv9uI
         ktasc98XesnFIOyMewYHUzoGDJqUQz6p9quLFzHbdppPOh18Ay/pyJaWrXq/W+HKy2iM
         z2FtOnrnmZBfoiguSpjG5SGrGuM7m7o851bf0IZHXX7JyKYi3dmuMc9sxPm5zkWHEARO
         zalg==
X-Gm-Message-State: AOJu0YwCeAL0ziHrM13kgLLyq2JXBbHxi4ko4DEnhgUOHnNA4vRlY2/L
	RxNEJnAyM5LxYgIwkCzoyQSmiWbM1d9y3lHhrFCGtbNlVMP9t/f5r5dTlZ/sLg==
X-Gm-Gg: ATEYQzzA0dsnwa+REK7RJFRRObvkhG/mTTNabL8Vs2wu0Aqf+1LMuyOl8VgrmQd2UmS
	VLro0bPMW6A5azesZNBrn20y8jRlI7Sd6ElP2lgu8pnXiXEx1mZ43jDqrHbdM5hzMFpQEAuVQoF
	6Laz3s9I111BoD24RgnfzP9f78rFlJpV+lDcFhGvtvp1tfH1viJ2VJfgDb8CODXXAQULltfZC5e
	9SvdMtOVIbsgBNh3nD312RsoLHB265bkE8d4eR5AwrtdBUXrYfTtS3Fm4kw8IjPbdAANu8iwgwQ
	XJQbWfhvUFvc+J/hDE+JxXmwX8P0SNuzTir9LYqWMq/mjCwTlf8YwUoualspHeQ+3JtY+1R7BY1
	VhgSRCe7KYsKjWAx0UXosxTTAYkXDOzQvZKifvpd+lYrx0Ky63FdB9q4DWE8NMX97QQZ9pbfm7a
	Kz9PjUv1P1UQvRKI1wJ7bfJQ==
X-Received: by 2002:a05:690c:e3ee:b0:799:1773:527d with SMTP id 00721157ae682-79a1c100004mr58333657b3.29.1773446450219;
        Fri, 13 Mar 2026 17:00:50 -0700 (PDT)
Received: from localhost ([2a03:2880:25ff:55::])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-79917ee4fdfsm57042447b3.25.2026.03.13.17.00.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Mar 2026 17:00:49 -0700 (PDT)
From: Bobby Eshleman <bobbyeshleman@gmail.com>
Date: Fri, 13 Mar 2026 17:00:14 -0700
Subject: [PATCH net-next 1/2] selftests/vsock: fix vmtest.sh for read-only
 nested VM runners
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260313-vsock-vmtest-nested-fixes-v1-1-d0e6274c3193@meta.com>
References: <20260313-vsock-vmtest-nested-fixes-v1-0-d0e6274c3193@meta.com>
In-Reply-To: <20260313-vsock-vmtest-nested-fixes-v1-0-d0e6274c3193@meta.com>
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
index 86e338886b33..c2cfcdf05d99 100755
--- a/tools/testing/selftests/vsock/vmtest.sh
+++ b/tools/testing/selftests/vsock/vmtest.sh
@@ -42,6 +42,8 @@ readonly KERNEL_CMDLINE="\
 	virtme.ssh virtme_ssh_channel=tcp virtme_ssh_user=$USER \
 "
 readonly LOG=$(mktemp /tmp/vsock_vmtest_XXXX.log)
+readonly TEST_HOME=$(mktemp -d /tmp/vmtest_home_XXXX)
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
+		--rwdir=/root=${TEST_HOME} \
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

