Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com [209.85.218.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11C7D367F45
	for <virtualization@lists.linux.dev>; Wed, 15 Jul 2026 14:23:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784125436; cv=none; b=s6c9WIrJVEnGWWatythZrt20yMLBosefBQu9ACOE+d1669F9vWI4Lyxl8CwMveLESlUW/ETr0m7LdxL08ShCch4ww7cPN13lteqI4Hz18Y9BMntoyJ/9OXm2I7HKBJknRPJyShk1wYahsQLDm5R7XhiB968Kcllxp6x2VkKltmM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784125436; c=relaxed/simple;
	bh=8X6+CQq3Hs1h/DFamxBzRSZL9Lbvylt2J3qL223C0to=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jPwHx71wIXN0tA08NGg/j6DQajddua7v7HV0+ZSaGjYo5NZ8SMns/rf9/cqdYkB9wVcGR8A0ddK9UHPpKJMybU9muii9j3wVkbD4d+nw3gcqq6ObeYVdkmNZJy9N0JhTYo4ROoCUqBbbFE78ZqNY4EI6d4ZbKDQoTegB566+a0M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=pg3fXCeB; arc=none smtp.client-ip=209.85.218.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pg3fXCeB"
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-c15d3cd51b2so647525466b.3
        for <virtualization@lists.linux.dev>; Wed, 15 Jul 2026 07:23:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784125431; x=1784730231; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=XBjSAX2B0WW1W8im1PxsWC01gxxXxQM2EqUc+55Cths=;
        b=pg3fXCeBDWlxdfx0ZvzNzA7IWRi2s/9Xu5+6ThzZumaAW0XUPq/1qPJDaDnmKrmyKS
         6n89sRYw3IMd0BiWbyDnzn1bIXt7aXaDEY0jHlTav+hmv3RNm5k/28micTmXrUq8+ijt
         OHENFv9bNA9uXcBG7rZDbcUavnmQcAr6gb/hy72+uZzAQzehibyBnOtRxmtQf5FxWknq
         fSp+hfiqExObdhELZLm0ZvqKq/CkXj2JKuk3tNB3H8YjcrMnn5eLNJNkzZWSTEEx6QmF
         eXGE5MAXRM10W4uIb67FV1a7xVK7zSKDUZRHR7/+isdiwg4Vt1zNJxe317xU6vpXEeGr
         wzmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784125431; x=1784730231;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=XBjSAX2B0WW1W8im1PxsWC01gxxXxQM2EqUc+55Cths=;
        b=QKtnmoexfvSwKXLx2ZkHXOY6Y09Bk5dBTi2aVhILt87DHP2+sIs1/idoVRyJpBT+Ju
         7bGHKgVhPMOio2YNHW01v9ZGmNoyRBA6FLLuygJQyrIwqutjm3zbuWNgvktWYkcWM365
         QsSfbeASxPW/2aEWQ+Qb1rVHXAiFXVHaO/QSvdytpRPjxHml72ujD0sWON0HZNKWKlM8
         X8H2yHz9h54jslvmGb9B2Ayj82WsCyNXGwi3Bn/Z5ZFzNyHVLyOAx67aV7iDRJTHMVBR
         Tyq3PHzaIdVNnHyFIMRT2sU9l84aqBJKeZ+X44yrZu3oCxlhCpbFikh8sYmunHNLwr4g
         suLg==
X-Forwarded-Encrypted: i=1; AHgh+RpeabfcWOJxp0BJ5UBl3q0FNzUu+SyxlyWyuaGPra8fpzbB9XsRVRG3gBcswyJgCjdlIgGTmfUQX+LIcTf6Yg==@lists.linux.dev
X-Gm-Message-State: AOJu0YzpnAb4CWpafdMqSbIZw30b/0TwCQIDIcAVjQbH1iXhnifnlOmX
	dn7YtXCrp3WFZdvlhE0ILfKEoICHf+e3GfdDJ7oPONYuc0pcXG0XiOTk
X-Gm-Gg: AfdE7clb0Tq9O30gvdtxxXG+amknFoFp3Mt02VqhN5xz000idAwBKoFaoeR9TPFisdX
	HMhD56aGqSsFiZua0ecBgC4bcYdVbEzIszygJrqYBRcT1L6fYZqljGMaCGj1DCuo8oO4ibfrFzl
	KRlNTSq5I2UrfYV6+kH4bIHzgpujz0SeSkkLWUFFPMzgU6As2h1uYuUTjRYMG5m0S7Szi1VjuTw
	WSd1HM7yK7OMuIc3GihneXuNoso+3K5FWumuXRtovobQ24TCPg2eRek7lT5GWM6wDIvUbaSrNtw
	Aqx4ycAqq9+36Oi1XRHFcCwki2g/BQ9Abnnc9qPiVCpfdcHTCSCdHZ8KuuAJbh/NxK+r8Ns1Bpt
	iLOtMQK5xWqJZPzf5j4R/ado+PuWR5+MHWaVpS1H1roY71PgHkv6NApIe8qBZprMZQnDROwLiUp
	ag7EOcl/5ozNLDxjdbLHDGJsaXA1XJMBmOaPK7jMUZKKTAT3c7z+Ft+5SRX16sUNJEIxHes2yIf
	iWz
X-Received: by 2002:a17:907:3e9f:b0:c12:7b74:7812 with SMTP id a640c23a62f3a-c1679533edcmr210683766b.59.1784125431131;
        Wed, 15 Jul 2026 07:23:51 -0700 (PDT)
Received: from misharu.home (2a02-a463-a071-0-8f3f-3afb-28f6-19c0.fixed6.kpn.net. [2a02:a463:a071:0:8f3f:3afb:28f6:19c0])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c168744bd40sm38743766b.43.2026.07.15.07.23.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Jul 2026 07:23:50 -0700 (PDT)
From: Hari Mishal <harimishal1@gmail.com>
To: Amit Shah <amit@kernel.org>,
	Arnd Bergmann <arnd@arndb.de>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Gerd Hoffmann <kraxel@redhat.com>,
	"Michael S . Tsirkin" <mst@redhat.com>,
	Jason Wang <jasowangio@gmail.com>,
	David Hildenbrand <david@kernel.org>,
	Henrik Rydberg <rydberg@bitmath.org>
Cc: Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	=?UTF-8?q?Eugenio=20P=C3=A9rez?= <eperezma@redhat.com>,
	virtualization@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-input@vger.kernel.org,
	Hari Mishal <harimishal1@gmail.com>
Subject: [PATCH 3/4] virtio_console: avoid NULL portdev dereference in in_intr()
Date: Wed, 15 Jul 2026 16:22:42 +0200
Message-ID: <20260715142337.22811-4-harimishal1@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260715142337.22811-1-harimishal1@gmail.com>
References: <20260715142337.22811-1-harimishal1@gmail.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

A port's virtqueue is not torn down immediately if the port itself is
hot-unplugged (unplug_port() only nulls port->portdev; the vq
callback stays registered until the whole device is removed).
If in_intr() fires for a port in that window it dereferences
port->portdev->vdev via is_rproc_serial(), crashing on the NULL
portdev.

Bail out early when portdev has already been cleared.

Assisted-by: gkh_clanker:t1000
Signed-off-by: Hari Mishal <harimishal1@gmail.com>
---
 drivers/char/virtio_console.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/char/virtio_console.c b/drivers/char/virtio_console.c
index 198b97314168..faef362dae85 100644
--- a/drivers/char/virtio_console.c
+++ b/drivers/char/virtio_console.c
@@ -1720,6 +1720,11 @@ static void in_intr(struct virtqueue *vq)
 	}
 
 	spin_lock_irqsave(&port->inbuf_lock, flags);
+	if (!port->portdev) {
+		/* Port is being unplugged, ignore further data. */
+		spin_unlock_irqrestore(&port->inbuf_lock, flags);
+		return;
+	}
 	port->inbuf = get_inbuf(port);
 
 	/*
-- 
2.43.0

