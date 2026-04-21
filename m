Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94B60280CD5
	for <virtualization@lists.linux.dev>; Tue, 21 Apr 2026 22:02:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776808921; cv=none; b=VL0UqEHPIgLhyil6dvWvYYpAbuZnP15p87PbK26Qy+jeDXyjqDC+umCOh0EjmLfTrNPF8sNBDs0QJuT+0Bj/KPuKEk/9k3rNpFcQmTppKXEwbUXkI5wNHA+Iy7P7hLTygbVqqfKoSw94YRuO/aUhpUcOPW2TuLh8gaRns47XzSs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776808921; c=relaxed/simple;
	bh=arS3wwEKF7EIFSX54DNKYimVm0l+bQRNcNnFnnvhoV0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=hQTSIldxWl7CIRCc2lXA/SsleIROwS6r4N4giyXjCFkEqCWL0k4gtTMVP0p71ZzqwqeNfSD1SFBgQC7Y3az39RzYd83X+QOiGvj1Tbse6uNco+TAF3Gsy+hgekQzUx1+xwbKFblgBxblxkUbGze4kW/6v60T6egEnmfKpya6CFk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=cqZsnL4e; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="cqZsnL4e"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1776808919;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=NAiu8nAu6jsdbD59MaLaRp9DyOH1KPADlHXUZUyeJ14=;
	b=cqZsnL4e1NcgQZkmPgabzzOhP+wxzQMePvBr4P5fi3o+Uf811Qsjwc4RSrM7LsOqwN0gW8
	a5K23Ihy5Drjj+Aya+dKVbkIjSiptNqcaJbBBwLCgyekjmEKlFGHEdvsbbIYYpy/48Qy3B
	bqbcODI1WK4/vHatwvOW0fm9XVz/Q9o=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-102-4v_84bymPXGZbyUy7KLpDQ-1; Tue, 21 Apr 2026 18:01:58 -0400
X-MC-Unique: 4v_84bymPXGZbyUy7KLpDQ-1
X-Mimecast-MFC-AGG-ID: 4v_84bymPXGZbyUy7KLpDQ_1776808917
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-4362197d1easo3526058f8f.2
        for <virtualization@lists.linux.dev>; Tue, 21 Apr 2026 15:01:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776808917; x=1777413717;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NAiu8nAu6jsdbD59MaLaRp9DyOH1KPADlHXUZUyeJ14=;
        b=ngFVvWSkws2Flk5VF8re7Ygxcy+M8OMtXD8qNpAdi1G2hLTXsa3zZRtXTRBkBhW4CQ
         nIXvyQGtRVmh2R+bVwDtld/FwlTP9mZIcDsxIIWZoe85ovXlpf1QcuD7Vp7iXwFLjsYS
         fIpsNOcwFsZJWxkaoILyOz4m5f1NKoK74WxqedfZ4KazkzfMoNOMtT6h+UqxCP96x4Ym
         6sckNezPnMEtY1JdsKmf7dXhEFdx7Ay9ptTk8MUsyBad/ARYapGqGMZiT5B4CdXFdOuW
         mP0rTdY1OGIMn+EbvwFpllTr+vvmu/3mifRDn0TOA6RUY/BHfTu1dkRHLiZuVLWAsjmL
         dOjg==
X-Forwarded-Encrypted: i=1; AFNElJ/ouoE5FdOO8SrZIwo0tH2UzvxT+naA2ZHv7ixM5QwO4gO1qrf5/fILoOePLM8TijKd2oqEF50U2W/3+XtOgA==@lists.linux.dev
X-Gm-Message-State: AOJu0Yy81BRUCwAxPKLBb0S3lkDAEQxTBLoXYgrkdBNtmN6IboTaC1ip
	7qtzi0sX9PGFBJkuQP1boyg8CFloDyYj8uz+MeHBwdnqOxL2pv+rf/Hic0h3gnePQDRHkt6GJDQ
	g2z8pnTmNVf7cxJX7afIPqqMcUBKZvP7BIIKHe8N9ySswlLz1kCqGtIBkcPAPRvwZ/Hor
X-Gm-Gg: AeBDievLwa0ueBeOU44jj0bJCb6+N0KYfkH7rri0PX5fFFvDu6x2C8uyZYkaIn2QK5R
	IJi2h9pG8Dg+Q1EyFT0OBy+evZct5bQYUHuQp1z3mLK5btLy9PRuiW949stwmzolLI0Zap6sJQ0
	mu3p7htlYnOgA1SKIcc6EK+cPxhxfQkhIBPOPkAFcTVDjB55Eyw8xvqbDu8oM0zF3/XfXFIgqO0
	iZrX+R1HkBD9D/oFWFwUoXDgDWfi8/NpTvwVtKFsdz0HhfQGsgMdxTIEA+YZl0RGMmXdla1V2MI
	DmF6SMnXGSn/m9e1tTXJC65o33iTzwWdVl+uKfUIBiutkbykAnPrF3nDXUAZXlPauIoosrPqGa0
	0Cw8R6ipp9RUy9hnXChP+y3HweEsaMhDffCiz0tnNpYKBCNBwIupcng==
X-Received: by 2002:a05:6000:184b:b0:43f:e231:6721 with SMTP id ffacd0b85a97d-43fe3db2c4emr30836516f8f.2.1776808916845;
        Tue, 21 Apr 2026 15:01:56 -0700 (PDT)
X-Received: by 2002:a05:6000:184b:b0:43f:e231:6721 with SMTP id ffacd0b85a97d-43fe3db2c4emr30836484f8f.2.1776808916351;
        Tue, 21 Apr 2026 15:01:56 -0700 (PDT)
Received: from redhat.com (IGLD-80-230-25-21.inter.net.il. [80.230.25.21])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43fe4e46471sm39731110f8f.28.2026.04.21.15.01.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Apr 2026 15:01:55 -0700 (PDT)
Date: Tue, 21 Apr 2026 18:01:53 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: linux-kernel@vger.kernel.org
Cc: Andrew Morton <akpm@linux-foundation.org>,
	David Hildenbrand <david@kernel.org>,
	Vlastimil Babka <vbabka@kernel.org>,
	Brendan Jackman <jackmanb@google.com>,
	Michal Hocko <mhocko@suse.com>,
	Suren Baghdasaryan <surenb@google.com>,
	Jason Wang <jasowang@redhat.com>,
	Andrea Arcangeli <aarcange@redhat.com>,
	Gregory Price <gourry@gourry.net>, linux-mm@kvack.org,
	virtualization@lists.linux.dev,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	Eugenio =?utf-8?B?UMOpcmV6?= <eperezma@redhat.com>
Subject: [PATCH RFC v3 13/19] virtio_balloon: a hack to enable host-zeroed
 page optimization
Message-ID: <585a71dace8705d604da7d3093c70896eef5b2bc.1776808210.git.mst@redhat.com>
References: <cover.1776808209.git.mst@redhat.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <cover.1776808209.git.mst@redhat.com>
X-Mailer: git-send-email 2.27.0.106.g8ac3dc51b1
X-Mutt-Fcc: =sent
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: TruuNBkDXg4IBpzwOmDpG3egqrfMljmTF93_lRII_Jk_1776808917
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Add a module parameter host_zeroes_pages to opt in to the zeroed
page optimization.  A proper virtio feature flag is needed before
this can be merged.

  insmod virtio_balloon.ko host_zeroes_pages=1

Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
Assisted-by: Claude:claude-opus-4-6
---
 drivers/virtio/virtio_balloon.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/virtio/virtio_balloon.c b/drivers/virtio/virtio_balloon.c
index d1fbc8fe8470..165b123caa64 100644
--- a/drivers/virtio/virtio_balloon.c
+++ b/drivers/virtio/virtio_balloon.c
@@ -19,6 +19,11 @@
 #include <linux/mm.h>
 #include <linux/page_reporting.h>
 
+static bool host_zeroes_pages;
+module_param(host_zeroes_pages, bool, 0444);
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

