Received: from mx0b-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0C992DE702
	for <virtualization@lists.linux.dev>; Tue,  6 Jan 2026 22:19:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.153.30
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767737987; cv=none; b=ZfljqLInAJYoJ50Z3G+fHnxUH5ILEL4Mogsf3OQ4pzt152weOoxLPDsaTZh6Kj0kKk1RwKdXhFC+iQWGzPV10HuGf1H/f1yMFb1MlKpa/EZjuZbKPbII0VXaUshcH8pbgVs35GEzL4/mT6t3On42q0T2M3AMM9zrrkLu5XsBfYs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767737987; c=relaxed/simple;
	bh=8oF583sCmzVigbrYeAFMBC5539k2OVgNRp3RC2aKUd4=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=IhdrdHOTAdtBgIv5LT52zb4LihaFfbulIWhIWrUkRor2Fm+I/aJYpsOV9AuLJ4hHci2mMVpodK1NvNelhqe5V3J5E7oKN52Qg34YO+8+fCeRc6CAR2GFN79Bq9QkGjX5SFO76xvoS86Ov3MjfEL7s4NsJH3rgGh8BZbOoKo2qUk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com; spf=pass smtp.mailfrom=meta.com; dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b=eWKPIPZF; arc=none smtp.client-ip=67.231.153.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=meta.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b="eWKPIPZF"
Received: from pps.filterd (m0148460.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 606LMT4t2015921;
	Tue, 6 Jan 2026 14:19:37 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=s2048-2025-q2;
	 bh=MNQwZZkKZQbflK6dA6wyx5Zt5X8Lh5WnfvNKOHgR3VI=; b=eWKPIPZFocov
	P2UT7pWPsat/cR8eTXnn7/2QDDDWmWXLuUGUt3xs9UqNSJrhQNiWAGWXDJOiJcYo
	b0TnVDTNYLXTaFxbLRZbyIVxECPfB7gVpLfsLwp35AkruYKOTbj2cSP4BdzKVEbr
	gIUUglP+pGpMkCehqtGAcWIUpHlAJnOuKBl62XWUhg4jAMKr6x7WOJDhvVbDrgPw
	JFDKQxfVxz0XTHSRxb/zCfdrCnMlyNkkVJIuJCrtx9Ju0UkQhUBQ+BTEdL/M+xao
	u3+vqZEBJbnWDqxy+Or4/5RqSbxi1ES8ie9lWoupR04PJCwklkdyRbjKGpbMJd82
	0L4T8bTgpg==
Received: from maileast.thefacebook.com ([163.114.135.16])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 4bh4v63pw8-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
	Tue, 06 Jan 2026 14:19:37 -0800 (PST)
Received: from localhost (2620:10d:c0a8:1b::8e35) by mail.thefacebook.com
 (2620:10d:c0a9:6f::237c) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.2.2562.29; Tue, 6 Jan
 2026 22:19:29 +0000
From: Vishwanath Seshagiri <vishs@meta.com>
To: "Michael S . Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>
CC: Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
        =?UTF-8?q?Eugenio=20P=C3=A9rez?=
	<eperezma@redhat.com>,
        Andrew Lunn <andrew+netdev@lunn.ch>,
        "David S .
 Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>, Jakub
 Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, David Wei
	<dw@davidwei.uk>,
        <netdev@vger.kernel.org>, <virtualization@lists.linux.dev>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH 2/2] selftests: virtio_net: add buffer circulation test
Date: Tue, 6 Jan 2026 14:19:24 -0800
Message-ID: <20260106221924.123856-3-vishs@meta.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260106221924.123856-1-vishs@meta.com>
References: <20260106221924.123856-1-vishs@meta.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTA2MDE5MyBTYWx0ZWRfX14rD0B4MHVra
 tYh1jJ3mpr/5HGiJETI9QJWH3H+of6tfvh9TIxvNVcxy8cj0/W0JnyY71zrBTKKOyJteo1ch8Qo
 0hktQd3OZzhIJyrWGZo/3Q8Ttgl8Jj0atv3IqCNmsaKZoxP6GwXMlu0DEh/igi64VwNiBKjwtAi
 /zrzZ5Gu7PWXBjzdO0C/UzY5cbyxjfESxs889DOx23xY/dnBPyG16KqgchsY7Jqt0eX8lQND6JS
 xWJn7vOigCyoN+u9FrYqSjrE9Pu8FJMVWaDIdcnrKZwR+mCKFIZi/zlrV3M7upCDtPT682ttgKh
 AFUl5T79B61K6cR9vBZ0UyaIkk/XkZqo5m9cA56JT3Yx27zLXql9E4wYuMkk331n4Csb6MhkzuA
 B8NgNtv+s3FD4GbRT3i5Sg+FQYplMVYkKpFJlxFRQFCP1CNTFH7aocOPgpFuJp54RRPcBzpR3wj
 gv6d9V6cIHxDXi7QgqQ==
X-Proofpoint-ORIG-GUID: t7wsrFEpDt0vdqOb7LS2endCp8XptD92
X-Authority-Analysis: v=2.4 cv=Zs/g6t7G c=1 sm=1 tr=0 ts=695d8a79 cx=c_pps
 a=MfjaFnPeirRr97d5FC5oHw==:117 a=MfjaFnPeirRr97d5FC5oHw==:17
 a=vUbySO9Y5rIA:10 a=VkNPw1HP01LnGYTKEx00:22 a=-RNOp1hDGyVVwNzvGBsA:9
X-Proofpoint-GUID: t7wsrFEpDt0vdqOb7LS2endCp8XptD92
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2026-01-06_02,2026-01-06_01,2025-10-01_01

Add iperf3-based test to verify RX buffer handling under load.
Optionally logs page_pool tracepoints when available.
---
 .../drivers/net/virtio_net/basic_features.sh  | 70 +++++++++++++++++++
 1 file changed, 70 insertions(+)

diff --git a/tools/testing/selftests/drivers/net/virtio_net/basic_features.sh b/tools/testing/selftests/drivers/net/virtio_net/basic_features.sh
index cf8cf816ed48..c2c8023d2b92 100755
--- a/tools/testing/selftests/drivers/net/virtio_net/basic_features.sh
+++ b/tools/testing/selftests/drivers/net/virtio_net/basic_features.sh
@@ -6,6 +6,7 @@
 ALL_TESTS="
 	initial_ping_test
 	f_mac_test
+	buffer_circulation_test
 "
 
 source virtio_net_common.sh
@@ -16,6 +17,8 @@ source "$lib_dir"/../../../net/forwarding/lib.sh
 h1=${NETIFS[p1]}
 h2=${NETIFS[p2]}
 
+require_command iperf3
+
 h1_create()
 {
 	simple_if_init $h1 $H1_IPV4/24 $H1_IPV6/64
@@ -83,6 +86,73 @@ f_mac_test()
 	log_test "$test_name"
 }
 
+buffer_circulation_test()
+{
+	RET=0
+	local test_name="buffer circulation"
+	local tracefs="/sys/kernel/tracing"
+
+	setup_cleanup
+	setup_prepare
+
+	ping -c 1 -I $h1 $H2_IPV4 >/dev/null
+	if [ $? -ne 0 ]; then
+		check_err 1 "Ping failed"
+		log_test "$test_name"
+		return
+	fi
+
+	local rx_start=$(cat /sys/class/net/$h2/statistics/rx_packets)
+	local tx_start=$(cat /sys/class/net/$h1/statistics/tx_packets)
+
+	if [ -d "$tracefs/events/page_pool" ]; then
+		echo > "$tracefs/trace"
+		echo 1 > "$tracefs/events/page_pool/enable"
+	fi
+
+	iperf3 -s --bind-dev $h2 -p 5201 &>/dev/null &
+	local server_pid=$!
+	sleep 1
+
+	if ! kill -0 $server_pid 2>/dev/null; then
+		if [ -d "$tracefs/events/page_pool" ]; then
+			echo 0 > "$tracefs/events/page_pool/enable"
+		fi
+		check_err 1 "iperf3 server died"
+		log_test "$test_name"
+		return
+	fi
+
+	iperf3 -c $H2_IPV4 --bind-dev $h1 -p 5201 -t 5 >/dev/null 2>&1
+	local iperf_ret=$?
+
+	kill $server_pid 2>/dev/null || true
+	wait $server_pid 2>/dev/null || true
+
+	if [ -d "$tracefs/events/page_pool" ]; then
+		echo 0 > "$tracefs/events/page_pool/enable"
+		local trace="$tracefs/trace"
+		local hold=$(grep -c "page_pool_state_hold" "$trace" 2>/dev/null)
+		local release=$(grep -c "page_pool_state_release" "$trace" 2>/dev/null)
+		log_info "page_pool events: hold=${hold:-0}, release=${release:-0}"
+	fi
+
+	local rx_end=$(cat /sys/class/net/$h2/statistics/rx_packets)
+	local tx_end=$(cat /sys/class/net/$h1/statistics/tx_packets)
+	local rx_delta=$((rx_end - rx_start))
+	local tx_delta=$((tx_end - tx_start))
+
+	log_info "Circulated TX:$tx_delta RX:$rx_delta"
+
+	if [ $iperf_ret -ne 0 ]; then
+		check_err 1 "iperf3 failed"
+	elif [ "$rx_delta" -lt 10000 ]; then
+		check_err 1 "Too few packets: $rx_delta"
+	fi
+
+	log_test "$test_name"
+}
+
 setup_prepare()
 {
 	virtio_device_rebind $h1
-- 
2.47.3

