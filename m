Received: from mail-pj1-f50.google.com (mail-pj1-f50.google.com [209.85.216.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF96331D381
	for <virtualization@lists.linux.dev>; Thu, 27 Nov 2025 07:47:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764229677; cv=none; b=tfOYW2YAB+8DmxuFOtxFm4VEEclkq+YiODraDtclRuXGfkhHyKCKDunJfdjUlQftNu7oqYgiY7rQ+XfaBMIqCxdYG4fFyR7vDmcXxpJ6GV5w/md+YW0w64UL+mlLOQGgwEO4MCjfH07zZbh519Zi6W86jO1ibDnQnoWvgnL3ZiA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764229677; c=relaxed/simple;
	bh=VXSznUA/qrGw37DlDQ/ITpl+vbnJQhBZAvRQarakHeE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=huFAkGBHGXnuYj9YW/DwHKJXKXycmxRrpVjKpbHQ7WDnrV7hQLSf3i3fAcpSRKqbHdetPdR/P2igoxvy+dnHdA+iDWS4p+4JdzCUyS/DZhwmQkAu3X5gz4CIRLVToc7b7J/IMp5jHOHv+kMpR2wxkR8GBdUVp/k4+mqF5LA/9OM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Hf0CabmB; arc=none smtp.client-ip=209.85.216.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Hf0CabmB"
Received: by mail-pj1-f50.google.com with SMTP id 98e67ed59e1d1-34585428e33so628568a91.3
        for <virtualization@lists.linux.dev>; Wed, 26 Nov 2025 23:47:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1764229671; x=1764834471; darn=lists.linux.dev;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=81Yb0D7xNXy+MdzfxaynPdllQZqiJyMZrUjJeETwoWg=;
        b=Hf0CabmBK0t45R+gEYGd/v+pH5uxBUM6MqQ/uVxEF/7Ee3+XujPpJtpJPFzJvTvbf0
         wSVrrR19HwntDVWMDokWei/a8sluS7fQ97cE0B6u8o5MZsxKCV+du3L1ElOsjzhts6Zq
         WYjhMxyZ4vBl6ona8IsnExdbmCzqGI44wYd0viraqQYgHhYObmAbJwJ+MEM0wiTDrS7y
         KtUKc8FjeW3llxBHXTw6xbrA9G60NW7X3v5zWTFoKdK47X8dFVi4T49jdMlYdhTvSSN/
         S+KsMLpiibXQ9tvF9GjoqQFefA9EMfrmozq2z9U+zKI6jZER6Z/kkpNO3GtCw1i3Isu8
         kheQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764229671; x=1764834471;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=81Yb0D7xNXy+MdzfxaynPdllQZqiJyMZrUjJeETwoWg=;
        b=KJHCIglZw5Zher2FzeetE1zD7L4i9go90UphhDLIgLGcC5F1oL5D8RAIll4rJpcw7f
         xqmYYnl78a8Bh8y+NrBMjczxBgfD10JiUM67GlpRdBzrUw1BZDo36RsOavOc49tgOIyJ
         6/dCIZJF3NjuvTW06IwA2BvhuOat3SGnW7YCyuXRTM4oydPzyMxlRDJ2NxRqFAXmhS65
         AJxLITlmZJdsTeehuOy3Yt3EhxU0okZcVFtyWii67nld5BBGDGc0Fg9AMrrLAnySwRbN
         J2lIEZxVWGkCboil9tpwGNvdd2RjIZBbKji9iMTbrIy9NIT/hEV8ebN0M6dHIf7yXjQz
         MrTg==
X-Forwarded-Encrypted: i=1; AJvYcCUy0xyYinc9RNCuSM7h511TIJtLWlvfr0Lg0Mfbqtw/yhhJd1X8Q+taGln8Tr/njKocT8WNY67E+TcbA3WiIQ==@lists.linux.dev
X-Gm-Message-State: AOJu0YxRy1hoa1iox4SFNWAgZx/lndTkrVS4n7Cx+fXX1UaE6qV71ptO
	Hnn58yWaCuk4tRszuMUF3Nhu1gj4H6agcTeOOvxMNyV2QmQUk4mLGyTd
X-Gm-Gg: ASbGncu9J3XFLT9qu5o+mmO4B7RmJbPPVj7FWFfqbuujEXFmSvvw4r+vI1r2d2Oi6Vh
	qMHko7p51KypyC6UB9gaV6k+tbKxWhDtbW4X/Kqn011fQmVq/5QV3yDmwLqohubicxcsM49s/t1
	TDGmeDbpg+STI1XNEjPhBl4Seb1BJtW3xZOm1S8mx8X6rFbiGa7ydF0Dpl19sRuQ2pg3IFEfbBf
	EWIilP25NVwPkGgrLL7J2srQ+m0VglZsso7PKgzevO0mQP5D8/6YUpdzoBpD12T3Zyyemycircu
	NKKMiDDyg+NGk14ONcpnZvIAcxL1ERusHALauxaOYaCl8a8URCuvfoq6clZ/8Cw2fWcYiVzD+8C
	dk20ez79GllagRqBUIVqQ4bXthI8hS02xjK2hYsMIiaIYeqw3hrWd9/SqdvG0M/6hf5u51+qHZX
	Qlf2uztvOAtE/GEib8Gec=
X-Google-Smtp-Source: AGHT+IHm9n1hN/MXgqh8Fst0OOiMbfzgNDndic/dBuz4wSklQZaHZ2bC0MkEgH2q8ls+YwLmQfHTOg==
X-Received: by 2002:a17:90b:4c48:b0:32e:5d87:8abc with SMTP id 98e67ed59e1d1-34733f3f6d5mr19204188a91.36.1764229670667;
        Wed, 26 Nov 2025 23:47:50 -0800 (PST)
Received: from localhost ([2a03:2880:2ff:3::])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-be5095a0e65sm989665a12.27.2025.11.26.23.47.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Nov 2025 23:47:50 -0800 (PST)
From: Bobby Eshleman <bobbyeshleman@gmail.com>
Date: Wed, 26 Nov 2025 23:47:37 -0800
Subject: [PATCH net-next v12 08/12] selftests/vsock: use ss to wait for
 listeners instead of /proc/net
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251126-vsock-vmtest-v12-8-257ee21cd5de@meta.com>
References: <20251126-vsock-vmtest-v12-0-257ee21cd5de@meta.com>
In-Reply-To: <20251126-vsock-vmtest-v12-0-257ee21cd5de@meta.com>
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
 Shuah Khan <shuah@kernel.org>
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
index 1623e4da15e2..e32997db322d 100755
--- a/tools/testing/selftests/vsock/vmtest.sh
+++ b/tools/testing/selftests/vsock/vmtest.sh
@@ -191,7 +191,7 @@ check_args() {
 }
 
 check_deps() {
-	for dep in vng ${QEMU} busybox pkill ssh; do
+	for dep in vng ${QEMU} busybox pkill ssh ss; do
 		if [[ ! -x $(command -v "${dep}") ]]; then
 			echo -e "skip:    dependency ${dep} not found!\n"
 			exit "${KSFT_SKIP}"
@@ -346,21 +346,32 @@ wait_for_listener()
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
@@ -368,23 +379,25 @@ wait_for_listener()
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
@@ -431,7 +444,7 @@ vm_vsock_test() {
 			return $rc
 		fi
 
-		vm_wait_for_listener "${ns}" "${port}"
+		vm_wait_for_listener "${ns}" "${port}" "tcp"
 		rc=$?
 	fi
 	set +o pipefail
@@ -472,7 +485,7 @@ host_vsock_test() {
 			return $rc
 		fi
 
-		host_wait_for_listener "${ns}" "${port}"
+		host_wait_for_listener "${ns}" "${port}" "tcp"
 		rc=$?
 	fi
 	set +o pipefail

-- 
2.47.3

