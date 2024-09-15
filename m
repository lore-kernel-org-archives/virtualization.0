Received: from mail-pg1-f171.google.com (mail-pg1-f171.google.com [209.85.215.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83C8B186A
	for <virtualization@lists.linux.dev>; Sun, 15 Sep 2024 01:36:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726364162; cv=none; b=ZLGIYjaOjl6T69I2lkZELwKgKEjzlLLItfHnZqyg4UcGBZue8q1nHFwee34nq13HFOQPLG9Vj4qN652XYyKlfJ9EtU8BbRgkX5MYVz1jHkjKcfBCh5tk0uL8YqEw+39SMpujsON3hGrluu+EAZU4MD22hDzWLiuv0o6HanA1Ry8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726364162; c=relaxed/simple;
	bh=6HK5vKJd1Pz6CMRoia/S7R29gEpWsJ/Mfdgnkw8NhNA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=sVUWb3MVDlnqdwdmxEhGAthpIJj/T/UlgLGbIvPQdbYpY344oWiQCn2eNzbkMyGtaQZ8DHDY+v4Op2ec/F3ZThCwpYUs2KULxkIHdHQCQ/fCi+7G/tkTuMK1HM8tSyoixayBfFUCmzRdmLEHH0mJhwuBFJi7cvo7UyHdVdqJu+M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=daynix.com; spf=none smtp.mailfrom=daynix.com; dkim=pass (2048-bit key) header.d=daynix-com.20230601.gappssmtp.com header.i=@daynix-com.20230601.gappssmtp.com header.b=BDgiozb+; arc=none smtp.client-ip=209.85.215.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=daynix.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=daynix.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=daynix-com.20230601.gappssmtp.com header.i=@daynix-com.20230601.gappssmtp.com header.b="BDgiozb+"
Received: by mail-pg1-f171.google.com with SMTP id 41be03b00d2f7-7cd8803fe0aso2409532a12.0
        for <virtualization@lists.linux.dev>; Sat, 14 Sep 2024 18:36:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1726364161; x=1726968961; darn=lists.linux.dev;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=w8tj/CMN+xcHivHKfSr03LNWcdWKGkoKc1aDHjXGCyk=;
        b=BDgiozb+w2m3NAwImySFNoEWJ3sLpxzN9nnEuCAxJyUkyv4pQVCMax8OcoVGFC2EsW
         V4eOCA9f2037FEj/HgccqJeuZNg6nVGsDm8Zxsaw4Cuc94svjyR4az9pUyqbGAME6w/q
         O8+06QR2K3zMwOXMn2fqGjJw2QXslYkY+7A3/sJEAM90Od4M9hVhuEYFxGF/ZMud6IDG
         VP4eu5jDMjV3vA/GZKOqu7LyOn8R0i4MouiCM3XhAa+4XUuT0S1qFuK7KgfSivybF1WL
         clIZLGClCxZY2WSpjx6/IGd1odcTnTZEkRR0OaT/IB5mmS167fWyr5NM4mNfnNMR0ZlC
         /+Vw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726364161; x=1726968961;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=w8tj/CMN+xcHivHKfSr03LNWcdWKGkoKc1aDHjXGCyk=;
        b=XX5WoExCRFaTpHCxRkX9Ph1VDFg4pK+Z9oOpu2Vw1KmWdLwgXvE8juyp4n2QyfWd3b
         1T8UFqI2n5VLbLLdh0+h3XmUMi+noqJ/amN0FcUtizZRPCSxa+lREZa3wM4AuqpKRtZg
         rG8HLhpWkwL9azWwivXnvnd4W4QJyI4regVvIUu0ySh2sfFAP2tcsIt4p0+uWwPC7Qrn
         yrW+rfH7GygOqZ47PYIgsvM3HTZ2x32EaiSoClONFWXVyftdAxFPp0be/Ibaqao//RbU
         kNB2P8UiRuNKqUh6XD0kzUF3R0l37MFjHz7jwjtSbLjuE/o02WE5pfw+NWmnCb/rsB4R
         ticA==
X-Forwarded-Encrypted: i=1; AJvYcCWgooWaC+zMdoTKa9dzLB7PxSCxYRpH+5Mn5evzAiZBXpSDEuvRqMpCIbafTMbXCNEzrtcNtV7Dr6bJ3tPhig==@lists.linux.dev
X-Gm-Message-State: AOJu0YwOrN0QRkU/pIPPPWnAfqfvPuTuzuEqXLmAfphK1euTC9BZsF2N
	wL5PFoBgJPe/2PhX/o8VUmZ1xzHkDGUCs2tCWq7oKowNWRElqjYQMd6+k6zIxZE=
X-Google-Smtp-Source: AGHT+IHOrSk7MZi+esiCMTfswJQ9NquBWUjlKkA2lu3eeEtyMYGJhosf6snJ4jwv1UvMxQMrmtnewA==
X-Received: by 2002:a17:902:e742:b0:206:a3a9:197c with SMTP id d9443c01a7336-2076e43d052mr172274795ad.49.1726364160775;
        Sat, 14 Sep 2024 18:36:00 -0700 (PDT)
Received: from localhost ([210.160.217.68])
        by smtp.gmail.com with UTF8SMTPSA id d9443c01a7336-20794605721sm14899215ad.111.2024.09.14.18.35.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 14 Sep 2024 18:36:00 -0700 (PDT)
From: Akihiko Odaki <akihiko.odaki@daynix.com>
Date: Sun, 15 Sep 2024 10:35:53 +0900
Subject: [PATCH] vhost/net: Set num_buffers for virtio 1.0
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240915-v1-v1-1-f10d2cb5e759@daynix.com>
X-B4-Tracking: v=1; b=H4sIAPg55mYC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDIxMDSwML3TJDXUuDtGQL47Q0iyQDSyWgwoKi1LTMCrAh0bG1tQAopLCnVAA
 AAA==
To: "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>, 
 =?utf-8?q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>
Cc: kvm@vger.kernel.org, virtualization@lists.linux.dev, 
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Akihiko Odaki <akihiko.odaki@daynix.com>
X-Mailer: b4 0.14-dev-fd6e3

The specification says the device MUST set num_buffers to 1 if
VIRTIO_NET_F_MRG_RXBUF has not been negotiated.

Fixes: 41e3e42108bc ("vhost/net: enable virtio 1.0")
Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
---
 drivers/vhost/net.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/vhost/net.c b/drivers/vhost/net.c
index f16279351db5..d4d97fa9cc8f 100644
--- a/drivers/vhost/net.c
+++ b/drivers/vhost/net.c
@@ -1107,6 +1107,7 @@ static void handle_rx(struct vhost_net *net)
 	size_t vhost_hlen, sock_hlen;
 	size_t vhost_len, sock_len;
 	bool busyloop_intr = false;
+	bool set_num_buffers;
 	struct socket *sock;
 	struct iov_iter fixup;
 	__virtio16 num_buffers;
@@ -1129,6 +1130,8 @@ static void handle_rx(struct vhost_net *net)
 	vq_log = unlikely(vhost_has_feature(vq, VHOST_F_LOG_ALL)) ?
 		vq->log : NULL;
 	mergeable = vhost_has_feature(vq, VIRTIO_NET_F_MRG_RXBUF);
+	set_num_buffers = mergeable ||
+			  vhost_has_feature(vq, VIRTIO_F_VERSION_1);
 
 	do {
 		sock_len = vhost_net_rx_peek_head_len(net, sock->sk,
@@ -1205,7 +1208,7 @@ static void handle_rx(struct vhost_net *net)
 		/* TODO: Should check and handle checksum. */
 
 		num_buffers = cpu_to_vhost16(vq, headcount);
-		if (likely(mergeable) &&
+		if (likely(set_num_buffers) &&
 		    copy_to_iter(&num_buffers, sizeof num_buffers,
 				 &fixup) != sizeof num_buffers) {
 			vq_err(vq, "Failed num_buffers write");

---
base-commit: 46a0057a5853cbdb58211c19e89ba7777dc6fd50
change-id: 20240908-v1-90fc83ff8b09

Best regards,
-- 
Akihiko Odaki <akihiko.odaki@daynix.com>

