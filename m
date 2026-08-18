Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3208368D50
	for <virtualization@lists.linux.dev>; Tue, 18 Aug 2026 05:47:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787032077; cv=none; b=kZX21WvEcjETKxUWrQGIL1ggGvyipJI0CU+vDncDu2DxzV90a6QdaveMB7SxDJJqo3Iat7g9mT/AXf0C/3GqyWWBaTfF2lU1dTa3Ipw0R6UxGvDy2qrkwpsxtSySExhuBO65OpH+C+9y3Ik+oi4+HZjvElL0GinTFSdHwd/YJ9E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787032077; c=relaxed/simple;
	bh=3kwUH9VjOFNvtVGD9P+Sv3DG838jDeBeyfBh1fP55f0=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=XnIyVk4MglHdhcKVDYkH/RiTZ+fcO/+eNRXn48PSJgUH2EixcnpQI/IM6ZzBuAlsOT7/wdKpJHlAFzWgKxX7u7OFTWi50uIbENWv2Y3SCJOyDIKNvHw3htEtNB0VbSRn2VyMktrPLhNMY7poYF++bA2KGmD/mvRA7ZXyQYqGAJc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FjtrY5TY; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FjtrY5TY"
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-2caced6038eso8505595ad.0
        for <virtualization@lists.linux.dev>; Mon, 17 Aug 2026 22:47:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787032075; x=1787636875; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=yeF5s/zx6+8hMLW6H+qKAJyqoTB1cdRg+gT9WgtCNI4=;
        b=FjtrY5TYOM143cR2N9GX7Q5Xxz4TWzGwQopDt9mk5QDZNQ/M8yI1LfKSN/+N4g3O2N
         HCQVJfv+pnRa7roJW+I5CLjh3p5syx9aTKdS0/2mKtiH5eUct0RS4IKp9zV0qBQ6Ko2H
         bPtXC0uwdRtHP3ghAKkJPP6DaokFPjFgFeeJQX945+PoFa6MvM8ZzwJxw1NtKHBiDX9s
         YSlRlUjk21jsYBUabjIngVh5EcbMGNfRFb33UGgmy/aABKCBs6fYxH/Kd0GaW3UCBpO+
         a+PMJy6PU0I9RptOQN8bjBt9nfTOfz7C8sPKMvLMXKo9PIlwP5qiDh7J1VJl/iyZF36Q
         WfqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787032075; x=1787636875;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=yeF5s/zx6+8hMLW6H+qKAJyqoTB1cdRg+gT9WgtCNI4=;
        b=Ufvo8ZfYUR1azmgXV6jBvcjw67EOLeMGvovVlOiv9nffws+awX6ymKqtizsmVOifQP
         yvp97zdvvtWXYFZDdlxDW57RygcCrOmUsUrXWuzQk+9l3ccA3q2vjAegG6eoXxBL+MFu
         2Ou3zHeyjWbAEnF3n6/3vJ8+Z/2VekOAxclXLyht5aKrBR+kRqZ8FrfCwmo99ImZhb7G
         crpJEivDuyRPtEfH9KXuNIxPatRb4I121YFmPmNQxZemwV2++4RjrpsZJqmZzJsoH9I7
         rhb10URP/Clw63sfa+P5Qra0HBAsYfqjHcAHT/M819E5+uE+ULYI5cQZkkPX8HdUnBxX
         z0mw==
X-Forwarded-Encrypted: i=1; AHgh+Rp20ikckoWsg4vf+Hg9kMMa2s5/1pI5B3l4sDIhGB2FcJKw+nI5FSN4bgpmtOyoqnUObZinvpwXuL48CDDG7g==@lists.linux.dev
X-Gm-Message-State: AOJu0YzYSd9qLnArxbL4CfI8pw0rlKiwL9GHvfLtF4vigBI4o5M3Od4B
	CsFitAscrIUpBkEvghZpnsyxKGDChMmHG/gqXxtVmsaXucMEvGNiMNTvAaaByQ/QjTB2kQ==
X-Gm-Gg: AR+sD13Pp79f8wgde1bYfLbBTLipmyZkRMlJ4jdseFZQVhRU5pcs8qaxPR7ZhBuDoHS
	MjS162i5TYGABFjdP0V3lymVO3hJIFS7q4ltCdUUB0ngwsKlxEvlf1yMlyAJsgu6aDKjkFwsKa7
	R2bzMe2G8iAyNXGGdCR4QUNDBD6gW/bz+IWC/wowtUqIUfCI5ff1qnMKXuD7uOCAGAz2dGK1S/A
	8nrZvC2dAA7PvkWhRV7qKjmd1Uowv+WyMfpZem9WdjVT21xikiW+Bh3JZVfo19osExlqyddTmRw
	LyqRYiigyh8UhUM5XjLgwUUjqVdRIljwdhtbwDagoNjeQQo3yIw8uPY4MdOuyQhtLoFGQbyHNLh
	mjv6TDeoNQTpaw68O3LvXLREriwmnyvy56/kszu8tvBql3K3+6f/kGNKVE2ZpR4mHLbvn0mfrEB
	EHfWRlQYUo88QFSNcXiQPct93cBEKrgVfWmiC5I4BPzNV0IbwhLHocsI29FP0L6d55WG8Q72Q9K
	eQ=
X-Received: by 2002:a17:902:e78e:b0:2c7:f5c6:c4a6 with SMTP id d9443c01a7336-2d5d149bafamr31963995ad.7.1787032074635;
        Mon, 17 Aug 2026 22:47:54 -0700 (PDT)
Received: from [127.0.1.1] ([188.253.126.51])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2d5bb514bacsm13097505ad.27.2026.08.17.22.47.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Aug 2026 22:47:54 -0700 (PDT)
From: Jia Jia <physicalmtea@gmail.com>
To: amit@kernel.org,
	mst@redhat.com,
	jasowangio@gmail.com
Cc: xuanzhuo@linux.alibaba.com,
	eperezma@redhat.com,
	gregkh@linuxfoundation.org,
	arnd@arndb.de,
	virtualization@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH] virtio_console: do not free control-out buffers on remove
Date: Tue, 18 Aug 2026 13:47:09 +0800
Message-Id: <20260818054709.282196-1-physicalmtea@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

__send_control_msg() publishes &portdev->cpkt as the control-out
virtqueue cookie. remove_vqs() walks every virtqueue and passes leftover
cookies to free_buf(), which treats them as struct port_buffer and
reads sgpages.

If a control message is still on c_ovq when the device is unbound,
free_buf() reads past the ports_device object.

KASAN reported the use through:

	free_buf
	remove_vqs
	virtcons_remove
	unbind_store

Drain c_ovq without freeing. The packet lives in portdev and is released
with it.

Fixes: a7a69ec0d8e4 ("virtio_console: free buffers after reset")
Cc: stable@vger.kernel.org
Signed-off-by: Jia Jia <physicalmtea@gmail.com>
---
 drivers/char/virtio_console.c | 20 +++++++++++++++++---
 1 file changed, 17 insertions(+), 3 deletions(-)

diff --git a/drivers/char/virtio_console.c b/drivers/char/virtio_console.c
index 9a33217c68d9..6e9bf064826e 100644
--- a/drivers/char/virtio_console.c
+++ b/drivers/char/virtio_console.c
@@ -1886,10 +1886,24 @@ static void remove_vqs(struct ports_device *portdev)
 
 	virtio_device_for_each_vq(portdev->vdev, vq) {
 		struct port_buffer *buf;
+		unsigned int len;
 
-		flush_bufs(vq, true);
-		while ((buf = virtqueue_detach_unused_buf(vq)))
-			free_buf(buf, true);
+		/*
+		 * c_ovq cookies are &portdev->cpkt, not port_buffer.
+		 * Detach them but do not free_buf().
+		 */
+		if (vq == portdev->c_ovq) {
+			spin_lock(&portdev->c_ovq_lock);
+			while (virtqueue_get_buf(vq, &len))
+				;
+			while (virtqueue_detach_unused_buf(vq))
+				;
+			spin_unlock(&portdev->c_ovq_lock);
+		} else {
+			flush_bufs(vq, true);
+			while ((buf = virtqueue_detach_unused_buf(vq)))
+				free_buf(buf, true);
+		}
 		cond_resched();
 	}
 	portdev->vdev->config->del_vqs(portdev->vdev);
-- 
2.34.1
