Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7EC9C38FA1
	for <virtualization@lists.linux.dev>; Mon, 16 Sep 2024 18:33:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726511588; cv=none; b=mLZWKS4xCmoJqwFhuLfz4ZdpqS7LnMPOTtOQvz9ONda5er9POaL63+2hsyrzeF5MhNrjBo5WmQEtmii4bCH0gfQgPDNBZ2+j05BxSkPKOk/8tRY53/GPrr2G+gc4/dc5nnXEALmdXllnIL0Siy2mnLlqE/Y+DyQKbtBno0pyIzc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726511588; c=relaxed/simple;
	bh=hm48JXEIf4Qh3L7/EGK5bJzmwt2Kku2kiNSqtmDfgs0=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=dZQKO4A9oHzvcZHVCn4KWKCvE8fVbhwaRfXsOi6YGrPM1txPnO+2eCZDj++pTpdrojF4U9sFiD9r7zo0fVgRALrwUoUvXUJP6Y4aymi7e8k2utV9krWyff5m8ezdxwHff9S9AimTR57JsYc9oZYmiWcrmxG8yqBgwViMc8xqkH0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=b3lNWB4t; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="b3lNWB4t"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1726511585;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type;
	bh=X7796kQiN8JkFcyUNsQBv84LTsmrMbLlpHtIF9rU9QA=;
	b=b3lNWB4txhJwp6RqJZg5X/cY6fLfoLtJp8/LCKb/0ru8yyfL6ksILQMYN9zCYIjpy6HPNY
	4KcFPEZq5yCC1FA19wN3AMsSzn0ZJmOSUQpMDeoSoRcWHmxIUAwluc9Xc8CmVt0PjO2KOd
	iCyhXZ7FaFEW/vZtobPY8pTRBkJXMko=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-599-7cD9Qd8PPO-MRbNLlFIjlg-1; Mon, 16 Sep 2024 14:33:03 -0400
X-MC-Unique: 7cD9Qd8PPO-MRbNLlFIjlg-1
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-42cb115566eso33858385e9.2
        for <virtualization@lists.linux.dev>; Mon, 16 Sep 2024 11:33:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726511582; x=1727116382;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=X7796kQiN8JkFcyUNsQBv84LTsmrMbLlpHtIF9rU9QA=;
        b=shgow99c7wKvD8nzuriX59cfFfzba1ixg7BmdzSG3HkrO0oGUitO+HXGZsjeSfpMZF
         7fq51ZFVXp9K1rkySML0xMfQPNEodK5IxDCNIwVD/550Wcw6empwsAn4IbZOCQeohflP
         FpFlluuxwDOVdFY6ycCLb0g6FePhiISK+vlz+TuVufTEeBRqe4zDDr6+B6PBQkW3nBfo
         9BlFEDU0fk6XjLyEcD6d13+7+IW8zGxlwoLJt/7P2EADv++d7c9bAMEpa7YbGJUUSJ7D
         Floj/HVGHODyVov12Mkhb2hew4NtgF5Bsra/C7nnc2Htrij9uiEaaP6E4jdQA3U4pb0T
         plKQ==
X-Forwarded-Encrypted: i=1; AJvYcCXcqA7Zcs7fbmrONhAghuTIydIqYJesCyn7t+YX/pM5HTQ2H+r1B/o4CC2hXM5fTjWwNxAtnXrkFEhNptwgfA==@lists.linux.dev
X-Gm-Message-State: AOJu0YzPntjf4K82RP27DIJ+LN2HcD6qrZ3UZpG3kq1fUqR46MIPXS30
	r1egxqo3VtRSPCW8vkJL0B9j6K2LMd4GJMTxXZE+8RpJ3OD8XBL8a1fYPRwaeqFf4pnVEajziEe
	gTV7ugzBUSElQ0W8/DgH+7mJbGpu1PxUpqJ6LoDYIouCsaHMabqiAYYlAvB643ypeu4ZEtGcR
X-Received: by 2002:a05:600c:4744:b0:42c:b802:47bc with SMTP id 5b1f17b1804b1-42d964e091amr121067875e9.34.1726511582179;
        Mon, 16 Sep 2024 11:33:02 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH4xlYytPGyDiOdL8yrJF86iAslRshUMMEUuSrQQ7TqZWWyRpaqYywxdlMlP7eGHt2ui8gMDA==
X-Received: by 2002:a05:600c:4744:b0:42c:b802:47bc with SMTP id 5b1f17b1804b1-42d964e091amr121067625e9.34.1726511581620;
        Mon, 16 Sep 2024 11:33:01 -0700 (PDT)
Received: from redhat.com ([2a02:14f:1ec:9b4:46f5:ba16:343e:7485])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42d9b15d3ebsm117113315e9.28.2024.09.16.11.32.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Sep 2024 11:33:01 -0700 (PDT)
Date: Mon, 16 Sep 2024 14:32:56 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: linux-kernel@vger.kernel.org
Cc: Amit Shah <amit@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Rusty Russell <rusty@rustcorp.com.au>,
	virtualization@lists.linux.dev
Subject: [PATCH] virtio_console: fix misc probe bugs
Message-ID: <ad982e975a6160ad110c623c016041311ca15b4f.1726511547.git.mst@redhat.com>
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

This fixes the following issue discovered by code review:

after vqs have been created, a buggy device can send an interrupt.

A control vq callback will then try to schedule control_work which has
not been initialized yet. Similarly for config interrupt.  Further, in
and out vq callbacks invoke find_port_by_vq which attempts to take
ports_lock which also has not been initialized.

To fix, init all locks and work before creating vqs.

Fixes: 17634ba25544 ("virtio: console: Add a new MULTIPORT feature, support for generic ports")
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 drivers/char/virtio_console.c | 18 ++++++++++--------
 1 file changed, 10 insertions(+), 8 deletions(-)

diff --git a/drivers/char/virtio_console.c b/drivers/char/virtio_console.c
index de7d720d99fa..bcb05fc44c99 100644
--- a/drivers/char/virtio_console.c
+++ b/drivers/char/virtio_console.c
@@ -2007,25 +2007,27 @@ static int virtcons_probe(struct virtio_device *vdev)
 		multiport = true;
 	}
 
-	err = init_vqs(portdev);
-	if (err < 0) {
-		dev_err(&vdev->dev, "Error %d initializing vqs\n", err);
-		goto free_chrdev;
-	}
-
 	spin_lock_init(&portdev->ports_lock);
 	INIT_LIST_HEAD(&portdev->ports);
 	INIT_LIST_HEAD(&portdev->list);
 
-	virtio_device_ready(portdev->vdev);
-
 	INIT_WORK(&portdev->config_work, &config_work_handler);
 	INIT_WORK(&portdev->control_work, &control_work_handler);
 
 	if (multiport) {
 		spin_lock_init(&portdev->c_ivq_lock);
 		spin_lock_init(&portdev->c_ovq_lock);
+	}
 
+	err = init_vqs(portdev);
+	if (err < 0) {
+		dev_err(&vdev->dev, "Error %d initializing vqs\n", err);
+		goto free_chrdev;
+	}
+
+	virtio_device_ready(portdev->vdev);
+
+	if (multiport) {
 		err = fill_queue(portdev->c_ivq, &portdev->c_ivq_lock);
 		if (err < 0) {
 			dev_err(&vdev->dev,
-- 
MST

