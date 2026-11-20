Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=52.59.177.22
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795145942;
	b=pH2RsLSXWOyKcYi2OGqJcDrMwuZmAsVE7PdqCSRxZL0gaioVaiRq5838IL5MuzW1nPD2
	 KPI3XevLFeo1g0MFzhXnLWoaYFDaJxbwR4iNbwEeDOMaee4gYm35eaK7GC87eA75Kdrb3
	 YMdOGF8S0mY3KOMYJq0589aLAw4xIWMvev+V1QOv22/Yb2WolVTDasDhAneEAQVcuDENO
	 duCDD0REbD+3xWkz/0hiNV42PUI5foqX7Ftpm1w+0xy57PJs7cCUPYldVYhnDpwmvjbQ0
	 J2caWcrQiOJ/b3DthF3Hcg7LxzkEpsO33GITYmDuCMTii77duDGKSifp7VSHdXLgIqg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795145942;
	h=DMARC-Filter:DKIM-Signature:X-QQ-mid:X-QQ-Originating-IP:Received:
	 X-QQ-SSF:X-QQ-GoodBg:X-BIZMAIL-ID:EX-QQ-RecipientCnt:From:To:Cc:
	 Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding:X-QQ-SENDSIZE:Feedback-ID:X-QQ-XMAILINFO:
	 X-QQ-XMRINFO:X-QQ-RECHKSPAM;
	bh=6ID25TASgB9mY3j+/9ivqOm1LKio+2OprW84VL0Grno=;
	b=WYlNt+qq9t5gvL6AQt7votzgV9Hs/plwM/vtAmp/dz+727d0DjE2hXRv4ZPXP7G8XuZb
	 P0X9DbFkHYn3ymxmkkv7Q35qpl+yo/PyIX3y/zNoTzhMr0Va5SNv/e+HUFsP6QVha5xj6
	 B7gmbcxZFqiDIydP+SK/HIaT1HmLQ3jEif3pTZugVvfHHP+1dzaRsbWGbMpF+DlY1ghcG
	 3AdkS/wYqGogDWs/mTHIirszE9fazYuFVtWl5ojLKOggkfEgFnpTVJr0AcRT7mz1nXWEO
	 Bd2vshsnrA4DpU8+klmwt/QxqfvUwbtChB8g2iWOe5ScSSFkhQ28hEasQ/drss2asWw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=uniontech.com;
	spf=pass smtp.mailfrom=uniontech.com;
	dkim=pass header.d=uniontech.com header.i=@uniontech.com header.a=rsa-sha256 header.s=onoh2408 header.b=RaDWpzLq;
	arc=none smtp.remote-ip=52.59.177.22
Received: from smtpbgeu1.qq.com (smtpbgeu1.qq.com [52.59.177.22])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D38A5606A320
	for <virtualization@lists.linux.dev>; Fri, 20 Nov 2026 03:38:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D38A5606A320
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniontech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=uniontech.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=uniontech.com header.i=@uniontech.com header.a=rsa-sha256 header.s=onoh2408 header.b=RaDWpzLq
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=uniontech.com;
	s=onoh2408; t=1795145912;
	bh=6ID25TASgB9mY3j+/9ivqOm1LKio+2OprW84VL0Grno=;
	h=From:To:Subject:Date:Message-ID:MIME-Version;
	b=RaDWpzLqCdYYGRlKySuGUQaSPqkaLKbto6xE75Z7DkWkxQkTgTfeRG0R94NcJFHIo
	 wZa943Zh1rATL+aq0YIJh0YyEYetiF/YBgVPubX62zIUIoXfixEo6Rm6SQSyUkWBcf
	 FklDE/31hdDk2EvwxWiT95VlBDo+MowuMgkvLIjc=
X-QQ-mid: zesmtpgz9t1795145907t2b7c356a
X-QQ-Originating-IP: 2Dvc6PhiaE8wquu067dn3SVToxhwDgWWzXwvNhwqyak=
Received: from PEN202512010004 ( [113.57.152.160])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Fri, 20 Nov 2026 11:38:25 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 1
X-BIZMAIL-ID: 5714097690566660774
EX-QQ-RecipientCnt: 10
From: raoxu <raoxu@uniontech.com>
To: mst@redhat.com
Cc: jasowangio@gmail.com,
	eperezma@redhat.com,
	davem@davemloft.net,
	kvm@vger.kernel.org,
	virtualization@lists.linux.dev,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	raoxu@uniontech.com,
	stable@vger.kernel.org
Subject: [PATCH net v2] vhost/net: Fix receive queue test in busy poll
Date: Fri, 20 Nov 2026 11:38:24 +0800
Message-ID: <1B3A1B72438119BC+20261120033824.681219-1-raoxu@uniontech.com>
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
Feedback-ID: zesmtpgz:uniontech.com:qybglogicsvrgz:qybglogicsvrgz6b-0
X-QQ-XMAILINFO: N4kMhpKju7/pug6xHKTvHbdchBT/IBEy6aGk8cOlUz33hi8Qj9qKk5tl
	QKAN9A5QI2vypQtXDC+lvRXzrp5RxsvkTRBRys8mK7lGs2KZ5tmCHrfrirdFMSmIHiCXJAK
	clPUZd9F7/qorsVB4CddiztQNYlu6beQmVo2r2yLggA3uu0YVK1vCu2B3BVSo8LA3zP+rDn
	28sdh0LC+Jg1Ys4G2x7+/9IjRVZ4+9NyAV3l9J+fjQ26kFFD3dhO/qTWmI+xuTM52kQaf//
	plUnZL0+GUDFWBERGBdjY2pi/S6j4bh+gicodXtr6nDl21mF7eXU0KZNVzNr2z48XMAdT2f
	x26Os8BHGNLwS5F3WCnmZ/fcpTjF1RiPJi6gKw+yrY9XwCZi6BTP2AYYLi22R2frK+uN0Xu
	mVcsRkiP0M915XrEjLSXh+5UzyKS0MtKDbvXMO838UfyOI325p5SGFsKbWyt3R5qcAhQ4Tm
	w5HCaIsSEBDvqVeN81rWamaJgR+U5sh8rLwZvMXt749NSaeh/+kM9GJaiP7pT8K8VAyFYtK
	ZoLPQoTZeiYhsrBVmOrjpbbxZSjpqV8JUviv+ppXjvM5YlrzPHvnTzuMPfzwbkOlwyhPKul
	3CtLQOubykvgiyPC8zOiUmM0I2edOoxuZ+74AWoFV/kdPcpZz4+nC7Mhr0W9AYKeLFDKXlY
	9Gp52SqGvXltQvcgqC6s3avxCWBoItbpHA4acWscVPYPVhqg0kSJYgB/d+EL633dhDFeGEE
	F2GaPqnpLCJdMreuggwjoNSj1qeGJxWfbS1sYgeEVJzyHWGS6+Do9iuZzq9FnlFRoXB+4oq
	qJHSUQYqXjz2aoWMOWZTrTIXmL0qWir3Qw/5bV+5seH+ZtwKW9zZNnPBTjULfdS6vlvgKQ5
	GGhG439/uZDSx0JPnJ1LLausWze/MXqKfI89LSwOxJRMR9q3VlTP/8V8Z7Oj6zztWIFMLGm
	TC2ACTEPbeIO3xN5aTP6lmfbjDGjyYhEKyraEG3b8tPgX6LfGJSzFJGFWQKr17eneavmVjH
	6WVi4a4cjyB2E+NRkl4irctZ/s+7PSxK2g6Wa4OeVpWFyo7yEcVHLgWJBoDvbDZ2R0xgnpC
	p6J483PVEMJ76aQYexPo3g=
X-QQ-XMRINFO: Nq+8W0+stu50tPAe92KXseR0ZZmBTk3gLg==
X-QQ-RECHKSPAM: 0

From: Xu Rao <raoxu@uniontech.com>

sock_has_rx_data() returns a positive value when receive data is
available. For sockets without a peek_len() callback, however, its
fallback returns skb_queue_empty(), which has the opposite meaning.

An AF_PACKET SOCK_RAW socket is accepted by get_raw_socket() as a
vhost-net backend, and its socket operations do not provide peek_len().
With busy polling enabled for this backend, an empty receive queue is
treated as ready and a nonempty queue as not ready. This can make
vhost_net_busy_poll() stop polling prematurely or fail to stop for
queued receive data, and invert its receive-side scheduling decision.
TUN and TAP backends provide peek_len() and are unaffected.

Negate skb_queue_empty() so the fallback matches the callback and the
readiness checks in vhost_net_busy_poll().

The issue was found during AI-assisted code review. The helper's
incorrect result was confirmed on x86_64 running 6.6.0-amd64-desktop
using a temporary diagnostic module containing the original and fixed
helpers. An AF_PACKET SOCK_RAW socket, without PACKET_RX_RING, was
bound to loopback in a private network namespace. Across three cycles
of sending and receiving a 60-byte frame, the original helper returned
1 for an empty queue and 0 for a queued frame. The fixed helper returned
0 and 1 respectively, matching socket readability in all nine checks.
This tests helper copies on real sockets, not the running vhost-net
busy-poll path; the vhost-net module was not replaced.

The patched drivers/vhost/net.o was also build-tested on the net tree
with x86_64 GCC 12.3 and W=1 under allmodconfig and allyesconfig.
No end-to-end vhost tests or kernel selftests were run.

Fixes: 1576d9860599 ("tun: switch to use skb array for tx")
Cc: stable@vger.kernel.org
Signed-off-by: Xu Rao <raoxu@uniontech.com>
---
Changes in v2:
  - Target net and add the introducing commit's Fixes tag.
  - Explain the raw packet socket backend and busy-poll decisions.
  - State the AI-assisted discovery method and document the diagnostic
    module test, its results and its helper-level coverage.
  - Document the targeted build tests.
  - Keep the code change unchanged from v1.

v1: https://lore.kernel.org/virtualization/20261110051642.249640-1-raoxu@uniontech.com/

AI assistance: OpenCode was used to inspect the history, prepare and run
the diagnostic module test, run build checks, and revise this message.
The code change is unchanged from v1. The discovery method was confirmed
by the author.

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

base-commit: 435cbdaf9b03687498dc16fe4af8d16a977e21d0
-- 
2.50.1
