Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F93F2F7AB0
	for <virtualization@lists.linux.dev>; Thu,  4 Dec 2025 18:46:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764873995; cv=none; b=k84+sthdpTGZcQlT7CDOd5dGT1E5oVVn3thfk4Y7JALmB8xihIdtzR3FcWyeu12OtpBjI5lAg6we4hUNofvThA/dawKO/rws5ea8bm7GG13lZDGc1Bp9n9EofHHnnjKGMwL5brMTiFKHf9NaGpEBsOyNNDjVEgJK3FzWeg3uZMk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764873995; c=relaxed/simple;
	bh=Qk/J4L0SFzsNCQrg7rVR1krOtbKHu7m+vBq4AMJeMVc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=Twyqvp7jwUaAVRVWZvDfnNmzWEyHkFDNFb67HhpgMmPuGyd3YMx+wV31MJQaMlr4xsS0jHe6mSSP2SIqZ/rwoI3nAfYGX9mHMAmQ5q6GtQwjsxXINZlaPAyipp5eSeeUALVNKslJsq/2VS8MLBcBGhHDEMb29sVNfbPnGTbNvd8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=X1OGgsy/; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="X1OGgsy/"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1764873993;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=nPYTUFJHr1POn8hRKDfdxFF2OaU0fNElhNqKPHpzHOE=;
	b=X1OGgsy/2YwA5qwLAa0Yb8zooYnjuonHr4lWnhG9k6nanPXQtliUyoq1nbDFGSG14EtCtA
	6eK96LwM5e97lvQ1sv1paFSYGKIX6gnXO8rddXefL6DxsXmJ/uNO+cSDYovDK/5vdDc3WF
	VUYemT07FTXrxYlq8+u4RY2iY0+r1aY=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-457-n05uOMfrPFaKQPVFoVPdtQ-1; Thu, 04 Dec 2025 13:46:31 -0500
X-MC-Unique: n05uOMfrPFaKQPVFoVPdtQ-1
X-Mimecast-MFC-AGG-ID: n05uOMfrPFaKQPVFoVPdtQ_1764873991
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-477a11d9f89so6279365e9.3
        for <virtualization@lists.linux.dev>; Thu, 04 Dec 2025 10:46:31 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764873990; x=1765478790;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nPYTUFJHr1POn8hRKDfdxFF2OaU0fNElhNqKPHpzHOE=;
        b=u7iscHVX5lrl6+MJpnmHS43i9OmLn/qwoGlWK2KptYCXMZ2YFzEHZX5V2bNr8kqO9H
         y+U1RzRWjmT6PswbIhA0wA8YSq70Zx6ciZxIAb25VRKnS1PPvpiTI0/SS9nnn4MoViTf
         LlWXDZyi27Yd73cV1VZY9Da0vf9kg8cVJQLd8/KyTctxQQwoCCLrd+Rjlox0N59DR4WH
         NBRZLIBODjUPRDGyN85rvS3oG8CohoH8dVIdnGNo7fLPUbJsml4QjRi7NenajLm+9oz7
         tE5X63LOd+iReKRIISsk91JVyqwr7wWRXk2pK832/7QDszl9CChSI47S6Dsp8qgYZe/I
         8pjw==
X-Forwarded-Encrypted: i=1; AJvYcCXFKGPb9sCBD30ao6XaLMwVDd0tqb1PoEiIULiauPAkyUN+eXVnloEscVt/49lQKjdQu7mpWofCsrSDoixmZQ==@lists.linux.dev
X-Gm-Message-State: AOJu0Yxp61sgzUuxYhWKzVR5O5zXUqXOb3+0GuEopXcX2ENr4OpM3gCF
	nCh/1qpNagdS6rCE/B+KFX978EsD/W5Oj+gYbDcAhc2PJGyTvY9x0Kt/6XeeXk1ZGAt0s7x2Pp4
	HdJZu59iGdhNkd5L+ie23ERkK/YM2FSNDeIa1i8BR2bAFtOYfjyucJX+yLdA/fWbrJ5Lz
X-Gm-Gg: ASbGncuKIujnN/mbhezuk9EQwpdmvEyxDba4qyQhq75aTkbD89O2IOL5tHwKbjSqLgx
	h4xxICJf7sprifQ9E8tcj/UtdrOvYBcmHFngMKW8sAxto1TrfVJ+mY65oaqpk3fZ4+qX+PaZz0Y
	JzDjGi5Qjsd73T7MM6jEvxnzHpqLKpjq1Dmr0F4e6QeFX2OgmFdywBO/K6r8+/1/MUDHBLpxsfS
	GKotS2nwirOfrJZAgRPnh2cRAhRUseP40oSHV0k9xK5ljASrwTtsTYHLIAPQm5X2mFRBrskWSXl
	YG6wYT6LCgBJdKdkNsGvzQiNWlUQmg4olOVxfF0wG1Tl0iA/6xDHWVo5IKe/XtvibwFvprcSI5U
	=
X-Received: by 2002:a05:600c:4ec9:b0:477:89d5:fdb2 with SMTP id 5b1f17b1804b1-4792aef1d2amr69355135e9.14.1764873990434;
        Thu, 04 Dec 2025 10:46:30 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFU7aeaH8aUbdBeDAO1JThY2D/Cq7sLCeHq+TwiYHRfy14KN9woOqNkZ12PESfC+fB0elhfyA==
X-Received: by 2002:a05:600c:4ec9:b0:477:89d5:fdb2 with SMTP id 5b1f17b1804b1-4792aef1d2amr69354895e9.14.1764873989886;
        Thu, 04 Dec 2025 10:46:29 -0800 (PST)
Received: from redhat.com ([31.187.78.57])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-47933aef61fsm9037945e9.7.2025.12.04.10.46.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Dec 2025 10:46:29 -0800 (PST)
Date: Thu, 4 Dec 2025 13:46:27 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: linux-kernel@vger.kernel.org
Cc: Jason Wang <jasowang@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	Eugenio =?utf-8?B?UMOpcmV6?= <eperezma@redhat.com>,
	virtualization@lists.linux.dev
Subject: [PATCH 12/14] virtio_features: make it self-contained
Message-ID: <579986aa9b8d023844990d2a0e267382f8ad85d5.1764873799.git.mst@redhat.com>
References: <cover.1764873799.git.mst@redhat.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <cover.1764873799.git.mst@redhat.com>
X-Mailer: git-send-email 2.27.0.106.g8ac3dc51b1
X-Mutt-Fcc: =sent
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: n2JBSsMcCW0tYzSX2KiO29cmnif1eY0JXrFf1Ot47p0_1764873991
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

virtio_features.h uses WARN_ON_ONCE and memset so it must
include linux/bug.h and linux/string.h

Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 include/linux/virtio_features.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/include/linux/virtio_features.h b/include/linux/virtio_features.h
index ea2ad8717882..ce59ea91f474 100644
--- a/include/linux/virtio_features.h
+++ b/include/linux/virtio_features.h
@@ -3,6 +3,8 @@
 #define _LINUX_VIRTIO_FEATURES_H
 
 #include <linux/bits.h>
+#include <linux/bug.h>
+#include <linux/string.h>
 
 #define VIRTIO_FEATURES_U64S	2
 #define VIRTIO_FEATURES_BITS	(VIRTIO_FEATURES_U64S * 64)
-- 
MST

