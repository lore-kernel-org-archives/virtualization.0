Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E3821922E4
	for <virtualization@lists.linux.dev>; Wed, 10 Jul 2024 11:42:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720611772; cv=none; b=cSGE1S1YgGjXpUFa8+soI3f6fh9d4w/QT1V6s1DkNLU+yso9un+Oe8sWh+yWemjMZmHnPrqC3horQpV+REbth50rgvT7NwsUsMwoiKokBMWMjohIBik+IkxEBk0Xl0iWrBaO+Vab9QkCsK+rq7TczoMMVISjP7IB4bJ+gB4uzLI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720611772; c=relaxed/simple;
	bh=Z8OR0lbdBCi/RvDNxw7LRIrhiGA1nGWJviAMSO0Hxk0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=OVYgf1oU606+gZxWVDwj/6z9n1etI0DioBdgNvAJEUNAtPSDSZEid640keS4xlfUpemhqOGSVq9I055AGhknvCG5Iey2uz4eBs4WVY5oOHNPk/bS/Mef6qoIK+TRcMLIAVl5JmDSqECNoyZCIHs5RcvqiGZi8emihZ7rgKYJEY4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=arG9pKU/; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="arG9pKU/"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1720611769;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Zsf+nJBsGvYaVbTxbJtn/Kvhd8j6Wn70g60U3gJwhTI=;
	b=arG9pKU/5I6qVcMl/b2CpAfgThulfxa2pm1uL6E7DJzpKCV7JnLkfwaJql7Q9aALrHl6AA
	Z3PtSDL6UAHvcfchJpUO/yyc8pZkT9xwifCyh/3+II7Ydba7N9XrjxTZplXvLkkqr8Jasw
	ihTYKUrAyNb79eFZeb/NSzTOAjM/eIc=
Received: from mail-lj1-f198.google.com (mail-lj1-f198.google.com
 [209.85.208.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-522-psTPz6V1O9yo73fY48Wilw-1; Wed, 10 Jul 2024 07:42:48 -0400
X-MC-Unique: psTPz6V1O9yo73fY48Wilw-1
Received: by mail-lj1-f198.google.com with SMTP id 38308e7fff4ca-2ee9b383ffbso43100101fa.1
        for <virtualization@lists.linux.dev>; Wed, 10 Jul 2024 04:42:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720611767; x=1721216567;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Zsf+nJBsGvYaVbTxbJtn/Kvhd8j6Wn70g60U3gJwhTI=;
        b=qEhJOoNkGZV22usBkzRYh+q3XzIfBfkD/6riHJaUng8SwUJC7Sg2nALsBr43W1liVt
         XlW1Kt5wx1iGlEN+YHAP1heHZ1wBY9z/mUt4pZaW7pLU9E4+P0O8sNk91+lfOJQN12ad
         2cTJT0dlncaQLfD1t2KGbJHmvFv/8DToUih0pKK7HvkFkhDSg3HVr33zTgu0Goj9bj2g
         nl0QuW0MiG8I8U4dTZBw9w6UYb8UzxShxnCEA+kPU8DC34uBP3uIimNiKrhJ810inenN
         QJcya1f0ST0/6KaQmuRO2IMx2+Qax1027VitF6mXwS1HuVht3a8+fNGEICc2PfgLDudY
         YZlQ==
X-Forwarded-Encrypted: i=1; AJvYcCXfiP0jRMpzcA4fUlTfaHN6+XMyPa1+IOOK9NZVvFFRTAzG+50cJ7NSenU6Ha0JzSslcg13J0LirauygE3RufWumhkQ4tmpyMqsgClbMG4=
X-Gm-Message-State: AOJu0Yxmzd8KWnu+QjIZ8jEWKOvaXuz9K6at2VdJ2uuuPaBLhjI+XHTQ
	agPfRew7DLaEHIu8k8A2/CpvdSwd+vgjs0m+OiZF0w72C9b1aoKqMWmSxNilktw0KvpQtA/CKiU
	wG/Nsr9sGeZSh9X2n6+6nl8XLbwWJLiQhQsdSKzHke/SLgMDWpxxczsRLgqwaNLgK
X-Received: by 2002:a2e:9dd3:0:b0:2ec:51b5:27c8 with SMTP id 38308e7fff4ca-2eeb3171537mr34867001fa.32.1720611766799;
        Wed, 10 Jul 2024 04:42:46 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFGL8nfmB7GUlie0Na5yMQMDltOJr5NPNsulJoickaf21VsdTFgnCEG6hEjAm20dRBEO7XxMg==
X-Received: by 2002:a2e:9dd3:0:b0:2ec:51b5:27c8 with SMTP id 38308e7fff4ca-2eeb3171537mr34866781fa.32.1720611766004;
        Wed, 10 Jul 2024 04:42:46 -0700 (PDT)
Received: from redhat.com ([2a02:14f:174:f6ae:a6e3:8cbc:2cbd:b8ff])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-367cdfab753sm5067071f8f.107.2024.07.10.04.42.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Jul 2024 04:42:45 -0700 (PDT)
Date: Wed, 10 Jul 2024 07:42:42 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: linux-kernel@vger.kernel.org
Cc: Alexander Duyck <alexander.h.duyck@linux.intel.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	David Hildenbrand <david@redhat.com>,
	Jason Wang <jasowang@redhat.com>,
	Eugenio =?utf-8?B?UMOpcmV6?= <eperezma@redhat.com>,
	virtualization@lists.linux.dev
Subject: [PATCH v2 1/2] virtio_balloon: add work around for out of spec QEMU
Message-ID: <19d916257b76148f89de7386389eeb7267b1b61c.1720611677.git.mst@redhat.com>
References: <cover.1720611677.git.mst@redhat.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <cover.1720611677.git.mst@redhat.com>
X-Mailer: git-send-email 2.27.0.106.g8ac3dc51b1
X-Mutt-Fcc: =sent
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

QEMU implemented the configuration
	VIRTIO_BALLOON_F_REPORTING && ! VIRTIO_BALLOON_F_FREE_PAGE_HINT
incorrectly: it then uses vq3 for reporting, spec says it is always 4.

This is masked by a corresponding bug in driver:
add a work around as I'm going to try and fix the driver bug.

Message-ID: <cover.1720173841.git.mst@redhat.com>
Fixes: b0c504f15471 ("virtio-balloon: add support for providing free page reports to host")
Cc: "Alexander Duyck" <alexander.h.duyck@linux.intel.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 drivers/virtio/virtio_balloon.c | 19 +++++++++++++++++--
 1 file changed, 17 insertions(+), 2 deletions(-)

diff --git a/drivers/virtio/virtio_balloon.c b/drivers/virtio/virtio_balloon.c
index 54469277ca30..eebeab863697 100644
--- a/drivers/virtio/virtio_balloon.c
+++ b/drivers/virtio/virtio_balloon.c
@@ -589,8 +589,23 @@ static int init_vqs(struct virtio_balloon *vb)
 
 	err = virtio_find_vqs(vb->vdev, VIRTIO_BALLOON_VQ_MAX, vqs,
 			      vqs_info, NULL);
-	if (err)
-		return err;
+	if (err) {
+		/*
+		 * Try to work around QEMU bug which since 2020 confused vq numbers
+		 * when VIRTIO_BALLOON_F_REPORTING but not
+		 * VIRTIO_BALLOON_F_FREE_PAGE_HINT are offered.
+		 */
+		if (virtio_has_feature(vb->vdev, VIRTIO_BALLOON_F_REPORTING) &&
+		    !virtio_has_feature(vb->vdev, VIRTIO_BALLOON_F_FREE_PAGE_HINT)) {
+			vqs_info[VIRTIO_BALLOON_VQ_FREE_PAGE].name = "reporting_vq";
+			vqs_info[VIRTIO_BALLOON_VQ_FREE_PAGE].callback = balloon_ack;
+			err = virtio_find_vqs(vb->vdev,
+					      VIRTIO_BALLOON_VQ_REPORTING, vqs_info, NULL);
+		}
+
+		if (err)
+			return err;
+	}
 
 	vb->inflate_vq = vqs[VIRTIO_BALLOON_VQ_INFLATE];
 	vb->deflate_vq = vqs[VIRTIO_BALLOON_VQ_DEFLATE];
-- 
MST

