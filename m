Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E97B1EBFF8
	for <virtualization@lists.linux.dev>; Fri, 21 Mar 2025 06:49:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742539742; cv=none; b=cor/Vtd5r9LDbeOMoGeBwR2Wjl2+9MDTj2yq0IaUW9tVHOVdP9iiBwBzF0SHYYG/T1Z+bI6+UxFzfssaTXQdkiygysbHZ5iaDCnvhNLHMrFFnDtkVMohykssoiL5DOMntQJDjfIiq3ARXRGsRGh97lJoiQPf+Yo8tSwfhNCqLUI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742539742; c=relaxed/simple;
	bh=JjapcMVDGbOLgMkpCmBgvZCv2tls7EkMlHjM4nzx7nc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=VG2aukyeSvOWxY3yQzfkB33zmbAIJaHp943lwReiW7cyyPg4rY/C4fdQPWFyU7FUCZ8xQ1wRqCWZtVbLmo4YS0mXZualt5gatlwPkWotY1j59XN2Ws0NBzXxVu+DhABJzHgn9u/a3glxqDOmiyMm2fcfOrdKEEiAeR170CxAIYk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=daynix.com; spf=pass smtp.mailfrom=daynix.com; dkim=pass (2048-bit key) header.d=daynix-com.20230601.gappssmtp.com header.i=@daynix-com.20230601.gappssmtp.com header.b=mHbbEwZn; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=daynix.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=daynix.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=daynix-com.20230601.gappssmtp.com header.i=@daynix-com.20230601.gappssmtp.com header.b="mHbbEwZn"
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-22435603572so30012715ad.1
        for <virtualization@lists.linux.dev>; Thu, 20 Mar 2025 23:49:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1742539741; x=1743144541; darn=lists.linux.dev;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=b/ZmhDXoFm25C2TQibSTkJHDcTfVUeG1ViV6OOg3xRE=;
        b=mHbbEwZnRqB778OU90y1wDVMldy22HXY4XD2SSAQ6aRGdtI2s5DNmuaHaaMZJzX68v
         NSyDef5l2puEdbs0UDtjCCK93TAdv573G1jdcOT8m8xn551PHCBxJLKpWg9nrWrUZ9Pg
         7e9M29oRQii/airaGgaGE3/OwHewdenJYAc2wiNPKY5JA2bLzHyeDL0GOJfpp3v+3/hX
         mVQ6tlgSss8nfWSG25NHxnsCoZGpjgafNQYxluX3F3AyZrT4tvOFSBbUGP7ngbCc9p8W
         rnSYhp/X0X7RzShoIN910j7O3Zp6+3ypgDUU3DaXLF60ckFQ1gHB4tNwcRgEELpQ29W5
         ceNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742539741; x=1743144541;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=b/ZmhDXoFm25C2TQibSTkJHDcTfVUeG1ViV6OOg3xRE=;
        b=xQqH+qiSz4jak0guQMQMZMOQ2qoCqsGkSyrZf8wJ7AyaGdLGuWpjFK4YTvhOBsf/Ii
         uMpy5/9caVV+BrPXdJ3HlY/FwvSilyIQGcc+9qPEnV5i9T2Ifhi9ovIivdhzCKIiKbyU
         MWzQlFVX6TRbHzpgUEq5ipQjazOcCt5dBIpVAOaCsIJb2Y2JprEkcDbjZNpLOORxb1qb
         KSN7La4nXCRbCAPxHhNZOojcxKYDnAyQO2QfoaMOmTnGHwOq/UZPo79QP+E/Br8TTNBp
         TlbhMx52EU6h5VXMixePUXFjfFY4e0t3j7NA8gov9JpFDdJ/iuhQICtQvgkqegcIac/u
         CuCg==
X-Gm-Message-State: AOJu0Yywn0tXYoytUtq7tmCvkLfzOB7vpXxQ/0maEqDlA7CfGzrSqFYs
	dA4NdgkRXHbnzr/O7U27Z4ynGb6lBE92u1Ny0yjkKYri6dXxVu46ezF+MbXnPLo=
X-Gm-Gg: ASbGncsykYTjFQjawsTt3/ZOHk7F/mELYuVRZjXAPJ+QSPHfOt+zjPYmuZhjYobdxel
	NTcnCz/TfVwGB3wYDeaHioUTSW52IKPsV9EWrK45KU9Poaq5v8s1Cz8bMMwUxi6yJxcw8IG1U5k
	piSVXynez8kMF1hPnWcH4ht+KnIwQcRExMiQWkAWLkqUfFakhU3gQpSPCubUpb5bncBODASe2pp
	j9xCTfC/c1YowsFtmgr+tN6HjoHDEUA7pb8mxT/PIeScsCA1Lf+T+zOp0BcrtvL4K4wfKuIQ1/Q
	erie4mJ0DgT5PwcPEwE6AtNTi4fyOPz5QfoUuBRtrQMJMK1M
X-Google-Smtp-Source: AGHT+IFY57i8l2zIDhAAWUOoYbKyLPQPPGn+mWn2Fuj0WlYT5jMKi+NUy5SRU1dEXrfFRpylN+S9vg==
X-Received: by 2002:a17:903:22c4:b0:224:2715:bf44 with SMTP id d9443c01a7336-22780c7b0d9mr33833585ad.19.1742539740663;
        Thu, 20 Mar 2025 23:49:00 -0700 (PDT)
Received: from localhost ([157.82.207.107])
        by smtp.gmail.com with UTF8SMTPSA id d9443c01a7336-22780f3977fsm9212645ad.14.2025.03.20.23.48.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 20 Mar 2025 23:49:00 -0700 (PDT)
From: Akihiko Odaki <akihiko.odaki@daynix.com>
Date: Fri, 21 Mar 2025 15:48:32 +0900
Subject: [PATCH net-next v2 1/4] virtio_net: Split struct
 virtio_net_rss_config
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250321-virtio-v2-1-33afb8f4640b@daynix.com>
References: <20250321-virtio-v2-0-33afb8f4640b@daynix.com>
In-Reply-To: <20250321-virtio-v2-0-33afb8f4640b@daynix.com>
To: "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>, 
 Xuan Zhuo <xuanzhuo@linux.alibaba.com>, 
 =?utf-8?q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>, 
 Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Andrew Melnychenko <andrew@daynix.com>, Joe Damato <jdamato@fastly.com>, 
 Philo Lu <lulie@linux.alibaba.com>
Cc: virtualization@lists.linux.dev, linux-kernel@vger.kernel.org, 
 netdev@vger.kernel.org, devel@daynix.com, 
 Akihiko Odaki <akihiko.odaki@daynix.com>, Lei Yang <leiyang@redhat.com>
X-Mailer: b4 0.15-dev-edae6

struct virtio_net_rss_config was less useful in actual code because of a
flexible array placed in the middle. Add new structures that split it
into two to avoid having a flexible array in the middle.

Suggested-by: Jason Wang <jasowang@redhat.com>
Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
Acked-by: Jason Wang <jasowang@redhat.com>
Tested-by: Lei Yang <leiyang@redhat.com>
Acked-by: Michael S. Tsirkin <mst@redhat.com>
---
 include/uapi/linux/virtio_net.h | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/include/uapi/linux/virtio_net.h b/include/uapi/linux/virtio_net.h
index ac9174717ef1..963540deae66 100644
--- a/include/uapi/linux/virtio_net.h
+++ b/include/uapi/linux/virtio_net.h
@@ -327,6 +327,19 @@ struct virtio_net_rss_config {
 	__u8 hash_key_data[/* hash_key_length */];
 };
 
+struct virtio_net_rss_config_hdr {
+	__le32 hash_types;
+	__le16 indirection_table_mask;
+	__le16 unclassified_queue;
+	__le16 indirection_table[/* 1 + indirection_table_mask */];
+};
+
+struct virtio_net_rss_config_trailer {
+	__le16 max_tx_vq;
+	__u8 hash_key_length;
+	__u8 hash_key_data[/* hash_key_length */];
+};
+
  #define VIRTIO_NET_CTRL_MQ_RSS_CONFIG          1
 
 /*

-- 
2.48.1

