Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A7682DC331
	for <virtualization@lists.linux.dev>; Fri,  3 Apr 2026 09:32:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775208781; cv=none; b=gj7KrxxAuT1oxjrBtjLIaXYFhi9pxjrmZu24MqKDAlhDJu3hqfrejSl3Ii2+V9GAAZabMrer6P1PQJwEu37W5Fc5Wbg+2LSOqkiHpIcRRN3/XNr+UrKdGX7g23UQ4ARgWeIKXtU2oI/Ig45UROHKSZVf8GVHq6tD/69e3lpWbys=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775208781; c=relaxed/simple;
	bh=cv1n3+Y6D+oKSnZC7Rf2LuWBrgJHOPCt+mhyNABBrEQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:content-type; b=NOS9ouap6Dd+9vCj7NA6ZhRZCA7mgYNXpSDZ1muLznJiSeTTLBwMib2FndIK/7rfYxMUr2XJJgbh2zlAwOU4oeTRuNzizpATHjyh0v96Ws+XM9Yn+OLS0KdyydmeAEsUn1g9k++fiRR08ulG63yw05czM1vdg0OcdO7Vsq4WF6Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=BHxdMRUQ; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="BHxdMRUQ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1775208777;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=OlhvOOy7p63KXaOzp0l12f0csTlzcyaDpAiq+n8anCo=;
	b=BHxdMRUQlF+j18Yx8M0UKuoxdIXKOHPEBsvyUe/HeohGRIQ8KdHhWOqCiW6s4XYlj8SsKq
	EwZrpV991QQXDqxIvdSLS9rvTGv1i9dfHgxJx7kUc2ms5t1eNAGt1Am+Ox2EWV49PABa46
	S9Ow/Dn7Zt+7qP1usQO8l2Lp/TYnSNI=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-694-efWuDHIGM9e946k1hufJ2Q-1; Fri, 03 Apr 2026 05:32:56 -0400
X-MC-Unique: efWuDHIGM9e946k1hufJ2Q-1
X-Mimecast-MFC-AGG-ID: efWuDHIGM9e946k1hufJ2Q_1775208774
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-4887d32788bso14009545e9.0
        for <virtualization@lists.linux.dev>; Fri, 03 Apr 2026 02:32:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775208774; x=1775813574;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OlhvOOy7p63KXaOzp0l12f0csTlzcyaDpAiq+n8anCo=;
        b=o/TLhQatmENMR/o31vZJzxkEu417uo8xHnG/ZCRtll1CiHOAtRc0P34bRDzuGry3y7
         fn6EO6XHLbKD9mTvxwF3K1nfXn34tFP/CJ3eQ2s4HLmLglmK4LDUWNrbbKmG76pD5oop
         lgn2smu3azzsBL9W8F+TPpjmKvBuUSlP/8MNEkAhXd3QRw2Fu0aQlPGemHAb7NjRkm5B
         WfRxMSzJ+2LqNh/LHZExy8woAyGE5Q6e5VVfgBNX9tegtor8Ne4oWovhADyBMYMe8gtD
         KlGWXDTV84DHMCteIs+RXj3sPbZuWVFaCIWYOxEVkDOL00yCa2sml4EzDKMRPXXFdrUd
         9I7A==
X-Forwarded-Encrypted: i=1; AJvYcCXbDt5gDofwT1alC/9Ny7vEohdOtHM8Xtgeoslx0R6TxRGCSr99sutuAU68lnTt2+8wsEyrXfuPWupo4PnvXg==@lists.linux.dev
X-Gm-Message-State: AOJu0Yxl0sfXAxSCBtd8CAnHHhrOTMWj9unZcOxlZelR7RDCN63mjLWt
	CRsUQvHqHyJduU8M17JxnO57MnOzNjUfoYuZ/Ln/+s3HqFKAv47RLjo3eHE39LUP3CQ4ZuYbp2y
	4+/xgsJNjdvnNyp2tWuwd7IKNqDPuKa1sf8uWb1ULkotkcTd1hYGvfW2snq2W0X6nOVSd
X-Gm-Gg: ATEYQzy7j+8gdk7J/208/nB3guk0gFCqZzCPbn97EjKY4viS4+5swYPaZOgRRZYjf1W
	VT7Q9PO19lYZf1ATXG6Nn8G9YDfWhYTaabhtkPzImbNxLmBsJ9cGipkUNzcmk/MFdTZf4EphkoB
	/G11J/MqDDnD7FY1lUb1lkBQ2yPrOLXA6SL5NUjIu5Saup0/rSvpipoYd6kOzyMlKPC1C31DEFh
	1tLEhoJS60sfVgTMqgIDQfaqMBzo62VRneQtPEC6QV+lnkiXxUwfdrKd18J/UuN/BhMftGVS8Ky
	pMwTXYbCPB4xKnfXnkZBRaKj4HJJboA5vvqddvn9yv4dZNcK6UufcvJSJIXzzhpF2O+3LG6lsmy
	/Iejx2dG2eXzAO1pYHz1ixiCVuEFp5ElSpFRE66l/2UeEfpi3lpHxLNXOG97dzIE=
X-Received: by 2002:a05:600c:1d86:b0:480:1d0b:2d32 with SMTP id 5b1f17b1804b1-48899719a00mr32512475e9.12.1775208774411;
        Fri, 03 Apr 2026 02:32:54 -0700 (PDT)
X-Received: by 2002:a05:600c:1d86:b0:480:1d0b:2d32 with SMTP id 5b1f17b1804b1-48899719a00mr32512075e9.12.1775208773785;
        Fri, 03 Apr 2026 02:32:53 -0700 (PDT)
Received: from stex1 (host-87-12-139-105.business.telecomitalia.it. [87.12.139.105])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4888a65635fsm132198625e9.6.2026.04.03.02.32.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Apr 2026 02:32:52 -0700 (PDT)
From: Stefano Garzarella <sgarzare@redhat.com>
To: netdev@vger.kernel.org
Cc: "David S. Miller" <davem@davemloft.net>,
	Arseniy Krasnov <avkrasnov@salutedevices.com>,
	linux-kernel@vger.kernel.org,
	Stefano Garzarella <sgarzare@redhat.com>,
	virtualization@lists.linux.dev
Subject: [PATCH net] vsock/test: fix send_buf()/recv_buf() EINTR handling
Date: Fri,  3 Apr 2026 11:32:51 +0200
Message-ID: <20260403093251.30662-1-sgarzare@redhat.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: xmAR1PsM0ridIuM9ZaA40cK5eUvtwkIF9JBjuZFErXs_1775208774
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
content-type: text/plain; charset="US-ASCII"; x-default=true

From: Stefano Garzarella <sgarzare@redhat.com>

When send() or recv() returns -1 with errno == EINTR, the code skips
the break but still adds the return value to nwritten/nread, making it
decrease by 1. This leads to wrong buffer offsets and wrong bytes count.

Fix it by explicitly continuing the loop on EINTR, so the return value
is only added when it is positive.

Fixes: a8ed71a27ef5 ("vsock/test: add recv_buf() utility function")
Fixes: 12329bd51fdc ("vsock/test: add send_buf() utility function")
Signed-off-by: Stefano Garzarella <sgarzare@redhat.com>
---
 tools/testing/vsock/util.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/tools/testing/vsock/util.c b/tools/testing/vsock/util.c
index 9430ef5b8bc3..1fe1338c79cd 100644
--- a/tools/testing/vsock/util.c
+++ b/tools/testing/vsock/util.c
@@ -344,7 +344,9 @@ void send_buf(int fd, const void *buf, size_t len, int flags,
 		ret = send(fd, buf + nwritten, len - nwritten, flags);
 		timeout_check("send");
 
-		if (ret == 0 || (ret < 0 && errno != EINTR))
+		if (ret < 0 && errno == EINTR)
+			continue;
+		if (ret <= 0)
 			break;
 
 		nwritten += ret;
@@ -396,7 +398,9 @@ void recv_buf(int fd, void *buf, size_t len, int flags, ssize_t expected_ret)
 		ret = recv(fd, buf + nread, len - nread, flags);
 		timeout_check("recv");
 
-		if (ret == 0 || (ret < 0 && errno != EINTR))
+		if (ret < 0 && errno == EINTR)
+			continue;
+		if (ret <= 0)
 			break;
 
 		nread += ret;
-- 
2.53.0

