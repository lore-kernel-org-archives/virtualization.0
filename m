Received: from mail-pf1-f193.google.com (mail-pf1-f193.google.com [209.85.210.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9244828DB54
	for <virtualization@lists.linux.dev>; Thu, 11 Jun 2026 02:57:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.193
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781146624; cv=none; b=km3GeryN9mvXOG5wSkYx6ZtUfflxQrQK7dDSg3z9cL95ygsKFElmOzQX340ZwqlAj1CTiG/zgalbt9zpcUr8Y6U7kXYOHTwh/rdIl5kTsjHVXzejSQ29N1FvyleMOHgju6/SoDvXn+yGoihkCoIsRBLNtGGEP7hYn79r43+B5yc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781146624; c=relaxed/simple;
	bh=e/GUBI5y6udIvJIPdFh3I2NoVZarjuSWsF0Ua4MQmBU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=gsIhWlMHmiZFz/3KY45+kEBFt7NTVdIk5ZkLaoBJ1lO+8RdayXx+xadb0arp+49jmqp5fgPx2GVCu8gSeoVZ2woYCWQWy4dZoOM2pGA7EIHLXyeHgd9qM2ZHmfpwVhBHPvxFmLpr66Ip2w1+MkXGq3sHLLw1GaQ+9gHcYDJMB8A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=h580RIVY; arc=none smtp.client-ip=209.85.210.193
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="h580RIVY"
Received: by mail-pf1-f193.google.com with SMTP id d2e1a72fcca58-842307473b5so5184834b3a.2
        for <virtualization@lists.linux.dev>; Wed, 10 Jun 2026 19:57:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781146621; x=1781751421; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=YGTwoCtKa3qFsxEvMshBp4ypPZjRIYp49KFhfGyY/yQ=;
        b=h580RIVYz5lrlZmluTkGiACnE4Hr5j6D/zUeUZgaz1lsPJ37Mi6K2vzT3gS1rWPoAY
         Y1jKSM+pZot8+G6BFUaN+ULTNEq/HnUZVR5yz/L6FaTi1T5TYRRABy45wOPydraF14sR
         Rt//Hs6T/VsGCTEJeB8cmCoYECv/Ddvln75nkkiogbSuXdsjcMyDw1PKlrt5EfbRqe1+
         XqkMek5KrU5SbDccVQCk7LHKOkMqhYNVbYavvaJ2FJrTNn0g3q+6zIzdxcsvllrg/X61
         HdPyZSJBiTlbxajq4oaS/t41jXV3WyaXjlJA9N0MDDEk+WYx0bANpKO8XKj/iSYilrZv
         XGDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781146621; x=1781751421;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YGTwoCtKa3qFsxEvMshBp4ypPZjRIYp49KFhfGyY/yQ=;
        b=N5vlcgiLRJNe/Fqt1GyuCoovgMl2+1Z2OS5wk6O1p+wW6dvqgszkSJa2ENaIb2ZdMM
         gpWVUUmgX5n927jIKsv6O1mCOLbgYYdj3zodj/A0asubg1+ZCJblrjzSPUPc/p8LOKG+
         DgGZaY8aHDycASaMtEc6gPsUBXjNPQmUW8zDWzDNN9W+loxYRTSfnJQrBe/Y7v9ZywMX
         cf7wbxITVxapI29q/guN2aPAY6i2lf7GfcwjXCTV4GKkwQikt9jX3/I6/40IHRCiACQf
         IyMgjustL+C6tA+H5HpLAtspl42krtEA5Rly751XIkgvpZmkl7p4yVBE1Co+SODf0wtc
         Y4yA==
X-Forwarded-Encrypted: i=1; AFNElJ/I0WnWPJ7r0A1rvF6t7sShiyIdcknY5wdj+1PCN+15INoaIZXHih2nl47iw/rBdcYO2Ikm1j6Ms2MYl5YNIw==@lists.linux.dev
X-Gm-Message-State: AOJu0YxJVeNIh+6khUQ8Nio2+ldH58CAXGsmSpVIumUuUcSdSos9+RKc
	o+VYbc4/eAMwZYyZRU0s3Qy8k/r8H1V83umpW1yqH6ma5JO683Vn0GvU
X-Gm-Gg: Acq92OERGUVslmjuH7DFr16jut5td56//1uYxcBfVERGfAiElAsftRZOV4MFYrDH9Hr
	2y0OhJ2e4p65hgvvNIq+69uOdM5VHQUaLZ83F/aBtX02QsrVWLsBOKVsTulMW19U9kDYU+2j2Ne
	X1WTTgESddLnWbfebAKBHQyh/VvctE5SktrzmOAsfHwRPfAo4jSjkI6Kl7TSzojcy6XyuA3B3Xr
	bGjRerUOn0feYTOEPDadEe7QeNX14/ZVjN4/w/i2OHppf3BoOahRtS9eXmc5z8hGlyAhH7cUbfa
	lHG842o+KHTf9XmVoOGjtPK98GQIUp/y0MDXIxzo9KUBPXZ7L6n95k1rbJIKIe94zoMQa8pZLaQ
	MQHsB4X/6RgthaOt1K31c1bny572vXlZHXWBNeZShwfKWg40Nbx61zjYukEoGUJuR7EGSJN32kj
	gAKmvQowOW6cYk5ftftEoIOHluomhO8QoQXXyXOl2CBuqvB01cifo=
X-Received: by 2002:a05:6a00:3996:b0:83b:905:c9fd with SMTP id d2e1a72fcca58-84336a8c539mr870473b3a.24.1781146620897;
        Wed, 10 Jun 2026 19:57:00 -0700 (PDT)
Received: from localhost.localdomain ([103.173.155.241])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-84338316f0fsm233006b3a.50.2026.06.10.19.56.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Jun 2026 19:57:00 -0700 (PDT)
From: menglong8.dong@gmail.com
X-Google-Original-From: dongml2@chinatelecom.cn
To: xuanzhuo@linux.alibaba.com,
	eperezma@redhat.com
Cc: mst@redhat.com,
	jasowang@redhat.com,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	minhquangbui99@gmail.com,
	kerneljasonxing@gmail.com,
	netdev@vger.kernel.org,
	virtualization@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [PATCH net-next v2 0/2] virtio_net: xsk: rx and tx wake up
Date: Thu, 11 Jun 2026 10:56:42 +0800
Message-ID: <20260611025644.2431148-1-dongml2@chinatelecom.cn>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Menglong Dong <dongml2@chinatelecom.cn>

In the first patch, we fix a race condition for the xsk rx wake up in
virtio-net.

In the second patch, we support xsk tx wake up for virtio-net.

Changes since v1:
- split the rx and tx into two patch
- add the Fixes tag


Menglong Dong (2):
  virtio_net: xsk: fix race in rx wake up
  virtio-net: xsk: support tx wake up

 drivers/net/virtio_net.c | 52 ++++++++++++++++++++++++++++++++++------
 1 file changed, 45 insertions(+), 7 deletions(-)

-- 
2.54.0

