Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8979338F38
	for <virtualization@lists.linux.dev>; Tue,  4 Nov 2025 22:39:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762295956; cv=none; b=eB7+lDUNYXhUALtAA90P6I3hlf/p3Xzt9I2RaXluPBj8S5m9v7W7DBK90GVDxdu7g3spoHDGz5Ppa1OXyPkYwIFuAY7Ojxoh8KqfsbUleznUaBqZ+TcBFl8YNHv+BXbBoyZ8kl50cXk8q8rIoGsZp7JU3EuYJlCEn74S1aYTnmE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762295956; c=relaxed/simple;
	bh=qaM/YycVu4RVy+bT1TrwTWoAn6/Kw7T+6Ey2I1qpe/o=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=RePkg+qOR7Nc/yiVdIuGapVW6MlnMQ1FfYxOBFFxBodMEr5tDJxKDJFG6NtfnVGzhkpMemeS+Uq5P/EN7WShkxbJFJbutO1PjIcrrv3PSFAfCWKf5YgBwv9zrPwYhR3df5vX1ud/5hX0YeYJJKco57LNttvJ5vFwVsvBU51h2og=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RAOyqdSe; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RAOyqdSe"
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-27c369f8986so61754935ad.3
        for <virtualization@lists.linux.dev>; Tue, 04 Nov 2025 14:39:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762295953; x=1762900753; darn=lists.linux.dev;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=rPomieP6y6cKKzxkcHQHYffWFCMJSj6awEpxYtimWiU=;
        b=RAOyqdSeaLON32CkpWnn14NPCePxw45tca3Qg7Thghu+whDy/jrTaxWFFWCjOHOFcG
         DHJ0Yodtf1xJL/X/wVgBIpk4hpH9SoVd4pgmPD1m+HVg7GawTa7qD67Dy3M3HsHrcz5h
         QvrxaAtLlODklW7tmYgUg6odfe0bwFqLN6GAEQcoraEx0/YZ+Ogm6MKZSmBQ3tO8V0nD
         dg+OxVd/0UNpvd7XafrVQreG+D/RB5VKzBZB2hZhipa93cLgvq9Rkc/9WH20dhIdtFZG
         cvVt1S+72a8MFoQmun6XPmqomAv+uqAWHEZMQQ2YqzocbKAj9vzaWd3OasQLckGf/JWS
         85wA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762295953; x=1762900753;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rPomieP6y6cKKzxkcHQHYffWFCMJSj6awEpxYtimWiU=;
        b=kYozVf8OtVxKVEj5gEY+ZKWm4QNRkmE+tdu7iQZ/HxfhaGgFMMJfxkJslltBa/Tl79
         Q/kTfsDVk6viNRGynZUO/JRUXBq2HuTad9bipVSnLMLxaysMwwKGO61W/5p3weYUOo/N
         SQpAhSnL0n4z8u4RYQ7+hLHkUzHu3nYOiGpUPxdnMMkdlchEPd7bxcSPlSaFpeXI+R2z
         e0XBCgPESS5YMZdYc7SDuZPPA8xUlzwEOFC1RQ9v7NROMmWEh9HwFtD2Uw7oaZCS85ET
         fNYAsHL/aPybuIbg4t6xHLvyUHGSStRcBAiycBwj2/wotTHteGz9H1p1yemvev7bO2sH
         Vi8A==
X-Gm-Message-State: AOJu0Yyv2ZKt//LJgNpVbhcGs+zho6YmU7C0/d7zLm+NRnQ3xO/ePAha
	AvX8maxZTvF+ruJJOkDSJLEmMmuAA3tXF/erDjX2rMKUBTLnTej/09fq
X-Gm-Gg: ASbGncu7jPFkc27LuROh24eU+H+1A8OSeht7SZ57FBYjOSP1m4tk86f3t0CF0A1bjny
	QJQvLqSWQdBcoLa6irtcXleIM5JGLfY1lEp6CIOOJ3tRi78dndxemez35EYdNu1hYC3alBhEREL
	/fqLvA5zwgUrpW856MeolqgXaNmwQ4Cb8BMsvS8vvt1Z7j19U0wnp30Ytr4iiPYbWtNQZLPrCz5
	1Mx2/IrngUZ0J+9Z//p5iOh/URYiuONQleZ0CNLgnPuO6e1lVbhloHqW/k/zidLPxRM9YeZWvIT
	NPrP2x/Mijag+XsY8XqPWNsybllOVKjMHagYNvotUSsxXsCVjIrBN57n17xfCaeOGP9i5hbrTp2
	dAgQ9hUSzCvIfiNnhOVqo/15puKmQWKq3zmq9tnCWcvH/cOsj5hnJgH42aAF0RyLS1m1G7JqBgg
	==
X-Google-Smtp-Source: AGHT+IHD3n38ktdMLAtQTdG9dlRMpp5+qaB/a5F/5Hc82s9u1whde0uAmROI8lO0PC79msxpg9QR4Q==
X-Received: by 2002:a17:903:19e4:b0:290:cd9c:1229 with SMTP id d9443c01a7336-2962ad1f5d4mr15355965ad.19.1762295952976;
        Tue, 04 Nov 2025 14:39:12 -0800 (PST)
Received: from localhost ([2a03:2880:2ff:45::])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29601998336sm38421705ad.31.2025.11.04.14.39.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Nov 2025 14:39:12 -0800 (PST)
From: Bobby Eshleman <bobbyeshleman@gmail.com>
Date: Tue, 04 Nov 2025 14:38:54 -0800
Subject: [PATCH net-next v2 04/12] selftests/vsock: avoid multi-VM pidfile
 collisions with QEMU
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251104-vsock-selftests-fixes-and-improvements-v2-4-ca2070fd1601@meta.com>
References: <20251104-vsock-selftests-fixes-and-improvements-v2-0-ca2070fd1601@meta.com>
In-Reply-To: <20251104-vsock-selftests-fixes-and-improvements-v2-0-ca2070fd1601@meta.com>
To: Stefano Garzarella <sgarzare@redhat.com>, Shuah Khan <shuah@kernel.org>, 
 Jakub Kicinski <kuba@kernel.org>, Bobby Eshleman <bobbyeshleman@gmail.com>
Cc: virtualization@lists.linux.dev, netdev@vger.kernel.org, 
 linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Simon Horman <horms@kernel.org>, Bobby Eshleman <bobbyeshleman@meta.com>
X-Mailer: b4 0.13.0

From: Bobby Eshleman <bobbyeshleman@meta.com>

Change QEMU to use generated pidfile names instead of just a single
globally-defined pidfile. This allows multiple QEMU instances to
co-exist with different pidfiles. This is required for future tests that
use multiple VMs to check for CID collissions.

Additionally, this also places the burden of killing the QEMU process
and cleaning up the pidfile on the caller of vm_start(). To help with
this, a function terminate_pidfiles() is introduced that callers use to
perform the cleanup. The terminate_pidfiles() function supports multiple
pidfile removals because future patches will need to process two
pidfiles at a time.

Change QEMU_OPTS to be initialized inside the vm_start(). This allows the
generated pidfile to passed to the string assignment, and prepares for
future vm-specific options as well (e.g., cid).

Signed-off-by: Bobby Eshleman <bobbyeshleman@meta.com>
---
Changes in v2:
- mention QEMU_OPTS changes in commit message (Simon)
---
 tools/testing/selftests/vsock/vmtest.sh | 53 +++++++++++++++++++--------------
 1 file changed, 30 insertions(+), 23 deletions(-)

diff --git a/tools/testing/selftests/vsock/vmtest.sh b/tools/testing/selftests/vsock/vmtest.sh
index 03dc4717ac3b..5637c98d5fe8 100755
--- a/tools/testing/selftests/vsock/vmtest.sh
+++ b/tools/testing/selftests/vsock/vmtest.sh
@@ -23,7 +23,7 @@ readonly VSOCK_CID=1234
 readonly WAIT_PERIOD=3
 readonly WAIT_PERIOD_MAX=60
 readonly WAIT_TOTAL=$(( WAIT_PERIOD * WAIT_PERIOD_MAX ))
-readonly QEMU_PIDFILE=$(mktemp /tmp/qemu_vsock_vmtest_XXXX.pid)
+readonly PIDFILE_TEMPLATE=/tmp/vsock_vmtest_XXXX.pid
 
 # virtme-ng offers a netdev for ssh when using "--ssh", but we also need a
 # control port forwarded for vsock_test.  Because virtme-ng doesn't support
@@ -33,12 +33,6 @@ readonly QEMU_PIDFILE=$(mktemp /tmp/qemu_vsock_vmtest_XXXX.pid)
 # add the kernel cmdline options that virtme-init uses to setup the interface.
 readonly QEMU_TEST_PORT_FWD="hostfwd=tcp::${TEST_HOST_PORT}-:${TEST_GUEST_PORT}"
 readonly QEMU_SSH_PORT_FWD="hostfwd=tcp::${SSH_HOST_PORT}-:${SSH_GUEST_PORT}"
-readonly QEMU_OPTS="\
-	 -netdev user,id=n0,${QEMU_TEST_PORT_FWD},${QEMU_SSH_PORT_FWD} \
-	 -device virtio-net-pci,netdev=n0 \
-	 -device vhost-vsock-pci,guest-cid=${VSOCK_CID} \
-	 --pidfile ${QEMU_PIDFILE} \
-"
 readonly KERNEL_CMDLINE="\
 	virtme.dhcp net.ifnames=0 biosdevname=0 \
 	virtme.ssh virtme_ssh_channel=tcp virtme_ssh_user=$USER \
@@ -89,17 +83,6 @@ vm_ssh() {
 	return $?
 }
 
-cleanup() {
-	if [[ -s "${QEMU_PIDFILE}" ]]; then
-		pkill -SIGTERM -F "${QEMU_PIDFILE}" > /dev/null 2>&1
-	fi
-
-	# If failure occurred during or before qemu start up, then we need
-	# to clean this up ourselves.
-	if [[ -e "${QEMU_PIDFILE}" ]]; then
-		rm "${QEMU_PIDFILE}"
-	fi
-}
 
 check_args() {
 	local found
@@ -188,10 +171,26 @@ handle_build() {
 	popd &>/dev/null
 }
 
+terminate_pidfiles() {
+	local pidfile
+
+	for pidfile in "$@"; do
+		if [[ -s "${pidfile}" ]]; then
+			pkill -SIGTERM -F "${pidfile}" > /dev/null 2>&1
+		fi
+
+		if [[ -e "${pidfile}" ]]; then
+			rm -f "${pidfile}"
+		fi
+	done
+}
+
 vm_start() {
+	local pidfile=$1
 	local logfile=/dev/null
 	local verbose_opt=""
 	local kernel_opt=""
+	local qemu_opts=""
 	local qemu
 
 	qemu=$(command -v "${QEMU}")
@@ -201,6 +200,13 @@ vm_start() {
 		logfile=/dev/stdout
 	fi
 
+	qemu_opts="\
+		 -netdev user,id=n0,${QEMU_TEST_PORT_FWD},${QEMU_SSH_PORT_FWD} \
+		 -device virtio-net-pci,netdev=n0 \
+		 -device vhost-vsock-pci,guest-cid=${VSOCK_CID} \
+		--pidfile ${pidfile}
+	"
+
 	if [[ "${BUILD}" -eq 1 ]]; then
 		kernel_opt="${KERNEL_CHECKOUT}"
 	fi
@@ -209,14 +215,14 @@ vm_start() {
 		--run \
 		${kernel_opt} \
 		${verbose_opt} \
-		--qemu-opts="${QEMU_OPTS}" \
+		--qemu-opts="${qemu_opts}" \
 		--qemu="${qemu}" \
 		--user root \
 		--append "${KERNEL_CMDLINE}" \
 		--rw  &> ${logfile} &
 
 	if ! timeout ${WAIT_TOTAL} \
-		bash -c 'while [[ ! -s '"${QEMU_PIDFILE}"' ]]; do sleep 1; done; exit 0'; then
+		bash -c 'while [[ ! -s '"${pidfile}"' ]]; do sleep 1; done; exit 0'; then
 		die "failed to boot VM"
 	fi
 }
@@ -480,8 +486,6 @@ do
 done
 shift $((OPTIND-1))
 
-trap cleanup EXIT
-
 if [[ ${#} -eq 0 ]]; then
 	ARGS=("${TEST_NAMES[@]}")
 else
@@ -496,7 +500,8 @@ handle_build
 echo "1..${#ARGS[@]}"
 
 log_host "Booting up VM"
-vm_start
+pidfile="$(mktemp -u $PIDFILE_TEMPLATE)"
+vm_start "${pidfile}"
 vm_wait_for_ssh
 log_host "VM booted up"
 
@@ -520,6 +525,8 @@ for arg in "${ARGS[@]}"; do
 	cnt_total=$(( cnt_total + 1 ))
 done
 
+terminate_pidfiles "${pidfile}"
+
 echo "SUMMARY: PASS=${cnt_pass} SKIP=${cnt_skip} FAIL=${cnt_fail}"
 echo "Log: ${LOG}"
 

-- 
2.47.3

