Received: from mail-qt1-f179.google.com (mail-qt1-f179.google.com [209.85.160.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89B633B3C1D
	for <virtualization@lists.linux.dev>; Tue,  7 Apr 2026 12:39:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775565554; cv=none; b=R/weTuD9rCqH7rzhf5jbvGPD1kwy6sZuxmVoORXAH7M8l46qlVl1Tr4zTRYOX/pIjLRYU6EtEGheFdAmd2hmKIrvGC5w0WYz6oawW8tRY24+I87RQY1sjq2YrX7QPEqSFYhDEIK51QowC2Xay+6IuOkm6lcEVKX3emPc9VPE5mQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775565554; c=relaxed/simple;
	bh=2kx1Oip+6YQLuV/VHAvcYtYmbP2AKsVF1Xibb3dftko=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LCOFKZMr8nXJlcbP6LjCsHT+AryEWEel70/azLShmqvvfgKblFtveAL1wNQ+c4mtNsS4DiE5C7V6MSlMy1HdEuRP79SlKPGNt28lSuLnPoRH5dJ7d7Lr+eYYGdvNUILhsaUgEQUhfewz6KNJoA4P2kjEBNlE5s67oSwTnAJxaiI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=stellman-greene.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HJ673sco; arc=none smtp.client-ip=209.85.160.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=stellman-greene.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HJ673sco"
Received: by mail-qt1-f179.google.com with SMTP id d75a77b69052e-50d6ab4476eso41029641cf.2
        for <virtualization@lists.linux.dev>; Tue, 07 Apr 2026 05:39:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775565552; x=1776170352; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to;
        bh=u7VFfJjUGbIXDKcJmEuKBDpVPwVGyf1i5hyqfmybFlM=;
        b=HJ673sco5QjZmPDcJ1Es3+oVq/CEgCz+7hpEjDH6IlhxjpyFAC/aJr90oDLNJvdGQM
         YIbBHfplw0Fon7OG+9JdLzJ3Y9VvBdhbUhf5BAp6kedqyBgWI3FgjCnjKgvZOm0UBOcv
         QXI3+2hlcWUlDyNdnFtfZSkPriHE5WZcQCOkSTLMJhBQ1WSzk1IkoG9+vOqJLUosFyZ6
         IdXiYdcPGHT5kt3KQiJaMk5TcX4QTLYIz6nY0YB1mgJC2o6aW8CCqKCL2XSLInwnbV2L
         pr7tE6BrCae5GvdaLfoTRc9yw8WMtbUhaznubCinaXDf0l9M724upNS/wKD1oVyY7Iwc
         PXlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775565552; x=1776170352;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=u7VFfJjUGbIXDKcJmEuKBDpVPwVGyf1i5hyqfmybFlM=;
        b=ITsvu8wC2KkDCRrcwQpe3myPCnBi8y4e5LSa53789UYj0vVbsnYUf+rF0cZ/6isQC8
         FC2WDww7+g+iUTAdNJr7feMeYHcHqc8Owa6KqZiAda4Na3ibWcTT2TBDt5tOmhMd+FXe
         jvayW4QW+pk72TKnFLi534zQim8uqIhSZzq/eFp9nS8w5kN7EFRtuBxGUxcyyQN0GYYQ
         wQfzIbqLaRALHooVrAnz5JLkMQ+BOg9UJsXZMiAA6GlfP46m+qldIVUeB9IPpvDX81La
         oZOpIi7TemlIfIGoomV40jjeT6sAQeUHNwYMWTknGyMwrpXRFLTAM7nZ6QDc/xB1oxZW
         9msg==
X-Forwarded-Encrypted: i=1; AJvYcCV2DMoVC0Eu0cxGcdOQKvqiAoGgnlwuT4wCNwNNABiS/95QVfNyku1OqahKT0hRn2fvMkgWmCRapRwjBVLxEg==@lists.linux.dev
X-Gm-Message-State: AOJu0YxGemQ47zLiheXCOFFhcWaCvQ/PzNRcG02S+XJsaQ85YlcWnM+r
	TJ+38I8ollSZ5l/PAlE2/Pl7/QWVe790bnbUfS4NCn6SPlQvdDrcX02Q
X-Gm-Gg: AeBDietfTHA2753i2qzYaKVQqltOfTU7ToApP2ejkPVxYO3Cu7pTyworXu7ME4U1VvG
	qxT7j/zQnNEJdU5IET6DcrI+T/JqpaWElzaW9dIk/ybuAdbuCEZVbg/x3G61AUaS8Bf3TRicI0c
	lEUDljAKW7p5RS6M1yIjMZdJnJuBeyD0HSQxKbNIf61GiSgB6TGiBjnBZ+r/QIWCfUh9X6xmZqv
	aeqtI86bxInOb022ERd+p7C/4mLR9vlATNo9rmKZ9HPLBjeb20d9dqIvOGFZqX+d+IubXXfzk0B
	KBUFdLI9Vq13jquqry6rL9zwwJFRQogLI7pR6lOSffbp9DHQfSqzcYCAhdha9CbW0degjVaTDwZ
	JBImZWHuXed+oJk1Qa8UolsuDHyUmTu4Rfj+lTlgEvrHEU8F3dAYgyhPFjhieV+YrJwumcKRC8v
	XdL5rz2oOz45KV0LN+bHJURzOKXqBP7hhe5S+fk56udgLq4RFmjwlBi2BEaxZncu1yYSFXA6y8c
	eWdAwrzSbbK3rS0GatkFT9wWqFQG5RolIGqPTsg1tWk9p9D0I541jt8t1kpT1QSEKwauUVdRony
	Ik415ePB6m8Dmz+PDUkg
X-Received: by 2002:a05:622a:130a:b0:50b:3a6d:db4b with SMTP id d75a77b69052e-50d62d31ba2mr241569871cf.55.1775565552461;
        Tue, 07 Apr 2026 05:39:12 -0700 (PDT)
Received: from localhost.localdomain ([2600:4041:5c46:7000:d80b:4b87:c7c8:bd46])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-50d4d4a034asm133005611cf.6.2026.04.07.05.39.11
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Tue, 07 Apr 2026 05:39:12 -0700 (PDT)
Sender: Andrew Stellman <stellman@gmail.com>
From: Andrew Stellman <astellman@stellman-greene.com>
To: "Michael S . Tsirkin" <mst@redhat.com>,
	Jason Wang <jasowang@redhat.com>
Cc: Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	=?UTF-8?q?Eugenio=20P=C3=A9rez?= <eperezma@redhat.com>,
	virtualization@lists.linux.dev,
	Andrew Stellman <astellman@stellman-greene.com>
Subject: [PATCH 4/4] virtio_ring: preserve VIRTIO_F_RING_RESET in transport features
Date: Tue,  7 Apr 2026 08:39:04 -0400
Message-ID: <20260407123904.6390-5-astellman@stellman-greene.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260407123904.6390-1-astellman@stellman-greene.com>
References: <20260407123904.6390-1-astellman@stellman-greene.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

vring_transport_features() whitelists known transport feature bits and
clears the rest via __virtio_clear_bit(). VIRTIO_F_RING_RESET is
missing from the whitelist, so it is unconditionally cleared during
feature negotiation. Drivers that depend on ring reset capability
silently lose the feature.

Add VIRTIO_F_RING_RESET to the switch statement, matching the other
transport-level features.

Signed-off-by: Andrew Stellman <astellman@stellman-greene.com>
---
 drivers/virtio/virtio_ring.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/virtio/virtio_ring.c b/drivers/virtio/virtio_ring.c
index fbca7ce..2cb643f 100644
--- a/drivers/virtio/virtio_ring.c
+++ b/drivers/virtio/virtio_ring.c
@@ -3524,6 +3524,8 @@ void vring_transport_features(struct virtio_device *vdev)
 			break;
 		case VIRTIO_F_IN_ORDER:
 			break;
+		case VIRTIO_F_RING_RESET:
+			break;
 		default:
 			/* We don't understand this bit. */
 			__virtio_clear_bit(vdev, i);
-- 
2.34.1

