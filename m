Received: from mail-pf1-f174.google.com (mail-pf1-f174.google.com [209.85.210.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 681E617A2F0
	for <virtualization@lists.linux.dev>; Sun, 15 Jun 2025 15:14:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750000489; cv=none; b=fTmIvVkBROagrnYRKS6AnWY795uJlbW6kGkoDuB0g5vQYS4QBGQ3rnV6+ChKRgQdX2BJTTrFdllF6PaOvI+5thQbal0QIDXoQ/i99o+04qqolAlHXLHf/Mw1p09xOYuSlJsrQQOcYddmUX/Ymo5FnRI43DSKQfWLLtcMzKGm+WQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750000489; c=relaxed/simple;
	bh=HVGg2b4dETfvRRMS1KObnnYIH8VqBEDJ75o3UiizCng=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=uB9h88+S4FvEhF1+WZfZedHho0DVrWzd6UQXu71fCW+MdiXq9yhY20w8A+gcacACxSWpHjO+hZC0k4/ntFQfFBNppX4WNwFoDHpUTn9CPCjKZa9Zgg2S92PbiiW+fnvddQXx/xlkPwT8jl0aU/J7aspF+Hpm0n4RKIdXj1ljfV4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jTxkCfZt; arc=none smtp.client-ip=209.85.210.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jTxkCfZt"
Received: by mail-pf1-f174.google.com with SMTP id d2e1a72fcca58-739b3fe7ce8so2832712b3a.0
        for <virtualization@lists.linux.dev>; Sun, 15 Jun 2025 08:14:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750000488; x=1750605288; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=q2XHfduxkI50goUmbRh0tLs3//lxjQzHdD0tvUgOrco=;
        b=jTxkCfZtuiDiuA0qBRjWHL3BX/GOnehDJRc0aUu3mGy095kchmyqqwxQxt5xVEZbqt
         HpQDdvl5PQ4+WfE/0uUvB494DAJp3beXukG0ukf6rZrxIG8PBH+5Zr4WSMZP6aqjl8v/
         gW9SwfALfmZ17zSrcUeALCCgH4maDgsAGKGBG8QFJq24FUflPHX+f+3VXS9F9FF4o6V7
         4dlNf4S97/3Xo80jWXx9/W4VLEsp0fP6HM/knVwkxpE/5yE9+MRE5CAlSbV5muG7IqJ9
         uBzmH/VrjCZogfovJkcZ0oNIOmpYMKyWd9ALh6eStbz1CrXUsXuz5gpfmhaYIhbk+2Tb
         x90w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750000488; x=1750605288;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=q2XHfduxkI50goUmbRh0tLs3//lxjQzHdD0tvUgOrco=;
        b=hdL9meO6H55iMBQXOKPAxNa6hQngxtU1tJYvRAPCbg8s4HZ9lWpTqKuVi7hTk5jjxZ
         32oxJEp7FWht25xFd6pOIsOgiLSdYfaBRR0M7kJi5ibeyIRkB+0LnmmnifNnSBtgXWKh
         JESi9PPiqpD6Jj3pgDJ4JRpdUjyfFYddoxx9wmAun0kCGaCm0AXAhkOl74X0owl1MnfN
         ZhVM6+cCZo9dmVFCheDHzAzzGh/I45/7EGAMZGsqjk327QjLnqbV4RTCuhH4tz/mE116
         ED8qry231Td72vO8XFlKNJHCGlQgQ5O00TI3JrqezX3vs3uqG35PPUT5VcS3c5qtMEFN
         z4oQ==
X-Forwarded-Encrypted: i=1; AJvYcCVNexpZ+JSSF6bhhDggh19AfQp1m2zf9QQNLGMsaSE/SzirNagT63xnf0LCap0owdOB9fghUiisy8XXfPZTPA==@lists.linux.dev
X-Gm-Message-State: AOJu0YwbpoEaiJuYUhkLBwO99A6Xjna4H/m0bHxGnwm+q96VQcUo1mQ8
	AWv0wLfsBmAWdePOORbzying52nqqvW3eSrPmaEm8w15Lcyj5Vzv90qJ
X-Gm-Gg: ASbGncveqOZaTYF3Kp7eGVq1OsOdbwf+GmP4bAjOdBhot/8B4vR5MzgCDJeyArXTHME
	zcm9hpgoYG7myg7JRTSJb4jDh+uh7Sswv5tF9P2xvy+edMnKfRzxDvZJbw/juNFnHsiJ/T5Ytgv
	32v6wf3H8nC5ChgA9B9UmxrUY+lw1YsNTBX9y67WFAEFSH9YZthPrIhu7jQ/2BSJn6LF8fHRqao
	O01uXvmhKf6RNeWMcP4CHpIAo9caxnlTtBplMRwsOfYVtXY+/j6CJXDFw837OH+w60VSlygzkwY
	hANxOADkeXsU8HAWM7r33KUZCEc3gZjSY8pghDzNhkx9zZuHMAOro9piNZiSK+rk07Dv2IJsI5h
	bPg==
X-Google-Smtp-Source: AGHT+IGq1OjC4mhUydkSvko7Z0RIr7FJnfDd6BfxHT+hxc75Ge2cUYCLom9mvffce4tass46LGxFYg==
X-Received: by 2002:a05:6a00:b8b:b0:747:b043:41e5 with SMTP id d2e1a72fcca58-7489cfc785cmr9029961b3a.16.1750000487602;
        Sun, 15 Jun 2025 08:14:47 -0700 (PDT)
Received: from minh.192.168.1.1 ([2001:ee0:4f0e:fb30:482b:a929:1381:df12])
        by smtp.googlemail.com with ESMTPSA id d2e1a72fcca58-748900b219csm4950022b3a.129.2025.06.15.08.14.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 15 Jun 2025 08:14:47 -0700 (PDT)
From: Bui Quang Minh <minhquangbui99@gmail.com>
To: netdev@vger.kernel.org
Cc: "Michael S. Tsirkin" <mst@redhat.com>,
	Jason Wang <jasowang@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	=?UTF-8?q?Eugenio=20P=C3=A9rez?= <eperezma@redhat.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Jesper Dangaard Brouer <hawk@kernel.org>,
	John Fastabend <john.fastabend@gmail.com>,
	virtualization@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	bpf@vger.kernel.org,
	Bui Quang Minh <minhquangbui99@gmail.com>
Subject: [PATCH net 2/2] virtio-net: xsk: rx: move the xdp->data adjustment to buf_to_xdp()
Date: Sun, 15 Jun 2025 22:13:33 +0700
Message-ID: <20250615151333.10644-3-minhquangbui99@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250615151333.10644-1-minhquangbui99@gmail.com>
References: <20250615151333.10644-1-minhquangbui99@gmail.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This commit does not do any functional changes. It moves xdp->data
adjustment for buffer other than first buffer to buf_to_xdp() helper so
that the xdp_buff adjustment does not scatter over different functions.

Signed-off-by: Bui Quang Minh <minhquangbui99@gmail.com>
---
 drivers/net/virtio_net.c | 16 ++++++++++++++--
 1 file changed, 14 insertions(+), 2 deletions(-)

diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
index 7c9cf5ed1827..678502aefddd 100644
--- a/drivers/net/virtio_net.c
+++ b/drivers/net/virtio_net.c
@@ -1167,7 +1167,19 @@ static struct xdp_buff *buf_to_xdp(struct virtnet_info *vi,
 		return NULL;
 	}
 
-	xsk_buff_set_size(xdp, len);
+	if (first_buf) {
+		xsk_buff_set_size(xdp, len);
+	} else {
+		/* This is the same as xsk_buff_set_size but with the adjusted
+		 * xdp->data.
+		 */
+		xdp->data = xdp->data_hard_start + XDP_PACKET_HEADROOM;
+		xdp->data -= vi->hdr_len;
+		xdp->data_meta = xdp->data;
+		xdp->data_end = xdp->data + len;
+		xdp->flags = 0;
+	}
+
 	xsk_buff_dma_sync_for_cpu(xdp);
 
 	return xdp;
@@ -1292,7 +1304,7 @@ static int xsk_append_merge_buffer(struct virtnet_info *vi,
 			goto err;
 		}
 
-		memcpy(buf, xdp->data - vi->hdr_len, len);
+		memcpy(buf, xdp->data, len);
 
 		xsk_buff_free(xdp);
 
-- 
2.43.0

