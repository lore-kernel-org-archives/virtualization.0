Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E0261773A
	for <virtualization@lists.linux.dev>; Thu,  5 Dec 2024 17:00:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733418036; cv=none; b=u85Ny3e4LN8sErkGWR4qM9+V/3ZGiRFiisjiAa4wHp0ROtEfzA1Y+Fu7MDB/PbzON9i8raS7UcBwJI31JMxgkxw2/PK+NGWglgOxn5oa+RUcLnEqn8yMWWsMYBcsSA+1JJ67H1UA1CzFjp0rxAVvOGV4eb2fy2MSIa1t7RVs8Dc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733418036; c=relaxed/simple;
	bh=tnQzLup3SN9IK8olecRg46PLyiLOeIsRMZVNRC5rX+I=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=XD6T3F/3IBFqpqhOVCZraCIXbQDLD5WlKMuB3MjhbYEW6veIBF6Iw9R1lZcVjMeEkCHsdjDNptscKFEjB4KVBLzXgjVaKGJ4ums7Ab7zTUgmJz8YY++e+lU+xTzjBUy8Tes6niCzR9rFLlMVpVf62CEUPDljhiHJcTl+oVShVpE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=wp1U8+DM; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="wp1U8+DM"
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-2155e9dcbe7so10701315ad.3
        for <virtualization@lists.linux.dev>; Thu, 05 Dec 2024 09:00:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1733418033; x=1734022833; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/sYsHYyKEwYdU+pGD1sUEa2kFoGvEayvExztEGexqjk=;
        b=wp1U8+DMyXopVa3d+8hNNNw9Rrcdd4spsLv6fW6a+zLu49E6clLRsZwLMDb8V1fn3F
         EC3ep92lhp15VO8ESkZUvKqf6SIXS9Z1PRMWhRYBUuuYo41lbSQ7Zy0gI1Kg8WMEY5qP
         ItOLAHmzbdKJ3pgfTb3q1+1Ok3ixLi1eJUBWxDzFSKjyV/c/TK6aUgqHDQtsWWMxga0y
         giLPsBiJ63ACp7SMkQgtQLgJSdLVTl7gPvs4TVE4EGibOaH9yYPAOP9Af5SlHJ083Hz0
         AUZtDqusv6as+zZe/51HnYOYFrGQXW81LkTAn1SNYKdSDxbUvZzCjMkw+Z8p/FUvfKgS
         vRSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733418033; x=1734022833;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/sYsHYyKEwYdU+pGD1sUEa2kFoGvEayvExztEGexqjk=;
        b=M9pQ/Ih/PO9k45H0qOGRp1/uJKNk2PyewtpZ/VsUaZEacahzuRLiU540LXOWKvs3lD
         a97RiVyWVXi7krUAZTXwwKyA2Q1mmrfxVBKgxWpJNlvVuKZOOUbSS2jzq4R6QjayZ/LJ
         PzBzq85ZQKalBQuJU+dJ/8EWJKoVlYlIzK+z6NcmjwmZCKMAoT/7IqXpMgkyFitLRqSr
         mv+M4oSnLiW5s/SZK/uA5lDKF6e7Ah4KzhXM4zKWZ8nJcznYmSKbisT3qLK3EVZEYDlA
         oi9lX6/Ut6QkYinDdx4OntbRZ/2JkTK6n7hd3EzntKTJmigRsBTGo5O5TaNp4omKWpdq
         UMvw==
X-Forwarded-Encrypted: i=1; AJvYcCVFI8wBmC0c0OM8WwfZgcb9ri0/uTRuabPC5/HzeVIXqmKTEPuzYqwHl8i/f8qAHu1om+LdVCZMW+k2SDnMdw==@lists.linux.dev
X-Gm-Message-State: AOJu0YwBiSK4TzHQHRaZCHg09gFKHahlyQqkK+4tnMThJr39vS6jjtcW
	fj9GDv7apWwye/qVhtqKwVEho3qBshznXXtkCzvf2xRZnglBs7y7BKOHCWwnLrA=
X-Gm-Gg: ASbGncsCiHUrrWbPe2qQgz4kuXf9pWMoWdX7muloZvPy+S5aWPIPFNyMN/+w0MGaqaN
	m/tQTiSgvdWX3HmmQJFLRnmF6AdBg/vjlo+nOwzoHeC0411DZe3dpOoTJN0fiTxm1naBAk4dx5S
	IdN1OrEq9qUhl1EDFhVnHPKGV4spBCsGLDg0/7I+qPepaXxdxq7BkY89dZF3ARqxnJkHyBzz3Yb
	5XXVUGBoE6j/W3pkwF1hmtnT3si7w==
X-Google-Smtp-Source: AGHT+IH+6ZU/vU10S4DTHnV14trdeiv/HMOUP+N78dCEwlIoNUxevvyiqbsiem/5dlHa8xT96d7tGw==
X-Received: by 2002:a17:902:cec3:b0:215:3fb9:5201 with SMTP id d9443c01a7336-215bd16f90amr119499135ad.44.1733418032765;
        Thu, 05 Dec 2024 09:00:32 -0800 (PST)
Received: from [127.0.0.1] ([2620:10d:c090:600::1:dea0])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-215f8f27141sm14727875ad.232.2024.12.05.09.00.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Dec 2024 09:00:32 -0800 (PST)
From: Jens Axboe <axboe@kernel.dk>
To: linux-block@vger.kernel.org, Ming Lei <ming.lei@redhat.com>
Cc: Yi Sun <yi.sun@unisoc.com>, "Michael S. Tsirkin" <mst@redhat.com>, 
 Jason Wang <jasowang@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>, 
 virtualization@lists.linux.dev, Marek Szyprowski <m.szyprowski@samsung.com>
In-Reply-To: <20241112125821.1475793-1-ming.lei@redhat.com>
References: <20241112125821.1475793-1-ming.lei@redhat.com>
Subject: Re: [PATCH] virtio-blk: don't keep queue frozen during system
 suspend
Message-Id: <173341803146.638625.9371515835290273948.b4-ty@kernel.dk>
Date: Thu, 05 Dec 2024 10:00:31 -0700
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.3-dev-86319


On Tue, 12 Nov 2024 20:58:21 +0800, Ming Lei wrote:
> Commit 4ce6e2db00de ("virtio-blk: Ensure no requests in virtqueues before
> deleting vqs.") replaces queue quiesce with queue freeze in virtio-blk's
> PM callbacks. And the motivation is to drain inflight IOs before suspending.
> 
> block layer's queue freeze looks very handy, but it is also easy to cause
> deadlock, such as, any attempt to call into bio_queue_enter() may run into
> deadlock if the queue is frozen in current context. There are all kinds
> of ->suspend() called in suspend context, so keeping queue frozen in the
> whole suspend context isn't one good idea. And Marek reported lockdep
> warning[1] caused by virtio-blk's freeze queue in virtblk_freeze().
> 
> [...]

Applied, thanks!

[1/1] virtio-blk: don't keep queue frozen during system suspend
      commit: 7678abee0867e6b7fb89aa40f6e9f575f755fb37

Best regards,
-- 
Jens Axboe



