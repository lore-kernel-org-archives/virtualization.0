Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46FF815573D
	for <virtualization@lists.linux.dev>; Wed, 15 May 2024 15:05:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715785554; cv=none; b=elgAaPubzeyaVsTx0TWdFr4UBQ7oBl2U0W/0VVPaQhaaJM1gFSCwU8oyOj1JGs+Xef+kRQTgvrGPImKFvowaSP8UwivIgQb82kNXe1hYtqqBksCVEzTGq9hmKboOg4vmqVdbzhcNpZcGd/vopyDHUdlo7Dxjv2cVtVXZCr9vJiQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715785554; c=relaxed/simple;
	bh=Eqhliyv/rLaqDzkaLcjCJEDibkGNoMMtCnsez51KbII=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=VxmmRbQDOuYX5BvqPWQVVrXE9YP9sdazS0SaGHSgUUfcvItPiq70AwGJKKXuxV1cs4LE+p+Aq8XU7nibTkhMVTaHZAvNBRbukwPBSvd/CVfxs/Ya+LqdM8qqJgJ97Nz3oAt7oyVyG6/h70p7AO1dTXUYENk4idBYWPlqqevpsq4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=RaKnAD0u; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="RaKnAD0u"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1715785551;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type;
	bh=5HsQnBBLUP3Pazt+byzwwgyn37KXCpOuxjPpikdkNik=;
	b=RaKnAD0upOAnyXuKS4DHDCqG/DA2VwmPONtYPreMeE1RGJKuHlvxg6atgk/fJDos5XmdxZ
	NCXlntdxzuLkQSYxmZSsdCMlVjfDwgCllYxE0/gxYUFT5X/KEnUBhzEkmGQSLU+QGTmp38
	NCgHQbeqWEH9SSUujB5DQZoe2T8ezSs=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-622-oHVdWq0FNQG-SXPfuwh1Vg-1; Wed, 15 May 2024 11:05:48 -0400
X-MC-Unique: oHVdWq0FNQG-SXPfuwh1Vg-1
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-41ec8ef128fso36237765e9.0
        for <virtualization@lists.linux.dev>; Wed, 15 May 2024 08:05:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715785547; x=1716390347;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=5HsQnBBLUP3Pazt+byzwwgyn37KXCpOuxjPpikdkNik=;
        b=libbVrpgntc7Exv7/Gr4oGJcwoIWfc/LExFlZFWFZgSTKZtW4I6UaFCwVWntw9BOKd
         xGNo3SxNyi8HM7aDJdXu7aET+I5HIOhq62cPoiEeDuyZMfEOTJ+e2iy+15FeEFUEVPTy
         PQNz0KoROVed52oMQYtxSmn2amK4lULrTELJaQ7j/H8fl7FvrNHuS2Ygegu7h/4jFoH6
         lv5lnH2P75udoyaP7dfedBWqxN6muQ2n/TTr6YKbYic91NGqYTDXv/2n0+6qVkcuTzJW
         0QV0H78ZOz6SkGGxwNzaMkOlGzB6R0qTyBrYrKEV35Xa2WPsUz15yalDeSZJMFXljgEt
         +ebw==
X-Forwarded-Encrypted: i=1; AJvYcCXiy9rIk46fARdNNjQzbbyanUdU+SYt1kWu4WdwaE14xDhbG6mIFCE/u+S/FuKYvBimPjER/k0bVaNjB+t52kZwITfHBRugw/6/s20iUdQ=
X-Gm-Message-State: AOJu0Yx+39Afn6w8PXdMFm/ZART0jievp8OxjpwKCFECnCsVtQxlwxQc
	K3Ame+hCQRb3EHFwyriA4M1LwldsOvHKdpYcv9jVvHBzaZXg3GtMxV5Jtv43MpwiC99BH1hQ5YP
	5k8nkzyaxqdBG1rnmbw0nXpuy22HXI5izj40XamsoWIakAuZcwDWS0lh/tNIdJ8dt
X-Received: by 2002:a05:600c:a44:b0:41a:34c3:2297 with SMTP id 5b1f17b1804b1-41fea93a34cmr139868005e9.5.1715785547162;
        Wed, 15 May 2024 08:05:47 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFwcKYJU04KRN+C9m9RrjwdUumM+NzjuDj85eoasrKYaMbDWv5ZX8CZUBelGxUEWCXHzSMp8A==
X-Received: by 2002:a05:600c:a44:b0:41a:34c3:2297 with SMTP id 5b1f17b1804b1-41fea93a34cmr139867595e9.5.1715785546575;
        Wed, 15 May 2024 08:05:46 -0700 (PDT)
Received: from redhat.com ([2a02:14f:175:c01e:6df5:7e14:ad03:85bd])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-41ff7a840d2sm197154985e9.39.2024.05.15.08.05.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 May 2024 08:05:45 -0700 (PDT)
Date: Wed, 15 May 2024 11:05:43 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: linux-kernel@vger.kernel.org
Cc: syzbot+6c21aeb59d0e82eb2782@syzkaller.appspotmail.com,
	Jeongjun Park <aha310510@gmail.com>,
	Arseny Krasnov <arseny.krasnov@kaspersky.com>,
	"David S . Miller" <davem@davemloft.net>,
	Stefan Hajnoczi <stefanha@redhat.com>,
	Stefano Garzarella <sgarzare@redhat.com>,
	Jason Wang <jasowang@redhat.com>,
	Eugenio =?utf-8?B?UMOpcmV6?= <eperezma@redhat.com>,
	kvm@vger.kernel.org, virtualization@lists.linux.dev,
	netdev@vger.kernel.org
Subject: [PATCH] vhost/vsock: always initialize seqpacket_allow
Message-ID: <bcc17a060d93b198d8a17a9b87b593f41337ee28.1715785488.git.mst@redhat.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Mailer: git-send-email 2.27.0.106.g8ac3dc51b1
X-Mutt-Fcc: =sent
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

There are two issues around seqpacket_allow:
1. seqpacket_allow is not initialized when socket is
   created. Thus if features are never set, it will be
   read uninitialized.
2. if VIRTIO_VSOCK_F_SEQPACKET is set and then cleared,
   then seqpacket_allow will not be cleared appropriately
   (existing apps I know about don't usually do this but
    it's legal and there's no way to be sure no one relies
    on this).

To fix:
	- initialize seqpacket_allow after allocation
	- set it unconditionally in set_features

Reported-by: syzbot+6c21aeb59d0e82eb2782@syzkaller.appspotmail.com
Reported-by: Jeongjun Park <aha310510@gmail.com>
Fixes: ced7b713711f ("vhost/vsock: support SEQPACKET for transport").
Cc: Arseny Krasnov <arseny.krasnov@kaspersky.com>
Cc: David S. Miller <davem@davemloft.net>
Cc: Stefan Hajnoczi <stefanha@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
Acked-by: Arseniy Krasnov <avkrasnov@salutedevices.com>
Tested-by: Arseniy Krasnov <avkrasnov@salutedevices.com>

---


Reposting now it's been tested.

 drivers/vhost/vsock.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/vhost/vsock.c b/drivers/vhost/vsock.c
index ec20ecff85c7..bf664ec9341b 100644
--- a/drivers/vhost/vsock.c
+++ b/drivers/vhost/vsock.c
@@ -667,6 +667,7 @@ static int vhost_vsock_dev_open(struct inode *inode, struct file *file)
 	}
 
 	vsock->guest_cid = 0; /* no CID assigned yet */
+	vsock->seqpacket_allow = false;
 
 	atomic_set(&vsock->queued_replies, 0);
 
@@ -810,8 +811,7 @@ static int vhost_vsock_set_features(struct vhost_vsock *vsock, u64 features)
 			goto err;
 	}
 
-	if (features & (1ULL << VIRTIO_VSOCK_F_SEQPACKET))
-		vsock->seqpacket_allow = true;
+	vsock->seqpacket_allow = features & (1ULL << VIRTIO_VSOCK_F_SEQPACKET);
 
 	for (i = 0; i < ARRAY_SIZE(vsock->vqs); i++) {
 		vq = &vsock->vqs[i];
-- 
MST

