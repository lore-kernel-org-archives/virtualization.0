Received: from mail-pj1-f48.google.com (mail-pj1-f48.google.com [209.85.216.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 198AB3E1690
	for <virtualization@lists.linux.dev>; Fri, 14 Aug 2026 07:29:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786692575; cv=none; b=cuV5jjruGRG5QpWcz86ubfMsY4pyYBEGlMbcyCZPWryE6OTZ/KKs51K5qVy+y8mwTUBSfvnRSLMp2VVDsZr4+3hkktf5oBJKlDtN1OFaoCl4/EtMp9389o6RUL+4+9C2Cg0fRLjRHmxLyuIQVpl1vawOE0tbSS72sMMRbxfsaSo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786692575; c=relaxed/simple;
	bh=lBg0JhbsnNpsGb1wruN50IIhyCn8WZ0eKcALPJXFHwc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=b7ovQ4dCd9XH4XKmS/1pCDXu39QTTxZ5mfn1a/Y4dTvkBeAn2bP0+IoF1Pjabzmlo15CgtuGQSXYbst/lQbIAmXkRWIglGM0ysy7XzFI3SnH4A5l4KxEo8uubt/Pl7Rr8b5DctKT4FWBd9yZsNrLONM+ndwmzpg4pLwZJmYdneQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=X4YkF9W5; arc=none smtp.client-ip=209.85.216.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="X4YkF9W5"
Received: by mail-pj1-f48.google.com with SMTP id 98e67ed59e1d1-381b831d535so1028278a91.0
        for <virtualization@lists.linux.dev>; Fri, 14 Aug 2026 00:29:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786692569; x=1787297369; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=sb2mcYm1zw8ztLxWQHXttWOsqNChoxNNVKIkbMFY0ww=;
        b=X4YkF9W576zvfumxWMWYXgl33VN9BoNUgSyJ1rDJlDSnanDDHMqVmXVwEOwBe45aeq
         LGcg7LQgZvVdottUEjj5KXpaMRJqYfbKq173M3YkNAftCI9qFkDiF7p91MWswSUiqRYW
         2Rw2UUcWha1uQsB0ynv9ap32GnyzPN7/rY4sXroZfvwOZFRp5n8Vqpq9ctDpXl5J2ktw
         tggddwOUhr7oMfBvEhHEXD/y+56PhNFKu2Dw/Laby9Fg1Wz7t56QOsGiii2pANasU3we
         yQ1RqrSF5MAdlV2CaQ2nHxlhK+ARKJH7bpYdweMDTGJm/t+AbUBIsc21zD5OEMDqROaP
         dobw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786692569; x=1787297369;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=sb2mcYm1zw8ztLxWQHXttWOsqNChoxNNVKIkbMFY0ww=;
        b=WVglu4UNBwbtNej5C5zytATK57uno4WwLL0uudm1d86bER5ajOTbmi3MKgSmKhrOeM
         YL0xJNfppKcRMJoVKj/A4uaevC6C1fnPgyRXJ3EglnLfG9BV59INjwYbXiy9/znTPqfO
         SXIE6JrL9C87Zm+cffWB5KbaqlfdofID+V4WaAiWJ3a2reVdrJvLSdTwzRAdoB1M3X7x
         VkUUBl+LEU+E9RMpxEZ/MYQGmtmEJcab7xBcY2EACuxhILw83gAO0/X1nbxKB797hj7U
         LYBHlLFkstH+Qe0fOihKV+wbY+xjgzPhE4r/Ntg/m8wzbXAopoxQ8U8DJxHT9P3Cb/7y
         GG4A==
X-Forwarded-Encrypted: i=1; AHgh+Ro0t4TlKpEGQXKazgVvPaguYCLA1tFSdr9Gia4lBLvsJVN3zaqKk6AFP96eZKNqXUP0ro2sEKOaOP68lJ8uVQ==@lists.linux.dev
X-Gm-Message-State: AOJu0YxhbMmo/Q3u8v4/QzDi+WE/DB+wwPAsgxBygjMu4IEq7wLo0K+t
	eJL2ONsJAZWz3XkRb3A36GWBmDVRyf/71RKY82izEgHwM/KETqZcjdhi
X-Gm-Gg: AR+sD11UJkDIub1IdgRzY2C0ry7b9AgCUOmtWUBQ9NJ6lolnJSO3F+R/ne1lYFshyrg
	/teVz+IOu4XH6FwnGPCE7cs19Yv2W7q6exhZWX6XM49IpVIenRPfHVngO6oZBb+1ZjARwnfr5s4
	5oPT/uBzPKjZGAtgeTsyPwxq9I5dEtmsnwDO9ULl8NW7hR9eOaMrknTULjXcfFe7qaVmNUlnhR1
	+EfzPMbj0tiSQIRw2+F7aSmgiAxEZbPbgF1f70mDU38iqOIF10OlNx/MdzWey6tye5qsRfDVe1x
	o2aSWECVW8qY3T6rZR4dlKYVKvcnsCVM/vAoTiFzO8z/MKDIRGKYIzjlMmANtn3T+/xbIxZXJ7g
	67bd05D3xdIZ1wVV6CRx/Hy8VVhXZfN+qmh1o9AajTMj+VhKFtBulq4y9c6Q3O2eRz0i9Ye54V8
	8sRr0TzOgUArlUdlSwk4O5GIpHbyaFxuJ/5E5b+dNVLgvTE762YFMgvta+Lpn9IR8=
X-Received: by 2002:a17:90b:520d:b0:38f:5801:cd76 with SMTP id 98e67ed59e1d1-3933b6d0171mr4528637a91.3.1786692568692;
        Fri, 14 Aug 2026 00:29:28 -0700 (PDT)
Received: from [127.0.1.1] ([188.253.12.32])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-394ebb888e3sm1388828a91.11.2026.08.14.00.29.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Aug 2026 00:29:28 -0700 (PDT)
From: Jia Jia <physicalmtea@gmail.com>
To: Stefan Hajnoczi <stefanha@redhat.com>,
	Stefano Garzarella <sgarzare@redhat.com>,
	"Michael S . Tsirkin" <mst@redhat.com>,
	Jason Wang <jasowangio@gmail.com>
Cc: =?UTF-8?q?Eugenio=20P=C3=A9rez?= <eperezma@redhat.com>,
	kvm@vger.kernel.org,
	virtualization@lists.linux.dev,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v4 3/3] vhost/vsock: keep IOTLB across feature updates
Date: Fri, 14 Aug 2026 15:29:03 +0800
Message-Id: <20260814072903.124991-4-physicalmtea@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260814072903.124991-1-physicalmtea@gmail.com>
References: <20260814072903.124991-1-physicalmtea@gmail.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

VHOST_SET_FEATURES is also used to update logging while a device is
running. When ACCESS_PLATFORM stays enabled, allocating a new empty
IOTLB on every call drops valid translations and forces avoidable
misses.

Initialize the device IOTLB only when one does not already exist.

Fixes: e13a6915a03f ("vhost/vsock: add IOTLB API support")
Signed-off-by: Jia Jia <physicalmtea@gmail.com>
---
 drivers/vhost/vsock.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/vhost/vsock.c b/drivers/vhost/vsock.c
index b69c260eaeff..9142fa1143b2 100644
--- a/drivers/vhost/vsock.c
+++ b/drivers/vhost/vsock.c
@@ -869,6 +869,7 @@ static int vhost_vsock_set_features(struct vhost_vsock *vsock, u64 features)
 	    vsock->dev.iotlb)
 		vhost_clear_device_iotlb(&vsock->dev);
 
-	if ((features & (1ULL << VIRTIO_F_ACCESS_PLATFORM))) {
+	if ((features & (1ULL << VIRTIO_F_ACCESS_PLATFORM)) &&
+	    !vsock->dev.iotlb) {
 		if (vhost_init_device_iotlb(&vsock->dev))
 			goto err;
-- 
2.34.1
