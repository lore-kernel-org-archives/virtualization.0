Received: from mail-pg1-f176.google.com (mail-pg1-f176.google.com [209.85.215.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7AAC42E2F15
	for <virtualization@lists.linux.dev>; Wed, 12 Nov 2025 06:55:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762930543; cv=none; b=UlOyztrI4j0sG3GWC5MD6V7Fyq36JCxlm8gYktzZ19CACs7SM5oAtR3yLgIR2V1zmQMR1Y/F/3lYd9UPeWnpqn+abqN0PZRV5yv8tu5Gem8dxshFNapibjEtbXO5Gz7ghZe+QhLfykJJWVCrfow+7eiOVgZUnvkNkOlJzf271lw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762930543; c=relaxed/simple;
	bh=5emprepJCkrosJM8h3ONRAh/VBEaqfFdtQYY3rXLh2g=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=E0JXvd4AgkJ6cQMBoTpAml1i4j+fgwKbzkDfmVPWL1gUVSG9TjM3U6T8pxYP9+tU3FW95prhX/MQr3C+3LfyYj0ajfBaQmnpWQED2yAyoqdciM2tWC0/u3DR/5ihjuQfGM9W88Z27AW1AVnM1pSJ9KZzSVQA3gs6LiT8evq4HVY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SWpe6WYc; arc=none smtp.client-ip=209.85.215.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SWpe6WYc"
Received: by mail-pg1-f176.google.com with SMTP id 41be03b00d2f7-ba599137cf7so460078a12.0
        for <virtualization@lists.linux.dev>; Tue, 11 Nov 2025 22:55:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762930538; x=1763535338; darn=lists.linux.dev;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=kfQ2Nx6CoFxjU6rBT4tiqTH+6eTbyO5fnFEERoP0vpM=;
        b=SWpe6WYcnDdCBK8MmFrVbm6PheEVO70uB/r1wKXiY2ftJWG5QnPCuLUuK3MvEP5fKB
         tPSOZ1Fb3yxSYGh9x7CaA96lIvNvay5suU9hjP3mhg9+3+qI+ezuU931OyLISf4+WOXe
         larbY8gSE/W2ILOBezcO3gT9iClWOequaJREg16uQyWBH0SteMbjUso9lpkSVxL8c0cJ
         5MzgPDU4vCKOQoD6dCGIFiJLomXWcm0AHnUVNlIn9aWZfMfoKtZyGtUyXaap9zK+xq4W
         iXFPtVz5EKwZuvKozueyY33VutgQOsF5zwguN1tEJET3I2r9dVQxt7UV9hNCwu/Xp9iF
         n7gg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762930538; x=1763535338;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=kfQ2Nx6CoFxjU6rBT4tiqTH+6eTbyO5fnFEERoP0vpM=;
        b=BwFbox4pgzittZWo9CVLBfcUN0KPdJaMot2Hp4flJqDSIIdQRUp8RtLqXMqUfSyJpr
         u3QC56WVYKuhlaSRaXB31ZeEi9MB4zX7vzGPx+JEuxhCfoFY8+E8H3S8alh/OZPA9kRQ
         IRJ5h6zUp9btOtMnRvj//6UScwsAODFcU7KGVW3IKdH3kxerin4pTqnmZJGGXhFwzZoP
         Df8DtYjsE1O5NBxEH9TLDBw+aUw8y9B2qr6NKL73N1qjLcjlHpdL76sGZpidd5NBr8fO
         5jCaTrSspiSoxoeNNtB4aVxNMm5oczkWvB08N75qpYBfNrsPCO8lCG3b7pyZHP36G85d
         8Nwg==
X-Gm-Message-State: AOJu0YySkea//pHVabxIHyfHcpofY58poJfBErTHjTOr7nplk6ZOncj5
	QPm/Nc4uZ2kiccaHsar3FhJ3uS0qz87BR9KlHT0ySPheAI7UiHpPSLwF
X-Gm-Gg: ASbGncv4nhOa/QLDpqU7xtnjUYN/WzlCHExFMiniP6oVJR/3ut3HMneAjcwaAHcxndF
	Nyrdsblm/qZ9jmLtsTOLNqYxtMmwRpyPtvMPpHexk9EcI2+W/mFIO7iYCgAAxuOpd2RCrh8kbVM
	+TWjsotW7LgSrDM79eBTPg3Abra8SdD0mDNEPP+xZtUfGQNKRp1X8oztAUvu1E+mJBSZ1nHaw2e
	TnDMr0IFPxGjS0/etQChH2u5S2IAfA5zCObye7smz/dh01SRSRxM7mGH4b1WgjF4TrqOORgmdVr
	r6MyP8fuZUTTGcKVAwHIpbS7TbqeDcGUgGZj8yaNryBXhnOQOmiNeSCRQZLA9gaN1KmZ90YWEr7
	YRAZS8cd08RnkEKU8ju+ptvXxlhzMzW/9JhrbjriQaBh7dF7jhz3l0b9oUBWkNAKSmOVgWc25
X-Google-Smtp-Source: AGHT+IF7DfsEqGvimsF/vV7xkPY5hQFPw6KbtZBzdnrAV5tW65XpvT8z84/9DJylmvZPMXLFyKNPwg==
X-Received: by 2002:a17:903:19e3:b0:295:21ac:352b with SMTP id d9443c01a7336-2984ed92f72mr26986205ad.15.1762930538514;
        Tue, 11 Nov 2025 22:55:38 -0800 (PST)
Received: from localhost ([2a03:2880:2ff:2::])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2984dce55dcsm18719235ad.97.2025.11.11.22.55.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Nov 2025 22:55:38 -0800 (PST)
From: Bobby Eshleman <bobbyeshleman@gmail.com>
Date: Tue, 11 Nov 2025 22:54:46 -0800
Subject: [PATCH net-next v9 04/14] vsock/virtio: pack struct
 virtio_vsock_skb_cb
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251111-vsock-vmtest-v9-4-852787a37bed@meta.com>
References: <20251111-vsock-vmtest-v9-0-852787a37bed@meta.com>
In-Reply-To: <20251111-vsock-vmtest-v9-0-852787a37bed@meta.com>
To: Stefano Garzarella <sgarzare@redhat.com>, Shuah Khan <shuah@kernel.org>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Simon Horman <horms@kernel.org>, Stefan Hajnoczi <stefanha@redhat.com>, 
 "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>, 
 Xuan Zhuo <xuanzhuo@linux.alibaba.com>, 
 =?utf-8?q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>, 
 "K. Y. Srinivasan" <kys@microsoft.com>, 
 Haiyang Zhang <haiyangz@microsoft.com>, Wei Liu <wei.liu@kernel.org>, 
 Dexuan Cui <decui@microsoft.com>, Bryan Tan <bryan-bt.tan@broadcom.com>, 
 Vishnu Dasa <vishnu.dasa@broadcom.com>, 
 Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>, 
 Bobby Eshleman <bobbyeshleman@gmail.com>
Cc: virtualization@lists.linux.dev, netdev@vger.kernel.org, 
 linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org, 
 kvm@vger.kernel.org, linux-hyperv@vger.kernel.org, 
 Sargun Dhillon <sargun@sargun.me>, berrange@redhat.com, 
 Bobby Eshleman <bobbyeshleman@meta.com>
X-Mailer: b4 0.14.3

From: Bobby Eshleman <bobbyeshleman@meta.com>

Reduce holes in struct virtio_vsock_skb_cb. As this struct continues to
grow, we want to keep it trimmed down so it doesn't exceed the size of
skb->cb (currently 48 bytes). Eliminating the 2 byte hole provides an
additional two bytes for new fields at the end of the structure. It does
not shrink the total size, however.

Future work could include combining fields like reply and tap_delivered
into a single bitfield, but currently doing so will not make the total
struct size smaller (although, would extend the tail-end padding area by
one byte).

Before this patch:

struct virtio_vsock_skb_cb {
	bool                       reply;                /*     0     1 */
	bool                       tap_delivered;        /*     1     1 */

	/* XXX 2 bytes hole, try to pack */

	u32                        offset;               /*     4     4 */

	/* size: 8, cachelines: 1, members: 3 */
	/* sum members: 6, holes: 1, sum holes: 2 */
	/* last cacheline: 8 bytes */
};
;

After this patch:

struct virtio_vsock_skb_cb {
	u32                        offset;               /*     0     4 */
	bool                       reply;                /*     4     1 */
	bool                       tap_delivered;        /*     5     1 */

	/* size: 8, cachelines: 1, members: 3 */
	/* padding: 2 */
	/* last cacheline: 8 bytes */
};

Reviewed-by: Stefano Garzarella <sgarzare@redhat.com>
Signed-off-by: Bobby Eshleman <bobbyeshleman@meta.com>
---
 include/linux/virtio_vsock.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/virtio_vsock.h b/include/linux/virtio_vsock.h
index 5ed6136a4ed4..18deb3c8dab3 100644
--- a/include/linux/virtio_vsock.h
+++ b/include/linux/virtio_vsock.h
@@ -10,9 +10,9 @@
 #define VIRTIO_VSOCK_SKB_HEADROOM (sizeof(struct virtio_vsock_hdr))
 
 struct virtio_vsock_skb_cb {
+	u32 offset;
 	bool reply;
 	bool tap_delivered;
-	u32 offset;
 };
 
 #define VIRTIO_VSOCK_SKB_CB(skb) ((struct virtio_vsock_skb_cb *)((skb)->cb))

-- 
2.47.3

