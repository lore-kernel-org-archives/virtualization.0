Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F978136659
	for <virtualization@lists.linux.dev>; Tue, 27 Feb 2024 15:21:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709047314; cv=none; b=XvSLh/G25Cl1OPJ4jlT1AEligyaM1c5/FMZwUIfT/QWXKGxpO9WcwbwNuruUSL0AIVlgxeLHz15apcrEPuUsdZTo3sYz95JAM2wXvEDSvNzeSwKtdTbICDSbnD6LdyHzn4W3PDkza0SRJujy1TGEY2+f2/xoWSn6T13I19GzUDQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709047314; c=relaxed/simple;
	bh=QsD3Iiv/LhOTtgVgR1olwTS+toXhr/zliUNlH+elpAo=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=k3VIwdQqWmC3KRECJPlsXumZRk8g7vTnZdvaW6f07YR5Cy43BQ+K+EMfLU8WEJ6Jei3OjOOqFyLDromFMbP0AbGPdggKzMQkxfm6wWaNRNCjJrjW1aNj2l940ws1rAg6jpK+VjsUXrSLMCQwLZLOZZX7HiISlkwO0Gf7b9Wae1U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=qz2wuPkl; arc=none smtp.client-ip=209.85.221.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="qz2wuPkl"
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-3392b12dd21so3608070f8f.0
        for <virtualization@lists.linux.dev>; Tue, 27 Feb 2024 07:21:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1709047311; x=1709652111; darn=lists.linux.dev;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=oAR0191YpG6gmNK9RS3NwTYy2tpEgrl20yHlWytzXZU=;
        b=qz2wuPklWXA3sdO7BZpYFttQDeZ5uUQytdiJJy7Ixy7f/5G3wIiOS2Eq5akw9zuu/u
         0IbKvMQIBW30QGu6MDuTwvAuH+/wvG4+3KNQ/YEsNJTatuQKjgSFpJvVLyCVjbcuLb62
         jrs/4YqZatG0X+JFoV3OPDVox9nbOotkBIUPXcEMgFnTjfHYs3yxdQ3lmEHeA7wxdk2d
         VloQcURr3Oa3GIrqIDx+61hFdSp7OqweGG33IQ+YSeODlvXQDiD83seVEThzahY1UCIX
         optesc6K6NouX98VbTGtPkcnX3QbEPxVByAjED1oxLzaTlw+iNJfsrFhtTo9PiJVsfZf
         6RhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709047311; x=1709652111;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=oAR0191YpG6gmNK9RS3NwTYy2tpEgrl20yHlWytzXZU=;
        b=XvAQYQRv7Y2UX/6+LimiY4sKeWARjU7ZEFNV1Je0zW6M2GV1P6X+8im9djVH4OZYYn
         PnzpB9B+Am18INdcSILhnyCGuHwq2mybqixo73T8qUK0Y5Oa1kvEAprb48+Dy2o98b0z
         9bXpmG/V7yIEsTTUjwzlk5vGMh4Ph5JE1wNlC9viTfxtVbR5wV0EaHWl2jFgRyd7Px80
         0K0nCQ1dd5KZiDiwbmdI6sTQacWZ7GyWQuHDYbx3HBG5s+Za0TKEvPs0d/kUoAFIditE
         gUn22MAIaLpa5d5UyXGvq7DOFzh0Y6GlL8JD39H1TIm0dPnQG9TONKav6QtNADIXE/nk
         SIZQ==
X-Forwarded-Encrypted: i=1; AJvYcCVIaI55tbY8FkDIXSuZ0GuX2rbfTDTd1o9updOTZteA+DRblvysxgI3lXma4ur4HapPsPc9yqt9WpmPvd/NWLbapqpcYc7wwNRKOgGH0vs=
X-Gm-Message-State: AOJu0YycZgWGEQRQcglZq1pvHIPos44xyFPvtbjEgqGfhmZINJ3lHTc5
	2W1aPJEyc1clkyCXL1gtUtSix2q65Ec/4sWPbDtSpdtH2KBHcnERbiugljyMGA8=
X-Google-Smtp-Source: AGHT+IGx3UJwCU3OwYophAFSeMY+HT7j8jGN+JsrR+9BGVpaMQSzmvZQht8iS1eq9Il37PGPrMeIYg==
X-Received: by 2002:a5d:4f01:0:b0:33d:87e9:5905 with SMTP id c1-20020a5d4f01000000b0033d87e95905mr6160029wru.28.1709047311631;
        Tue, 27 Feb 2024 07:21:51 -0800 (PST)
Received: from localhost ([102.222.70.76])
        by smtp.gmail.com with ESMTPSA id k2-20020a5d6d42000000b0033b79d385f6sm11579719wri.47.2024.02.27.07.21.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Feb 2024 07:21:51 -0800 (PST)
Date: Tue, 27 Feb 2024 18:21:46 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Cindy Lu <lulu@redhat.com>
Cc: "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	Xie Yongji <xieyongji@bytedance.com>,
	Maxime Coquelin <maxime.coquelin@redhat.com>,
	Christian Brauner <brauner@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	virtualization@lists.linux.dev, linux-kernel@vger.kernel.org,
	kernel-janitors@vger.kernel.org
Subject: [PATCH] vduse: Fix off by one in vduse_dev_mmap()
Message-ID: <e26476e0-68ae-412d-a5d9-4996bc30d038@moroto.mountain>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Mailer: git-send-email haha only kidding

The dev->vqs[] array has "dev->vq_num" elements.  It's allocated in
vduse_dev_init_vqs().  Thus, this > comparison needs to be >= to avoid
reading one element beyond the end of the array.

Fixes: 316ecd1346b0 ("vduse: Add file operation for mmap")
Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>
---
 drivers/vdpa/vdpa_user/vduse_dev.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/vdpa/vdpa_user/vduse_dev.c b/drivers/vdpa/vdpa_user/vduse_dev.c
index b7a1fb88c506..9150c8281953 100644
--- a/drivers/vdpa/vdpa_user/vduse_dev.c
+++ b/drivers/vdpa/vdpa_user/vduse_dev.c
@@ -1532,7 +1532,7 @@ static int vduse_dev_mmap(struct file *file, struct vm_area_struct *vma)
 	if ((vma->vm_flags & VM_SHARED) == 0)
 		return -EINVAL;
 
-	if (index > dev->vq_num)
+	if (index >= dev->vq_num)
 		return -EINVAL;
 
 	vq = dev->vqs[index];
-- 
2.43.0

