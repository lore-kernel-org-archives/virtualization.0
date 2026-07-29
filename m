Received: from mail-pj1-f41.google.com (mail-pj1-f41.google.com [209.85.216.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C551C3B14D8
	for <virtualization@lists.linux.dev>; Wed, 29 Jul 2026 19:17:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785352646; cv=none; b=Cxne7iO14+j9UrD3CD4RNgT4rTW20wMkM+4pQ4hzdkT4XqMYndQdlT4VgtlRv29PJ87iwOg6y1DE0LDvK7ko7ha8MGXt/A0Gph6Fpsca2+PZEatymJE3r78M5fitj6QG+N+SRBiDN+PCkuQk6RBUqdH/0tpJsy/qwDfvEtTk0Oo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785352646; c=relaxed/simple;
	bh=gLYJ/tvikVJD261WQ8Bnm0r9paDoP2JeP0aFQhh4qUo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=CZczPndR7NpyM3fzKWcg6XwLcbjLdCXY56UvkNxOFnO1Y7YgYZwbT7Jf3QMDjCh+TuKo0vNnbmwoCbNPjCcMIV4r3hHsOvUtrkCwH3zKgmbu82iQRH79MlQdRQoeWOgMxWFlhptAp33tIJZGycszWG44JhkbgqfEGzSpMxOCjHA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ltQhXLq0; arc=none smtp.client-ip=209.85.216.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ltQhXLq0"
Received: by mail-pj1-f41.google.com with SMTP id 98e67ed59e1d1-382ef647e20so1362981a91.1
        for <virtualization@lists.linux.dev>; Wed, 29 Jul 2026 12:17:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785352644; x=1785957444; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=8cYrrvUoYS01HckamENfIVCtypmUIu/Ic6/OpmpgsnA=;
        b=ltQhXLq04ToJ2LpiFAgx7VzFRTSB4S8ITnnC2FtCq3u2Li57ENlDHLlBc0yHvxYOUb
         M2UZIs8TpaAT8XlqSnylL5BqbDiPY6Ysfmqfm49/1FRwqmDdjBKll/t33BsXn4ZSEOeM
         YOzbrjdUx83pF2BkgZ7O2gpPWb49eM42mHkI3wajLAjJss8rnxwyKatiGK2md7S0c0X5
         GmRydYsR689vCNsfTN8tOmNGBTMd9/Hvgw3wIFn+X05aX9ag7Q5Tzta7wTpgrIuEsdPP
         ifkEkN43LL2uK2qEsTsYVkSOFwmNPAYtHqbtsxDIa/PP4zOhxBIQ1hG48fILfN70tf5k
         Mglg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785352644; x=1785957444;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=8cYrrvUoYS01HckamENfIVCtypmUIu/Ic6/OpmpgsnA=;
        b=BEpXXAwMZHX19M6ZZjrSxysLq4JCgjW36BXVUwC0E8NSLEmG62YPw6tUdMqMyz9x4v
         CMl5wwYQWKep3o5mqGKAw/k629ZXDyXxNoptRvgvpn2Jse7PBkwqA21Q+Nboa7r/fajO
         RAM0kS4svcDZjgEMn0w6+wf2AffsvZqPT5sxe/Q16ED8QeEokx0ITKr2dJ7oJx9oeG/Y
         +qWEv9LGYC/EeQJC6yujgM6o8/4XnkOszKBG4JTC7F1IuPQsIyaI3ylQqOVLNindjOCY
         k7YCEObY/yDID6Z++BvCQuoRdm1mpHj9WMA6q1SyIBI9BljvZLBSr1r7kLqVZ1pb6DR5
         D1mQ==
X-Gm-Message-State: AOJu0YxL5//0m6MEVCo7K+71TX8i0KS6WZmnbJLGuqrZVGZEc065kGzP
	HjMKK/Bc4mHmLat2wIDfgkuihPPf+KoaGR2i7mQfGzRva2ax3AR8tknG
X-Gm-Gg: AR+sD12YivB5iZTjZuDwu/veGJOUhyFwKbQfWY5fRfdk7YQT2zvrM/MoF7CziDw0yRZ
	mxt1tdN+SHkVrAkLsr2QtxlFExSVdaFvV1bTUEwHCFd1Ot7CXefg5yF2XZPyTZuuhtCgt9475mA
	J4EQBcIHDuvhkVebremDcy2mg+7MNodL73eV6UnSkakCU09jrXLnBsHcutUrudAIkv+S8tnPOnq
	pNmyTIm5y/CdAxYiqd8durUZ/QGe/UUQSvVyekaFQXrY4nMR+SwyvwgxGdraZ0JiC+PN2QS4ZUM
	sHGrcEmNV482//H9q09YpbOPQLwQbEkQXf6z0XXD7S151/n29BH2aDzpW440mdUdQYamBfILUK3
	kH4V/8WZu9o/D5NIhgDWnp2RPlFN+xcIxk+0EuYMBy70u6JcUkmGzW3Y1ZD8yVO1UYoXD5o85S5
	7owcBeF01h4uRaICNtIs5rdM0hRHx1ldBbzKv0kf0TuHz/KWr974B58BljqNcS4udx+rd388Xd6
	UmT91o=
X-Received: by 2002:a17:90b:5484:b0:38d:a150:ee04 with SMTP id 98e67ed59e1d1-38f99384981mr116539a91.30.1785352643745;
        Wed, 29 Jul 2026 12:17:23 -0700 (PDT)
Received: from bogon ([2408:8207:1832:1b44::c6b])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-38f81543abfsm833349a91.4.2026.07.29.12.17.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Jul 2026 12:17:22 -0700 (PDT)
Sender: Weiming Shi <thebestswings@gmail.com>
From: Weiming Shi <bestswngs@gmail.com>
To: "Michael S. Tsirkin" <mst@redhat.com>,
	Jason Wang <jasowangio@gmail.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	=?UTF-8?q?Eugenio=20P=C3=A9rez?= <eperezma@redhat.com>,
	Stefan Hajnoczi <stefanha@redhat.com>,
	Stefano Garzarella <sgarzare@redhat.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>
Cc: virtualization@lists.linux.dev,
	kvm@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Xiang Mei <xmei5@asu.edu>,
	Bobby Eshleman <bobbyeshleman@meta.com>
Subject: [PATCH v3 0/2] vsock/virtio: fix worker access after virtqueue teardown
Date: Wed, 29 Jul 2026 12:16:53 -0700
Message-ID: <cover.1785352330.git.bestswngs@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260729185831.3247971-1-bestswngs@gmail.com>
References: <20260729185831.3247971-1-bestswngs@gmail.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Virtio-vsock workers can remain queued while freeze deletes the
virtqueues.  This series prevents workers delayed across freeze and
restore from retaining pointers to deleted queues, and prevents the RX
worker from refilling its queue after teardown.

Changes in v3:
- Resend the series with proper email threading; no code changes.

Changes in v2:
- Split the worker pointer changes from the RX refill fix because they
  fix different commits.
- Use bd50c5dc182b as the Fixes tag for the worker pointer changes.
- Keep b917507e5ad9 as the Fixes tag for the RX refill fix.
- Use the suggested out_nofill label when rx_run is clear.

Weiming Shi (2):
  vsock/virtio: read virtqueues under worker locks
  vsock/virtio: avoid refilling the RX queue after teardown

 net/vmw_vsock/virtio_transport.c | 14 ++++++++------
 1 file changed, 8 insertions(+), 6 deletions(-)


base-commit: 51b093a7ba27476e1f639455f005e8d2e75390e4
-- 
2.55.0
