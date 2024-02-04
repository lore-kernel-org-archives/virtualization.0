Received: from mail-pj1-f48.google.com (mail-pj1-f48.google.com [209.85.216.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70B96286A6
	for <virtualization@lists.linux.dev>; Sun,  4 Feb 2024 20:52:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707079947; cv=none; b=PmHRdsHMUSbHxZRjW03LiMJ61xN6FkbSbSN+c6GpdJ4j4ARsyIdokRSu5Qh7hDVOO4Yn7qRA6wD/dj5SJobloN1u3xnLOEaR7fdYTPuhXh29B1BvTFO/ed6m4ehYoBT6SHywJ5rVmnzsaF+0FUevA67/LFEL3LqsiBaJ7BMYt6Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707079947; c=relaxed/simple;
	bh=sbDgyhLemt9WBM8/41UER9Vp4nTwIRVkedKPpoL3NUQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=u7AIIstKn0IxZVNx4CBGO8AVJatfu52n0EF6NycDPDukvRD/A4bcm+4iHNvGdsGNvqrSyX9t+dvwSQwc1RvDrY0wD3ZMUNeV6aheBDbgAXjunhF70ZKXiUYxbsQN5tCf8l2SPjdtopIIzLRx/a0XFnJTydETBMfwXiM/Vt37DgQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=marliere.net; spf=pass smtp.mailfrom=gmail.com; dkim=fail (0-bit key) header.d=marliere.net header.i=@marliere.net header.b=K4DOjjmC reason="key not found in DNS"; arc=none smtp.client-ip=209.85.216.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=marliere.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=marliere.net header.i=@marliere.net header.b="K4DOjjmC"
Received: by mail-pj1-f48.google.com with SMTP id 98e67ed59e1d1-29080973530so3067525a91.1
        for <virtualization@lists.linux.dev>; Sun, 04 Feb 2024 12:52:24 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707079943; x=1707684743;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:dkim-signature:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ClGn8ecbU90TEqn2u6KZZZz4O47dZbbXURgIbg3kG2k=;
        b=Hxg5zy5hr8pjugPfXjrlRuuHjiw7DAMNmMBwAm5vmxIGO8kLYJu6apLVaPhDHrdWRA
         ghYLrZm1DwuH81VOoOS+Zdq7jyDbcu70ciINeitmLyPuYcp3ZUlU2csso5SrvgFLGd7x
         JxMy04yjLMAwHbLiSArKZ8bpfz5TI2pSFfiedqw2O9omQN/XscjmXqr+cH6EhuCQY8tG
         KXeQuS+1yGALrWom9AzfHezVnputZlVGiju9N8GzPK1NOKyL2fA1dm7a1PPo5H3DRwfu
         JrRgAngFMflM7dvLG1NXJb8ziNVk0nXfUcEU/9VsR158zPoS4cGmNh8294seE7k0VSCT
         hFew==
X-Gm-Message-State: AOJu0Yyr6C4frtAcvqAv14LvtZJT0C48AOg5LKOFb+Pw2Ryx45brZ1T7
	DjgxnmEMBtjKRRncG7R4opeJZrGkZLYS/La4zhpObyTlFC+oVOiQ
X-Google-Smtp-Source: AGHT+IGwI+tmMj1Hb+S7XDaQ6Osr7BoUGeig7QhjNWvkOD5fdQf33VJmNq/7osImTH9HJ7rzv3UrHA==
X-Received: by 2002:a17:90a:d70f:b0:296:1bf4:e797 with SMTP id y15-20020a17090ad70f00b002961bf4e797mr7396926pju.39.1707079943581;
        Sun, 04 Feb 2024 12:52:23 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCXZptgEgoAqPO/fTbxR4ln9UrXnO4Z/I65NwR863eqa8UnQwb55H/HmRC+gbiPdkYQo+ERurQuxcPVnLToxA1a78RFgjLXkD8uJdvh9SGW0yLgxztRw/XPWSFrLZ9u909Z4zH2qjlespfmZerVw5m2Ubfpu8C57bQ7ZVDjKvI/eEuA/Et+PM6MBSdK7OgICbJP9hvYmUfAXZ7c=
Received: from mail.marliere.net ([24.199.118.162])
        by smtp.gmail.com with ESMTPSA id se13-20020a17090b518d00b0028d8fa0171asm3697044pjb.35.2024.02.04.12.52.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 04 Feb 2024 12:52:23 -0800 (PST)
From: "Ricardo B. Marliere" <ricardo@marliere.net>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marliere.net;
	s=2023; t=1707079942;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=ClGn8ecbU90TEqn2u6KZZZz4O47dZbbXURgIbg3kG2k=;
	b=K4DOjjmC2N94iaAG09XzaTmx6ylEsNVITmdO1FSvxeS6zhOM9x9vVpd1JoI27a7zk06/+2
	XjHVQxVYAmQCSeJuxRizYm4TiDjgYu9eMiarzPPgykvSY4mkAzTdjszsobhq1K9vqUZEk6
	cQLyAK0qfKZ2acuMqocOLGMRp1Wt3g4xORUmZw39jB9jabwQ+oycAPAMpFq/pPV+GRJenx
	nyIBxubFVPOluzPeSj8Fu4VTg7xAAC3T50QuuOBxFn/hT2wQ4hHOfiLfSLrBcmOf+kMnCU
	/ao19X2G/pIzFhQst3UguCD7crgNBDkmNgXcQCWbhwfvbDq9/CeQNS0/IRG4rw==
Authentication-Results: ORIGINATING;
	auth=pass smtp.auth=ricardo@marliere.net smtp.mailfrom=ricardo@marliere.net
Date: Sun, 04 Feb 2024 17:52:51 -0300
Subject: [PATCH] virtio: make virtio_bus const
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240204-bus_cleanup-virtio-v1-1-3bcb2212aaa0@marliere.net>
X-B4-Tracking: v=1; b=H4sIACL5v2UC/x3MTQqAIBBA4avErBMmk/6uEhFpYw2EhVYE0t2Tl
 t/ivQiBPFOALovg6ebAu0so8gzMOrmFBM/JIFEqlKiEvsJoNprcdYib/cm7aC3WlSmNxqqBFB6
 eLD//tB/e9wPxXdFUZAAAAA==
To: "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>, 
 Xuan Zhuo <xuanzhuo@linux.alibaba.com>
Cc: virtualization@lists.linux.dev, linux-kernel@vger.kernel.org, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 "Ricardo B. Marliere" <ricardo@marliere.net>
X-Developer-Signature: v=1; a=openpgp-sha256; l=1108; i=ricardo@marliere.net;
 h=from:subject:message-id; bh=sbDgyhLemt9WBM8/41UER9Vp4nTwIRVkedKPpoL3NUQ=;
 b=owEBbQKS/ZANAwAKAckLinxjhlimAcsmYgBlv/kke1/UbX16S1OwqSFTauQH9I5P+fSdkKA8e
 VF6yGm5+jyJAjMEAAEKAB0WIQQDCo6eQk7jwGVXh+HJC4p8Y4ZYpgUCZb/5JAAKCRDJC4p8Y4ZY
 pscUD/49sG93DuRWQirQHxFOKP5JYeZvBKitNbaw1hjWE1YXjwlNU1541CqegIAAaJGup9Wc3eZ
 u3Ia3zlN+DJN4sXY4AaKRiGPcYvKaXik343Srgo9diDhep00X5sSKUQWUMPET3STdNSI1XCTLi2
 PA59oyxD9tpOlrCdOpF9pWENfM2WPd0kfIl99ejXJQ2qc1VUK0b+4xsvN/KtF2dkCVVM0qDgbT8
 qnWJP0tVWPKacoNpr+kd4VcsGgGMks7iJtwEUUYMGHpaGWFIVY+c+QO3nWWMLs60kxQ3Jl/FcWa
 MYyk8NqiIXeuUYmTjDm7z1ZAtvbvXLg4YYbP1ZEqLBL61ij+jz2rp7gKAX8Vs2jOp8a0vjX/z4R
 GGFFKL5gqebTjNqNFOsRu9duN4sF3A7QL238R68eeqEfKcI3+mZ2Ffr5aoXp7g7xPfZM281sILZ
 EAT+K4O8dT+sTe/HdImQ/dtisX7+zmbGDUuCtaDl6ClfxMT79YrSM92Hra1xSmSbnCHQ9NIdCJa
 1tWDKnWsBTbFBS/Gevd4FpYjYwMh8ahiUPmNW5MUQmxTAaiqzY4PBvVvQ2yMHEjtKqiKuXU6jgw
 wkhmVWkfOLKYIua9gyZQ/JaBIKReOsSMdkrr5fIaFpscWyAHnzq5gfYzuWk1EOBRHVkOWBUzKEv
 thYsbSkh8c6/qtg==
X-Developer-Key: i=ricardo@marliere.net; a=openpgp;
 fpr=030A8E9E424EE3C0655787E1C90B8A7C638658A6

Now that the driver core can properly handle constant struct bus_type,
move the virtio_bus variable to be a constant structure as well,
placing it into read-only memory which can not be modified at runtime.

Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Suggested-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Ricardo B. Marliere <ricardo@marliere.net>
---
 drivers/virtio/virtio.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/virtio/virtio.c b/drivers/virtio/virtio.c
index f4080692b351..a68e6556f71b 100644
--- a/drivers/virtio/virtio.c
+++ b/drivers/virtio/virtio.c
@@ -353,7 +353,7 @@ static void virtio_dev_remove(struct device *_d)
 	of_node_put(dev->dev.of_node);
 }
 
-static struct bus_type virtio_bus = {
+static const struct bus_type virtio_bus = {
 	.name  = "virtio",
 	.match = virtio_dev_match,
 	.dev_groups = virtio_dev_groups,

---
base-commit: 41b9fb381a486360b2daaec0c7480f8e3ff72bc7
change-id: 20240204-bus_cleanup-virtio-9f076c3cb068

Best regards,
-- 
Ricardo B. Marliere <ricardo@marliere.net>

