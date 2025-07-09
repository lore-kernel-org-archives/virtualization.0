Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AEEE923FC41
	for <virtualization@lists.linux.dev>; Wed,  9 Jul 2025 20:55:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752094539; cv=none; b=M6z8UoXpDkqc2iKnPzrgdwl4M/+plMlgR5h9X9Q7JeHu2+FSPkdBwxaHuUG699J7ncZgJ0LuLLi4TMaOoYjEAynJFKRPQ24celqSK4nCh/1oOAHIP1LG0HNfFD5medGMz64JQbjCyDsaRlv5+4SLwfADRGCMTcB3g2NBAEpI6HM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752094539; c=relaxed/simple;
	bh=PUGyVN4OJqSqheGuV7u25IOAaInhgOsYis9mxDJwLeY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=m/idfmssICi4JZqRGPrNaRrAI3ogDexFU7anBnR6IL0X3JaIx7zxMJpedHotPrR21cQdbGoqe2yMVk9PxVnneucNSNcU+0f/BHJ44V1ljIxxSPW3emae8K2No7JcXVJ7IX+rEL+qYJ6/BoL4RS+B6+YVZQCz1NIPSv7bVYf3jpM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Yur/WbOc; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Yur/WbOc"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1752094536;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Y/PjBes3xfnhRnjsZQuw1IljDm3PZO9lLi6jhdLLbvQ=;
	b=Yur/WbOc0GGe2uQTkZBdvhuhqbTPO+ePWJQq2p/NWJtq9CLCpiBrO4knP8ccw3lKJPt1U/
	am9Yu1yp2E1gjGVq9I+cJFOQ3F1ymjKv2poS7UllYwxTjjPlZFcZ7+azG1cSaCRq1ZbVGg
	bZ8NPGtw9GsDEdo1Wh78FFZZzmyYM0w=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-455-bjyXOdYTMhajRq34V3rC7w-1; Wed, 09 Jul 2025 16:55:35 -0400
X-MC-Unique: bjyXOdYTMhajRq34V3rC7w-1
X-Mimecast-MFC-AGG-ID: bjyXOdYTMhajRq34V3rC7w_1752094534
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-45359bfe631so1107435e9.0
        for <virtualization@lists.linux.dev>; Wed, 09 Jul 2025 13:55:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752094534; x=1752699334;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Y/PjBes3xfnhRnjsZQuw1IljDm3PZO9lLi6jhdLLbvQ=;
        b=u4BsQrV+eKvL+h7efhLPQjMo9iy9tU6AMicp3EkHWWekcWDJYoGlx1ZZS0eTRn+1mX
         La7Op4qoJF4CYQBZWMxiOVgweFiSpOGR8F5Gb8ymacRhfA+53Q9QtXpPxjffdKuANR81
         +LVByIle+Le+iOELW9WEiBGiMPfXIWVkmGMqmWNSfF7vy6BsqHtrlizVYcKBd0epGvv7
         G4aQG5LshvgYFEJm68rR4Vgmj0y0V7MJ1h7UqwCzPcNvEBWSkRo+AYdk+2bhVS8/88kz
         jnEehidrE5jLCW4vJyqg1q/4nl+CFc2IA0i0QAmlAyhtTXFTFllV39VIsHTgxwDyDemS
         YUpw==
X-Forwarded-Encrypted: i=1; AJvYcCWMPkpJ6y3Kmst9ji/IKxAFSygxsxLNLMFij0/8cGOpF0UpBu5hn2flLN0mXI3+cWma00byECy4yhTWnOtqjw==@lists.linux.dev
X-Gm-Message-State: AOJu0YzuD0eMdRV40zBT7HOY1J705R5uwlhH7MbaB2AEjV/w/kgdnZct
	VQdTdXmUomaHDc073+0+nzdVNKa/q+3ajc7Adqrp4AEkiKtPhGvbH1IyOudw3h2Q1cJ37bzDINW
	MoJp+Losua7o8rN9wGJWanvbU9jlN1aV4iWftLqSgnj5oige/St9Reb+Y+LaFlJqesW49
X-Gm-Gg: ASbGncsrxVrjaZXB2czfUvNFiciSAoGqUejAoigqZ7/IVrKA0vF7SBVskeLQ/bsl5ra
	Ye/SPP7pAjPunPe/LdomBeF70I9MymOgJNsbajiVcEc0mpqVu79rs+fRuTTdmkyOOBnBvRPq6E5
	Wo/134LvCbsJzvbRSlVcgrbUu3QfbjsuB50WWkTv7DFUAJjlkgNkx4eaPgWRVBsmXctVoG/GQyN
	UBhrWdoZVpp2LVkljjH7nj+NzXelBZIXoAniRybJjMl/mtLOLCK+C69ur4gN12X6DyK3iM2Jkq4
	JPWBgrcExTh0vPQ=
X-Received: by 2002:a05:600c:19d1:b0:441:d4e8:76c6 with SMTP id 5b1f17b1804b1-454d53f3136mr41919315e9.30.1752094534107;
        Wed, 09 Jul 2025 13:55:34 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGvtzRfPYPigjuG7evCZ9GSCMu34t4nH9W9Zvmdr8ctw27FNFQTVrA3clj+tm0lA0zRoYKbtg==
X-Received: by 2002:a05:600c:19d1:b0:441:d4e8:76c6 with SMTP id 5b1f17b1804b1-454d53f3136mr41919085e9.30.1752094533725;
        Wed, 09 Jul 2025 13:55:33 -0700 (PDT)
Received: from redhat.com ([2a0d:6fc0:150d:fc00:de3:4725:47c6:6809])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3b47225a2dcsm17021160f8f.71.2025.07.09.13.55.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Jul 2025 13:55:33 -0700 (PDT)
Date: Wed, 9 Jul 2025 16:55:31 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: linux-kernel@vger.kernel.org
Cc: Lukas Wunner <lukas@wunner.de>, Keith Busch <kbusch@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Parav Pandit <parav@nvidia.com>, virtualization@lists.linux.dev,
	stefanha@redhat.com, alok.a.tiwari@oracle.com,
	Jason Wang <jasowang@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	Eugenio =?utf-8?B?UMOpcmV6?= <eperezma@redhat.com>
Subject: [PATCH RFC v5 3/5] virtio: pack config changed flags
Message-ID: <65da7bde75cdd7ca7ecbca7ca10f51277b44f86f.1752094439.git.mst@redhat.com>
References: <cover.1752094439.git.mst@redhat.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <cover.1752094439.git.mst@redhat.com>
X-Mailer: git-send-email 2.27.0.106.g8ac3dc51b1
X-Mutt-Fcc: =sent
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: 2j9WHEFTRdKc8x9Co31DDrw5LmlT1mYjwg6VJsDgn14_1752094534
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

In anticipation of adding more, use bit-fields instead of bool.

Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 include/linux/virtio.h | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/include/linux/virtio.h b/include/linux/virtio.h
index 64cb4b04be7a..be0beb16b487 100644
--- a/include/linux/virtio.h
+++ b/include/linux/virtio.h
@@ -149,9 +149,9 @@ struct virtio_admin_cmd {
 struct virtio_device {
 	int index;
 	bool failed;
-	bool config_core_enabled;
-	bool config_driver_disabled;
-	bool config_change_pending;
+	u8 config_core_enabled:1;
+	u8 config_driver_disabled:1;
+	u8 config_change_pending:1;
 	spinlock_t config_lock;
 	spinlock_t vqs_list_lock;
 	struct device dev;
-- 
MST

