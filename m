Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=203.205.221.236
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794405032;
	b=MKxsL8p+gs3oRCF6e0EHW6SvS2F+E9gL+vSeCVjeDF8KXNazJb+HcricxilZdr1ZGZ6W
	 t3TKvzdNa6w7mS9HmVCEBcjwajaKWXFBO5BPBgUXhq+yZYzOFCJ6LB1JAgVytnBVXuksM
	 54E/0lYbDl3gfCSEGyMIDg3Of9NkAKT7qk3erZNcUxfwDkr0lykxIycn5vuGAt9fi5Qrh
	 w3oM3u7GQ5QdEIW+9Yq2YCQMgdUsTomhuSCjUW1fe2iTKio/OtFBRbNsaayZHcYEjzSSh
	 q6wOShUcCpwn3LOelcVwQxj1fgy+DOIRQHyfenmbeH2flZJ05ZE/yCLo/2MrBwrx0hQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794405032;
	h=DMARC-Filter:DKIM-Signature:Received:X-QQ-mid:Message-ID:
	 X-QQ-XMAILINFO:X-QQ-XMRINFO:From:To:Cc:Subject:Date:X-OQ-MSGID:
	 X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=lrCLdu1Uj8IpYGbohx64Dr8YzwhjD4Aogvb43lGJo8Q=;
	b=sjFuvqwSEOdzLUQBt6UodQT1QrEFDWg2WRaJ3puaglfl1NSX0WkNheF48OHf8UMmqIMV
	 F9cpisFIexoj0HAthW8H6daFO2CsGx2LpXkC/8k+twHoPV9QCFbuZqTzEMd8ewN+5l4sM
	 ksaECk5q8S3qj4DE3fRbaVgjCObZ5hZugI7CmYuaErA1M667JgdZYZVE4xMcL/qtCiyAm
	 aCzeMsnAj+xmsu+qx7d8+d1sGu0mdkNlLyNR9BqV1dTJ3yOqVrKYq75SBfVKLdKE2VZv9
	 dFJjf74DXQO+vpgGF1iVomOKg/ONxlRHCrI4oS1Pfp+jJVqWvpgFsGdw+BWVmn3oX1Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=qq.com;
	spf=pass smtp.mailfrom=qq.com;
	dkim=pass header.d=qq.com header.i=@qq.com header.a=rsa-sha256 header.s=s201512 header.b=kqNcUF9L;
	arc=none smtp.remote-ip=203.205.221.236
Received: from out203-205-221-236.mail.qq.com (out203-205-221-236.mail.qq.com [203.205.221.236])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D076F606A32E
	for <virtualization@lists.linux.dev>; Wed, 11 Nov 2026 13:50:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D076F606A32E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qq.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.a=rsa-sha256 header.s=s201512 header.b=kqNcUF9L
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1794405028; bh=lrCLdu1Uj8IpYGbohx64Dr8YzwhjD4Aogvb43lGJo8Q=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=kqNcUF9LH3c2FJM961kN0RmwZ/A17xC4TR3aZ0ekkWginNPBYVEW9qBGaJZsmDuEL
	 LDtQwPWy4uaT9yBL+ve1hW/Puq6Xo6cF7Ds/hsHaRRazD4fNYp9rN0AZ7VteQ4aq3R
	 BnwkXsANz9WdQh5fbFStROqSnH9+lOchM5/Pzs+I=
Received: from ubuntu.. ([112.3.92.91])
	by newxmesmtplogicsvrszc43-0.qq.com (NewEsmtp) with SMTP
	id C92862E4; Wed, 11 Nov 2026 21:50:18 +0800
X-QQ-mid: xmsmtpt1794405020thbzufhkb
Message-ID: <tencent_3206E4502773D7AC6F720CF4046674E5A809@qq.com>
X-QQ-XMAILINFO: N6IfSeM/PG+ti4tgBMk5WwFsx315YDPXfk8C9KO/PPtAfGLRF7pWeLMVjvUxKi
	 Jf3o7ksWWEiWBGFB6YfYnXu110+HwBMgktUgSDooryMeuyuu5DpYXrtaPgY+CrFwG+bR+O0wFl2d
	 SlEsLFxPf3EmS94KxvjqbrTqo0X/gs1hlxEGqI0n1YrA2xPXvUw6n910U2us043Lb8mRKHixQqos
	 pL6ItedeLzruUFLwWkaTcIwVA+hObGwveTJh60KYC/c9DSQZBz9OM05Q9lFbL8+24+ouiNEMlig/
	 qUyLe3KjB01hp8KsgfIRN/3jbzgy81LUhKrELNviHnPOzbkIY9p7FQdLwYfcrlMLI82zB4F1Fw1p
	 v3a1/UYliyq8x/FUnTPnxa1MJP56GKfr/ecB5IyUtqP//KreIH7H5Fb/oCBD22NcBeCugxOAXMNz
	 c+wFBXqJiwTHCjKqLuoNUEj+y1jP3dRiAdlAUIhwch9fbP+a7Vxn55LMCORDgK7mM0JVwP6xmYXR
	 Z4G5vdLOmX5TYjZj2ZN9w8yKJ5SGYeFziN/Nbqn00rvASrt2YhBqm1KcLJuG8ZHtbDANt5H4KS2I
	 JwYTa8OL8KdRe/Nb0zJVi2dJ3pWT5/YV4sFVzoIKlOElvCT6yvK85f2BwspmnxUgXUKgPH+hkUfh
	 UoiMd4bSOSvMkfb40b6cXmWefrJ1ix3juvOMWgFpEhDkVEFf+0nMc+xKXi7TMdRCpqLSdIGpr58b
	 KyrrC4Xk0WslsjiPqwHNIt//74n/cB1Hq9G5ZSv4saETqqDwu25cB1xAqDx6aEACZIARPSal60ho
	 wqHnEezjfd1l7KGnn+DGNfLCepAp8Zo+KjG2BxRmye1dfG/wuOl/hTeO82N7ZE+yfu71cBgvBSA/
	 4rIvNDPRXHrjuYTqgUCi8+/mkd7GE5CvBc00n54iO3DxMgvTS3n1RNw2Tl5UCOrFPf08uVm/27Wu
	 tNm+FVWV/A7TtddDoWSwIYtoP9owmJxJAgYh8w97udoVAZB1e+lCnKusoc1ZuRtIo+YF07TWFJHL
	 D9JI6xY5/rDfN69qWmAqMp/X1I/GGShA+NCcl5H9WY3u0j6U1gd7aNbVHECi9dKNoPZJ1PlmRt7u
	 uo3lFgV5ray71CHtyOTMfO6cTc1FAvX1909LNl7zGmgpMR0z360aaQ1Z6lvS3RfYRrc8IamPZjmi
	 sgNLQ=
X-QQ-XMRINFO: OD9hHCdaPRBwH5bRRRw8tsiH4UAatJqXfg==
From: Congjie Zhou <zcjie0802@qq.com>
To: netdev@vger.kernel.org
Cc: mst@redhat.com,
	jasowangio@gmail.com,
	eperezma@redhat.com,
	xuanzhuo@linux.alibaba.com,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@kernel.org,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	virtualization@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	zcjie0802@qq.com
Subject: [PATCH net 2/2] virtio_net: mask callbacks before releasing NAPI ownership
Date: Wed, 11 Nov 2026 21:50:08 +0800
X-OQ-MSGID: <20261111135008.1048054-2-zcjie0802@qq.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <tencent_AA4F39DA7ADE330C721C03AAA832B92DD608@qq.com>
References: <tencent_AA4F39DA7ADE330C721C03AAA832B92DD608@qq.com>
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

virtqueue_napi_complete() prepares callbacks before calling
napi_complete_done(), then disables them if completion returns false.
On the hard IRQ deferral path, completion can release NAPI ownership
and arm the watchdog before returning false.

A successor poll can rearm callbacks and complete before the old caller
executes virtqueue_disable_cb(). The stale mask then disables
notifications again. If the one-shot watchdog has already run, no NAPI
owner or timer remains to consume later used entries, causing a
persistent RX stall.

Use napi_complete_done_with_irq_mask() to disable callbacks before
completion can hand NAPI to a successor, and remove the stale mask after
a false return. Keep virtqueue_enable_cb_prepare() before completion:
moving it after ownership release would reintroduce the RX virtqueue
race fixed by commit cbdadbbf0c79 ("virtio_net: fix race in RX VQ
processing").

Signed-off-by: Congjie Zhou <zcjie0802@qq.com>
---
 drivers/net/virtio_net.c | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
index dd2c41ef6..0de6bd95a 100644
--- a/drivers/net/virtio_net.c
+++ b/drivers/net/virtio_net.c
@@ -727,19 +727,23 @@ static void virtqueue_napi_schedule(struct napi_struct *napi,
 	}
 }
 
+static void virtqueue_napi_mask(void *data)
+{
+	virtqueue_disable_cb(data);
+}
+
 static bool virtqueue_napi_complete(struct napi_struct *napi,
 				    struct virtqueue *vq, int processed)
 {
 	int opaque;
 
 	opaque = virtqueue_enable_cb_prepare(vq);
-	if (napi_complete_done(napi, processed)) {
+	if (napi_complete_done_with_irq_mask(napi, processed,
+					     virtqueue_napi_mask, vq)) {
 		if (unlikely(virtqueue_poll(vq, opaque)))
 			virtqueue_napi_schedule(napi, vq);
 		else
 			return true;
-	} else {
-		virtqueue_disable_cb(vq);
 	}
 
 	return false;
-- 
2.43.0

