Received: from mail-pf1-f175.google.com (mail-pf1-f175.google.com [209.85.210.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E50D2E7659
	for <virtualization@lists.linux.dev>; Tue, 21 Oct 2025 23:47:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761090437; cv=none; b=TzpH8qUYUn9FWY6DfkHu+OoLG4wT7caQFVRWY9cWFWMHsZUsHpHHjKsIce+LtsSbfEq71HzUviBty0miUUg++NizzEWeh0Gy0jcGJpzAvWBf953n/N5sYsvV6iuXaFndsuEJaFcGVcnj7L65/a8h9eO+2nJHfS6oEwc8+91f/RY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761090437; c=relaxed/simple;
	bh=1TJpetkZxtBQiB7nUe4Rc6HDEslWsfWsLeGiK/zQyW0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=pufy7aY2XPwIsT2oXiYqeguw0wDu/M0Y4WXJTW/5dlDbI++2njyXvNt2EosftvGi5uMLSF62apN5LY/9x+mO9HqIOcThYZW9vtqSIU+nOd+YKKxVdQRLVomdklCtU8gHvqHYgRV95C/Btz5mRJAbNy8rqndQ1zx2ZGlwXK5c+Kc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SUm9HVzW; arc=none smtp.client-ip=209.85.210.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SUm9HVzW"
Received: by mail-pf1-f175.google.com with SMTP id d2e1a72fcca58-781010ff051so4625450b3a.0
        for <virtualization@lists.linux.dev>; Tue, 21 Oct 2025 16:47:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761090429; x=1761695229; darn=lists.linux.dev;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=bp4Nw6yXc3Wo3rOJsEv9cE/uO6VvL+09gH92ff2ezzc=;
        b=SUm9HVzWyKb6pc1Yty5RgPrfVuvfllIQ2bVTnFnGh15euhSi9V+cCsC1p0JmVEUQ7E
         rKfoGc8fp3aC5SNTF5V5G5zFecA+aAVHEcJZHoNPLRKw+dwFDXSpf16LxZiwUMyRrYB6
         JptqCxTijn5xXDT2GLxzt35lerearffPzMiM7GgHieIESQyy7VeapAsu1zMQ0GCIuHZ6
         rr+cY3xmWPnRWAj3pE8+J5w7kRC5+ZcGhP4ES/IIDZxWjQXGJjz89kN1kJ5aXj+A5xgA
         SwzwqvAPVJ3yQOHS/vgUXtHPZiVMPEhNHbyiOY33Nzu8D8lH4lImK/aRoqnqlgodEl+R
         lqXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761090429; x=1761695229;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bp4Nw6yXc3Wo3rOJsEv9cE/uO6VvL+09gH92ff2ezzc=;
        b=hhlpb/JygegsfZz4yPEgHxSb7tWsbBfgqOrzN0WxLQwrDhVikmLs9FDbyb8/TwXoE2
         RLwJ5ZPd3WRNKbVDqIEX/FP3g10e2VALKOnytwERwzK8a6C5RydFQUdyjMrHJipugh/w
         uGbfM8+b5Wgi9EpmUagaUJP3+YShzEZGiFtzyYF/QHHgMWzzMq0AqCjGcQBU8V2t77cZ
         fuyP3Flnz4YE7nerx/OWt9a76f1/RlZ+EeiOuRb661ASp1jBr2BSeNBw+spLMBnYaz0E
         AEvc+xDATJ++l0h7bvSkyZJ/iL8pvdQUQGMY3TdIFIehwNutp8ywgyOmdsNku3fwID7k
         66PQ==
X-Gm-Message-State: AOJu0YxeV+4csDhqUPVPBKD0uxMpeCPeBwaPizMpu37EmyfpvLo4Dly4
	hQCZqh4C2gLv7wCMT40p52wJLsGy1a/9eL+VjUcpCu4njzc37zaadQA1
X-Gm-Gg: ASbGnctYj3KMSD3KjGwGfyobWyJ1cqtmh0JO3gEzIEPPPZ8BBG/jtrmbCbwgfF4vcvY
	QC83wskk6/t22JG+W2zUvlJb9bZQ4pG263Jmzhd6QeE2mW+UKsZYwlaJMhWTBUKTDFxEzBQzCML
	CQS6Pv98uCZrfVTqqSkvnRNpB3F/gn9KoFO/TqAZWDAfdYTNxTqR9mPNxMwIhu+hX09SuxRpYwz
	w2uNoWYa13lxI/ItBuu56mcVOmqBsUMwq0n+ilmgVqwrLOTibm6tVhAJdFqIk2+7Vd7NKaMb9/C
	cdq+V9mAO9iWIMo5+nhHl9TzLQbY5y3EuDk+SLrGNgFdc9LPPhkl7QBNEtMRVFjRduI91vZ5LtV
	dKN1Xv9uUZrTnkT1VBQqFeiwbY34yhZs1iDwqaf+VI1W00W80fhGCw261Bg+wzpm9Zte5rF/zhc
	b40nHSnw8=
X-Google-Smtp-Source: AGHT+IFtE7kUaxGGBCIPvCA5xq+X+CjTxjkLXDamZJvTdeDWKXgLXL+jJ+B0+JzhKzpp/1MhbmJcug==
X-Received: by 2002:a05:6a21:7e8a:b0:338:614f:aac4 with SMTP id adf61e73a8af0-338614fab5amr6788012637.29.1761090429512;
        Tue, 21 Oct 2025 16:47:09 -0700 (PDT)
Received: from localhost ([2a03:2880:2ff:5::])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7a25f41ad15sm2272286b3a.41.2025.10.21.16.47.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Oct 2025 16:47:09 -0700 (PDT)
From: Bobby Eshleman <bobbyeshleman@gmail.com>
Date: Tue, 21 Oct 2025 16:46:54 -0700
Subject: [PATCH net-next v7 11/26] selftests/vsock: avoid multi-VM pidfile
 collisions with QEMU
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251021-vsock-vmtest-v7-11-0661b7b6f081@meta.com>
References: <20251021-vsock-vmtest-v7-0-0661b7b6f081@meta.com>
In-Reply-To: <20251021-vsock-vmtest-v7-0-0661b7b6f081@meta.com>
To: Stefano Garzarella <sgarzare@redhat.com>, Shuah Khan <shuah@kernel.org>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Simon Horman <horms@kernel.org>, Stefan Hajnoczi <stefanha@redhat.com>, 
 "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>, 
 Xuan Zhuo <xuanzhuo@linux.alibaba.com>, 
 =?utf-8?q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>, 
 "K. Y. Srinivasan" <kys@microsoft.com>, 
 Haiyang Zhang <haiyangz@microsoft.com>, Wei Liu <wei.liu@kernel.org>, 
 Dexuan Cui <decui@microsoft.com>, Bryan Tan <bryan-bt.tan@broadcom.com>, 
 Vishnu Dasa <vishnu.dasa@broadcom.com>, 
 Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>, 
 Bobby Eshleman <bobbyeshleman@gmail.com>
Cc: virtualization@lists.linux.dev, netdev@vger.kernel.org, 
 linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org, 
 kvm@vger.kernel.org, linux-hyperv@vger.kernel.org, berrange@redhat.com, 
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
 tools/testing/selftests/vsock/vmtest.sh | 51 +++++++++++++++++++--------------
 1 file changed, 30 insertions(+), 21 deletions(-)

diff --git a/tools/testing/selftests/vsock/vmtest.sh b/tools/testing/selftests/vsock/vmtest.sh
index 29b36b4d301d..9958b3250520 100755
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
@@ -507,7 +513,8 @@ handle_build
 echo "1..${#ARGS[@]}"
 
 log_host "Booting up VM"
-vm_start
+pidfile="$(mktemp -u $PIDFILE_TEMPLATE)"
+vm_start "${pidfile}"
 vm_wait_for_ssh
 log_host "VM booted up"
 
@@ -531,6 +538,8 @@ for arg in "${ARGS[@]}"; do
 	cnt_total=$(( cnt_total + 1 ))
 done
 
+terminate_pidfiles "${pidfile}"
+
 echo "SUMMARY: PASS=${cnt_pass} SKIP=${cnt_skip} FAIL=${cnt_fail}"
 echo "Log: ${LOG}"
 

-- 
2.47.3

