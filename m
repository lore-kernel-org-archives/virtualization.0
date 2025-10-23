Received: from mail-pf1-f173.google.com (mail-pf1-f173.google.com [209.85.210.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6286819F13F
	for <virtualization@lists.linux.dev>; Thu, 23 Oct 2025 01:00:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761181231; cv=none; b=irwkNGQsFnUky/58bewqpqjNWv0jmg4HZmgAZFNrU7Z1oru0RzKF/34MLYlJB2GzHknoXiTTdksoIhYlLtmlr7mDb7Xbrm1XRn2awmWG4Rbdu/L948Cs0PaO/PiPZQsLd0Gv4OnWO+wH+KIQ9YuEBqZuKwPkHV9JcdrtLVNoO7I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761181231; c=relaxed/simple;
	bh=FRgbksM3HIGYkwx36Cagrg47zhk41xhggIZrcI5RpEY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ilYZG1IYCfwBrIVPFIu0pJRCezt3xB3i/XMgmlQ8xOcUh9LblPSDv8L/RI2LzEnW/aMQZV/b0Vxy/nyBKv1fvhfv3BCJvbm+lMDbACmmbAt5NwVo2yVjEBFHSHNkQ6yRyT9XhoLY47SY+FRBbfxG8SMNTzhr6wL0fmNdydUea2c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ksZoNIcw; arc=none smtp.client-ip=209.85.210.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ksZoNIcw"
Received: by mail-pf1-f173.google.com with SMTP id d2e1a72fcca58-78af743c232so255670b3a.1
        for <virtualization@lists.linux.dev>; Wed, 22 Oct 2025 18:00:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761181228; x=1761786028; darn=lists.linux.dev;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=psdpZrmw9QO6xTkaBDSFoh7/I56QbRl0HPRaHD7JNxQ=;
        b=ksZoNIcwI9xjJD7AuYUFEhR/6wJp0EVGXVCCKShbWAkZHdVbViSqDUohirYJFvOOmb
         wYydrUCKbgxL8Phgru7V0bpg/sVrTSRgCtbS8HbAuugWb/ZrPDsNOIoU7mcgcYn3w4jX
         MqLEbXPy3JPFs1ob4T4LqGNHLNA9Js44u8cUPKfh37+1mYW0b6tZq8PeT1wyGuzxHskd
         1nzYhaASHd/gNCCAzIYRTOja2Naq/ud4/W2dK2pHG7hmyzdUtHoh+fGrYfec1uccvIOK
         LfUz502DnkxZNqN/auQzSkM9FRDAgpu9A0OrdU7J3Krho3iDxlmSX0fLIQwj4wS9VvwA
         KJLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761181228; x=1761786028;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=psdpZrmw9QO6xTkaBDSFoh7/I56QbRl0HPRaHD7JNxQ=;
        b=B49xKOFRzVEQBzV3ZE2QXgjNvCswJRxuJiETdv9lV8Pf7lQs5azI9y7k+7fbbj3Gdu
         s2fNtRfJvUoJ0+u5o1K/dYBFysOjo/B0/11o0UWPyvDjnM15EU6spQm+vVYIh7skQqrb
         rAx37MyY4jubdfN6C1+1XkC/bhb9i+WotMHQuqxRklpdwvtVPvC36xwlbkJuRfr+00B8
         vgyfQRiN61Dqfx2OwhoLdPLkBnSvUebUVB9/Go8Ov3wbEhbTle9F/8t2bf8/3SCXx4se
         M+Sl8cS/VkbCLgBSbC4TxktoKnQT2GM2dE3ccGRJpuvuK6VUlAizi1AAMeR10ybCzjC0
         tLTQ==
X-Gm-Message-State: AOJu0YxQpiV/95K4ooMOzh2R+2R2pr+3RegO1ch1wYd1/ZodiePY5qvO
	rMJvWxwwZWxK8mp3UwzB+C5RXpBmEcAhOJErbRoUKBlyhqoIEla4MNGcqC3mqyYx
X-Gm-Gg: ASbGnctaUvNd+1QPjTcqm8zzHsudbMFu1jHSKglhOzBvryU8nQEsqBM0bO9DPnGqiHU
	E84wEnjf3pSAApLX5sb9192LUryYazY3Zmw67Qw65sfAOuhtbtLO+7EXdR/azVRlrG4liyLE2LG
	y4s3HZ3JIPgFhMuZa5h9Ckz4e1MjQyQNTdDVKvFtbcWwNU2J1C0nr4c5JUMXOiP6Q+7kLmmYEls
	x3p7kLQhP0TIjg3ahINrfHQ8asU7CnAyP/zMQAO3LnFQc7WZbK9vFpBx2L1EQ8PbJIIltQrWe+X
	ecI7wnBGo0l2Fdkc0jn5+r6xbWG7suQ8S/Dt06dnSYWh4pdlWcF5yzmn6t6+7ECrJpbiEKansLk
	89FiRIv/LxWUKGExOn5ZwaAIyuIEaaA8DO9Iq78xuNoy8LdHOUTFlbEN+69ppFqrlHc8ajB652/
	mq0VhaFuM=
X-Google-Smtp-Source: AGHT+IG2lMzcFjc7REx0pi6nhktqcdfljQ9tGmdpXH2R81kak7XIbbuULliQHZiUSV0Oy/z29QS5Nw==
X-Received: by 2002:a05:6a00:9518:b0:782:ec0f:d273 with SMTP id d2e1a72fcca58-7a2208fe6bfmr25768343b3a.1.1761181228171;
        Wed, 22 Oct 2025 18:00:28 -0700 (PDT)
Received: from localhost ([2a03:2880:2ff:8::])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7a274bb3bdesm563096b3a.64.2025.10.22.18.00.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Oct 2025 18:00:27 -0700 (PDT)
From: Bobby Eshleman <bobbyeshleman@gmail.com>
Date: Wed, 22 Oct 2025 18:00:08 -0700
Subject: [PATCH net-next 04/12] selftests/vsock: avoid multi-VM pidfile
 collisions with QEMU
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251022-vsock-selftests-fixes-and-improvements-v1-4-edeb179d6463@meta.com>
References: <20251022-vsock-selftests-fixes-and-improvements-v1-0-edeb179d6463@meta.com>
In-Reply-To: <20251022-vsock-selftests-fixes-and-improvements-v1-0-edeb179d6463@meta.com>
To: Stefano Garzarella <sgarzare@redhat.com>, Shuah Khan <shuah@kernel.org>, 
 Bobby Eshleman <bobbyeshleman@gmail.com>, Jakub Kicinski <kuba@kernel.org>
Cc: virtualization@lists.linux.dev, netdev@vger.kernel.org, 
 linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Bobby Eshleman <bobbyeshleman@meta.com>
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

Signed-off-by: Bobby Eshleman <bobbyeshleman@meta.com>
---
 tools/testing/selftests/vsock/vmtest.sh | 53 +++++++++++++++++++--------------
 1 file changed, 30 insertions(+), 23 deletions(-)

diff --git a/tools/testing/selftests/vsock/vmtest.sh b/tools/testing/selftests/vsock/vmtest.sh
index 29b36b4d301d..9c72559aa894 100755
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
@@ -491,8 +497,6 @@ do
 done
 shift $((OPTIND-1))
 
-trap cleanup EXIT
-
 if [[ ${#} -eq 0 ]]; then
 	ARGS=("${TEST_NAMES[@]}")
 else
@@ -507,7 +511,8 @@ handle_build
 echo "1..${#ARGS[@]}"
 
 log_host "Booting up VM"
-vm_start
+pidfile="$(mktemp -u $PIDFILE_TEMPLATE)"
+vm_start "${pidfile}"
 vm_wait_for_ssh
 log_host "VM booted up"
 
@@ -531,6 +536,8 @@ for arg in "${ARGS[@]}"; do
 	cnt_total=$(( cnt_total + 1 ))
 done
 
+terminate_pidfiles "${pidfile}"
+
 echo "SUMMARY: PASS=${cnt_pass} SKIP=${cnt_skip} FAIL=${cnt_fail}"
 echo "Log: ${LOG}"
 

-- 
2.47.3

