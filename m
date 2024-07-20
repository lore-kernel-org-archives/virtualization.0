Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78082DDB2
	for <virtualization@lists.linux-foundation.org>; Sat, 20 Jul 2024 20:11:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.136
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721506276; cv=none; b=r58rCCATe2fd73UUpGzSgeSkqIjaQpQZrzOOkzTejcvid7UlOsZTh69YX6+r7xI4EvDskyHR6kLHuARdq0Eq70UKNjfvq8rrUlQN/PcFkzPixPxgP9ON6qvmZStFawcN0Nxjn8f2Y26X9zqMFyVSTBpl7KuT9NC90Kp/T58E1I4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721506276; c=relaxed/simple;
	bh=MMccahpFs/BX2/ZmF+Ahe+wf3beg9doy+mIncCTABp4=;
	h=Message-ID:Date:MIME-Version:In-Reply-To:To:CC:From:Subject:
	 Content-Type; b=Jl4vivvkzbbOHej6+lRQFXP4GCiqDtEpniqSQjm6JlrIuGZxLQufyfGqLa1Kvb8qPt4Ztr5NEJGm/U8OPJjVoDShKqVPcmsv/YrDefZwxqnHkGo0QR2LPSPj9e3/WUehkoFF7bvKnbczh+oGHPuuKfPpt2NfLYgHFZj/BXImf7I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=salutedevices.com header.i=@salutedevices.com header.b=XOBw0mCr; arc=none smtp.client-ip=140.211.166.136
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=salutedevices.com header.i=@salutedevices.com header.b="XOBw0mCr"
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id C0B9160731
	for <virtualization@lists.linux-foundation.org>; Sat, 20 Jul 2024 20:11:12 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -2.102
X-Spam-Level:
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id lpC46NIuFGPE for <virtualization@lists.linux-foundation.org>;
 Sat, 20 Jul 2024 20:11:11 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=45.89.224.132; helo=mx1.sberdevices.ru; envelope-from=avkrasnov@salutedevices.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp3.osuosl.org DB3DC6068A
Authentication-Results: smtp3.osuosl.org; dmarc=pass (p=none dis=none) header.from=salutedevices.com
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org DB3DC6068A
Authentication-Results: smtp3.osuosl.org;
	dkim=pass (2048-bit key, unprotected) header.d=salutedevices.com header.i=@salutedevices.com header.a=rsa-sha256 header.s=mail header.b=XOBw0mCr
Received: from mx1.sberdevices.ru (mx2.sberdevices.ru [45.89.224.132])
	by smtp3.osuosl.org (Postfix) with ESMTPS id DB3DC6068A
	for <virtualization@lists.linux-foundation.org>; Sat, 20 Jul 2024 20:11:07 +0000 (UTC)
Received: from p-infra-ksmg-sc-msk02.sberdevices.ru (localhost [127.0.0.1])
	by mx1.sberdevices.ru (Postfix) with ESMTP id 6F39C120003;
	Sat, 20 Jul 2024 23:11:03 +0300 (MSK)
DKIM-Filter: OpenDKIM Filter v2.11.0 mx1.sberdevices.ru 6F39C120003
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=salutedevices.com;
	s=mail; t=1721506263;
	bh=US63tdy4CVQs+687WGqzILjkxPtutPxeQcKuCPb5QWE=;
	h=Message-ID:Date:MIME-Version:To:From:Subject:Content-Type:From;
	b=XOBw0mCrV7p9Zi+pEfyVJhDbFSCAllSki3+OQFo1UD8PDCgyWMKGxd82B8vppA3By
	 3n04+nn1OmyrqRAxCEI/6iHHe/2yce0wlqwh+WC8O42G2/5tf9KVh0/3wtQy2RN3oI
	 UqLkWj/JtfahxoHKnBMXgqxOhjhxxRLLupCSrR0JLTqfJWc07CtWM1elgsrynBS9tq
	 gfxgjCNrA2HmbRQ218tRvyitPcQW5smW963cWZkKIpjA4DrP7+FuUgLJlvt2JQvsdg
	 Fn70wFoJcG+kvUnqbTPdgq+rJjNl9rpYBlpD5ID80vSYAHzDAn3bJlnM3llh1aApV7
	 Yl8MidrEAKk1A==
Received: from smtp.sberdevices.ru (p-i-exch-sc-m02.sberdevices.ru [172.16.192.103])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.sberdevices.ru (Postfix) with ESMTPS;
	Sat, 20 Jul 2024 23:11:03 +0300 (MSK)
Received: from [172.28.192.160] (100.64.160.123) by
 p-i-exch-sc-m02.sberdevices.ru (172.16.192.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Sat, 20 Jul 2024 23:11:01 +0300
Message-ID: <8e3071f2-682c-7f0d-ff10-2865d7c2d8d4@salutedevices.com>
Date: Sat, 20 Jul 2024 22:58:40 +0300
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Content-Language: en-US
In-Reply-To: <20240710212555.1617795-15-amery.hung@bytedance.com>
To: <stefanha@redhat.com>, <sgarzare@redhat.com>, <mst@redhat.com>,
	<jasowang@redhat.com>, <xuanzhuo@linux.alibaba.com>, <davem@davemloft.net>,
	<edumazet@google.com>, <kuba@kernel.org>, <pabeni@redhat.com>,
	<kys@microsoft.com>, <haiyangz@microsoft.com>, <wei.liu@kernel.org>,
	<decui@microsoft.com>, <bryantan@vmware.com>, <vdasa@vmware.com>,
	<pv-drivers@vmware.com>
CC: <dan.carpenter@linaro.org>, <simon.horman@corigine.com>,
	<oxffffaa@gmail.com>, <kvm@vger.kernel.org>,
	<virtualization@lists.linux-foundation.org>, <netdev@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <linux-hyperv@vger.kernel.org>,
	<bpf@vger.kernel.org>, <bobby.eshleman@bytedance.com>,
	<jiang.wang@bytedance.com>, <amery.hung@bytedance.com>,
	<ameryhung@gmail.com>, <xiyou.wangcong@gmail.com>
From: Arseniy Krasnov <avkrasnov@salutedevices.com>
Subject: Re: [RFC PATCH net-next v6 14/14] test/vsock: add vsock dgram tests
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: p-i-exch-sc-m02.sberdevices.ru (172.16.192.103) To
 p-i-exch-sc-m02.sberdevices.ru (172.16.192.103)
X-KSMG-Rule-ID: 10
X-KSMG-Message-Action: clean
X-KSMG-AntiSpam-Lua-Profiles: 186631 [Jul 20 2024]
X-KSMG-AntiSpam-Version: 6.1.0.4
X-KSMG-AntiSpam-Envelope-From: avkrasnov@salutedevices.com
X-KSMG-AntiSpam-Rate: 0
X-KSMG-AntiSpam-Status: not_detected
X-KSMG-AntiSpam-Method: none
X-KSMG-AntiSpam-Auth: dkim=none
X-KSMG-AntiSpam-Info: LuaCore: 24 0.3.24 186c4d603b899ccfd4883d230c53f273b80e467f, {Tracking_from_domain_doesnt_match_to}, 100.64.160.123:7.1.2;d41d8cd98f00b204e9800998ecf8427e.com:7.1.1;salutedevices.com:7.1.1;smtp.sberdevices.ru:5.0.1,7.1.1;127.0.0.199:7.1.2, FromAlignment: s, ApMailHostAddress: 100.64.160.123
X-MS-Exchange-Organization-SCL: -1
X-KSMG-AntiSpam-Interceptor-Info: scan successful
X-KSMG-AntiPhishing: Clean
X-KSMG-LinksScanning: Clean
X-KSMG-AntiVirus: Kaspersky Secure Mail Gateway, version 2.0.1.6960, bases: 2024/07/20 18:23:00 #26109921
X-KSMG-AntiVirus-Status: Clean, skipped

+static void test_dgram_sendto_client(const struct test_opts *opts)
+{
+	union {
+		struct sockaddr sa;
+		struct sockaddr_vm svm;
+	} addr = {
+		.svm = {
+			.svm_family = AF_VSOCK,
+			.svm_port = 1234,

^^^
port is not hardcoded, it is 'opts->peer_port'

+			.svm_cid = opts->peer_cid,
+		},
+	};
+	int fd;

Thanks, Arseniy
