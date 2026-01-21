Received: from mail-yx1-f45.google.com (mail-yx1-f45.google.com [74.125.224.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA27043DA3D
	for <virtualization@lists.linux.dev>; Wed, 21 Jan 2026 22:12:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769033534; cv=none; b=OBKnAco+fhi7PWoUIK/S4B9I4PwHitTKIEzzvqkaCX3bABDV4fXodWb5RScVEPQSNZU8JZPa/uuo/7YNHG0kRWDZXP7mBXw9YGya5cOG9a9Uuz/I/Lmk0LmnhnMY+CBS2qSaFbjmLe6zPv4UQPd2h5A/1+he3nYvDX4FLmmiaj4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769033534; c=relaxed/simple;
	bh=P4erHizl27nbkGk13UaQgtaMcmfPrCQL8OW5nr9GtQs=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=K+6GFVk3jTHu1ZI/N8c5jaxRRKKrOvJqejdJtVREENtTAUAozHWhQyONXNUvRcuSs1VqGF1P3fkJz8ZBh2ESQ5Jl9nsi+ZGwUvhiSVyucTNDpsmUq5uMnUuHxN7qeM/9QRkGHNxCMKOLkVmFMXh183HU0xR6tx1oJkvSO52KAxs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=A4ktN1nl; arc=none smtp.client-ip=74.125.224.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="A4ktN1nl"
Received: by mail-yx1-f45.google.com with SMTP id 956f58d0204a3-6467b7c3853so326982d50.0
        for <virtualization@lists.linux.dev>; Wed, 21 Jan 2026 14:12:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769033526; x=1769638326; darn=lists.linux.dev;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=pnWUXZAQs2u/RX1G1g/cLNdC4zcJTVF/JpiRxAH0cLc=;
        b=A4ktN1nlUMRpRY7QPLAPf/a6D+INxTEO/N7niQpLwn/raihFfucTt4Gdme6Qy1LmVG
         ML/MSRD59ZauORRpPNFvyXzOGUaaq/wOTriMIII7E9p6OJuqg2AnJGRK2WYdBSAnDSTj
         h8jKdoR6/zT4TznkXCpF7SKwkHTjLbZf/t5FZ4JxMREzWI04B9rBntRPvb02dGuUZ2S3
         z4kDl3oSUSpEdnrsUj8KJMJ5mK3SXOqTE51nrW9d14BaJQiuf/ld20srgrAIzguKH6oG
         1fQ46vEVsP4vNCfakJjYZpqfxT3/FTxWMdEnbLL94U06ZkZZfiBaIYShhnt1BR39ctPp
         EtLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769033526; x=1769638326;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=pnWUXZAQs2u/RX1G1g/cLNdC4zcJTVF/JpiRxAH0cLc=;
        b=f8MmC2StLP5/CXpTTGBXC74GGcJOs1Cqkggv0phtKxNYLXLMQ6pT1h8YYACQRZAw5s
         uRuflqPno8ILAgVIcIMvFd+B40s1kozX6mIkDUHISxovK3bjPRyUt8HpgFTzdbSx4/yy
         DOSsr6YTOceCVxv1vaVfuaGV4cfjFmeMU2aN1P0FNfBbsskee/FVEaMSUVR0IA8P0m96
         P8JDFvkifPHVzBJhaFf+VS769kYh/CVNMoNfCb+PEEAAIvJBmOT5cVDuArW1Pkrfedgj
         CX2xcsYriGEcLiTPHgC++FL/hvQzW6uwSdoOToS+6MVFZ03RsN0XFrnZmfNLCjDMluIJ
         LaGQ==
X-Forwarded-Encrypted: i=1; AJvYcCWQxFoBm7HujkleSL59R0mFZv/j0eg26O67VKX3xpMifPE/8//Vgn+ZiVABK7etUf2p67w+MPDKGbe3lhYgYw==@lists.linux.dev
X-Gm-Message-State: AOJu0YxhsEx/7DHHVl0IO9uxRkQueS0RALMOLZJxhmkNKr/Gnp5qw5Lr
	bFCTThvIY3O/tBZ6E1N+OxLKLW4MhttamqxiJk7LihmpqWRBK997yFsK
X-Gm-Gg: AZuq6aL8Lb6BC+puM1gz0SxUOqSxi6Cq2kevNISWye++S9zjqfZxHvYQr/KBYXsTA3q
	mELZZtsSZT9aKsl0ll/p+XwAegEXiEPrH/MY+3dL5vEG6jrGM4WRWtKEHwbquSP11Ln3flXIlDC
	Q/af+HcIb6toMNTjoNK0OZW+f3yp7yjhGTIT+VidaIK0q3VpRMZ0XFjUjgApznNXR/iMNQ3Xj5X
	yuh8CcfJH9zz9GETkY2JUXXYn9LtexZv8os0wBQ31gUXTw3ARwmaDPsMa4XC9e9MRGtUfoPnaoS
	fj0zUZZ5tia3OKK7c8zsb2Gp/WSSpe2kx46iEIICrVvVP45j+nnz60YtmPR8YLRPMX6DVhu77Fv
	VKtt06dMwINlueEkM4YmfHL0ucWBENioDFU7RYPpGhz3z7itJLqQIjIThsW8adahON6lFIkmONO
	2K77ddQyJL
X-Received: by 2002:a05:690e:b4d:b0:649:3f08:edc with SMTP id 956f58d0204a3-6493f080f88mr4683116d50.41.1769033526167;
        Wed, 21 Jan 2026 14:12:06 -0800 (PST)
Received: from localhost ([2a03:2880:25ff:d::])
        by smtp.gmail.com with ESMTPSA id 956f58d0204a3-649170acbdbsm8409641d50.13.2026.01.21.14.12.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Jan 2026 14:12:05 -0800 (PST)
From: Bobby Eshleman <bobbyeshleman@gmail.com>
Date: Wed, 21 Jan 2026 14:11:48 -0800
Subject: [PATCH net-next v16 08/12] selftests/vsock: use ss to wait for
 listeners instead of /proc/net
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260121-vsock-vmtest-v16-8-2859a7512097@meta.com>
References: <20260121-vsock-vmtest-v16-0-2859a7512097@meta.com>
In-Reply-To: <20260121-vsock-vmtest-v16-0-2859a7512097@meta.com>
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

Replace /proc/net parsing with ss(8) for detecting listening sockets in
wait_for_listener() functions and add support for TCP, VSOCK, and Unix
socket protocols.

The previous implementation parsed /proc/net/tcp using awk to detect
listening sockets, but this approach could not support vsock because
vsock does not export socket information to /proc/net/.

Instead, use ss so that we can detect listeners on tcp, vsock, and unix.

The protocol parameter is now required for all wait_for_listener family
functions (wait_for_listener, vm_wait_for_listener,
host_wait_for_listener) to explicitly specify which socket type to wait
for.

ss is added to the dependency check in check_deps().

Reviewed-by: Stefano Garzarella <sgarzare@redhat.com>
Signed-off-by: Bobby Eshleman <bobbyeshleman@meta.com>
---
 tools/testing/selftests/vsock/vmtest.sh | 47 +++++++++++++++++++++------------
 1 file changed, 30 insertions(+), 17 deletions(-)

diff --git a/tools/testing/selftests/vsock/vmtest.sh b/tools/testing/selftests/vsock/vmtest.sh
index 4b5929ffc9eb..0e681d4c3a15 100755
--- a/tools/testing/selftests/vsock/vmtest.sh
+++ b/tools/testing/selftests/vsock/vmtest.sh
@@ -182,7 +182,7 @@ check_args() {
 }
 
 check_deps() {
-	for dep in vng ${QEMU} busybox pkill ssh; do
+	for dep in vng ${QEMU} busybox pkill ssh ss; do
 		if [[ ! -x $(command -v "${dep}") ]]; then
 			echo -e "skip:    dependency ${dep} not found!\n"
 			exit "${KSFT_SKIP}"
@@ -337,21 +337,32 @@ wait_for_listener()
 	local port=$1
 	local interval=$2
 	local max_intervals=$3
-	local protocol=tcp
-	local pattern
+	local protocol=$4
 	local i
 
-	pattern=":$(printf "%04X" "${port}") "
-
-	# for tcp protocol additionally check the socket state
-	[ "${protocol}" = "tcp" ] && pattern="${pattern}0A"
-
 	for i in $(seq "${max_intervals}"); do
-		if awk -v pattern="${pattern}" \
-			'BEGIN {rc=1} $2" "$4 ~ pattern {rc=0} END {exit rc}' \
-			/proc/net/"${protocol}"*; then
+		case "${protocol}" in
+		tcp)
+			if ss --listening --tcp --numeric | grep -q ":${port} "; then
+				break
+			fi
+			;;
+		vsock)
+			if ss --listening --vsock --numeric | grep -q ":${port} "; then
+				break
+			fi
+			;;
+		unix)
+			# For unix sockets, port is actually the socket path
+			if ss --listening --unix | grep -q "${port}"; then
+				break
+			fi
+			;;
+		*)
+			echo "Unknown protocol: ${protocol}" >&2
 			break
-		fi
+			;;
+		esac
 		sleep "${interval}"
 	done
 }
@@ -359,23 +370,25 @@ wait_for_listener()
 vm_wait_for_listener() {
 	local ns=$1
 	local port=$2
+	local protocol=$3
 
 	vm_ssh "${ns}" <<EOF
 $(declare -f wait_for_listener)
-wait_for_listener ${port} ${WAIT_PERIOD} ${WAIT_PERIOD_MAX}
+wait_for_listener ${port} ${WAIT_PERIOD} ${WAIT_PERIOD_MAX} ${protocol}
 EOF
 }
 
 host_wait_for_listener() {
 	local ns=$1
 	local port=$2
+	local protocol=$3
 
 	if [[ "${ns}" == "init_ns" ]]; then
-		wait_for_listener "${port}" "${WAIT_PERIOD}" "${WAIT_PERIOD_MAX}"
+		wait_for_listener "${port}" "${WAIT_PERIOD}" "${WAIT_PERIOD_MAX}" "${protocol}"
 	else
 		ip netns exec "${ns}" bash <<-EOF
 			$(declare -f wait_for_listener)
-			wait_for_listener ${port} ${WAIT_PERIOD} ${WAIT_PERIOD_MAX}
+			wait_for_listener ${port} ${WAIT_PERIOD} ${WAIT_PERIOD_MAX} ${protocol}
 		EOF
 	fi
 }
@@ -422,7 +435,7 @@ vm_vsock_test() {
 			return $rc
 		fi
 
-		vm_wait_for_listener "${ns}" "${port}"
+		vm_wait_for_listener "${ns}" "${port}" "tcp"
 		rc=$?
 	fi
 	set +o pipefail
@@ -463,7 +476,7 @@ host_vsock_test() {
 			return $rc
 		fi
 
-		host_wait_for_listener "${ns}" "${port}"
+		host_wait_for_listener "${ns}" "${port}" "tcp"
 		rc=$?
 	fi
 	set +o pipefail

-- 
2.47.3

