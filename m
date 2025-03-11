Received: from mail-il1-f169.google.com (mail-il1-f169.google.com [209.85.166.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E73671C5F14
	for <virtualization@lists.linux.dev>; Tue, 11 Mar 2025 13:50:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741701031; cv=none; b=iAmtqJSGySGNwVCXVHxi2nQar+mSSFMmkgFDgcQfXELG450HAmKJr+lWA8zjF3hK25Tmbv5EANhk/uhCAnZCRXrdxk7niGMtxT+ILDIpRBlrs5x2sIfBblvC5n4LHUvzhBuhQt5B9kGG+i4QgP2PH1QXnI/x5pRzLAkXj6mqy7M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741701031; c=relaxed/simple;
	bh=TF1EGeovnW6B5Fki5wnGhvAhhpu8DdqNVf1ne8WgrYk=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=nEpgEb3LuQJRs0CViTvrH2oFjFaOb7GgUd6+NMKv1v2NSMuhNbIlkqoYYHjfo04r4xHX3nawa1Ae/UQSItoyqonhYabTUUQ+uTS2A/BAKjV9N5JF3z3AVhXx/xBCMFdMcrFvMF8SPDjKwFKuMsROxNJCOGMCIv1vltS32r8VNTg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=ZiKy4TVY; arc=none smtp.client-ip=209.85.166.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="ZiKy4TVY"
Received: by mail-il1-f169.google.com with SMTP id e9e14a558f8ab-3d2b6ed8128so19021455ab.0
        for <virtualization@lists.linux.dev>; Tue, 11 Mar 2025 06:50:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1741701029; x=1742305829; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YsrXv0bf4SwYPCzHdWKazz89+OtA3vJ8ZRt7BAG3VbU=;
        b=ZiKy4TVYCid7OykmEdRgECzpXebTLyRWyUfx5JFabrfxfpYcoEwvoPyCIhHtamwhyY
         zxMo+rTviGp6InCdhsIpOyNlKue59NMHXPffwo67A1lS2VlABlr6qluuSB1MTcPXRmQg
         +vbmnh5sJxeWEvMjCzFwr/Jy96VuTzMQhIROFa7GatsB3GKMAMimvkvI0exuAucs3dgT
         AGWMT3BuceI5vVfMrNxSnWhThz1ETbVeWxNh9+brXy/ASQQxhPBRx4YrirKFeTTMNDy+
         dLXTFfgu1uX4iuBQ1oHI0ISBvwAvMJt8kr5EE1eZe68sngOtWqA4wc8IIQqoWsFH6AAy
         TK3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741701029; x=1742305829;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YsrXv0bf4SwYPCzHdWKazz89+OtA3vJ8ZRt7BAG3VbU=;
        b=RLgeJz/0WQXaFVj0DdZWD8ewogr2R+tdZPcFF/RlpCS3uRy7F0p44DlEDoqgdY4aM3
         ez6xP/F/Dtck2VXoSlHBEzdI11Ex+C7Pv9XLu7jKheTm343XA3n6KP9xbK+NAGqtm+/1
         5pdAQYL3Q3XMgVElcVib1ECfNAu6vxltMOqvVJFpPFSLYXJJTd9HX3jhqC+J3Bq1ZJkO
         o/nMJevw1osJ+7myHgQRjGMmPd8Wrmxov2TdMPJbrYtA7u22IypnVqx5/ewq9hU+fIPz
         9DsNf6EPkYHxbAXqQeO+G34qo92jxa58ZeLEyL9leiMW4/6GZwbgZMo+MffSF/LuhA6t
         nhlg==
X-Gm-Message-State: AOJu0YyvONa9FB4inwfSvcYF8KtrzOcDQgTcQAS1vOsyqFS64ddDuefW
	Noq79OC9XZSVn4mezkf/s1OHw5aW/S3YUNuuo0xDaRiL8GWfR4EKzlNc7xT8zLo=
X-Gm-Gg: ASbGnctmNJVoBaZ4vN4QmTeqRa0xjwMZ4j3p0Zt+jXThK+Xh5NMbrGK5YUKQuJ0FKTE
	EOhX69KcaFPSt4gT2GpmI/CIslLuYXf56ayLqPDR6XFC37+1I1bpLt+9NVwJOWgEQbvpCoYN62E
	33b69d9ydEgB6Q11TC0ZJkUB1zwLoChjQYFxEvU/IWztQRHn60I/SnE7eXxTpJtTWzn7SS8BYCd
	+NiSpi7lvn1b9+AVOc/WffvYi0e2E2GkJxY3zxyJ8/LG53GMOybNyAd5L2xN99bn6VabA7vb9iX
	BPoFmT3cAwTB/Q2ao4lZBqXTV/vVf2lisf5T65p/8HkmFw==
X-Google-Smtp-Source: AGHT+IEJpumqHggfcCQNZSUxuoyo1e+nAm1OVkr94r5e5qCv6EQWmunFqyrvyE3JGQqty289x1CA7g==
X-Received: by 2002:a05:6e02:3389:b0:3d4:346e:8d49 with SMTP id e9e14a558f8ab-3d4692159fbmr36048055ab.9.1741701028951;
        Tue, 11 Mar 2025 06:50:28 -0700 (PDT)
Received: from [127.0.0.1] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-4f24ca8602bsm275068173.145.2025.03.11.06.50.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Mar 2025 06:50:28 -0700 (PDT)
From: Jens Axboe <axboe@kernel.dk>
To: linux-block@vger.kernel.org, linux-nvme@lists.infradead.org, 
 Keith Busch <kbusch@kernel.org>, Christoph Hellwig <hch@infradead.org>, 
 Sagi Grimberg <sagi@grimberg.me>, Alan Adamson <alan.adamson@oracle.com>, 
 Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Cc: virtualization@lists.linux.dev, asahi@lists.linux.dev, 
 linux-arm-kernel@lists.infradead.org, Hannes Reinecke <hare@suse.de>, 
 "Michael S . Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>, 
 Xuan Zhuo <xuanzhuo@linux.alibaba.com>, 
 =?utf-8?q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>, 
 Paolo Bonzini <pbonzini@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>, 
 Sven Peter <sven@svenpeter.dev>, Janne Grunau <j@jannau.net>, 
 Alyssa Rosenzweig <alyssa@rosenzweig.io>
In-Reply-To: <20250311104359.1767728-1-shinichiro.kawasaki@wdc.com>
References: <20250311104359.1767728-1-shinichiro.kawasaki@wdc.com>
Subject: Re: [PATCH v2 0/2] block: nvme: fix blktests nvme/039 failure
Message-Id: <174170102773.320314.5830688529132236537.b4-ty@kernel.dk>
Date: Tue, 11 Mar 2025 07:50:27 -0600
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.3-dev-7b9b9


On Tue, 11 Mar 2025 19:43:57 +0900, Shin'ichiro Kawasaki wrote:
> Commit 1f47ed294a2b ("block: cleanup and fix batch completion adding
> conditions") in the kernel tag v6.14-rc3 triggered blktests nvme/039
> failure [1].
> 
> The test case injects errors to the NVMe driver and confirms the errors
> are logged. The first half of the test checks it for non-passthrough
> requests, and the second half checks for passthrough requests. The
> commit made both halves fail.
> 
> [...]

Applied, thanks!

[1/2] nvme: move error logging from nvme_end_req() to __nvme_end_req()
      commit: e5c2bcc0cd47321d78bb4e865d7857304139f95d
[2/2] block: change blk_mq_add_to_batch() third argument type to bool
      commit: f00baf2eac785bba837e5ed79d489f16520e7a6d

Best regards,
-- 
Jens Axboe



