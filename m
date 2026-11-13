Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=195.10.208.62
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794612542;
	b=wHdcAIjMzOI+uN7a+mkrczdceZjab9jCs9aXUz8Gg6VavEphYAWqnM3PSHg+Fe5BuvFB
	 bOIJ7lq8H2fNrtGS/bVjdA6nYZIkiqSSB3iESyjfNrutGym2Rue3aBwDXQiY0AENs1IND
	 tMP7xvaK6FKW6nSA4pxbXKD719YJBNL0VAVhwZwht2AoVpPWCqGDAMI5tKPAIw8v+5t92
	 TIjHAg4ncq0fTfwLch8GHnhS+33YPD61dlDnbdOzv9AFRmGKSaSfOPw6PMlpyZtl1F87J
	 OmYMN0ovN7JMZZCU6q+OKd/rpUf/qFC2mYsXn/QrapR2PRwu+7SuuJQaAmwwJ62HZig==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794612542;
	h=DMARC-Filter:Received:DKIM-Signature:From:To:Cc:Subject:Date:
	 Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding:
	 X-Rspamd-Queue-Id;
	bh=YMmiURWTclyFUKjPqBzMU4kcCzHqWhA5bK0YM2ZJ3Pw=;
	b=jtVwSMyCdfVu21IqLZtY4H9cNdwrY4AEOaQLPb44bb1npwFitVTWZuw/hbKbJFh5r/wK
	 f7DrWBrJo3zy+I1wFlrJUYbh+jc+0LJDkKeADr7ddFpJgHb1g5yDa7iXnBdcZE83OR2K2
	 FSsJxJ3xXFubRhv22DAzDqLcw4EKYIWbsA4ZRVafb1l3u6uCWxb5nIbsQ28AvUfffilJI
	 XKH+4OBfyBMPafBMxxB0MKNzkB8jnOEVBzZGAxPfp3NPhT8iiW7UGl2qpJiDzG0WrIKY/
	 ON26n/1a7SK9Omxd7Zw50MJDbKegoYZyiw1QirR130/yyEFEHCmOyhGrhItS1F2bFaQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=mandelbit.com;
	spf=pass smtp.mailfrom=mandelbit.com;
	dkim=pass header.d=mandelbit.com header.i=@mandelbit.com header.a=rsa-sha256 header.s=MBO0001 header.b=ZvtB7qAH;
	arc=none smtp.remote-ip=195.10.208.62
Received: from mout-b-202.mailbox.org (mout-b-202.mailbox.org [195.10.208.62])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2993E606A33F
	for <virtualization@lists.linux.dev>; Fri, 13 Nov 2026 23:28:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 2993E606A33F
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mandelbit.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mandelbit.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=mandelbit.com header.i=@mandelbit.com header.a=rsa-sha256 header.s=MBO0001 header.b=ZvtB7qAH
Received: from smtp102.mailbox.org (smtp102.mailbox.org [IPv6:2001:67c:2050:b231:465::102])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519MLKEM768 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-b-202.mailbox.org (Postfix) with ESMTPS id 4jRD3V0vmqzKnR0;
	Sat, 14 Nov 2026 00:28:54 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mandelbit.com;
	s=MBO0001; t=1794612534;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=YMmiURWTclyFUKjPqBzMU4kcCzHqWhA5bK0YM2ZJ3Pw=;
	b=ZvtB7qAH43vttbZJaG/JxTYoCepd8k6m73Avmyuq9kroqKWsDgrJ41LwfBnugSC2laTbKF
	hiwcnZ9qnyciDWwE+0XtL7Q88W9nzGCwomq7ABVSgZ3nk4LStdugulNRLjPHtoNujkocvm
	NAImsyqRFF9feGz35LaHRjO6BNFtP0nFeDKARmhcObOK7JdLBYjHjJj7vtHfFPkeBP3rJC
	WW5dBuuKy5YSF2GbEKQV+dVVpI6hcz9h2Y+Q2pIzE754Oi8zn6wvhpdcGeskmJZ18bCgDp
	v0lk79zU3AuX01xuUHzKUGznwMm17J9Ih/4Emx52avefCGN+IM5eN/atKIyjfQ==
Authentication-Results: outgoing_mbo_mout;
	dkim=none;
	spf=pass (outgoing_mbo_mout: domain of antonio@mandelbit.com designates 2001:67c:2050:b231:465::102 as permitted sender) smtp.mailfrom=antonio@mandelbit.com
From: Antonio Quartulli <antonio@mandelbit.com>
To: willemdebruijn.kernel@gmail.com,
	jasowangio@gmail.com
Cc: Antonio Quartulli <antonio@mandelbit.com>,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@kernel.org,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	mst@redhat.com,
	eperezma@redhat.com,
	ast@kernel.org,
	daniel@iogearbox.net,
	hawk@kernel.org,
	john.fastabend@gmail.com,
	sdf@fomichev.me,
	netdev@vger.kernel.org,
	virtualization@lists.linux.dev,
	bpf@vger.kernel.org
Subject: [PATCH net] tun: complete the zerocopy buffer of packets consumed by XDP
Date: Sat, 14 Nov 2026 00:28:41 +0100
Message-ID: <20261113232843.2338734-1-antonio@mandelbit.com>
X-Mailer: git-send-email 2.56.0
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
X-Rspamd-Queue-Id: 4jRD3V0vmqzKnR0

When vhost-net passes a zerocopy buffer that tun_get_user() does not use,
because the packet spans too many pages, the packet is copied and the
buffer completed. If the copy goes through build_skb() and native XDP
consumes the packet (DROP, TX or REDIRECT), tun_get_user() returns
without completing it: vhost-net never gets the descriptor back, and
closing the vhost-net device then blocks forever.

Complete it in that case too, as copied.

Reproducer: vhost-net with experimental_zcopytx=1 on a tap device with a
native XDP_DROP program; send one 806-byte packet as 40 descriptors, each
in its own page. The descriptor is never returned and close() of the
vhost-net fd does not return. With the patch it is returned.

Tested in an x86-64 VM with the reproducer and the tun kselftest.

Found by the Sashiko AI review bot, as a pre-existing issue while
reviewing an unrelated tun patch, and confirmed with the reproducer.

Link: https://sashiko.dev/#/bug/linux-f9997fb6-303f-41d6-93e2-60c392b1856f
Fixes: 761876c857cb ("tap: XDP support")
Signed-off-by: Antonio Quartulli <antonio@mandelbit.com>
---
Notes:
- Completed as copied (success false), as the copy path does: the packet
  was copied into a page fragment.
- net-next replaced ubuf_info->ops with net_zcopy_complete() in
  ecca9bb2c855; there the call becomes
  net_zcopy_complete(NULL, msg_control, false).

 drivers/net/tun.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/drivers/net/tun.c b/drivers/net/tun.c
index 86fd44e10755..927196840725 100644
--- a/drivers/net/tun.c
+++ b/drivers/net/tun.c
@@ -1871,8 +1871,15 @@ static ssize_t tun_get_user(struct tun_struct *tun, struct tun_file *tfile,
 		err = PTR_ERR_OR_ZERO(skb);
 		if (err)
 			goto drop;
-		if (!skb)
+		if (!skb) {
+			/* consumed by XDP, after copying */
+			if (msg_control) {
+				struct ubuf_info *uarg = msg_control;
+
+				uarg->ops->complete(NULL, uarg, false);
+			}
 			return total_len;
+		}
 	} else {
 		if (!zerocopy) {
 			copylen = len;

base-commit: ead6fa9a0ab194f02a2f36d634b193e9c5f9a1c6
-- 
2.56.0

