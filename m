Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com [209.85.210.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BAD4A26ED3E
	for <virtualization@lists.linux.dev>; Wed, 24 Dec 2025 00:29:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766536150; cv=none; b=JP5R9HZ1m9SIfsWemdD3ei4VctPmCvVxw9NSw7TDv0ogh2xa0Zyfeq/EOme3whBVnJP3B+4wprMs4y6B1YuDAIQFay4RiDoZw01dlvVVQ+tlWWdHx7jKOOHoPgnA30gIUhoxiLUqWVLg/NQb7d+VPdxlpQmaUBK5maU3or2fy5w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766536150; c=relaxed/simple;
	bh=P4erHizl27nbkGk13UaQgtaMcmfPrCQL8OW5nr9GtQs=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=mV2uzEhpw1kiy9ZOTVf0hYETLTlhjczHocFs6NKeoxIMW/x7o1ZYHraH9kOEObMPfMKOJ2qkCKvnj32RmC8pzuniuprE3X8fqH9DBiDkdXhB1Tv/UPwN5gbmIzOqN2MucmrtJilyXwjH9WbBe1LtZPtbsujTJTSriatUzfof9MY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TmXbNEzh; arc=none smtp.client-ip=209.85.210.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TmXbNEzh"
Received: by mail-pf1-f169.google.com with SMTP id d2e1a72fcca58-7b89c1ce9easo6287560b3a.2
        for <virtualization@lists.linux.dev>; Tue, 23 Dec 2025 16:29:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1766536145; x=1767140945; darn=lists.linux.dev;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=pnWUXZAQs2u/RX1G1g/cLNdC4zcJTVF/JpiRxAH0cLc=;
        b=TmXbNEzhWDRc5SbSTIhoGzkeluOKmg6OytVkBWmnz4eoHMa93eJWBSkOvGBAxhxqss
         NDL17hTdM8LCkSxKCVRlwmWJufRK8IKOB5Ky023i+jRJFq6ZOy5TngPM0XKmVMc3OVMf
         MHnfjX3jt+0ARBBorGi3i7qaxG3MX1a2W/WxZdUBKA5kIzAywtqOBfzAzmT0asoHeA29
         LkraStAWC4B/Lbt5bJgzMWdqEKUIMQLLbReHAU3RPL6ZzrB+TFMsP4ZveMW25RV5ZDt7
         qAmti9po/4ZiHb3zYykq6ovEBRKcRX4USpwDxUTXioD7KyqbSSgS46mZPPr5hT1nGbDy
         Ozag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766536145; x=1767140945;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=pnWUXZAQs2u/RX1G1g/cLNdC4zcJTVF/JpiRxAH0cLc=;
        b=bgoiitJFmlcZJ4p7o5m1ZqimtXQCY3qt/ONnav1VhpUuWxdINOdQYNw1jzNbiaAnAK
         3iE/Gkl2/fVjJE/QCUfe1SamCeRGtac7xchPFuCHJadXM10SaDNuupH5+X6W1ARR6hTD
         qkmFhAH+z66TQqPc4UQfxgYdIvWGyZe6JJ9go3wKoBM9rPhXOQh8F+oXEfp3/rK7Zs+G
         h5guPFLJb9y2xrCNssq8+yVKU2WMsUPUdT9LMd184dij5gzx6O0sI0H4gSz6SpszrkGR
         R2Aj7oJVyfSOWpcusUzCSN2sF9V4wLoLUcGuCj3fsjanG0DXj7NwqI8F5gzpbGBvjc/n
         nhtQ==
X-Forwarded-Encrypted: i=1; AJvYcCXU1YBi7mhCP6uXFs2Id1A4brZJqx48+AtruyQ+z6vMSQqXypj48MeyBGm51syztgh13C4ycjNewQqg72UuJA==@lists.linux.dev
X-Gm-Message-State: AOJu0YxTr3xBNxcEQ4EchKV3/eeavMAfHRZFCnMZ8fgpFsItJh2BrdnN
	l3RKfOwTNIdIQ4WlR4ggbi2dT5qrxBnIPYIUyCx7rwuJoCK1Z/3Rmw2k
X-Gm-Gg: AY/fxX57Mf7VqW/gzwPjkRr68CgKSLX8NIj2pHbpplvYihd931v0+YCDoz/CdVI4Snm
	hgcryyL06whKcNsKYyxFLWhMARSfpBaNMZJbEb8u83+j4/AGbuuUWvMM8UwiA/+CXNXQHKfa3B2
	GRAAFe6qah6tazaSS6uqgblhm3YMDXtQ1afMTPAjt5woT3DSrMGA2tiEV6byAhHglDhL278uvJn
	2rICal1ttbqPus9881lbhH0KfdT4Lr7eKpAVmPi+1sJy+/sCIUoL7fpDHNZ3jBfcQ1YjGO1PEdH
	H9GRf93z2GHuMzrhcghf4U9n5tn3nAAttgviImLL2faLxKf9FSHoxR2BjaR3bWJ9bA+L60KtnyQ
	0+pPICLJ6TPx0DZQFu6ntpJZsKebVra1vZHcnZnCDGsrvZ4M9EBX/kB9SjfND/BvlSBD9HWWkHY
	CH/Zgx72f4RtZUfup5e9c=
X-Google-Smtp-Source: AGHT+IG9bM40+23m7ksLXlbMaHJ4J5fajkInG27QTdkeyL6rIcjmRvm7kMrKaaEMk9caXe/lgKe2eQ==
X-Received: by 2002:a05:6a00:6ca2:b0:7a9:c738:5e88 with SMTP id d2e1a72fcca58-7ff657a1298mr13744515b3a.8.1766536145181;
        Tue, 23 Dec 2025 16:29:05 -0800 (PST)
Received: from localhost ([2a03:2880:2ff:7::])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7ff7b423d86sm14802196b3a.26.2025.12.23.16.29.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Dec 2025 16:29:04 -0800 (PST)
From: Bobby Eshleman <bobbyeshleman@gmail.com>
Date: Tue, 23 Dec 2025 16:28:43 -0800
Subject: [PATCH RFC net-next v13 09/13] selftests/vsock: use ss to wait for
 listeners instead of /proc/net
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251223-vsock-vmtest-v13-9-9d6db8e7c80b@meta.com>
References: <20251223-vsock-vmtest-v13-0-9d6db8e7c80b@meta.com>
In-Reply-To: <20251223-vsock-vmtest-v13-0-9d6db8e7c80b@meta.com>
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

