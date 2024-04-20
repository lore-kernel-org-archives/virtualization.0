Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF6CD134BF
	for <virtualization@lists.linux.dev>; Sat, 20 Apr 2024 08:57:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713603479; cv=none; b=pIjsQwcxrZv5XgOIdPsEvGXq0njPkZbptHJbIBtw/DnE7EY0zjh7GRmdXRfKX9dmH6ZhljQOCNkF9ziPY7y9f7Us6UZ0Vu2zXHi3AU94UFOVk2wvFgs4oLSEfNFWkiu4t5z/zyD3nQnFICmKgA9/YeV4KB3OmRxl5JzxHs8hZE8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713603479; c=relaxed/simple;
	bh=9SRG5NGgAQWbJ7b1PO89EyFuba/zQaF5gPA0aAKRqE8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=fIpHTkuyXmnniU7Eplz6hst4HJoCihmLUKjbikA/o0zT5gSBbdBd9n8maNqtwWyuqUvWSqdeJoqeWy46u5agdAI9Gro4mIBFA4TVx2osW+7TXf7qwZzlvDyXCp2nI5qdl5LiZrii7kqt2JFzSEG33ccwdsOpSLAegUPERT3fwo4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RQn/33wg; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RQn/33wg"
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-1e0bec01232so22977205ad.3
        for <virtualization@lists.linux.dev>; Sat, 20 Apr 2024 01:57:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713603477; x=1714208277; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=48Iq+30cR26jwufNHZ2YfXYM/ol31EjO7UuID9EN8+c=;
        b=RQn/33wgzWdQefV+wTn7+HCRb6nHzKotJIOBpAyCXg3dwssstCkYDL7umfJif3KZSF
         xKlkJNIFNrVfNr6ktq+QrB944kNV2ERkfB9ql4wBKfzHzdeynMprQnLKx3K3BqVBIwwQ
         CJ7E/ACgvCLLGl+DVmtYGdzQpmegELxYe+88u8MZ5DhvIHGQWz80s3Lkdv2dSqRCCtDc
         VpHx6mTWRJurIXTnDEabD32x+fv4hkGMjpQ/sqtaSNrCp2Y51pe88FG6PZqzjwnuVLAu
         Qtki542fbW9WuKgrorlahfF4h6/5tE+wuEBtW5Zc77e8cDx0KddLASA0sms/kGdHBm5i
         Lyfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713603477; x=1714208277;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=48Iq+30cR26jwufNHZ2YfXYM/ol31EjO7UuID9EN8+c=;
        b=iseAJpUrlevqV8aW7+lfFwttVV3TCYz6oFjQ2yVt/o0nax4wg/l7rcSi3FwVpBXqdJ
         BqpPyxraZFeRWakOqOLARuF9mk+m85gWZ7IkslS9EUxdthNCDZosnK4uXoi7XXohXMyY
         o/LVMAzECNpOJXCBEntNg48BfNSBSyb4KCIAoj6RQU64RB1ePtj8jynM35VgdTnqYNHT
         v9GUz6g6V3cTimw4nC06U4fMMttUOLF1RoQ5U4tlHB7UcJ5KDCAFkVaHkunW/T4+Vc+t
         yUn2aBN1ex8ITIvBCr2CYVHnuol+t80qwypnOYXaakrfkTrt1ASxYYqZmi9oEvp2CtyR
         YF0Q==
X-Forwarded-Encrypted: i=1; AJvYcCUhzr3L24vBfbdEkmuBmNNjGD/t4qDtxXwLZS0JqJL4Q3vzJauFJ8J2umRUCRE5IlJxqFLROjLaG4qrUiQlI0oc5rGU3c6lDTbdoqtFvJA=
X-Gm-Message-State: AOJu0YyqxSNbPGiIr/cqNCwKQzidgDfT/oLQ5GYJCCfZbAGXRxU8ynkW
	DGjAQiJkmisb0xXIaVhhp+jTZeeoh2HuWNtTgj0osCU5fEgvg4A5
X-Google-Smtp-Source: AGHT+IG8EU9aw+RsorFWmCwNnDqhjyjrO+DrkR5PkJw3blIHTNDCMPTP7m8lFUkodGAIDAyljL2Ckw==
X-Received: by 2002:a17:903:191:b0:1e4:4125:806f with SMTP id z17-20020a170903019100b001e44125806fmr5617293plg.11.1713603477162;
        Sat, 20 Apr 2024 01:57:57 -0700 (PDT)
Received: from kernelexploit-virtual-machine.localdomain ([121.185.186.233])
        by smtp.gmail.com with ESMTPSA id mp6-20020a170902fd0600b001e256cb48f7sm4653132plb.197.2024.04.20.01.57.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 20 Apr 2024 01:57:56 -0700 (PDT)
From: Jeongjun Park <aha310510@gmail.com>
To: syzbot+6c21aeb59d0e82eb2782@syzkaller.appspotmail.com
Cc: stefanha@redhat.com,
	sgarzare@redhat.com,
	mst@redhat.com,
	jasowang@redhat.com,
	kvm@vger.kernel.org,
	virtualization@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	syzkaller-bugs@googlegroups.com,
	Jeongjun Park <aha310510@gmail.com>
Subject: [PATCH virt] virt: fix uninit-value in vhost_vsock_dev_open
Date: Sat, 20 Apr 2024 17:57:50 +0900
Message-Id: <20240420085750.64274-1-aha310510@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <000000000000be4e1c06166fdc85@google.com>
References: <000000000000be4e1c06166fdc85@google.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Change vhost_vsock_dev_open() to use kvzalloc() instead of kvmalloc()
to avoid uninit state.

Reported-by: syzbot+6c21aeb59d0e82eb2782@syzkaller.appspotmail.com
Fixes: dcda9b04713c ("mm, tree wide: replace __GFP_REPEAT by __GFP_RETRY_MAYFAIL with more useful semantic")
Signed-off-by: Jeongjun Park <aha310510@gmail.com>
---
 drivers/vhost/vsock.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/vhost/vsock.c b/drivers/vhost/vsock.c
index ec20ecff85c7..652ef97a444b 100644
--- a/drivers/vhost/vsock.c
+++ b/drivers/vhost/vsock.c
@@ -656,7 +656,7 @@ static int vhost_vsock_dev_open(struct inode *inode, struct file *file)
 	/* This struct is large and allocation could fail, fall back to vmalloc
 	 * if there is no other way.
 	 */
-	vsock = kvmalloc(sizeof(*vsock), GFP_KERNEL | __GFP_RETRY_MAYFAIL);
+	vsock = kvzalloc(sizeof(*vsock), GFP_KERNEL | __GFP_RETRY_MAYFAIL);
 	if (!vsock)
 		return -ENOMEM;
 
-- 
2.34.1
