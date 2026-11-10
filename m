Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=54.254.200.128
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794287835;
	b=hQeUTw7oFYIRJHUYCZvHRcwYxRQyiQ55txVbHahL+T33v3V8w8FmD6o/FcFN0vHdeRhs
	 FST41/CF3sSMqHEUoWhUwnCIRtirtjAEBmx+npT8hwXANNBIxlZfIfNLWAgQDHnhdaKYK
	 oI2lUkYOLSYHlwmIbGN5BWmnJ/UkmDhdQrCjltlDYGe1+k99DHloTInMy01RNiiOOk89k
	 1jNVf9PP81zaRSDDe9IyG1dBZVdxvgLuPZO35u6siuLURl0QvTRDlMBdEHOlF1NCUVZ1d
	 l5hf//ge0gfKxudpGZMsXexb9vIMOaUfBYGb+ppdGlAw/5hN9zd6pl7F4X5kTn8mdsw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794287835;
	h=DMARC-Filter:DKIM-Signature:X-QQ-mid:X-QQ-Originating-IP:Received:
	 X-QQ-SSF:X-QQ-GoodBg:X-BIZMAIL-ID:EX-QQ-RecipientCnt:From:To:Cc:
	 Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding:X-QQ-SENDSIZE:Feedback-ID:X-QQ-XMAILINFO:
	 X-QQ-XMRINFO:X-QQ-RECHKSPAM;
	bh=Yv0P3TWiAzWONtWG2ECNG8H4lCa4xc6OHScDZ0+4aCc=;
	b=f0QlzDffR0TVc/1VnpRR/8QiKK8ZqSfg2MlgPeOvv0o0D/TRhaA7pnUAzWQnRN+Ni3gb
	 7DJSc46Prxhrb8XG0IP4o3gMawhrxSkAtUa/dow98Lh95IPOoKWj9hgmfP2hkwryHQOEf
	 55J/k5UYyxFzhib+YmUdI61NP0tB29BRywforhyOpitIvoyBiUGE0g4cp4+zN7fHcdIEp
	 khQYQrgIjCSqpEnrVmIk8eqoJYaYIK/IXxgc2zD6m/eeOmtlmEZc55/vJ0Fptya6Lvh1z
	 ZCPOIGho8fA7N1BYdtALZwf8YMwl9k8/SxfSZNjZ/BZQ55JJBzgVvyLYEht6D/mqTAw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=uniontech.com;
	spf=pass smtp.mailfrom=uniontech.com;
	dkim=pass header.d=uniontech.com header.i=@uniontech.com header.a=rsa-sha256 header.s=onoh2408 header.b=p6P+7S4a;
	arc=none smtp.remote-ip=54.254.200.128
Received: from smtpbgsg2.qq.com (smtpbgsg2.qq.com [54.254.200.128])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32A4D606A330
	for <virtualization@lists.linux.dev>; Tue, 10 Nov 2026 05:17:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 32A4D606A330
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniontech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=uniontech.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=uniontech.com header.i=@uniontech.com header.a=rsa-sha256 header.s=onoh2408 header.b=p6P+7S4a
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=uniontech.com;
	s=onoh2408; t=1794287821;
	bh=Yv0P3TWiAzWONtWG2ECNG8H4lCa4xc6OHScDZ0+4aCc=;
	h=From:To:Subject:Date:Message-ID:MIME-Version;
	b=p6P+7S4a/rtI0Ax5JVDJTg165W4NPkTC5PFo99HU5CfgqWHxsLR1DoAVyBe/kivJu
	 EzSLruBoQ7nNBjBEi6LzK9SnHiECUPuNDwrG4BTWW09SZmlmmCgkI8joDMmdkrOoHF
	 khEnjOBFC5M/BWvNshaRZ3243n1DiKaZ3ufNE4sU=
X-QQ-mid: esmtpgz10t1794287805t9d703794
X-QQ-Originating-IP: aIKJNBS3eM61OM3SC3IHGrznIfXqHEw19N6Jpqqjrgg=
Received: from PEN202512010004 ( [113.57.152.160])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Tue, 10 Nov 2026 13:16:43 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 1
X-BIZMAIL-ID: 10376603232952361344
EX-QQ-RecipientCnt: 8
From: raoxu <raoxu@uniontech.com>
To: mst@redhat.com
Cc: jasowangio@gmail.com,
	eperezma@redhat.com,
	kvm@vger.kernel.org,
	virtualization@lists.linux.dev,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	raoxu@uniontech.com
Subject: [PATCH] vhost/net: Fix receive queue test in busy poll
Date: Tue, 10 Nov 2026 13:16:42 +0800
Message-ID: <005FA5F7354482C7+20261110051642.249640-1-raoxu@uniontech.com>
X-Mailer: git-send-email 2.50.1
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Post: <mailto:virtualization@lists.linux.dev>
List-Help: <mailto:virtualization+help@lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
List-Owner: <mailto:virtualization+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: esmtpgz:uniontech.com:qybglogicsvrgz:qybglogicsvrgz6b-0
X-QQ-XMAILINFO: OKDqGZ+wcdYmN7I/w5u32lU6eKdu1rDL+iRi6TU3+4kma/JDSI7yDCwL
	s8mdutyqH1o/CPRRqvZQBOc7rwstx6xyYpYSR2kPGE/JiQDZpiAp984By23LA5MzsWoq4Bj
	VFwr0sBLM9iZeeBX+A+aZk/MCNI1by4iV2JPVb/O1G0N23aY8/79kHjJVgLhmyvXoD71vSc
	vSb9sbitlgBiF8LLCAVMLj8HwsnHCLIf5n6kmzRJPE2nWhyBWeDGXNJc+QK4F91IvALPFfr
	KoXx5TfxS7Oq9DdwEM74EHAAia6/1xI4NcJ333aPADvcTZm39Uva35nnj3ZzC8cvisuB/tX
	EMyVfFTyZ0yiDA3kQKoxWpINHH4W8txW5U22jZF7BWCVr8USId0rdeY4m+gc+uVswmfdLRz
	SR7MHgCrte3G6P48hyUoOC5aMbytOdJzdMs1g2JJ3R+ja8zN2HfCCP8JdOT2jXoBH2v3fxb
	Nbk61qenkhFvrliiTb4AzwI3c8FbQ113yIazXkJPtzZHkh21Vwte1s5CMhfc4bI+uw2cNsg
	vAtVo/qQZEO2wUEp5aP6EhXbkbHm1xVfe4CuAkLIPOqGjr4Z+wjGJHmSZ5waSxm4TciHy5C
	9Af+FGgjh28jt1EdCC5j+nFiLM5CUPYlii/X2cPjycOZl76XfBd/j5E5grlP/wtIQvmHX+z
	EGKRlvEMDeHe9uFrLpedkbtvoEx3PQQUgPRwWDtuizLIdFeXuZRjSc1GK8918XKzoMioZ2F
	m7yjIaO02zskO2tIqveEqZKELJ/vTNesxsVMuPHpmchVc71KGV/yfz9Kgs1hxSq7u8Z17EP
	+jCAxIofhZPhgQD2SfjhE0dYLHpQ8F8XBVtFYV07eMbmlzLjfQI2UGxMqR/b1tv7oAojpsL
	u3bWlSp4gj8EUL+K6HnfM3oLg4Uqshn2urZ9CYKVmSYRNvFCeN/LnhY3boeYielYakBErCm
	3GKyCIfQk7X2z91C4KCQxw9ib3MIddR85yi+EbyQCmPpgCCW3BPg7oC1fI5LHKX/efG3awl
	41S/T1LKYKydWZUBf684sKJTykkrEc9BqLn7hyemB7cHuM7GEX
X-QQ-XMRINFO: OD9hHCdaPRBwH5bRRRw8tsiH4UAatJqXfg==
X-QQ-RECHKSPAM: 0

From: Xu Rao <raoxu@uniontech.com>

sock_has_rx_data() returns a positive result when receive data is
available. Socket implementations with a peek_len() callback follow
that convention, but the fallback for sockets without one returns
skb_queue_empty(), which has the opposite meaning.

This makes busy polling stop when a raw packet socket has no queued data
and fail to recognize queued data through the fallback path. Return the
negated queue-empty result so the fallback matches the callback and its
callers.

Signed-off-by: Xu Rao <raoxu@uniontech.com>
---
 drivers/vhost/net.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/vhost/net.c b/drivers/vhost/net.c
index 4570a4ffbab2..10ed2d55ff07 100644
--- a/drivers/vhost/net.c
+++ b/drivers/vhost/net.c
@@ -538,7 +538,7 @@ static int sock_has_rx_data(struct socket *sock)
 	if (sock->ops->peek_len)
 		return sock->ops->peek_len(sock);

-	return skb_queue_empty(&sock->sk->sk_receive_queue);
+	return !skb_queue_empty(&sock->sk->sk_receive_queue);
 }

 static void vhost_net_busy_poll_try_queue(struct vhost_net *net,
--
2.50.1

