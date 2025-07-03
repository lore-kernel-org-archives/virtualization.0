Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DC252D9485
	for <virtualization@lists.linux.dev>; Thu,  3 Jul 2025 09:26:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751534802; cv=none; b=Ok97qYdfn0Smvhe50/QnkTktoD7aXIGKR7vjc624Y2VOxz21GoPk/EJG4jln1A1Hv6lCFlDl0v+bLcq+OYq2d8hgOrE1snyiBHW6qAlY7gjHCrzCd/ZnHhazwRkmLyNMA2yhshOyi2JRhO6jd8mAiD+6uZNgYNEJZXIFMf79gXo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751534802; c=relaxed/simple;
	bh=PUGyVN4OJqSqheGuV7u25IOAaInhgOsYis9mxDJwLeY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=o28TGSAICpLft/pdi0fRdOD3jQMf21Hw651BAlbMTmJc5Iau/C3I8d9IBnVFKJbW76bwRMfU5XE9BzvNrkgy6O+8cFd/WkOEkwKcUvXJKUtinEcP44dM1sTb0xsSEOeTKY3BbMBb9L1o2d/y7cvLYYFPSBnzIr84dWB7G0ojW2k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=UknM0xvy; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="UknM0xvy"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1751534799;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Y/PjBes3xfnhRnjsZQuw1IljDm3PZO9lLi6jhdLLbvQ=;
	b=UknM0xvy7TDVmsoNgTq5x2GxZlHTWN4bRqIPdc3ey10aGy24ukVFpmx0CWb5tBRXpIV2vT
	jUKqSCbiymrrwpGMQp4Bv698iYuYGVuC0h1Jxm6673CLs5jTmQR9SAOaneAF6Uc5EozzDP
	kjMDb+kHw3fMjs42ln+8xJp7qNrTjOU=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-390-l1lh5zkDOPmbktLibHW5Ew-1; Thu, 03 Jul 2025 05:26:36 -0400
X-MC-Unique: l1lh5zkDOPmbktLibHW5Ew-1
X-Mimecast-MFC-AGG-ID: l1lh5zkDOPmbktLibHW5Ew_1751534795
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-3a4eeed54c2so3859941f8f.3
        for <virtualization@lists.linux.dev>; Thu, 03 Jul 2025 02:26:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751534795; x=1752139595;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Y/PjBes3xfnhRnjsZQuw1IljDm3PZO9lLi6jhdLLbvQ=;
        b=AMNhPsHk5a+LZjrkF8Meef/gOVZ2JgHQCMQ6yx8/yqc99La9UTYtEQWb8iMmW0gpVy
         yQHUszF+m2aHbXVVCcaMHiHyphCVm3vyioGGijGGZ6mCyY1bpMpKPs2uWWH+C9KeFZGv
         wCw9ODAItYg9MqZNPelL78OK41P6f8szVINzJyuErYwR9tzIkcoNJ6oeQDtNJHvY/sLx
         /n1ZBW42YLlq06zZQEIkxKIFVBHMoZ6fOP8Yg6Nc+6fyUoej85bfItjNSGb/5nDKYGCU
         bclsWg7JyJMnHjFtEGfErpIr4soPYcUnpQxAPqNr27XuAuKZs4vbM7GNbgQepFzLQdRX
         sY4w==
X-Forwarded-Encrypted: i=1; AJvYcCVuBr8fFSOgNebckolycVlj4RMYkaKnjA2GKHUzWgXk8dkhlSo0kmgwjSmxbANz8saj3Hn0Pb6DyfMfWmpGkw==@lists.linux.dev
X-Gm-Message-State: AOJu0YzKyjlovHBe7eqgwaXL/GdA+gH+7FcOS2to50Y8h7X/1Ay31goP
	NJnz01mYacO/t4OsRY1J2e3CHwiNg/hg04DTQ5+nNzarMBljM83VzFWIREi76SNA2udi2ZtORw/
	xYG4Zfwds5x+LrD3qZhZnDXqz6hJIfsqNbIRCvUOWfzlHBLXOPbBr4PIFC/T5LaqsrMX6
X-Gm-Gg: ASbGncv5C/2VBz3I1W0LRw71HG2sEqbUG2ev+K4jYPs9EHnLIsmvXKSHPS4V2kNMqaH
	/H/IymlHXKrsCtP25+GeblzLjjcRX2W9I7QuqQPDrTQJvT/xa6BJmcMIlBT7sSRvOAPi7ku2nhH
	FaXlZNnRsCPE86yfgXvBSKuCE1lVPiUbmV7wawOtwqg0oyg3MWwShyuQKp9rzZ9VzQL3Fem5vrL
	RKfCKsD03CAmKFa/4SSsvmS0w9na0MT7J43X6g4ZKHQx+yI2L7E/R6XvyYM0yzYitB+lEZkpy+x
	TwEapJHxdYk7pqH4
X-Received: by 2002:a05:6000:22c5:b0:3a3:6e85:a529 with SMTP id ffacd0b85a97d-3b32e5209b1mr2046003f8f.51.1751534795012;
        Thu, 03 Jul 2025 02:26:35 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGfswN2F1WSnecEwI4IFFwD4JVrRDEDFHdlQdrbIQbLQDH7ysTzQt9L3uJYclxAObpUi6v/jw==
X-Received: by 2002:a05:6000:22c5:b0:3a3:6e85:a529 with SMTP id ffacd0b85a97d-3b32e5209b1mr2045960f8f.51.1751534794544;
        Thu, 03 Jul 2025 02:26:34 -0700 (PDT)
Received: from redhat.com ([2a0d:6fc0:152e:1400:856d:9957:3ec3:1ddc])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-454a997af9esm21221155e9.14.2025.07.03.02.26.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Jul 2025 02:26:34 -0700 (PDT)
Date: Thu, 3 Jul 2025 05:26:32 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: linux-kernel@vger.kernel.org
Cc: Lukas Wunner <lukas@wunner.de>, Keith Busch <kbusch@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Parav Pandit <parav@nvidia.com>, virtualization@lists.linux.dev,
	stefanha@redhat.com, alok.a.tiwari@oracle.com,
	Jason Wang <jasowang@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	Eugenio =?utf-8?B?UMOpcmV6?= <eperezma@redhat.com>
Subject: [PATCH RFC v4 3/5] virtio: pack config changed flags
Message-ID: <ae1546541834abe3296c6341f6dd02a73a49f29a.1751534711.git.mst@redhat.com>
References: <cover.1751534711.git.mst@redhat.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <cover.1751534711.git.mst@redhat.com>
X-Mailer: git-send-email 2.27.0.106.g8ac3dc51b1
X-Mutt-Fcc: =sent
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: yIEIFgCbtp_krGkq3pbAZ1FwghJJ8Ya4OBs4jflm8VI_1751534795
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

