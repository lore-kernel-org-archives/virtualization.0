Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 118EF2ECD3E
	for <virtualization@lists.linux.dev>; Fri,  7 Nov 2025 00:49:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762476598; cv=none; b=BuVv4c/sOhFJnjhdivyvyqIQ95DnxgNdVNLSFG8Rg3Y8AE/KujTf9gg3zdjxVfwFr0CWxSCD971ijlkZPf8wKy9k3L4uTL8u8t5E2z/zaQKw8+8JORUEaYSaRYUidyHy5osCz1AZKngg57afzbcgjf9zErApABFCN3C88aKnHyk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762476598; c=relaxed/simple;
	bh=1wmMbDkeZvwS5QPp81g31sRYXEDgsB4E7BdLRFqgg48=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=pW4mSH1ny6Y/ruKvfaoepI2m4+PwIrJnd7oVaogC/AS2ZGMhQfUWX7pkLpjU+cvS4JuBdifpTCSVDaVnSZx69bbfp98LJY9tSQly3cu2rGzV/DovsqPZrNNWnHZr6+5cKdqRQZuN4ugMYrz7U1AR1x8JRg+VDPyqHxU+8Opxb60=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Xt92ABoL; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Xt92ABoL"
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-292fd52d527so1868715ad.2
        for <virtualization@lists.linux.dev>; Thu, 06 Nov 2025 16:49:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762476595; x=1763081395; darn=lists.linux.dev;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=dJjKQe5/mXMKF0WVnYjVoyy86oXCt6LuarvonIeoQdI=;
        b=Xt92ABoLMYvtMqaMzk9In6eTfsLV0rkyYqPtQEC8GcnSLiFrb7GodiKh4E5Rwzg7O1
         mkHH/9zIO9K7wrfVpYJqKNV52xZ9R7AJ0ypCOlb5E/CtLDqyJUfn8ea0484wG89oFaGi
         dCc9kC0EU6up/SLAIJFfcEOXHhuw46axExti0z0WrLLOfK48zwk7Y7dhP98qC9BgnV1P
         LOS9Eu0xSWFGiSqF9UtjXAzlkYLQsgzyLBVvWhEfxwpTG/HDfBFEbhUofYFEsVQaFGOL
         O8Zg+bvnhFpukHAiBnkleayefniIMGO7NLpQ+upz5j8PLCVjfQp//7Y26CO6HE8awtRV
         QBwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762476595; x=1763081395;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=dJjKQe5/mXMKF0WVnYjVoyy86oXCt6LuarvonIeoQdI=;
        b=T+ua0i8e67xe87kmQf5Anfxs/tNM8ZFj7gs3c66blfCMoHoTg++X2zRVTSjClk+iFR
         h/ckkA+1uaXQPSTDtF4xQlUXMYCRXisLTiHgu3wm4X0kowi+xXx5op3qD74CHRkT55Bi
         tCr5RVKMHV2Bil3mCRABnthXt8GmnburynFJRdvCp8TLAxpUp3oWzim8ZbwZEAHVAOtr
         ZfnAX8/meDOynW7HxD79pYZ5Y/yALWiGtWPNpBmIBjM28f4eKMKTKCY5sOoogSZhqFNQ
         dLXgR5GAkG1siHN5dGiZGzLeM4E+UBxJ7sNQU3XKl5ktPFaj6IdzV66gClWA/G/Aki9i
         wPCQ==
X-Gm-Message-State: AOJu0Yx1CcXRcFHQx1XQxpyDnVjfWcjMY1JL+zI8gTqJm0Akp8RYOb5J
	q5opvWPoI2fTNZODtC4/YcgSHotriKuIV9185B75sdndfRB/1kQen904
X-Gm-Gg: ASbGncsQY9hUGekVpdt3YV51BkDPOpYUQ/vBaBtwgi+chO06yAJcvNb+Q2UtWbD2is9
	LeRF15LrAXnYBv8q5aMrKBoAogQM0UxRi3EDT79a+YSBbhSMcEVeT6ohH3lyXzpM7+JOHvNOc8O
	BXE9tP6zH2zyKJmtw6sLntNgWmXxwQAwnPfDC4txVjURuV2j7yaFz3X9b3x7dBJKFDplwe4X88x
	3mESEqrWUupfJagKj/tKjZMvJfDFqt5Ap5I1FizPtgtKdtiXyRk06FQBZ52JP3w0CHnre5yYJew
	Ey55jlXvSZj/eJCXj5jW9Y7RSLNK8qIrn6/m10Dg2IQoaGx3l9eMpBd/+QpR0PViT54Cdsdln+9
	BUTQkytSoGB80qa+M2zIJ0d4sCfLmKI2EL/iY2blFHpxaS8NUpG7tI0yQgrR94PhiB6ZnAdfcqQ
	==
X-Google-Smtp-Source: AGHT+IGi1k8J+USNG0iHJpgilsw9wrNeAWnolCrzF3sxEbAdWnQ7KZAJ70UKioRAg5vmvuxlz3eybg==
X-Received: by 2002:a17:902:dacf:b0:27e:ee83:fc80 with SMTP id d9443c01a7336-297c04aaa05mr16981245ad.57.1762476595330;
        Thu, 06 Nov 2025 16:49:55 -0800 (PST)
Received: from localhost ([2a03:2880:2ff:71::])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29651c8f2b3sm41613955ad.76.2025.11.06.16.49.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Nov 2025 16:49:54 -0800 (PST)
From: Bobby Eshleman <bobbyeshleman@gmail.com>
Date: Thu, 06 Nov 2025 16:49:48 -0800
Subject: [PATCH net-next v3 04/11] selftests/vsock: avoid multi-VM pidfile
 collisions with QEMU
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251106-vsock-selftests-fixes-and-improvements-v3-4-519372e8a07b@meta.com>
References: <20251106-vsock-selftests-fixes-and-improvements-v3-0-519372e8a07b@meta.com>
In-Reply-To: <20251106-vsock-selftests-fixes-and-improvements-v3-0-519372e8a07b@meta.com>
To: Stefano Garzarella <sgarzare@redhat.com>, Shuah Khan <shuah@kernel.org>
Cc: virtualization@lists.linux.dev, netdev@vger.kernel.org, 
 linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Bobby Eshleman <bobbyeshleman@meta.com>
X-Mailer: b4 0.14.3

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

Change QEMU_OPTS to be initialized inside the vm_start(). This allows
the generated pidfile to be passed to the string assignment, and
prepares for future vm-specific options as well (e.g., cid).

Signed-off-by: Bobby Eshleman <bobbyeshleman@meta.com>
---
Changes in v3:
- do not add unneeded -u to mktemp (Stefano)
- quote $PIDFILE_TEMPLATE (Stefano)
- do not remove cleanup(). Though it is expected that vm_start() does
  not exit(2) and its caller is responsible for pidfile cleanup,
  retaining cleanup() on EXIT is worth keeping as ill-timed kill signals
  (i.e., during manual runs) may leak those files.
- add create_pidfile() function to generate pidfile and automatically
  add it to array for cleanup() to terminate and remove later.

Changes in v2:
- mention QEMU_OPTS changes in commit message (Simon)
---
 tools/testing/selftests/vsock/vmtest.sh | 70 ++++++++++++++++++++++++---------
 1 file changed, 52 insertions(+), 18 deletions(-)

diff --git a/tools/testing/selftests/vsock/vmtest.sh b/tools/testing/selftests/vsock/vmtest.sh
index 01ac2b7ee8db..a461ef1fcc61 100755
--- a/tools/testing/selftests/vsock/vmtest.sh
+++ b/tools/testing/selftests/vsock/vmtest.sh
@@ -23,7 +23,8 @@ readonly VSOCK_CID=1234
 readonly WAIT_PERIOD=3
 readonly WAIT_PERIOD_MAX=60
 readonly WAIT_TOTAL=$(( WAIT_PERIOD * WAIT_PERIOD_MAX ))
-readonly QEMU_PIDFILE=$(mktemp /tmp/qemu_vsock_vmtest_XXXX.pid)
+readonly PIDFILE_TEMPLATE=/tmp/vsock_vmtest_XXXX.pid
+declare -a PIDFILES
 
 # virtme-ng offers a netdev for ssh when using "--ssh", but we also need a
 # control port forwarded for vsock_test.  Because virtme-ng doesn't support
@@ -33,12 +34,6 @@ readonly QEMU_PIDFILE=$(mktemp /tmp/qemu_vsock_vmtest_XXXX.pid)
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
@@ -90,15 +85,19 @@ vm_ssh() {
 }
 
 cleanup() {
-	if [[ -s "${QEMU_PIDFILE}" ]]; then
-		pkill -SIGTERM -F "${QEMU_PIDFILE}" > /dev/null 2>&1
-	fi
+	local pidfile
 
-	# If failure occurred during or before qemu start up, then we need
-	# to clean this up ourselves.
-	if [[ -e "${QEMU_PIDFILE}" ]]; then
-		rm "${QEMU_PIDFILE}"
-	fi
+	for pidfile in "${PIDFILES[@]}"; do
+		if [[ -s "${pidfile}" ]]; then
+			pkill -SIGTERM -F "${pidfile}" > /dev/null 2>&1
+		fi
+
+		# If failure occurred during or before qemu start up, then we need
+		# to clean this up ourselves.
+		if [[ -e "${pidfile}" ]]; then
+			rm "${pidfile}"
+		fi
+	done
 }
 
 check_args() {
@@ -188,10 +187,35 @@ handle_build() {
 	popd &>/dev/null
 }
 
+create_pidfile() {
+	local pidfile
+
+	pidfile=$(mktemp "${PIDFILE_TEMPLATE}")
+	PIDFILES+=("${pidfile}")
+
+	echo "${pidfile}"
+}
+
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
@@ -201,6 +225,13 @@ vm_start() {
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
@@ -209,14 +240,14 @@ vm_start() {
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
@@ -498,7 +529,8 @@ handle_build
 echo "1..${#ARGS[@]}"
 
 log_host "Booting up VM"
-vm_start
+pidfile="$(create_pidfile)"
+vm_start "${pidfile}"
 vm_wait_for_ssh
 log_host "VM booted up"
 
@@ -522,6 +554,8 @@ for arg in "${ARGS[@]}"; do
 	cnt_total=$(( cnt_total + 1 ))
 done
 
+terminate_pidfiles "${pidfile}"
+
 echo "SUMMARY: PASS=${cnt_pass} SKIP=${cnt_skip} FAIL=${cnt_fail}"
 echo "Log: ${LOG}"
 

-- 
2.47.3

