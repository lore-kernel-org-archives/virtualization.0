Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=115.124.28.169
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793695328;
	b=Kr9+ym9dHp5A3MTD5fRdvbL78nDwYpLqbFviuyy45J4O0svPjUQqhlW4VUdsMcL85C2L
	 //t6TOmeC8Ear8pv1LwLfB+EXIfopxLGThBGYNzxZz9pvBnd27gyYvBtcln+XbhSN5M7K
	 tUjZ7xJlb4ij6fARklzqRc66OOvc6xqgUHhghMe+RSnb/5JSkH61YqPfvMseJFTDF6QBh
	 FNP5yYXVyBeIeEkeX1cWlIP1Me/aKrK1G6jQIa3RWmO3iQNOiicbB4AgzQrJs7QHeRkco
	 HHGG67roCMshlAGNFg4+HacRZPoX7o0zw6Jw3s/0c4B8+J2f+cvEp7JyfwDKP3zSM8A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793695328;
	h=DMARC-Filter:DKIM-Signature:X-Alimail-AntiSpam:Received:From:To:Cc:
	 Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=UO1AH6z6kWHNPfsPB/Z9b6Fgl+nVJ6ikVhnEdW6S4Ww=;
	b=j6EbhYuH8QYJSB3bkrEqt/p0PDoQCjFUKyu4YyUrERuNC4qciN0DPfU7+O8N0sgjIAnA
	 hzCu7KQaSeAD6LdeDywHSZgzuN0fPpCNxiMenaT3VIoniQu50JzVDJaMbzIHM3CLjgU4R
	 tep06KJ0g9dhxOds1FG4/D92YifUcxW7y09opfHM+WTeLmaGzEAu4cIIUdQtjHZlMFiZQ
	 TBZ9LESFaPlshepmOOGi1tELjlqo6EvuONJhdU+kcH4xUK7g1cStrRedEEoFgvJMjP6EE
	 xnZbEbb8pnDiJVLSFY8Ln6fceoF9AEY/LTpcgVPZt5FyjkjKiV8uiJwQsifkhuGZKhA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=xiaopeng.com;
	spf=pass smtp.mailfrom=xiaopeng.com;
	dkim=pass header.d=xiaopeng.com header.i=@xiaopeng.com header.a=rsa-sha256 header.s=default header.b=GxZ0w7uu;
	arc=none smtp.remote-ip=115.124.28.169
Received: from out28-169.mail.aliyun.com (out28-169.mail.aliyun.com [115.124.28.169])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E77D606EEAA
	for <virtualization@lists.linux.dev>; Tue,  3 Nov 2026 08:42:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 7E77D606EEAA
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=xiaopeng.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=xiaopeng.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=xiaopeng.com header.i=@xiaopeng.com header.a=rsa-sha256 header.s=default header.b=GxZ0w7uu
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=xiaopeng.com; s=default;
	t=1793695317; h=From:To:Subject:Date:Message-ID:MIME-Version;
	bh=UO1AH6z6kWHNPfsPB/Z9b6Fgl+nVJ6ikVhnEdW6S4Ww=;
	b=GxZ0w7uuUz3y/wrVG19scxtv4OZHS0fwQt53hR63Yqn3CRr3IsBvevzWITq08xayfRlKlZ/YtAm5FI3HkIvrjXU9i8apfJXFKQpZCw2LCCgj+TICwc46QirneG0fsB6Vb2tK/Q4xswE44Clb2bAuobOH0b5kDgehPZ1QHpp8h+A=
X-Alimail-AntiSpam:AC=CONTINUE;BC=0.0766856|-1;CH=green;DM=|CONTINUE|false|;DS=CONTINUE|ham_regular_dialog|0.00323087-0.000708702-0.99606;FP=10185923086858692184|0|0|0|0|-1|-1|-1;HT=maildocker-contentspam033071099199;MF=zhugl3@xiaopeng.com;NM=1;PH=DS;RN=5;RT=5;SR=0;TI=SMTPD_---.jvS.gZt_1793695316;
Received: from DESKTOP-UL5U09E.xiaopeng.local(mailfrom:zhugl3@xiaopeng.com fp:SMTPD_---.jvS.gZt_1793695316 cluster:ay29)
          by smtp.aliyun-inc.com;
          Tue, 03 Nov 2026 16:41:57 +0800
From: Guanglei Zhu <zhugl3@xiaopeng.com>
To: amit@kernel.org
Cc: virtualization@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	liuc63@xiaopeng.com,
	stable@vger.kernel.org
Subject: [PATCH] virtio: console: check the control packet size before parsing it
Date: Tue,  3 Nov 2026 16:41:56 +0800
Message-ID: <20261103084156.426810-1-zhugl3@xiaopeng.com>
X-Mailer: git-send-email 2.43.0
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

The control queue handler hands whatever the host wrote to the
control queue straight to the parser:

	buf->len = min_t(size_t, len, buf->size);
	buf->offset = 0;

	handle_control_message(vq->vdev, portdev, buf);

handle_control_message() casts the start of the buffer to struct
virtio_console_control and reads the id, event and value fields
without ever looking at buf->len. A control packet shorter than the
structure makes the driver parse whatever bytes were left in the
reused buffer as a control header, and the uninitialized event then
drives the port state machine.

Drop control packets that are too short to hold the header.

Fixes: 17634ba25544 ("virtio: console: Add a new MULTIPORT feature, support for generic ports")
Cc: stable@vger.kernel.org
Signed-off-by: Guanglei Zhu <zhugl3@xiaopeng.com>
---
 drivers/char/virtio_console.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/char/virtio_console.c b/drivers/char/virtio_console.c
index 019bcae81af5..5e2a4403dbf8 100644
--- a/drivers/char/virtio_console.c
+++ b/drivers/char/virtio_console.c
@@ -1597,6 +1597,12 @@ static void handle_control_message(struct virtio_device *vdev,
 	size_t name_size;
 	int err;
 
+	if (buf->len < sizeof(struct virtio_console_control)) {
+		dev_dbg(&portdev->vdev->dev,
+			"Invalid control packet size %zu\n", buf->len);
+		return;
+	}
+
 	cpkt = (struct virtio_console_control *)(buf->buf + buf->offset);
 
 	port = find_port_by_id(portdev, virtio32_to_cpu(vdev, cpkt->id));
-- 
2.50.1

