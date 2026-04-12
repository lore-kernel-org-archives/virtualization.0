Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FC4A3203B6
	for <virtualization@lists.linux.dev>; Sun, 12 Apr 2026 22:51:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776034275; cv=none; b=Fd8eKVqYElqYKJmkNwyjOSc0tPpIfpnqmWhRScMzISroaUZ9lONN3gdNgohfD1yLpwu8eS4SSd+BynrfJ8u4vc4vACfFpcQn8+UqvANm2QYqxzSkUq2R6NIqYiJmpBACOaG1+WwirN0Uren8A/3oqdonOmELxXDW6PNJJDaPaWk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776034275; c=relaxed/simple;
	bh=XT8XjxrOo8Cw3Xtsh9vyWO+BBJloOorKy42s8aeR6k0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=nKLDWBMWTGyTkhZj9lDIhdWbjHOTNV5Un7SEO5OhAqM8WuuElcJQyD8+fHXjT/seYfnjASR+zFRkPnKXHsisp93QTVbAuFzNWWnZqKBJay3CQAuYI0MaQJEafZXHkuK5+Uzpp3Tu5HGbLITky9iovq6M0Ex6ml2h+AYr3uJ+Bw8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=fUgNopBH; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="fUgNopBH"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1776034273;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=TlfRBK2bX8o/k8wjGS3qq/qL09qxPEswmhdPhNP/qNU=;
	b=fUgNopBHuFM+syu3UFnDeOlMYOer5/QKMpOp6y0Ff0v/b33YZwWh20Tna5Tq4lkXkiby+T
	SpL88xqv1sId6eHP8S/0Oxq8LW69wWTPJxANggiSgmLShDsFTwAwHlrT0vHEKOKx8m1r3t
	seNcbaFrgAbjeOlkBkNNYQ+RemLunb0=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-594-vfTXYeSdOmKxL0FeK87M0w-1; Sun, 12 Apr 2026 18:51:12 -0400
X-MC-Unique: vfTXYeSdOmKxL0FeK87M0w-1
X-Mimecast-MFC-AGG-ID: vfTXYeSdOmKxL0FeK87M0w_1776034271
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-488d8deb75fso13508215e9.3
        for <virtualization@lists.linux.dev>; Sun, 12 Apr 2026 15:51:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776034271; x=1776639071;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TlfRBK2bX8o/k8wjGS3qq/qL09qxPEswmhdPhNP/qNU=;
        b=Kdo3py4GEQWeZnZSkMfIAgEAEbeJ+R4XzaDyfz2N5dfVKZn6kpkLFSUHxfVBzouNxQ
         fk0h/U+2vlsQkWdrRMZeDY1DNT4zkNOpUG8qcfJPW2hBN59g1q2uHB9Z81MtZ8U2YZbm
         REBGVQZPOeeYyfY9kKp+dmxKs9PHKeshhANTaWDKa/YSiqoTpDWGszy7tBgsDThuRWzW
         xUoyxOX8kIa0IJWdTlDwzhwshtJ+tFzvDo0u0K1TDcr97/ilT5E/GCXYI9raFJH7of7B
         7lk9nZs1WaJQBNpDf2YGlgxo5nE8fK48wD2JTE7lePANzPYn90n14QSipBUON6vOmyfC
         b7cg==
X-Forwarded-Encrypted: i=1; AJvYcCWCbTJS13URYwNoUYC7O0UED0oqljSCRZVT3AkJA53WWGFi2uWB7yZ4xpmWaGNPcOLFhI//AEICqI9kXxD10Q==@lists.linux.dev
X-Gm-Message-State: AOJu0YwHSgbNOvc1EZqkH1q3ONRDsZkU/ixu4ujlBbTSWDXxSGw3WeiY
	I9JIog0K/Eyu1nD/Yk0oKuXUw3Of1BdHGuPHcvAHgDyseJZpwhoo/P1RKYcLH+rEytbWdpCLMxf
	vSTqfnBnJ9FmekuxkmFmw5eR9r1Tmm+IWHEfNZ+gDS2qI/1bm66eIrIzor3uZpg9FZTMk
X-Gm-Gg: AeBDieuKIa5x07JjVJgCi9nK9WSyXJ+l8o30yitMGZCavVkxNkbbkipani4ax1BRZ4A
	XGdIBKE0wORiJkve19NrY2DnfQwwiTc6ZJji9pYYiojMspfpiFRSyZWFNeDfQKqCrqZ/h5fw0fA
	PcNsULADlwOnlvboP4IxcoMTwetBobuP4tKsQYJ5hIr+J8oJU9/qdUT0n98VvZwXF3pBwOE/ML3
	HiStt0uCDEgTzmAyX5JA2Q23e6iYt3y2DlUcRFmHcU7QUzXemJeRSB3z/5pEgA88we7f8qqYGJZ
	lEoeZ2bKSf1ltHCMY0zz/Y8WPrtru+FfJWR6thnpo/2DFcABC3Zxgb+ATr1vsg5PxtEjcD5yhvR
	m8XsjmouQu+/e8O604sssIuCFfrkb0efNtidlpVEbJjM=
X-Received: by 2002:a05:600c:8b27:b0:488:af7f:775f with SMTP id 5b1f17b1804b1-488d68766c7mr139928385e9.18.1776034270969;
        Sun, 12 Apr 2026 15:51:10 -0700 (PDT)
X-Received: by 2002:a05:600c:8b27:b0:488:af7f:775f with SMTP id 5b1f17b1804b1-488d68766c7mr139928185e9.18.1776034270471;
        Sun, 12 Apr 2026 15:51:10 -0700 (PDT)
Received: from redhat.com (IGLD-80-230-25-21.inter.net.il. [80.230.25.21])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-488d5888acbsm285563185e9.1.2026.04.12.15.51.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 12 Apr 2026 15:51:09 -0700 (PDT)
Date: Sun, 12 Apr 2026 18:51:07 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: linux-kernel@vger.kernel.org
Cc: Andrew Morton <akpm@linux-foundation.org>,
	David Hildenbrand <david@kernel.org>,
	Vlastimil Babka <vbabka@kernel.org>,
	Brendan Jackman <jackmanb@google.com>,
	Michal Hocko <mhocko@suse.com>,
	Suren Baghdasaryan <surenb@google.com>,
	Jason Wang <jasowang@redhat.com>,
	Andrea Arcangeli <aarcange@redhat.com>, linux-mm@kvack.org,
	virtualization@lists.linux.dev,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	Eugenio =?utf-8?B?UMOpcmV6?= <eperezma@redhat.com>
Subject: [PATCH RFC 9/9] virtio_balloon: a hack to enable host-zeroed page
 optimization
Message-ID: <709f6d4e2a454d44cb89c73652e7769692eedb13.1776033771.git.mst@redhat.com>
References: <cover.1776033471.git.mst@redhat.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <cover.1776033471.git.mst@redhat.com>
X-Mailer: git-send-email 2.27.0.106.g8ac3dc51b1
X-Mutt-Fcc: =sent
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: uAZXjoBuYQN53fyTWEOoT9ef1cNfokHI_-HntZEUVWs_1776034271
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Add a module parameter host_zeroes_pages to opt in to the pre-zeroed
page optimization.  A proper virtio feature flag is needed before
this can be merged.

  insmod virtio_balloon.ko host_zeroes_pages=1

Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
Assisted-by: Claude:claude-opus-4-6
---
 drivers/virtio/virtio_balloon.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/virtio/virtio_balloon.c b/drivers/virtio/virtio_balloon.c
index d1fbc8fe8470..5d37196daa75 100644
--- a/drivers/virtio/virtio_balloon.c
+++ b/drivers/virtio/virtio_balloon.c
@@ -19,6 +19,11 @@
 #include <linux/mm.h>
 #include <linux/page_reporting.h>
 
+static bool host_zeroes_pages;
+module_param(host_zeroes_pages, bool, 0644);
+MODULE_PARM_DESC(host_zeroes_pages,
+		 "Host zeroes reported pages, skip guest re-zeroing");
+
 /*
  * Balloon device works in 4K page units.  So each page is pointed to by
  * multiple balloon pages.  All memory counters in this driver are in balloon
@@ -1039,6 +1044,8 @@ static int virtballoon_probe(struct virtio_device *vdev)
 		vb->pr_dev_info.order = 5;
 #endif
 
+		/* TODO: needs a virtio feature flag */
+		vb->pr_dev_info.host_zeroes_pages = host_zeroes_pages;
 		err = page_reporting_register(&vb->pr_dev_info);
 		if (err)
 			goto out_unregister_oom;
-- 
MST

