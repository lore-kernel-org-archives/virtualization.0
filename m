Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A4DA132C13
	for <virtualization@lists.linux-foundation.org>; Wed, 24 Jan 2024 19:42:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706125327; cv=none; b=izM+/IePPd9vajNm1VOlA2Hn2/R9CPBbMQ6jZOQ1euSdCVNp0hgbUze2gneADnHP0TILL3YI93dCiZ0YkKywAHUEnC7on3eVJSIjiogkuvPSlp62+flmYTFw8Je+e6nQe6RH6bkJ21hSCrozrexbdfTOKfUt0v25EYjjNzmk4GU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706125327; c=relaxed/simple;
	bh=DfiiVQZmjrPJ8btA/mdv8DkKXsGYk1q1vtKQzoxgcHc=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=aEgOvS/7vd/74q7Pai4SXcz4BRvpz1zBeVVHB4F7pKn1OWiCDFOzBw+zRshVxin887UFA1bOc/hmAIGlHT+v4/tIRY3AxVjO47F9c/XwTQEa0I++QO7CDEJtVguLfD0S2JLfWPbd8eHVgAkDvvxYIo97MwP1vPcHo6ErpvIAFI8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=salutedevices.com header.i=@salutedevices.com header.b=ds9HQUO5; arc=none smtp.client-ip=140.211.166.133
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=salutedevices.com header.i=@salutedevices.com header.b="ds9HQUO5"
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 0658340298
	for <virtualization@lists.linux-foundation.org>; Wed, 24 Jan 2024 19:42:04 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 0658340298
Authentication-Results: smtp2.osuosl.org;
	dkim=pass (2048-bit key) header.d=salutedevices.com header.i=@salutedevices.com header.a=rsa-sha256 header.s=mail header.b=ds9HQUO5
X-Virus-Scanned: amavisd-new at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -2.1
X-Spam-Level:
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id kGczhNBiDyeM
	for <virtualization@lists.linux-foundation.org>;
	Wed, 24 Jan 2024 19:42:01 +0000 (UTC)
Received: from mx1.sberdevices.ru (mx2.sberdevices.ru [45.89.224.132])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 6F2624011B
	for <virtualization@lists.linux-foundation.org>; Wed, 24 Jan 2024 19:41:59 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 6F2624011B
Received: from p-infra-ksmg-sc-msk02 (localhost [127.0.0.1])
	by mx1.sberdevices.ru (Postfix) with ESMTP id 4FA4C12000E;
	Wed, 24 Jan 2024 22:41:54 +0300 (MSK)
DKIM-Filter: OpenDKIM Filter v2.11.0 mx1.sberdevices.ru 4FA4C12000E
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=salutedevices.com;
	s=mail; t=1706125314;
	bh=+yHbOvDyvGtgm795jjTFfmlf2iRBnxlkK7sPdEluKIs=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type:From;
	b=ds9HQUO5boD/YLHIDX2Ca/XU1Eu8CaXs4JVR/rfVG32/EE6N6AR9PFIrUWTixl9xa
	 JER28IKF2Kn7WPIoOue75fdYAuab9+6jQttZmvdYTCTkpxNZtvOmRaDFVhbvmaRa2y
	 J5/KT+rzjY1rF40UalNv5csgdcT7sfW8UFdqqGNDjcus8QaEi1pad3AqEyBhcJszZ1
	 iCVHHnLcBQ8ta2s6Dr7HPXG65HMgPLTGGHbUmj3X0poiphhyby5qEivB2ZzkQ4eYS9
	 y8ZGBdaKnNFUUseUa7pZftRDk0bKtM5Gw+GYSY185zsB5EfXPQ/SEn6H0l8cpLZPHZ
	 susewPppnz7eA==
Received: from smtp.sberdevices.ru (p-i-exch-sc-m01.sberdevices.ru [172.16.192.107])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.sberdevices.ru (Postfix) with ESMTPS;
	Wed, 24 Jan 2024 22:41:53 +0300 (MSK)
Received: from localhost.localdomain (100.64.160.123) by
 p-i-exch-sc-m01.sberdevices.ru (172.16.192.107) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Wed, 24 Jan 2024 22:41:53 +0300
From: Arseniy Krasnov <avkrasnov@salutedevices.com>
To: Stefan Hajnoczi <stefanha@redhat.com>, Stefano Garzarella
	<sgarzare@redhat.com>, "David S. Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang
	<jasowang@redhat.com>, Bobby Eshleman <bobby.eshleman@bytedance.com>
CC: <kvm@vger.kernel.org>, <virtualization@lists.linux-foundation.org>,
	<netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<kernel@sberdevices.ru>, <oxffffaa@gmail.com>, <avkrasnov@salutedevices.com>
Subject: [PATCH net-next v1] vsock/test: print type for SOCK_SEQPACKET
Date: Wed, 24 Jan 2024 22:32:55 +0300
Message-ID: <20240124193255.3417803-1-avkrasnov@salutedevices.com>
X-Mailer: git-send-email 2.35.0
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: p-i-exch-sc-m01.sberdevices.ru (172.16.192.107) To
 p-i-exch-sc-m01.sberdevices.ru (172.16.192.107)
X-KSMG-Rule-ID: 10
X-KSMG-Message-Action: clean
X-KSMG-AntiSpam-Lua-Profiles: 182911 [Jan 24 2024]
X-KSMG-AntiSpam-Version: 6.1.0.3
X-KSMG-AntiSpam-Envelope-From: avkrasnov@salutedevices.com
X-KSMG-AntiSpam-Rate: 0
X-KSMG-AntiSpam-Status: not_detected
X-KSMG-AntiSpam-Method: none
X-KSMG-AntiSpam-Auth: dkim=none
X-KSMG-AntiSpam-Info: LuaCore: 7 0.3.7 6d6bf5bd8eea7373134f756a2fd73e9456bb7d1a, {Tracking_from_domain_doesnt_match_to}, d41d8cd98f00b204e9800998ecf8427e.com:7.1.1;100.64.160.123:7.1.2;salutedevices.com:7.1.1;smtp.sberdevices.ru:7.1.1,5.0.1;127.0.0.199:7.1.2, FromAlignment: s, ApMailHostAddress: 100.64.160.123
X-MS-Exchange-Organization-SCL: -1
X-KSMG-AntiSpam-Interceptor-Info: scan successful
X-KSMG-AntiPhishing: Clean
X-KSMG-LinksScanning: Clean
X-KSMG-AntiVirus: Kaspersky Secure Mail Gateway, version 2.0.1.6960, bases: 2024/01/24 17:38:00 #23402977
X-KSMG-AntiVirus-Status: Clean, skipped

SOCK_SEQPACKET is supported for virtio transport, so do not interpret
such type of socket as unknown.

Signed-off-by: Arseniy Krasnov <avkrasnov@salutedevices.com>
---
 tools/testing/vsock/vsock_diag_test.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/tools/testing/vsock/vsock_diag_test.c b/tools/testing/vsock/vsock_diag_test.c
index 5e6049226b77..17aeba7cbd14 100644
--- a/tools/testing/vsock/vsock_diag_test.c
+++ b/tools/testing/vsock/vsock_diag_test.c
@@ -39,6 +39,8 @@ static const char *sock_type_str(int type)
 		return "DGRAM";
 	case SOCK_STREAM:
 		return "STREAM";
+	case SOCK_SEQPACKET:
+		return "SEQPACKET";
 	default:
 		return "INVALID TYPE";
 	}
-- 
2.25.1

