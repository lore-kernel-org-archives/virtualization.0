Received: from mail-yw1-f169.google.com (mail-yw1-f169.google.com [209.85.128.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9AE3031327A
	for <virtualization@lists.linux.dev>; Fri, 16 Jan 2026 21:29:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768598954; cv=none; b=JSte7hUof9IOv9xTbMM4U/JXy0nDJqbxP+OjFL05DYWjzS+kqiuv/qHV5oSSZenRhtFqYDZs+BeC1FGMYUg8Ctyi1emwrrDpq3ZIWT1Lb5UgLOUPjv83GckiNTdi1kjfvyN9g6T6aaQJhxe01l0hO51tMM36yYw3L2zn7bkRGwE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768598954; c=relaxed/simple;
	bh=P4erHizl27nbkGk13UaQgtaMcmfPrCQL8OW5nr9GtQs=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=h4oatbLRq1n5BAoVyZSiaTmnVaMWz01MxT0+n2Sv10xB27oi8XtwS3WCXF+hBcEDO2kqkf/p5c5jaBf3kgGF1jTt4uJSDsUDccWAPAXH7oPHCrpzD5CR7UANpWq+OvIPBctn8HWxqAyydWi594CU00/gSDFsSBS7Ul4PAaHkNiE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=meZNXNs7; arc=none smtp.client-ip=209.85.128.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="meZNXNs7"
Received: by mail-yw1-f169.google.com with SMTP id 00721157ae682-78fba1a1b1eso40461037b3.1
        for <virtualization@lists.linux.dev>; Fri, 16 Jan 2026 13:29:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768598950; x=1769203750; darn=lists.linux.dev;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=pnWUXZAQs2u/RX1G1g/cLNdC4zcJTVF/JpiRxAH0cLc=;
        b=meZNXNs7KRbBKVUX1CS2/Xp+yGAxZLxuh9WmXkRZYrScS5TItajCYaMT1jwT5Adw7J
         HQEqM+bX8f2pmRLqr/GWlPKxzKkaVLmLREGeRMHIBcg6L4v4h0zyv2zOwTwChyLF5RCY
         7nI0jxgqEFl17wVqMRC/IYHXDx/9ZjxpxCrtet1TSYPjQUpI1i4yxMWKq8rO8ZoWsv93
         vZipVSWpmQIq2jQwMcK9D+uWn1NnOzxbsW+5hWmYmiw55ItwFvxJDgPkEYeEpAftRoXL
         x3emX7OLU2mZvIpnT8SlDDiK1a2zJOMRNSz/d6PvlUYmOxSk801JXa3AL68g+gNbB8Ev
         m7kQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768598950; x=1769203750;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=pnWUXZAQs2u/RX1G1g/cLNdC4zcJTVF/JpiRxAH0cLc=;
        b=a9EU+OoP7Yy5klnCbmBWzJRPbHcUGd5IzQRUKUTBjCAlVqZRUEh4a/frSeyzKVNXdW
         6Gif0YX86Bt4p8dNHe5KZBeJ4SnbNKTs7gKjgvJplO+QLgrFbuz3TIDkgfwComx+t1db
         hq/cEoSQkXDXsTAyYpYNhkTjm0ia6ASXFuJzOp8b5l3yHxcMRhMVqowIsKVegXuEHYJV
         kwVpudQLQh+lFWkO3FHQa0WANAwgNsZqKBq7RyRs8jJIwJMcFx5VcpWrpP4AbMbd1552
         6FuU+ZdfdujwqJNGdTR/xHfWAYUpgAI8cUeYJCzzb1VRQSPixI5z3hXdToB4CFK+fYar
         DJUA==
X-Forwarded-Encrypted: i=1; AJvYcCUqeoBrJqs8mEhw/jKyhGrdA4i2VrHrFkUzBPc10t60XpvbmnuYlHb/k0HzafQXbRDZxGDsUmCP1o02ZEsTVw==@lists.linux.dev
X-Gm-Message-State: AOJu0Yw1VlyRLDpBfnVn0v6mbB5FTpWCUj8Tcm43tthhDSKBRDy3gKxR
	F14NX3E/GfbHqpj7XoLS0++Rt4tXw+BllvGx09+k8WS2mvG4Okhtk8rgtYfrOA==
X-Gm-Gg: AY/fxX4kdAMziiPJM5TydNiWVaSZCltdOgE+meRjmtKBgIH+VVGdm00ZyxZQKZtFn9n
	pQ7utdke92d3BkMG9kM3PGAXsalsuBzz8rXBo2jAkTCsPKGsxBydrA8zfsfbE/BXqukyv9cBRUf
	U3qqurjaXTcv2Ir28+Vb4451GVUvTQnoFQk+RQD8/n1diXKsMdQb2Gcd9l5GuJQJ+LE+k91k9tg
	0gkMFak9bIzwOoEFFOIr2nfInpg0NmRGepNeehmfpRSH1PaD96bERQaX5U4TNFxLNRYpMzJHbQC
	752FW9lL8B8NkCQgc/2tEG8J1+vtVg7/j276dZVQm+O/UEOb7VChG1REC13KLqUpeeSlxiBqXUT
	8i4HRVNMltyjNmCtIfI7zA6+E5rcO4n122j9koH33ff5GxOo1V8W3gtqDkvq/wvmD1mhHhfCxcz
	bi5l/Boki3
X-Received: by 2002:a05:690c:dd4:b0:793:baf5:ffcc with SMTP id 00721157ae682-793c57be153mr40080797b3.2.1768598949786;
        Fri, 16 Jan 2026 13:29:09 -0800 (PST)
Received: from localhost ([2a03:2880:25ff:6::])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-793c66f6f97sm13467037b3.16.2026.01.16.13.29.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Jan 2026 13:29:09 -0800 (PST)
From: Bobby Eshleman <bobbyeshleman@gmail.com>
Date: Fri, 16 Jan 2026 13:28:48 -0800
Subject: [PATCH net-next v15 08/12] selftests/vsock: use ss to wait for
 listeners instead of /proc/net
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260116-vsock-vmtest-v15-8-bbfd1a668548@meta.com>
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

