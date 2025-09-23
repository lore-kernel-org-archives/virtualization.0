Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8E8321348
	for <virtualization@lists.linux.dev>; Tue, 23 Sep 2025 21:47:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758664082; cv=none; b=L0ptYwbAVvT2hjGmgYTUASinsNODrOxB4X+cWujZm/hFbPXwrDJmue8MeSgtE3YIlWsKbeldxgh/plL0iou+kXvlzg2QG88IJAzv5fjW1J97IkS0I25ECEDix/T2Ba7jXQc3c+3Mmw9PQtpkXN1sDvWj5HQWcu66FlmtL5zWELo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758664082; c=relaxed/simple;
	bh=ueTXvYOaTGFnlsHbGUKhUluBx5Uj1EtJeF74+R0Vgys=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=FBb6nqshlrfD7z/j742CqOqdnILSsb9Qt+P7eRiJSk2pi9ZN4PHPPF6JTsubJuqDUTvu0A23382u2gClkjHb1757IcZNDh46KK2ePOFPiZxY5Otb/G7QmEjXsmj+olojHCur4Fb6dh6Jo51mJRfjJRiTAp8R2jqqQsxvmNisWZo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ATrY/tpm; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ATrY/tpm"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1758664078;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type;
	bh=gE1p9jvRg0lKTpk9XpwlgaFgqtSuJtcDtsDSqLMg4mo=;
	b=ATrY/tpm6rFJ55hsbZsuP7MWrDIKs6uzwmNjzAh41YItDjwItOTTNx8zqbF5iNtUN1fqnd
	5doIpvG/U+jFBheT3VkG9jLOtASL5fx6GDuufMLzQ7SCqk2wi4JbKto/RJKJcBkggNOkgK
	wzZYTvxQG3iCfqkF3O3H5bXAkiw+cWA=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-187-KsbajKqRPy-K5Wz0d7VAIw-1; Tue, 23 Sep 2025 17:47:57 -0400
X-MC-Unique: KsbajKqRPy-K5Wz0d7VAIw-1
X-Mimecast-MFC-AGG-ID: KsbajKqRPy-K5Wz0d7VAIw_1758664076
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-3ef9218daf5so1866909f8f.1
        for <virtualization@lists.linux.dev>; Tue, 23 Sep 2025 14:47:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758664076; x=1759268876;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=gE1p9jvRg0lKTpk9XpwlgaFgqtSuJtcDtsDSqLMg4mo=;
        b=KM+yOpEAFsLP8MNr8WLr0AVCzmfwlLt0e6gMfPegFo4xFnYX8ak5h9EQTIs962DDdk
         AoV98oSDyu6N5y7/n//yRdEoYxZD16C9jPdvGie1IN7B4bEBbGjsjmAfmaeHz8Y3A8Wm
         Hly6Bng2Xv0csxDewhLXxOrwaN/4uojySMyAAHaoco1nSedVzVptNQP3PhX4mgglTdn6
         nAPkEpM2XW7tJppnMSRsAJtiDt57/3abp9GGMqkfbVhjvoFnpz18fk2uVmsRgKT8SSaX
         2PmIV1+FqZolN1zxhHupA86rqojpIOwtKLm/xyehdZnm0fLkwTQgtvfW05QkTfVN3/90
         OYzQ==
X-Forwarded-Encrypted: i=1; AJvYcCUBzT96PnH49O/iEnWFwMZIfNGiMIyPSWNfA9ad62w+bdkqofXlEruFqSdD2dA9nwIDSQTEYQOjZ6k20+eOUg==@lists.linux.dev
X-Gm-Message-State: AOJu0YyEEtEeYB3mCslCHWz+6m8vrnuBSRphnE72/2BefnDo9kbpivtB
	/pZlthnAvtIxNx3k2YYIAK+CydR74KJaRJSp9at0KLmEbf6wqwmvRRDKGh72qG1cjM1clj5Kwdc
	+ZEvwcinnLyEoRn+KObVbwhJxkyKNZ2GS0Hooy32bL75wddcklR4Cpe9AHym0L88ogX0C
X-Gm-Gg: ASbGncsMzaqXg8xXUb/YxS0fjP6a7S9kFZWpWwS/D2zaZ+3GUhwo7zbT5L9wmfoqc6N
	B6qY3h4MVIYNxKBpY6JhrCSw2ZzBTr0WcgDjUQNRNHrY0bu3MxDgI/+lvBhQGsiefW55A68UXZv
	C9457SN7aJLj3WJRWwvshx76VHRO3USgIqBr1Q3SbhUusxnEmtZo9Xj8K+yCDkIXcSeoRHJUTUi
	zfG939180ehkdqsDk6cIEZ7n020eTvMHl/+/1nMAVX9XxAWi/dPDDt37AeMzfFCLm9LovQoiL/N
	rOzk9lUL7Z00K4NpxFSHGUPGuRDrb8UDPos=
X-Received: by 2002:a05:6000:1885:b0:3cd:ef83:a9a1 with SMTP id ffacd0b85a97d-405c6751cabmr3721719f8f.20.1758664075765;
        Tue, 23 Sep 2025 14:47:55 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IETV4Q7KUf/fsmOmIwTE27eO2P2KhRHj2pOb3/FmZCSUNeq3z+t0xn78V0pxCEhXhxYrElaFg==
X-Received: by 2002:a05:6000:1885:b0:3cd:ef83:a9a1 with SMTP id ffacd0b85a97d-405c6751cabmr3721711f8f.20.1758664075279;
        Tue, 23 Sep 2025 14:47:55 -0700 (PDT)
Received: from redhat.com ([2a06:c701:73ea:f900:52ee:df2b:4811:77e0])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3f61703b206sm15270816f8f.6.2025.09.23.14.47.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Sep 2025 14:47:54 -0700 (PDT)
Date: Tue, 23 Sep 2025 17:47:53 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: linux-kernel@vger.kernel.org
Cc: zhang jiao <zhangjiao2@cmss.chinamobile.com>,
	Jason Wang <jasowang@redhat.com>,
	Eugenio =?utf-8?B?UMOpcmV6?= <eperezma@redhat.com>,
	kvm@vger.kernel.org, virtualization@lists.linux.dev,
	netdev@vger.kernel.org
Subject: [PATCH] vhost: vringh: Fix copy_to_iter return value check
Message-ID: <cd637504a6e3967954a9e80fc1b75e8c0978087b.1758664002.git.mst@redhat.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Mailer: git-send-email 2.27.0.106.g8ac3dc51b1
X-Mutt-Fcc: =sent
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: -Aj5Bi1GiPvapE5Pl2PwxKFD8OzmITkvvjEnjaWtO1s_1758664076
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

The return value of copy_to_iter can't be negative, check whether the
copied length is equal to the requested length instead of checking for
negative values.

Cc: zhang jiao <zhangjiao2@cmss.chinamobile.com>
Link: https://lore.kernel.org/all/20250910091739.2999-1-zhangjiao2@cmss.chinamobile.com
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---


Lightly tested. zhang jiao could you pls also test, either ack or
fold into your patch?

 drivers/vhost/vringh.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/vhost/vringh.c b/drivers/vhost/vringh.c
index 0c8a17cbb22e..925858cc6096 100644
--- a/drivers/vhost/vringh.c
+++ b/drivers/vhost/vringh.c
@@ -1162,6 +1162,7 @@ static inline int copy_to_iotlb(const struct vringh *vrh, void *dst,
 		struct iov_iter iter;
 		u64 translated;
 		int ret;
+		size_t size;
 
 		ret = iotlb_translate(vrh, (u64)(uintptr_t)dst,
 				      len - total_translated, &translated,
@@ -1179,9 +1180,9 @@ static inline int copy_to_iotlb(const struct vringh *vrh, void *dst,
 				      translated);
 		}
 
-		ret = copy_to_iter(src, translated, &iter);
-		if (ret < 0)
-			return ret;
+		size = copy_to_iter(src, translated, &iter);
+		if (size != translated)
+			return -EFAULT;
 
 		src += translated;
 		dst += translated;
-- 
MST

