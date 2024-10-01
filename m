Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A04A519ABA4
	for <virtualization@lists.linux.dev>; Tue,  1 Oct 2024 09:30:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727775057; cv=none; b=ZPEWzzqykU5S2Awc/bcBdCvwazVzkt0uv0Xcuxh85ifP9VS6tMoiZrv3kOJP5XZh+Wd83CiBZcEeRAUJEGgZ01Wmlnr+/cnjC4WGBsIl6ZULsjHxgOCc+sGk4O8d0uYByVn4yobnfb3eExOoSreTVNikprxKw51VESRQbDgAtRw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727775057; c=relaxed/simple;
	bh=ZskDUsZeVMJFIK/Yigi2D03XvMO2kozwT/rt/TJPv5E=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=rCRItJft+IGxf0EXSztUtC8cGVcTBt6LF41uvVbydmmxTXoR4Ix4KKe7D8YfE7WzGNyou6UixvJkuu/VPG5vItmJfKWNHj1fp6vEZ7otDiOjJDS7snWyvrKTK1Ai2o21hZA/laHrUy5csm923/hKSpS7AkvEzYfnUhzn9Otbz5A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=beHoFl5y; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="beHoFl5y"
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-20bb610be6aso3527005ad.1
        for <virtualization@lists.linux.dev>; Tue, 01 Oct 2024 02:30:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727775056; x=1728379856; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=W+4UolrUQ6Xy2r4o1oQrUubFhTKVXa1bQO0YF2hCMqw=;
        b=beHoFl5yRAoeNkFLEUKpN89kiYBlcRv/fOfu5DVPcYslPJxtBsGaZXAYtzcCd9oMO4
         qgyy57mhuzTG1gitHoJssSA6OjafB6L6QCfAX4linu7YeaD2IGVaTi3DyQsyZiNBiWRN
         /ID4m4aaSCfYT0welcx1w3wcM6DiGpg2/2SPoxshujBz0cfrcFPFNoc9wTgZV1VWySOo
         vzvg0L3vRinRdeZxAwa787MnXxMfJxoxBLRobNFJM9jl4IF0HOMwTELNxab3PpLc509D
         PG28A+rgg87Pl0Q8L6Tzm9pCRe8f/LUclIXrd+u2GRNIsb8bvqNNqaMNfQdeL+42gH27
         v3Qw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727775056; x=1728379856;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=W+4UolrUQ6Xy2r4o1oQrUubFhTKVXa1bQO0YF2hCMqw=;
        b=mYmu952VOYtB+Z66+nys45xAZGlQ0v0+4KdU18HCYig0SJfPdkxLyq338cisoPVNwK
         Aurshg/o28UUqVYCZCBOHGPoyFF5VysHUCz6wC5EhoI5nUK8gevDDoW/WWDs/A4ZzMar
         E5c5OuxOfQ56tJvgWUHK99/+lqPnQWRaZJ2BMjhRfn5n9uwzvBO9s5ESWL9Jd9A+poXA
         TxFqaZkkcrEn4BvnfYD5dgZHkTo6vVPC2TZmZwnytumpGI3Dnbfe3V7jBx56bKxlGFnq
         vw07DYPjMocDzrBQThNTi4CLjzJ/nR10Mzz3dXoIBkhUqk9tKb58kKjj4ieHAUXmWW8i
         9JpQ==
X-Forwarded-Encrypted: i=1; AJvYcCWdM/USi5/FrQ8iP8Lq8PoOIARzdq/ZqBJ0gmrTMsQBDh0dIc7R1BY4Zae+Lvx5WKax1MaoOPZe/XMAXub4qg==@lists.linux.dev
X-Gm-Message-State: AOJu0Yxab7i3cSN6hLHhEOy5PB18WE54mrF5/vmnyP3feQ87K0isW3d9
	VaFLmzKNgYZHBTqyOQUMHQy+gDuO2o7VSv0gr/12kpcpEWkNJ73n
X-Google-Smtp-Source: AGHT+IG3MRTXsdCNxSvHbHz8XHYStnncZOvWI6fDhmAE9CqqHGPX5KMyzKCUyJKUNaPIYsVfDRSRSA==
X-Received: by 2002:a17:903:2344:b0:207:1675:6709 with SMTP id d9443c01a7336-20b36709fabmr201291175ad.0.1727775055866;
        Tue, 01 Oct 2024 02:30:55 -0700 (PDT)
Received: from localhost.localdomain ([175.45.38.98])
        by smtp.googlemail.com with ESMTPSA id 98e67ed59e1d1-2e0b6c74071sm9782805a91.18.2024.10.01.02.30.53
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Tue, 01 Oct 2024 02:30:55 -0700 (PDT)
From: Wenyu Huang <huangwenyu1998@gmail.com>
X-Google-Original-From: Wenyu Huang <huangwenyuu@outlook.com>
To: jasowang@redhat.com
Cc: huangwenyu1998@gmail.com,
	linux-kernel@vger.kernel.org,
	mst@redhat.com,
	virtualization@lists.linux.dev,
	xuanzhuo@linux.alibaba.com
Subject: Re: Re: [PATCH] virtio: Make vring_new_virtqueue support for packed vring
Date: Tue,  1 Oct 2024 17:30:51 +0800
Message-Id: <20241001093051.42703-1-huangwenyuu@outlook.com>
X-Mailer: git-send-email 2.30.1 (Apple Git-130)
In-Reply-To: <CACGkMEvieuDTp-DfhQ58EGbeFCvNmn4fUNmUdPHzex6pOetbdw@mail.gmail.com>
References: <CACGkMEvieuDTp-DfhQ58EGbeFCvNmn4fUNmUdPHzex6pOetbdw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

It used for testing in tools/virtio/vringh_test.c. 
If vring_new_virtqueue supports packed vring, we can add support for 
packed vring to vringh and test it.
