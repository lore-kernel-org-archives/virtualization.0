Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8CF3313E17
	for <virtualization@lists.linux.dev>; Thu, 27 Nov 2025 06:40:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764225642; cv=none; b=n8fGdVRN8CSxxr2x48KKyg9k8xIP5G3qKfmJheAhnUByIeyBoNBvLw/m6UklbsO47vWbVPjkFpCaQ4JRQRxUK2X+21tJaqi7KRZia7fXP4Jc9+Y4JJJBJK7jvxi1kVLBdG9U6ZjCxVnwlKujOqOZUP6O7w4oAr4gyEtmLQvSsR0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764225642; c=relaxed/simple;
	bh=p4zBspV0umYpwlxraVSt9LbhsuCRfZnCfl2fUmVODfw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=eLv4WJxWC0KJ1v0XY4Pfrv2/a99+u/KPWKsvD8XMqs9pAxQT/W9RGZD3fcr6N5RT5WwwHBA+xjH0qPudgD6bX2qCwWOVR+avo2r2FRjBBkGt/5cHNTevUxT/Ug9fLrdxfDDrfeqxCMSN7FikY5h+btHKTFy4QeCIlNdQje28VEY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=TRs7XW13; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="TRs7XW13"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1764225638;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=kFZFceCxodv+sVrwXshrWOSA01PvSJh54J0xHtV2LxM=;
	b=TRs7XW13eC58qfJksEUlVhEjIW1ZuQMPCThb1IvL6dFy1iIsihkt2MdhzndUs3pS56Qp8s
	S64COeVqtzTFZCNvL7an3Tfl4gm5+fxTfnRJCdLdHcrsJAPZTjR4ninld3ZcVR+/H5lIss
	WgmdXq1ROfpDujq7ZqptuYpNHPw1AvU=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-502-UQ_VY-iSN_ijjT0US7ik4Q-1; Thu, 27 Nov 2025 01:40:37 -0500
X-MC-Unique: UQ_VY-iSN_ijjT0US7ik4Q-1
X-Mimecast-MFC-AGG-ID: UQ_VY-iSN_ijjT0US7ik4Q_1764225636
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-477563e531cso3169645e9.1
        for <virtualization@lists.linux.dev>; Wed, 26 Nov 2025 22:40:37 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764225636; x=1764830436;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kFZFceCxodv+sVrwXshrWOSA01PvSJh54J0xHtV2LxM=;
        b=v1++t2YUxVgj8bJlNb/5Uo+JpfQNy/Ur9pDB6j3f6M9nTDo+OyQhEOeDCfrdLiG328
         ZYEhwsrkFD65n36hjCZcp1Z1ONSwN9+w/RccXlKjT80O/5u/P3ytiykRxxLXLIrhQMNz
         6xy8Wy4SAJoicr8UYBuOWt2d0kTn4BMHpSGDL0PVZA5YF0dyNdKshF1psAKCkESCKm5Q
         +uXiITdk595YicNIe/OjFFTQtvmvfvLyLdNMNn4qDMAyTdnBJb4gJ57J+9glNlrh8XQY
         PAYuSTU5IL0bhNMzB3bnC6ZDU2qt/N1jDWD+mne6DxP32g7w677/JiS8+4e79LYpAeRa
         PMUg==
X-Forwarded-Encrypted: i=1; AJvYcCXWlhARaxx1a0Z1VT6LcLekam6UbuEHrJsseF9ZemgtLHiyxD84u+a/+bj336o7NDCJrCR0G2gOG2U5dnX4Pg==@lists.linux.dev
X-Gm-Message-State: AOJu0YwO+gh1Bv9dY2QeTlyJlcPkbKi8Y5+oCAxMFYC0LLQfCJ+P+pYT
	9ZuoHhjXug4UQsfSzAY6TznGjcIJxMn06wjgg6bSUK3fblQ0JqCqmnDkF5znki66Cx5RpCoH6Op
	PIWXqOWwHHSUgsMahgBN371c61loasCnAL8OGtK78qHQPPi6Mr+2rIn2EXWDF59olxbUcZBc0tu
	RS
X-Gm-Gg: ASbGncuv/PXq/Rpm4KezcdTYvf9YbBm0MpQCGYuTSorjMwf3jan9+PTde3qFdaN2kFY
	pasHu4HUODs1s6kt0InBAxEfjVcX2767AF8OMAInvfC4fxVXBNhaiWtibym2HD4qCMNBwyjxljj
	O57qwF8JFqxsTCZ4k5g1/fZ996VtFChp73z2Dx28tKTBZb3QBHl71jMuir2maRr0jKHq3PXLN5T
	Fce6h3U1u9XxBbexlgNRpSBq39sKCuOCAGEDOPRO/Ac9r4x4gAmXvdfVs3QlplGPZ5Zy1rKqZ3X
	LJqQSaDFIVhHf+vYRSgc+IhKvQYp0NB4hSEzA0bhwcHNRPhkLmjBd2vGSp8tl070ExF9lhGKFWo
	JpJuibmJXsRPt9fyxCWLvZk/M0Hj3AA==
X-Received: by 2002:a05:600c:3543:b0:477:1ae1:fa5d with SMTP id 5b1f17b1804b1-477c1142268mr180867355e9.20.1764225635785;
        Wed, 26 Nov 2025 22:40:35 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHmaKJl3GPl1IrG9e+lyxemKaHO0wPm9ET8yhjMSTC9B7Xozmw3CvG5GdadD3czzW5PwSFbkA==
X-Received: by 2002:a05:600c:3543:b0:477:1ae1:fa5d with SMTP id 5b1f17b1804b1-477c1142268mr180867165e9.20.1764225635290;
        Wed, 26 Nov 2025 22:40:35 -0800 (PST)
Received: from redhat.com (IGLD-80-230-39-63.inter.net.il. [80.230.39.63])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4790b0c44dcsm78642495e9.11.2025.11.26.22.40.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Nov 2025 22:40:34 -0800 (PST)
Date: Thu, 27 Nov 2025 01:40:33 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: linux-kernel@vger.kernel.org
Cc: Andrew Lunn <andrew@lunn.ch>, Paolo Abeni <pabeni@redhat.com>,
	Jason Wang <jasowang@redhat.com>,
	Eugenio =?utf-8?B?UMOpcmV6?= <eperezma@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	Jonathan Corbet <corbet@lwn.net>, kvm@vger.kernel.org,
	virtualization@lists.linux.dev, netdev@vger.kernel.org,
	linux-doc@vger.kernel.org
Subject: [PATCH v6 2/3] vhost/test: add test specific macro for features
Message-ID: <23ca04512a800ee8b3594482492e536020931340.1764225384.git.mst@redhat.com>
References: <cover.1764225384.git.mst@redhat.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <cover.1764225384.git.mst@redhat.com>
X-Mailer: git-send-email 2.27.0.106.g8ac3dc51b1
X-Mutt-Fcc: =sent
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: r_gfwwQmqXtIfSsCAzgwp6_0KfCkO09m70mj7tINJts_1764225636
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

test just uses vhost features with no change,
but people tend to copy/paste code, so let's
add our own define.

Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 drivers/vhost/test.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/vhost/test.c b/drivers/vhost/test.c
index 42c955a5b211..94cd09f36f59 100644
--- a/drivers/vhost/test.c
+++ b/drivers/vhost/test.c
@@ -28,6 +28,8 @@
  */
 #define VHOST_TEST_PKT_WEIGHT 256
 
+#define VHOST_TEST_FEATURES VHOST_FEATURES
+
 enum {
 	VHOST_TEST_VQ = 0,
 	VHOST_TEST_VQ_MAX = 1,
@@ -328,14 +330,14 @@ static long vhost_test_ioctl(struct file *f, unsigned int ioctl,
 			return -EFAULT;
 		return vhost_test_set_backend(n, backend.index, backend.fd);
 	case VHOST_GET_FEATURES:
-		features = VHOST_FEATURES;
+		features = VHOST_TEST_FEATURES;
 		if (copy_to_user(featurep, &features, sizeof features))
 			return -EFAULT;
 		return 0;
 	case VHOST_SET_FEATURES:
 		if (copy_from_user(&features, featurep, sizeof features))
 			return -EFAULT;
-		if (features & ~VHOST_FEATURES)
+		if (features & ~VHOST_TEST_FEATURES)
 			return -EOPNOTSUPP;
 		return vhost_test_set_features(n, features);
 	case VHOST_RESET_OWNER:
-- 
MST

