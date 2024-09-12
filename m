Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BCA41AD9CB
	for <virtualization@lists.linux.dev>; Thu, 12 Sep 2024 14:45:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726152356; cv=none; b=Uxhmjv5lBrgaHj33mNdd4NVGFqy5+0LufiCrSxT5qe3W1hmeYwGPINsBr+XnQYYoPgb1KdBDcADbq0HRNL2AIHHuqMuqtlnphAM3PyyxWPxutxZXzUI1wYYAhGL7Glugn3NuCFjx6LhFHqIVE7to9zMKbHpgoSZ4ncep/TOt1xY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726152356; c=relaxed/simple;
	bh=bDNWpJKzhrF3VLCZRlkouzN2c2h29O1kt92gs8u0Cd8=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=i5808sd8n9AhftKxLCml3uu5VgSQSwK69WdG6qfa3owWNQTD54vPCqB5zXpV8+BzYoSWY2qt0RmNNKhQgoo2bFFPTndWJFPhniJFwlaTwSwph1qmoLtWhgeV4bpD+l8NuXopT8FbSyf9mYGtG7FS/3DBhCS2aNHncOKtrwceewM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=i/UZUTTh; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="i/UZUTTh"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1726152353;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type;
	bh=Gxo+YbK0LSE4pTUF6ewOWgrq+3ntyBNDfI8Bopy+BNM=;
	b=i/UZUTTh02CPj4lvgqVczXlCnFLsypfQrxdoVth/j3cU4vzfMCpwf3Wr5OwZPVm2+jpquN
	CBzrKYKw1wM8MM/A/5frmMUvbkL/wY78POsMg8DiP+//ocsZA3ppoygd3K4ia82scKQwTQ
	xZfr8bPsErxTzvlejJeqX3d1RTm1b9A=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-323-RSrycIqFMV6iap83FrY2HA-1; Thu, 12 Sep 2024 10:45:49 -0400
X-MC-Unique: RSrycIqFMV6iap83FrY2HA-1
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-42cceb06940so7866695e9.0
        for <virtualization@lists.linux.dev>; Thu, 12 Sep 2024 07:45:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726152349; x=1726757149;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Gxo+YbK0LSE4pTUF6ewOWgrq+3ntyBNDfI8Bopy+BNM=;
        b=jqv66wSyyN5UqFGFLDNY2/QnxepRXwSallhOEXvx4gwsB1vpYa28LmRQQ06+i4kLa4
         9EWL4kACSTFdIrFFHZvmwKEG0xRUtin4XCktXGnnrFu8Fc/YnjNlu+wYkOUaiT2XKXFa
         yJQH5L4UTjCW9az+OrezokwoAwekkwqvxWZEa+iozcFkZqmZqEgLTFjA8DcturSlT0/n
         u0cmn2ZzHm2detugkAoUEthI3+1T7iEYLoMRP2o/aTx7ZOtyFhiej3N/i402mUwnmkow
         L7WxSMff2Tt2Qinz3T4YGpSkwyOGqu2aB4H09ISDRMSFEC55dkVpiH5InqD0HobOGKLX
         mlmg==
X-Forwarded-Encrypted: i=1; AJvYcCWSpTttJE1zfi57x5474642OU5Hi0QoG3X1VCYr9w9nWEuEAgcw/vhqSi4eniDFx/P4ZpiB4Y29MGzdXhYL6w==@lists.linux.dev
X-Gm-Message-State: AOJu0Yxm7kLhf3ot9uWRNQoPHuFMi/+AtYR/YqV4E86TO97hOVoRGrzn
	6tqLndI2MRCt+HKeOu+Rx/dLJ8it/nWEq8BnkVyQIp8r5pHWcacCx5nogYYZtefAMnOUNHxl77Z
	CGWgcgJvF1/9SLDFM/o+J/LQVilwdmkT9fJCwoXar68dpsfcNZwJAyxFwvlQVa4mn
X-Received: by 2002:a05:600c:3581:b0:42c:c401:6d67 with SMTP id 5b1f17b1804b1-42cdb4e6966mr24733255e9.6.1726152348611;
        Thu, 12 Sep 2024 07:45:48 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFSTr4UGE5sTddlBtoIDKITpSKo52BFe23QJb7ewHaHb9juwa9mzhKxt4NIv4kesVcFbq/Fzg==
X-Received: by 2002:a05:600c:3581:b0:42c:c401:6d67 with SMTP id 5b1f17b1804b1-42cdb4e6966mr24732825e9.6.1726152347628;
        Thu, 12 Sep 2024 07:45:47 -0700 (PDT)
Received: from redhat.com ([2a02:14f:177:45a6:a4e6:75a4:a286:2745])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42cb1b172c7sm161732395e9.35.2024.09.12.07.45.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Sep 2024 07:45:47 -0700 (PDT)
Date: Thu, 12 Sep 2024 10:45:44 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: linux-kernel@vger.kernel.org
Cc: Marco Elver <elver@google.com>,
	syzbot+8a02104389c2e0ef5049@syzkaller.appspotmail.com,
	Jason Wang <jasowang@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	Eugenio =?utf-8?B?UMOpcmV6?= <eperezma@redhat.com>,
	virtualization@lists.linux.dev
Subject: [PATCH] virtio_ring: tag event_triggered as racy for KCSAN
Message-ID: <39fbceb9a794b7c412b17c4ac6c2dd285d1bd3e5.1726152335.git.mst@redhat.com>
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

event_triggered is fundamentally racy. There are races of 2 types:
1. vq processing can read false value while interrupt
   triggered and set it to true.
   result will be a bit of extra work when disabling cbs, no big deal.

1. vq processing can set false value then interrupt
   immediately sets true value
   since interrupt then triggers a callback which will
   process buffers, this is also not an issue.

However, looks like KCSAN isn't smart enough to figure this out.
Tag the field __data_racy for now.
We should probably look at ways to make this more straight-forwardly
correct.

Cc: Marco Elver <elver@google.com>
Reported-by: syzbot+8a02104389c2e0ef5049@syzkaller.appspotmail.com
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 drivers/virtio/virtio_ring.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/virtio/virtio_ring.c b/drivers/virtio/virtio_ring.c
index be7309b1e860..724aa9c27c6b 100644
--- a/drivers/virtio/virtio_ring.c
+++ b/drivers/virtio/virtio_ring.c
@@ -194,7 +194,7 @@ struct vring_virtqueue {
 	u16 last_used_idx;
 
 	/* Hint for event idx: already triggered no need to disable. */
-	bool event_triggered;
+	bool __data_racy event_triggered;
 
 	union {
 		/* Available for split ring */
-- 
MST

